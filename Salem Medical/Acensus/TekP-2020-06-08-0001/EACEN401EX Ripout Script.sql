SET NOCOUNT ON;
IF OBJECT_ID('U_EACEN401EX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EACEN401EX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EACEN401EX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EACEN401EX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEACEN401EX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEACEN401EX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EACEN401EX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EACEN401EX];
GO
IF OBJECT_ID('U_EACEN401EX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EACEN401EX_PEarHist];
GO
IF OBJECT_ID('U_EACEN401EX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EACEN401EX_PDedHist];
GO
IF OBJECT_ID('U_EACEN401EX_File') IS NOT NULL DROP TABLE [dbo].[U_EACEN401EX_File];
GO
IF OBJECT_ID('U_EACEN401EX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EACEN401EX_EEList];
GO
IF OBJECT_ID('U_EACEN401EX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EACEN401EX_drvTbl];
GO
IF OBJECT_ID('U_EACEN401EX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EACEN401EX_DedList];
GO
IF OBJECT_ID('U_EACEN401EX_03_Header') IS NOT NULL DROP TABLE [dbo].[U_EACEN401EX_03_Header];
GO
IF OBJECT_ID('U_EACEN401EX_02_Header') IS NOT NULL DROP TABLE [dbo].[U_EACEN401EX_02_Header];
GO
IF OBJECT_ID('U_dsi_BDM_EACEN401EX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EACEN401EX];
GO
IF OBJECT_ID('dbo.U_EACEN401EX_HdrTbl_02') IS NOT NULL DROP TABLE [dbo].[dbo.U_EACEN401EX_HdrTbl_02];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EACEN401EX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EACEN401EX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EACEN401EX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EACEN401EX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EACEN401EX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EACEN401EX','Acensus 401K Eligibilty Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EACEN401EXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN NAME:"','1','(''DA''=''T,'')','EACEN401EXZ0','50','H','01','1',NULL,'PLAN NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"258952"','2','(''DA''=''T'')','EACEN401EXZ0','50','H','01','2',NULL,'PLAN NAME VALUE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAYROLL DATE:"','1','(''DA''=''T,'')','EACEN401EXZ0','50','H','02','1',NULL,'PAYROLL DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayRollDate"','2','(''UD101''=''T'')','EACEN401EXZ0','50','H','02','2',NULL,'PAYROLL DATE VALUE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SITE:"','1','(''DA''=''T,'')','EACEN401EXZ0','50','H','03','1',NULL,'SITE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','2','(''DA''=''T,'')','EACEN401EXZ0','50','H','03','2',NULL,'SITE VALUE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','3','(''DA''=''T,'')','EACEN401EXZ0','50','H','03','3',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','4','(''DA''=''T,'')','EACEN401EXZ0','50','H','03','4',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TOTALS"','5','(''DA''=''T,'')','EACEN401EXZ0','50','H','03','5',NULL,'TOTALS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalCompensation"','6','(''UA''=''T,'')','EACEN401EXZ0','50','H','03','6',NULL,'TOTAL COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployee401K"','7','(''UA''=''T,'')','EACEN401EXZ0','50','H','03','7',NULL,'EMPLOYEE 401(K)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRoth401K"','8','(''UA''=''T,'')','EACEN401EXZ0','50','H','03','8',NULL,'ROTH 401(K)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentAmt"','9','(''UA''=''T,'')','EACEN401EXZ0','50','H','03','9',NULL,'LOAN PAYMENT AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EACEN401EXZ0','50','H','03','10',NULL,'MATCH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','11','(''DA''=''T,'')','EACEN401EXZ0','50','H','03','11',NULL,'PROFIT SHARING',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','12','(''DA''=''T,'')','EACEN401EXZ0','50','H','03','12',NULL,'SAFE HARBOR MATCH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','13','(''DA''=''T,'')','EACEN401EXZ0','50','H','03','13',NULL,'SAFE HARBOR NEC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','14','(''DA''=''T,'')','EACEN401EXZ0','50','H','03','14',NULL,'CLIENT SPECIFIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','15','(''DA''=''T,'')','EACEN401EXZ0','50','H','03','15',NULL,'CLIENT SPECIFIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','16','(''DA''=''T,'')','EACEN401EXZ0','50','H','03','16',NULL,'CLIENT SPECIFIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHours"','17','(''UA''=''T,'')','EACEN401EXZ0','50','H','03','17',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SOCIAL SECURITY"','1','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','1',NULL,'SOCIAL SECURITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST NAME"','2','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','2',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST NAME"','3','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','3',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MI"','4','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','4',NULL,'MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISIONAL CODE"','5','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','5',NULL,'DIVISIONAL CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TOTAL COMPENSATION"','6','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','6',NULL,'TOTAL COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE 401(K)"','7','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','7',NULL,'EMPLOYEE 401(K)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ROTH 401(K)"','8','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','8',NULL,'ROTH 401(K)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOAN PAYMENT AMOUNT"','9','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','9',NULL,'LOAN PAYMENT AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MATCH"','10','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','10',NULL,'MATCH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PROFIT SHARING"','11','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','11',NULL,'PROFIT SHARING',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAFE HARBOR MATCH"','12','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','12',NULL,'SAFE HARBOR MATCH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAFE HARBOR NEC"','13','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','13',NULL,'SAFE HARBOR NEC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLIENT SPECIFIC"','14','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','14',NULL,'CLIENT SPECIFIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLIENT SPECIFIC"','15','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','15',NULL,'CLIENT SPECIFIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLIENT SPECIFIC"','16','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','16',NULL,'CLIENT SPECIFIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOURS"','17','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','17',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS 1"','18','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','18',NULL,'ADDRESS 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS  2"','19','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','19',NULL,'ADDRESS  2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CITY"','20','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','20',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STATE"','21','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','21',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZIP"','22','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','22',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE OF BIRTH"','23','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','23',NULL,'DATE OF BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CURRENT DATE OF HIRE"','24','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','24',NULL,'CURRENT DATE OF HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE ELIGIBILITY DATE"','25','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','25',NULL,'EMPLOYEE ELIGIBILITY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CURRENT DATE OF TERM"','26','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','26',NULL,'CURRENT DATE OF TERM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIOR DATE OF HIRE"','27','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','27',NULL,'PRIOR DATE OF HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIOR DATE OF TERM"','28','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','28',NULL,'PRIOR DATE OF TERM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ESTIMATED ANNUAL COMPENSATION"','29','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','29',NULL,'ESTIMATED ANNUAL COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYMENT STATUS"','30','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','30',NULL,'EMPLOYMENT STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HCE CODE"','31','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','31',NULL,'HCE CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"KEY EE CODE"','32','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','32',NULL,'KEY EE CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENROLLMENT ELIGIBILITY"','33','(''DA''=''T,'')','EACEN401EXZ0','50','H','04','33',NULL,'ENROLLMENT ELIGIBILITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNION STATUS CODE"','34','(''DA''=''T'')','EACEN401EXZ0','50','H','04','34',NULL,'UNION STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','1',NULL,'SOCIAL SECURITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','2','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','2',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','3','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','3',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','4','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','4',NULL,'MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','5',NULL,'DIVISIONAL CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalCompensation"','6','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','6',NULL,'TOTAL COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployee401K"','7','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','7',NULL,'EMPLOYEE 401(K)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRoth401K"','8','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','8',NULL,'ROTH 401(K)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentAmt"','9','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','9',NULL,'LOAN PAYMENT AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','10',NULL,'MATCH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','11',NULL,'PROFIT SHARING',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','12',NULL,'SAFE HARBOR MATCH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','13',NULL,'SAFE HARBOR NEC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','14',NULL,'CLIENT SPECIFIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','15',NULL,'CLIENT SPECIFIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','16',NULL,'CLIENT SPECIFIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHours"','17','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','17',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','18','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','18',NULL,'ADDRESS 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','19','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','19',NULL,'ADDRESS  2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','20','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','20',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','21','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','21',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressPostalCode"','22','(''UA''=''T,'')','EACEN401EXZ0','50','D','10','22',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','23','(''UD101''=''T,'')','EACEN401EXZ0','50','D','10','23',NULL,'DATE OF BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentDateOfHire"','24','(''UD101''=''T,'')','EACEN401EXZ0','50','D','10','24',NULL,'CURRENT DATE OF HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentDateOfTerm"','25','(''UD101''=''T,'')','EACEN401EXZ0','50','D','10','25',NULL,'EMPLOYEE ELIGIBILITY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','26',NULL,'CURRENT DATE OF TERM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorDateOfHire"','27','(''UD101''=''T,'')','EACEN401EXZ0','50','D','10','27',NULL,'PRIOR DATE OF HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorDateOfTerm"','28','(''UD101''=''T,'')','EACEN401EXZ0','50','D','10','28',NULL,'PRIOR DATE OF TERM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','29',NULL,'ESTIMATED ANNUAL COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','30',NULL,'EMPLOYMENT STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','31',NULL,'HCE CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','32',NULL,'KEY EE CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T,'')','EACEN401EXZ0','50','D','10','33',NULL,'ENROLLMENT ELIGIBILITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T'')','EACEN401EXZ0','50','D','10','34',NULL,'UNION STATUS CODE',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EACEN401EX_20200930.txt',NULL,'','',NULL,NULL,NULL,NULL,'Acensus 401K Eligibilty Export','202007249','EMPEXPORT','ONDEM_XOE',NULL,'EACEN401EX',NULL,NULL,NULL,'202007249','Aug 20 2020  5:51PM','Aug 20 2020  5:51PM','202007241',NULL,'','','202007241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EACEN401EX_20200930.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Acensus 401K Eligibilty -Sched','202007249','EMPEXPORT','SCH_EACEN4',NULL,'EACEN401EX',NULL,NULL,NULL,'202007249','Aug 20 2020  5:51PM','Aug 20 2020  5:51PM','202007241',NULL,'','','202007241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EACEN401EX_20200930.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202007249','EMPEXPORT','OEACTIVE',NULL,'EACEN401EX',NULL,NULL,NULL,'202007249','Aug 20 2020  5:51PM','Aug 20 2020  5:51PM','202007241',NULL,'','','202007241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EACEN401EX_20200930.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202007249','EMPEXPORT','OEPASSIVE',NULL,'EACEN401EX',NULL,NULL,NULL,'202007249','Aug 20 2020  5:51PM','Aug 20 2020  5:51PM','202007241',NULL,'','','202007241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EACEN401EX_20200930.txt',NULL,'','','',NULL,NULL,NULL,'Acensus 401K Eligibilty -Test','202009041','EMPEXPORT','TEST_XOE','Sep 29 2020  1:05PM','EACEN401EX',NULL,NULL,NULL,'202009041','Sep  4 2020 12:00AM','Aug 29 2020 12:00AM','202009041','282','','','202009041',dbo.fn_GetTimedKey(),NULL,'us3rVaSAL1011',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EACEN401EX_20200930.txt' END WHERE expFormatCode = 'EACEN401EX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACEN401EX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACEN401EX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACEN401EX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACEN401EX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACEN401EX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EACEN401EX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EACEN401EX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EACEN401EX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EACEN401EX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EACEN401EX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EACEN401EX','H02','dbo.U_EACEN401EX_02_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EACEN401EX','H03','dbo.U_EACEN401EX_03_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EACEN401EX','D10','dbo.U_EACEN401EX_drvTbl',NULL);
IF OBJECT_ID('dbo.U_EACEN401EX_HdrTbl_02') IS NULL
CREATE TABLE [dbo].[dbo.U_EACEN401EX_HdrTbl_02] (
    [drvPayrollDate] varchar(50) NULL
);
IF OBJECT_ID('U_dsi_BDM_EACEN401EX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EACEN401EX] (
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
IF OBJECT_ID('U_EACEN401EX_02_Header') IS NULL
CREATE TABLE [dbo].[U_EACEN401EX_02_Header] (
    [drvPayRollDate] datetime NULL
);
IF OBJECT_ID('U_EACEN401EX_03_Header') IS NULL
CREATE TABLE [dbo].[U_EACEN401EX_03_Header] (
    [drvTotalCompensation] nvarchar(4000) NULL,
    [drvEmployee401K] nvarchar(4000) NULL,
    [drvRoth401K] nvarchar(4000) NULL,
    [drvLoanPaymentAmt] nvarchar(4000) NULL,
    [drvHours] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EACEN401EX_DedList') IS NULL
CREATE TABLE [dbo].[U_EACEN401EX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EACEN401EX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EACEN401EX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] varchar(13) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvTotalCompensation] nvarchar(4000) NULL,
    [drvEmployee401K] nvarchar(4000) NULL,
    [drvRoth401K] nvarchar(4000) NULL,
    [drvLoanPaymentAmt] nvarchar(4000) NULL,
    [drvHours] nvarchar(4000) NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressPostalCode] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvCurrentDateOfHire] datetime NULL,
    [drvCurrentDateOfTerm] datetime NULL,
    [drvPriorDateOfHire] datetime NULL,
    [drvPriorDateOfTerm] datetime NULL
);
IF OBJECT_ID('U_EACEN401EX_EEList') IS NULL
CREATE TABLE [dbo].[U_EACEN401EX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EACEN401EX_File') IS NULL
CREATE TABLE [dbo].[U_EACEN401EX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EACEN401EX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EACEN401EX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhEmployee401k] numeric NULL,
    [PdhRoth401k] numeric NULL,
    [PdhLoanPaymentAmt] numeric NULL
);
IF OBJECT_ID('U_EACEN401EX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EACEN401EX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EACEN401EX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Salem Medical

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 08/20/2020
Service Request Number: TekP-2020-06-08-0001

Purpose: Acensus 401K Eligibilty Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EACEN401EX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EACEN401EX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EACEN401EX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EACEN401EX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EACEN401EX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACEN401EX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACEN401EX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACEN401EX', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EACEN401EX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EACEN401EX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EACEN401EX';

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
    DELETE FROM dbo.U_EACEN401EX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EACEN401EX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)

    SET @DedList = '401K,CODE,CODE2,ROTH,401CU,401LN,401KD';

    IF OBJECT_ID('U_EACEN401EX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EACEN401EX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EACEN401EX_DedList
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
    IF OBJECT_ID('U_EACEN401EX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EACEN401EX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhEmployee401k     = SUM(CASE WHEN PdhDedCode IN ('401K', '401CU','401KD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRoth401k     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLoanPaymentAmt     = SUM(CASE WHEN PdhDedCode IN ('401LN') THEN PdhEECurAmt ELSE 0.00 END)        
    INTO dbo.U_EACEN401EX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EACEN401EX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EACEN401EX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EACEN401EX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EACEN401EX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = '"' + RTRIM(eepSSN) + '"'
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvTotalCompensation = FORMAT(EeeLstAmt, '#0.00')
        ,drvEmployee401K = FORMAT(PdhEmployee401k, '#0.00')
        ,drvRoth401K = FORMAT(PdhRoth401k, '#0.00')
        ,drvLoanPaymentAmt = FORMAT(PdhLoanPaymentAmt, '#0.00')
        ,drvHours = FORMAT(EeeLstHrs, '#')
        ,drvAddressLine1 = '"' + EepAddressLine1 + '"'
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressPostalCode = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvCurrentDateOfHire = EecDateOfLastHire
        ,drvCurrentDateOfTerm = EecDateOfTermination
        ,drvPriorDateOfHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfOriginalHire END
        ,drvPriorDateOfTerm = EecDateOfTermination
    INTO dbo.U_EACEN401EX_drvTbl
    FROM dbo.U_EACEN401EX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EACEN401EX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_EACEN401EX_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN (
            SELECT EeeEEID, EeeCOID, SUM(EeeLstAmt) AS EeeLstAmt, SUM(EeeLstHrs) AS EeeLstHrs
            FROM dbo.EmpEarn WITH (NOLOCK)
            --WHERE EeeEarnCode NOT IN ('GTIMP')
            WHERE EeeEarnCode IN ('CB','CHRG','CHRG5','FLOAT','IC20','IC300','IC500','OC10','OC3','OC5','OT','OTP','OTPS2','OTPS3','PTO','PTOCA','REG','REG2','REG3','RP','SALEM','TRIN2','TRINS','TROR2','TROR3','TRORI')
            GROUP BY EeeEEID, EeeCOID
        ) AS Earnings
        ON EeeEEID = xEEID
        AND EeeCOID = xCOID
    ;


    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EACEN401EX_02_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EACEN401EX_02_Header;
    SELECT DISTINCT
         drvPayRollDate = @ENDDATE
    INTO dbo.U_EACEN401EX_02_Header
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EACEN401EX_03_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EACEN401EX_03_Header;
    SELECT DISTINCT
         drvTotalCompensation = FORMAT((SELECT SUM(CAST(drvTotalCompensation AS FLOAT)) FROM dbo.U_EACEN401EX_drvTbl), '#0.00')
        ,drvEmployee401K = FORMAT((SELECT SUM(CAST(drvEmployee401K AS FLOAT)) FROM dbo.U_EACEN401EX_drvTbl), '#0.00')
        ,drvRoth401K = FORMAT((SELECT SUM(CAST(drvRoth401K AS FLOAT)) FROM dbo.U_EACEN401EX_drvTbl), '#0.00')
        ,drvLoanPaymentAmt = FORMAT((SELECT SUM(CAST(drvLoanPaymentAmt AS FLOAT)) FROM dbo.U_EACEN401EX_drvTbl), '#0.00')
        ,drvHours = FORMAT((SELECT SUM(CAST(drvHours AS FLOAT)) FROM dbo.U_EACEN401EX_drvTbl), '#0.00')
    INTO dbo.U_EACEN401EX_03_Header
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
ALTER VIEW dbo.dsi_vwEACEN401EX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EACEN401EX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EACEN401EX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007241'
       ,expStartPerControl     = '202007241'
       ,expLastEndPerControl   = '202007249'
       ,expEndPerControl       = '202007249'
WHERE expFormatCode = 'EACEN401EX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEACEN401EX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EACEN401EX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort