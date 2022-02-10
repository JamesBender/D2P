--Populate iascDefF for EUNUMLEECO
--For your reference, the adhSystemID is EUNUMLEECOZ0
--Loaded iascDefF Successfully

IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMLEECO') IS NOT NULL
    DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMLEECO];
GO

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMLEECO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Lee Contracting, Inc.

Created By: Andy Pineda
Business Analyst: Julie Reardon
Create Date: 02/08/2022
Service Request Number: TekP-2021-11-18-0002

Purpose: Unum FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMLEECO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMLEECO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMLEECO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMLEECO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMLEECO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMLEECO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMLEECO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMLEECO', 'SCH_EUNUML';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMLEECO';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUNUMLEECO', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EUNUMLEECO';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('01/01/2021' as DATETIME)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUNUMLEECO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMLEECO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD,STD2,STD3,LTD';

    IF OBJECT_ID('U_EUNUMLEECO_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLEECO_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMLEECO_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    -- IF OBJECT_ID('U_EUNUMLEECO_PDedHist','U') IS NOT NULL
    --     DROP TABLE dbo.U_EUNUMLEECO_PDedHist;
    -- SELECT DISTINCT
    --      PdhEEID
    --     -- Current Payroll Amounts
    --     ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --     -- YTD Payroll Amounts
    --     ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --     ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --     -- Categorize Payroll Amounts
    --     ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --     ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    -- INTO dbo.U_EUNUMLEECO_PDedHist
    -- FROM dbo.PDedHist WITH (NOLOCK)
    -- JOIN dbo.U_EUNUMLEECO_DedList WITH (NOLOCK)
    --     ON DedCode = PdhDedCode
    -- WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    -- AND PdhPerControl <= @EndPerControl
    -- AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    -- GROUP BY PdhEEID
    -- HAVING (SUM(PdhEECurAmt) <> 0.00
    --     OR SUM(PdhERCurAmt) <> 0.00
    -- );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
   IF OBJECT_ID('U_EUNUMLEECO_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLEECO_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehEarnCode
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PayEarnCode            = MAX(PehEarnCode)
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
    INTO dbo.U_EUNUMLEECO_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl, 4) = YEAR(GETDATE()) - 1
    --LEFT(PehPerControl,4) - 1 = LEFT(@EndPerControl,4) - 1
    --PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehEarnCode
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMLEECO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMLEECO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLEECO_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPartCaseId = 'LEE-023835'
        ,drvServIndic = 'ELG'
        ,drvEESSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                    SUBSTRING(EepSSN, 4, 2)+'-'+
                    SUBSTRING(EepSSN, 6, 4) 
        ,drvEmpId = EecEmpNo
        ,drvEmpIdType = 'EEID'
        ,drvEmpFName = EepNameFirst
        ,drvEmpMI = ''
        ,drvEmpLName = EepNameLast
        ,drvEEAdd1 = EepAddressLine1
        ,drvEEAdd2 = ''
        ,drvEECity = EepAddressCity
        ,drvEEState = EepAddressState
        ,drvEEPostalCode = EepAddressZipCode
        ,drvEECountryCode = EepAddressCountry
        ,drvEEWorkState = LocAddressState
        ,drvEEDOB = EepDateOfBirth
        ,drvEEGender = EepGender
        ,drvMaritalStat = EepMaritalStatus
        ,drvEmpJobTitle = JbcDesc
        ,drvMostRecentHireDt = EecDateOfLastHire
        ,drvOrigHireDt = EecDateOfOriginalHire
        ,drvEmploymentTermDt = ISNULL(CONVERT(VARCHAR, EecDateOfTermination, 101), '')
        ,drvEmploymentStat = CASE WHEN EecEmplStatus IN ('A', 'O', 'S', 'T') THEN 'A'
                                    WHEN EecEmplStatus = 'R' THEN 'LAY'
                                    WHEN EecEmplStatus = 'L' THEN 'LOA' END
        ,drvWeekSchWorkHrs = CAST(EecScheduledWorkHrs AS VARCHAR)
        ,drvAccoRestrict = 'Y'
        ,drvSickPayHrs = ''
        ,drvDtLastSalChng = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire)
        ,drvEmpHomePh = EepPhoneHomeNumber
        ,drvManFName = ''
        ,drvManLName = ''
        ,drvManEmail = ''
        ,drvEmpSecManEmail = ''
        ,drvEmpThirdManEmail = ''
        ,drvHrsWrkedPast12Mo = CAST(Peh.PehCurHrs AS VARCHAR)
        ,drvWorkSunday = ''
        ,drvWorkMonday = ''
        ,drvWorkTuesday = ''
        ,drvWorkWednesday = ''
        ,drvWorkThursday = ''
        ,drvWorkFriday = ''
        ,drvWorkSaturday = ''
        ,drvOfficeName = ''
        ,drvEmpWorkMailStreet1 = ''
        ,drvEmpWorkMailStreet2 = ''
        ,drvEmpWorkMailStreet3 = ''
        ,drvEmpWorkCity = EepAddressCity
        ,drvEmpWorkPostCode = ''
        ,drvFMLARepGrp = ''
        ,drvKeyEmp = ''
        ,drvEESalMode = EecSalaryOrHourly
        ,drvProduct1 = CASE WHEN STD IS NOT NULL THEN '469' END
        ,drvPolNum1 = CASE WHEN STD IS NOT NULL THEN '709744' END
        ,drvDiv1 = '1'
        ,drvPolEligGrp1 = CASE WHEN STD IS NOT NULL AND EecOrgLvl3 IN ('TRD', 'ADS') THEN '1'
                                WHEN STD IS NOT NULL AND EecOrgLvl3 IN ('MGT', 'PFS', 'EXE') AND DATEDIFF(YEAR, GETDATE(), EecDateOfLastHire) < 3 THEN '2'
                                WHEN STD IS NOT NULL AND EecOrgLvl3 IN ('MGT', 'PFS', 'EXE') AND DATEDIFF(YEAR, GETDATE(), EecDateOfLastHire) >= 3 THEN '3'
                                    END
        ,drvChoice1 = '1'
        ,drvEmpPostTax1 = CASE WHEN STD IS NOT NULL THEN '0' END
        ,drvEarnings1 = CASE WHEN STD IS NOT NULL THEN '0' END
        ,drvEarningsPrd1 = CASE WHEN STD IS NOT NULL THEN 'WK' END
        ,drvEffDtEmpCov1 = CASE WHEN STD IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', STD_BenStartDate, @FileMinCovDate) END
        ,drvEmpCovTermDt1 = CASE WHEN STD IS NOT NULL THEN STD_BenStopDate END
        ,drvProduct2 = CASE WHEN LTD IS NOT NULL THEN '195' END
        ,drvPolNum2 = CASE WHEN LTD IS NOT NULL THEN '497388' END
        ,drvDiv2 = '1'
        ,drvPolEligGrp2 = CASE WHEN LTD IS NOT NULL THEN '1' END
        ,drvChoice2 = '1'
        ,drvEmpPostTax2 = CASE WHEN LTD IS NOT NULL THEN '100' END
        ,drvEarnings2 = CASE WHEN LTD IS NOT NULL THEN CAST(EecAnnSalary / 12 AS VARCHAR) END
        ,drvEarningsPrd2 = CASE WHEN LTD IS NOT NULL THEN 'MO' END
        ,drvEffDtEmpCov2 = CASE WHEN LTD IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', LTD_BenStartDate, @FileMinCovDate) END
        ,drvEmpCovTermDt2 = CASE WHEN LTD IS NOT NULL THEN LTD_BenStopDate END
    INTO dbo.U_EUNUMLEECO_drvTbl
    FROM dbo.U_EUNUMLEECO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
	JOIN dbo.Location WITH(NOLOCK)
		ON LocCode = EecLocation
    -- JOIN dbo.U_dsi_BDM_EUNUMLEECO WITH (NOLOCK)
    --     ON BdmEEID = xEEID 
    --     AND BdmCoID = xCoID
    JOIN (SELECT EedEEID, EedCOID, MAX(CASE WHEN EedDedCode = 'LTD' THEN 'LTD' END) AS LTD,
                    MAX(CASE WHEN EedDedCode IN ('STD', 'STD2', 'STD3') THEN 'STD' END) AS STD,
                    MAX(CASE WHEN EedDedCode = 'LTD' THEN EedBenStartDate END) AS LTD_BenStartDate,
                    MAX(CASE WHEN EedDedCode = 'LTD' THEN EedBenStopDate END) AS LTD_BenStopDate,
                    MAX(CASE WHEN EedDedCode IN ('STD', 'STD2', 'STD3')  THEN EedBenStartDate END) AS STD_BenStartDate,
                    MAX(CASE WHEN EedDedCode IN ('STD', 'STD2', 'STD3')  THEN EedBenStopDate END) AS STD_BenStopDate
            FROM dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
            WHERE EedFormatCode = @FormatCode
            AND EedValidForExport = 'Y'
            GROUP BY EedEEID, EedCOID
            ) D ON D.EedEEID = xEEID AND D.EedCOID = xCOID
    LEFT JOIN (SELECT PehEEID, SUM(PehCurHrs) AS PehCurHrs
                FROM dbo.U_EUNUMLEECO_PEarHist WITH(NOLOCK)
                WHERE PehEarnCode IN ('DT', 'MBDT', 'MBOT', 'MBRG', 'OT', 'REG')
                                        GROUP BY PehEEID) Peh ON Peh.PehEEID = xEEID
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
ALTER VIEW dbo.dsi_vwEUNUMLEECO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMLEECO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMLEECO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202202011'
       ,expStartPerControl     = '202202011'
       ,expLastEndPerControl   = '202202089'
       ,expEndPerControl       = '202202089'
WHERE expFormatCode = 'EUNUMLEECO';

**********************************************************************************/
