SET NOCOUNT ON;
IF OBJECT_ID('U_EWAGEWREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EWAGEWREXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EWAGEWREXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EWAGEWREXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEWAGEWREXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWAGEWREXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWAGEWREXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWAGEWREXP];
GO
IF OBJECT_ID('U_EWAGEWREXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EWAGEWREXP_PEarHist];
GO
IF OBJECT_ID('U_EWAGEWREXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EWAGEWREXP_PDedHist];
GO
IF OBJECT_ID('U_EWAGEWREXP_File') IS NOT NULL DROP TABLE [dbo].[U_EWAGEWREXP_File];
GO
IF OBJECT_ID('U_EWAGEWREXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWAGEWREXP_EEList];
GO
IF OBJECT_ID('U_EWAGEWREXP_drvTbl_PRO') IS NOT NULL DROP TABLE [dbo].[U_EWAGEWREXP_drvTbl_PRO];
GO
IF OBJECT_ID('U_EWAGEWREXP_drvTbl_EPRO') IS NOT NULL DROP TABLE [dbo].[U_EWAGEWREXP_drvTbl_EPRO];
GO
IF OBJECT_ID('U_EWAGEWREXP_drvTbl_ENR') IS NOT NULL DROP TABLE [dbo].[U_EWAGEWREXP_drvTbl_ENR];
GO
IF OBJECT_ID('U_EWAGEWREXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EWAGEWREXP_DedList];
GO
IF OBJECT_ID('U_EWAGEWREXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EWAGEWREXP_AuditFields];
GO
IF OBJECT_ID('U_EWAGEWREXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EWAGEWREXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EWAGEWREXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EWAGEWREXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EWAGEWREXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EWAGEWREXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EWAGEWREXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EWAGEWREXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EWAGEWREXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EWAGEWREXP','WageWorks FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EWAGEWREXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRO"','1','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"48317"','2','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','2',NULL,'WW Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpId"','3','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','3',NULL,'Participant or Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','4',NULL,'Unique ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','5',NULL,'Change to Unique ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','6',NULL,'Old Unique ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','7',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','8','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','8',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','9',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','10','(''UD101''=''T|'')','EWAGEWREXPZ0','50','D','10','10',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','11',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','12',NULL,'Street Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','13',NULL,'Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','15',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','16','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','16',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','17',NULL,'Zip Code Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','18',NULL,'Work ZIP Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','19','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','19',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','20',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','21',NULL,'Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','22','(''UD101''=''T|'')','EWAGEWREXPZ0','50','D','10','22',NULL,'Employment Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','23','(''UD101''=''T|'')','EWAGEWREXPZ0','50','D','10','23',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','24',NULL,'Benefit Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','25',NULL,'Benefit Group Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','26',NULL,'Payroll Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','27',NULL,'Payroll Group Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocCode"','28','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','28',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyCode"','29','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','29',NULL,'Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','30',NULL,'For Future Use 1 (Commuter)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','31',NULL,'For Future Use 2 (Commuter)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','32',NULL,'Bank Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','33',NULL,'Bank Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','34',NULL,'Bank Routing Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','35',NULL,'Bank Account Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','36',NULL,'Payment Preference',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCommuterBenGrp"','37','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','37',NULL,'Commuter Program Benefit Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLvlMthSubPTVPAmt"','38','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','38',NULL,'Participant Level Monthly Subsidy for PT&VP: Amoun',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','39',NULL,'Participant Level Monthly Subsidy for PT&VP: Perce',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','40',NULL,'Participant Level Monthly Subsidy for PT&VP: Maxim',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','41',NULL,'For Future Use 3 (Commuter)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLvlMnthSubPKAmt"','42','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','10','42',NULL,'Participant Level Monthly Subsidy for PK: Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','43',NULL,'Participant Level Monthly Subsidy for PK: Percenta',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','44',NULL,'Participant Level Monthly Subsidy for PK: Maximum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','45',NULL,'For Future Use 4 (Commuter)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','46',NULL,'For Future Use 5 (Commuter)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','47',NULL,'For Internal Use Only 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','48',NULL,'For Internal Use Only 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','49',NULL,'For Internal Use Only 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','50',NULL,'For Internal Use Only 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','51',NULL,'For Internal Use Only 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','52',NULL,'For Internal Use Only 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','53',NULL,'For Internal Use Only 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','54',NULL,'For Internal Use Only 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','55',NULL,'For Internal Use Only 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','10','56',NULL,'For Internal Use Only 10 (Health Care)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''T'')','EWAGEWREXPZ0','50','D','10','57',NULL,'For Future Use Only 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EPRO"','1','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"48317"','2','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','20','2',NULL,'WW Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','3','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','20','3',NULL,'Participant or Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','20','4',NULL,'Unique ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','20','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','20','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','20','7',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','20','8',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','20','9',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','20','10',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','20','11',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','20','12',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLvlMaxCommSub"','13','(''UA''=''T'')','EWAGEWREXPZ0','50','D','20','13',NULL,'Participant Level Maximum Commuter Subsidy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENR"','1','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"48317"','2','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','2',NULL,'WW Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','3','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','30','3',NULL,'Participant or Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','30','4',NULL,'Unique ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','30','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','30','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode"','7','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','30','7',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','8',NULL,'Plan Action Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectionAmt"','9','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','30','9',NULL,'Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate"','10','(''UD101''=''T|'')','EWAGEWREXPZ0','50','D','30','10',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEndDate"','11','(''UD101''=''T|'')','EWAGEWREXPZ0','50','D','30','11',NULL,'Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHsaFsaOption"','12','(''UA''=''T|'')','EWAGEWREXPZ0','50','D','30','12',NULL,'HSA-Compatible FSA Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHsaFsaOptEffDate"','13','(''UD101''=''T|'')','EWAGEWREXPZ0','50','D','30','13',NULL,'HSA-Compatible FSA Option Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','14',NULL,'Standard FSA Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','15',NULL,'Standard FSA Option Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','16',NULL,'Deductible Requirement Met',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','17',NULL,'Automatic Health Plan Claims',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','18',NULL,'Terms & Conditions Accept Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','19',NULL,'Terms & Conditions Timestamp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','20',NULL,'Custodian Statement Preference',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','21',NULL,'Period of Non-Coverage Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','22',NULL,'Period of Non-Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','23',NULL,'Period of Non-Coverage Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','24',NULL,'HDHP Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','25',NULL,'HDHP Coverage Calendar Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T|'')','EWAGEWREXPZ0','50','D','30','26',NULL,'HRA Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T'')','EWAGEWREXPZ0','50','D','30','27',NULL,'For Internal Use  Only 1',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EWAGEWREXP_20200407.txt',NULL,'','',NULL,NULL,NULL,NULL,'WageWorks FSA Export','202004039','EMPEXPORT','ONDEMAND',NULL,'EWAGEWREXP',NULL,NULL,NULL,'202004039','Feb  3 2020  9:10AM','Feb  3 2020  9:10AM','202003301',NULL,'','','202003301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EWAGEWREXP_20200407.txt',NULL,'Null','N',',Z36FF',NULL,NULL,NULL,'Wageworks FSA Elig - Fri 8am','202004039','EMPEXPORT','SCHEDULED',NULL,'EWAGEWREXP',NULL,NULL,NULL,'202004039','Feb  3 2020  9:10AM','Feb  3 2020  9:10AM','202003301',NULL,'','','202003301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EWAGEWREXP_20200407.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202004039','EMPEXPORT','OEACTIVE',NULL,'EWAGEWREXP',NULL,NULL,NULL,'202004039','Feb  3 2020  9:10AM','Feb  3 2020  9:10AM','202003301',NULL,'','','202003301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EWAGEWREXP_20200407.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202004039','EMPEXPORT','OEPASSIVE',NULL,'EWAGEWREXP',NULL,NULL,NULL,'202004039','Feb  3 2020  9:10AM','Feb  3 2020  9:10AM','202003301',NULL,'','','202003301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EWAGEWREXP_20200407.txt',NULL,'','','Z36FF',NULL,NULL,NULL,'Test Purposes Only','202004039','EMPEXPORT','TEST','Mar 10 2020 10:07AM','EWAGEWREXP',NULL,NULL,NULL,'202004039','Mar 10 2020 12:00AM','Dec 30 1899 12:00AM','202003301','57','','','202003301',dbo.fn_GetTimedKey(),NULL,'us3lKiGEO1007',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EWAGEWREXP_20200407.txt' END WHERE expFormatCode = 'EWAGEWREXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWAGEWREXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWAGEWREXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWAGEWREXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWAGEWREXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWAGEWREXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EWAGEWREXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EWAGEWREXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EWAGEWREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EWAGEWREXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWAGEWREXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWAGEWREXP','D10','dbo.U_EWAGEWREXP_drvTbl_PRO',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWAGEWREXP','D20','dbo.U_EWAGEWREXP_drvTbl_EPRO',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWAGEWREXP','D30','dbo.U_EWAGEWREXP_drvTbl_ENR',NULL);
IF OBJECT_ID('U_dsi_BDM_EWAGEWREXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EWAGEWREXP] (
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
IF OBJECT_ID('U_EWAGEWREXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EWAGEWREXP_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EWAGEWREXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EWAGEWREXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EWAGEWREXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EWAGEWREXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EWAGEWREXP_drvTbl_ENR') IS NULL
CREATE TABLE [dbo].[U_EWAGEWREXP_drvTbl_ENR] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(5) NULL,
    [drvEmpNo] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvPlanCode] varchar(9) NULL,
    [drvElectionAmt] money NULL,
    [drvCoverageStartDate] datetime NULL,
    [drvCoverageEndDate] datetime NULL,
    [drvHsaFsaOption] varchar(1) NULL,
    [drvHsaFsaOptEffDate] datetime NULL
);
IF OBJECT_ID('U_EWAGEWREXP_drvTbl_EPRO') IS NULL
CREATE TABLE [dbo].[U_EWAGEWREXP_drvTbl_EPRO] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmpNo] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvPartLvlMaxCommSub] varchar(3) NULL
);
IF OBJECT_ID('U_EWAGEWREXP_drvTbl_PRO') IS NULL
CREATE TABLE [dbo].[U_EWAGEWREXP_drvTbl_PRO] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmpId] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(5) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvLocCode] char(6) NULL,
    [drvCompanyCode] char(8) NULL,
    [drvCommuterBenGrp] varchar(1) NOT NULL,
    [drvPartLvlMthSubPTVPAmt] varchar(3) NULL,
    [drvPartLvlMnthSubPKAmt] varchar(3) NULL
);
IF OBJECT_ID('U_EWAGEWREXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EWAGEWREXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EWAGEWREXP_File') IS NULL
CREATE TABLE [dbo].[U_EWAGEWREXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EWAGEWREXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EWAGEWREXP_PDedHist] (
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
IF OBJECT_ID('U_EWAGEWREXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EWAGEWREXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWAGEWREXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Georgetown Day School

Created By: James Bender
Business Analyst: Trena King
Create Date: 02/03/2020
Service Request Number: SR-2019-00246260

Purpose: WageWorks FSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWAGEWREXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWAGEWREXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWAGEWREXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWAGEWREXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWAGEWREXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWAGEWREXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWAGEWREXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWAGEWREXP', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWAGEWREXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EWAGEWREXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWAGEWREXP';

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
    DELETE FROM dbo.U_EWAGEWREXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWAGEWREXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EWAGEWREXP_EEList where xEEID IN (
        select distinct eeceeid from empcomp where eecEEType IN('TES')
    )



    --==========================================
    -- Create audit tables
    --==========================================
    IF OBJECT_ID('U_EWAGEWREXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EWAGEWREXP_AuditFields;
    CREATE TABLE dbo.U_EWAGEWREXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EWAGEWREXP_AuditFields VALUES ('empcomp','eecemplstatus');    
    -- Create audit table
    IF OBJECT_ID('U_EWAGEWREXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EWAGEWREXP_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EWAGEWREXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EWAGEWREXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EWAGEWREXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EWAGEWREXP_Audit ON dbo.U_EWAGEWREXP_Audit (audKey1Value, audKey2Value);











    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSADC,FSA,FSATR';
    --SET @DedList = 'FSADC,FSA,FSATR,HSAC,HSACC,HSACF,HSACI,HSACS,HSAF,HSAI';

    IF OBJECT_ID('U_EWAGEWREXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EWAGEWREXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EWAGEWREXP_DedList
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
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate');

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
    IF OBJECT_ID('U_EWAGEWREXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWAGEWREXP_PDedHist;
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
    INTO dbo.U_EWAGEWREXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EWAGEWREXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EWAGEWREXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWAGEWREXP_PEarHist;
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
    INTO dbo.U_EWAGEWREXP_PEarHist
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
    -- DETAIL RECORD - U_EWAGEWREXP_drvTbl_PRO
    ---------------------------------
    IF OBJECT_ID('U_EWAGEWREXP_drvTbl_PRO','U') IS NOT NULL
        DROP TABLE dbo.U_EWAGEWREXP_drvTbl_PRO;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' --EecJobCode -- ISNULL(BdmDedCode, 'nope') + ' -- ' + ISNULL(EecJobCode, 'nope')
        -- standard fields above and additional driver fields below
        ,drvEmpId = EecEmpNo
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvDateOfBirth = EepDateOfBirth
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = LEFT(EepAddressZipCode, 5)
        ,drvEmailAddress = EepAddressEMail
        ,drvHireDate = EecDateOfLastHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvLocCode = EecLocation
        ,drvCompanyCode = eecJobCode -- CmpCompanyCode
        ,drvCommuterBenGrp =    CASE WHEN EecJobCode IN ('ASP','ACADSPT', 'ADMINAST', 'ADMINSPT', 'ADMSPEC', 'ASP25', 'ASP30', 'ASP35', 'ASP50', 'ASP60', 'ASP70', 'ASPCL', 'ASSOC', 'ASSTPRIN', 'AUXLEAD', 'AUXSPEC', 'AUXSTAFF', 'AUXTRAIN', 'AUXWW', 'CAMP1', 'CAMP2', 'CAMP3', 'CAMPBRK', 'CHLDCARE', 'COACHACD', 'COACHATH', 'COUNS', 'DEAN', 'DEPTHEAD', 'DIR', 'GRDCOORD', 'HLTHSTF', 'INTERN', 'LTSUB', 'MGR', 'PLAYVST', 'PLNTLEAD', 'PLNTSTF', 'PROCTOR', 'SECLEAD', 'SECSTF', 'SNRADMIN', 'STFFCARE', 'SUBADMIN', 'SUBTCHR', 'TEACHER', 'TRNSLEAD', 'TRNSSTF', 'WWPKK') THEN 'Y'
                                    --('COUNS', 'DEAN', 'DEPTHEAD', 'DIR', 'GRDCOORD', 'HLTHSTF', 'MGR', 'PLNTLEAD', 'PLNTSTF', 'SECLEAD', 'SECSTF', 'SNRADMIN', 'ETEACHER', 'TRNSLEAD', 'TRNSSTF', 'ACADSPT', 'ADMINAST', 'ADMINSPT', 'ADMSPEC', 'ASSTPRIN') THEN 'Y'
                                    ELSE 'N'
                                END
        ,drvPartLvlMthSubPTVPAmt =    CASE WHEN BdmDedCode = 'FSATR' THEN
                                        CASE WHEN EecJobCode IN ('DEAN', 'DEPTHEAD', 'DIR', 'MGR', 'PLNTLEAD', 'TEACHER', 'ASSTPRIN') THEN '260' 
                                        ELSE '130'
                                        END
                                    END
        ,drvPartLvlMnthSubPKAmt =    CASE WHEN BdmDedCode = 'FSATR' THEN
                                        CASE WHEN EecJobCode IN ('DEAN', 'DEPTHEAD', 'DIR', 'MGR', 'PLNTLEAD', 'TEACHER', 'ASSTPRIN') THEN '260' 
                                        ELSE '130'
                                        END
                                    END
    INTO dbo.U_EWAGEWREXP_drvTbl_PRO
    FROM dbo.U_EWAGEWREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EWAGEWREXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    --JOIN dbo.JobCode WITH (NOLOCK)
    --    ON EecJobCode = jbcJobCode
    WHERE --eecJobCode IN ('COUNS', 'DEAN', 'DEPTHEAD', 'DIR', 'GRDCOORD', 'HLTHSTF', 'MGR', 'PLNTLEAD', 'PLNTSTF', 'SECLEAD', 'SECSTF', 'SNRADMIN', 'ETEACHER', 'TRNSLEAD', 'TRNSSTF', 'ACADSPT', 'ADMINAST', 'ADMINSPT', 'ADMSPEC', 'ASSTPRIN')
    --AND 
        (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EWAGEWREXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate)) 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWAGEWREXP_drvTbl_EPRO
    ---------------------------------
    IF OBJECT_ID('U_EWAGEWREXP_drvTbl_EPRO','U') IS NOT NULL
        DROP TABLE dbo.U_EWAGEWREXP_drvTbl_EPRO;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' --EecJobCode
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvPartLvlMaxCommSub = CASE WHEN BdmDedCode = 'FSATR' THEN
                                        CASE WHEN EecJobCode IN ('DEAN', 'DEPTHEAD', 'DIR', 'MGR', 'PLNTLEAD', 'TEACHER', 'ASSTPRIN') THEN '260' 
                                        ELSE '130'
                                        END
                                    END 
                                  /*CASE WHEN BdmDedCode = 'FSATR' THEN
                                    CASE WHEN EecJobCode IN ('DEAN', 'DEPTHEAD', 'DIR', 'MGR', 'PLNTLEAD', 'TEACHER', 'ASSTPRIN') THEN
                                        (SELECT SUM(CAST(drvPartLvlMthSubPTVPAmt AS INT)) FROM dbo.U_EWAGEWREXP_drvTbl_PRO WITH (NOLOCK) WHERE drvPartLvlMthSubPTVPAmt = '260')
                                    ELSE 
                                        (SELECT SUM(CAST(drvPartLvlMthSubPTVPAmt AS INT)) FROM dbo.U_EWAGEWREXP_drvTbl_PRO WITH (NOLOCK) WHERE drvPartLvlMthSubPTVPAmt <> '260')
                                    END
                                END*/
    INTO dbo.U_EWAGEWREXP_drvTbl_EPRO
    FROM dbo.U_EWAGEWREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EWAGEWREXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    WHERE --eecJobCode IN ('COUNS', 'DEAN', 'DEPTHEAD', 'DIR', 'GRDCOORD', 'HLTHSTF', 'MGR', 'PLNTLEAD', 'PLNTSTF', 'SECLEAD', 'SECSTF', 'SNRADMIN', 'ETEACHER', 'TRNSLEAD', 'TRNSSTF', 'ACADSPT', 'ADMINAST', 'ADMINSPT', 'ADMSPEC', 'ASSTPRIN')
        --AND 
        (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EWAGEWREXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate)) 
    ;




    INSERT INTO dbo.U_dsi_BDM_EWAGEWREXP
    SELECT 'EMP'
        ,EedCOID
        ,EedEEID
        ,NULL
        ,NULL
        ,''
        ,''
        ,'Emp'
        ,EepDateOfBirth
        ,Eeddedcode
        ,'FSA'
        ,NULL
        ,EedBenStatus
        ,EedBenStartDate
        ,EedBenStopDate
        ,EedBenStatusDate
        ,EedBenOptionDate
        ,EedChangeReason
        ,EedStartDate
        ,EedStopDate
        ,'N'
        ,EedCobraReason
        ,EedDateOfCobraEvent
        ,EedISPQB
        ,NULL
        ,EedUSGField1
        ,EedUSGField2
        ,EedUSGDate1
        ,EedUSGDate2
        ,EedTVSTartDate
        ,''
        ,EedEEAmt
        ,EedEECalcRateOrPct
        ,EedEEGoalAmt
        ,NULL
        ,EedERAmt
        ,EedNumSpouses
        ,EedNumChildren
        ,EedNumDomPartners
        ,EedNumDPChildren
    FROM dbo.u_dsi_bdm_empdeductions WITH (NOLOCK)
    JOIN EmpPers 
        ON EedEEID = EepEEID
    WHERE EedFormatCode = 'EWAGEWREXP' 
        AND EedValidForExport = 'N' 
        AND EedBenStatus = 'T'
        AND EedBenStatusDate BETWEEN @StartDate AND @EndDate

    ---------------------------------
    -- DETAIL RECORD - U_EWAGEWREXP_drvTbl_ENR
    ---------------------------------
    IF OBJECT_ID('U_EWAGEWREXP_drvTbl_ENR','U') IS NOT NULL
        DROP TABLE dbo.U_EWAGEWREXP_drvTbl_ENR;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = BdmDedCode
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvPlanCode =    CASE WHEN BdmDedCode = 'FSA' THEN 'HCFSA2020' 
                            WHEN BdmDedCode = 'FSADC' THEN 'DCFSA2020'
                            --WHEN BdmDedCode = 'FSATR' THEN BdmDedCode
                        END
        ,drvElectionAmt = BdmEEGoalAmt -- BdmEEAmt
        ,drvCoverageStartDate = BdmBenStartDate
        ,drvCoverageEndDate = BdmBenStopDate
        ,drvHsaFsaOption =    CASE WHEN BdmDedCode = 'FSA' 
                                        AND (HSAC_DedCode IS NOT NULL OR HSACC_DedCode IS NOT NULL 
                                        OR HSACF_DedCode IS NOT NULL OR HSACI_DedCode IS NOT NULL 
                                        OR HSACS_DedCode IS NOT NULL OR HSAF_DedCode IS NOT NULL 
                                        OR HSAI_DedCode IS NOT NULL ) AND BdmBenStatus = 'A' THEN 'Y' END
        ,drvHsaFsaOptEffDate =    CASE WHEN BdmDedCode = 'FSA' 
                                        AND (HSAC_DedCode IS NOT NULL OR HSACC_DedCode IS NOT NULL 
                                        OR HSACF_DedCode IS NOT NULL OR HSACI_DedCode IS NOT NULL 
                                        OR HSACS_DedCode IS NOT NULL OR HSAF_DedCode IS NOT NULL 
                                        OR HSAI_DedCode IS NOT NULL ) THEN
                                            CASE WHEN BdmBenStatus = 'A' THEN BdmBenStartDate ELSE BdmBenStatusDate END
                                        END

        --CASE WHEN BdmDedCode = 'FSA' THEN BdmBenStartDate END
    INTO dbo.U_EWAGEWREXP_drvTbl_ENR
    FROM dbo.U_EWAGEWREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EWAGEWREXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (
                SELECT DISTINCT EdhEEID, EdhCOID
                    ,MAX(CASE WHEN EdhDedCode = 'HSAC' THEN EdhDEdCode END) AS HSAC_DedCode
                    ,MAX(CASE WHEN EdhDedCode = 'HSACC' THEN EdhDEdCode END) AS HSACC_DedCode
                    ,MAX(CASE WHEN EdhDedCode = 'HSACF' THEN EdhDEdCode END) AS HSACF_DedCode
                    ,MAX(CASE WHEN EdhDedCode = 'HSACI' THEN EdhDEdCode END) AS HSACI_DedCode
                    ,MAX(CASE WHEN EdhDedCode = 'HSACS' THEN EdhDEdCode END) AS HSACS_DedCode
                    ,MAX(CASE WHEN EdhDedCode = 'HSAF' THEN EdhDEdCode END) AS HSAF_DedCode
                    ,MAX(CASE WHEN EdhDedCode = 'HSAI' THEN EdhDEdCode END) AS HSAI_DedCode
                FROM(SELECT EdhEEID, EdhCOID, EdhDedCode, EdhBenStatus, EdhBenStatusDate, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhBenStatusDate desc) AS RN
                    FROM dbo.EmpHDed WITH (NOLOCK)
                    JOIN dbo.U_EWAGEWREXP_EEList
                        ON EdhEEID = xEEID
                        AND EdhCOID = xCOID 
                    WHERE EdhDedCode IN ('HSAC', 'HSACC', 'HSACF', 'HSACI', 'HSACS', 'HSAF', 'HSAI')
                ) AS T
                WHERE RN = 1
                    AND EdhBenStatus = 'A'
                GROUP BY EdhEEID, EdhCOID) AS HSAF_Codes
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
    WHERE --eecJobCode IN ('COUNS', 'DEAN', 'DEPTHEAD', 'DIR', 'GRDCOORD', 'HLTHSTF', 'MGR', 'PLNTLEAD', 'PLNTSTF', 'SECLEAD', 'SECSTF', 'SNRADMIN', 'ETEACHER', 'TRNSLEAD', 'TRNSSTF', 'ACADSPT', 'ADMINAST', 'ADMINSPT', 'ADMSPEC', 'ASSTPRIN')
            BdmDedCode <> 'FSATR'
        AND 
        (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EWAGEWREXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate)) 
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
ALTER VIEW dbo.dsi_vwEWAGEWREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWAGEWREXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EWAGEWREXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202003301'
       ,expStartPerControl     = '202003301'
       ,expLastEndPerControl   = '202004039'
       ,expEndPerControl       = '202004039'
WHERE expFormatCode = 'EWAGEWREXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEWAGEWREXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EWAGEWREXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort 