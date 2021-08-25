USE [ULTIPRO_WDS]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_ESPMWESTDS]    Script Date: 8/13/2021 3:16:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESPMWESTDS]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Western Dental Services

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 06/11/2021
Service Request Number: SR-2021-00309704

Purpose: SPM Benefits Export

Revision History
----------------
06/22/2021 by AP:
        - Set all employee output to LOA.
        - Fixed output order of employee records to SPM -> SPMPLAN -> SPMPLANMEMBERSPECIFICRATE.
        - Added double quote to field address1, address2 and city.
        - Set Allow Member SSO field to FALSE.
        - Set Benefit Group to BLANK.

06/29/2021 by AP:
        - Fixed sorting issue.
        - Fixed SPMPLAN not showing on file.
        - SPMPLANMEMBERSPECIFICRATE value change for plan name field.

07/12/2021 by AP:
        - Updated client division name field.
        - Updated plan name field.
        - Updated where eedeeamt > 0.

07/14/2021 by AP:
        - Made error updating the client division field and not the client division name field (fixed).

07/29/2021 by AP:
        - Client division name field fix.
        - Plan name field fix.
        - Added 3 new plan name values for SPM Member Specific Rate.

08/12/2021 by AP:
		- Only LOA audit records sent.
		- Set Billing End Date to BLANK.
		- Added logic to make sure a file is sent even if BLANK.

08/13/2021 by AP:
		- Updated SPM record to make sure that the LATEST LOA record is reported.
		- Added logic to SPMPLAN drvCovLevel.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESPMWESTDS';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESPMWESTDS';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESPMWESTDS';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESPMWESTDS';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESPMWESTDS' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESPMWESTDS', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESPMWESTDS', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESPMWESTDS', 'SCH_ESPMWE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESPMWESTDS';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESPMWESTDS', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESPMWESTDS';

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
    DELETE FROM dbo.U_ESPMWESTDS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESPMWESTDS_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DENAL, MEDAB, MEDEB, MEDEH, MEDAG, MEDAS, VLBTC, VLBTE, VLBTS, VCAN, VIDP, VIDV, MEDK2, MEDK4, MEDK1, MEDK3, VACC, VCIEE, VCISP, VHOSP, VLFCH, VLFEE, VLFSP, VLTD2, VSTD, VISN, DEN3, DENAZ, VCICH';

    IF OBJECT_ID('U_ESPMWESTDS_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESPMWESTDS_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESPMWESTDS_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

	--==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESPMWESTDS_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESPMWESTDS_AuditFields;
    CREATE TABLE dbo.U_ESPMWESTDS_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpPers','EepOldSSN');
    INSERT INTO dbo.U_ESPMWESTDS_AuditFields VALUES ('EmpPers','EepSSN');

	--DROP INDEX IF EXISTS [NCX_U_ESPMWESTDS_EELIST] ON dbo.[U_ESPMWESTDS_EEList]

	--CREATE NONCLUSTERED INDEX [NCX_U_ESPMWESTDS_EELIST]
	--ON [dbo].[U_ESPMWESTDS_EEList] ([xEEID])
	--INCLUDE ([xCOID])

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESPMWESTDS_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESPMWESTDS_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
		,audLOA = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') <> 'L' AND ISNULL(audNewValue,'') = 'L' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ESPMWESTDS_Audit
    FROM dbo.U_ESPMWESTDS_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_ESPMWESTDS_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

	-- DELETE ANY EMPLOYEES WHO ARE SHOWING AS ACTIVE STATUS
	DELETE dbo.U_ESPMWESTDS_Audit
	WHERE audEEID IN (SELECT audEEID
					FROM dbo.U_ESPMWESTDS_Audit
					WHERE audRowNo = 1
					AND audNewValue = 'A')

	--CREATE CLUSTERED INDEX CDX_U_ESPMWESTDS_Audit ON dbo.U_ESPMWESTDS_Audit (audEEID, audKey2);

	--CREATE CLUSTERED INDEX CDX_U_ESPMWESTDS_EELIST ON dbo.U_ESPMWESTDS_EEList (xEEID, xCOID);


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    --IF OBJECT_ID('U_ESPMWESTDS_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_ESPMWESTDS_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_ESPMWESTDS_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_ESPMWESTDS_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    --IF OBJECT_ID('U_ESPMWESTDS_PEarHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_ESPMWESTDS_PEarHist;
    --SELECT DISTINCT
    --     PehEEID
    --    ,PrgPayDate             = MAX(PrgPayDate)
    --    -- Current Payroll Amount/Hours
    --    ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
    --    ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
    --    -- YTD Payroll Amount/Hours
    --    ,PehCurAmtYTD           = SUM(PehCurAmt)
    --    ,PehCurHrsYTD           = SUM(PehCurHrs)
    --    -- Current Include Deferred Comp Amount/Hours
    --    ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
    --    ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
    --    -- YTD Include Deferred Comp Amount/Hours
    --    ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
    --    ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    --INTO dbo.U_ESPMWESTDS_PEarHist
    --FROM dbo.vw_int_PayReg WITH (NOLOCK)
    --JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
    --    ON PehGenNumber = PrgGenNumber
    --WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    --GROUP BY PehEEID
    --HAVING SUM(PehCurAmt) <> 0.00;

   
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESPMWESTDS_spmTbl
    ---------------------------------
    IF OBJECT_ID('U_ESPMWESTDS_spmTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESPMWESTDS_spmTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvClientName = 'Western Dental Services Inc 21645'
        --REPLACE(CmpCompanyName, ',', '')
        --'Western Dental Services Inc 21645'
        ,drvClientDivName = dbo.dsi_fnRemoveChars(',.', CmpCompanyName)
        --REPLACE(CmpCompanyName, ',', '')
        /*CASE WHEN EecCOID IN ('MV70M', 'N0A78') THEN 'DB Brident Dental Services-TX' 
                                    WHEN EecCOID = 'N0A01' THEN 'DB Kelley Dunay DMD P.C.-NV'
                                    WHEN EecCOID = 'N0A9B' THEN 'DB Soumava Sen DDS P.C.-TX'
                                    WHEN EecCOID = 'MV7G2' THEN 'DB Vital Smiles-AL'
                                    WHEN EecCOID = 'N0A50' THEN 'DB Western Dental of AZ'
                                    WHEN EecCOID = 'N0BXX' THEN 'DB Western Dental of NV' 
                                    WHEN EecCOID = 'N09HN' THEN 'DB Western Dental Services-CA' END*/
        ,drvSalutation = ''
        ,drvFName = RTRIM(EepNameFirst)
        ,drvMiddle = LEFT(EepNameMiddle, 1)
        ,drvLName = RTRIM(EepNameLast)
        ,drvSSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                    SUBSTRING(EepSSN, 4, 2)+'-'+
                    SUBSTRING(EepSSN, 6, 4) 
        ,drvIndID = ''
        ,drvEmail = ''
        ,drvPhone = ''
        ,drvPhone2 = ''
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvPostCode = EepAddressZipCode
        ,drvCountry = ''
        ,drvSex = CASE WHEN EepGender = 'M' THEN 'M' WHEN EepGender = 'F' THEN 'F' ELSE 'U' END
        ,drvDOB = EepDateOfBirth
        ,drvBillStartDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END), 101), '')
        ,drvBillEndDate = ''
		--ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'A' AND Esh.EshEmplStatus = 'L' THEN Esh.EshStatusStopDate END), 101), '')
        ,drvBillType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE' END
        ,drvBillFreq = 'MONTHLY' 
        ,drvIsCOBRAElig = 'FALSE'
        ,drvIsCOBRAEligTerm = 'FALSE'
        ,drvSubsequentGraceNumDays = ''
        ,drvSubsequentGracePeriodOpt = 'CLIENTDEFAULT'
        ,drvIsLegacy = 'FALSE'
        ,drvTobaccoUse = 'UNKNOWN'
        ,drvEnrollmentDate = (SELECT MIN(EdhBenStartDate) FROM dbo.EmpHDed WITH(NOLOCK) WHERE EdhEEID = xEEID AND EdhCOID = xCOID)
        ,drvEmployeeType = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'FTE' ELSE 'PTE' END
        ,drvEmployeePayrollType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'SALARY' ELSE 'HOURLY' END
        ,drvYearsOfService = ''
        ,drvPremiumCoupon = 'COUPONBOOK'
        ,drvActive = 'TRUE'
        ,drvAllowMemberSSO = 'FALSE'
        ,drvBenGroup = ''
        ,drvAccountStructure = ''
        ,drvClientCustomData = ''
        ,drvSSO = ''
        ,drvEventDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END), 101), '')
        ,drvInitialGracePeriodDate = ''
        ,drvBillingSeedDate = ''
        ,drvSecBillingSeedDate = ''
        ,drvPlanCat = ''
        ,drvInitialSort = '2' + EepSSN
        ,drvSubSort = '1'
    INTO dbo.U_ESPMWESTDS_spmTbl
    FROM dbo.U_ESPMWESTDS_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK) ON xEEID = eepEEID
    JOIN dbo.EmpComp WITH(NOLOCK) ON xEEID = eecEEID AND xCOID = eecCOID
    JOIN dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK) ON xEEID = EedEEID AND xCOID = EedCOID
	JOIN dbo.U_ESPMWESTDS_Audit WITH(NOLOCK) ON audEEID = xEEID AND audKey2 = xCOID
    JOIN dbo.Company WITH(NOLOCK) ON CmpCOID = xCOID
    --LEFT JOIN (SELECT EshEEID, EshCOID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate
    --            FROM dbo.EmpHStat WITH(NOLOCK)
    --            WHERE EshEmplStatus = 'L'
    --            GROUP BY EshEEID, EshCOID, EshEmplStatus
    --            ) Esh ON Esh.EshEEID = xEEID AND Esh.EshCOID = xCOID
    WHERE EedFormatCode = @FormatCode
    AND EedValidForExport = 'Y'
   -- AND EecEmplStatus = 'L'
	AND audLOA = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESPMWESTDS_spmplanTbl
    ---------------------------------
    IF OBJECT_ID('U_ESPMWESTDS_spmplanTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESPMWESTDS_spmplanTbl;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE EedDedCode 
                            WHEN 'DENAL' THEN 'DB Aetna Dental (Alabama Only)'
                            WHEN 'MEDAB' THEN 'DB Anthem BCBS Medical Bronze PPO'
                            WHEN 'MEDEB' THEN 'DB Anthem BCBS Medical EPO'
                            WHEN 'MEDEH' THEN 'DB Anthem BCBS Medical EPO HSA'
                            WHEN 'MEDAG' THEN 'DB Anthem BCBS Medical Gold PPO'
                            WHEN 'MEDAS' THEN 'DB Anthem BCBS Medical Silver PPO'
                            WHEN 'VLBTC' THEN 'DB Chubb LTD Child'
                            WHEN 'VLBTE' THEN 'DB Chubb LTD Employee'
                            WHEN 'VLBTS' THEN 'DB Chubb LTD Spouse'
                            WHEN 'VCAN' THEN 'DB Guardian Cancer'
                            WHEN 'VIDP' THEN 'DB Identity Guard Premier'
                            WHEN 'VIDV' THEN 'DB Identity Guard Value'
                            WHEN 'MEDK2' THEN 'DB Kaiser Northern CA DHMO'
                            WHEN 'MEDK4' THEN 'DB Kaiser Northern CA HDHP HMO w/HSA'
                            WHEN 'MEDK1' THEN 'DB Kaiser Southern CA DHMO'
                            WHEN 'MEDK3' THEN 'DB Kaiser Southern CA HDHP HMO w/HSA'
                            WHEN 'VACC' THEN 'DB MetLife Accident'
                            WHEN 'VCIEE' THEN 'DB MetLife Critical Illness - EE'
                            WHEN 'VCISP' THEN 'DB MetLife Critical Illness - Spouse'
                            WHEN 'VHOSP' THEN 'DB MetLife Hospital Indemnity'
                            WHEN 'VLFCH' THEN 'DB MetLife Voluntary Child Life'
                            WHEN 'VLFEE' THEN 'DB MetLife Voluntary Life and AD&D - Employee'
                            WHEN 'VLFSP' THEN 'DB MetLife Voluntary Life and AD&D - Spouse'
                            WHEN 'VLTD2' THEN 'DB MetLife Voluntary LTD'
                            WHEN 'VSTD' THEN 'DB MetLife Voluntary STD - Out of CA'
                            WHEN 'VISN' THEN 'DB VSP Vision'
                            WHEN 'DEN3' THEN 'DB Western Dental DHMO CA Only'
                            WHEN 'DENAZ' THEN 'DB Western Dental Premier Choice AZ Only'
                            WHEN 'VCICH' THEN 'DB MetLife Critical Illness - Children' END

        ,drvStartDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END), 101), '')
        ,drvEndDate = ''
        ,drvCovLevel = CASE WHEN EedDedCode = 'VLFCH' THEN 'CHILDRENONLY' -- FIGURE OUT 1 child dependent 
                                WHEN EedDedCode IN ('VCISP', 'VLFSP') THEN 'SPOUSEONLY'
                                WHEN EedDedCode = 'DENAL' AND EedBenOption = 'EE' THEN 'EE'
                                WHEN EedDedCode = 'DENAL' AND EedBenOption = 'EESP' THEN 'EE+1'
                                WHEN EedDedCode = 'DENAL' AND EedBenOption = 'EECH' THEN 'EE+CHILDREN'
                                WHEN EedDedCode = 'DENAL' AND EedBenOption = 'FAM' THEN 'EE+FAMILY' 
                                WHEN EedBenOption IN ('EE', 'EE50', 'EE65', 'EE49') THEN 'EE' 
                                WHEN EedBenOption = 'EE1' THEN 'EE+1'
                                WHEN EedBenOption = 'EECH' THEN 'EE+CHILDREN'
                                WHEN EedBenOption IN ('FAM', 'EES49', 'EES50') THEN 'EE+FAMILY'
                                WHEN EedBenOption = 'EESP' THEN 'EE+SPOUSE'
								WHEN EedDedCode = 'VLFEE' THEN 'EE' END
        ,drvFirstDayOfCov = ''
        ,drvLastDayOfCov = ''
        ,drvLastDatesRateNotif = ''
        ,drvSendPlanChangeLetter = 'FALSE'
        ,drvNumberOfUnits = ''
        ,drvBundle = ''
        ,drvInitialSort = '2' + EepSSN
        ,drvSubSort = '2'
    INTO dbo.U_ESPMWESTDS_spmplanTbl
    FROM dbo.U_ESPMWESTDS_spmTbl WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = drvEEID
    JOIN dbo.EmpComp WITH(NOLOCK) 
    ON EecEEID = drvEEID AND EecCOID = drvCOID
    JOIN dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
    ON drvEEID = EedEEID AND drvCOID = EedCOID
	JOIN dbo.U_ESPMWESTDS_Audit WITH(NOLOCK) ON audEEID = drvEEID AND audKey2 = drvCOID
    WHERE EedFormatCode = @FormatCode
    AND EedValidForExport = 'Y'
   -- AND EecEmplStatus = 'L'
    AND audLOA = 'Y'

    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESPMWESTDS_spmplanmemspcrateTbl
    ---------------------------------
    IF OBJECT_ID('U_ESPMWESTDS_spmplanmemspcrateTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESPMWESTDS_spmplanmemspcrateTbl;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE EedDedCode 
                            WHEN 'VCAN' THEN 'DB Guardian Cancer'
                            WHEN 'VCIEE' THEN 'DB MetLife Critical Illness - EE'
                            WHEN 'VCISP' THEN 'DB MetLife Critical Illness - Spouse'
                            WHEN 'VLFCH' THEN 'DB MetLife Voluntary Child Life'
                            WHEN 'VLFEE' THEN 'DB MetLife Voluntary Life and AD&D - Employee'
                            WHEN 'VLFSP' THEN 'DB MetLife Voluntary Life and AD&D - Spouse'
                            WHEN 'VLTD2' THEN 'DB MetLife Voluntary LTD'
                            WHEN 'VSTD' THEN 'DB MetLife Voluntary STD - Out of CA'
                            WHEN 'VCICH' THEN 'DB MetLife Critical Illness - Children' 
                            WHEN 'VLBTC' THEN 'DB Chubb LTD Child'
                            WHEN 'VLBTE' THEN 'DB Chubb LTD Employee'
                            WHEN 'VLBTS' THEN 'DB Chubb LTD Spouse' END
        ,drvStartDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END), 101), '')
        ,drvEndDate = ''
        ,drvRate = EedEEAmt * 2
        ,drvInitialSort = '2' + EepSSN
        ,drvSubSort = '3'
    INTO dbo.U_ESPMWESTDS_spmplanmemspcrateTbl
    FROM dbo.U_ESPMWESTDS_spmTbl WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = drvEEID
    JOIN dbo.EmpComp WITH(NOLOCK) 
    ON EecEEID = drvEEID AND EecCOID = drvCOID
    JOIN dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
    ON drvEEID = EedEEID AND drvCOID = EedCOID
	JOIN dbo.U_ESPMWESTDS_Audit WITH(NOLOCK) ON audEEID = drvEEID AND audKey2 = drvCOID
    WHERE EedDedCode IN ('VCAN', 'VCIEE', 'VCISP', 'VLFCH', 'VLFEE', 'VLFSP', 'VLTD2', 'VSTD', 'VCICH', 'VLBTC', 'VLBTE', 'VLBTS')
    AND EedFormatCode = @FormatCode
    and EedValidForExport = 'Y'
   -- AND EecEmplStatus = 'L'
    AND audLOA = 'Y'
    AND EedEEAmt > 0.00
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
ALTER VIEW dbo.dsi_vwESPMWESTDS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESPMWESTDS_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESPMWESTDS%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106041'
       ,expStartPerControl     = '202106041'
       ,expLastEndPerControl   = '202106119'
       ,expEndPerControl       = '202106119'
WHERE expFormatCode = 'ESPMWESTDS';

**********************************************************************************/
