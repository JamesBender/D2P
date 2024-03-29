SET NOCOUNT ON;
IF OBJECT_ID('U_EFSAPRLEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFSAPRLEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFSAPRLEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFSAPRLEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFSAPRLEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFSAPRLEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFSAPRLEXP];
GO
IF OBJECT_ID('U_EFSAPRLEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_Trailer];
GO
IF OBJECT_ID('U_EFSAPRLEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_PEarHist];
GO
IF OBJECT_ID('U_EFSAPRLEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_PDedHist];
GO
IF OBJECT_ID('U_EFSAPRLEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_Header];
GO
IF OBJECT_ID('U_EFSAPRLEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_File];
GO
IF OBJECT_ID('U_EFSAPRLEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_EEList];
GO
IF OBJECT_ID('U_EFSAPRLEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_drvTbl];
GO
IF OBJECT_ID('U_EFSAPRLEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EFSAPRLEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFSAPRLEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFSAPRLEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFSAPRLEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFSAPRLEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFSAPRLEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFSAPRLEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFSAPRLEXP','Discovery FSA Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EFSAPRLEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FH"','1','(''DA''=''T|'')','EFSAPRLEXPZ0','50','H','01','1',NULL,'Record Type  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DBI"','2','(''DA''=''T|'')','EFSAPRLEXPZ0','50','H','01','2',NULL,'Administrator Code  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"36093"','3','(''DA''=''T|'')','EFSAPRLEXPZ0','50','H','01','3',NULL,'Employer Code  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','4','(''DA''=''T|'')','EFSAPRLEXPZ0','50','H','01','4',NULL,'Synchronize Flag  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentDate"','5','(''UA''=''T|'')','EFSAPRLEXPZ0','50','H','01','5',NULL,'Submitted Date  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentTime"','6','(''UA''=''T|'')','EFSAPRLEXPZ0','50','H','01','6',NULL,'Submitted Time  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"3.5"','7','(''DA''=''T'')','EFSAPRLEXPZ0','50','H','01','7',NULL,'File Version  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CT"','1','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','10','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFileImportID"','2','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','10','2',NULL,'Participant File Import Id ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','3','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','10','3',NULL,'Plan Name  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribDate"','4','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','10','4',NULL,'Contribution Date  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Deduction"','5','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','10','5',NULL,'Contribution Description  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribAmt"','6','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','10','6',NULL,'Contribution Amount  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmtType"','7','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','10','7',NULL,'Amount Type  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxYear"','8','(''UA''=''T'')','EFSAPRLEXPZ0','50','D','10','8',NULL,'Tax Year  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FF"','1','(''DA''=''T|'')','EFSAPRLEXPZ0','50','T','90','1',NULL,'Record Type  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','2','(''UA''=''T|'')','EFSAPRLEXPZ0','50','T','90','2',NULL,'Record Count ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DBI"','3','(''DA''=''T|'')','EFSAPRLEXPZ0','50','T','90','3',NULL,'Administrator Code  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"36093"','4','(''DA''=''T|'')','EFSAPRLEXPZ0','50','T','90','4',NULL,'Employer Code  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmitDate"','5','(''UDMDY''=''T|'')','EFSAPRLEXPZ0','50','T','90','5',NULL,'Submitted Date  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmitTime"','6','(''UA''=''T'')','EFSAPRLEXPZ0','50','T','90','6',NULL,'Submitted Time  ',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSAPRLEXP_20200102.txt',NULL,'','','',NULL,NULL,NULL,'FSA Payroll Export','201911279','EMPEXPORT','ONDEMAND','Dec 12 2019  8:23AM','EFSAPRLEXP',NULL,NULL,NULL,'201911279','Nov 27 2019  6:04AM','Nov 27 2019  6:04AM','201901011','82','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSAPRLEXP_20200102.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','201911279','EMPEXPORT','SCHEDULED','Dec 12 2019  8:23AM','EFSAPRLEXP',NULL,NULL,NULL,'201911279','Nov 27 2019  6:04AM','Nov 27 2019  6:04AM','201901011','82','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSAPRLEXP_20200102.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','201911279','EMPEXPORT','OEACTIVE','Dec 12 2019  8:22AM','EFSAPRLEXP',NULL,NULL,NULL,'201911279','Nov 27 2019  6:04AM','Nov 27 2019  6:04AM','201901011','36','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSAPRLEXP_20200102.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','201911279','EMPEXPORT','OEPASSIVE','Dec 12 2019  8:22AM','EFSAPRLEXP',NULL,NULL,NULL,'201911279','Nov 27 2019  6:04AM','Nov 27 2019  6:04AM','201901011','82','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSAPRLEXP_20200102.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201912069','EMPEXPORT','TEST','Dec 19 2019 12:31PM','EFSAPRLEXP',NULL,NULL,NULL,'201912069','Dec  6 2019 12:00AM','Dec 30 1899 12:00AM','201912061','65','','','201912061',dbo.fn_GetTimedKey(),NULL,'us3lKiRED1015',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EFSAPRLEXP_20200102.txt' END WHERE expFormatCode = 'EFSAPRLEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSAPRLEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSAPRLEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSAPRLEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSAPRLEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSAPRLEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSAPRLEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EFSAPRLEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFSAPRLEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EFSAPRLEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFSAPRLEXP','H01','dbo.U_EFSAPRLEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFSAPRLEXP','D10','dbo.U_EFSAPRLEXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFSAPRLEXP','T90','dbo.U_EFSAPRLEXP_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EFSAPRLEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFSAPRLEXP] (
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
IF OBJECT_ID('U_EFSAPRLEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPartFileImportID] char(11) NULL,
    [drvPlanName] varchar(19) NULL,
    [drvContribDate] nvarchar(4000) NULL,
    [drvContribAmt] nvarchar(4000) NULL,
    [drvAmtType] varchar(6) NOT NULL,
    [drvTaxYear] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_File') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_Header] (
    [drvCurrentDate] varchar(8) NULL,
    [drvCurrentTime] varchar(6) NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhFsaAmount] numeric NULL,
    [PdhFsaDAmount] numeric NULL,
    [PdhLfsaAmount] numeric NULL,
    [PdhCtranAmount] numeric NULL,
    [PdhCparkAmount] numeric NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_PEarHist] (
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
IF OBJECT_ID('U_EFSAPRLEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_Trailer] (
    [drvRecordCount] int NULL,
    [drvSubmitDate] varchar(8) NULL,
    [drvSubmitTime] varchar(6) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFSAPRLEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Redhorse Corp

Created By: James Bender
Business Analyst: Lea King
Create Date: 11/27/2019
Service Request Number: TekP-2019-10-18-0002

Purpose: FSA Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFSAPRLEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFSAPRLEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFSAPRLEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFSAPRLEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFSAPRLEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFSAPRLEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFSAPRLEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFSAPRLEXP', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFSAPRLEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFSAPRLEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFSAPRLEXP';

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
    DELETE FROM dbo.U_EFSAPRLEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFSAPRLEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EFSAPRLEXP_EEList where xEEID IN (
        select distinct eeceeid from empcomp where eecEEType IN('TES')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSAD,LSFA,CTRAN,CPARK';

    IF OBJECT_ID('U_EFSAPRLEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFSAPRLEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFSAPRLEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhFsaAmount     = SUM(CASE WHEN PdhDedCode IN ('FSA') THEN PdhEECurAmt ELSE 0.00 END) -- JCB
        ,PdhFsaDAmount     = SUM(CASE WHEN PdhDedCode IN ('FSAD') THEN PdhEECurAmt ELSE 0.00 END) -- JCB
        ,PdhLfsaAmount     = SUM(CASE WHEN PdhDedCode IN ('LFSA') THEN PdhEECurAmt ELSE 0.00 END) -- JCB
        ,PdhCtranAmount     = SUM(CASE WHEN PdhDedCode IN ('CTRAN') THEN PdhEECurAmt ELSE 0.00 END) -- JCB
        ,PdhCparkAmount     = SUM(CASE WHEN PdhDedCode IN ('CPARK') THEN PdhEECurAmt ELSE 0.00 END) -- JCB
        /*,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)*/
    INTO dbo.U_EFSAPRLEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFSAPRLEXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EFSAPRLEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_PEarHist;
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
    INTO dbo.U_EFSAPRLEXP_PEarHist
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
    -- DETAIL RECORD - U_EFSAPRLEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EFSAPRLEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvPartFileImportID = EepSSN
        ,drvPlanName = CASE BdmDedCode
                            WHEN 'FSA' THEN 'Medical FSA'
                            WHEN 'FSAD' THEN 'Dependent Care FSA'
                            WHEN 'LFSA' THEN 'Limited Medical FSA'
                            WHEN 'CTRAN' THEN 'Mass Transit'
                            WHEN 'CPARK' THEN 'Parking'
                        END
        ,drvContribDate = FORMAT(PrgPayDate, 'MMddyyyy')
        ,drvContribAmt =    CASE BdmDedCode
                                WHEN 'FSA' THEN FORMAT(PdhFsaAmount, '##.00')
                                WHEN 'FSAD' THEN FORMAT(PdhFsadAmount, '##.00')
                                WHEN 'LFSA' THEN FORMAT(PdhLfsaAmount, '##.00')
                                WHEN 'CTRAN' THEN FORMAT(PdhCtranAmount, '##.00')
                                WHEN 'CPARK' THEN FORMAT(PdhCparkAmount, '##.00')
                            END
        --     FORMAT(PdhFsaAmount, '##.00')
        ,drvAmtType = 'Actual'
        ,drvTaxYear = FORMAT(GETDATE(), 'yyyy')
    INTO dbo.U_EFSAPRLEXP_drvTbl
    FROM dbo.U_EFSAPRLEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EFSAPRLEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EFSAPRLEXP_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.U_EFSAPRLEXP_PDedHist WITH (NOLOCK) -- JCB
        ON PdhEEID = xEEID
    --WHERE EecEEType NOT IN ('TES')
    ;

    DECLARE @CurrentDate VARCHAR(8)
        ,@CurrentTime VARCHAR(6);

    SELECT @CurrentDate = FORMAT(GETDATE(), 'MMddyyyy');
    SELECT @CurrentTime = FORMAT(GETDATE(), 'hhmmss')
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EFSAPRLEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_Header;
    SELECT DISTINCT
         drvCurrentDate = @CurrentDate -- FORMAT(GETDATE(), 'MMdyyyy')
        ,drvCurrentTime = @CurrentTime -- FORMAT(CURRENT_TIMESTAMP, 'HHMMss')
    INTO dbo.U_EFSAPRLEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EFSAPRLEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_Trailer;
    SELECT DISTINCT
         drvRecordCount = (SELECT COUNT(*) FROM dbo.U_EFSAPRLEXP_drvTbl)
        ,drvSubmitDate = @CurrentDate -- FORMAT(GETDATE(), 'MMddyyyy')
        ,drvSubmitTime = @CurrentTime --FORMAT(CURRENT_TIMESTAMP, 'HHMMss')
    INTO dbo.U_EFSAPRLEXP_Trailer
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
ALTER VIEW dbo.dsi_vwEFSAPRLEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFSAPRLEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFSAPRLEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201901011'
       ,expStartPerControl     = '201901011'
       ,expLastEndPerControl   = '201911279'
       ,expEndPerControl       = '201911279'
WHERE expFormatCode = 'EFSAPRLEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFSAPRLEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFSAPRLEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort