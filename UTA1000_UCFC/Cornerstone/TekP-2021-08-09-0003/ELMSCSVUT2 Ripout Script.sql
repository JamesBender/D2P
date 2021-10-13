SET NOCOUNT ON;
IF OBJECT_ID('U_ELMSCSVUT2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELMSCSVUT2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELMSCSVUT2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELMSCSVUT2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELMSCSVUT2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELMSCSVUT2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELMSCSVUT2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELMSCSVUT2];
GO
IF OBJECT_ID('U_ELMSCSVUT2_File') IS NOT NULL DROP TABLE [dbo].[U_ELMSCSVUT2_File];
GO
IF OBJECT_ID('U_ELMSCSVUT2_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELMSCSVUT2_EEList];
GO
IF OBJECT_ID('U_ELMSCSVUT2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELMSCSVUT2_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELMSCSVUT2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELMSCSVUT2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELMSCSVUT2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELMSCSVUT2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELMSCSVUT2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELMSCSVUT2','Torch LMS Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','8000','S','N','ELMSCSVUT2Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELMSCSVUT2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User ID"','1','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','1',NULL,'User ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','2','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','3','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Username"','4','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','4',NULL,'Username',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager"','5','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','5',NULL,'Manager',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Allow Reconciliation"','6','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','6',NULL,'Allow Reconciliation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email"','7','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','7',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Required Training Approvals"','8','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','8',NULL,'Required Training Approvals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Exempt"','9','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','9',NULL,'Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Hire Date"','10','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','10',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Hire Date"','11','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','11',NULL,'Last Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Status"','12','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','12',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','13','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','13',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Title"','14','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','14',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department"','15','(''DA''=''T,'')','ELMSCSVUT2Z0','50','H','01','15',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','16','(''DA''=''T'')','ELMSCSVUT2Z0','50','H','01','16',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserId"','1','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','1',NULL,'User ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','2','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','3','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUsername"','4','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','4',NULL,'User Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManager"','5','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','5',NULL,'Manager',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAllowReconciliation"','6','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','6',NULL,'Allow Reconciliation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','7','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','7',NULL,'Emal',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRequiredTrainingApprov"','8','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','8',NULL,'Required Training Approvals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExempt"','9','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','9',NULL,'Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalHireDate"','10','(''UD101''=''T,'')','ELMSCSVUT2Z0','50','D','10','10',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastHireDate"','11','(''UD101''=''T,'')','ELMSCSVUT2Z0','50','D','10','11',NULL,'Last Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','12','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','12',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','13','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','13',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','14','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','14',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartment"','15','(''UA''=''T,'')','ELMSCSVUT2Z0','50','D','10','15',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','16','(''UD101''=''T'')','ELMSCSVUT2Z0','50','D','10','16',NULL,'Termination Date',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ELMSCSVUT2_20211012.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','XAH9W',NULL,NULL,NULL,'Torch LMS Export','201903139','EMPEXPORT','ONDEMAND',NULL,'ELMSCSVUT2',NULL,NULL,NULL,'201905029','Feb 12 2019  9:27AM','Feb 12 2019  9:27AM','201905011',NULL,'','','201903061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','XAH9W',NULL,NULL,NULL,'Scheduled Session','201903139','EMPEXPORT','SCHEDULED',NULL,'ELMSCSVUT2',NULL,NULL,NULL,'202108319','Feb 12 2019  9:27AM','Feb 12 2019  9:27AM','202108301',NULL,'','','201903061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201905139','EMPEXPORT','TEST','Sep 21 2021 11:31AM','ELMSCSVUT2',NULL,NULL,NULL,'201905139','May 13 2019 12:00AM','Dec 30 1899 12:00AM','201905061','985','','','201905061',dbo.fn_GetTimedKey(),NULL,'us3rVaUTA1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'XAH9W',NULL,NULL,NULL,'Torch LMS OE Export','202001019','EMPEXPORT','TorOE',NULL,'ELMSCSVUT2',NULL,NULL,NULL,'202001019',NULL,NULL,'202001011',NULL,NULL,'','202001011',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUT2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUT2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUT2','InitialSort','C','drvNameFirst');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUT2','SubSort','C','drvNameLast');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUT2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUT2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ELMSCSVUT2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ELMSCSVUT2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ELMSCSVUT2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELMSCSVUT2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELMSCSVUT2','D10','dbo.U_ELMSCSVUT2_drvTbl',NULL);
IF OBJECT_ID('U_ELMSCSVUT2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELMSCSVUT2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvUserId] varchar(50) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvUsername] char(9) NULL,
    [drvManager] varchar(50) NULL,
    [drvAllowReconciliation] varchar(4) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvRequiredTrainingApprov] varchar(1) NOT NULL,
    [drvExempt] varchar(1) NOT NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvLastHireDate] datetime NULL,
    [drvStatus] varchar(1) NOT NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvJobTitle] char(8) NULL,
    [drvDepartment] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL
);
IF OBJECT_ID('U_ELMSCSVUT2_EEList') IS NULL
CREATE TABLE [dbo].[U_ELMSCSVUT2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELMSCSVUT2_File') IS NULL
CREATE TABLE [dbo].[U_ELMSCSVUT2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELMSCSVUT2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Utah Community Federal Credit Union

Created By: Sean Farrell
Business Analyst: Nick Watkins
Create Date: 02/12/2019
Service Request Number: SR-2018-00221045

Purpose: Torch LMS Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELMSCSVUT2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELMSCSVUT2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELMSCSVUT2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELMSCSVUT2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELMSCSVUT2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELMSCSVUT2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELMSCSVUT2', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELMSCSVUT2', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELMSCSVUT2';

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
    DELETE FROM dbo.U_ELMSCSVUT2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELMSCSVUT2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);



    DELETE dbo.U_ELMSCSVUT2_EEList
    FROM dbo.U_ELMSCSVUT2_EEList
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID
    AND EecCOID = xCOID
    WHERE EecEmplStatus = 'T'
    AND EecDateOfTermination <= DATEADD(dd,-30,@EndDate)


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELMSCSVUT2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELMSCSVUT2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELMSCSVUT2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID

        ,drvUserId = EEP.EepAddressEmail
        ,drvNameFirst = EEP.EepNameFirst
        ,drvNameLast = EEP.EepNameLast
        ,drvUsername = EEC.EecEmpNo
        ,drvManager = SUPP.eepAddressEMail
        ,drvAllowReconciliation = 'TRUE'
        ,drvEmail = EEP.EepAddressEmail
        ,drvRequiredTrainingApprov = '1'
        ,drvExempt = CASE WHEN EjhFLSACategory = 'E' THEN '1' ELSE '0' END
        ,drvOriginalHireDate = EEC.EecDateOfOriginalHire
        ,drvLastHireDate = EEC.EecDateOfLastHire
        ,drvStatus = CASE WHEN EEC.EecEmplStatus = 'A' THEN '1' ELSE '0' END
        ,drvDivision = '' --O1.OrgDesc
        ,drvJobTitle = EEC.EecJobCode
        ,drvDepartment = '' --O2.OrgDesc
        ,drvTerminationDate = EEC.EecDateOfTermination
    /*
        -- standard fields above and additional driver fields below
        ,drvUsername = CASE WHEN ISNULL((SELECT UPN FROM dbo.vw_ADFS_GetSSOUsers JOIN dbo.vw_rbsUserFind ON dbo.vw_ADFS_GetSSOUsers.sususername = dbo.vw_rbsUserFind.sususername  WHERE sucEEID = xEEID),'') = '' THEN EepAddressEmail
                                ELSE (SELECT UPN FROM dbo.vw_ADFS_GetSSOUsers JOIN dbo.vw_rbsUserFind ON dbo.vw_ADFS_GetSSOUsers.sususername = dbo.vw_rbsUserFind.sususername  WHERE sucEEID = xEEID)
                        END
        ,drvAddressEmail = EepAddressEMail
        ,drvEmpNo = EecEmpNo
        ,drvNameFirst = ISNULL(EepNamePreferred,EepNameFirst)
        ,drvNameLast = EepNameLast
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvEmplStatus = CASE EecEmplStatus WHEN 'A' THEN '1' ELSE '0' END
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvSupervisorEmail = (SELECT UPN FROM dbo.vw_ADFS_GetSSOUsers JOIN dbo.vw_rbsUserFind ON dbo.vw_ADFS_GetSSOUsers.sususername = dbo.vw_rbsUserFind.sususername 
                                WHERE SucEEID IN (SELECT EecSupervisorID FROM dbo.vw_int_EmpComp WITH (NOLOCK) WHERE EecEEID = xEEID AND EecCOID = xCOID))
        
                            --(SELECT EepAddressEMail FROM dbo.EmpPers WITH (NOLOCK) 
                                    --WHERE EepEEID IN (SELECT EecSupervisorId FROM dbo.vw_int_EmpComp WITH (NOLOCK) WHERE EecEEID = xEEID AND EecCOID = xCOID))
        ,drvRole1 = CASE WHEN EecOrgLvl1 = 'TR' THEN 'Super Admin'
                         WHEN EecOrgLvl1 <> 'TR' THEN CASE WHEN (SELECT TOP 1 RolName FROM dbo.RbsUserRoles JOIN dbo.RbsRoles ON RurRoleID = RolID 
                                                                 WHERE RolName NOT IN ('MOBILE','HEALTHCAREMEASUREMENT','UTMUSEREMPLOYEE','PERCEPTIONADMIN') AND RurEEID = xEEID
                                                                 Order BY RurDateTimeCreated DESC) = 'MGR' THEN 'MGR'
                                                           
                                                           WHEN (SELECT TOP 1 RolName FROM dbo.RbsUserRoles JOIN dbo.RbsRoles ON RurRoleID = RolID 
                                                                 WHERE RolName NOT IN ('MOBILE','HEALTHCAREMEASUREMENT','UTMUSEREMPLOYEE','PERCEPTIONADMIN') AND RurEEID = xEEID
                                                                 AND RolDefaultRole = '0'
                                                                 Order BY RurDateTimeCreated DESC) = 'ASSTMGR' THEN 'ASSTMGR'
                                                           ELSE 'User'
                                                      END
                    END
        ,drvRole2 = CASE When EecOrgLvl1 = 'TR' THEN 'Instructor' ELSE '' END
        ,drvOrgLvl1 = (SELECT TOP 1 OrgDesc From dbo.vw_int_OrgLevel JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON OrgCode = EecOrgLvl1 AND EecEEID = xEEID AND EecCOID = xCOID)
        ,drvOrgLvl2 = CASE WHEN EecOrgLvl1 = 'BO' THEN 
                            (SELECT TOP 1 OrgDesc From dbo.vw_int_OrgLevel JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON OrgCode = EecOrgLvl2 AND EecEEID = xEEID AND EecCOID = xCOID AND OrgLvl = '2')
                        ELSE ''
                    END
        ,drvAdmin1 = (SELECT TOP 1 OrgDesc From dbo.vw_int_OrgLevel JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON OrgCode = EecOrgLvl1 AND EecEEID = xEEID AND EecCOID = xCOID)
        ,drvAdmin2 = CASE WHEN EecOrgLvl1 = 'BO' THEN 
                            (SELECT TOP 1 OrgDesc From dbo.vw_int_OrgLevel JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON OrgCode = EecOrgLvl2 AND EecEEID = xEEID AND EecCOID = xCOID AND OrgLvl ='2')
                        ELSE ''
                    END
        ,drvJobTitle = JbcDesc*/
    INTO dbo.U_ELMSCSVUT2_drvTbl
    FROM dbo.U_ELMSCSVUT2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp EEC WITH (NOLOCK)
        ON EEC.EecEEID = xEEID 
        AND EEC.EecCoID = xCoID
    JOIN dbo.EmpPers EEP WITH (NOLOCK)
        ON EEP.EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EEC.EecJobCode
    --LEFT JOIN dbo.vw_int_EmpComp SUP WITH (NOLOCK)
--        ON EEC.EecSupervisorId = SUP.EecEEID
    LEFT JOIN dbo.EmpPers SUPP WITH (NOLOCK)
        ON SUPP.eepEEID = EEC.EecSupervisorId
    LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS X
            WHERE RN = 1) AS EJH
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    LEFT JOIN dbo.OrgLevel O1 WITH (NOLOCK)
        ON EEC.EecOrgLvl1 = O1.OrgCode
    LEFT JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON EEC.EecOrgLvl2 = O2.OrgCode
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
ALTER VIEW dbo.dsi_vwELMSCSVUT2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELMSCSVUT2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELMSCSVUT2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201903061'
       ,expStartPerControl     = '201903061'
       ,expLastEndPerControl   = '201903139'
       ,expEndPerControl       = '201903139'
WHERE expFormatCode = 'ELMSCSVUT2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELMSCSVUT2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELMSCSVUT2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort