--Populate iascDefF for EWEXFSASYM
--For your reference, the adhSystemID is EWEXFSASYMZ0
--Loaded iascDefF Successfully

IF OBJECT_ID('dsi_sp_BuildDriverTables_EWEXFSASYM') IS NOT NULL
    DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWEXFSASYM];
GO

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWEXFSASYM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Symplr

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 01/27/2022
Service Request Number: TekP-2021-10-22-0001

Purpose: WEX FSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWEXFSASYM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWEXFSASYM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWEXFSASYM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWEXFSASYM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWEXFSASYM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXFSASYM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXFSASYM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXFSASYM', 'SCH_EWEXFS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWEXFSASYM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EWEXFSASYM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWEXFSASYM';

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
    DELETE FROM dbo.U_EWEXFSASYM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWEXFSASYM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSADC';

    IF OBJECT_ID('U_EWEXFSASYM_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EWEXFSASYM_DedList
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
    IF OBJECT_ID('U_EWEXFSASYM_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_PDedHist;
    SELECT DISTINCT
         PdhEEID
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
    INTO dbo.U_EWEXFSASYM_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EWEXFSASYM_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EWEXFSASYM_PTTbl
    ---------------------------------
    IF OBJECT_ID('U_EWEXFSASYM_PTTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_PTTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drv10RecType = 'PT'
        ,drv10PartFileId = EepSSN
        ,drv10EmployerEmpId = ''
        ,drv10EmpNum = EecEmpNo
        ,drv10LName = EepNameLast
        ,drv10FName = EepNameFirst
        ,drv10MI = LEFT(EepNameMiddle, 1)
        ,drv10Gender = EepGender
        ,drv10MaritalStat = ''
        ,drv10MotherMN = ''
        ,drv10DOB = EepDateOfBirth
        ,drv10SSN = EepSSN
        ,drv10Add1 = EepAddressLine1
        ,drv10Add2 = EepAddressLine2
        ,drv10Add3 = ''
        ,drv10Add4 = ''
        ,drv10City = EepAddressCity
        ,drv10State = EepAddressState
        ,drv10ZipCode = EepAddressZipCode
        ,drv10Country = 'US'
        ,drv10HPh = ''
        ,drv10WPh = ''
        ,drv10WPhExt = ''
        ,drv10EmailAdd = EepAddressEMail
        ,drv10User = ''
        ,drv10Pass = ''
        ,drv10HireDt = EecDateOfLastHire
        ,drv10Div = ''
        ,drv10HrsPerWk = ''
        ,drv10EmpClass = 'E'
        ,drv10PayrollFreq = 'Payroll'
        ,drv10PayrollFreqEffDt = ''
        ,drv10PartStat = CASE WHEN EecEmplStatus = 'T' THEN 'Terminated' ELSE 'Active' END
        ,drv10StatEffDt = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination ELSE EecDateOfLastHire END
        ,drv10HoldPayDed = ''
        ,drv10HoldEmployerCont = ''
        ,drv10IncurServ = ''
        ,drv10FinalPayProcDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination) END), 101), '')
        ,drv10FinalContProcDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination) END), 101), '')
        ,drv10HSACust = ''
        ,drv10MediBen = ''
        ,drv10MediId = ''
        ,drv10ExIntId = ''
        ,drv10RepLvl1 = ''
        ,drv10RepLvl2 = ''
        ,drv10RepLvl3 = ''
        ,drv10RepLvl4 = ''
        ,drv10CDDCitizen = ''
        ,drv10CDDCountry = EepAddressCountry
        ,drv10CDDEmpStat = ''
        ,drv10Employer = ''
        ,drv10JobTitle = ''
        ,drv10ClassEffDt = ''
        ,drv10IDIdentType = ''
        ,drv10IDIdentNum = ''
        ,drv10IDIssuingState = EepAddressState
        ,drv10IDIssuer = ''
        ,drv10IDIssueDt = ''
        ,drv10IDExpirationDt = ''
        ,drv10MobileCar = ''
        ,drv10MobileNum = ''
        ,drv10TimeZone = ''
    INTO dbo.U_EWEXFSASYM_PTTbl
    FROM dbo.U_EWEXFSASYM_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWEXFSASYM_ENTbl
    ---------------------------------
    IF OBJECT_ID('U_EWEXFSASYM_ENTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_ENTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drv20RecType = 'EN'
        ,drv20PartFileImpId = EepSSN
        ,drv20PlanName = CASE WHEN EedDedCode = 'FSA' THEN 'Medical FSA'
                                WHEN EedDedCode = 'FSAD' THEN 'Dependent Care FSA' END
        ,drv20EnrollEffDt = EedBenStartDate
        ,drv20PartElectAmt = EedEEGoalAmt
        ,drv20EnrollTermDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus <> 'T' THEN EedBenStopDate END), 101), '')
        ,drv20EmployerContribLvl = ''
        ,drv20EmployerContribAmt = ''
        ,drv20PrimReimburse = ''
        ,drv20AltReimburse = ''
        ,drv20EnrolledInClaims = ''
        ,drv20ElectAmtIndic = ''
        ,drv20HDHPCovLvl = ''
        ,drv20PlanYearStartDt = '0101' + CAST(YEAR(GETDATE()) AS VARCHAR)
        ,drv20TermCondAccept = ''
        ,drv20TimeTermCondAccpt = ''
        ,drv20ChangeDt = ''
        ,drv20SpendDown = ''
    INTO dbo.U_EWEXFSASYM_ENTbl
    FROM dbo.U_EWEXFSASYM_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWEXFSASYM_CTTbl
    ---------------------------------
    IF OBJECT_ID('U_EWEXFSASYM_CTTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_CTTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drv30RecordType = 'CT'
        ,drv30PartFileImpId = EepSSN
        ,drv30PlanName = CASE WHEN EedDedCode = 'FSA' THEN 'Medical FSA' ELSE 'Dependent Care FSA' END
        ,drv30ContDt = PgrPayDate
        ,drv30ContDesc = 'Payroll Deduction'
        ,drv30ContAmt = CAST(CAST(PdhEECurAmt AS DECIMAL(10,2)) AS VARCHAR)
        ,drv30AmtType = 'Actual'
        ,drv30TaxYear = 'Current'
    INTO dbo.U_EWEXFSASYM_CTTbl
    FROM dbo.U_EWEXFSASYM_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EWEXFSASYM_hdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_hdrTbl;
    SELECT DISTINCT
         hdr01RecType = 'FH'
        ,hdr01AdminCode = 'DBI'
        ,hdr01EmpCode = '43104'
        ,hdr01SyncFlag = 'N'
        ,hdr01SubmitDt = GETDATE()
        ,hdr01SubmitTime = CONVERT(VARCHAR(10), GETDATE(), 108)
    INTO dbo.U_EWEXFSASYM_hdrTbl
    FROM dbo.U_EWEXFSASYM_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EWEXFSASYM_trlTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_trlTbl;
    SELECT DISTINCT
         trl90RecType = 'FF'
        ,trl90RecCount = (SELECT COUNT(1) FROM dbo.U_EWEXFSASYM_PTTbl WITH(NOLOCK)) + (SELECT COUNT(1) FROM dbo.U_EWEXFSASYM_ENTbl WITH(NOLOCK)) + (SELECT COUNT(1) FROM dbo.U_EWEXFSASYM_CTTbl WITH(NOLOCK)) 
        ,trl90AdminCode = 'DBI'
        ,trl90EmpCode = '43104'
        ,trl90SubmitDt = GETDATE()
        ,trl90SubmitTime = CONVERT(VARCHAR(10), GETDATE(), 108)
    INTO dbo.U_EWEXFSASYM_trlTbl
    FROM dbo.U_EWEXFSASYM_EEList WITH (NOLOCK)
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
ALTER VIEW dbo.dsi_vwEWEXFSASYM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWEXFSASYM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EWEXFSASYM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201201'
       ,expStartPerControl     = '202201201'
       ,expLastEndPerControl   = '202201279'
       ,expEndPerControl       = '202201279'
WHERE expFormatCode = 'EWEXFSASYM';

**********************************************************************************/
