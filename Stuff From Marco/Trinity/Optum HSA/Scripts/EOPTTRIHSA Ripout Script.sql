SET NOCOUNT ON;
IF OBJECT_ID('U_EOPTTRIHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EOPTTRIHSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EOPTTRIHSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EOPTTRIHSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEOPTTRIHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEOPTTRIHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EOPTTRIHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTTRIHSA];
GO
IF OBJECT_ID('U_EOPTTRIHSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EOPTTRIHSA_PEarHist];
GO
IF OBJECT_ID('U_EOPTTRIHSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EOPTTRIHSA_PDedHist];
GO
IF OBJECT_ID('U_EOPTTRIHSA_File') IS NOT NULL DROP TABLE [dbo].[U_EOPTTRIHSA_File];
GO
IF OBJECT_ID('U_EOPTTRIHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EOPTTRIHSA_EEList];
GO
IF OBJECT_ID('U_EOPTTRIHSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EOPTTRIHSA_drvTbl];
GO
IF OBJECT_ID('U_EOPTTRIHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EOPTTRIHSA_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EOPTTRIHSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EOPTTRIHSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EOPTTRIHSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EOPTTRIHSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EOPTTRIHSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EOPTTRIHSA','Optum HSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EOPTTRIHSAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Transaction Type"','1','(''DA''=''T,'')','EOPTTRIHSAZ0','50','H','01','1',NULL,'Transaction Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account Number"','2','(''DA''=''T,'')','EOPTTRIHSAZ0','50','H','01','2',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Credit Amount"','3','(''DA''=''T,'')','EOPTTRIHSAZ0','50','H','01','3',NULL,'Credit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution Type"','4','(''DA''=''T,'')','EOPTTRIHSAZ0','50','H','01','4',NULL,'Contribution Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number"','5','(''DA''=''T'')','EOPTTRIHSAZ0','50','H','01','5',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransactionType"','1','(''UA''=''T,'')','EOPTTRIHSAZ0','12','D','10','1',NULL,'Transaction Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountNumber"','2','(''UA''=''T,'')','EOPTTRIHSAZ0','9','D','10','2',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCreditAmount"','3','(''UA''=''T,'')','EOPTTRIHSAZ0','11','D','10','3',NULL,'Credit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionType"','4','(''UA''=''T,'')','EOPTTRIHSAZ0','34','D','10','4',NULL,'Contribution Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSocialSecurity"','5','(''UA''=''T'')','EOPTTRIHSAZ0','9','D','10','5',NULL,'Social Security Number',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EOPTTRIHSA_20200628.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Optum HSA Export','202002129','EMPEXPORT','ONDEMAND',NULL,'EOPTTRIHSA',NULL,NULL,NULL,'202002129','Feb 12 2020  1:07PM','Feb 12 2020  1:07PM','202002121',NULL,'','','202002121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EOPTTRIHSA_20200628.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202002129','EMPEXPORT','OPT_SCHED',NULL,'EOPTTRIHSA',NULL,NULL,NULL,'202002129','Feb 12 2020  1:07PM','Feb 12 2020  1:07PM','202002121',NULL,'','','202002121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EOPTTRIHSA_20200628.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202006261','EMPEXPORT','TEST','Jun 28 2020 10:04PM','EOPTTRIHSA',NULL,NULL,NULL,'202006261','Jun 26 2020 12:00AM','Dec 30 1899 12:00AM','202006231','42','','','202006231',dbo.fn_GetTimedKey(),NULL,'us3mLaTRI1018',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EOPTTRIHSA_20200628.txt' END WHERE expFormatCode = 'EOPTTRIHSA';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTTRIHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTTRIHSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTTRIHSA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTTRIHSA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTTRIHSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTTRIHSA','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EOPTTRIHSA' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EOPTTRIHSA' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EOPTTRIHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EOPTTRIHSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTTRIHSA','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTTRIHSA','D10','dbo.U_EOPTTRIHSA_drvTbl',NULL);
IF OBJECT_ID('U_EOPTTRIHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EOPTTRIHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EOPTTRIHSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EOPTTRIHSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvTransactionType] varchar(12) NOT NULL,
    [drvAccountNumber] varchar(1) NOT NULL,
    [drvCreditAmount] varchar(8000) NULL,
    [drvContributionType] varchar(34) NOT NULL,
    [drvSocialSecurity] char(11) NULL,
    [drvCreditAmountRaw] numeric NULL
);
IF OBJECT_ID('U_EOPTTRIHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EOPTTRIHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EOPTTRIHSA_File') IS NULL
CREATE TABLE [dbo].[U_EOPTTRIHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EOPTTRIHSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EOPTTRIHSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL
);
IF OBJECT_ID('U_EOPTTRIHSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EOPTTRIHSA_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTTRIHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Trinity Rivers Authority of Texas

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 02/12/2020
Service Request Number: TekP-2019-12-03-002

Purpose: Optum HSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EOPTTRIHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EOPTTRIHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EOPTTRIHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EOPTTRIHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EOPTTRIHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTTRIHSA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTTRIHSA', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EOPTTRIHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EOPTTRIHSA';

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
    DELETE FROM dbo.U_EOPTTRIHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EOPTTRIHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSA,HSAF,HSACF,HSACI,HSAER';

    IF OBJECT_ID('U_EOPTTRIHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTTRIHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EOPTTRIHSA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EOPTTRIHSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTTRIHSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhEECurAmt = SUM(CASE WHEN PdhDedcode in ('HSAI','HSAF','HSACF','HSACI') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt = SUM(CASE WHEN PdhDedcode in ('HSAI','HSAF','HSACF','HSACI','HSAER') THEN PdhERCurAmt ELSE 0.00 END)
    INTO dbo.U_EOPTTRIHSA_PDedHist

    FROM dbo.PDedHist WITH (NOLOCK)

    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl

    AND PdhDedCode IN ('HSAI','HSAF','HSACF','HSACI','HSAER')

    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00);



    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EOPTTRIHSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTTRIHSA_PEarHist;
    SELECT DISTINCT
         PehEEID
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
    INTO dbo.U_EOPTTRIHSA_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EOPTTRIHSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EOPTTRIHSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTTRIHSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvTransactionType = 'Contribution'
        ,drvAccountNumber = ''
        ,drvCreditAmount = REPLACE((CONVERT(VARCHAR, CONVERT( DECIMAL(7,2),(PdhEECurAmt)) )),'.','')
        ,drvContributionType =  'Current Year Employee Contribution'
        ,drvSocialSecurity = eepSSN
        ,drvCreditAmountRaw = PdhEECurAmt

    INTO dbo.U_EOPTTRIHSA_drvTbl
    FROM dbo.U_EOPTTRIHSA_EEList WITH (NOLOCK)
    INNER JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
    INNER JOIN dbo.U_EOPTTRIHSA_PDedHist
            on pdhEEID = xEEID
    WHERE PdhEECurAmt > 0
    ;


    INSERT INTO dbo.U_EOPTTRIHSA_drvTbl
      SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvTransactionType = 'Contribution'
        ,drvAccountNumber = ''
        ,drvCreditAmount =  REPLACE((CONVERT(VARCHAR, CONVERT( DECIMAL(7,2),(PdhERCurAmt)) )),'.','')
        ,drvContributionType =  'Current Year Employer Contribution'
        ,drvSocialSecurity = eepSSN
        ,drvCreditAmountRaw = PdhEECurAmt

    FROM dbo.U_EOPTTRIHSA_EEList WITH (NOLOCK)
    INNER JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
    INNER JOIN dbo.U_EOPTTRIHSA_PDedHist
            on pdhEEID = xEEID
    WHERE PdhERCurAmt > 0





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
ALTER VIEW dbo.dsi_vwEOPTTRIHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EOPTTRIHSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EOPTTRIHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202002051'
       ,expStartPerControl     = '202002051'
       ,expLastEndPerControl   = '202002129'
       ,expEndPerControl       = '202002129'
WHERE expFormatCode = 'EOPTTRIHSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEOPTTRIHSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EOPTTRIHSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort