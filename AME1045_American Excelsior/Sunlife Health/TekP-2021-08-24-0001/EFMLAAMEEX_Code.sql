USE [ULTIPRO_WPAEXC]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_EFMLAAMEEX]    Script Date: 11/1/2021 3:25:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFMLAAMEEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: American Excelsior

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 10/18/2021
Service Request Number: TekP-2021-08-24-0001

Purpose: Sunlife FMLA Export

Revision History
----------------
11/01/2021 by AP:
		- Changed employee work state logic.
		- Removed commas from employee job title.
		- Added older than 30 days to drop term logic.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFMLAAMEEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFMLAAMEEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFMLAAMEEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFMLAAMEEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFMLAAMEEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFMLAAMEEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFMLAAMEEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFMLAAMEEX', 'SCH_EFMLAA';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFMLAAMEEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFMLAAMEEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@Last24MonthsPerControl varchar(9)
            ,@Last12MonthsPerControl varchar(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EFMLAAMEEX';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

	SELECT @Last24MonthsPerControl =  CONVERT(VARCHAR(12),DATEADD(month,-24, @StartDate),112) + '1'

    SELECT @Last12MonthsPerControl =  CONVERT(VARCHAR(12),DATEADD(month,-12, @StartDate),112) + '1'

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFMLAAMEEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFMLAAMEEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    ----==========================================
    ---- Create Deduction List
    ----==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_EFMLAAMEEX_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_EFMLAAMEEX_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_EFMLAAMEEX_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;


    ----==========================================
    ---- BDM Section
    ----==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    ---- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    ---- Non-Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    ---- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    --IF OBJECT_ID('U_EFMLAAMEEX_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EFMLAAMEEX_PDedHist;
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
    --INTO dbo.U_EFMLAAMEEX_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_EFMLAAMEEX_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);


    -------------------------------
    ---- Working Table - PEarHist YTD
    -------------------------------
    IF OBJECT_ID('U_EFMLAAMEEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFMLAAMEEX_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PgrPayFrequency        = MAX(PgrPayFrequency)
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
    INTO dbo.U_EFMLAAMEEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.PayGroup WITH(NOLOCK)
        ON PrgPayGroup = PgrPayGroup
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;

    -------------------------------
    ---- Working Table - PEarHist 24M
    -------------------------------
    IF OBJECT_ID('U_EFMLAAMEEX_PEarHist_24M','U') IS NOT NULL
        DROP TABLE dbo.U_EFMLAAMEEX_PEarHist_24M;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PgrPayFrequency        = MAX(PgrPayFrequency)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @Last24MonthsPerControl THEN PehCurAmt ELSE 0.00 END)
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
    INTO dbo.U_EFMLAAMEEX_PEarHist_24M
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.PayGroup WITH(NOLOCK)
        ON PrgPayGroup = PgrPayGroup
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;


    -------------------------------
    ---- Working Table - PEarHist 12M
    -------------------------------
    IF OBJECT_ID('U_EFMLAAMEEX_PEarHist_12M','U') IS NOT NULL
        DROP TABLE dbo.U_EFMLAAMEEX_PEarHist_12M;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
		,PehPerControl			= MAX(PehPerControl)
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PgrPayFrequency        = MAX(PgrPayFrequency)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @Last12MonthsPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @Last12MonthsPerControl AND PehEarnCode IN ('COOT', 'DBL', 'OT', 'REG', 'SALRY') THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EFMLAAMEEX_PEarHist_12M
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.PayGroup WITH(NOLOCK)
        ON PrgPayGroup = PgrPayGroup
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFMLAAMEEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EFMLAAMEEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFMLAAMEEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmpSSN = eepSSN
        ,drvEmpId = EecEmpNo
        ,drvEmpTitle = ''
        ,drvEmpFName = EepNameFirst
        ,drvEmpMI = LEFT(EepNameMiddle, 1)
        ,drvEmpLName = EepNameLast
        ,drvEmpGender = CASE WHEN EepGender NOT IN ('M', 'F') THEN 'N' ELSE EepGender END
        ,drvEmpDOB = EepDateOfBirth
        ,drvEmpHomeAdd1 = REPLACE(EepAddressline1, ',', '')
        ,drvEmpHomeAdd2 = REPLACE(EepAddressline2, ',', '')
        ,drvEmpHomeCity = EepAddressCity
        ,drvEmpHomeState = EepAddressState
        ,drvEmpHomeZip = LEFT(EepAddressZipCode, 5)
        ,drvEmpCounty = EepAddressCounty
        ,drvEmpCountry = ''
        ,drvEmpHomePh = EepPHoneHomeNumber
        ,drvEmpMobilePh = EfoPhoneNumber
        ,drvPrimaryPhType = 'Home'
        ,drvEmpEmail = EepAddressemailalternate
        ,drvEmpWorkEmail = EepAddressEMail
        ,drvEmpWorkState = LocAddressState
		--LocDesc
        ,drvEmpOrigDOH = EecDateOfOriginalHire
        ,drvEmpMostRecentDOH = EecDateOfLastHire
        ,drvEmpAdjDOH = ''
        ,drvEmpJobTitle = REPLACE(JbcDesc, ',', '')
        ,drvEmployStatus = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'RT'
                                WHEN EecEmplStatus = 'T' AND EecTermReason <> '202' THEN 'TE'
                                WHEN EecEmplStatus = 'L' THEN 'OL'
                                WHEN EecEmplStatus = 'S' THEN 'SU' 
                                ELSE 'AE' END
        ,drvFTPTStatus = EecFullTimeOrPartTime
        ,drvExemptStatus = CASE WHEN E.EjhFLSACategory = 'E' THEN 'Exempt' ELSE 'Non Exempt' END
        ,drvCompMethod = EecSalaryOrHourly
        ,drvUnionType = CASE WHEN ISNULL(EecUnionLocal, '') <> '' THEN 'Union' ELSE 'Non Union' END
        ,drvUnionName = EecUnionLocal
        ,drvSchHrsPerWk = CAST(CAST(CASE WHEN Peh.PgrPayFrequency = 'B' THEN EecScheduledWorkHrs / 2 ELSE EecScheduledWorkHrs END AS DECIMAL(10,1)) AS VARCHAR)
        ,drvSchDaysPerWk = CASE WHEN EecFullTimeOrPartTime = 'F' THEN '4' ELSE '2' END
        ,drvEmployType = CASE WHEN EecEEType IN ('REG', 'UNI') THEN 'P' ELSE '' END
        ,drvWrkSiteName = EecLocation
        ,drvOrgUnit = EecOrgLvl3
        ,drvBusUnit = EecOrgLvl1
        ,drvDiv = ''
        ,drvGrpType = ''
        ,drvEmpEarning = CAST(CAST(CASE WHEN DATEDIFF(year, Eecdateoflasthire, getdate()) >= 1 THEN Peh24.PehCurAmt ELSE Peh.PehCurAmtYTD END AS DECIMAL(10,2)) AS VARCHAR)
        ,drvEarningsFreq = 'A'
        ,drvEarningsEffDt = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, GETDATE(),EecDateInJob)  
        ,drvSTDWklyEarnings = ''
        ,drvLTDMonthEarnings = ''
        ,drvTermDt = ISNULL(CONVERT(VARCHAR, CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END, 101), '')
        ,drvSTDEligDt = ''
        ,drvSTDElect = ''
        ,drvSTDBenAmt = ''
        ,drvSTDClass = ''
        ,drvSTDTermDt = ''
        ,drvStatDisType = ''
        ,drvLTDEligDt = ''
        ,drvLTDElect = ''
        ,drvLTDBenAmt = ''
        ,drvLTDClass = ''
        ,drvLTDTermDt = ''
        ,drvPolNum = ''
        ,drvKeyEmpIndic = ''
        ,drvWrkAtHomeIndic = ''
        ,drv50in75RuleIndic = 'Y'
        ,drvHrsWrkedPrev12Mo = CAST(CAST(Peh12.PehCurHrs AS INT) AS VARCHAR)
        ,drvSupervisorEmpId = ''
        ,drvSupervisorFName = ''
        ,drvSupervisorLName = ''
        ,drvOccQual1 = ''
        ,drvOccQual2 = ''
        ,drvOccQual3 = ''
        ,drvOccQual4 = ''
        ,drvOccQual5 = ''
        ,drvOccQual6 = ''
        ,drvOccQual7 = ''
        ,drvOccQual8 = ''
        ,drvOccQual9 = ''
        ,drvOccQual10 = ''
        ,drvEmployCont1 = ''
        ,drvEmployCont2 = ''
        ,drvEmployCont3 = ''
        ,drvEmployCont4 = ''
        ,drvEmployCont5 = ''
        ,drvEmployCont6 = ''
        ,drvEmployCont7 = ''
        ,drvEmployCont8 = ''
        ,drvEmployCont9 = ''
        ,drvEmployCont10 = ''
        ,drvRepField1 = ''
        ,drvRepField2 = ''
        ,drvRepField3 = ''
        ,drvRepField4 = ''
        ,drvSpouseDtOfChange = ''
        ,drvSpouseFName = ''
        ,drvSpouseLName = ''
        ,drvSpouseDOB = ''
        ,drvSpouseSSN = ''
        ,drvSpouseEmpId = ''
        ,drvMaritalStatus = ''
        ,drvSpouseReasonOfChange = ''
        ,drvEmployClass = ''
        ,drvEmployStrength = ''
    INTO dbo.U_EFMLAAMEEX_drvTbl
    FROM dbo.U_EFMLAAMEEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH(NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_EFMLAAMEEX_PEarHist Peh WITH(NOLOCK)
        ON Peh.PehEEID = xEEID
        AND Peh.PehCOID = xCOID
    OUTER APPLY (SELECT TOP 1 * FROM dbo.EmpHJob WITH(NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID ORDER BY EjhJobEffDate DESC) E
  --  OUTER APPLY (SELECT TOP 1 * FROM dbo.EmpHJob WITH(NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID AND EjhJobEffDate < @StartDate AND EjhIsRateChange = 'Y' ORDER BY EjhJobEffDate DESC) E2
    LEFT JOIN (SELECT TOP 1 EfoEEID, EfoPhoneNumber FROM dbo.EmpMPhon WITH(NOLOCK) WHERE efoPhoneType = 'CEL') as M on M.EfoEEID = xEEID
    LEFT JOIN dbo.U_EFMLAAMEEX_PEarHist_24M Peh24 WITH(NOLOCK)
        ON Peh24.PehEEID = xEEID
        AND Peh24.PehCOID = xCOID
    LEFT JOIN dbo.U_EFMLAAMEEX_PEarHist_12M Peh12 WITH(NOLOCK)
        ON Peh12.PehEEID = xEEID
        AND Peh12.PehCOID = xCOID
    --JOIN dbo.U_dsi_BDM_EFMLAAMEEX WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
	WHERE EecDateOfTermination IS NULL OR CAST(EecDateOfTermination AS DATE) >= DATEADD(day, -30, CAST(GETDATE() AS DATE))
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
ALTER VIEW dbo.dsi_vwEFMLAAMEEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFMLAAMEEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFMLAAMEEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202110111'
       ,expStartPerControl     = '202110111'
       ,expLastEndPerControl   = '202110189'
       ,expEndPerControl       = '202110189'
WHERE expFormatCode = 'EFMLAAMEEX';

**********************************************************************************/
