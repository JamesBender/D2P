USE [ULTIPRO_ESA]
GO
/****** Object:  StoredProcedure [dbo].[dsi_sp_BuildDriverTables_ECLOHSACON]    Script Date: 7/14/2022 9:33:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECLOHSACON]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: ChanceLight

Created By: Roger Bynum
Business Analyst: Cheryl Petitti
Create Date: 06/21/2022
Service Request Number: TekP-2022-04-14-01

Purpose: Optum HSA Contribution Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECLOHSACON';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECLOHSACON';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECLOHSACON';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, 
ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECLOHSACON';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECLOHSACON' ORDER BY RunID DESC;
Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECLOHSACON', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECLOHSACON', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECLOHSACON', 'SCH_ECLOHS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECLOHSACON';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECLOHSACON', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECLOHSACON';

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
    DELETE FROM dbo.U_ECLOHSACON_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECLOHSACON_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSADE, HSAEE, HSDCU, HSECU, HSAUP';

    IF OBJECT_ID('U_ECLOHSACON_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECLOHSACON_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECLOHSACON_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList) ;
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStartDateDays','30');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStopDateDays','30');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECLOHSACON_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECLOHSACON_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        --,PdhEEHSADE     = SUM(CASE WHEN PdhDedCode IN ('HSADE') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhEEHSAEE     = SUM(CASE WHEN PdhDedCode IN ('HSAEE') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhEEHSDCU     = SUM(CASE WHEN PdhDedCode IN ('HSDCU') THEN PdhERCurAmt ELSE 0.00 END)        
        --,PdhEEHSECU     = SUM(CASE WHEN PdhDedCode IN ('HSECU') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhEEHSAUP     = SUM(CASE WHEN PdhDedCode IN ('HSAUP') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhERHSADE     = SUM(CASE WHEN PdhDedCode IN ('HSADE') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhERHSAEE     = SUM(CASE WHEN PdhDedCode IN ('HSAEE') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhERHSDCU     = SUM(CASE WHEN PdhDedCode IN ('HSDCU') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhERHSECU     = SUM(CASE WHEN PdhDedCode IN ('HSECU') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhERHSAUP     = SUM(CASE WHEN PdhDedCode IN ('HSAUP') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_ECLOHSACON_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECLOHSACON_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
 --   AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECLOHSACON_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECLOHSACON_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECLOHSACON_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = xEEID
        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,drvCreditAmount = '"' + REPLACE(SUBSTRING(bdmEEAmt,1, LEN(bdmEEAmt) -2), '.' ,'') + '00"'
        ,drvContributionType = 'Current Year Employee Contribution'
        ,drvSocialSecurityNumber = '"' + TRIM(EepSSN) + '"'
    INTO dbo.U_ECLOHSACON_drvTbl
    FROM dbo.U_ECLOHSACON_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
	JOIN (SELECT bdmEEID as BdmEEID,
			bdmCOID AS bdmCOID, 
			'Y' AS bdmEECode,
			CAST(SUM (bdmEEAmt)AS VARCHAR) AS bdmEEAmt
			from dbo.U_dsi_BDM_ECLOHSACON WITH (NOLOCK)
			WHERE bdmDedcode IN ('HSADE', 'HSAEE', 'HSDCU', 'HSECU')
			AND bdmEEAmt > 0
			GROUP BY bdmEEID, bdmCOID) AS BdmFlattenedEE
        ON BdmEEID = xEEID
			
    ;
    INSERT INTO dbo.U_ECLOHSACON_drvTbl
     (drvEEID
    ,drvCoID
    ,drvSort
    ,drvSubSort
    -- standard fields above
    ,drvCreditAmount
    ,drvContributionType
    ,drvSocialSecurityNumber)

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = xEEID
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvCreditAmount = '"' + REPLACE(SUBSTRING(bdmERAmt,1, LEN(bdmERAmt) -2), '.' ,'') + '00"'
        ,drvContributionType = 'Current Year Employer Contribution'
        ,drvSocialSecurityNumber = '"' + TRIM(EepSSN) + '"'
    FROM dbo.U_ECLOHSACON_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    JOIN dbo.U_ECLOHSACON_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
	JOIN (SELECT bdmEEID as BdmEEID,
		bdmCOID AS bdmCOID, 
		'Y' AS bdmEECode,
		CAST(SUM (bdmERAmt)AS VARCHAR) AS bdmERAmt
		from dbo.U_dsi_BDM_ECLOHSACON WITH (NOLOCK)
		WHERE bdmDedcode IN ('HSADE', 'HSAEE', 'HSDCU', 'HSECU')
		AND BdmERAmt > 0
		GROUP BY bdmEEID, bdmCOID) AS BdmFlattenedER
		ON BdmEEID = xEEID


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
ALTER VIEW dbo.dsi_vwECLOHSACON_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECLOHSACON_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECLOHSACON%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202206141'
       ,expStartPerControl     = '202206141'
       ,expLastEndPerControl   = '202206219'
       ,expEndPerControl       = '202206219'
WHERE expFormatCode = 'ECLOHSACON';

**********************************************************************************/
