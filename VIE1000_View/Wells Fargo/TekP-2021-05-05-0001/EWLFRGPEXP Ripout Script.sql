SET NOCOUNT ON;
IF OBJECT_ID('U_EWLFRGPEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EWLFRGPEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EWLFRGPEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EWLFRGPEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEWLFRGPEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWLFRGPEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWLFRGPEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWLFRGPEXP];
GO
IF OBJECT_ID('U_EWLFRGPEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EWLFRGPEXP_Trailer];
GO
IF OBJECT_ID('U_EWLFRGPEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EWLFRGPEXP_PEarHist];
GO
IF OBJECT_ID('U_EWLFRGPEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EWLFRGPEXP_Header];
GO
IF OBJECT_ID('U_EWLFRGPEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EWLFRGPEXP_File];
GO
IF OBJECT_ID('U_EWLFRGPEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWLFRGPEXP_EEList];
GO
IF OBJECT_ID('U_EWLFRGPEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EWLFRGPEXP_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EWLFRGPEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EWLFRGPEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EWLFRGPEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EWLFRGPEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EWLFRGPEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EWLFRGPEXP','Wells Fargo Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EWLFRGPEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EWLFRGPEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','1','(''DA''=''F'')','EWLFRGPEXPZ0','1','H','01','1',NULL,'Logical Record ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000000"','2','(''DA''=''F'')','EWLFRGPEXPZ0','9','H','01','2',NULL,'Logical Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CA00320426"','3','(''DA''=''F'')','EWLFRGPEXPZ0','10','H','01','11',NULL,'Originator ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','4','(''DA''=''F'')','EWLFRGPEXPZ0','4','H','01','21',NULL,'File Creation Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreationDate"','5','(''UA''=''F'')','EWLFRGPEXPZ0','6','H','01','25',NULL,'File Creation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''F'')','EWLFRGPEXPZ0','5','H','01','31',NULL,'Destination Processing Center',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''F'')','EWLFRGPEXPZ0','20','H','01','36',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDestinationCurrencyCode"','8','(''UA''=''F'')','EWLFRGPEXPZ0','3','H','01','56',NULL,'Destination Currency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','EWLFRGPEXPZ0','1406','H','01','59',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CA00320426"','1','(''DA''=''F'')','EWLFRGPEXPZ0','1','D','10','1',NULL,'Logical Record ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000000"','2','(''DA''=''F'')','EWLFRGPEXPZ0','9','D','10','2',NULL,'Logical Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EWLFRGPEXPZ0','10','D','10','11',NULL,'Originator ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''F'')','EWLFRGPEXPZ0','4','D','10','21',NULL,'File Creation Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"200"','5','(''DA''=''F'')','EWLFRGPEXPZ0','3','D','10','25',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPaymentAmount"','6','(''UA''=''F'')','EWLFRGPEXPZ0','10','D','10','28',NULL,'Payment Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateFundsAvailable"','7','(''UA''=''F'')','EWLFRGPEXPZ0','6','D','10','38',NULL,'Date Funds To Be Available',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInstituteIdNumber"','8','(''UA''=''F'')','EWLFRGPEXPZ0','9','D','10','44',NULL,'Institutional Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayeeAccountNumber"','9','(''UA''=''F'')','EWLFRGPEXPZ0','12','D','10','53',NULL,'Payee Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EWLFRGPEXPZ0','22','D','10','65',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''F'')','EWLFRGPEXPZ0','3','D','10','87',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VIEW SMART BUIL"','12','(''DA''=''F'')','EWLFRGPEXPZ0','15','D','10','90',NULL,'Customer Short Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayeeName"','13','(''UA''=''F'')','EWLFRGPEXPZ0','30','D','10','105',NULL,'Payee Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCutomerName"','14','(''UA''=''F'')','EWLFRGPEXPZ0','30','D','10','135',NULL,'Customer Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''F'')','EWLFRGPEXPZ0','10','D','10','165',NULL,'Originating Direct Clearer’s User’s Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EWLFRGPEXPZ0','19','D','10','175',NULL,'Originator’s Cross Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000000"','17','(''DA''=''F'')','EWLFRGPEXPZ0','9','D','10','194',NULL,'Institute ID Number for Returns',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','EWLFRGPEXPZ0','12','D','10','203',NULL,'Account Number for Returns',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginatorSundryInfo"','19','(''UA''=''F'')','EWLFRGPEXPZ0','15','D','10','215',NULL,'Originator’s Sundry Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EWLFRGPEXPZ0','22','D','10','230',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','EWLFRGPEXPZ0','2','D','10','252',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''F'')','EWLFRGPEXPZ0','11','D','10','254',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Z"','1','(''DA''=''F'')','EWLFRGPEXPZ0','1','T','90','1',NULL,'Logical Record ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000000"','2','(''DA''=''F'')','EWLFRGPEXPZ0','9','T','90','2',NULL,'Logical Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CA00320426"','3','(''DA''=''F'')','EWLFRGPEXPZ0','10','T','90','11',NULL,'Originator ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','4','(''DA''=''F'')','EWLFRGPEXPZ0','4','T','90','21',NULL,'File Creation Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000000000000"','5','(''DA''=''F'')','EWLFRGPEXPZ0','14','T','90','25',NULL,'Debit Payment Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000000"','6','(''DA''=''F'')','EWLFRGPEXPZ0','8','T','90','39',NULL,'Debit Payment Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCreditPaymentAmount"','7','(''UA''=''F'')','EWLFRGPEXPZ0','14','T','90','47',NULL,'Credit Payment Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCredPaymentCount"','8','(''UA''=''F'')','EWLFRGPEXPZ0','8','T','90','61',NULL,'Credit Payment Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','EWLFRGPEXPZ0','1396','T','90','69',NULL,'Reserved',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EWLFRGPEXP_20210701.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Wells Fargo Payroll Export','202107021','EMPEXPORT','ONDEM_XOE',NULL,'EWLFRGPEXP',NULL,NULL,NULL,'202107021','Jun 17 2021 10:10AM','Jun 17 2021 10:10AM','202107021',NULL,'','','202107021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Wells Fargo Payroll Expo-Sched','202107021','EMPEXPORT','SCH_EWLFRG',NULL,'EWLFRGPEXP',NULL,NULL,NULL,'202107021','Jun 17 2021 10:10AM','Jun 17 2021 10:10AM','202107021',NULL,'','','202107021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Wells Fargo Payroll Expo-Test','202107021','EMPEXPORT','TEST_XOE','Jul  1 2021 10:14AM','EWLFRGPEXP',NULL,NULL,NULL,'202107021','Jun 18 2021 12:00AM','Dec 30 1899 12:00AM','202107021','5','','','202107021',dbo.fn_GetTimedKey(),NULL,'us3lKiVIE1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWLFRGPEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWLFRGPEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWLFRGPEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWLFRGPEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWLFRGPEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EWLFRGPEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EWLFRGPEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EWLFRGPEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EWLFRGPEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWLFRGPEXP','H01','dbo.U_EWLFRGPEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWLFRGPEXP','D10','dbo.U_EWLFRGPEXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWLFRGPEXP','T90','dbo.U_EWLFRGPEXP_Trailer',NULL);
IF OBJECT_ID('U_EWLFRGPEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EWLFRGPEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvPaymentAmount] nvarchar(4000) NULL,
    [drvDateFundsAvailable] varchar(6) NULL,
    [drvInstituteIdNumber] varchar(9) NULL,
    [drvPayeeAccountNumber] char(22) NOT NULL,
    [drvPayeeName] varchar(201) NULL,
    [drvCutomerName] varchar(34) NOT NULL,
    [drvOriginatorSundryInfo] varchar(19) NULL
);
IF OBJECT_ID('U_EWLFRGPEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EWLFRGPEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EWLFRGPEXP_File') IS NULL
CREATE TABLE [dbo].[U_EWLFRGPEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EWLFRGPEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EWLFRGPEXP_Header] (
    [drvFileCreationDate] int NULL,
    [drvDestinationCurrencyCode] char(3) NULL
);
IF OBJECT_ID('U_EWLFRGPEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EWLFRGPEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgDocNo] char(10) NULL,
    [PrgCurrencyCode] char(3) NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
IF OBJECT_ID('U_EWLFRGPEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EWLFRGPEXP_Trailer] (
    [drvCreditPaymentAmount] nvarchar(4000) NULL,
    [drvCredPaymentCount] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWLFRGPEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: View Inc

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 06/17/2021
Service Request Number: TekP-2021-05-05-0001

Purpose: Wells Fargo Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWLFRGPEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWLFRGPEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWLFRGPEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWLFRGPEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWLFRGPEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWLFRGPEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWLFRGPEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWLFRGPEXP', 'SCH_EWLFRG';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EWLFRGPEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWLFRGPEXP';

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
    DELETE FROM dbo.U_EWLFRGPEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWLFRGPEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --DELETE TEST/BAD EMPLOYEES
    DELETE EE
    FROM dbo.U_EWLFRGPEXP_EEList EE
    JOIN dbo.EmpComp WITH (NOLOCK)
      ON EecEEID = xEEID
     AND EecCOID = xCOID
        JOIN dbo.EmpPers WITH (NOLOCK)
      ON EepEEID = xEEID
    WHERE EecEEType = 'TES';
        

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EWLFRGPEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWLFRGPEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgDocNo = MAX(PrgDocNo)
        ,PrgCurrencyCode = MAX(PrgCurrencyCode)
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
    INTO dbo.U_EWLFRGPEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = PehEEID
       AND EecCoID = PehCOID
       AND EecPayGroup = 'CANBW'
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    --PehPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EWLFRGPEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EWLFRGPEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWLFRGPEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvPaymentAmount = FORMAT(PrhDepositAmt*100, '0000000000')
        ,drvDateFundsAvailable = RIGHT('000'+CAST(YEAR(PrgPayDate) AS VARCHAR(4)),3) + RIGHT('000' + CAST(DATEPART(dy, PrgPayDate) AS varchar(3)),3) 
        ,drvInstituteIdNumber =  Right('000000000' + rtrim(ltrim(isnull(EddEEInstitutionNo,''))) + rtrim(ltrim(isnull(EddEeBankRoute,''))),9)
        ,drvPayeeAccountNumber = EddAcct
        ,drvPayeeName = EepNameFirst + ' ' + EepNameLast
        ,drvCutomerName = 'VIEW SMART BUILDING TECHNOLOGY INC'
        ,drvOriginatorSundryInfo = LTRIM(RTRIM(EecEmpNo)) + LTRIM(PrgDocNo)
    INTO dbo.U_EWLFRGPEXP_drvTbl
    FROM dbo.U_EWLFRGPEXP_EEList WITH (NOLOCK)
    JOIN dbo.PdirHist WITH (NOLOCK)
        ON PrhEEID = xEEID
        AND PrhCOID = xCOID
    JOIN dbo.U_EWLFRGPEXP_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.EmpDirdp WITH (NOLOCK)
        ON EddEEID = xEEID
        AND EddCOID = xCOID
        AND PrhEEBankRoute = EddEEBankRoute
        AND PrhAcct = EddAcct
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecPayGroup = 'CANBW' 
    WHERE PrhPerControl BETWEEN @StartPerControl AND @EndPerControl
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EWLFRGPEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EWLFRGPEXP_Header;
    SELECT TOP 1
         drvFileCreationDate = (SELECT (DATEPART(YEAR, GETDATE())-1900)*1000 + DATEPART(DY, GETDATE()))
        ,drvDestinationCurrencyCode = PrgCurrencyCode
    INTO dbo.U_EWLFRGPEXP_Header
    FROM dbo.U_EWLFRGPEXP_EEList WITH (NOLOCK) 
    JOIN dbo.U_EWLFRGPEXP_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EWLFRGPEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EWLFRGPEXP_Trailer;
    SELECT DISTINCT
         drvCreditPaymentAmount = FORMAT((SELECT SUM(CAST(drvPaymentAmount AS MONEY))/100 FROM dbo.U_EWLFRGPEXP_drvTbl WITH (NOLOCK))*100, '00000000000000')
        ,drvCredPaymentCount = FORMAT((SELECT COUNT(*) FROM dbo.U_EWLFRGPEXP_drvTbl WITH (NOLOCK)), '00000000')
    INTO dbo.U_EWLFRGPEXP_Trailer
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
ALTER VIEW dbo.dsi_vwEWLFRGPEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWLFRGPEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EWLFRGPEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107021'
       ,expStartPerControl     = '202107021'
       ,expLastEndPerControl   = '202107021'
       ,expEndPerControl       = '202107021'
WHERE expFormatCode = 'EWLFRGPEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEWLFRGPEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EWLFRGPEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort