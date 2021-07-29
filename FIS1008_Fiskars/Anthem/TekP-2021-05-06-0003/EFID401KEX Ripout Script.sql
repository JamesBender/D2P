SET NOCOUNT ON;
IF OBJECT_ID('U_EFID401KEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFID401KEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFID401KEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFID401KEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFID401KEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFID401KEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFID401KEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFID401KEX];
GO
IF OBJECT_ID('U_EFID401KEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFID401KEX_PEarHist];
GO
IF OBJECT_ID('U_EFID401KEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFID401KEX_PDedHist];
GO
IF OBJECT_ID('U_EFID401KEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EFID401KEX_Header];
GO
IF OBJECT_ID('U_EFID401KEX_File') IS NOT NULL DROP TABLE [dbo].[U_EFID401KEX_File];
GO
IF OBJECT_ID('U_EFID401KEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFID401KEX_EEList];
GO
IF OBJECT_ID('U_EFID401KEX_drvTbl_21') IS NOT NULL DROP TABLE [dbo].[U_EFID401KEX_drvTbl_21];
GO
IF OBJECT_ID('U_EFID401KEX_drvTbl_19') IS NOT NULL DROP TABLE [dbo].[U_EFID401KEX_drvTbl_19];
GO
IF OBJECT_ID('U_EFID401KEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFID401KEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EFID401KEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFID401KEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFID401KEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFID401KEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFID401KEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFID401KEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFID401KEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EFID401KEX','Fidelity 401K Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','80','S','N','EFID401KEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFID401KEX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTestIdentifier"','1','(''UA''=''F'')','EFID401KEXZ0','7','H','01','1',NULL,'TEST FILE IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00088"','1','(''DA''=''F'')','EFID401KEXZ0','5','D','10','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''F'')','EFID401KEXZ0','4','D','10','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFID401KEXZ0','3','D','10','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFID401KEXZ0','11','D','10','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFID401KEXZ0','1','D','10','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000"','6','(''DA''=''F'')','EFID401KEXZ0','5','D','10','25',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"19"','7','(''DA''=''F'')','EFID401KEXZ0','2','D','10','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','EFID401KEXZ0','4','D','10','32',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"220"','9','(''DA''=''F'')','EFID401KEXZ0','3','D','10','36',NULL,'TRANSACTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFID401KEXZ0','2','D','10','39',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource"','11','(''UA''=''F'')','EFID401KEXZ0','2','D','10','41',NULL,'SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','12','(''DA''=''F'')','EFID401KEXZ0','2','D','10','43',NULL,'ITEM NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EFID401KEXZ0','1','D','10','45',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmount"','14','(''UA''=''F'')','EFID401KEXZ0','13','D','10','46',NULL,'AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''F'')','EFID401KEXZ0','4','D','10','59',NULL,'RESERVED (space-fill)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EFID401KEXZ0','4','D','10','63',NULL,'FISCAL YEAR (current year default)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','EFID401KEXZ0','1','D','10','67',NULL,'CORRECTION METHOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','EFID401KEXZ0','8','D','10','68',NULL,'POSTING DATE (HSA)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EFID401KEXZ0','5','D','10','76',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00088"','1','(''DA''=''F'')','EFID401KEXZ0','5','D','20','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''F'')','EFID401KEXZ0','4','D','20','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFID401KEXZ0','3','D','20','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFID401KEXZ0','11','D','20','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFID401KEXZ0','1','D','20','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000"','6','(''DA''=''F'')','EFID401KEXZ0','5','D','20','25',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"21"','7','(''DA''=''F'')','EFID401KEXZ0','2','D','20','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','EFID401KEXZ0','4','D','20','32',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanIdentification"','9','(''UA''=''F'')','EFID401KEXZ0','12','D','20','36',NULL,'LOAN IDENTIFICATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFID401KEXZ0','1','D','20','48',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"260"','11','(''DA''=''F'')','EFID401KEXZ0','3','D','20','49',NULL,'TRANSACTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"14"','12','(''DA''=''F'')','EFID401KEXZ0','2','D','20','52',NULL,'ITEM NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','13','(''DA''=''F'')','EFID401KEXZ0','2','D','20','54',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''F'')','EFID401KEXZ0','1','D','20','56',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRepaymentAmount"','15','(''UA''=''F'')','EFID401KEXZ0','7','D','20','57',NULL,'REPAYMENT AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EFID401KEXZ0','1','D','20','64',NULL,'CORRECTION METHOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','EFID401KEXZ0','8','D','20','65',NULL,'POSTING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','EFID401KEXZ0','1','D','20','73',NULL,'PRINCIPAL ONLY FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EFID401KEXZ0','1','D','20','74',NULL,'NEW REPAYMENT FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EFID401KEXZ0','6','D','20','75',NULL,'DIVISION CODE OR BATCH GROUP',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EFID401KEX_20210726.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202107089','EMPEXPORT','OEACTIVE',NULL,'EFID401KEX',NULL,NULL,NULL,'202107089','Jul  8 2021  8:10AM','Jul  8 2021  8:10AM','202107081',NULL,'','','202107081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202107089','EMPEXPORT','OEPASSIVE',NULL,'EFID401KEX',NULL,NULL,NULL,'202107089','Jul  8 2021  8:10AM','Jul  8 2021  8:10AM','202107081',NULL,'','','202107081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fidelity 401K Payroll Export','202107089','EMPEXPORT','ONDEM_XOE',NULL,'EFID401KEX',NULL,NULL,NULL,'202107089','Jul  8 2021  8:10AM','Jul  8 2021  8:10AM','202107081',NULL,'','','202107081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fidelity 401K Payroll Ex-Sched','202107089','EMPEXPORT','SCH_EFID40',NULL,'EFID401KEX',NULL,NULL,NULL,'202107089','Jul  8 2021  8:10AM','Jul  8 2021  8:10AM','202107081',NULL,'','','202107081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Fidelity 401K Payroll Ex-Test','202107229','EMPEXPORT','TEST_XOE','Jul 22 2021  9:40AM','EFID401KEX',NULL,NULL,NULL,'202107229','Jul 22 2021 12:00AM','Dec 30 1899 12:00AM','202107221','121','','','202107221',dbo.fn_GetTimedKey(),NULL,'us3lKiFIS1008',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFID401KEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFID401KEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFID401KEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFID401KEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFID401KEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EFID401KEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EFID401KEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EFID401KEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFID401KEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFID401KEX','H01','dbo.U_EFID401KEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFID401KEX','D10','dbo.U_EFID401KEX_drvTbl_19',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFID401KEX','D20','dbo.U_EFID401KEX_drvTbl_21',NULL);
IF OBJECT_ID('U_dsi_BDM_EFID401KEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFID401KEX] (
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
IF OBJECT_ID('U_EFID401KEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EFID401KEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFID401KEX_drvTbl_19') IS NULL
CREATE TABLE [dbo].[U_EFID401KEX_drvTbl_19] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] varchar(11) NULL,
    [drvSource] varchar(2) NULL,
    [drvAmount] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EFID401KEX_drvTbl_21') IS NULL
CREATE TABLE [dbo].[U_EFID401KEX_drvTbl_21] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] varchar(11) NULL,
    [drvLoanIdentification] varchar(6) NULL,
    [drvRepaymentAmount] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EFID401KEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EFID401KEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFID401KEX_File') IS NULL
CREATE TABLE [dbo].[U_EFID401KEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(80) NULL
);
IF OBJECT_ID('U_EFID401KEX_Header') IS NULL
CREATE TABLE [dbo].[U_EFID401KEX_Header] (
    [drvTestIdentifier] varchar(7) NOT NULL
);
IF OBJECT_ID('U_EFID401KEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFID401KEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhL401PAmt] numeric NULL,
    [PdhLRothAmt] numeric NULL,
    [Pdh401CUAmt] numeric NULL,
    [PdhL401MAmt] numeric NULL,
    [PdhLoan1Amt] numeric NULL,
    [PdhLoan2Amt] numeric NULL,
    [PdhLoan3Amt] numeric NULL
);
IF OBJECT_ID('U_EFID401KEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFID401KEX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFID401KEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Fiskars

Created By: James Bender
Business Analyst: Lea King
Create Date: 07/08/2021
Service Request Number: TekP-2021-05-06-0003

Purpose: Fidelity 401K Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFID401KEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFID401KEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFID401KEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFID401KEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFID401KEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFID401KEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFID401KEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFID401KEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFID401KEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFID401KEX', 'SCH_EFID40';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFID401KEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFID401KEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFID401KEX';

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
    DELETE FROM dbo.U_EFID401KEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFID401KEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EFID401KEX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'L401P,LROTH,401CU,L401M,Loan1,Loan2,Loan3';

    IF OBJECT_ID('U_EFID401KEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFID401KEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFID401KEX_DedList
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
    IF OBJECT_ID('U_EFID401KEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFID401KEX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhL401PAmt     = SUM(CASE WHEN PdhDedCode IN ('L401P') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLRothAmt     = SUM(CASE WHEN PdhDedCode IN ('LROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401CUAmt     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhL401MAmt     = SUM(CASE WHEN PdhDedCode IN ('L401M') THEN PdhERCurAmt ELSE 0.00 END)  
        ,PdhLoan1Amt     = SUM(CASE WHEN PdhDedCode IN ('LOAN1') THEN PdhEECurAmt ELSE 0.00 END)  
        ,PdhLoan2Amt     = SUM(CASE WHEN PdhDedCode IN ('LOAN2') THEN PdhEECurAmt ELSE 0.00 END)  
        ,PdhLoan3Amt     = SUM(CASE WHEN PdhDedCode IN ('LOAN3') THEN PdhEECurAmt ELSE 0.00 END)        
    INTO dbo.U_EFID401KEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFID401KEX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
   -- HAVING (SUM(PdhEECurAmt) <> 0.00
   --     OR SUM(PdhERCurAmt) <> 0.00
   -- )
    ;


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EFID401KEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFID401KEX_PEarHist;
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
    INTO dbo.U_EFID401KEX_PEarHist
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
    -- DETAIL RECORD - U_EFID401KEX_drvTbl_19
    ---------------------------------
    IF OBJECT_ID('U_EFID401KEX_drvTbl_19','U') IS NOT NULL
        DROP TABLE dbo.U_EFID401KEX_drvTbl_19;
    SELECT DISTINCT
         drvEEID = xEEID    
        ,drvCoID = xCoID    
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvSource =    CASE WHEN BdmDedCode IN ('L401P','LROTH','401CU') THEN '01'
                            WHEN BdmDedCode IN ('L401M') THEN '02'
                        END
        ,drvAmount =    FORMAT(CASE WHEN BdmDedCode = 'L401P' THEN PdhL401PAmt
                            WHEN BdmDedCode = 'LROTH' THEN PdhLRothAmt
                            WHEN BdmDedCode = '401CU' THEN Pdh401CUAmt
                            WHEN BdmDedCode = 'L401M' THEN PdhL401MAmt
                        END, '#0.00')
    INTO dbo.U_EFID401KEX_drvTbl_19
    FROM dbo.U_EFID401KEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFID401KEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_EFID401KEX_PDedHist
        ON PdhEEID = xEEID
    WHERE BdmDedCode IN ('L401P','LROTH','401CU','L401M')
        AND (
                (
                    BdmDedCode IN ('L401P','LROTH','401CU') AND
                    (
                        PdhL401PAmt > 0.00
                        OR PdhLRothAmt > 0.00
                        OR Pdh401CUAmt > 0.00)
                )
                OR (BdmDedCode = 'L401M' AND PdhL401MAmt > 0.00)
            )
    ;

    UPDATE dbo.U_EFID401KEX_drvTbl_19 SET drvAmount = CONVERT(VARCHAR,dbo.dsi_fnPadZero((CAST(drvAmount AS MONEY))*100,13,0)) 
        
    Update dbo.U_EFID401KEX_drvTbl_19 set drvAmount  =   REPLACE(CONCAT(LEFT(REPLACE(drvAmount,'.',''),(LEN( REPLACE(drvAmount,'.','')) -1)),
    
    CASE WHEN LEFT(drvAmount, 1) = '-' THEN 
        CASE WHEN RIGHT(drvAmount,1) = '1' THEN 'J'
             WHEN RIGHT(drvAmount,1) = '2' THEN 'K'
             WHEN RIGHT(drvAmount,1) = '3' THEN 'L'
             WHEN RIGHT(drvAmount,1) = '4' THEN 'M'
             WHEN RIGHT(drvAmount,1) = '5' THEN 'N'
             WHEN RIGHT(drvAmount,1) = '6' THEN 'O'
             WHEN RIGHT(drvAmount,1) = '7' THEN 'P'
             WHEN RIGHT(drvAmount,1) = '8' THEN 'Q'
             WHEN RIGHT(drvAmount,1) = '9' THEN 'R'
             WHEN RIGHT(drvAmount,1) = '0' THEN '}'
        END
    ELSE
        CASE WHEN RIGHT(drvAmount,1) = '1' THEN 'A'
             WHEN RIGHT(drvAmount,1) = '2' THEN 'B'
             WHEN RIGHT(drvAmount,1) = '3' THEN 'C'
             WHEN RIGHT(drvAmount,1) = '4' THEN 'D'
             WHEN RIGHT(drvAmount,1) = '5' THEN 'E'
             WHEN RIGHT(drvAmount,1) = '6' THEN 'F'
             WHEN RIGHT(drvAmount,1) = '7' THEN 'G'
             WHEN RIGHT(drvAmount,1) = '8' THEN 'H'
             WHEN RIGHT(drvAmount,1) = '9' THEN 'I'
             WHEN RIGHT(drvAmount,1) = '0' THEN '{'
        END
    END
    ), '-','0') 


    ---------------------------------
    -- DETAIL RECORD - U_EFID401KEX_drvTbl_21
    ---------------------------------
    IF OBJECT_ID('U_EFID401KEX_drvTbl_21','U') IS NOT NULL
        DROP TABLE dbo.U_EFID401KEX_drvTbl_21;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvLoanIdentification =    CASE WHEN BdmDedCode = 'LOAN1' THEN 'LOAN 1'
                                        WHEN BdmDedCode = 'LOAN2' THEN 'LOAN 2'
                                        WHEN BdmDedCode = 'LOAN3' THEN 'LOAN 3'
                                    END
        ,drvRepaymentAmount =    CASE WHEN BdmDedCode = 'LOAN1' THEN FORMAT(PdhLoan1Amt, '#0.00')
                                    WHEN BdmDedCode = 'LOAN2' THEN FORMAT(PdhLoan2Amt, '#0.00')
                                    WHEN BdmDedCode = 'LOAN3' THEN FORMAT(PdhLoan3Amt, '#0.00')
                                END
    INTO dbo.U_EFID401KEX_drvTbl_21
    FROM dbo.U_EFID401KEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFID401KEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_EFID401KEX_PDedHist
        ON PdhEEID = xEEID
    WHERE BdmDedCode IN ('LOAN1','LOAN2','LOAN3')
        AND (
                (BdmDedCode = 'LOAN1' AND PdhLoan1Amt > 0.00 )
                OR (BdmDedCode = 'LOAN2' AND PdhLoan2Amt > 0.00)
                OR (BdmDedCode = 'LOAN3' AND PdhLoan3Amt > 0.00)  
            ) 
    ;

    UPDATE dbo.U_EFID401KEX_drvTbl_21 SET drvRepaymentAmount = CONVERT(VARCHAR,dbo.dsi_fnPadZero((CAST(drvRepaymentAmount AS MONEY))*100,7,0)) 
        
    Update dbo.U_EFID401KEX_drvTbl_21 set drvRepaymentAmount  =   REPLACE(CONCAT(LEFT(REPLACE(drvRepaymentAmount,'.',''),(LEN( REPLACE(drvRepaymentAmount,'.','')) -1)),
    
    CASE WHEN LEFT(drvRepaymentAmount, 1) = '-' THEN 
        CASE WHEN RIGHT(drvRepaymentAmount,1) = '1' THEN 'J'
             WHEN RIGHT(drvRepaymentAmount,1) = '2' THEN 'K'
             WHEN RIGHT(drvRepaymentAmount,1) = '3' THEN 'L'
             WHEN RIGHT(drvRepaymentAmount,1) = '4' THEN 'M'
             WHEN RIGHT(drvRepaymentAmount,1) = '5' THEN 'N'
             WHEN RIGHT(drvRepaymentAmount,1) = '6' THEN 'O'
             WHEN RIGHT(drvRepaymentAmount,1) = '7' THEN 'P'
             WHEN RIGHT(drvRepaymentAmount,1) = '8' THEN 'Q'
             WHEN RIGHT(drvRepaymentAmount,1) = '9' THEN 'R'
             WHEN RIGHT(drvRepaymentAmount,1) = '0' THEN '}'
        END
    ELSE
        CASE WHEN RIGHT(drvRepaymentAmount,1) = '1' THEN 'A'
             WHEN RIGHT(drvRepaymentAmount,1) = '2' THEN 'B'
             WHEN RIGHT(drvRepaymentAmount,1) = '3' THEN 'C'
             WHEN RIGHT(drvRepaymentAmount,1) = '4' THEN 'D'
             WHEN RIGHT(drvRepaymentAmount,1) = '5' THEN 'E'
             WHEN RIGHT(drvRepaymentAmount,1) = '6' THEN 'F'
             WHEN RIGHT(drvRepaymentAmount,1) = '7' THEN 'G'
             WHEN RIGHT(drvRepaymentAmount,1) = '8' THEN 'H'
             WHEN RIGHT(drvRepaymentAmount,1) = '9' THEN 'I'
             WHEN RIGHT(drvRepaymentAmount,1) = '0' THEN '{'
        END
    END
    ), '-','0') 

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EFID401KEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EFID401KEX_Header;
    SELECT DISTINCT
         drvTestIdentifier = 'TESTEDT'
    INTO dbo.U_EFID401KEX_Header
    WHERE @ExportCode LIKE '%TEST%' -- ONLY send this record if a test file is being created
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
ALTER VIEW dbo.dsi_vwEFID401KEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFID401KEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFID401KEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107011'
       ,expStartPerControl     = '202107011'
       ,expLastEndPerControl   = '202107089'
       ,expEndPerControl       = '202107089'
WHERE expFormatCode = 'EFID401KEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFID401KEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFID401KEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort