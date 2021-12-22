--Populate AscDefF for EOPTFSAGRA
--For your reference, the adhSystemID is EOPTFSAGRAZ0
--Loaded AscDefF Successfully

IF OBJECT_ID('dsi_sp_BuildDriverTables_EOPTFSAGRA') IS NOT NULL
    DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTFSAGRA];
GO

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTFSAGRA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Grange Insurance

Created By: Andy Pineda
Business Analyst: Richard Vars
Create Date: 12/21/2021
Service Request Number: TekP-2021-08-23-0001

Purpose: Optum FSA

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EOPTFSAGRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EOPTFSAGRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EOPTFSAGRA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EOPTFSAGRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EOPTFSAGRA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTFSAGRA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTFSAGRA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTFSAGRA', 'SCH_EOPTFS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EOPTFSAGRA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EOPTFSAGRA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EOPTFSAGRA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('01/01/2022' AS DATETIME)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EOPTFSAGRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EOPTFSAGRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FLXBG';

    IF OBJECT_ID('U_EOPTFSAGRA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EOPTFSAGRA_DedList
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
    IF OBJECT_ID('U_EOPTFSAGRA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCOID
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
    INTO dbo.U_EOPTFSAGRA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EOPTFSAGRA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhCOID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EOPTFSAGRA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
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
    INTO dbo.U_EOPTFSAGRA_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EOPTFSAGRA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EOPTFSAGRA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmpId = CASE WHEN BdmRecType = 'EMP' THEN EepSSN ELSE ConSSN END
        ,drvEmpIdEmpAltId = '000000000'
        ,drvMemLName = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvMemFName = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvMI = ''
        ,drvPermAdd1 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1 ELSE ConAddressLine1 END
        ,drvPermAdd2 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2 ELSE ConAddressLine2 END
        ,drvPermCity = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity ELSE ConAddressCity END
        ,drvPermState = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState ELSE ConAddressState END
        ,drvPermZip = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode ELSE ConAddressZipCode END
        ,drvMemDOB = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvPolNum = '0925268'
        ,drvPlanCode = '0001'
        ,drvPlanEffDt = BdmBenStartDate
        ,drvRepCode1 = ''
        ,drvRepCode2 = ''
        ,drvContribType1 = 'MED' -- See ripout for enrollment date field prior to this one. Add to table and remove 'SS'
        ,drvContribSC1 = 'E'
        ,drvContribSign1 = '+'
        ,drvContribAmt1 = '0000000'
        ,drvContribType2 = 'DEP'
        ,drvContribSC2 = 'E'
        ,drvContribSign2 = '+'
        ,drvContribAmt2 = '0000000'
        ,drvContribType3 = 'MED'
        ,drvContribSC3 = 'P'
        ,drvContribSign3 = '+'
        ,drvContribAmt3 = '0000000'
        ,drvContribType4 = 'DEP'
        ,drvContribSC4 = 'P'
        ,drvContribSign4 = '+'
        ,drvContribAmt4 = '0000000'
        ,drvAutoSubIndic = ''
        ,drvHealthLPFSATermDt = ISNULL(CONVERT(VARCHAR, BdmBenStopDate, 112), '')
        ,drvHealthLPFSAElectAmt = '0000000'
        ,drvHealthLPFSAElectEffDt = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvPrefundSign = '+'
        ,drvPrefundAmt = '0000000'
        ,drvDepCareFSATermDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN BdmRecType = 'DEP' THEN BdmBenStopDate END), 112), '')
        ,drvDepCareFSAElectEffDt = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvDepCareFSAElectAmt = '0000000'
    INTO dbo.U_EOPTFSAGRA_drvTbl
    FROM dbo.U_EOPTFSAGRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EOPTFSAGRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	JOIN dbo.U_EOPTFSAGRA_PEarHist WITH(NOLOCK)
		ON PehEEID = xEEID
		AND PehCOID = xCOID
	LEFT JOIN dbo.Contacts WITH(NOLOCK)
		ON ConEEID = xEEID
		AND ConSystemID = BdmDepRecId
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EOPTFSAGRA_hdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_hdrTbl;
    SELECT DISTINCT
         hdrHeadMastLay = '6'
        ,hdrSysName = 'FSA'
        ,hdrSysNum = '5426'
        ,hdrClientCode = '925268111'
        ,hdrVersNum = '001'
        ,hdrDate = (SELECT MAX(PrgPayDate) FROM dbo.U_EOPTFSAGRA_PEarHist WITH(NOLOCK))
        ,hdrCustSpecId = '925268111'
        ,hdrCustName = 'Grange'
        ,hdrCycle = '' -- Design logic in server
        ,hdrPolNum = '0925268'
        ,hdrTypeFeed = 'PROD'
        ,hdrMultCovDataIndic = 'A'
    INTO dbo.U_EOPTFSAGRA_hdrTbl
 --   FROM dbo.U_EOPTFSAGRA_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EOPTFSAGRA_trlTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_trlTbl;
    SELECT DISTINCT
         drvRecCount = RIGHT('000000' + (SELECT COUNT(1) FROM dbo.U_EOPTFSAGRA_drvTbl WITH(NOLOCK)), 6)
        ,drvTotHealthLFSAContAmtSign = '+'
        ,drvTotHealthLFSAContAmt = '0000000000'
        ,drvTotDepCareFSAContAmtSign = '+'
        ,drvTotDepCareFSAContAmt = (SELECT PehCurAmtYTD FROM dbo.U_EOPTFSAGRA_PEarHist WITH(NOLOCK))
        ,drvTotHealthLFSAElectAmt = '0000000000'
        ,drvTotDepCareFSAElectAmt = '0000000000'
    INTO dbo.U_EOPTFSAGRA_trlTbl
   -- FROM dbo.U_EOPTFSAGRA_EEList WITH (NOLOCK)
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
ALTER VIEW dbo.dsi_vwEOPTFSAGRA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EOPTFSAGRA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EOPTFSAGRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112141'
       ,expStartPerControl     = '202112141'
       ,expLastEndPerControl   = '202112219'
       ,expEndPerControl       = '202112219'
WHERE expFormatCode = 'EOPTFSAGRA';

**********************************************************************************/
