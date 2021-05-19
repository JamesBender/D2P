SET NOCOUNT ON;
IF OBJECT_ID('U_ETASYMPDEM_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETASYMPDEM_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETASYMPDEM_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETASYMPDEM' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETASYMPDEM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETASYMPDEM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETASYMPDEM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETASYMPDEM];
GO
IF OBJECT_ID('U_ETASYMPDEM_File') IS NOT NULL DROP TABLE [dbo].[U_ETASYMPDEM_File];
GO
IF OBJECT_ID('U_ETASYMPDEM_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETASYMPDEM_EEList];
GO
IF OBJECT_ID('U_ETASYMPDEM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETASYMPDEM_drvTbl];
GO
IF OBJECT_ID('U_ETASYMPDEM_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ETASYMPDEM_AuditFields];
GO
IF OBJECT_ID('U_ETASYMPDEM_Audit') IS NOT NULL DROP TABLE [dbo].[U_ETASYMPDEM_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETASYMPDEM';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETASYMPDEM';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETASYMPDEM';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETASYMPDEM';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETASYMPDEM';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETASYMPDEM','TASS Demographic Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ETASYMPDEMZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETASYMPDEM' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCode"','1','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','1',NULL,'EmployeeCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLName"','2','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','2',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFName"','3','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','3',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrefName"','4','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','4',NULL,'PreferredName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLegalName"','5','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','5',NULL,'LegalName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatus"','6','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','6',NULL,'EmployeeStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeOrgUnit2"','7','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','7',NULL,'HomeOrganizationUnit2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeJobClass"','8','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','8',NULL,'HomeJobClass',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeEmpCat"','9','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','9',NULL,'HomeEmployeeCategory',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeOrgUnit4"','10','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','10',NULL,'HomeOrganizationUnit4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeAppHours"','11','(''UNT2''=''T,'')','ETASYMPDEMZ0','50','D','10','11',NULL,'HomeApprovedHours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeEmpClass"','12','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','12',NULL,'HomeEmployeeClass',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeDailyHours"','13','(''UNT2''=''T,'')','ETASYMPDEMZ0','50','D','10','13',NULL,'HomeDailyHours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePayGroup"','14','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','14',NULL,'HomePayGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeFullTimeEquiv"','15','(''UNT2''=''T,'')','ETASYMPDEMZ0','50','D','10','15',NULL,'HomeFullTimeEquivalent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTitle"','16','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','16',NULL,'Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWhenHire"','17','(''UDMDY''=''T,'')','ETASYMPDEMZ0','50','D','10','17',NULL,'WhenHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCalcStandardDate"','18','(''UDMDY''=''T,'')','ETASYMPDEMZ0','50','D','10','18',NULL,'EmployeeCalculationsStandardDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCalcUserDefAlpha"','19','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','19',NULL,'EmployeeCalculationsUserDefinedAlpha',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoginName"','20','(''UA''=''T,'')','ETASYMPDEMZ0','50','D','10','20',NULL,'LoginName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWhenTerm"','21','(''UDMDY''=''T,'')','ETASYMPDEMZ0','50','D','10','21',NULL,'WhenTerminate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','22','(''UA''=''T'')','ETASYMPDEMZ0','50','D','10','22',NULL,'Email',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ETASYMPDEM_20210506.csv';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TASS Demographic Export','202105039','EMPEXPORT','CHANGES',NULL,'ETASYMPDEM',NULL,NULL,NULL,'202105039','May  3 2021  9:02PM','May  3 2021  9:02PM','202105031',NULL,'','','202105031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TASS Demographic Export','202105039','EMPEXPORT','FULLFILE',NULL,'ETASYMPDEM',NULL,NULL,NULL,'202105039','May  3 2021  9:02PM','May  3 2021  9:02PM','202105031',NULL,'','','202105031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TASS Demographic Export','202105039','EMPEXPORT','ONDEM_XOE',NULL,'ETASYMPDEM',NULL,NULL,NULL,'202105039','May  3 2021  9:02PM','May  3 2021  9:02PM','202105031',NULL,'','','202105031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TASS Demographic Export-Sched','202105039','EMPEXPORT','SCH_ETASYM',NULL,'ETASYMPDEM',NULL,NULL,NULL,'202105039','May  3 2021  9:02PM','May  3 2021  9:02PM','202105031',NULL,'','','202105031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'TASS Demographic Export-Test','202105039','EMPEXPORT','TEST_XOE',NULL,'ETASYMPDEM',NULL,NULL,NULL,'202105039','May  3 2021  9:02PM','May  3 2021  9:02PM','202105031',NULL,'','','202105031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASYMPDEM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASYMPDEM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASYMPDEM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETASYMPDEM','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ETASYMPDEM' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ETASYMPDEM' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ETASYMPDEM_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETASYMPDEM_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETASYMPDEM','D10','dbo.U_ETASYMPDEM_drvTbl',NULL);
IF OBJECT_ID('U_ETASYMPDEM_Audit') IS NULL
CREATE TABLE [dbo].[U_ETASYMPDEM_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audKey1] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audEffectiveDate] smalldatetime NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_ETASYMPDEM_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ETASYMPDEM_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ETASYMPDEM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETASYMPDEM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpCode] char(9) NULL,
    [drvLName] varchar(100) NULL,
    [drvFName] varchar(100) NULL,
    [drvPrefName] varchar(100) NULL,
    [drvLegalName] varchar(201) NULL,
    [drvEmpStatus] char(1) NULL,
    [drvHomeOrgUnit2] varchar(6) NOT NULL,
    [drvHomeJobClass] varchar(3) NOT NULL,
    [drvHomeEmpCat] char(1) NULL,
    [drvHomeOrgUnit4] varchar(25) NULL,
    [drvHomeAppHours] decimal NULL,
    [drvHomeEmpClass] char(1) NULL,
    [drvHomeDailyHours] decimal NULL,
    [drvHomePayGroup] varchar(6) NOT NULL,
    [drvHomeFullTimeEquiv] decimal NULL,
    [drvTitle] varchar(25) NOT NULL,
    [drvWhenHire] datetime NULL,
    [drvEmpCalcStandardDate] datetime NULL,
    [drvEmpCalcUserDefAlpha] varchar(25) NULL,
    [drvLoginName] varchar(50) NULL,
    [drvWhenTerm] varchar(8000) NOT NULL,
    [drvEmail] varchar(50) NULL
);
IF OBJECT_ID('U_ETASYMPDEM_EEList') IS NULL
CREATE TABLE [dbo].[U_ETASYMPDEM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETASYMPDEM_File') IS NULL
CREATE TABLE [dbo].[U_ETASYMPDEM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETASYMPDEM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Symplr

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 05/03/2021
Service Request Number: TekP-2021-03-18-0003

Purpose: TASS Demographic Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETASYMPDEM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETASYMPDEM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETASYMPDEM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETASYMPDEM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETASYMPDEM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASYMPDEM', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASYMPDEM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASYMPDEM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASYMPDEM', 'SCH_ETASYM'
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETASYMPDEM', 'CHANGES'
;

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETASYMPDEM';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETASYMPDEM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETASYMPDEM';

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
    DELETE FROM dbo.U_ETASYMPDEM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETASYMPDEM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_ETASYMPDEM_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ETASYMPDEM_AuditFields;
    CREATE TABLE dbo.U_ETASYMPDEM_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpPers','EepAddressEmail');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('JobCode','JbcDesc');
    INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('Location','LocDesc');
    -- Deduction/Benefit Information
    --INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('DedCode','DedBenAmt');
    --INSERT INTO dbo.U_ETASYMPDEM_AuditFields VALUES ('DedCode','DedBenAmtRateOrPct');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ETASYMPDEM_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ETASYMPDEM_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_ETASYMPDEM_Audit
    FROM dbo.U_ETASYMPDEM_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_ETASYMPDEM_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
    );

    --================
    -- Changes Only
    --================
    IF (@Exportcode NOT IN ('ONDEM_XOE','TEST_XOE','SCH_ETASYM', 'FULLFILE'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_ETASYMPDEM_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ETASYMPDEM_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ETASYMPDEM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETASYMPDEM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETASYMPDEM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmpCode = EecEmpNo
        ,drvLName = EepNameLast
        ,drvFName = EepNameFirst
        ,drvPrefName = EepNamePreferred
        ,drvLegalName = LTRIM(RTRIM(EepNameFirst)) + ' ' + LTRIM(RTRIM(EepNameLast))
        ,drvEmpStatus = EecEmplStatus
        ,drvHomeOrgUnit2 = 'Symplr'
        ,drvHomeJobClass = '100'
        ,drvHomeEmpCat = CodDesc
        ,drvHomeOrgUnit4 = O1.OrgDesc
        ,drvHomeAppHours = EecScheduledWorkHrs
        ,drvHomeEmpClass = EecFullTimeOrPartTime
        ,drvHomeDailyHours = EecScheduledWorkHrs / 10
        ,drvHomePayGroup = 'Symplr'
        ,drvHomeFullTimeEquiv = EecScheduledWorkHrs / 80
        ,drvTitle = REPLACE(JbcDesc, ',', '')
        ,drvWhenHire = EecDateOfOriginalHire
        ,drvEmpCalcStandardDate = EecDateOfLastHire
        ,drvEmpCalcUserDefAlpha = LocDesc
        ,drvLoginName = EepAddressEmail
        ,drvWhenTerm = ISNULL((CASE WHEN EecEmplStatus = 'T' THEN REPLACE(CONVERT (CHAR(10), EecDateOfTermination, 101),'/','') END), '') 
        ,drvEmail = EepAddressEMail
    INTO dbo.U_ETASYMPDEM_drvTbl
    FROM dbo.U_ETASYMPDEM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        AND EXISTS(select 1 from dbo.U_ETASYMPDEM_Audit where  audKey1 = xEEID AND audKey2 = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH(NOLOCK)
        ON LocCode = EecLocation
    OUTER APPLY (SELECT TOP 1 * FROM dbo.EmpHJob WITH(NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID ORDER BY EjhJobEffDate DESC) E
    --LEFT JOIN (SELECT EjhEEID, EjhCOID, EjhFLSACategory, MAX(EjhJobEffDate) AS EjhJobEffDate
    --        FROM dbo.EmpHJob WITH(NOLOCK)
    --        GROUP BY EjhEEID, EjhCOID, EjhFLSACategory) E ON E.EjhEEID = xEEID AND E.EjhCOID = xCOID
    LEFT JOIN dbo.Codes WITH(NOLOCK)
        ON CodCode = E.EjhFLSACategory
        AND CodTable = 'FLSATYPE'
    LEFT JOIN dbo.OrgLevel O1 WITH(NOLOCK) 
        ON EecOrgLvl1 = O1.OrgCode AND O1.OrgLvl = '1'
    LEFT JOIN dbo.U_ETASYMPDEM_Audit WITH(NOLOCK)
        ON audEEID = xEEID
        AND audCOID = xCOID
    WHERE EecEEType <> 'TES'
    AND EecPayGroup = '000001'  -- Groups to exclude, "everyone not in eecpaygroup = '000001'

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
ALTER VIEW dbo.dsi_vwETASYMPDEM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETASYMPDEM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETASYMPDEM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202104261'
       ,expStartPerControl     = '202104261'
       ,expLastEndPerControl   = '202105039'
       ,expEndPerControl       = '202105039'
WHERE expFormatCode = 'ETASYMPDEM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETASYMPDEM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETASYMPDEM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort