SET NOCOUNT ON;
IF OBJECT_ID('U_EEGENCUKEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEGENCUKEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EEGENCUKEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EEGENCUKEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEEGENCUKEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEGENCUKEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEGENCUKEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEGENCUKEX];
GO
IF OBJECT_ID('U_EEGENCUKEX_File') IS NOT NULL DROP TABLE [dbo].[U_EEGENCUKEX_File];
GO
IF OBJECT_ID('U_EEGENCUKEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEGENCUKEX_EEList];
GO
IF OBJECT_ID('U_EEGENCUKEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEGENCUKEX_drvTbl];
GO
IF OBJECT_ID('U_EEGENCUKEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EEGENCUKEX_AuditFields];
GO
IF OBJECT_ID('U_EEGENCUKEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EEGENCUKEX_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEGENCUKEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEGENCUKEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEGENCUKEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEGENCUKEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEGENCUKEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EEGENCUKEX','Egencia UK Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EEGENCUKEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Username"','1','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','1',NULL,'Username',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email"','2','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','2',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Single Sign On Id"','3','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','3',NULL,'Single Sign On Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Status"','4','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','4',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Title"','5','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','5',NULL,'Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','6','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle name"','7','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','7',NULL,'Middle name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last name"','8','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','8',NULL,'Last name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Travel Group"','9','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','9',NULL,'Travel Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Traveler"','10','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','10',NULL,'Traveler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department code"','11','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','11',NULL,'Department code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cost Center"','12','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','12',NULL,'Cost Center',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','13','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','13',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Code"','14','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','14',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Name"','15','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','15',NULL,'Supervisor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Out of Policy Notifiers"','16','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','16',NULL,'Out of Policy Notifiers',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Notifiers"','17','(''DA''=''T,'')','EEGENCUKEXZ0','50','H','01','17',NULL,'Additional Notifiers',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','18','(''DA''=''T'')','EEGENCUKEXZ0','50','H','01','18',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserName"','1','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','1',NULL,'Usernames',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','2','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','2',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSingleSignOn"','3','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','3',NULL,'Single Sign On Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','4','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','4',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTitle"','5','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','5',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','7',NULL,'Middle name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','8',NULL,'Last name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"General Traveler Group"','9','(''DA''=''T,'')','EEGENCUKEXZ0','50','D','10','9',NULL,'Travel Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Traveler"','10','(''DA''=''T,'')','EEGENCUKEXZ0','50','D','10','10',NULL,'Traveler Role',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentCode"','11','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','11',NULL,'Department code (Legal Entity)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCostCenter"','12','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','12',NULL,'Cost Center',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','13','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','13',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationCode"','14','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','14',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorName"','15','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','15',NULL,'Supervisor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DL-EgenciaNotifications@lairdconnect.com"','16','(''DA''=''T,'')','EEGENCUKEXZ0','50','D','10','16',NULL,'Out of Policy Notifiers',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalNotifiers"','17','(''UA''=''T,'')','EEGENCUKEXZ0','50','D','10','17',NULL,'Additional Notifiers',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeId"','18','(''UA''=''T'')','EEGENCUKEXZ0','50','D','10','18',NULL,'Employee ID',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEGENCUKEX_20200811.txt',NULL,'','','',NULL,NULL,NULL,'Egencia UK Export','202007279','EMPEXPORT','ONDEMAND','Jul 30 2020  2:13PM','EEGENCUKEX',NULL,NULL,NULL,'202007279','Jul 27 2020 11:54AM','Jul 27 2020 11:54AM','202007271','29','','','202007271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEGENCUKEX_20200811.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202007279','EMPEXPORT','SCHEDULED','Jul 30 2020  2:13PM','EEGENCUKEX',NULL,NULL,NULL,'202007279','Jul 27 2020 11:54AM','Jul 27 2020 11:54AM','202007271','29','','','202007271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEGENCUKEX_20200811.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202008069','EMPEXPORT','TEST','Aug  6 2020  3:18PM','EEGENCUKEX',NULL,NULL,NULL,'202008069','Aug  6 2020 12:00AM','Dec 30 1899 12:00AM','202007271','29','','','202007271',dbo.fn_GetTimedKey(),NULL,'us3lKiLAI1002',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EEGENCUKEX_20200811.txt' END WHERE expFormatCode = 'EEGENCUKEX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEGENCUKEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEGENCUKEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEGENCUKEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEGENCUKEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEGENCUKEX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EEGENCUKEX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EEGENCUKEX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EEGENCUKEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEGENCUKEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEGENCUKEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEGENCUKEX','D10','dbo.U_EEGENCUKEX_drvTbl',NULL);
IF OBJECT_ID('U_EEGENCUKEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EEGENCUKEX_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EEGENCUKEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EEGENCUKEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EEGENCUKEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEGENCUKEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(69) NULL,
    [drvUserName] varchar(8000) NULL,
    [drvEmail] varchar(50) NULL,
    [drvSingleSignOn] varchar(50) NULL,
    [drvStatus] varchar(8) NOT NULL,
    [drvTitle] varchar(3) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvDepartmentCode] char(6) NULL,
    [drvCostCenter] char(6) NULL,
    [drvDivision] char(6) NULL,
    [drvLocationCode] char(6) NULL,
    [drvSupervisorName] varchar(255) NULL,
    [drvAdditionalNotifiers] varchar(50) NULL,
    [drvEmployeeId] char(9) NULL
);
IF OBJECT_ID('U_EEGENCUKEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EEGENCUKEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EEGENCUKEX_File') IS NULL
CREATE TABLE [dbo].[U_EEGENCUKEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEGENCUKEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Laird Connectivity

Created By: James Bender
Business Analyst: Lea King
Create Date: 07/27/2020
Service Request Number: TekP-2020-06-24-0001

Purpose: Egencia UK Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEGENCUKEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEGENCUKEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEGENCUKEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEGENCUKEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEGENCUKEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEGENCUKEX', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEGENCUKEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EEGENCUKEX';

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
    DELETE FROM dbo.U_EEGENCUKEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEGENCUKEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_EEGENCUKEX_EEList
    WHERE xEEID IN (SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE LEFT(EecLocation, 1) <> 'E');

    DELETE FROM dbo.U_EEGENCUKEX_EEList
    WHERE xEEID IN (SELECT DISTINCT EepEEID FROM dbo.EmpPers WITH (NOLOCK) WHERE ISNULL(EepAddressEmail, '') = '' OR EepAddressEmail = 'noemail@lairdconnect.com');

    DELETE FROM dbo.U_EEGENCUKEX_EEList
    WHERE xEEID NOT IN (select distinct EepEEID from dbo.EmpPers WITH (NOLOCK) where EepAddressEmail LIKE '%@lairdconnect.com')


     --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
/*    IF OBJECT_ID('U_EEGENCUKEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EEGENCUKEX_AuditFields;
    CREATE TABLE dbo.U_EEGENCUKEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EEGENCUKEX_AuditFields VALUES ('EmpComp','EecDateOfTermination');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EEGENCUKEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EEGENCUKEX_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EEGENCUKEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EEGENCUKEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(DAY, -30, @StartDate) AND @EndDate
    AND audNewValue = 'T'
    ;

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EEGENCUKEX_Audit ON dbo.U_EEGENCUKEX_Audit (audEEID,audCOID);*/



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEGENCUKEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEGENCUKEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEGENCUKEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EecEmplStatus + ' -- ' + CAST(@EndDate AS VARCHAR) + ' -- ' + CAST(DATEADD(DAY, -30,EecDateOfTermination) AS VARCHAR)
        -- standard fields above and additional driver fields below
        ,drvUserName = REPLACE(EecEmpNo, ' ','') + '@lairdconnect.com'
        ,drvEmail = EepAddressEMail
        ,drvSingleSignOn = EepAddressEMail
        ,drvStatus = CASE WHEN EecEmplStatus = 'T' THEN 'Inactive' ELSE 'Active' END
        ,drvTitle = CASE WHEN EepGender = 'M' THEN 'Mr.' ELSE 'Ms.' END
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle
        ,drvNameLast = EepNameLast
        ,drvDepartmentCode = EecOrgLvl4
        ,drvCostCenter = EecOrgLvl3
        ,drvDivision = EecOrgLvl1
        ,drvLocationCode = EecLocation
        ,drvSupervisorName = '"' + RTRIM(SUP_NAME) + '"'
        ,drvAdditionalNotifiers = SUP_EMAIL
        ,drvEmployeeId = EecEmpNo
    INTO dbo.U_EEGENCUKEX_drvTbl
    FROM dbo.U_EEGENCUKEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (
                SELECT EepEEID AS SUP_EEID, EepNameLast + ', ' + EepNameFirst + ' ' + ISNULL(EepNameMiddle, '') AS SUP_NAME, EepAddressEmail AS SUP_EMAIL FROM dbo.EmpPers WITH (NOLOCK)) AS SUP
        ON EecSupervisorID = SUP_EEID
    WHERE EecEmplStatus <> 'T'
        OR (EecEmplStatus = 'T' AND @ENDDATE < DATEADD(DAY, -30, EecDateOfTermination))
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
ALTER VIEW dbo.dsi_vwEEGENCUKEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEGENCUKEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEGENCUKEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007201'
       ,expStartPerControl     = '202007201'
       ,expLastEndPerControl   = '202007279'
       ,expEndPerControl       = '202007279'
WHERE expFormatCode = 'EEGENCUKEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEGENCUKEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEGENCUKEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort