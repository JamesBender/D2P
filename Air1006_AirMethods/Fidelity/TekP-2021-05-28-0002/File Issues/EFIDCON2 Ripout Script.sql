SET NOCOUNT ON;
IF OBJECT_ID('U_EFIDCON2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDCON2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFIDCON2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFIDCON2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFIDCON2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFIDCON2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFIDCON2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDCON2];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_EFIDCON2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_EFIDCON2];
GO
IF OBJECT_ID('U_EFIDCON2_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDCON2_PDedHist];
GO
IF OBJECT_ID('U_EFIDCON2_File') IS NOT NULL DROP TABLE [dbo].[U_EFIDCON2_File];
GO
IF OBJECT_ID('U_EFIDCON2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFIDCON2_EEList];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDCON2_Header') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDCON2_Header];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDCON2_3K') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDCON2_3K];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDCON2_21') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDCON2_21];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDCON2_19') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDCON2_19];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFIDCON2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFIDCON2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFIDCON2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFIDCON2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFIDCON2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','EFIDCON2','Fidelity 401k Deferral and Loan Deductions V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','80','S','N','EFIDCON2Z0','N',NULL,'C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFIDCON2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDCON2Z0','5','H','01','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','2','(''UA''=''F'')','EFIDCON2Z0','3','H','01','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDCON2Z0','1','H','01','9','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvTypeOfAccount"','4','(''UA''=''F'')','EFIDCON2Z0','15','H','01','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDCON2Z0','6','H','01','25','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvClientName"','6','(''UA''=''F'')','EFIDCON2Z0','25','H','01','31','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvChangesOnlyFileIndicator"','7','(''UA''=''F'')','EFIDCON2Z0','1','H','01','56','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','8','(''UA''=''F'')','EFIDCON2Z0','24','H','01','57','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDCON2Z0','5','D','19','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupID"','2','(''UA''=''F'')','EFIDCON2Z0','7','D','19','2','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','3','(''UA''=''F'')','EFIDCON2Z0','11','D','19','3','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','4','(''UA''=''F'')','EFIDCON2Z0','1','D','19','4','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvReserved1"','5','(''UA''=''F'')','EFIDCON2Z0','5','D','19','5','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDCON2Z0','2','D','19','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiscalYear"','7','(''UA''=''F'')','EFIDCON2Z0','4','D','19','7','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransCode"','8','(''UA''=''F'')','EFIDCON2Z0','3','D','19','8','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','9','(''UA''=''F'')','EFIDCON2Z0','3','D','19','9','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource"','10','(''UA''=''F'')','EFIDCON2Z0','2','D','19','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvItemNumber"','11','(''UA''=''F'')','EFIDCON2Z0','2','D','19','11','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved2"','12','(''UA''=''F'')','EFIDCON2Z0','1','D','19','12','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmount"','13','(''UNPN''=''F'')','EFIDCON2Z0','13','D','19','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReason"','14','(''UA''=''F'')','EFIDCON2Z0','1','D','19','14','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalPayDate"','15','(''UA''=''F'')','EFIDCON2Z0','8','D','19','15','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSalary"','16','(''UNPN''=''F'')','EFIDCON2Z0','9','D','19','16','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReserved3"','17','(''UA''=''F'')','EFIDCON2Z0','3','D','19','17','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDCON2Z0','5','D','21','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupID"','2','(''UA''=''F'')','EFIDCON2Z0','4','D','21','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDCON2Z0','3','D','21','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDCON2Z0','11','D','21','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDCON2Z0','1','D','21','24','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvReserved1"','6','(''UA''=''F'')','EFIDCON2Z0','5','D','21','25','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','7','(''UA''=''F'')','EFIDCON2Z0','2','D','21','30','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','8','(''UA''=''F'')','EFIDCON2Z0','4','D','21','32','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvLoanIdentification"','9','(''UA''=''F'')','EFIDCON2Z0','12','D','21','36','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller4"','10','(''UA''=''F'')','EFIDCON2Z0','1','D','21','48','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvTransactionCode"','11','(''UA''=''F'')','EFIDCON2Z0','3','D','21','49','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvItemNumber"','12','(''UA''=''F'')','EFIDCON2Z0','2','D','21','52','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvReserved2"','13','(''UA''=''F'')','EFIDCON2Z0','2','D','21','54','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller5"','14','(''UA''=''F'')','EFIDCON2Z0','1','D','21','56','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPrincipalAmount"','15','(''UNPN''=''F'')','EFIDCON2Z0','7','D','21','57','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvAdjReason"','16','(''UA''=''F'')','EFIDCON2Z0','1','D','21','64','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvInterestAmount"','17','(''UNPN''=''F'')','EFIDCON2Z0','7','D','21','65','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller7"','18','(''UA''=''F'')','EFIDCON2Z0','1','D','21','72','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPrincipalOnlyFlag"','19','(''UA''=''F'')','EFIDCON2Z0','1','D','21','73','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvNewRepaymentFrequency"','20','(''UA''=''F'')','EFIDCON2Z0','1','D','21','74','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller8"','21','(''UA''=''F'')','EFIDCON2Z0','6','D','21','75','','',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EFIDCON2_20211007.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'FR95C',NULL,NULL,NULL,'On Demand Export','202108202','EMPEXPORT','ON_DEMAND','Aug 20 2021  8:03PM','EFIDCON2',NULL,NULL,NULL,'202108202','Aug 20 2021 12:00AM','Aug 20 2021 12:00AM','202108202','297','eecPayGroup','BWPLT','202108202',dbo.fn_GetTimedKey(),NULL,'ULTI_AIRMC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','FR95C,N7GY3,WO2AC,RIOOJ,H4VKS,0Y1AJ',NULL,NULL,NULL,'Fidelity 401k Deferral V2','202109179','EMPEXPORT','SCH_EFID40','Sep 30 2021 12:00AM','EFIDCON2',NULL,NULL,NULL,'202110019','Sep 17 2021 12:00AM','Dec 30 1899 12:00AM','202109181','4239','eecPaygroup','PLTHH,BLUEHI,BWXMPT,BWMECH,BWMED,BWNXMT,BWPLT,SUNDNC,BWUR','202109171',dbo.fn_GetTimedKey(),NULL,'us3lKiAIR1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','FR95C,N7GY3,WO2AC,RIOOJ,H4VKS,0Y1AJ',NULL,NULL,NULL,'Fidelity 401k Payroll - TEST','202109031','EMPEXPORT','TEST','Sep  9 2021 11:20AM','EFIDCON2',NULL,NULL,NULL,'202109031','Sep  3 2021 12:00AM','Aug 28 2021 12:00AM','202109031','4218','eecPayGroup','PLTHH,BLUEHI,BWXMPT,BWMECH,BWMED,BWNXMT,BWPLT,SUNDNC,BWUR','202109031',dbo.fn_GetTimedKey(),NULL,'us3lKiAIR1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unlock Export Session','201306099','EMPEXPORT','ZAP','Aug 23 2021 12:00AM','EFIDCON2',NULL,NULL,NULL,'201306099','Jun  9 2013 12:00AM','Dec 30 1899 12:00AM','201306091','-99','','PLTHH,BLUEHI,XMPTBH,NXMTBH,PLTBH,BWXMPT,XMPTHH,NXMTHH,BWMECH,BWMED,BWNXMT,BWPLT,SUNDNC,XMPTSD,NXMTSD,PLTSD,TRACK,XMPTTS,MECHTS,MEDTS,NXMTTS,PLTTS,BWUR','201306091',dbo.fn_GetTimedKey(),NULL,'us3lKiAIR1006',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDCON2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDCON2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDCON2','InitialSort','C','DrvEEID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDCON2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDCON2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDCON2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EFIDCON2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EFIDCON2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EFIDCON2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDCON2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDCON2','H01','dbo.U_Dsi_DrvTbl_EFIDCON2_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDCON2','D19','dbo.U_Dsi_DrvTbl_EFIDCON2_3K',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDCON2','D21','dbo.U_Dsi_DrvTbl_EFIDCON2_21',NULL);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDCON2_19') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDCON2_19] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupID] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvReserved1] varchar(5) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvFiller3] varchar(1) NOT NULL,
    [DrvTransactionCode] varchar(3) NULL,
    [DrvFiller4] varchar(1) NOT NULL,
    [DrvSource] varchar(2) NOT NULL,
    [DrvItemNumber] varchar(2) NOT NULL,
    [DrvFiller5] varchar(1) NOT NULL,
    [DrvAmountRaw] money NULL,
    [DrvAmount] money NULL,
    [DrvFiller6] varchar(1) NOT NULL,
    [DrvFiscalYear] varchar(4) NULL,
    [DrvAdjReason] varchar(1) NULL,
    [DrvOrigPayDate] varchar(8) NULL,
    [DrvReserved2] varchar(5) NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDCON2_21') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDCON2_21] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupID] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvReserved1] varchar(5) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvFiller3] varchar(1) NOT NULL,
    [DrvLoanIdentification] varchar(6) NULL,
    [DrvFiller4] varchar(1) NOT NULL,
    [DrvTransactionCode] varchar(3) NOT NULL,
    [DrvItemNumber] varchar(2) NOT NULL,
    [DrvReserved2] varchar(2) NOT NULL,
    [DrvFiller5] varchar(1) NOT NULL,
    [DrvPrincipalAmountRaw] money NULL,
    [DrvPrincipalAmount] money NULL,
    [DrvAdjReason] varchar(1) NULL,
    [DrvFiller6] varchar(1) NOT NULL,
    [DrvInterestAmount] varchar(1) NOT NULL,
    [DrvFiller7] varchar(1) NOT NULL,
    [DrvPrincipalOnlyFlag] varchar(1) NOT NULL,
    [DrvNewRepaymentFrequency] varchar(1) NOT NULL,
    [DrvFiller8] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDCON2_3K') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDCON2_3K] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupID] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvReserved1] varchar(5) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [drvFiscalYear] varchar(4) NULL,
    [drvTransCode] varchar(3) NOT NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvTransactionCode] varchar(3) NOT NULL,
    [DrvFiller3] varchar(1) NOT NULL,
    [drvSource] varchar(2) NULL,
    [drvItemNumber] varchar(2) NOT NULL,
    [drvReserved2] varchar(1) NOT NULL,
    [drvAmount] money NULL,
    [drvReason] varchar(1) NOT NULL,
    [drvOriginalPayDate] varchar(1) NOT NULL,
    [drvEmpSalary] numeric NULL,
    [drvReserved3] varchar(3) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDCON2_Header') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDCON2_Header] (
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvRecordIdentifier] varchar(3) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvTypeOfAccount] varchar(7) NOT NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvClientName] varchar(11) NOT NULL,
    [DrvChangesOnlyFileIndicator] varchar(1) NOT NULL,
    [DrvFiller3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EFIDCON2_EEList') IS NULL
CREATE TABLE [dbo].[U_EFIDCON2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFIDCON2_File') IS NULL
CREATE TABLE [dbo].[U_EFIDCON2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(80) NULL
);
IF OBJECT_ID('U_EFIDCON2_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFIDCON2_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [pdhCoID] char(5) NOT NULL,
    [pdhEECurAmt] money NULL,
    [pdhSourceCode] varchar(2) NULL,
    [pdhTransCode] varchar(3) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_EFIDCON2]
AS

/************************************************************

Client: AIRMC

Created By: Megan Grieves
Business Analyst: Greg Travetti
Create Date: 6/10/2013
ChangePoint Request Number: 68700

Purpose: Insert Testing Header

Revision History
----------------
Update By         Date          CP Num         Descr
xxxxxxxxxxxxxxxx  xx/xx/xxxxx   CS-xxxx-xxxxx  xxxxxxxx

************************************************************/

-----------
-- If testing, insert testing header
-----------

--IF dbo.dsi_fnVariable('EFIDCON2','TEST') = 'Y' BEGIN

--    INSERT INTO dbo.U_EFIDCON2_File VALUES ('H00','0','1','TESTEDT' + SPACE(73))

--END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDCON2] @SystemID VARCHAR(15)
AS
SET NOCOUNT ON;
/************************************************************

Created By: Megan Grieves
Business Analyst: Greg Travetti
Create Date: 6/10/2013
ChangePoint Request Number: 68700

Purpose:
Execute Export:

Revision History
-----------------
Update By            Date           SR Num            Desc            
R Dreese           09/17/2014     SF 04231153         Removed EE's in Sundance Comp.
Sean Hawkins       01/13/2017     SR-2016-00131575    Updates for new 93523 logic and field changes
Elizabeth Fox      07/18/2017     SR-2017-00163821    Add new deduction codes. Update transaction code field. 
Dave Smith         03/30/2018     SR-2018-00192540    Add new loan code - 401LT
Wes Burger         10/05/2018     SR-2018-00212857    Adding deduction code 401MM
Jimmy Tran         10/3/2019      SR-2019-00236877    Updated per 2.6
TekPartners           06/28/2021     no SR               Removed coding for plan number 93523, removed sql scheduler and moved to web

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFIDCON2', @AllObjects = 'Y', @IsWeb = 'Y'

update u_dsi_configuration
set cfgvalue = 'Y'
where formatcode = 'EFIDCON2' and cfgname = 'Testing'

SELECT * FROM U_Dsi_Configuration WHERE FormatCode = 'EFIDCON2'
SELECT * FROM U_Dsi_parameters WHERE FormatCode = 'EFIDCON2'
SELECT * FROM U_Dsi_sqlclauses WHERE FormatCode = 'EFIDCON2'

U_Dsi_DrvTbl_EFIDCON2_21

UPDATE U_Dsi_Configuration
   SET CfgValue = dbo.dsi_fnVariable('EFIDCON2','TestPath')
 WHERE FormatCode = 'EFIDCON2'
   AND CfgName = 'ExportPath'

dsi_sp_testswitchbox_v2 'EFIDCON2', 'ON_DEMAND'
dsi_sp_testswitchbox_v2 'EFIDCON2', 'ZAP'
dsi_sp_testswitchbox_v2 'EFIDCON2', 'TEST'
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDCON2', 'SCH_EFID40';

select * from U_EFIDCON2_File

UPDATE AscExp
SET
ExpStartPerControl     = '2013' + '01' + '011',
ExpLastStartPerControl = '2013' + '01' + '011',
--ExpEndPerControl       = '2013' + '01' + '011',
--ExpLastEndPerControl   = '2013' + '01' + '011'
ExpEndPerControl       = CONVERT(VARCHAR(8), GETDATE(), 112) + '9',
ExpLastEndPerControl   = CONVERT(VARCHAR(8), GETDATE(), 112) + '9'
WHERE ExpFormatCode    = 'EFIDCON2'
AND ExpExportCode    = 'ON_DEMAND'


************************************************************/
SET NOCOUNT ON

-----------
-- Declare variables
-----------
DECLARE @FormatCode CHAR(10)
DECLARE @ExportCode CHAR(10)
DECLARE @StartDateTime DATETIME
DECLARE @EndDateTime DATETIME
DECLARE @StartPerControl CHAR(9)
DECLARE @EndPerControl CHAR(9)
DECLARE @TestingFlag CHAR(1)

-----------
-- Set start and end dates
-----------
SELECT @FormatCode = FormatCode
    ,@ExportCode = ExportCode
    ,@StartPerControl = StartPerControl
    ,@EndPerControl = EndPerControl
FROM dbo.U_dsi_Parameters
WHERE FormatCode = 'EFIDCON2'

SET @StartDateTime = CONVERT(DATETIME, LEFT(@StartPerControl, 8))
SET @EndDateTime = CONVERT(DATETIME, LEFT(@EndPerControl, 8))
SET @EndDateTime = DATEADD(SECOND, - 1, DATEADD(DD, 1, DATEDIFF(DD, 0, @EndDateTime))) -- 11:59:59 pm
SET @TestingFlag = dbo.dsi_fnVariable(@FormatCode, 'TEST')

PRINT '@StartPerControl: ' + @StartPerControl
PRINT '@EndPerControl:   ' + @EndPerControl
PRINT '@StartDateTime    ' + CONVERT(VARCHAR(30), @StartDateTime)
PRINT '@EndDateTime:     ' + CONVERT(VARCHAR(30), @EndDateTime)

-----------
-- Drop tables
-----------
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDCON2_3K') IS NOT NULL
    DROP TABLE dbo.U_Dsi_DrvTbl_EFIDCON2_3K

IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDCON2_21') IS NOT NULL
    DROP TABLE dbo.U_Dsi_DrvTbl_EFIDCON2_21

IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDCON2_Header') IS NOT NULL
    DROP TABLE dbo.U_Dsi_DrvTbl_EFIDCON2_Header

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDCON2_Header
-----------------------
SELECT DISTINCT DrvPlanNumber = '37379'
    ,DrvRecordIdentifier = 'THR'
    ,DrvFiller1 = ''
    ,DrvTypeOfAccount = 'Payroll'
    ,DrvFiller2 = ''
    ,DrvClientName = 'Air Methods'
    ,DrvChangesOnlyFileIndicator = 'Y'
    ,DrvFiller3 = ''
INTO dbo.U_Dsi_DrvTbl_EFIDCON2_Header

-------------------------
---- Build dbo.U_Dsi_DrvTbl_EFIDCON2_19
----select * from U_Dsi_DrvTbl_EFIDCON2_19
-------------------------
---- Employee Contributions
--SELECT DISTINCT DrvCOID = xCOID
--    ,DrvEEID = xEEID
--    ,DrvPlanNumber = CASE 
--        WHEN CmpCompanyCode IN (
--                'HH'
--                ,'BHH'
--                ,'SNDNC'
--                )
--            THEN '93523'
--        ELSE '37379'
--        END
--    ,--'37379',
--    DrvBatchGroupID = ''
--    ,DrvFiller1 = ''
--    ,DrvSocialSecurityNumber = SUBSTRING(EepSSN, 1, 3) + '-' + SUBSTRING(EepSSN, 4, 2) + '-' + SUBSTRING(EepSSN, 6, 4)
--    ,DrvFiller2 = ''
--    ,DrvReserved1 = '00000'
--    ,DrvRecordIdentifier = '19'
--    ,DrvFiller3 = ''
--    ,DrvTransactionCode = CASE 
--        WHEN PdhDedCode IN (
--                '401CA'
--                ,'401CB'
--                ,'401CS'
--                ,'401CT'
--                ,'401CU'
--                ,'401K'
--                ,'401KA'
--                ,'401KB'
--                ,'401KS'
--                ,'401KT'
--                )
--            THEN '220'
--        WHEN PdhDedCode IN (
--                '401KM'
--                ,'401CM'
--                ,'401MM' -- Wes Burger 10/05/2018
--                )
--            THEN '295'
--        END
--    ,DrvFiller4 = ''
--    ,DrvSource = '01'
--    ,DrvItemNumber = '01'
--    ,DrvFiller5 = ''
--    ,DrvAmountRaw = SUM(PdhEECurAmt)
--    ,DrvAmount = SUM(PdhEECurAmt)
--    ,DrvFiller6 = ''
--    ,DrvFiscalYear = LEFT(@EndPerControl, 4)
--    ,DrvAdjReason = space(1)
--    ,DrvOrigPayDate = space(8)
--    ,DrvReserved2 = space(5) --'00000000000000'
--INTO dbo.U_Dsi_DrvTbl_EFIDCON2_19
--FROM dbo.U_EFIDCON2_EEList
--JOIN EmpPers WITH (NOLOCK) ON xEEID = EepEEID
--JOIN PDedHist WITH (NOLOCK) ON PdhEEID = xEEID
--    AND PdhCOID = xCOID
--JOIN dbo.Company WITH (NOLOCK) ON CmpCoid = Xcoid
--WHERE PdhPerControl BETWEEN @StartPerControl
--        AND @EndPerControl
--    AND PdhEECurAmt <> 0
--    AND PdhDedCode IN (
--        '401CA'
--        ,'401CB'
--        ,'401CS'
--        ,'401CT'
--        ,'401CU'
--        ,'401K'
--        ,'401KA'
--        ,'401KB'
--        ,'401KS'
--        ,'401KT'
--        ,'401KM'
--        ,'401CM'
--        ,'401MM' -- Wes Burger 10/05/2018
--        )
----AND eepHomeCoID <> 'H4VKS' --- RAD SF 04231153
--GROUP BY xCOID
--    ,xEEID
--    ,EepSSN
--    ,CmpCompanyCode
--    ,PdhDedCode

---- Employer Contributions
--INSERT INTO dbo.U_Dsi_DrvTbl_EFIDCON2_19
--SELECT DISTINCT DrvCOID = xCOID
--    ,DrvEEID = xEEID
--    ,DrvPlanNumber = CASE 
--        WHEN CmpCompanyCode IN (
--                'HH'
--                ,'BHH'
--                ,'SNDNC'
--                )
--            THEN '93523'
--        ELSE '37379'
--        END
--    ,--'37379',
--    DrvBatchGroupID = ''
--    ,DrvFiller1 = ''
--    ,DrvSocialSecurityNumber = SUBSTRING(EepSSN, 1, 3) + '-' + SUBSTRING(EepSSN, 4, 2) + '-' + SUBSTRING(EepSSN, 6, 4)
--    ,DrvFiller2 = ''
--    ,DrvReserved1 = '00000'
--    ,DrvRecordIdentifier = '19'
--    ,DrvFiller3 = ''
--    ,DrvTransactionCode = CASE 
--        WHEN PdhDedCode IN (
--                '401CA'
--                ,'401CB'
--                ,'401CS'
--                ,'401CT'
--                ,'401CU'
--                ,'401K'
--                ,'401KA'
--                ,'401KB'
--                ,'401KS'
--                ,'401KT'
--                )
--            THEN '220'
--        WHEN PdhDedCode IN (
--                '401KM'
--                ,'401CM'
--                ,'401MM' -- Wes Burger 10/05/2018
--                )
--            THEN '295'
--        END
--    ,DrvFiller4 = ''
--    ,DrvSource = '02'
--    ,DrvItemNumber = '01'
--    ,DrvFiller5 = ''
--    ,DrvAmountRaw = SUM(PdhERCurAmt)
--    ,DrvAmount = SUM(PdhERCurAmt)
--    ,DrvFiller6 = ''
--    ,DrvFiscalYear = LEFT(@EndPerControl, 4)
--    ,DrvAdjReason = space(1)
--    ,DrvOrigPayDate = space(8)
--    ,DrvReserved2 = space(5) --'00000000000000'
--FROM dbo.U_EFIDCON2_EEList
--JOIN EmpPers WITH (NOLOCK) ON xEEID = EepEEID
--JOIN PDedHist WITH (NOLOCK) ON PdhEEID = xEEID
--    AND PdhCOID = xCOID
--JOIN dbo.Company WITH (NOLOCK) ON CmpCoid = Xcoid
--WHERE PdhPerControl BETWEEN @StartPerControl
--        AND @EndPerControl
--    AND PdhERCurAmt <> 0
--    AND PdhDedCode IN (
--        '401CA'
--        ,'401CB'
--        ,'401CS'
--        ,'401CT'
--        ,'401CU'
--        ,'401K'
--        ,'401KA'
--        ,'401KB'
--        ,'401KS'
--        ,'401KT'
--        ,'401KM'
--        ,'401CM'
--        ,'401MM' -- Wes Burger 10/05/2018
--        )
----AND eepHomeCoID <> 'H4VKS' --- RAD SF 04231153
--GROUP BY xCOID
--    ,xEEID
--    ,EepSSN
--    ,CmpCompanyCode
--    ,PdhDedCode

----update adj reason - if raw amount <0 then 'P':
--UPDATE dbo.U_Dsi_DrvTbl_EFIDCON2_19
--SET DrvAdjReason = CASE 
--        WHEN DrvAmountRaw < 0
--            THEN 'P'
--        ELSE DrvAdjReason
--        END
--WHERE drvAmountRaw < 0

-----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFIDCON2_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDCON2_PDedHist;
    SELECT DISTINCT
         PdhEEID
         ,pdhCoID
        ,pdhEECurAmt  = SUM(CASE WHEN pdhDedCode IN ('401CA','401CB','401CS','401KA','401KB' ,'401KS','401K','401CU' ,'401KT' ,'401KZ' ,'401MM','401M','401CM','ROTHT','ATSAV','ROTH') THEN pdhEECurAmt END)
        ,pdhSourceCode =   CASE When pdhDedCode in ('401KZ', '401K', '401CU', '401MM', '401M', '401CM', '401KT', '401CA', '401CB', '401CS', '401KA', '401KB', '401KS') then '01'
                                When pdhDedCode in ('401K', '401CU', '401MM', '401CM', '401CA', '401CB', '401CS', '401KA', '401KB', '401KS') THEN '02'
                                When pdhDedCode in ('Roth','ROTHT') then '10'
                                When pdhDedCode in ('ATSAV') then '15'
                                END
        
                        --CASE WHEN CmpCompanyCode NOT IN ('HH','BHH','SNDNC') then CASE
        --                                                                When pdhDedCode in ('401KZ', '401K', '401CU', '401MM','401M','401CM') then '01'
        --                                                                When pdhDedCode in ('401k', '401CU', '401MM', '401CM') THEN '02'
        --                                                                When pdhDedCode in ('Roth') then '10'
        --                                                                When pdhDedCode in ('ATSAV') then '15'
        --                                                                END

                    --    WHEN CmpCompanyCode IN ('HH','BHH','SNDNC') then 
                    --                                CASE When pdhDedCode in ('401KT', '401CA', '401CB', '401CS', '401KA', '401KB', '401KS', '401MM','401M', '401CM') then '01'
                    --                                When pdhDedCode in ('401CA', '401CB', '401CS', '401KA', '401KB', '401KS', '401MM', '401CM') THEN '02'
                    --                                When pdhDedCode in ('ROTHT') then '09'
                    --                                When pdhDedCode in ('ATSAV') then '14'
                    --                                END
                    --END
       ,pdhTransCode = CASE WHEN pdhDedCode IN('401MM','401M') THEN '295' ELSE '220' END
                    
    INTO dbo.U_EFIDCON2_PDedHist
    FROM dbo.U_EFIDCON2_EEList WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
        AND pdhCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        On cmpCoID = xCOID
    WHERE PdhPerControl BETWEEN @StartPerControl
        AND @EndPerControl
    AND PdhEECurAmt <> 0
    AND pdhDedCode IN ('401CA','401CB','401CS','401KA','401KB' ,'401KS','401K','401CU' ,'401KT' ,'401KZ' ,'401MM','401M','401CM','ROTHT','ATSAV','ROTH','401M')
    GROUP BY PdhEEID,pdhDedCode,pdhCoID, CASE When pdhDedCode in ('401KZ', '401K', '401CU', '401MM', '401M', '401CM', '401KT', '401CA', '401CB', '401CS', '401KA', '401KB', '401KS') then '01'
                                When pdhDedCode in ('401k', '401CU', '401MM', '401CM', '401CA', '401CB', '401CS', '401KA', '401KB', '401KS') THEN '02'
                                When pdhDedCode in ('Roth','ROTHT') then '10'
                                When pdhDedCode in ('ATSAV') then '15'
                                END
                                
                                --CASE WHEN CmpCompanyCode NOT IN ('HH','BHH','SNDNC') then CASE
        --                                                                When pdhDedCode in ('401KZ', '401K', '401CU', '401MM','401M','401CM') then '01'
        --                                                                When pdhDedCode in ('401k', '401CU', '401MM', '401CM') THEN '02'
        --                                                                When pdhDedCode in ('Roth') then '10'
        --                                                                When pdhDedCode in ('ATSAV') then '15'
        --                                                                END

        --                WHEN CmpCompanyCode IN ('HH','BHH','SNDNC') then 
        --                                            CASE When pdhDedCode in ('401KT', '401CA', '401CB', '401CS', '401KA', '401KB', '401KS', '401MM','401M', '401CM') then '01'
        --                                            When pdhDedCode in ('401CA', '401CB', '401CS', '401KA', '401KB', '401KS', '401MM', '401CM') THEN '02'
        --                                            When pdhDedCode in ('ROTHT') then '09'
        --                                            When pdhDedCode in ('ATSAV') then '14'
        --                                            END
        --            END


-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDCON2_21
-----------------------
SELECT DISTINCT DrvCOID = xCOID
    ,DrvEEID = xEEID
    ,DrvPlanNumber ='37379' --CASE WHEN CmpCompanyCode IN ('HH','BHH','SNDNC') THEN '93523' ELSE '37379' END
    ,DrvBatchGroupID = ''
    ,DrvFiller1 = ''
    ,DrvSocialSecurityNumber = SUBSTRING(EepSSN, 1, 3) + '-' + SUBSTRING(EepSSN, 4, 2) + '-' + SUBSTRING(EepSSN, 6, 4)
    ,DrvFiller2 = ''
    ,DrvReserved1 = '00000'
    ,DrvRecordIdentifier = '21'
    ,DrvFiller3 = ''
    ,DrvLoanIdentification = CASE 
        WHEN PdhDedCode IN (
                '401L1'
                ,'401LA'
                ,'401LB'
                ,'401LS'
                ,'401LT'
                )
            THEN 'LOAN 1'
        WHEN PdhDedCode = '401L2'
            THEN 'LOAN 2'
        END
    ,DrvFiller4 = ''
    ,DrvTransactionCode = '260'
    ,DrvItemNumber = '14'
    ,DrvReserved2 = '00'
    ,DrvFiller5 = ''
    ,DrvPrincipalAmountRaw = SUM(PdhEECurAmt)
    ,DrvPrincipalAmount = SUM(PdhEECurAmt)
    ,DrvAdjReason = space(1)
    ,DrvFiller6 = ''
    ,DrvInterestAmount = ''
    ,DrvFiller7 = ''
    ,DrvPrincipalOnlyFlag = ''
    ,DrvNewRepaymentFrequency = ''
    ,DrvFiller8 = ''
INTO dbo.U_Dsi_DrvTbl_EFIDCON2_21
FROM dbo.U_EFIDCON2_EEList
JOIN EmpPers WITH (NOLOCK) ON xEEID = EepEEID
JOIN PDedHist WITH (NOLOCK) ON PdhEEID = xEEID
    AND PdhCOID = xCOID
JOIN dbo.Company WITH (NOLOCK) ON CmpCoid = Xcoid
WHERE PdhPerControl BETWEEN @StartPerControl
        AND @EndPerControl
    AND PdhEECurAmt <> 0
    AND PdhDedCode IN (
        '401L1'
        ,'401L2'
        ,'401LA'
        ,'401LB'
        ,'401LS'
        ,'401LT'
        )
--AND eepHomeCoID <> 'H4VKS' --- RAD SF 04231153
GROUP BY xCOID
    ,xEEID
    ,EepSSN
    ,PdhDedCode
    ,CmpCompanyCode

--update adj reason - if raw amount <0 then 'P':
UPDATE dbo.U_Dsi_DrvTbl_EFIDCON2_21
SET DrvAdjReason = CASE 
        WHEN DrvPrincipalAmountRaw < 0
            THEN 'P'
        ELSE DrvAdjReason
        END
WHERE DrvPrincipalAmountRaw < 0

--select * from U_Dsi_DrvTbl_EFIDCON2_21


-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDCON2_3K
-----------------------
SELECT DISTINCT DrvCOID = xCOID
    ,DrvEEID = xEEID
    ,DrvPlanNumber ='37379' --CASE WHEN CmpCompanyCode IN ('HH','BHH','SNDNC') THEN '93523' ELSE '37379' END
    ,DrvBatchGroupID = '' --16B5
    
    --CASE WHEN cmpCompanyCode IN('HH','BHH') THEN 'BLUE'
    --                        WHEN cmpcompanyCode IN('SNDNC') THEN 'SUN'
    --                        ELSE 'AMC'
    --                        END
    ,DrvSocialSecurityNumber = SUBSTRING(EepSSN, 1, 3) + '-' + SUBSTRING(EepSSN, 4, 2) + '-' + SUBSTRING(EepSSN, 6, 4)
    ,DrvFiller1 = ''
    ,DrvReserved1 = '00000'
    ,DrvRecordIdentifier = '3K'
    ,drvFiscalYear = (SELECT CONVERT(VARCHAR(4),MAX(PrgPayDate),112) FROM dbo.PayReg WITH (NOLOCK) WHERE prgEEID = xEEID AND prgCoID = xCOID AND prgPerControl BETWEEN @Startpercontrol AND @EndPerControl)
    ,drvTransCode =pdhTransCode--'220'
    ,DrvFiller2 = ''
    ,DrvTransactionCode = '260'
    ,DrvFiller3 = ''
    ,drvSource = pdhSourceCode
    ,drvItemNumber = '01'
    ,drvReserved2 = ''
    ,drvAmount = pdhEECuramt
    ,drvReason = ''
    ,drvOriginalPayDate = ''
    ,drvEmpSalary = SUM(CASE WHEN pehInclInDefComp ='Y' THEN PehCuramt ELSE 0.00 END)
    ,drvReserved3 = '000'
INTO dbo.U_Dsi_DrvTbl_EFIDCON2_3K
FROM dbo.U_EFIDCON2_EEList
JOIN EmpPers WITH (NOLOCK) ON xEEID = EepEEID
JOIN dbo.U_EFIDCON2_PDedHist WITH (NOLOCK)
    ON pdhEEID = xEEID
--JOIN PDedHist WITH (NOLOCK) ON PdhEEID = xEEID
--    AND PdhCOID = xCOID
LEFT JOIN Pearhist WITH (NOLOCK) ON PehEEID = xEEID
    AND PehCOID = xCOID
JOIN dbo.Company WITH (NOLOCK) ON CmpCoid = Xcoid
WHERE pehPerControl BETWEEN @StartPerControl AND @EndPerControl
--WHERE PdhPerControl BETWEEN @StartPerControl
--        AND @EndPerControl
--    AND PdhEECurAmt <> 0
--    AND PdhDedCode IN (
--        '401CA'
--        ,'401CB'
--        ,'401CS'
--        ,'401KA'
--        ,'401KB'
--        ,'401KS'    
--        ,'401K'
--        ,'401CU'
--        ,'401KT'
--        ,'401KZ'
--        ,'401MM'
--        ,'401CM'
--        ,'ROTHT'
--        ,'ATSAV'
--        ,'ROTH'
--        )
--        AND pehPerControl BETWEEN @StartPerControl AND @EndPerControl

GROUP BY xCOID
    ,xEEID
    ,EepSSN
    ,pdhSourceCode
    ,pdhEECuramt
    ,pdhTransCode
--    ,PdhDedCode
    ,CmpCompanyCode

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



-----------------------
-- Update filename
-----------------------
--UPDATE dbo.U_dsi_Parameters
--SET ExportFile = 'FPRS.PAS.AMU2TXNS(+1)'
--WHERE SystemID = @SystemID

/**********************************************************************************

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFIDCON2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

**********************************************************************************/
GO
CREATE View [dbo].[dsi_vwEFIDCON2_Export] as
        select top 2000000 UPPER(Data) AS UPPERDATA from dbo.U_EFIDCON2_File with (nolock)
        order by InitialSort,substring(RecordSet,2,2),Data