SET NOCOUNT ON;
IF OBJECT_ID('U_EBENEXPREX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBENEXPREX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EBENEXPREX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EBENEXPREX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEBENEXPREX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBENEXPREX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBENEXPREX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENEXPREX];
GO
IF OBJECT_ID('U_EBENEXPREX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBENEXPREX_PEarHist];
GO
IF OBJECT_ID('U_EBENEXPREX_File') IS NOT NULL DROP TABLE [dbo].[U_EBENEXPREX_File];
GO
IF OBJECT_ID('U_EBENEXPREX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBENEXPREX_EEList];
GO
IF OBJECT_ID('U_EBENEXPREX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBENEXPREX_drvTbl];
GO
IF OBJECT_ID('U_EBENEXPREX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBENEXPREX_AuditFields];
GO
IF OBJECT_ID('U_EBENEXPREX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBENEXPREX_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EBENEXPREX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EBENEXPREX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EBENEXPREX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EBENEXPREX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EBENEXPREX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBENEXPREX','Benefit Express Labor Hours Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EBENEXPREXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EBENEXPREX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number"','1','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','1',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Key"','2','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','2',NULL,'Payroll Key',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','3','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','4','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','5','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Date"','6','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','6',NULL,'Pay Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Per Pay Actual Hours Worked"','7','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','7',NULL,'Per Pay Actual Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Year-To-Date Actual Hours Worked – Optional data field"','8','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','8',NULL,'Year-To-Date Actual Hours Worked – Optional data f',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Per Pay W-2 Earnings"','9','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','9',NULL,'Per Pay W-2 Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Year-To-Date W-2 Earnings"','10','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','10',NULL,'Year-To-Date W-2 Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Hours"','11','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','11',NULL,'Scheduled Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work or Home Email"','12','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','12',NULL,'Work or Home Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Rate"','13','(''DA''=''T,'')','EBENEXPREXZ0','50','H','01','13',NULL,'Pay Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACA Indicator"','14','(''DA''=''T'')','EBENEXPREXZ0','50','H','01','14',NULL,'ACA Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''T,'')','EBENEXPREXZ0','50','D','10','1',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollKey"','2','(''UA''=''T,'')','EBENEXPREXZ0','50','D','10','2',NULL,'Payroll Key',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','3','(''DA''=''T,'')','EBENEXPREXZ0','50','D','10','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','4','(''UA''=''T,'')','EBENEXPREXZ0','50','D','10','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EBENEXPREXZ0','50','D','10','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayDate"','6','(''UDMDY''=''T,'')','EBENEXPREXZ0','50','D','10','6',NULL,'Pay Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActualHoursWorked"','7','(''UA''=''T,'')','EBENEXPREXZ0','50','D','10','7',NULL,'Per Pay Actual Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDActualHoursWorked"','8','(''UA''=''T,'')','EBENEXPREXZ0','50','D','10','8',NULL,'Year-To-Date Actual Hours Worked – Optional data f',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPerPayW2Earnings"','9','(''UA''=''T,'')','EBENEXPREXZ0','50','D','10','9',NULL,'Per Pay W-2 Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDW2Earnings"','10','(''UA''=''T,'')','EBENEXPREXZ0','50','D','10','10',NULL,'Year-To-Date W-2 Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','11','(''DA''=''T,'')','EBENEXPREXZ0','50','D','10','11',NULL,'Scheduled Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','12','(''DA''=''T,'')','EBENEXPREXZ0','50','D','10','12',NULL,'Work or Home Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','13','(''DA''=''T,'')','EBENEXPREXZ0','50','D','10','13',NULL,'Pay Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','14','(''DA''=''T'')','EBENEXPREXZ0','50','D','10','14',NULL,'ACA Indicator',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EBENEXPREX_20201020.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Benefit Express Labor Hrs Exp','202010209','EMPEXPORT','ONDEM_XOE',NULL,'EBENEXPREX',NULL,NULL,NULL,'202010209','Oct 20 2020  1:17PM','Oct 20 2020  1:17PM','202010011',NULL,'','','202010011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Benefit Express Labor Hr-Sched','202010209','EMPEXPORT','SCH_EBENEX',NULL,'EBENEXPREX',NULL,NULL,NULL,'202010209','Oct 20 2020  1:17PM','Oct 20 2020  1:17PM','202010011',NULL,'','','202010011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Benefit Express Labor Hr-Test','202010209','EMPEXPORT','TEST_XOE',NULL,'EBENEXPREX',NULL,NULL,NULL,'202010209','Oct 20 2020  1:17PM','Oct 20 2020  1:17PM','202010011',NULL,'','','202010011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXPREX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXPREX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXPREX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXPREX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXPREX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EBENEXPREX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EBENEXPREX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EBENEXPREX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBENEXPREX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBENEXPREX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBENEXPREX','D10','dbo.U_EBENEXPREX_drvTbl',NULL);
IF OBJECT_ID('U_EBENEXPREX_Audit') IS NULL
CREATE TABLE [dbo].[U_EBENEXPREX_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EBENEXPREX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBENEXPREX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EBENEXPREX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBENEXPREX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvPayrollKey] char(9) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvPayDate] datetime NULL,
    [drvActualHoursWorked] nvarchar(4000) NULL,
    [drvYTDActualHoursWorked] nvarchar(4000) NULL,
    [drvPerPayW2Earnings] nvarchar(4000) NULL,
    [drvYTDW2Earnings] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EBENEXPREX_EEList') IS NULL
CREATE TABLE [dbo].[U_EBENEXPREX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EBENEXPREX_File') IS NULL
CREATE TABLE [dbo].[U_EBENEXPREX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EBENEXPREX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBENEXPREX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENEXPREX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Chidlren's Specialized

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 10/20/2020
Service Request Number: TekP-2020-09-18-0001

Purpose: Benefit Express Labor Hours Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBENEXPREX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBENEXPREX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBENEXPREX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBENEXPREX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBENEXPREX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENEXPREX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENEXPREX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENEXPREX', 'SCH_EBENEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBENEXPREX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBENEXPREX';

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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBENEXPREX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBENEXPREX_AuditFields;
    CREATE TABLE dbo.U_EBENEXPREX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    
    
    --INSERT INTO dbo.U_EBENEXPREX_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EBENEXPREX_AuditFields VALUES ('EmpPers','eepSSN');    
    INSERT INTO dbo.U_EBENEXPREX_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EBENEXPREX_AuditFields VALUES ('EmpPers','EepNameFirst');

    INSERT INTO dbo.U_EBENEXPREX_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_EBENEXPREX_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBENEXPREX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBENEXPREX_Audit;
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
--        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EBENEXPREX_Audit
    FROM dbo.U_EBENEXPREX_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EBENEXPREX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
   AND ISNULL(audNewValue,'') <> '';
    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EBENEXPREX_Audit WHERE audRowNo > 1;
    --==========================================
    -- Clean EE List 
    --=========================================
    -- Changes Only
    DELETE FROM dbo.U_EBENEXPREX_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EBENEXPREX_Audit WHERE audEEID = xEEID /*AND audNewHire = 'Y'*/);



    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EBENEXPREX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBENEXPREX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EBENEXPREX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBENEXPREX_PEarHist;
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
    INTO dbo.U_EBENEXPREX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBENEXPREX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBENEXPREX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBENEXPREX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvPayrollKey = EecEmpNo
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvPayDate = PrgPayDate
        ,drvActualHoursWorked = FORMAT(PehCurHrs, '#0.00')
        ,drvYTDActualHoursWorked = FORMAT(PehCurAmtYTD, '#0.00')
        ,drvPerPayW2Earnings = FORMAT(PthTaxableWages, '#0.00')
        ,drvYTDW2Earnings = FORMAT(PthYTDTaxableWages, '#0.00')
    INTO dbo.U_EBENEXPREX_drvTbl
    FROM dbo.U_EBENEXPREX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_EBENEXPREX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN (
            SELECT PthEEID, PthCOID, SUM(PthCurTaxableWages) AS PthYTDTaxableWages
                ,SUM(CASE WHEN PthPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PthCurTaxableWages ELSE 0.00 END) AS PthTaxableWages
            FROM dbo.PTaxHist WITH (NOLOCK)
            WHERE LEFT(PthPerControl, 4) = LEFT(@EndPerControl, 4)
                AND PthTaxCode LIKE '%SIT'
            GROUP BY PthEEID, PthCOID) AS W2Earnings
        ON PthEEID = xEEID
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
ALTER VIEW dbo.dsi_vwEBENEXPREX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBENEXPREX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBENEXPREX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202010011'
       ,expStartPerControl     = '202010011'
       ,expLastEndPerControl   = '202010209'
       ,expEndPerControl       = '202010209'
WHERE expFormatCode = 'EBENEXPREX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBENEXPREX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBENEXPREX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort