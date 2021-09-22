SET NOCOUNT ON;
IF OBJECT_ID('U_EFNBOGIEX2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFNBOGIEX2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFNBOGIEX2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFNBOGIEX2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFNBOGIEX2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFNBOGIEX2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFNBOGIEX2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFNBOGIEX2];
GO
IF OBJECT_ID('U_EFNBOGIEX2_File') IS NOT NULL DROP TABLE [dbo].[U_EFNBOGIEX2_File];
GO
IF OBJECT_ID('U_EFNBOGIEX2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFNBOGIEX2_EEList];
GO
IF OBJECT_ID('U_EFNBOGIEX2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EFNBOGIEX2_drvTbl];
GO
IF OBJECT_ID('U_EFNBOGIEX2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFNBOGIEX2_AuditFields];
GO
IF OBJECT_ID('U_EFNBOGIEX2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFNBOGIEX2_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFNBOGIEX2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFNBOGIEX2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFNBOGIEX2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFNBOGIEX2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFNBOGIEX2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFNBOGIEX2','FNB of Omaha General Interface V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EFNBOGIEX2Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFNBOGIEX2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee/HR ID"','1','(''DA''=''T,'')','EFNBOGIEX2Z0','50','H','01','1',NULL,'Employee/HR ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','2','(''DA''=''T,'')','EFNBOGIEX2Z0','50','H','01','2',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','3','(''DA''=''T,'')','EFNBOGIEX2Z0','50','H','01','3',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','4','(''DA''=''T,'')','EFNBOGIEX2Z0','50','H','01','4',NULL,'Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Partner ID"','5','(''DA''=''T,'')','EFNBOGIEX2Z0','50','H','01','5',NULL,'Partner ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub-Agent"','6','(''DA''=''T,'')','EFNBOGIEX2Z0','50','H','01','6',NULL,'Sub-Agent ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Role"','7','(''DA''=''T'')','EFNBOGIEX2Z0','50','H','01','7',NULL,'Role ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeHRID"','1','(''UA''=''T,'')','EFNBOGIEX2Z0','50','D','10','1',NULL,'Employee/HR ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','2','(''UA''=''T,'')','EFNBOGIEX2Z0','50','D','10','2',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','3','(''UA''=''T,'')','EFNBOGIEX2Z0','50','D','10','3',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','4','(''UA''=''T,'')','EFNBOGIEX2Z0','50','D','10','4',NULL,'Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"C12"','5','(''DA''=''T,'')','EFNBOGIEX2Z0','50','D','10','5',NULL,'Partner ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubAgent"','6','(''UA''=''T,'')','EFNBOGIEX2Z0','50','D','10','6',NULL,'Sub-Agent ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRole"','7','(''UA''=''T'')','EFNBOGIEX2Z0','50','D','10','7',NULL,'Role ',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EFNBOGIEX2_20210910.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'FNB of Omaha Gen Int FF Export','202110109','EMPEXPORT','FFile_XOE','Dec  8 2020  3:28PM','EFNBOGIEX2',NULL,NULL,NULL,'202110109','Dec  8 2020 12:00AM','Dec 30 1899 12:00AM','202110101','2208','','','202110101',dbo.fn_GetTimedKey(),NULL,'us3cPeRUN1001',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'FNB of Omaha Gen Int Export','202110109','EMPEXPORT','ONDEM_XOE','Nov 10 2020  1:34PM','EFNBOGIEX2',NULL,NULL,NULL,'202110109','Nov  9 2020  4:41PM','Nov  9 2020  4:41PM','202110101','38','','','202110101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N',',VELO7',NULL,NULL,NULL,'FNB of Omaha Gen Int Exp-Sched','202110109','EMPEXPORT','SCH_EFNBOG','Nov 10 2020  1:34PM','EFNBOGIEX2',NULL,NULL,NULL,'202110109','Nov  9 2020  4:41PM','Nov  9 2020  4:41PM','202110101','38','','','202110101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'FNB of Omaha Gen Int Exp-Test','202110109','EMPEXPORT','TEST_XOE','Nov 10 2020  1:34PM','EFNBOGIEX2',NULL,NULL,NULL,'202110109','Nov  9 2020  4:41PM','Nov  9 2020  4:41PM','202110101','38','','','202110101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'FNB of Omaha Gen Int FF Test','202110109','EMPEXPORT','TEST_XOEFF','Dec  4 2020  8:00PM','EFNBOGIEX2',NULL,NULL,NULL,'202110109','Nov 24 2020 12:00AM','Dec 30 1899 12:00AM','202110101','2215','','','202110101',dbo.fn_GetTimedKey(),NULL,'us3cPeRUN1001',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFNBOGIEX2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFNBOGIEX2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFNBOGIEX2','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFNBOGIEX2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFNBOGIEX2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EFNBOGIEX2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EFNBOGIEX2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EFNBOGIEX2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFNBOGIEX2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFNBOGIEX2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFNBOGIEX2','D10','dbo.U_EFNBOGIEX2_drvTbl',NULL);
IF OBJECT_ID('U_EFNBOGIEX2_Audit') IS NULL
CREATE TABLE [dbo].[U_EFNBOGIEX2_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audConSystemID] varchar(255) NULL,
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
    [audRowNo] bigint NULL,
    [audDedChange] varchar(1) NOT NULL,
    [audBenOptionChange] varchar(1) NOT NULL,
    [audSSNChange] varchar(1) NOT NULL,
    [audNameChange] varchar(1) NOT NULL,
    [audDemoChange] varchar(1) NOT NULL,
    [audAddrChange] varchar(1) NOT NULL,
    [audNewlyEnroll] varchar(1) NOT NULL,
    [audReEnroll] varchar(1) NOT NULL,
    [audTermPlan] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EFNBOGIEX2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFNBOGIEX2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EFNBOGIEX2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EFNBOGIEX2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeHRID] varchar(13) NULL,
    [drvNameFirst] varchar(8000) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvSubAgent] varchar(3) NULL,
    [drvRole] varchar(109) NULL
);
IF OBJECT_ID('U_EFNBOGIEX2_EEList') IS NULL
CREATE TABLE [dbo].[U_EFNBOGIEX2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFNBOGIEX2_File') IS NULL
CREATE TABLE [dbo].[U_EFNBOGIEX2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFNBOGIEX2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Running Supply

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 11/09/2020
Service Request Number: TekP-2020-10-01-0005

Purpose: FNB of Omaha General Interface Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFNBOGIEX2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFNBOGIEX2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFNBOGIEX2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFNBOGIEX2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFNBOGIEX2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFNBOGIEX2', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFNBOGIEX2', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFNBOGIEX2', 'SCH_EFNBOG';

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFNBOGIEX2', 'TEST_XOEFF';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFNBOGIEX2', 'FFile_XOE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFNBOGIEX2', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFNBOGIEX2';

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
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_EFNBOGIEX2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFNBOGIEX2_AuditFields;
    CREATE TABLE dbo.U_EFNBOGIEX2_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Dependent Information
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('Contacts','ConAddressCountry');
    -- Employee Deduction/Benefit Information
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('EmpDed','EedBenStopDate');
    -- Dependent Deduction/Benefit Information
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('DepBPlan','DbnBenStartDate');
    INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('DepBPlan','DbnBenStopDate');
    -- Deduction/Benefit Information
    --INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('DedCode','DedBenAmt');
    --INSERT INTO dbo.U_EFNBOGIEX2_AuditFields VALUES ('DedCode','DedBenAmtRateOrPct');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EFNBOGIEX2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFNBOGIEX2_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audConSystemID =  CASE WHEN audTableName = 'Contacts' THEN audKey3Value
                                WHEN audTableName = 'DepBPlan' THEN DbnDepRecID
                           END
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
        ,audDedChange = CASE WHEN audTableName IN ('EmpDed','DepBPlan','DedCode') THEN 'Y'
                             ELSE 'N'
                        END
        ,audBenOptionChange = CASE WHEN audFieldName IN ('EedBenOption') THEN 'Y'
                                   ELSE 'N'
                              END
        ,audSSNChange = CASE WHEN audFieldName IN ('EepSSN','ConSSN') THEN 'Y'
                              ELSE 'N'
                        END
        ,audNameChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Name%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers') AND audFieldName LIKE '%Prefix%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Suffix%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audDemoChange = CASE WHEN audFieldName IN ('EepGender','EepDateOfBirth','EepMaritalStatus','ConGender','ConDateOfBirth','ConRelationship') THEN 'Y'
                              ELSE 'N'
                         END
        ,audAddrChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Address%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audNewlyEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') = '' AND audNewValue = 'A' THEN 'Y'
                               ELSE 'N'
                          END
        ,audReEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') NOT IN ('A','') AND audNewValue = 'A' THEN 'Y'
                            WHEN audFieldName IN ('EedBenStartDate','DbnBenStartDate') AND ISNULL(audOldValue,'') <> '' AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
        ,audTermPlan = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND audOldValue = 'A' AND ISNULL(audNewValue,'') NOT IN ('A','') THEN 'Y'
                            WHEN audFieldName IN ('EedBenStopDate','DbnBenStopDate') AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
    INTO dbo.U_EFNBOGIEX2_Audit
    FROM dbo.U_EFNBOGIEX2_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_EFNBOGIEX2_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    /*AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
        OR (audTableName = 'EmpDed' AND audKey3Value IN (SELECT DedCode FROM dbo.U_EFNBOGIEX2_DedList))
        OR (audTableName = 'DepBPlan' AND audKey2Value IN (SELECT DedCode FROM dbo.U_EFNBOGIEX2_DedList))
    )*/
    ;

    --================
    -- Changes Only
    --================
    IF (@Exportcode NOT IN ('FULLFILE','OEACTIVE','OEPASSIVE', 'TEST_XOEFF', 'FFile_XOE' ,'SCH_EFNBOG'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_EFNBOGIEX2_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EFNBOGIEX2_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;












    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFNBOGIEX2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFNBOGIEX2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFNBOGIEX2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EFNBOGIEX2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFNBOGIEX2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' -- EecLocation -- EecJobCode + ' ** ' + ISNULL(EecUDField04, 'no 4') + ' :: ' + ISNULL(EecUDField05, 'no 5') + ' :: ' + ISNULL(EecUDField14, 'no 14') + ' :: ' + ISNULL(EecUDField15, 'no 15') 
        -- standard fields above and additional driver fields below
        ,drvEmployeeHRID = 'RUNN' + EecEmpNo
        ,drvNameFirst = REPLACE(REPLACE(REPLACE(EepNameFirst, '(', ''), ')', ''), '''', '')
        ,drvNameLast = EepNameLast
        ,drvEmailAddress = EepAddressEMail
        ,drvSubAgent =    CASE WHEN EecLocation IN ('LOC80') THEN '000' 
                            WHEN LEFT(EecLocation, 3) = 'LOC' THEN RIGHT('00' + RIGHT(RTRIM(EecLocation), LEN(RTRIM(EecLocation)) - 3), 3)
                        END                    
        ,drvRole =    CASE WHEN EecJobCode = 'STORMGR' THEN 'Sales:Administrator:Report Level 2'
                        --WHEN EecJObCode IN ('CASH','SALESASS','ASSTMGR','MIT','DEPTMGR','SERVWRIT','FIREARMS','SHOPTECH','SHOPMGR','SRCLK') THEN 'Sales' + RTRIM(CONCAT(':' + EecUDField04, ':' + EecUDField05, ':' + EecUDField14, ':' + EecUDField15))
                        WHEN EecJObCode IN ('CASH','SALESASS','ASSTMGR','MIT','DEPTMGR','SERVWRIT','FIREARMS','SHOPMGR','SRCLK','PRICING') THEN 'Sales' + RTRIM(CONCAT(':' + EecUDField04, ':' + EecUDField05, ':' + EecUDField14, ':' + EecUDField15))
                        
                        ELSE RTRIM(CONCAT(EecUDField04, ':' + EecUDField05, ':' + EecUDField14, ':' + EecUDField15))                            
                    END
    INTO dbo.U_EFNBOGIEX2_drvTbl
    FROM dbo.U_EFNBOGIEX2_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
    WHERE EecLocation NOT IN ('99','98','97','96','90')
        AND EecEmplStatus <> 'T'
        AND EecJobCode NOT IN ('SHOPTECH')
    ;

    DELETE dbo.U_EFNBOGIEX2_drvTbl WHERE drvRole IS NULL OR drvRole = '';


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
ALTER VIEW dbo.dsi_vwEFNBOGIEX2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFNBOGIEX2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFNBOGIEX2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101111'
       ,expStartPerControl     = '202101111'
       ,expLastEndPerControl   = '202101119'
       ,expEndPerControl       = '202101119'
WHERE expFormatCode = 'EFNBOGIEX2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFNBOGIEX2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFNBOGIEX2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort