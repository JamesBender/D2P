USE [ULTIPRO_WPNWOS]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EDISHSAEXP]    Script Date: 6/23/2021 5:29:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISHSAEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Borrego Solar

Created By: Inshan Singh
Business Analyst: Cheryl Petitti
Create Date: 05/06/2021
Service Request Number: TekP-2021-02-11-0001 

Purpose: Discovery HSA Export

Revision History
----------------
05/27/2021 by AP:
		- Removed use of BDM_@Formatname table and use BDM_EmpDeductions
		- Removed use of PayDedHist table in EN record that was dropping values
		- Election amount indicator updated
		- HDHP updated
		- CT record for contribution amount now for HSAF as well
		- CT record only for PdhEECurAmt > 0

06/23/2021 by AP:
		- PT records missing fixed (removed PayDedHist table from join which is unnecessary).

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISHSAEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISHSAEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISHSAEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISHSAEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISHSAEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISHSAEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISHSAEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISHSAEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISHSAEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISHSAEXP', 'SCH_EDISHS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISHSAEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISHSAEXP', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EDISHSAEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EDISHSAEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISHSAEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EDISHSAEXP_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEeType IN ('TES','Z')
    );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSAFC,HSCMD,HFCMD,HSAF,HSFMD,HSAIC,HSCIM,HSAI,HSIMD,HSACC';

    IF OBJECT_ID('U_EDISHSAEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDISHSAEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDISHSAEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EDISHSAEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDISHSAEXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
         ,PdhDedCode
         ,PdhPayDate = MAX(PdhPayDate)
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EDISHSAEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EDISHSAEXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDISHSAEXP_drvTbl_PT
    ---------------------------------
    IF OBJECT_ID('U_EDISHSAEXP_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISHSAEXP_drvTbl_PT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportID = eepSSN
        ,drvEmployeeNumber = EecEmpNo
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus IN ('S','M') THEN EepMaritalStatus END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSSN = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvHireDate = EecDateOfOriginalHire
        ,drvParticipantStatus = CASE WHEN EecEmplStatus = 'T' THEN 'Terminated' ELSE 'Active' END
        ,drvStatusEffectiveDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination ELSE EecDateOfLastHire END
        ,drvFinalPayrollProcessDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination) END
        ,drvFinalContribProcessDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination) END
        ,drvMobileNumber = EfoPhoneNumber
    INTO dbo.U_EDISHSAEXP_drvTbl_PT
    FROM dbo.U_EDISHSAEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
	JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
		ON EedEEID = xEEID
		AND EedCOID = xCOID
		AND EedValidForExport = 'Y'
		AND EedFormatCode = @FormatCode
    --JOIN dbo.U_dsi_BDM_EDISHSAEXP WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
        --AND BdmDedCode IN ('HSAFC','HSCMD','HFCMD','HSAF','HSFMD','HSAIC','HSCIM','HSAI','HSIMD','HSACC') 
    LEFT JOIN dbo.EmpMPhon 
        ON EfoEEID = xEEID
        AND EfoPhoneType = 'CEL'
    --JOIN dbo.U_EDISHSAEXP_PDedHist WITH (NOLOCK)
    --    ON PdhEEID = xEEID
    --    AND PdhDedCode = EedDedCode
    WHERE EedDedCode IN ('HSAFC','HSCMD','HFCMD','HSAF','HSFMD','HSAIC','HSCIM','HSAI','HSIMD','HSACC')
           -- OR (BdmDedCode = 'HSAER' AND PdhEECurAmt > 0)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISHSAEXP_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_EDISHSAEXP_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EDISHSAEXP_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 2'
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportID = EepSSN
        ,drvPlanName =    CASE 
                            WHEN EedDedCode IN ('HSAFC','HSCMD','HFCMD','HSAF','HSFMD','HSAIC','HSCIM','HSAI','HSIMD') THEN 'Health Savings Account'
                        END
        ,drvEnrollmentEffectiveDate =    CASE WHEN EedDedCode IN ('HSAFC','HSCMD','HFCMD','HSAF','HSFMD','HSAIC','HSCIM','HSAI','HSIMD','HSACC') THEN
                                            CASE WHEN DATEPART(YEAR, EedBenStartDate) <= 2021 THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, '1/1/2021')
                                                ELSE dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, '1/1/' + FORMAT(DATEPART(YEAR, EedBenStartDate), '0000'))                                                
                                            END
                                        END
        ,drvParticipantElectionAmount = ''          
        ,drvEnrollmentTerminationDate = ''
        ,drvElectionAmountIndicator =    CASE 
                                            WHEN EedDedCode IN ('HSAFC', 'HSCMD', 'HFCMD', 'HSAF', 'HSFMD', 'HSAIC', 'HSCIM', 'HSAI', 'HSIMD') THEN 'PerPay'
                                        END
        ,drvHDHPCoverageLevel =    CASE WHEN EedDedCode IN ('HSAFC', 'HSCMD', 'HFCMD', 'HSAF', 'HSFMD') THEN 'Family'
                                    WHEN EedDedCode IN ('HSAIC', 'HSCIM', 'HSAI', 'HSIMD') THEN 'Single'
                                END
        ,drvPlanYearStartDate =    '' -- blank
    INTO dbo.U_EDISHSAEXP_drvTbl_EN
    FROM dbo.U_EDISHSAEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
	JOIN dbo.U_dsi_BDM_EmpDeductions WITH(NOLOCK)
		ON EedEEID = xEEID
		AND EedCOID = xCOID
		AND EedValidForExport = 'Y'
		AND EedFormatCode = @FormatCode
    --JOIN dbo.U_dsi_BDM_EDISHSAEXP WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
        --AND BdmDedCode NOT IN ('HSAER')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_EDISHSAEXP_PDedHist WITH (NOLOCK)
    --    ON PdhEEID = xEEID
    --    AND PdhDedCode = EedDedCode
    WHERE EedDedCode IN ('HSAFC','HSCMD','HFCMD','HSAF','HSFMD','HSAIC','HSCIM','HSAI','HSIMD')
            --OR (BdmDedCode = 'HSAER' AND PdhEECurAmt > 0)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISHSAEXP_drvTbl_CT
    ---------------------------------
    IF OBJECT_ID('U_EDISHSAEXP_drvTbl_CT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISHSAEXP_drvTbl_CT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 3'
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportID = EepSSN
        ,drvPlanName = CASE 
                            WHEN EedDedCode IN ('HSAFC','HSCMD','HFCMD','HSAF','HSFMD','HSAIC','HSCIM','HSAI','HSIMD','HSACC') THEN 'Health Savings Account'
                        END
        ,drvContributionDate = PdhPayDate
        ,drvContributionDescription =    CASE WHEN EedDedCode IN ('HSAFC', 'HSCMD', 'HFCMD', 'HSAF', 'HSFMD', 'HSAIC', 'HSCIM', 'HSAI', 'HSIMD') THEN 'Payroll Deduction'
                                            WHEN EedDedCode IN ('HSACC') THEN 'Employer Contribution'
                                        END
        ,drvContributionAmount =    FORMAT(CASE WHEN EedDedCode IN ('HSAFC', 'HSCMD', 'HFCMD', 'HSAF', 'HSFMD', 'HSAIC', 'HSCIM', 'HSAI', 'HSIMD', 'HSACC') THEN PdhEECurAmt
--                                        WHEN BdmDedCode IN ('HSAER') THEN PdhERCurAmt
                                    END, '#0.00')
    INTO dbo.U_EDISHSAEXP_drvTbl_CT
    FROM dbo.U_EDISHSAEXP_EEList WITH (NOLOCK)
	JOIN dbo.U_dsi_BDM_EmpDeductions WITH(NOLOCK)
		ON EedEEID = xEEID
		AND EedCOID = xCOID
		AND EedValidForExport = 'Y'
		AND EedFormatCode = @FormatCode
    --JOIN dbo.U_dsi_BDM_EDISHSAEXP WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    JOIN dbo.U_EDISHSAEXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
        AND PdhDedCode = EedDedCode
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
	WHERE PdhEECurAmt > 0

    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------

    DECLARE @CurrentDate VARCHAR(8)
        ,@CurrentTime VARCHAR(6);

    SELECT @CurrentDate = FORMAT(GETDATE(), 'MMddyyyy');
    SELECT @CurrentTime = FORMAT(GETDATE(), 'HHmmss');

    IF OBJECT_ID('U_EDISHSAEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDISHSAEXP_Header;
    SELECT DISTINCT
         drvSubmittedDate = @CurrentDate
        ,drvSubmittedTime = @CurrentTime
    INTO dbo.U_EDISHSAEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISHSAEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDISHSAEXP_Trailer;
    SELECT DISTINCT
         drvRecordCount = (SELECT COUNT(*) FROM dbo.U_EDISHSAEXP_drvTbl_PT WITH (NOLOCK)) + (SELECT COUNT(*) FROM dbo.U_EDISHSAEXP_drvTbl_EN WITH (NOLOCK)) + (SELECT COUNT(*) FROM dbo.U_EDISHSAEXP_drvTbl_CT WITH (NOLOCK))
        ,drvSubmittedDate = @CurrentDate
        ,drvSubmittedTime = @CurrentTime
    INTO dbo.U_EDISHSAEXP_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEDISHSAEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISHSAEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISHSAEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101081'
       ,expStartPerControl     = '202101081'
       ,expLastEndPerControl   = '202101089'
       ,expEndPerControl       = '202101089'
WHERE expFormatCode = 'EDISHSAEXP';

**********************************************************************************/
