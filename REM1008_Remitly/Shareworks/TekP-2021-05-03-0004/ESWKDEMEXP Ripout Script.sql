SET NOCOUNT ON;
IF OBJECT_ID('U_ESWKDEMEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESWKDEMEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESWKDEMEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESWKDEMEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESWKDEMEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESWKDEMEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESWKDEMEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESWKDEMEXP];
GO
IF OBJECT_ID('U_ESWKDEMEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ESWKDEMEXP_File];
GO
IF OBJECT_ID('U_ESWKDEMEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESWKDEMEXP_EEList];
GO
IF OBJECT_ID('U_ESWKDEMEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESWKDEMEXP_drvTbl];
GO
IF OBJECT_ID('U_ESWKDEMEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESWKDEMEXP_AuditFields];
GO
IF OBJECT_ID('U_ESWKDEMEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESWKDEMEXP_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESWKDEMEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESWKDEMEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESWKDEMEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESWKDEMEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESWKDEMEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESWKDEMEXP','Shareworks Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ESWKDEMEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESWKDEMEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','1','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','1',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','2','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','3','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','3',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','4','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FALSE"','5','(''DA''=''T,'')','ESWKDEMEXPZ0','50','D','10','5',NULL,'Is A Corporate Entity?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','6','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','6',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInternationalSIN"','7','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','6',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCandaSIN"','8','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','6',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','9','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','9',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvDateOfBirth"','10','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','10',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyEmail"','11','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','11',NULL,'Company Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''T,'')','ESWKDEMEXPZ0','250','D','10','12',NULL,'Home Address || Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''T,'')','ESWKDEMEXPZ0','250','D','10','13',NULL,'Home Address || Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','14',NULL,'Home Address || City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','15',NULL,'Home Address || State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','16','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','16',NULL,'Home Address || Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','17',NULL,'Home Address || ZIP/Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartment"','18','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','18',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEntityRepOffice"','19','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','19',NULL,'Entity/Rep Office',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStockOptionStatus"','20','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','20',NULL,'Stock Options and Awards Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStockOptionDate"','21','(''UA''=''T,'')','ESWKDEMEXPZ0','50','D','10','21',NULL,'Stock Options and Awards Employee Status (Effectiv',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T'')','ESWKDEMEXPZ0','50','D','10','22',NULL,'Termination Reason/Type',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ESWKDEMEXP_20210830.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Shareworks Demo Export','202106289','EMPEXPORT','ONDEM_XOE','Aug 10 2021 11:32AM','ESWKDEMEXP',NULL,NULL,NULL,'202106289','Jun 28 2021  5:47AM','Jun 28 2021  5:47AM','202106281','1752','','','202106281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Shareworks Demo Export-Sched','202106289','EMPEXPORT','SCH_ESWKDE',NULL,'ESWKDEMEXP',NULL,NULL,NULL,'202106289','Jun 28 2021  5:47AM','Jun 28 2021  5:47AM','202106281',NULL,'','','202106281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Shareworks Demo Export-Test','202108261','EMPEXPORT','TEST_XOE','Aug 26 2021  7:16PM','ESWKDEMEXP',NULL,NULL,NULL,'202108261','Aug 26 2021 12:00AM','Dec 30 1899 12:00AM','202108191','1789','','','202108191',dbo.fn_GetTimedKey(),NULL,'us3cPeREM1008',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWKDEMEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWKDEMEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWKDEMEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWKDEMEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWKDEMEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ESWKDEMEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ESWKDEMEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ESWKDEMEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESWKDEMEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESWKDEMEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESWKDEMEXP','D10','dbo.U_ESWKDEMEXP_drvTbl',NULL);
IF OBJECT_ID('U_ESWKDEMEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ESWKDEMEXP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ESWKDEMEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESWKDEMEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ESWKDEMEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESWKDEMEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeNumber] varchar(9) NULL,
    [drvNameFirst] varchar(8000) NULL,
    [drvNameMiddle] varchar(8000) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvSSN] char(11) NULL,
    [drvInternationalSIN] varchar(50) NULL,
    [drvCandaSIN] varchar(50) NULL,
    [drvDateOfHire] varchar(8000) NULL,
    [DrvDateOfBirth] varchar(8000) NULL,
    [drvCompanyEmail] varchar(50) NULL,
    [drvAddressLine1] varchar(81) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressCountry] varchar(45) NULL,
    [drvAddressZipCode] varchar(52) NULL,
    [drvDepartment] varchar(10) NULL,
    [drvEntityRepOffice] varchar(10) NULL,
    [drvStockOptionStatus] varchar(16) NULL,
    [drvStockOptionDate] varchar(8000) NULL
);
IF OBJECT_ID('U_ESWKDEMEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ESWKDEMEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESWKDEMEXP_File') IS NULL
CREATE TABLE [dbo].[U_ESWKDEMEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESWKDEMEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Remitly

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 06/28/2021
Service Request Number: TekP-2020-11-18-0001

Purpose: Shareworks Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESWKDEMEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESWKDEMEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESWKDEMEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESWKDEMEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESWKDEMEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESWKDEMEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESWKDEMEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESWKDEMEXP', 'SCH_ESWKDE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESWKDEMEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESWKDEMEXP';

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
    DELETE FROM dbo.U_ESWKDEMEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESWKDEMEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ESWKDEMEXP_EEList WHERE xEEID NOT IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('REG','Z')--('STU','SUM','TES','TMP','CON')
    );

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESWKDEMEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESWKDEMEXP_AuditFields;
    CREATE TABLE dbo.U_ESWKDEMEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ESWKDEMEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESWKDEMEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESWKDEMEXP_Audit;
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
    INTO dbo.U_ESWKDEMEXP_Audit
    FROM dbo.U_ESWKDEMEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_ESWKDEMEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(DAY, -90, @EndDate) AND @EndDate
    AND audAction <> 'DELETE'
    AND audNewValue = 'T'
    --AND ISNULL(audNewValue,'') <> '';

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESWKDEMEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESWKDEMEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESWKDEMEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeNumber = SUBSTRING(EecEmpNo, PATINDEX('%[^0]%', EecEmpNo+'.'), LEN(EecEmpNo)) -- EecEmpNo
        ,drvNameFirst = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameFirst, 'ñ', 'n'), 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u')
        ,drvNameMiddle = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameMiddle, 'ñ', 'n'), 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u')
        ,drvNameLast = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameLast, 'ñ', 'n'), 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u')
        ,drvSSN = eepSSN
        ,drvInternationalSIN = CASE WHEN EepAddressCountry <> 'CAN' THEN EinNationalId END
        ,drvCandaSIN = CASE WHEN EepAddressCountry = 'CAN' THEN EinNationalId END
        ,drvDateOfHire = REPLACE(CONVERT(CHAR(11), /*EecDateOfOriginalHire*/ EecDateOfLastHire, 106), ' ', '-')
        ,DrvDateOfBirth = REPLACE(CONVERT(CHAR(11), EepDateOfBirth, 106), ' ', '-')
        ,drvCompanyEmail = EepAddressEMail
        ,drvAddressLine1 = LEFT(REPLACE(LEFT('"' + REPLACE(REPLACE(REPLACE(EepAddressLine1, '"', ''), '”', ''), '“', ''), 127), 'ñ', 'n'), 80) + '"'
        --,drvAddressLine2 = '"' + CASE WHEN LEN(EepAddressLine1) > 80  THEN SUBSTRING(REPLACE(LEFT(REPLACE(REPLACE(REPLACE(EepAddressLine1, '"', ''), '”', ''), '“', ''), 127) + '"', 'ñ', 'n'), 80, (LEN(EepAddressLine1) - 80) + 1) + ' ' ELSE '' END 
        ,drvAddressLine2 = '"' + CASE WHEN LEN(EepAddressLine1) > 80  THEN SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine1, '"', ''), '”', ''), '“', ''), 'ñ', 'n'), 80, (LEN(EepAddressLine1) - 80) + 1) + ' ' ELSE '' END 
                 + CASE WHEN EepAddressLine2 IS NOT NULL THEN REPLACE(REPLACE(RTRIM(EepAddressLine2), '"', ''), 'ñ', 'n') ELSE '' END + '"'
        ,drvAddressCity = '"' + REPLACE(EepAddressCity, 'ñ', 'n') + '"'
        ,drvAddressState = EepAddressState
        ,drvAddressCountry = CodDesc --EepAddressCountry
        ,drvAddressZipCode = CASE WHEN ISNULL(EepAddressZipCode, '') <> '' THEN '"' + RTRIM(EepAddressZipCode) + '"' ELSE 'N/A' END
        ,drvDepartment = EecOrgLvl1
        ,drvEntityRepOffice = EecOrgLvl2 --'"' + REPLACE(OrgDesc2, ',','') + '"' -- '"' + CmpCompanyName + '"'
        ,drvStockOptionStatus = CASE WHEN EecEmplStatus = 'A' THEN 'Active'                                    
                                    WHEN EecEmplStatus = 'L' THEN 'Leave of Absence'
                                    WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN 'Rehire'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'Retired'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'Death'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '215' THEN 'Disability'
                                    WHEN EecEmplStatus = 'T' THEN 'Termination'
                                END
        ,drvStockOptionDate = REPLACE(CONVERT(CHAR(11), 
                                                        CASE WHEN EecEmplStatus = 'T' AND EjhReason <> 'TRO' THEN EecDateOfTermination 
                                                            WHEN EecEmplStatus = 'T' AND EjhReason = 'TRO' THEN EecDateOfLastHire 
                                                            WHEN EecEmplStatus <> 'T' THEN EecDateOfLastHire  END, 106), ' ', '-')
    INTO dbo.U_ESWKDEMEXP_drvTbl
    FROM dbo.U_ESWKDEMEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON xCOID = CmpCOID
    JOIN dbo.Codes WITH (NOLOCK)
        ON CodTable = 'COUNTRY'
        AND EepAddressCountry = CodCode
    LEFT JOIN (
            SELECT DISTINCT OrgCode AS OrgCode2, OrgDesc AS OrgDesc2, OrgManagerId AS OrgManagerId2
            FROM dbo.vw_int_OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 2
            ) AS Org2
        ON OrgCode2 = EecOrgLvl2
    LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhReason
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhReason, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)) AS InnerEjh
                WHERE RN = 1) AS Ejh
        ON EjhEEID = xEEID
        AND EjhCoID    = xCOID
    LEFT JOIN dbo.U_ESWKDEMEXP_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
    LEFT JOIN dbo.EmpIntl
        ON EinEEID = xEEID
    WHERE --EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN AudDateTime AND @EndDate)
        (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL)) -- AND EecDateOfTermination BETWEEN AudDateTime AND @EndDate))
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
ALTER VIEW dbo.dsi_vwESWKDEMEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESWKDEMEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESWKDEMEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106211'
       ,expStartPerControl     = '202106211'
       ,expLastEndPerControl   = '202106289'
       ,expEndPerControl       = '202106289'
WHERE expFormatCode = 'ESWKDEMEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESWKDEMEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESWKDEMEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort