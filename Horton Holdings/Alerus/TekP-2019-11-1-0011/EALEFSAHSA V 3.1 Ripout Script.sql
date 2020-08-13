SET NOCOUNT ON;
IF OBJECT_ID('U_EALEFSAHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EALEFSAHSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EALEFSAHSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EALEFSAHSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEALEFSAHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEALEFSAHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EALEFSAHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EALEFSAHSA];
GO
IF OBJECT_ID('U_EALEFSAHSA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EALEFSAHSA_Trailer];
GO
IF OBJECT_ID('U_EALEFSAHSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EALEFSAHSA_PEarHist];
GO
IF OBJECT_ID('U_EALEFSAHSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EALEFSAHSA_PDedHist];
GO
IF OBJECT_ID('U_EALEFSAHSA_Header') IS NOT NULL DROP TABLE [dbo].[U_EALEFSAHSA_Header];
GO
IF OBJECT_ID('U_EALEFSAHSA_File') IS NOT NULL DROP TABLE [dbo].[U_EALEFSAHSA_File];
GO
IF OBJECT_ID('U_EALEFSAHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EALEFSAHSA_EEList];
GO
IF OBJECT_ID('U_EALEFSAHSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EALEFSAHSA_drvTbl];
GO
IF OBJECT_ID('U_EALEFSAHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EALEFSAHSA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EALEFSAHSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EALEFSAHSA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EALEFSAHSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EALEFSAHSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EALEFSAHSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EALEFSAHSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EALEFSAHSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EALEFSAHSA','Alerus FSA HSA Contributions Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EALEFSAHSAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrRecordType"','1','(''UA''=''T|'')','EALEFSAHSAZ0','50','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrAdminCode"','2','(''UA''=''T|'')','EALEFSAHSAZ0','50','H','01','2',NULL,'Admin Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrEmployerCode"','3','(''UA''=''T|'')','EALEFSAHSAZ0','50','H','01','3',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrSynchronizeFlag"','4','(''UA''=''T|'')','EALEFSAHSAZ0','50','H','01','4',NULL,'Synchronize Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrCreatedDate"','5','(''UDMDY''=''T|'')','EALEFSAHSAZ0','50','H','01','5',NULL,'Created Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrCreatedTime"','6','(''UDHMS''=''T|'')','EALEFSAHSAZ0','50','H','01','6',NULL,'Created Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hdrFileVersion"','7','(''UA''=''T'')','EALEFSAHSAZ0','50','H','01','7',NULL,'File Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerCode"','1','(''SS''=''T'')','EALEFSAHSAZ0','50','D','10','1',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','2','(''UA''=''T|'')','EALEFSAHSAZ0','50','D','10','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantFileImportID"','3','(''UA''=''T|'')','EALEFSAHSAZ0','50','D','10','3',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','4','(''UA''=''T|'')','EALEFSAHSAZ0','50','D','10','4',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionDate"','5','(''UDMDY''=''T|'')','EALEFSAHSAZ0','50','D','10','5',NULL,'Contribution Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionDescription"','6','(''UA''=''T|'')','EALEFSAHSAZ0','50','D','10','6',NULL,'Contribution Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','7','(''UNT2''=''T|'')','EALEFSAHSAZ0','50','D','10','7',NULL,'Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmountType"','8','(''UA''=''T|'')','EALEFSAHSAZ0','50','D','10','8',NULL,'Amount Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxYear"','9','(''UA''=''T|'')','EALEFSAHSAZ0','50','D','10','9',NULL,'Tax Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNotes"','10','(''UA''=''T|'')','EALEFSAHSAZ0','50','D','10','10',NULL,'Tax Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYearStart"','11','(''UA''=''T|'')','EALEFSAHSAZ0','50','D','10','11',NULL,'Tax Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYearEnd"','12','(''UA''=''T'')','EALEFSAHSAZ0','50','D','10','12',NULL,'Tax Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"trlRecordType"','1','(''UA''=''T|'')','EALEFSAHSAZ0','50','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"trlRecordCount"','2','(''UA''=''T|'')','EALEFSAHSAZ0','50','T','90','2',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"trlAdminCode"','3','(''UA''=''T|'')','EALEFSAHSAZ0','50','T','90','3',NULL,'Admin Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"trlEmployerCode"','4','(''UA''=''T|'')','EALEFSAHSAZ0','50','T','90','4',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"trlCreatedDate"','5','(''UDMDY''=''T|'')','EALEFSAHSAZ0','50','T','90','5',NULL,'Created Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"trlCreatedTime"','6','(''UDHMS''=''T'')','EALEFSAHSAZ0','50','T','90','6',NULL,'Created Time',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EALEFSAHSA_20200323.txt',NULL,'','','',NULL,NULL,NULL,'Alerus FSA HSA Contrib Exp','202002289','EMPEXPORT','ONDEMAND','Mar  9 2020 10:13AM','EALEFSAHSA',NULL,NULL,NULL,'202002289','Feb 28 2020  4:23AM','Feb 28 2020  4:23AM','202002141','129','','','202002141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EALEFSAHSA_20200323.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202002289','EMPEXPORT','TEST','Mar  9 2020 10:13AM','EALEFSAHSA',NULL,NULL,NULL,'202002289','Feb 28 2020  4:23AM','Feb 28 2020  4:23AM','202002141','129','','','202002141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EALEFSAHSA_20200323.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202002289','EMPEXPORT','SCHEDULED','Mar  9 2020 10:13AM','EALEFSAHSA',NULL,NULL,NULL,'202002289','Feb 28 2020  4:23AM','Feb 28 2020  4:23AM','202002141','129','','','202002141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EALEFSAHSA_20200323.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202002289','EMPEXPORT','OEACTIVE','Mar  9 2020 10:13AM','EALEFSAHSA',NULL,NULL,NULL,'202002289','Feb 28 2020  4:23AM','Feb 28 2020  4:23AM','202002141','129','','','202002141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EALEFSAHSA_20200323.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202002289','EMPEXPORT','OEPASSIVE','Mar  9 2020 10:13AM','EALEFSAHSA',NULL,NULL,NULL,'202002289','Feb 28 2020  4:23AM','Feb 28 2020  4:23AM','202002141','129','','','202002141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EALEFSAHSA_20200323.txt' END WHERE expFormatCode = 'EALEFSAHSA';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALEFSAHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALEFSAHSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALEFSAHSA','InitialSort','C','drvParticipantFileImportID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALEFSAHSA','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALEFSAHSA','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EALEFSAHSA' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EALEFSAHSA' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EALEFSAHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EALEFSAHSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALEFSAHSA','H01','dbo.U_EALEFSAHSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALEFSAHSA','D10','dbo.U_EALEFSAHSA_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALEFSAHSA','T90','dbo.U_EALEFSAHSA_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EALEFSAHSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EALEFSAHSA] (
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
IF OBJECT_ID('U_EALEFSAHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EALEFSAHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EALEFSAHSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EALEFSAHSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvParticipantFileImportID] char(11) NULL,
    [drvPlanName] varchar(15) NULL,
    [drvContributionDate] datetime NULL,
    [drvContributionDescription] varchar(21) NOT NULL,
    [drvContributionAmount] numeric NULL,
    [drvAmountType] varchar(6) NOT NULL,
    [drvTaxYear] varchar(1) NOT NULL,
    [drvNotes] varchar(1) NOT NULL,
    [drvPLanYearStart] varchar(8) NULL,
    [drvPLanYearEnd] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EALEFSAHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EALEFSAHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EALEFSAHSA_File') IS NULL
CREATE TABLE [dbo].[U_EALEFSAHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EALEFSAHSA_Header') IS NULL
CREATE TABLE [dbo].[U_EALEFSAHSA_Header] (
    [hdrRecordType] varchar(2) NOT NULL,
    [hdrAdminCode] varchar(3) NULL,
    [hdrEmployerCode] varchar(6) NULL,
    [hdrSynchronizeFlag] varchar(1) NOT NULL,
    [hdrCreatedDate] datetime NULL,
    [hdrCreatedTime] datetime NULL,
    [hdrFileVersion] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EALEFSAHSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EALEFSAHSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPerControl] varchar(8) NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhEEAmt] numeric NULL,
    [PdhERAmt] numeric NULL
);
IF OBJECT_ID('U_EALEFSAHSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EALEFSAHSA_PEarHist] (
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
IF OBJECT_ID('U_EALEFSAHSA_Trailer') IS NULL
CREATE TABLE [dbo].[U_EALEFSAHSA_Trailer] (
    [trlRecordType] varchar(2) NOT NULL,
    [trlRecordCount] int NULL,
    [trlAdminCode] varchar(3) NULL,
    [trlEmployerCode] varchar(6) NULL,
    [trlCreatedDate] datetime NULL,
    [trlCreatedTime] datetime NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EALEFSAHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Horton Holdings

Created By: James Bender
Business Analyst: Lea King
Create Date: 02/28/2020
Service Request Number: TekP-2019-11-1-0011

Purpose: Alerus FSA HSA Contributions Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EALEFSAHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EALEFSAHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EALEFSAHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EALEFSAHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EALEFSAHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALEFSAHSA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALEFSAHSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALEFSAHSA', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EALEFSAHSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EALEFSAHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@AdminCode            VARCHAR(3)
            ,@EmployerCode        VARCHAR(6)
            ,@CreateDate        DATETIME
            ,@LastPayDate        DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EALEFSAHSA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    SET @AdminCode = 'ALR';  --need from IA
    SET @EmployerCode = 'HHI040';  --need from IA
    SET @CreateDate = GetDate();

    SELECT @LastPayDate = max(prgpaydate)  FROM IPAYREGKEYS WHERE prgdocno <> 'ADJUSTMENT'
        AND prgPERCONTROL BETWEEN @StartPerControl and @EndPerControl;

    --==========================================
    -- Clean EE List
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EALEFSAHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EALEFSAHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
/*
    --433U9 - HH10     410713535 - Horton Holding, Inc.
    --857TO - HI15     410979135 - Horton Inc.
    DELETE dbo.U_EALEFSAHSA_EEList
    FROM dbo.U_EALEFSAHSA_EEList JOIN dbo.EMpcomp ON eeceeid=xeeid and eeccoid=xcoid
    WHERE eeceetype not in ('REG','INT','STU') or EecCoid not in ('433U9','857TO')
*/
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MFLEX,DCARE,LPFSA,HSAI,HSAF,HSAI1,HSAC1,HSACF,HSACI,HSAER';

    IF OBJECT_ID('U_EALEFSAHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EALEFSAHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EALEFSAHSA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EALEFSAHSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EALEFSAHSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhPerControl = LEFT(PdhPerControl,8)
        ,PdhDedCode
        -- Categorize Payroll Amounts
        ,PdhEEAmt = SUM(CASE WHEN PdhDedCode IN ('MFLEX','DCARE','LPFSA','HSAI','HSAF','HSAI1','HSAC1','HSACF','HSACI') AND PdhEECurAmt > 0 THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERAmt= SUM(CASE WHEN PdhDedCode IN ('HSAER') THEN PdhERCurAmt ELSE 0.00 END)  --put ER amounts in the EE column        
    INTO dbo.U_EALEFSAHSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EALEFSAHSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PDHPERCONTROL BETWEEN @StartPerControl and @EndPerControl
    GROUP BY PdhEEID, LEFT(PdhPerControl,8), PdhDedCode
    HAVING SUM(PdhEECurAmt) <> 0.00
    ;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EALEFSAHSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EALEFSAHSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EALEFSAHSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        --removed Employer Code 10/6/17
        --,drvEmployerCode = @EmployerCode  
        ,drvRecordType = 'CT'
        ,drvParticipantFileImportID = EepSSN 
        ,drvPlanName =    CASE
                            WHEN P.pdhDedCode =  'MFLEX' then 'Health FSA'
                            WHEN P.pdhDedCode =  'DCARE' then 'Dependent Care'
                            WHEN P.pdhDedCode =  'LPFSA' then 'Limited Purpose'
                            WHEN P.pdhDedCode IN ('HSAI','HSAF','HSAI1','HSAC1','HSACF','HSACI','HSAER') then 'HSA Program'
                        END
        ,drvContributionDate = @LastPayDate
        ,drvContributionDescription = CASE WHEN p.PdhERAmt > 0 THEN 'Employer Contribution' ELSE 'Payroll Deduction' END
        ,drvContributionAmount = CASE WHEN p.pdhDedCode = 'HSAER' THEN p.PdhERAmt
                                    ELSE
                                        --CASE WHEN p.PdhERAmt > 0 THEN p.PdhERAmt ELSE 
                                        p.PdhEEAmt 
                                        --END
                                    END
        ,drvAmountType = 'Actual'
        ,drvTaxYear = ''
        ,drvNotes = ''
        ,drvPLanYearStart = '0101' + LEFT(convert(varchar(8),@LastPayDate,112),4)
        ,drvPLanYearEnd = ''
    INTO dbo.U_EALEFSAHSA_drvTbl
    FROM dbo.U_EALEFSAHSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK) on xEEID = eepEEID
    JOIN dbo.U_EALEFSAHSA_PDedHist p WITH (NOLOCK) on xEEID = p.PdhEEID
    ;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EALEFSAHSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EALEFSAHSA_Header;
    SELECT DISTINCT
         hdrRecordType = 'FH'
        ,hdrAdminCode = @AdminCode
        ,hdrEmployerCode = @EmployerCode
        ,hdrSynchronizeFlag = 'Y'
        ,hdrCreatedDate = @CreateDate
        ,hdrCreatedTime = @CreateDate
        ,hdrFileVersion = '3.5'
    INTO dbo.U_EALEFSAHSA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EALEFSAHSA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EALEFSAHSA_Trailer;
    SELECT DISTINCT
         trlRecordType = 'FF'
        ,trlRecordCount = c.RecCount
        ,trlAdminCode = @AdminCode
        ,trlEmployerCode = @EmployerCode
        ,trlCreatedDate = @CreateDate
        ,trlCreatedTime = @CreateDate
    INTO dbo.U_EALEFSAHSA_Trailer
    FROM (select count(*) RecCount FROM dbo.U_EALEFSAHSA_drvTbl) c
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_ABHSAAMEO_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_ABHSAAMEO_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'ABHSAAMEO_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEALEFSAHSA_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EALEFSAHSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EALEFSAHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201709041'
       ,expStartPerControl     = '201709041'
       ,expLastEndPerControl   = '201709119'
       ,expEndPerControl       = '201709119'
WHERE expFormatCode = 'EALEFSAHSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEALEFSAHSA_Export AS
    SELECT TOP 200000000 Data FROM dbo.U_EALEFSAHSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort