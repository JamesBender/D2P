SET NOCOUNT ON;
IF OBJECT_ID('U_EFACCIGHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFACCIGHSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFACCIGHSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFACCIGHSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFACCIGHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFACCIGHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFACCIGHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFACCIGHSA];
GO
IF OBJECT_ID('U_EFACCIGHSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFACCIGHSA_PDedHist];
GO
IF OBJECT_ID('U_EFACCIGHSA_Header') IS NOT NULL DROP TABLE [dbo].[U_EFACCIGHSA_Header];
GO
IF OBJECT_ID('U_EFACCIGHSA_File') IS NOT NULL DROP TABLE [dbo].[U_EFACCIGHSA_File];
GO
IF OBJECT_ID('U_EFACCIGHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFACCIGHSA_EEList];
GO
IF OBJECT_ID('U_EFACCIGHSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EFACCIGHSA_drvTbl];
GO
IF OBJECT_ID('U_EFACCIGHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFACCIGHSA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EFACCIGHSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFACCIGHSA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFACCIGHSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFACCIGHSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFACCIGHSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFACCIGHSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFACCIGHSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFACCIGHSA','Cigna HSA Payroll','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EFACCIGHSAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFACCIGHSA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFACCIGHSAZ0','50','H','01','1',NULL,'drvFEDID',NULL,NULL,'"drvFEDID "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFACCIGHSAZ0','50','H','01','2',NULL,'drvClearingAccount',NULL,NULL,'"drvClearingAccount "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFACCIGHSAZ0','50','H','01','3',NULL,'drvEmail',NULL,NULL,'"drvEmail "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFACCIGHSAZ0','50','H','01','4',NULL,'drvDate',NULL,NULL,'"drvDate"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFACCIGHSAZ0','50','H','01','5',NULL,'drvNumberofDetailRecords',NULL,NULL,'"drvNumberofDetailRecords"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFACCIGHSAZ0','50','H','01','6',NULL,' drvAmount',NULL,NULL,'" drvAmount "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFACCIGHSAZ0','50','H','01','7',NULL,'drvSource',NULL,NULL,'"drvSource"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFACCIGHSAZ0','50','D','10','1',NULL,'drvLastName',NULL,NULL,'"drvLastName "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFACCIGHSAZ0','50','D','10','2',NULL,'drvFirstName',NULL,NULL,'"drvFirstName "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFACCIGHSAZ0','50','D','10','3',NULL,'drvAccountNumber',NULL,NULL,'"drvAccountNumber "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFACCIGHSAZ0','50','D','10','4',NULL,'drvSSN',NULL,NULL,'"drvSSN "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFACCIGHSAZ0','50','D','10','5',NULL,'drvTransactionAmount',NULL,NULL,'"drvTransactionAmount "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFACCIGHSAZ0','50','D','10','6',NULL,'drvTransactionType',NULL,NULL,'"drvTransactionType "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFACCIGHSAZ0','50','D','10','7',NULL,'drvDescription',NULL,NULL,'"drvDescription"','(''UA''=''T'')');
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EFACCIGHSA_20210617.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,'Cigna HSA Payroll','202106149','EMPEXPORT','ONDEM_XOE',NULL,'EFACCIGHSA',NULL,NULL,NULL,'202106149','Jun 14 2021 11:32PM','Jun 14 2021 11:32PM','202106141',NULL,'','','202106141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,'Cigna HSA Payroll-Sched','202106149','EMPEXPORT','SCH_EFACCI',NULL,'EFACCIGHSA',NULL,NULL,NULL,'202106149','Jun 14 2021 11:32PM','Jun 14 2021 11:32PM','202106141',NULL,'','','202106141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,'Cigna HSA Payroll-Test','202106159','EMPEXPORT','TEST_XOE','Jun 16 2021  3:50PM','EFACCIGHSA',NULL,NULL,NULL,'202106159','Jun 15 2021 12:00AM','Dec 30 1899 12:00AM','202106041','42','','','202106041',dbo.fn_GetTimedKey(),NULL,'us3lKiFAC1003','7K7IY,SEB2U,YCU16,ZYKDT,OSAZ5',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFACCIGHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFACCIGHSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFACCIGHSA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFACCIGHSA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFACCIGHSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFACCIGHSA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EFACCIGHSA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EFACCIGHSA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EFACCIGHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFACCIGHSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFACCIGHSA','H01','dbo.U_EFACCIGHSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFACCIGHSA','D10','dbo.U_EFACCIGHSA_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EFACCIGHSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFACCIGHSA] (
    [BdmRecType] varchar(3) NOT NULL,
    [BdmCOID] char(5) NULL,
    [BdmEEID] char(12) NOT NULL,
    [BdmDepRecID] char(12) NULL,
    [BdmSystemID] char(12) NULL,
    [BdmRunID] varchar(32) NULL,
    [BdmDedRowStatus] varchar(256) NULL,
    [BdmRelationship] char(3) NULL,
    [BdmDateOfBirth] datetime NULL,
    [BdmDedCode] char(5) NULL,
    [BdmDedType] varchar(32) NULL,
    [BdmBenOption] char(6) NULL,
    [BdmBenStatus] char(1) NULL,
    [BdmBenStartDate] datetime NULL,
    [BdmBenStopDate] datetime NULL,
    [BdmBenStatusDate] datetime NULL,
    [BdmBenOptionDate] datetime NULL,
    [BdmChangeReason] char(6) NULL,
    [BdmStartDate] datetime NULL,
    [BdmStopDate] datetime NULL,
    [BdmIsCobraCovered] char(1) NULL,
    [BdmCobraReason] char(6) NULL,
    [BdmDateOfCOBRAEvent] datetime NULL,
    [BdmIsPQB] char(1) NULL,
    [BdmIsChildOldest] char(1) NULL,
    [BdmUSGField1] varchar(256) NULL,
    [BdmUSGField2] varchar(256) NULL,
    [BdmUSGDate1] datetime NULL,
    [BdmUSGDate2] datetime NULL,
    [BdmTVStartDate] datetime NULL,
    [BdmSessionID] varchar(32) NULL,
    [BdmEEAmt] money NULL,
    [BdmEECalcRateOrPct] decimal NULL,
    [BdmEEGoalAmt] money NULL,
    [BdmEEMemberOrCaseNo] char(40) NULL,
    [BdmERAmt] money NULL,
    [BdmNumSpouses] int NULL,
    [BdmNumChildren] int NULL,
    [BdmNumDomPartners] int NULL,
    [BdmNumDPChildren] int NULL
);
IF OBJECT_ID('U_EFACCIGHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EFACCIGHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFACCIGHSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EFACCIGHSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvAccountNumber] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvTransactionAmount] varchar(30) NULL,
    [drvTransactionType] varchar(2) NULL,
    [drvTransactionAmountRaw] numeric NULL,
    [drvDescription] varchar(46) NULL
);
IF OBJECT_ID('U_EFACCIGHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EFACCIGHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFACCIGHSA_File') IS NULL
CREATE TABLE [dbo].[U_EFACCIGHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EFACCIGHSA_Header') IS NULL
CREATE TABLE [dbo].[U_EFACCIGHSA_Header] (
    [drvFEDID] char(9) NULL,
    [drvClearingAccount] varchar(10) NOT NULL,
    [drvEmail] varchar(20) NOT NULL,
    [drvDate] datetime NOT NULL,
    [drvNumberofDetailRecords] int NULL,
    [drvAmount] varchar(8000) NULL,
    [drvSource] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EFACCIGHSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFACCIGHSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhSource] varchar(2) NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFACCIGHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Factor Systems

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 06/14/2021
Service Request Number: TekP-2021-05-03-0006

Purpose: Cigna HSA Payroll

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFACCIGHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFACCIGHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFACCIGHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFACCIGHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFACCIGHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFACCIGHSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFACCIGHSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFACCIGHSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFACCIGHSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFACCIGHSA', 'SCH_EFACCI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFACCIGHSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFACCIGHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFACCIGHSA';

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
    DELETE FROM dbo.U_EFACCIGHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFACCIGHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSA,HSAER';

    IF OBJECT_ID('U_EFACCIGHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFACCIGHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFACCIGHSA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


   

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFACCIGHSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFACCIGHSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhSource      =  CASE WHEN PdhDedCode = 'HSA' THEN 'EX' 
                                WHEN PdhDedCode = 'HSAER' THEN'ER'
                           END
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
    INTO dbo.U_EFACCIGHSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFACCIGHSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID,CASE WHEN PdhDedCode = 'HSA' THEN 'EX' 
                                WHEN PdhDedCode = 'HSAER' THEN'ER'
                           END
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );
    
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFACCIGHSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EFACCIGHSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFACCIGHSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvAccountNumber = ''
        ,drvSSN = eepSSN
        ,drvTransactionAmount = CAST(CASE WHEN PdhSource = 'EX' THEN REPLACE( CAST(CONVERT(DECIMAL(12,2),PdhEECurAmt) as varchar),'.','')
                                                WHEN PdhSource = 'ER' THEN REPLACE(CAST(CONVERT(DECIMAL(12,2),PdhEECurAmt) as varchar),'.','')
                                END as varchar)
        ,drvTransactionType = PdhSource
        ,drvTransactionAmountRaw = CASE WHEN PdhSource = 'EX' THEN PdhEECurAmt
                                            WHEN PdhSource = 'ER' THEN PdhEECurAmt
                                   END
        ,drvDescription = CASE WHEN PdhSource = 'EX' THEN 'EE CONTRIBUTION ' + CAST(YEAR(@StartDate) as varchar)
                                            WHEN PdhSource = 'ER' THEN  'ER CONTRIBUTION ' + CAST(YEAR(@StartDate) as varchar)
                                   END 
    INTO dbo.U_EFACCIGHSA_drvTbl
    FROM dbo.U_EFACCIGHSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EFACCIGHSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID 
    ;

    Delete from dbo.U_EFACCIGHSA_drvTbl where drvTransactionAmount = '000'
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EFACCIGHSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EFACCIGHSA_Header;
    SELECT DISTINCT
         drvFEDID = (Select top 1 CmmFedtaxId from dbo.CompMast)
        ,drvClearingAccount = '8000281617'
        ,drvEmail = 'lhines@billtrust.com'
        ,drvDate = GETDATE()
        ,drvNumberofDetailRecords = (Select count(*) from dbo.U_EFACCIGHSA_drvTbl)
        ,drvAmount = REPLACE(CAST((Select sum(drvTransactionAmountRaw) from dbo.U_EFACCIGHSA_drvTbl) as varchar),'.','')
        ,drvSource = 'ACH'
    INTO dbo.U_EFACCIGHSA_Header
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
ALTER VIEW dbo.dsi_vwEFACCIGHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFACCIGHSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFACCIGHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106071'
       ,expStartPerControl     = '202106071'
       ,expLastEndPerControl   = '202106149'
       ,expEndPerControl       = '202106149'
WHERE expFormatCode = 'EFACCIGHSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFACCIGHSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFACCIGHSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort