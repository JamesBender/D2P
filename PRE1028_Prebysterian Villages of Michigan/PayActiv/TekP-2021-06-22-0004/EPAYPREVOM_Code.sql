--Populate AscDefF for EPAYPREVOM
--For your reference, the adhSystemID is EPAYPREVOMZ0
--Loaded AscDefF Successfully

IF OBJECT_ID('dsi_sp_BuildDriverTables_EPAYPREVOM') IS NOT NULL
    DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPAYPREVOM];
GO

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPAYPREVOM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Presbyterian Villages of Michigan 

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 12/16/2021
Service Request Number: TekP-2021-06-22-0004

Purpose: PayActiv Demographic Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPAYPREVOM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPAYPREVOM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPAYPREVOM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPAYPREVOM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPAYPREVOM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYPREVOM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYPREVOM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYPREVOM', 'SCH_EPAYPR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPAYPREVOM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPAYPREVOM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPAYPREVOM';

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
    DELETE FROM dbo.U_EPAYPREVOM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPAYPREVOM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- --==========================================
    -- -- Create Deduction List
    -- --==========================================
    -- DECLARE @DedList VARCHAR(MAX)
    -- SET @DedList = 'DED1,DED2';

    -- IF OBJECT_ID('U_EPAYPREVOM_DedList','U') IS NOT NULL
    --     DROP TABLE dbo.U_EPAYPREVOM_DedList;
    -- SELECT DISTINCT
    --      DedCode = DedDedCode
    --     ,DedType = DedDedType
    -- INTO dbo.U_EPAYPREVOM_DedList
    -- FROM dbo.fn_ListToTable(@DedList)
    -- JOIN dbo.DedCode WITH (NOLOCK)
    --     ON DedDedCode = Item;


    -- --==========================================
    -- -- BDM Section
    -- --==========================================
    -- DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- -- Required parameters
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- -- Non-Required parameters
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- -- Run BDM Module
    -- EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    -- IF OBJECT_ID('U_EPAYPREVOM_PDedHist','U') IS NOT NULL
    --     DROP TABLE dbo.U_EPAYPREVOM_PDedHist;
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
    -- INTO dbo.U_EPAYPREVOM_PDedHist
    -- FROM dbo.PDedHist WITH (NOLOCK)
    -- JOIN dbo.U_EPAYPREVOM_DedList WITH (NOLOCK)
    --     ON DedCode = PdhDedCode
    -- WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    -- AND PdhPerControl <= @EndPerControl
    -- AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    -- GROUP BY PdhEEID
    -- HAVING (SUM(PdhEECurAmt) <> 0.00
    --     OR SUM(PdhERCurAmt) <> 0.00
    -- );


    -- -----------------------------
    -- -- Working Table - PEarHist
    -- -----------------------------
    -- IF OBJECT_ID('U_EPAYPREVOM_PEarHist','U') IS NOT NULL
    --     DROP TABLE dbo.U_EPAYPREVOM_PEarHist;
    -- SELECT DISTINCT
    --      PehEEID
    --     ,PrgPayDate             = MAX(PrgPayDate)
    --     -- Current Payroll Amount/Hours
    --     ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
    --     ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
    --     -- YTD Payroll Amount/Hours
    --     ,PehCurAmtYTD           = SUM(PehCurAmt)
    --     ,PehCurHrsYTD           = SUM(PehCurHrs)
    --     -- Current Include Deferred Comp Amount/Hours
    --     ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
    --     ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
    --     -- YTD Include Deferred Comp Amount/Hours
    --     ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
    --     ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    -- INTO dbo.U_EPAYPREVOM_PEarHist
    -- FROM dbo.vw_int_PayReg WITH (NOLOCK)
    -- JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
    --     ON PehGenNumber = PrgGenNumber
    -- WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    -- AND PehPerControl <= @EndPerControl
    -- GROUP BY PehEEID
    -- HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPAYPREVOM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPAYPREVOM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPAYPREVOM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmpId = RIGHT('000000000' + EecEmpNo, 9)
        ,drvFName = EepNameFirst
        ,drvLName = EepNameLast
        ,drvEmpType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Salary' ELSE 'Hourly' END
        ,drvIncomeRate = CAST(CASE WHEN EecSalaryOrHourly = 'S' THEN EecAnnSalary ELSE CAST(EecHourlyPayRate AS DECIMAL(10,2)) END AS VARCHAR)
        ,drvPhNum = SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                    SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                    SUBSTRING(EepPhoneHomeNumber, 7, 4)
        ,drvEmail = EepAddressEMail
        ,drvLocId = LocDesc
        ,drvPayGroup = EecPayGroup
        ,drvWorkState = LocAddressState
        ,drvDOB = CONVERT(VARCHAR, EepDateOfBirth, 101)
    INTO dbo.U_EPAYPREVOM_drvTbl
    FROM dbo.U_EPAYPREVOM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Location WITH(NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEPAYPREVOM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPAYPREVOM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPAYPREVOM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112091'
       ,expStartPerControl     = '202112091'
       ,expLastEndPerControl   = '202112169'
       ,expEndPerControl       = '202112169'
WHERE expFormatCode = 'EPAYPREVOM';

**********************************************************************************/
