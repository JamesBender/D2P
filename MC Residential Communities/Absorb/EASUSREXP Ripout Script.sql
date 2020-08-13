SET NOCOUNT ON;
IF OBJECT_ID('U_EABSUSREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EABSUSREXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EABSUSREXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EABSUSREXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEABSUSREXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEABSUSREXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EABSUSREXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EABSUSREXP];
GO
IF OBJECT_ID('U_EABSUSREXP_File') IS NOT NULL DROP TABLE [dbo].[U_EABSUSREXP_File];
GO
IF OBJECT_ID('U_EABSUSREXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EABSUSREXP_EEList];
GO
IF OBJECT_ID('U_EABSUSREXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EABSUSREXP_drvTbl];
GO
IF OBJECT_ID('U_EABSUSREXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EABSUSREXP_AuditFields];
GO
IF OBJECT_ID('U_EABSUSREXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EABSUSREXP_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EABSUSREXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EABSUSREXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EABSUSREXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EABSUSREXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EABSUSREXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EABSUSREXP','Absorb User Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EABSUSREXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ExternalID"','1','(''DA''=''T,'')','EABSUSREXPZ0','50','H','01','1',NULL,'ExternalID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FirstName"','2','(''DA''=''T,'')','EABSUSREXPZ0','50','H','01','2',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LastName"','3','(''DA''=''T,'')','EABSUSREXPZ0','50','H','01','3',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DepartmentLookup"','4','(''DA''=''T,'')','EABSUSREXPZ0','50','H','01','4',NULL,'DepartmentLookup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Username"','5','(''DA''=''T,'')','EABSUSREXPZ0','50','H','01','5',NULL,'Username',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmailAddress"','6','(''DA''=''T,'')','EABSUSREXPZ0','50','H','01','6',NULL,'EmailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Password"','7','(''DA''=''T,'')','EABSUSREXPZ0','50','H','01','7',NULL,'Password',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeNumber"','8','(''DA''=''T,'')','EABSUSREXPZ0','50','H','01','8',NULL,'EmployeeNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"JobTitle"','9','(''DA''=''T,'')','EABSUSREXPZ0','50','H','01','9',NULL,'JobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DateHired"','10','(''DA''=''T,'')','EABSUSREXPZ0','50','H','01','10',NULL,'DateHired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DateTerminated"','11','(''DA''=''T,'')','EABSUSREXPZ0','50','H','01','11',NULL,'DateTerminated',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SupervisorLookup"','12','(''DA''=''T'')','EABSUSREXPZ0','50','H','01','12',NULL,'SupervisorLookup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExternalID"','1','(''UA''=''T,'')','EABSUSREXPZ0','50','D','10','1',NULL,'ExternalID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','2','(''UA''=''T,'')','EABSUSREXPZ0','50','D','10','2',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','3','(''UA''=''T,'')','EABSUSREXPZ0','50','D','10','3',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgCode"','4','(''UA''=''T,'')','EABSUSREXPZ0','50','D','10','4',NULL,'DepartmentLookup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserName"','5','(''UA''=''T,'')','EABSUSREXPZ0','50','D','10','5',NULL,'Username',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','6','(''UA''=''T,'')','EABSUSREXPZ0','50','D','10','6',NULL,'EmailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPassword"','7','(''UA''=''T,'')','EABSUSREXPZ0','50','D','10','7',NULL,'Password',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','8','(''UA''=''T,'')','EABSUSREXPZ0','50','D','10','8',NULL,'EmployeeNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','9','(''UA''=''T,'')','EABSUSREXPZ0','50','D','10','9',NULL,'JobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateHired"','10','(''UA''=''T,'')','EABSUSREXPZ0','50','D','10','10',NULL,'DateHired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateTerminated"','11','(''UA''=''T,'')','EABSUSREXPZ0','50','D','10','11',NULL,'DateTerminated',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorId"','12','(''UA''=''T'')','EABSUSREXPZ0','50','D','10','12',NULL,'SupervisorLookup',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EABSUSREXP_20200224.txt',NULL,'','','',NULL,NULL,NULL,'Absorb User Export','201911289','EMPEXPORT','ONDEMAND','Nov 29 2019  4:04AM','EABSUSREXP',NULL,NULL,NULL,'201911289','Nov 28 2019 12:27PM','Nov 28 2019 12:27PM','201911281','229','','','201911281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EABSUSREXP_20200224.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','201911289','EMPEXPORT','SCHEDULED','Nov 29 2019  4:04AM','EABSUSREXP',NULL,NULL,NULL,'201911289','Nov 28 2019 12:27PM','Nov 28 2019 12:27PM','201911281','229','','','201911281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EABSUSREXP_20200224.txt',NULL,'','','DV8TQ',NULL,NULL,NULL,'Test Purposes Only','202002219','EMPEXPORT','TEST','Feb 21 2020  1:34PM','EABSUSREXP',NULL,NULL,NULL,'202002219','Feb 21 2020 12:00AM','Dec 30 1899 12:00AM','202002071','208','','','202002071',dbo.fn_GetTimedKey(),NULL,'us3lKiMCR1001A',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EABSUSREXP_20200224.txt' END WHERE expFormatCode = 'EABSUSREXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EABSUSREXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EABSUSREXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EABSUSREXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EABSUSREXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EABSUSREXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EABSUSREXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EABSUSREXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EABSUSREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EABSUSREXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EABSUSREXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EABSUSREXP','D10','dbo.U_EABSUSREXP_drvTbl',NULL);
IF OBJECT_ID('U_EABSUSREXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EABSUSREXP_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audEEID] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EABSUSREXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EABSUSREXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EABSUSREXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EABSUSREXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvExternalID] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvOrgCode] char(6) NOT NULL,
    [drvUserName] varchar(204) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvPassword] varchar(206) NULL,
    [drvEmpNo] char(11) NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvDateHired] nvarchar(4000) NULL,
    [drvDateTerminated] nvarchar(4000) NULL,
    [drvSupervisorId] char(9) NULL
);
IF OBJECT_ID('U_EABSUSREXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EABSUSREXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EABSUSREXP_File') IS NULL
CREATE TABLE [dbo].[U_EABSUSREXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EABSUSREXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: MC Residential Communities

Created By: James Bender
Business Analyst: Trena King
Create Date: 11/28/2019
Service Request Number: TekP-2019-08-30-001

Purpose: Absorb User Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EABSUSREXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EABSUSREXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EABSUSREXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EABSUSREXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EABSUSREXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EABSUSREXP', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EABSUSREXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EABSUSREXP';

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
    -- Create audit tables
    --==========================================
    IF OBJECT_ID('U_EABSUSREXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EABSUSREXP_AuditFields;
    CREATE TABLE dbo.U_EABSUSREXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EABSUSREXP_AuditFields VALUES ('empcomp','eecemplstatus');   
    IF OBJECT_ID('U_EABSUSREXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EABSUSREXP_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audEEID = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EABSUSREXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EABSUSREXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EABSUSREXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN DATEADD(DAY, -14, @StartDate) AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EABSUSREXP_Audit ON dbo.U_EABSUSREXP_Audit (audEEID, audKey2Value);


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EABSUSREXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EABSUSREXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EABSUSREXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EABSUSREXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EABSUSREXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvExternalID = CASE WHEN ISNULL(EecEmpNo, '') <> '' THEN EecEmpNo ELSE eepSSN END
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvOrgCode = OrgCode
        ,drvUserName = EepNameFirst + '.' + EepNameLast + '.MC'
        ,drvEmailAddress = EepAddressEMail
        ,drvPassword = EepNameFirst + '.' + EepNameLast + '.MC1!'
        ,drvEmpNo = CASE WHEN ISNULL(EecEmpNo, '') <> '' THEN EecEmpNo ELSE eepSSN END
        ,drvJobTitle = REPLACE(JbcDesc, ',', '')
        ,drvDateHired = FORMAT(EecDateOfOriginalHire, 'yyyy/MM/dd')
        ,drvDateTerminated = CASE WHEN ISNULL(EecDateOfTermination, '') <> '' THEN FORMAT(EecDateOfTermination, 'yyyy/MM/dd') END
        ,drvSupervisorId = (SELECT TOP 1 EecEmpNo FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEID = (SELECT EecSupervisorID FROM dbo.EmpComp WHERE EecEEID = xEEID)) -- Without this inner query it keeps assiging the same supervisor to all employees. I was not able to figure out why. -JCB
    INTO dbo.U_EABSUSREXP_drvTbl
    FROM dbo.U_EABSUSREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.OrgLevel WITH (NOLOCK)
        ON EecOrgLvl1 = OrgCode
    WHERE OrgCode NOT IN ('GARL')
        AND (EecEmplStatus <> 'T' OR EXISTS(SELECT 1 FROM dbo.U_EABSUSREXP_Audit WITH (NOLOCK) WHERE AudNewValue = 'T' and AudFieldName = 'EecEmplStatus' AND AudRowNo = 1 AND AudEEID = xEEID))
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
ALTER VIEW dbo.dsi_vwEABSUSREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EABSUSREXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EABSUSREXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911211'
       ,expStartPerControl     = '201911211'
       ,expLastEndPerControl   = '201911289'
       ,expEndPerControl       = '201911289'
WHERE expFormatCode = 'EABSUSREXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEABSUSREXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EABSUSREXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort