SET NOCOUNT ON;
IF OBJECT_ID('U_EFHSAENROL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFHSAENROL_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFHSAENROL_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFHSAENROL' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFHSAENROL_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFHSAENROL_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFHSAENROL') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFHSAENROL];
GO
IF OBJECT_ID('U_EFHSAENROL_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFHSAENROL_PEarHist];
GO
IF OBJECT_ID('U_EFHSAENROL_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFHSAENROL_PDedHist];
GO
IF OBJECT_ID('U_EFHSAENROL_File') IS NOT NULL DROP TABLE [dbo].[U_EFHSAENROL_File];
GO
IF OBJECT_ID('U_EFHSAENROL_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFHSAENROL_EEList];
GO
IF OBJECT_ID('U_EFHSAENROL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EFHSAENROL_drvTbl];
GO
IF OBJECT_ID('U_EFHSAENROL_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFHSAENROL_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EFHSAENROL') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFHSAENROL];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFHSAENROL';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFHSAENROL';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFHSAENROL';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFHSAENROL';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFHSAENROL';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFHSAENROL','TASC FSA/HSA Enrollment','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EFHSAENROLZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFHSAENROL' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client TASC ID"','1','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','1',NULL,'Client TASC ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Individual TASC ID"','2','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','2',NULL,'Individual TASC ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','3','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Individual SSN"','4','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','4',NULL,'Individual SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','5','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','6','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Plan ID"','7','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','7',NULL,'Benefit Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Effective Date"','8','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','8',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Election Change Date"','9','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','9',NULL,'Election Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Eligibility End Date"','10','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','10',NULL,'Eligibility End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Individual Election Amount"','11','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','11',NULL,'Individual Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Election Amount"','12','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','12',NULL,'Client Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Disbursable Date"','13','(''DA''=''T,'')','EFHSAENROLZ0','50','H','01','13',NULL,'Disbursable Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Takeover Override"','14','(''DA''=''T'')','EFHSAENROLZ0','50','H','01','14',NULL,'Takeover Override',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"4900-0875-8130"','1','(''DA''=''T,'')','EFHSAENROLZ0','50','D','10','1',NULL,'Client TASC ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndTascId"','2','(''UA''=''T,'')','EFHSAENROLZ0','50','D','10','2',NULL,'Individual TASC ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','3','(''UA''=''T,'')','EFHSAENROLZ0','50','D','10','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T,'')','EFHSAENROLZ0','50','D','10','4',NULL,'Individual SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''T,'')','EFHSAENROLZ0','50','D','10','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EFHSAENROLZ0','50','D','10','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitPlanId"','7','(''UA''=''T,'')','EFHSAENROLZ0','50','D','10','7',NULL,'Benefit Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','8','(''UD101''=''T,'')','EFHSAENROLZ0','50','D','10','8',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectionChangeDate"','9','(''UD101''=''T,'')','EFHSAENROLZ0','50','D','10','9',NULL,'Election Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligiblityEndDate"','10','(''UD101''=''T,'')','EFHSAENROLZ0','50','D','10','10',NULL,'Eligibility End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndElectionAmt"','11','(''UA''=''T,'')','EFHSAENROLZ0','50','D','10','11',NULL,'Individual Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientElectionAmt"','12','(''UA''=''T,'')','EFHSAENROLZ0','50','D','10','12',NULL,'Client Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T,'')','EFHSAENROLZ0','50','D','10','13',NULL,'Disbursable Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T'')','EFHSAENROLZ0','50','D','10','14',NULL,'Takeover Override',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EFHSAENROL_20201215.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202101019','EMPEXPORT','OEACTIVE','Dec  1 2020  5:49PM','EFHSAENROL',NULL,NULL,NULL,'202101019','Jan  1 2021 12:00AM','Dec 30 1899 12:00AM','202011021','149','','','202011021',dbo.fn_GetTimedKey(),NULL,'us3lKiUNI1088',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202101019','EMPEXPORT','OEPASSIVE','Dec  1 2020  5:31PM','EFHSAENROL',NULL,NULL,NULL,'202101019','Jan  1 2021 12:00AM','Dec 30 1899 12:00AM','202011021','151','','','202011021',dbo.fn_GetTimedKey(),NULL,'us3lKiUNI1088',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'TASC FSA/HSA Enrollment','202006259','EMPEXPORT','ONDEMAND','Jun 29 2020  2:55PM','EFHSAENROL',NULL,NULL,NULL,'202006259','Jun 25 2020  5:57PM','Jun 25 2020  5:57PM','202006251','154','','','202006251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',',MURQ3',NULL,NULL,NULL,'TASC Enroll - Fridays 7:30pm','202006259','EMPEXPORT','SCHEDULED','Jun 29 2020  2:56PM','EFHSAENROL',NULL,NULL,NULL,'202006259','Jun 25 2020  5:57PM','Jun 25 2020  5:57PM','202006251','154','','','202006251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202010059','EMPEXPORT','TEST','Oct  5 2020  9:24AM','EFHSAENROL',NULL,NULL,NULL,'202010059','Oct  5 2020 12:00AM','Dec 30 1899 12:00AM','202009211','143','','','202009211',dbo.fn_GetTimedKey(),NULL,'us3lKiUNI1088',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFHSAENROL','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFHSAENROL','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFHSAENROL','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFHSAENROL','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFHSAENROL','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EFHSAENROL' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EFHSAENROL' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EFHSAENROL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFHSAENROL_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFHSAENROL','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFHSAENROL','D10','dbo.U_EFHSAENROL_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EFHSAENROL') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFHSAENROL] (
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
IF OBJECT_ID('U_EFHSAENROL_DedList') IS NULL
CREATE TABLE [dbo].[U_EFHSAENROL_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFHSAENROL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EFHSAENROL_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvIndTascId] varchar(1) NOT NULL,
    [drvEmployeeID] char(11) NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvBenefitPlanId] varchar(10) NULL,
    [drvEffectiveDate] datetime NULL,
    [drvElectionChangeDate] datetime NULL,
    [drvEligiblityEndDate] datetime NULL,
    [drvIndElectionAmt] nvarchar(4000) NULL,
    [drvClientElectionAmt] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EFHSAENROL_EEList') IS NULL
CREATE TABLE [dbo].[U_EFHSAENROL_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFHSAENROL_File') IS NULL
CREATE TABLE [dbo].[U_EFHSAENROL_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EFHSAENROL_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFHSAENROL_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);
IF OBJECT_ID('U_EFHSAENROL_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFHSAENROL_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFHSAENROL]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: United Prairie

Created By: James Bender
Business Analyst: Lea King
Create Date: 06/25/2020
Service Request Number: TekP-2020-03-10-0008

Purpose: TASC FSA/HSA Enrollment

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFHSAENROL';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFHSAENROL';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFHSAENROL';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFHSAENROL';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFHSAENROL' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFHSAENROL', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFHSAENROL', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFHSAENROL', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFHSAENROL';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFHSAENROL', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@FileMinCovDate    DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EFHSAENROL';
    SELECT @FileMinCovDate = '1/1/2020';

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
    DELETE FROM dbo.U_EFHSAENROL_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFHSAENROL_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '461,450,451,452,442, 443, 444, 447, 448'; --, 596, 597';

    IF OBJECT_ID('U_EFHSAENROL_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFHSAENROL_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFHSAENROL_DedList
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
    IF OBJECT_ID('U_EFHSAENROL_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFHSAENROL_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EFHSAENROL_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFHSAENROL_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EFHSAENROL_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFHSAENROL_PEarHist;
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
    INTO dbo.U_EFHSAENROL_PEarHist
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
    -- DETAIL RECORD - U_EFHSAENROL_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EFHSAENROL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFHSAENROL_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' --ISNULL(Ded_596, '') + ' :: ' + ISNULL(Ded_597, '') --BdmDedCode + ' : ' + CAST(BdmEEGoalAmt AS VARCHAR) --'' --EdhBenStartDate -- BdmDedCode + ' :: ' + BdmBenStatus + ' :: ' + FORMAT(BdmEEGoalAmt, '#0.00')
        -- standard fields above and additional driver fields below
        ,drvIndTascId = '' --epSSN
        ,drvEmployeeID = eepSSN
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvBenefitPlanId =    CASE WHEN BdmDedCode IN ('461') THEN '1000103325'
                                WHEN BdmDedCode IN ('451') THEN '1000103328'
                                WHEN BdmDedCode IN ('450') THEN '1000103330'
                                WHEN BdmDedCode IN ('452') THEN '1000103332'
                                WHEN BdmDedCode IN ('442','443','444','447','448','596','597') THEN '1000065146'
                            END
        ,drvEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '1/1/2021')
        ,drvElectionChangeDate = dbo.dsi_fnGetMinMaxDates('MAX',CASE WHEN EdhBenStartDate IS NOT NULL AND EdhBenStartDate > BdmBenStartDate THEN EdhBenStartDate END, '1/1/2021')
        ,drvEligiblityEndDate = BdmBenStopDate
        ,drvIndElectionAmt =    CASE WHEN BdmDedCode NOT IN ('442','443','444','447','448','596','597') THEN FORMAT(BdmEEGoalAmt, '#0.00') 
                                    ELSE (SELECT FORMAT(SUM(BdmEEGoalAmt), '#0.00') FROM dbo.U_dsi_BDM_EFHSAENROL WITH (NOLOCK) WHERE BdmDedCode IN ('442','443','444','447','448','596','597') AND BdmEEID = xEEID) 
                                END
        ,drvClientElectionAmt =    FORMAT(CASE WHEN Ded_596 IS NOT NULL OR Ded_597 IS NOT NULL THEN
                                    CASE WHEN (SELECT SUM(BdmEEGoalAmt) FROM dbo.U_dsi_BDM_EFHSAENROL WITH (NOLOCK) WHERE BdmDedCode IN ('442','443','444','447','448') AND BdmEEID = xEEID) >= 1000 THEN 1000
                                        ELSE (SELECT SUM(BdmEEGoalAmt) FROM dbo.U_dsi_BDM_EFHSAENROL WITH (NOLOCK) WHERE BdmDedCode IN ('442','443','444','447','448') AND BdmEEID = xEEID)
                                    END
                                    ELSE 0.00
                                END, '#0.00')
    INTO dbo.U_EFHSAENROL_drvTbl
    FROM dbo.U_EFHSAENROL_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFHSAENROL WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (
                SELECT EdhEEID, EdhCOID, EdhDedCode, EdhBenStartDate 
                FROM(
                    SELECT EdhEEID, EdhCOID, EdhDedCode, EdhBenStartDate, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhBenStartDAte DESC) AS RN
                    FROM dbo.EmpHDed WITH (NOLOCK)
                    WHERE EdhDedCode IN ('461','450','451','452','442', '443', '444', '447', '448', '596', '597')
                    AND EdhBenStatus = 'A'
                    AND EdhBenStartDate > @FileMinCovDate
                ) AS T) AS X
                ON EdhEEID = xEEID
                AND EdhCOID = xCOID
                AND BdmDedCode = EdhDedCode
    LEFT JOIN (
                SELECT EedEEID, EedCOID
                    ,MAX(CASE WHEN EedDedCode = '596' THEN EedDedCode END) AS Ded_596
                    ,MAX(CASE WHEN EedDedCode = '597' THEN EedDedCode END) AS Ded_597
                FROM dbo.EmpDed WITH (NOLOCK)
                WHERE EedDedCode IN ('596','597')
                GROUP BY EedEEID, EedCOID) AS Ded_59
        ON EedEEID = xEEID
        AND EedCOID = xCOID
    WHERE BdmBenStartDate <= DATEADD(DAY, 30, @ENDDATE)
        AND (BdmBenStopDate IS NULL OR BdmBenStopDate <= DATEADD(DAY, 30, @ENDDATE))
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
ALTER VIEW dbo.dsi_vwEFHSAENROL_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFHSAENROL_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFHSAENROL%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202006181'
       ,expStartPerControl     = '202006181'
       ,expLastEndPerControl   = '202006259'
       ,expEndPerControl       = '202006259'
WHERE expFormatCode = 'EFHSAENROL';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFHSAENROL_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFHSAENROL_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort