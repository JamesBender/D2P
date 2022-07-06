USE [ULTIPRO_BETHB]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EJCMHUNUM]    Script Date: 7/6/2022 11:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EJCMHUNUM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Jefferson Center for Mental Health

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 06/29/2022
Service Request Number: TekP-2022-05-05-02

Purpose: UNUM FMLA STD LTD

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EJCMHUNUM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EJCMHUNUM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EJCMHUNUM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EJCMHUNUM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EJCMHUNUM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJCMHUNUM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJCMHUNUM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJCMHUNUM', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJCMHUNUM', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJCMHUNUM', 'SCH_EJCMHU';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EJCMHUNUM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EJCMHUNUM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EJCMHUNUM';

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
    DELETE FROM dbo.U_EJCMHUNUM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EJCMHUNUM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ZSTD,ZLTD';

    IF OBJECT_ID('U_EJCMHUNUM_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EJCMHUNUM_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EJCMHUNUM_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

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
    IF OBJECT_ID('U_EJCMHUNUM_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EJCMHUNUM_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('ZLTD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ZSTD') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        --,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EJCMHUNUM_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EJCMHUNUM_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EJCMHUNUM_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EJCMHUNUM_PEarHist;
    SELECT DISTINCT
         PehEEID
		,PehEarnCode
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EJCMHUNUM_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl 
    GROUP BY PehEEID, PehEarnCode
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EJCMHUNUM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EJCMHUNUM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EJCMHUNUM_drvTbl;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitalSort = ''
        -- standard fields above and additional driver fields below
        ,drvPartnerCaseID = 'JEF-030723'
        ,drvServiceIndicator = 'ELG'
        ,drvEESSN = eepSSN
        ,drvEmpno = EecEmpNo
        ,drvEEIDType = xEEID
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvAddress1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddress2 = REPLACE(EepAddressLine2, ',', '')
        ,drvCity = EepAddressCity
        ,drvRdcStPvc = LEFT(eepaddressstate,2)
        ,drvPostalCd = eepaddresszipcode 
        ,drvCntryCd = LEFT(eepAddressCountry,2) -- Should be US employees on the file.
        ,drvWrkStPvc = LocAddressState --LocAddressState where LocCode = EecLocation
        ,drvEeDob = EepDateOfBirth
        ,drvEeGender = CASE WHEN EepGender not in ('M','F') THEN '' ELSE EepGender END 
        ,drvMaritalStatus = Case WHEN eepmaritalstatus = 'M' THEN 'Married'
								 WHEN eepmaritalstatus = 'S' THEN 'Single' 
								 ELSE 'UNK' 
								END
        ,drvJobTitle = REPLACE(JbcDesc, ',', '')  --JbcDesc where JbcCode = EecJobCode
        ,drvRcntHireDate = EecDateOfLastHire
        ,drvOriginaHireDate = EecDateOfLastHire
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvStatus = CASE WHEN EecEmplStatus = 'L' THEN 'LOA' else  'ACT' END
        ,drvWklySchWrkHrs = FORMAT((EecScheduledWorkHrs)/52, '#0') ---FORMAT((EecScheduledWorkHrs*12)/52, '#0') --CAST(CONVERT(DECIMAL(10,2), EecScheduledWorkHrs / 2) AS VARCHAR(12))
        ,drvDateOfLstSlyChg = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, '01/01/2010',EecDateOfLastHire)  ---max of most recent dsi_fnlib_GetAnnSalary_EffDate_WithStartDate or eecdateoflasthire
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvMgrFirstName = ''
        ,drvMgrLastName = ''
        ,drvMgrEmail = ''
        ,drvHrWrkedInPst12_Mnths = '1250'
        ,drvOffceName = ''
        ,drvWrkMailStAddr1 = ''
        ,drvWrkMailStAddr2 = ''
        ,drvWrkMailStAddr3 = ''
        ,drvWrkCity = ''
        ,drvWrkPostalCd = ''
        ,drvFMLARptingGrp = CASE WHEN D.STD IS NOT NULL THEN '100' END
        ,drvSalMd = EecSalaryOrHourly
        ,drvProduct1 = CASE WHEN D.STD IS NOT NULL THEN '31' END
        ,drvPolicyNbr1 = CASE WHEN D.STD IS NOT NULL THEN '715009' END
        ,drvDivisionDivision1 = CASE WHEN D.STD IS NOT NULL THEN '100' END
        ,drvPolicyElgGrp1 = CASE WHEN D.STD IS NOT NULL THEN '1' END
        ,drvPostTaxCntrbPct1 = CASE WHEN D.STD IS NOT NULL THEN '0' END
        ,drvEarnings1 = CASE WHEN YEAR(EecDateOfLastHire) < YEAR(GETDATE()) THEN  
                                CASE WHEN D.STD IS NOT NULL THEN CAST(CONVERT(DECIMAL(10,2), Peh.PehCurAmt / 52) AS VARCHAR) END 
                            WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN
                                CASE WHEN D.STD IS NOT NULL THEN CAST(CONVERT(DECIMAL(10,2), ((EecAnnSalary + EecUDField09 + EecUDField10) / 52)) AS VARCHAR) END
                            END
							--eecdateoflasthire date is prior to current year then if eeddedcode= ZSTD send sum(pehcuramt) where pehearncode in (BONUS,BONSP, BONSR, COMM, HOL, BONSL, OT, PTO, REG, REGE, RETRO, SICK, COV19) for all per controls in prior calendar year divided by 52
							--if eecdateoflasthire date is in the current year then if eeddedcode = ZSTD send eecannsalary plus EECUDFIELD09 plus EECUDFIELD10  divided by 52
		,drvEarningsPrd1 = CASE WHEN D.STD IS NOT NULL THEN 'WK' END
        ,drvDateOfEeCovg1 = CASE WHEN D.STD IS NOT NULL THEN D.STD_BenStartDate END ----eeddedcode = ZSTD send eedbenstartdate - default to 8/1/2022 or later
        ,drvCovgTermDate1 = CASE WHEN D.STD IS NOT NULL THEN D.STD_BenStopDate END
        ,drvProduct2 = CASE WHEN D.LTD IS NOT NULL THEN '38' END
        ,drvPolicyNbr2 = CASE WHEN D.LTD IS NOT NULL THEN '715009' END
        ,drvDivisionDivision2 = CASE WHEN LTD IS NOT NULL THEN '100' END
        ,drvElgGrp2 = CASE WHEN D.LTD IS NOT NULL THEN '1' END
        ,drvPosttaxCntrbPct2 = CASE WHEN D.LTD IS NOT NULL THEN '0' END
        ,drvEarnings2 =   CASE WHEN YEAR(EecDateOfLastHire) < YEAR(GETDATE()) THEN
                                CASE WHEN D.LTD IS NOT NULL  THEN  CAST(CONVERT(DECIMAL(10,2), ((EecAnnSalary + EecUDField09 + EecUDField10) / 12)) AS VARCHAR) END
                            WHEN YEAR(EecDateOFLastHire) = YEAR(GETDATE()) THEN 
                                CASE WHEN D.LTD IS NOT NULL  THEN CAST(CONVERT(DECIMAL(10,2), ((EecAnnSalary + EecUDField09 + EecUDField10) / 12)) AS VARCHAR) END
                            END
		-- if eecdateoflasthire date is prior to current year then
		-- if eeddedcode = ZLTD send sum(pehcuramt) where pehearncode in (BONUS,BONSP, BONSR, COMM, HOL, BONSL, OT, PTO, REG, REGE, RETRO, SICK, COV19) for all per controls in prior calendar year divided by 12
		-- if eecdateoflasthire date is in the current year then if eeddedcode = ZLTD send eecannsalary plus EECUDFIELD09 plus EECUDFIELD10  divided by 12
        ,drvEarningsPrd2 = CASE WHEN D.LTD IS NOT NULL THEN  'MO' END
        ,drvDateOfEeCovg2 = CASE WHEN D.LTD IS NOT NULL THEN  D.LTD_BenStartDate END --eeddedcode = ZLTD send eedbenstartdate - default to 8/1/2022 or later
        ,drvTermDate2 = CASE WHEN D.LTD IS NOT NULL THEN  D.LTD_BenStopDate END
    INTO dbo.U_EJCMHUNUM_drvTbl
    FROM dbo.U_EJCMHUNUM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_EJCMHUNUM WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	LEFT JOIN dbo.Location as Loc
        on Loc.LocCode =  EecLocation
	JOIN (SELECT EedEEID, EedCOID, MAX(CASE WHEN EedDedCode = 'ZLTD' THEN 'LTD' END) AS LTD,
                    MAX(CASE WHEN EedDedCode = 'ZSTD' THEN 'STD' END) AS STD,
                    MAX(CASE WHEN EedDedCode = 'ZLTD' THEN EedBenStartDate END) AS LTD_BenStartDate,
                    MAX(CASE WHEN EedDedCode = 'ZLTD' THEN EedBenStopDate END) AS LTD_BenStopDate,
                    MAX(CASE WHEN EedDedCode = 'ZSTD' THEN EedBenStartDate END) AS STD_BenStartDate,
                    MAX(CASE WHEN EedDedCode = 'ZSTD' THEN EedBenStopDate END) AS STD_BenStopDate
            FROM dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
            WHERE EedFormatCode = @FormatCode
            AND EedValidForExport = 'Y'
            GROUP BY EedEEID, EedCOID
            ) D ON D.EedEEID = xEEID AND D.EedCOID = xCOID
	LEFT JOIN (SELECT PehEEID, PehEarnCode, PehCurAmt
                FROM dbo.U_EJCMHUNUM_PEarHist WITH(NOLOCK)
                WHERE pehearncode in ('BONUS','BONSP', 'BONSR', 'COMM', 'HOL', 'BONSL', 'OT', 'PTO', 'REG', 
									   'REGE', 'RETRO', 'SICK', 'COV19')) Peh ON Peh.PehEEID = xEEID

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
ALTER VIEW dbo.dsi_vwEJCMHUNUM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EJCMHUNUM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EJCMHUNUM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202206221'
       ,expStartPerControl     = '202206221'
       ,expLastEndPerControl   = '202206299'
       ,expEndPerControl       = '202206299'
WHERE expFormatCode = 'EJCMHUNUM';

**********************************************************************************/