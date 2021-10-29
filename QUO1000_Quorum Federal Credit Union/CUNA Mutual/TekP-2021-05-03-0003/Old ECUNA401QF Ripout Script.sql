SET NOCOUNT ON;
IF OBJECT_ID('U_ECUNA401QF_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECUNA401QF_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECUNA401QF_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECUNA401QF' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECUNA401QF_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECUNA401QF_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECUNA401QF') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECUNA401QF];
GO
IF OBJECT_ID('U_ECUNA401QF_File') IS NOT NULL DROP TABLE [dbo].[U_ECUNA401QF_File];
GO
IF OBJECT_ID('U_ECUNA401QF_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECUNA401QF_EEList];
GO
IF OBJECT_ID('U_dsi_ECUNA401QF_TrlTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECUNA401QF_TrlTbl];
GO
IF OBJECT_ID('U_dsi_ECUNA401QF_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECUNA401QF_drvTbl];
GO
IF OBJECT_ID('U_dsi_ECUNA401QF_DedHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECUNA401QF_DedHist];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECUNA401QF';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECUNA401QF';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECUNA401QF';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECUNA401QF';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECUNA401QF';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','ECUNA401QF','CUNA - 401k','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ECUNA401QFZ0','N',NULL,'C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECUNA401QF' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Name"','1','(''DA''=''T,'')','ECUNA401QFZ0','50','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','2','(''DA''=''T,'')','ECUNA401QFZ0','50','H','01','51',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE 401K Contribution Pre-Tax"','3','(''DA''=''T,'')','ECUNA401QFZ0','50','H','01','101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE 401K Roth Contributions                                                                                                                                                                                                                        "','4','(''DA''=''T,'')','ECUNA401QFZ0','50','H','01','151',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ER Match Contributions"','5','(''DA''=''T,'')','ECUNA401QFZ0','50','H','01','201',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Pymts"','6','(''DA''=''T,'')','ECUNA401QFZ0','50','H','01','251',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total for Participant"','7','(''DA''=''T,'')','ECUNA401QFZ0','50','H','01','301',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Date"','8','(''DA''=''T,'')','ECUNA401QFZ0','50','H','01','351',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period From"','9','(''DA''=''T,'')','ECUNA401QFZ0','50','H','01','401',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period To"','10','(''DA''=''T,'')','ECUNA401QFZ0','50','H','01','451',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emloyer Name"','11','(''DA''=''T,'')','ECUNA401QFZ0','50','H','01','501',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contract #"','12','(''DA''=''T,'')','ECUNA401QFZ0','50','H','01','551',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Anniv Date"','13','(''DA''=''T'')','ECUNA401QFZ0','50','H','01','601',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpName"','1','(''UA''=''T,'')','ECUNA401QFZ0','50','D','02','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','ECUNA401QFZ0','50','D','02','51',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEContr"','3','(''UA''=''T,'')','ECUNA401QFZ0','50','D','02','101',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEERothContr"','4','(''UA''=''T,'')','ECUNA401QFZ0','50','D','02','151',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERMatchContr"','5','(''UA''=''T,'')','ECUNA401QFZ0','50','D','02','201',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPmt"','6','(''UA''=''T,'')','ECUNA401QFZ0','50','D','02','251',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartTotal"','7','(''UA''=''T,'')','ECUNA401QFZ0','50','D','02','301',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayDate"','8','(''UA''=''T,'')','ECUNA401QFZ0','50','D','02','351',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFromPayPer"','9','(''UA''=''T,'')','ECUNA401QFZ0','50','D','02','401',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvToPayPer"','10','(''UA''=''T,'')','ECUNA401QFZ0','50','D','02','451',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmlName"','11','(''UA''=''T,'')','ECUNA401QFZ0','50','D','02','501',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNo"','12','(''UA''=''T,'')','ECUNA401QFZ0','50','D','02','551',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnivDate"','13','(''UA''=''T'')','ECUNA401QFZ0','50','D','02','601',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotals"','1','(''UA''=''T,'')','ECUNA401QFZ0','50','T','03','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','2','(''SS''=''T,'')','ECUNA401QFZ0','50','T','03','51',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotEEContr"','3','(''UA''=''T,'')','ECUNA401QFZ0','50','T','03','101',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotEERothContr"','4','(''UA''=''T,'')','ECUNA401QFZ0','50','T','03','151',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotERMatchContr"','5','(''UA''=''T,'')','ECUNA401QFZ0','50','T','03','201',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotLoanPmt"','6','(''UA''=''T,'')','ECUNA401QFZ0','50','T','03','251',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotPartTotal"','7','(''UA''=''T'')','ECUNA401QFZ0','50','T','03','301',NULL,'',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECUNA401QF_20211026.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'OE','201312099','EMPEXPORT','ECUNA401OE',NULL,'ECUNA401QF',NULL,NULL,NULL,'201312099',NULL,NULL,'201309101',NULL,NULL,NULL,'201309101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'ECUNA401QF export','201401031','EMPEXPORT','ECUNA401QF','Jan  2 2014 12:00AM','ECUNA401QF',NULL,NULL,NULL,'201401031','Jan  3 2014 12:00AM','Dec 27 2013 12:00AM','201401011','119','','','201401011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPQFCU',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'TEST','201408019','EMPEXPORT','TEST','Jul 30 2014  3:05PM','ECUNA401QF',NULL,NULL,NULL,'201408019','Aug  1 2014 12:00AM','Dec 30 1899 12:00AM','201408011','129','','','201408011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPQFCU',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'unlock ECUNA401QF','201312099','EMPEXPORT','ZAP',NULL,'ECUNA401QF',NULL,NULL,NULL,'201312099',NULL,NULL,'201309101',NULL,NULL,NULL,'201309101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','ExportDescription','C','Quorum Federal CU - CUNA - 401k');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','MaxFileLength','C','664');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','SystemID','V','9VUGIG0030K0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECUNA401QF' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECUNA401QF' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECUNA401QF_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECUNA401QF_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUNA401QF','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUNA401QF','D02','dbo.U_dsi_ECUNA401QF_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUNA401QF','T03','dbo.U_dsi_ECUNA401QF_TrlTbl',NULL);
IF OBJECT_ID('U_dsi_ECUNA401QF_DedHist') IS NULL
CREATE TABLE [dbo].[U_dsi_ECUNA401QF_DedHist] (
    [heeid] char(12) NULL,
    [hcoid] char(5) NULL,
    [hdedcode] char(5) NOT NULL,
    [heecalcrateorpct] decimal NULL,
    [heeamt] money NULL,
    [heramt] money NULL
);
IF OBJECT_ID('U_dsi_ECUNA401QF_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ECUNA401QF_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvEmpName] varchar(8000) NULL,
    [drvSSN] varchar(11) NULL,
    [drvEEContr] money NULL,
    [drvEERothContr] money NULL,
    [drvERMatchContr] money NULL,
    [drvLoanPmt] money NULL,
    [drvPartTotal] money NULL,
    [drvPayDate] varchar(10) NULL,
    [drvFromPayPer] varchar(10) NULL,
    [drvToPayPer] varchar(10) NULL,
    [drvEmlName] varchar(10) NOT NULL,
    [drvContractNo] varchar(10) NOT NULL,
    [drvAnnivDate] varchar(5) NOT NULL
);
IF OBJECT_ID('U_dsi_ECUNA401QF_TrlTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ECUNA401QF_TrlTbl] (
    [drvrectype] varchar(1) NOT NULL,
    [drvTotals] varchar(6) NOT NULL,
    [drvTotEEContr] money NULL,
    [drvTotEERothContr] money NULL,
    [drvTotERMatchContr] money NULL,
    [drvTotLoanPmt] money NULL,
    [drvTotPartTotal] money NULL
);
IF OBJECT_ID('U_ECUNA401QF_EEList') IS NULL
CREATE TABLE [dbo].[U_ECUNA401QF_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECUNA401QF_File') IS NULL
CREATE TABLE [dbo].[U_ECUNA401QF_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_ECUNA401QF'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_ECUNA401QF',getdate(),'P','V1.HA'
*/

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECUNA401QF]
 @systemid varchar(12) = ''
AS
Begin


/*************************************************************************************************
DRIVER TABLE SP FOR:  CUNA Mutual
BUILT FOR: Quorum Federal Credit Union
ORIGINAL BUILD (V-1.0): 11/9/2013 - tdodson  - SF 02919645
*************************************************************************************************/

-- Collect the @Start and @End Percontrol/PayDates upfront

    /***************************
    COLLECT DATE PARAMETERS
    ****************************/
    DECLARE 
        @StartDate DATETIME,
        @EndDate DATETIME,
        @StartPerControl Char(9),
        @EndPerControl Char(9),
        @FormatCode Char(10),
        @ExportCode Char(10),
        @ExportFile char(200)
        
    --    Declare @Systemid char(12) 
    --    set @Systemid = '6DWPQL0000K0'

    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = rtrim(formatcode),
        @ExportCode = Exportcode,
        @Exportfile = ExportFile

    FROM dbo.U_Dsi_Parameters 
    WHERE SystemID = @SystemID

        
-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 14    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'Y'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'        -- P or F indicates if this export is for a passive or full(active) oe


-- clean up EELIST if needed


-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_ECUNA401QF_EELIST
            from dbo.u_ECUNA401QF_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end



--BDM
-- replace ECRE401COE with the OE session if applicable

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','401CP,401P,401KR,401RC,401L,401L2,401M') --not 401L1 11/2/14 drn

IF @ExportCode <> 'ECRE401COE' BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)    --@EndDate - @daysstopped)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END
IF @ExportCode = 'ECRE401COE' BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'stopdate')    --'ActiveOnly')    --'stoptdate')    --'AuditDate')

IF @ExportCode = 'ECRE401COE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')    --'Active')
END


EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode


--- LAstpaydate


--    left join (select eeceeid eeid, eeccoid coid, pgppaydate lastcheck
--                from empcomp
--                join pgpayper on eecpaygroup = pgppaygroup
--                where eecdateoftermination >= pgpperiodstartdate
--                and eecdateoftermination <= pgpperiodenddate) ppd on eeid = xeeid and coid = xcoid



-- Step20 Clean up eelist if needed to only include employees with deductions
--            delete dbo.u_ECUNA401QF_eelist
--            from dbo.u_ECUNA401QF_eelist a
--            where not exists(select 1 from U_dsi_bdm_EmpDeductions
--                            where a.xeeid = eedeeid
--                            and a.xcoid = eedcoid
--                            and eedformatcode = @formatcode
--                            and eedvalidforexport = 'Y')


-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_ECUNA401QF_EELIST
            from dbo.u_ECUNA401QF_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_ECUNA401QF_eelist
            from dbo.u_ECUNA401QF_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_ECUNA401QF_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end

--Clean up Terms from Deductions and EEList
--        delete U_dsi_bdm_EmpDeductions
--            from U_dsi_bdm_EmpDeductions left join empcomp on eedeeid = eeceeid
--        where eedFormatCode = @FormatCode
--            and eedValidForExport = 'Y'
--            and eecDateofTermination is not null
--            and @daysstopped + eecDateofTermination < getdate()
--
--        delete dbo.u_ECUNA401QF_eelist
--            from dbo.u_ECUNA401QF_eelist left join empcomp on xeeid = eeceeid and xcoid = eeccoid
--        where eecDateofTermination is not null
--            and @daysstopped + eecDateofTermination < getdate()



if object_id('U_dsi_ECUNA401QF_DedHist') is not null
  drop table U_dsi_ECUNA401QF_DedHist

SELECT
    xEEID heeid,
    xCOID hcoid,
    pdhdedcode hdedcode,
    SUM(ISNULL(pdhEECalcRateOrPct,0.00)) as heecalcrateorpct,
    SUM(ISNULL(PDHEECURAMT,0.00)) AS heeamt,
    SUM(ISNULL(PDHERCURAMT,0.00)) AS heramt

    INTO dbo.U_dsi_ECUNA401QF_DedHist
        from dbo.u_ECUNA401QF_EELIST 
    JOIN PDEDHIST (nolock) ON xeeid = PdhEEID and xCOID = PdhCOID
        AND (PDHEECURAMT <> 0 or PDHERCURAMT <> 0)
        AND PDHDEDCODE IN ('401CP','401P','401KR','401RC','401L','401L2','401M')
        --AND PDHPERCONTROL BETWEEN '20010901' and '20040924'
        --AND PDHPERCONTROL BETWEEN substring(@StartPerControl,1,4) and substring(@EndPerControl,1,4)
        AND PDHPERCONTROL BETWEEN @StartPerControl and @EndPerControl                                --12/10/13 drn
    GROUP BY xEEID,xCOID,PdhDedCode,pdhEECalcRateOrPct


/*  not used - 12/10/13 drn
/****Create Table: U_ds_ECUNA401QF_EarnsCUR***/

if object_id('dbo.U_dsi_ECUNA401QF_EarnsCUR') is not null
  drop table dbo.U_dsi_ECUNA401QF_EarnsCUR

SELECT
    xEEID eeeid,
    xCOID ecoid,
    SUM(ISNULL(pehCurAmt,0.00)) AS eamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ehrs

INTO dbo.U_dsi_ECUNA401QF_EarnsCUR
        from dbo.u_ECUNA401QF_EELIST 
    JOIN PEARHIST(nolock) ON xeeid = pehEEID and xCOID = PehCOID
    AND PEHPERCONTROL BETWEEN @StartPerControl and @EndPerControl
        AND pehInclInDefComp = 'Y'
    GROUP BY xEEID,xCOID


-- YTD Plan compensation
if object_id('U_dsi_ECUNA401QF_DefCompHist') is not null
  drop table dbo.U_dsi_ECUNA401QF_DefCompHist

SELECT
    xEEID dceeid,
    xCOID dccoid,
    SUM(ISNULL(pehCurAmt,0.00)) AS dcamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS dchrs

    INTO dbo.U_dsi_ECUNA401QF_DefCompHist
        from dbo.u_ECUNA401QF_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
    AND PEHPERCONTROL BETWEEN @StartPerControl and @EndPerControl
        AND pehInclInDefComp = 'Y'
    GROUP BY xEEID,xCOID

---

-- YTD Plan compensation W2
if object_id('U_dsi_ECUNA401QF_DefCompHistW2') is not null
  drop table dbo.U_dsi_ECUNA401QF_DefCompHistW2

SELECT
    xEEID dceeid,
    xCOID dccoid,
    SUM(ISNULL(pehCurAmt,0.00)) AS dcamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS dchrs

    INTO dbo.U_dsi_ECUNA401QF_DefCompHistW2
        from dbo.u_ECUNA401QF_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
AND PEHPERCONTROL BETWEEN @StartPerControl and @EndPerControl
        ---AND pehInclInDefComp = 'Y'
    GROUP BY xEEID,xCOID
    
    
*/

-- Populate Source for Employees

if object_id('U_dsi_ECUNA401QF_drvTbl') is not null
  drop table dbo.U_dsi_ECUNA401QF_drvTbl

-- EE Detail

  select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
-- standard fields above and additional driver fields below

    drvEmpName = replace(eepnamelast,',','') + ' '+ eepnamefirst,                                        --strip out any commas 12/10/13
    drvSSN = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),
    drvEEContr = C.eeamt,
    drvEERothContr = R.eeamt,
    drvERMatchContr = M.eramt,
    drvLoanPmt = L.eeamt,
    drvPartTotal = isnull(C.eeamt,0) + isnull(R.eeamt,0) + isnull(M.eramt,0) + isnull(L.eeamt,0),        --added IsNulls 12/10/13 drn
    drvPayDate = convert(varchar(10),period.paydt,101),                                                    --convert(varchar(10),EecLastRegPayDate,101),
    drvFromPayPer = convert(varchar(10),period.pdstdt,101),                                                --convert(varchar(10),@StartDate,101),
    drvToPayPer = convert(varchar(10),period.pdenddt,101),                                                --convert(varchar(10),@EndDate,101),
    drvEmlName = 'QUORUM FCU',
    drvContractNo = '031-1855-9',
    drvAnnivDate = '12/31'  --convert(varchar(10),'12/31/13',101)                                    --'31-Dec'

  into dbo.U_dsi_ECUNA401QF_drvTbl
  from dbo.u_ECUNA401QF_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID
    join empcomp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    left join (SELECT MAX(PgpPayDate) paydt, MAX(PGPPERIODSTARTDATE) pdstdt,MAX(PGPPERIODENDDATE) pdenddt    --12/10/13 drn
            FROM PgPayPer
            --WHERE PgpPayDate <= @EndDate) AS period on 1=1 7/30/2014 DJakes 04095431 Removed the < so it would select the correct start date based on the pay date
            WHERE PgpPayDate = @EndDate) AS period on 1=1  
--401K Contribution    
    left join(select heeid eeid, hcoid coid, sum(heeamt) eeamt, sum(heramt) eramt
        from dbo.U_dsi_ECUNA401QF_DedHist
        where hdedcode in ('401CF','401P','401CP')
        group by heeid, hcoid) C on C.eeid = xEEID and C.coid = xCOID
--MATCH
    left join(select heeid eeid, hcoid coid, sum(heeamt) eeamt, sum(heramt) eramt
        from dbo.U_dsi_ECUNA401QF_DedHist
        where hdedcode in ('401M')
        group by heeid, hcoid) M on M.eeid = xEEID and M.coid = xCOID
--ROTH
    left join(select heeid eeid, hcoid coid, sum(heeamt) eeamt, sum(heramt) eramt
        from dbo.U_dsi_ECUNA401QF_DedHist
        where hdedcode in ('401KR','401RC')
        group by heeid, hcoid) R on R.eeid = xEEID and R.coid = xCOID
-- LOAN
left join(select heeid eeid, hcoid coid, sum(heeamt) eeamt, sum(heramt) eramt
        from dbo.U_dsi_ECUNA401QF_DedHist
        where hdedcode in ('401L','401L2')                                --401L1
        group by heeid, hcoid) L on L.eeid = xEEID and L.coid = xCOID
        
WHERE eecemplstatus <> 'T'                                                            --WHERE clause added 12/10/13 drn
    or (eecemplstatus = 'T' and EecDateOfTermination + @daysstopped >= @EndDate)
    or (isnull(C.eeamt,0) + isnull(R.eeamt,0) + isnull(M.eramt,0) + isnull(L.eeamt,0)) <> 0


--select * from dbo.U_dsi_ECUNA401QF_drvTbl



-- Trailer

if object_id('U_dsi_ECUNA401QF_TrlTbl') is not null
  drop table dbo.U_dsi_ECUNA401QF_TrlTbl

  select distinct
--    drvEEID = xEEID, 
--    drvcoid = xcoid,
--    drvdepid = cast(null as varchar),
    drvrectype = 'T',
-- standard fields above and additional driver fields below

    drvTotals = 'Totals',
--filler
    drvTotEEContr = TC.eeamt,
    drvTotEERothContr = TR.eeamt,
    drvTotERMatchContr = TM.eramt,                                            --TM.eeamt
    drvTotLoanPmt = TL.eeamt,
    drvTotPartTotal = isnull(TC.eeamt,0) + isnull(TR.eeamt,0) + isnull(TM.eramt,0) + isnull(TL.eeamt,0)


  into dbo.U_dsi_ECUNA401QF_TrlTbl
  from dbo.u_ECUNA401QF_eelist with (nolock)
    --join empPers with (nolock) on xEEID = eepEEID
    join empcomp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
--401K Contribution    
    left join(select sum(heeamt) eeamt, sum(heramt) eramt
        from dbo.U_dsi_ECUNA401QF_DedHist
        where hdedcode in ('401CF','401P','401CP')) TC on 1=1        --401CP added 1/2/14 drn  --TC.eeid = xEEID and TC.coid = xCOID

--MATCH
    left join(select sum(heeamt) eeamt, sum(heramt) eramt
        from dbo.U_dsi_ECUNA401QF_DedHist
        where hdedcode in ('401M')) TM on 1=1 -- TM.eeid = xEEID and TM.coid = xCOID
--ROTH
    left join(select sum(heeamt) eeamt, sum(heramt) eramt
        from dbo.U_dsi_ECUNA401QF_DedHist
        where hdedcode in ('401KR','401RC')) TR on 1=1 --TR.eeid = xEEID and TR.coid = xCOID
-- LOAN
left join(select sum(heeamt) eeamt, sum(heramt) eramt
        from dbo.U_dsi_ECUNA401QF_DedHist
        where hdedcode in ('401L','401L2')) TL on 1=1 --TL.eeid = xEEID and TL.coid = xCOID
        



--select * from dbo.U_dsi_ECUNA401QF_TrlTbl



-- Set FileName  
if (dbo.dsi_fnVariable('ECUNA401QF','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'QFCU_CUNA_401K_' + convert(char(8),getdate(),112) + '.csv'
    where FormatCode = 'ECUNA401QF'



--select distinct eecishighlycomp from empcomp

-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwECUNA401QF_Export as
       select top 2000000 left(data,(len(data))) as data from dbo.U_ECUNA401QF_File with (nolock)
         order by substring(Recordset,2,2), initialsort, subsort 
*/



--Used for testing
--dbo.dsi_sp_TestSwitchbox 'ECUNA401QF','ECUNA401QF'
--dbo.dsi_sp_TestSwitchbox 'ECUNA401QF','TEST'
--dbo.dsi_sp_TestSwitchbox 'ECUNA401QF','zap'

END




--select * from pdedhist
--select * from empded
GO
 CREATE  View dbo.dsi_vwECUNA401QF_Export as
       select top 2000000 left(data,(len(data))) as data from dbo.U_ECUNA401QF_File with (nolock)
         order by substring(Recordset,2,2), initialsort, subsort 