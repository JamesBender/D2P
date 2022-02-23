SET NOCOUNT ON;
IF OBJECT_ID('U_ELINABSEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINABSEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELINABSEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELINABSEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELINABSEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELINABSEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELINABSEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINABSEXP];
GO
IF OBJECT_ID('U_ELINABSEXP_PEarHist_PreviousYear') IS NOT NULL DROP TABLE [dbo].[U_ELINABSEXP_PEarHist_PreviousYear];
GO
IF OBJECT_ID('U_ELINABSEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ELINABSEXP_PEarHist];
GO
IF OBJECT_ID('U_ELINABSEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ELINABSEXP_PDedHist];
GO
IF OBJECT_ID('U_ELINABSEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ELINABSEXP_File];
GO
IF OBJECT_ID('U_ELINABSEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELINABSEXP_EEList];
GO
IF OBJECT_ID('U_ELINABSEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELINABSEXP_drvTbl];
GO
IF OBJECT_ID('U_ELINABSEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELINABSEXP_DedList];
GO
IF OBJECT_ID('U_ELINABSEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELINABSEXP_AuditFields];
GO
IF OBJECT_ID('U_ELINABSEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELINABSEXP_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELINABSEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELINABSEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELINABSEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELINABSEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELINABSEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELINABSEXP','Licoln Absence Management','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','S','N','ELINABSEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','1','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','2','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','2',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Key Employee Identifier"','3','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','3',NULL,'Key Employee Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Last Name"','4','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','4',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee First Name"','5','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','5',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Middle Name"','6','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','6',NULL,'Employee Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Suffix "','7','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','7',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salutation"','8','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','8',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Contact Email "','9','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','9',NULL,'Employee Contact Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth  "','10','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','10',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','11','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','11',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','12','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','12',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Married Couple Rule Indicator"','13','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','13',NULL,'Married Couple Rule Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Employee ID"','14','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','14',NULL,'Spouse Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address1 "','15','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','15',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address2 "','16','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','16',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City "','17','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','18','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','18',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Postal Code "','19','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','19',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country "','20','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','20',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','21','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','21',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','22','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','22',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Fax "','23','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','23',NULL,'Fax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work State "','24','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','24',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Location Code"','25','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','25',NULL,'Work Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Code"','26','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','26',NULL,'Job Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Title"','27','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','27',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Status"','28','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','28',NULL,'Job Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Status Date "','29','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','29',NULL,'Job Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Type"','30','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','30',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Full Time"','31','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','31',NULL,'Full Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Exempt "','32','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','32',NULL,'Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date "','33','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','33',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Months of Service"','34','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','34',NULL,'Months of Service',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Adjusted Service Date"','35','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','35',NULL,'Adjusted Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date "','36','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','36',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Start Date "','37','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','37',NULL,'Job Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job End Date "','38','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','38',NULL,'Job End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Shift "','39','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','39',NULL,'Shift',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Per Week"','40','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','40',NULL,'Hours Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Per Day"','41','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','41',NULL,'Hours Per Day',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Days Per Week"','42','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','42',NULL,'Days Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Actual Hours Worked"','43','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','43',NULL,'Actual Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Begin Date"','44','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','44',NULL,'Hours Scheduled Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 1"','45','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','45',NULL,'Hours Scheduled Day 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 2"','46','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','46',NULL,'Hours Scheduled Day 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 3"','47','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','47',NULL,'Hours Scheduled Day 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 4"','48','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','48',NULL,'Hours Scheduled Day 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 5"','49','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','49',NULL,'Hours Scheduled Day 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 6"','50','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','50',NULL,'Hours Scheduled Day 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 7"','51','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','51',NULL,'Hours Scheduled Day 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 8"','52','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','52',NULL,'Hours Scheduled Day 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 9"','53','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','53',NULL,'Hours Scheduled Day 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 10"','54','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','54',NULL,'Hours Scheduled Day 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 11"','55','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','55',NULL,'Hours Scheduled Day 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 12"','56','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','56',NULL,'Hours Scheduled Day 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 13"','57','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','57',NULL,'Hours Scheduled Day 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Scheduled Day 14"','58','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','58',NULL,'Hours Scheduled Day 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Name "','59','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','59',NULL,'Union Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Local"','60','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','60',NULL,'Union Local',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Contact"','61','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','61',NULL,'Union Contact',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Contact Phone"','62','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','62',NULL,'Union Contact Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Base Pay"','63','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','63',NULL,'Base Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Base Pay Period / Salary Code"','64','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','64',NULL,'Base Pay Period / Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Other Pay"','65','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','65',NULL,'Other Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Other Pay Type"','66','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','66',NULL,'Other Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Other Pay Period"','67','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','67',NULL,'Other Pay Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Effective Date "','68','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','68',NULL,'Pay Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Level 1"','69','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','69',NULL,'Reporting Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Level 2"','70','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','70',NULL,'Reporting Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Level 3"','71','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','71',NULL,'Reporting Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Level 4"','72','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','72',NULL,'Reporting Level 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor ID"','73','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','73',NULL,'Supervisor ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact Name"','74','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','74',NULL,'Employer Contact Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact Email"','75','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','75',NULL,'Employer Contact Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact Phone"','76','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','76',NULL,'Employer Contact Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EVR Contact Name"','77','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','77',NULL,'EVR Contact Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EVR Contact Email"','78','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','78',NULL,'EVR Contact Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EVR Contact Phone"','79','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','79',NULL,'EVR Contact Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Group ID"','80','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','80',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Short Term Disability Bill Location"','81','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','81',NULL,'Short Term Disability Bill Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Claim Location"','82','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','82',NULL,'Claim Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Eligibility Indicator"','83','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','83',NULL,'Eligibility Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Statutory Disability Indicator"','84','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','84',NULL,'Statutory Disability Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Eligible 50–75 Indicator"','85','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','85',NULL,'Eligible 50–75 Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Policy Number"','86','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','86',NULL,'WI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Plan Identifier"','87','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','87',NULL,'WI Plan Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Class Identifier"','88','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','88',NULL,'WI Class Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Reports To"','89','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','89',NULL,'Additional Reports To',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Actual Hours Worked in Last 180 Days"','90','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','90',NULL,'Actual Hours Worked in Last 180 Days',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reserved Field 3"','91','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','91',NULL,'Reserved Field 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reserved Field 2 "','92','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','92',NULL,'Reserved Field 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reserved Field 1"','93','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','93',NULL,'Reserved Field 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Def 5"','94','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','94',NULL,'User Def 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Def 6"','95','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','95',NULL,'User Def 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Def 7"','96','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','96',NULL,'User Def 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Def 8"','97','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','97',NULL,'User Def 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Def 9"','98','(''DA''=''T,'')','ELINABSEXPZ0','50','H','01','98',NULL,'User Def 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Def 10"','99','(''DA''=''T'')','ELINABSEXPZ0','50','H','01','99',NULL,'User Def 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','2','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','2',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmployeeIdentifier"','3','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','3',NULL,'Key Employee Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLastName"','4','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','4',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeFirstName"','5','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','5',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMiddleName"','6','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','6',NULL,'Employee Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuffix"','7','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','7',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutation"','8','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','8',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeContactEmail"','9','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','9',NULL,'Employee Contact Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','10','(''UD112''=''T,'')','ELINABSEXPZ0','50','D','10','10',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','11','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','11',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','12','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','12',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMarriedCoupleRuleIndicator"','13','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','13',NULL,'Married Couple Rule Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseEmployeeID"','14','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','14',NULL,'Spouse Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','15','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','15',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','16','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','16',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','17','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','18','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','18',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','19','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','19',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','20','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','20',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','21','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','21',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','22','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','22',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFax"','23','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','23',NULL,'Fax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','24','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','24',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkLocationCode"','25','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','25',NULL,'Work Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobCode"','26','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','26',NULL,'Job Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','27','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','27',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobStatus"','28','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','28',NULL,'Job Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobStatusDate"','29','(''UD112''=''T,'')','ELINABSEXPZ0','50','D','10','29',NULL,'Job Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentType"','30','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','30',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullTime"','31','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','31',NULL,'Full Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExempt"','32','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','32',NULL,'Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','33','(''UD112''=''T,'')','ELINABSEXPZ0','50','D','10','33',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMonthsofService"','34','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','34',NULL,'Months of Service',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjustedServiceDate"','35','(''UD112''=''T,'')','ELINABSEXPZ0','50','D','10','35',NULL,'Adjusted Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','36','(''UD112''=''T,'')','ELINABSEXPZ0','50','D','10','36',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobStartDate"','37','(''UD112''=''T,'')','ELINABSEXPZ0','50','D','10','37',NULL,'Job Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobEndDate"','38','(''UD112''=''T,'')','ELINABSEXPZ0','50','D','10','38',NULL,'Job End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvShift"','39','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','39',NULL,'Shift',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursPerWeek"','40','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','40',NULL,'Hours Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursPerDay"','41','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','41',NULL,'Hours Per Day',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDaysPerWeek"','42','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','42',NULL,'Days Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActualHoursWorked"','43','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','43',NULL,'Actual Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedBeginDate"','44','(''UD112''=''T,'')','ELINABSEXPZ0','50','D','10','44',NULL,'Hours Scheduled Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay1"','45','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','45',NULL,'Hours Scheduled Day 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay2"','46','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','46',NULL,'Hours Scheduled Day 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay3"','47','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','47',NULL,'Hours Scheduled Day 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay4"','48','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','48',NULL,'Hours Scheduled Day 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay5"','49','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','49',NULL,'Hours Scheduled Day 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay6"','50','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','50',NULL,'Hours Scheduled Day 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay7"','51','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','51',NULL,'Hours Scheduled Day 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay8"','52','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','52',NULL,'Hours Scheduled Day 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay9"','53','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','53',NULL,'Hours Scheduled Day 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay10"','54','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','54',NULL,'Hours Scheduled Day 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay11"','55','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','55',NULL,'Hours Scheduled Day 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay12"','56','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','56',NULL,'Hours Scheduled Day 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay13"','57','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','57',NULL,'Hours Scheduled Day 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSchedDay14"','58','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','58',NULL,'Hours Scheduled Day 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionName"','59','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','59',NULL,'Union Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionLocal"','60','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','60',NULL,'Union Local',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionContact"','61','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','61',NULL,'Union Contact',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionContactPhone"','62','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','62',NULL,'Union Contact Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasePay"','63','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','63',NULL,'Base Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasePayPeriodSalaryCode"','64','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','64',NULL,'Base Pay Period / Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOtherPay"','65','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','65',NULL,'Other Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOtherPayType"','66','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','66',NULL,'Other Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOtherPayPeriod"','67','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','67',NULL,'Other Pay Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayEffectiveDate"','68','(''UD112''=''T,'')','ELINABSEXPZ0','50','D','10','68',NULL,'Pay Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportingLevel1"','69','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','69',NULL,'Reporting Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportingLevel2"','70','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','70',NULL,'Reporting Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportingLevel3"','71','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','71',NULL,'Reporting Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportingLevel4"','72','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','72',NULL,'Reporting Level 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorID"','73','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','73',NULL,'Supervisor ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContactName"','74','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','74',NULL,'Employer Contact Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContactEmail"','75','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','75',NULL,'Employer Contact Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContactPhone"','76','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','76',NULL,'Employer Contact Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEVRContactName"','77','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','77',NULL,'EVR Contact Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEVRContactEmail"','78','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','78',NULL,'EVR Contact Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEVRContactPhone"','79','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','79',NULL,'EVR Contact Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupID"','80','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','80',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvShortTermDisBillLocation"','81','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','81',NULL,'Short Term Disability Bill Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClaimLocation"','82','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','82',NULL,'Claim Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibilityIndicator"','83','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','83',NULL,'Eligibility Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatutoryDisIndicator"','84','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','84',NULL,'Statutory Disability Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligible5075Indicator"','85','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','85',NULL,'Eligible 50–75 Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWIPolicyNumber"','86','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','86',NULL,'WI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWIPlanIdentifier"','87','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','87',NULL,'WI Plan Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWIClassIdentifier"','88','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','88',NULL,'WI Class Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalReportsTo"','89','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','89',NULL,'Additional Reports To',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActualHoursWrkLast180D"','90','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','90',NULL,'Actual Hours Worked in Last 180 Days',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReservedField3"','91','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','91',NULL,'Reserved Field 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReservedField2"','92','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','92',NULL,'Reserved Field 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReservedField1"','93','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','93',NULL,'Reserved Field 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserDef5"','94','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','94',NULL,'User Def 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserDef6"','95','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','95',NULL,'User Def 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserDef7"','96','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','96',NULL,'User Def 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserDef8"','97','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','97',NULL,'User Def 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserDef9"','98','(''UA''=''T,'')','ELINABSEXPZ0','50','D','10','98',NULL,'User Def 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserDef10"','99','(''UA''=''T'')','ELINABSEXPZ0','50','D','10','99',NULL,'User Def 10',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINABSEXP_20200723.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Licoln Absence Management','202007239','EMPEXPORT','ONDEMAND',NULL,'ELINABSEXP',NULL,NULL,NULL,'202007239','Jul 23 2020  1:04PM','Jul 23 2020  1:04PM','202007231',NULL,'','','202007231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINABSEXP_20200723.txt',NULL,'','',NULL,NULL,NULL,NULL,'Test Purposes Only','202007239','EMPEXPORT','TEST',NULL,'ELINABSEXP',NULL,NULL,NULL,'202007239','Jul 23 2020  1:04PM','Jul 23 2020  1:04PM','202007231',NULL,'','','202007231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINABSEXP_20200723.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202007239','EMPEXPORT','SCH_LNAB',NULL,'ELINABSEXP',NULL,NULL,NULL,'202007239','Jul 23 2020  1:04PM','Jul 23 2020  1:04PM','202007231',NULL,'','','202007231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINABSEXP_20200723.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202007239','EMPEXPORT','OEACTIVE',NULL,'ELINABSEXP',NULL,NULL,NULL,'202007239','Jul 23 2020  1:04PM','Jul 23 2020  1:04PM','202007231',NULL,'','','202007231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINABSEXP_20200723.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202007239','EMPEXPORT','OEPASSIVE',NULL,'ELINABSEXP',NULL,NULL,NULL,'202007239','Jul 23 2020  1:04PM','Jul 23 2020  1:04PM','202007231',NULL,'','','202007231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ELINABSEXP_20200723.txt' END WHERE expFormatCode = 'ELINABSEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINABSEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINABSEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINABSEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINABSEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINABSEXP','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINABSEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ELINABSEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELINABSEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ELINABSEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINABSEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINABSEXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINABSEXP','D10','dbo.U_ELINABSEXP_drvTbl',NULL);
IF OBJECT_ID('U_ELINABSEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ELINABSEXP_Audit] (
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
IF OBJECT_ID('U_ELINABSEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELINABSEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ELINABSEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ELINABSEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ELINABSEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELINABSEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvKeyEmployeeIdentifier] varchar(1) NOT NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeMiddleName] varchar(50) NULL,
    [drvSuffix] varchar(1) NOT NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvEmployeeContactEmail] varchar(50) NULL,
    [drvDateofBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvMarriedCoupleRuleIndicator] varchar(1) NOT NULL,
    [drvSpouseEmployeeID] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvFax] varchar(1) NOT NULL,
    [drvWorkState] varchar(255) NULL,
    [drvWorkLocationCode] varchar(255) NULL,
    [drvJobCode] char(8) NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvJobStatus] varchar(1) NULL,
    [drvJobStatusDate] datetime NULL,
    [drvEmploymentType] varchar(1) NULL,
    [drvFullTime] varchar(5) NOT NULL,
    [drvExempt] varchar(5) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvMonthsofService] varchar(1) NOT NULL,
    [drvAdjustedServiceDate] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvJobStartDate] varchar(1) NOT NULL,
    [drvJobEndDate] varchar(1) NOT NULL,
    [drvShift] varchar(1) NOT NULL,
    [drvHoursPerWeek] varchar(12) NULL,
    [drvHoursPerDay] varchar(1) NOT NULL,
    [drvDaysPerWeek] varchar(1) NOT NULL,
    [drvActualHoursWorked] varchar(12) NULL,
    [drvHrsSchedBeginDate] varchar(1) NOT NULL,
    [drvHrsSchedDay1] varchar(1) NOT NULL,
    [drvHrsSchedDay2] varchar(1) NOT NULL,
    [drvHrsSchedDay3] varchar(1) NOT NULL,
    [drvHrsSchedDay4] varchar(1) NOT NULL,
    [drvHrsSchedDay5] varchar(1) NOT NULL,
    [drvHrsSchedDay6] varchar(1) NOT NULL,
    [drvHrsSchedDay7] varchar(1) NOT NULL,
    [drvHrsSchedDay8] varchar(1) NOT NULL,
    [drvHrsSchedDay9] varchar(1) NOT NULL,
    [drvHrsSchedDay10] varchar(1) NOT NULL,
    [drvHrsSchedDay11] varchar(1) NOT NULL,
    [drvHrsSchedDay12] varchar(1) NOT NULL,
    [drvHrsSchedDay13] varchar(1) NOT NULL,
    [drvHrsSchedDay14] varchar(1) NOT NULL,
    [drvUnionName] varchar(1) NOT NULL,
    [drvUnionLocal] varchar(1) NOT NULL,
    [drvUnionContact] varchar(1) NOT NULL,
    [drvUnionContactPhone] varchar(1) NOT NULL,
    [drvBasePay] varchar(12) NULL,
    [drvBasePayPeriodSalaryCode] char(1) NULL,
    [drvOtherPay] varchar(1) NOT NULL,
    [drvOtherPayType] varchar(1) NOT NULL,
    [drvOtherPayPeriod] char(1) NULL,
    [drvPayEffectiveDate] datetime NULL,
    [drvReportingLevel1] char(6) NULL,
    [drvReportingLevel2] char(6) NULL,
    [drvReportingLevel3] varchar(1) NOT NULL,
    [drvReportingLevel4] varchar(1) NOT NULL,
    [drvSupervisorID] varchar(6) NOT NULL,
    [drvEmployerContactName] varchar(256) NULL,
    [drvEmployerContactEmail] varchar(256) NULL,
    [drvEmployerContactPhone] varchar(1) NOT NULL,
    [drvEVRContactName] varchar(1) NOT NULL,
    [drvEVRContactEmail] varchar(1) NOT NULL,
    [drvEVRContactPhone] varchar(1) NOT NULL,
    [drvGroupID] varchar(5) NOT NULL,
    [drvShortTermDisBillLocation] varchar(7) NOT NULL,
    [drvClaimLocation] varchar(9) NOT NULL,
    [drvEligibilityIndicator] varchar(1) NOT NULL,
    [drvStatutoryDisIndicator] varchar(255) NULL,
    [drvEligible5075Indicator] varchar(1) NOT NULL,
    [drvWIPolicyNumber] varchar(17) NOT NULL,
    [drvWIPlanIdentifier] varchar(1) NOT NULL,
    [drvWIClassIdentifier] varchar(1) NOT NULL,
    [drvAdditionalReportsTo] varchar(1) NOT NULL,
    [drvActualHoursWrkLast180D] varchar(1) NOT NULL,
    [drvReservedField3] varchar(1) NOT NULL,
    [drvReservedField2] varchar(1) NOT NULL,
    [drvReservedField1] varchar(1) NOT NULL,
    [drvUserDef5] varchar(1) NOT NULL,
    [drvUserDef6] varchar(1) NOT NULL,
    [drvUserDef7] varchar(1) NOT NULL,
    [drvUserDef8] varchar(1) NOT NULL,
    [drvUserDef9] varchar(1) NOT NULL,
    [drvUserDef10] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ELINABSEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ELINABSEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELINABSEXP_File') IS NULL
CREATE TABLE [dbo].[U_ELINABSEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_ELINABSEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ELINABSEXP_PDedHist] (
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
IF OBJECT_ID('U_ELINABSEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ELINABSEXP_PEarHist] (
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
IF OBJECT_ID('U_ELINABSEXP_PEarHist_PreviousYear') IS NULL
CREATE TABLE [dbo].[U_ELINABSEXP_PEarHist_PreviousYear] (
    [PehEEID2] char(12) NOT NULL,
    [PehCurHrs52Weeks] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINABSEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: 2nd MD

Created By: Marco Lagrosa
Business Analyst: Richard Vars
Create Date: 07/23/2020
Service Request Number: TekP-2020-05-27-0007 

Purpose: Licoln Absence Management

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELINABSEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELINABSEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELINABSEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELINABSEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELINABSEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINABSEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINABSEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINABSEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINABSEXP', 'TEST';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELINABSEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELINABSEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@Last52WeekPerControl as VARCHAR(10) ;

    -- Set FormatCode
    SELECT @FormatCode = 'ELINABSEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ELINABSEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELINABSEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LTD';

    IF OBJECT_ID('U_ELINABSEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELINABSEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELINABSEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@EndDate - 30);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

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
    IF OBJECT_ID('U_ELINABSEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELINABSEXP_PDedHist;
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
    INTO dbo.U_ELINABSEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ELINABSEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ELINABSEXP_PEarHist_PreviousYear','U') IS NOT NULL
        DROP TABLE dbo.U_ELINABSEXP_PEarHist_PreviousYear;
    SELECT DISTINCT
         PehEEID as PehEEID2
        -- Current Payroll Amount/Hours
        ,PehCurHrs52Weeks              = SUM(CASE WHEN PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @StartPerControl  THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
      
    INTO dbo.U_ELINABSEXP_PEarHist_PreviousYear
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE  PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    IF OBJECT_ID('U_ELINABSEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELINABSEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @StartPerControl  THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ELINABSEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE  PehPerControl <= @EndPerControl
    AND LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    ----
    --Audit Table
    IF OBJECT_ID('U_ELINABSEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELINABSEXP_AuditFields;
    CREATE TABLE dbo.U_ELINABSEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ELINABSEXP_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ELINABSEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELINABSEXP_Audit;
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
    INTO dbo.U_ELINABSEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ELINABSEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ELINABSEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate -30 AND @EndDate;
    
        -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ELINABSEXP_Audit ON dbo.U_ELINABSEXP_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELINABSEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELINABSEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELINABSEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmployeeNumber = EecEmpNo
        ,drvKeyEmployeeIdentifier = ''
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeMiddleName = EepNameMiddle
        ,drvSuffix = ''
        ,drvSalutation = ''
        ,drvEmployeeContactEmail = EepAddressEMail
        ,drvDateofBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = ''
        ,drvMarriedCoupleRuleIndicator = ''
        ,drvSpouseEmployeeID = ''
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountry = ''
        ,drvHomePhone = (Select top 1 efoPhoneNumber  from dbo.EmpMPhon where efoPhoneType  = 'CEL' and efoeeid = xEEID)
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvFax = ''
        ,drvWorkState = EepAddressState
        ,drvWorkLocationCode = (Select top 1 LocAddressState  from dbo.Location where LocCode = EecLocation)
        ,drvJobCode = EecJobCode
        ,drvJobTitle = JbcDesc 
        ,drvJobStatus = CASE WHEN EecEmplStatus = 'A' THEn 'A'
                             WHEN EecEmplStatus = 'S' THEn 'I'
                             WHEN EecEmplStatus = 'L' THEn 'L'
                             WHEN EecEmplStatus = 'T' THEn 'T'
                        END
        ,drvJobStatusDate = EecEmplStatusStartDate
        ,drvEmploymentType = CASE WHEN EecEEType  = 'CON' THEN 'C'
                                  WHEN EecEEType  = 'INT' THEN 'I'
                                  WHEN EecEEType  = 'REG' THEN 'R'
                                  WHEN EecEEType  = 'SUN' THEN 'S'
                                  WHEN EecEEType  = 'TES' THEN 'T'
                        END
        ,drvFullTime = CASE WHEN EecFullTimeOrPartTime  = 'F' THEN 'TRUE' ELSE 'FALSE' END
        ,drvExempt = CASE WHEN EecSalaryOrHourly = 'S' THEN 'True' ELSE 'False' END
        ,drvHireDate = EecDateOfLastHire
        ,drvMonthsofService = ''
        ,drvAdjustedServiceDate = ''
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvJobStartDate = ''
        ,drvJobEndDate = ''
        ,drvShift = ''
        ,drvHoursPerWeek = CAST(CONVERT(DECIMAL(10,0),eecScheduledWorkHrs) as varchar(12))
        ,drvHoursPerDay = ''
        ,drvDaysPerWeek = ''
        ,drvActualHoursWorked = CAST(CONVERT(DECIMAL(10,0),PehCurHrs52Weeks) as varchar(12))
        ,drvHrsSchedBeginDate = ''
        ,drvHrsSchedDay1 = ''
        ,drvHrsSchedDay2 = ''
        ,drvHrsSchedDay3 = ''
        ,drvHrsSchedDay4 = ''
        ,drvHrsSchedDay5 = ''
        ,drvHrsSchedDay6 = ''
        ,drvHrsSchedDay7 = ''
        ,drvHrsSchedDay8 = ''
        ,drvHrsSchedDay9 = ''
        ,drvHrsSchedDay10 = ''
        ,drvHrsSchedDay11 = ''
        ,drvHrsSchedDay12 = ''
        ,drvHrsSchedDay13 = ''
        ,drvHrsSchedDay14 = ''
        ,drvUnionName = ''
        ,drvUnionLocal = ''
        ,drvUnionContact = ''
        ,drvUnionContactPhone = ''
        ,drvBasePay = CASE WHEN EecSalaryOrHourly = 'H' THEN CAST( eecHourlyPayRate  as varchar(12)) ELSE CAST(eecAnnSalary as varchar(12)) END 
        ,drvBasePayPeriodSalaryCode = EecPayPeriod
        ,drvOtherPay = ''
        ,drvOtherPayType = ''
        ,drvOtherPayPeriod = EecPayPeriod
        ,drvPayEffectiveDate =  dbo.dsi_fnGetMinMaxDates('MAX',PrgPayDate, PayDate) 
        ,drvReportingLevel1 = EecOrgLvl1
        ,drvReportingLevel2 = EecOrgLvl2
        ,drvReportingLevel3 = ''
        ,drvReportingLevel4 = ''
        ,drvSupervisorID = '200159'
        ,drvEmployerContactName = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast, First M')    --EecSupervisorID
        ,drvEmployerContactEmail = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'AddressEMail') --EecSupervisorID
        ,drvEmployerContactPhone = ''
        ,drvEVRContactName = ''
        ,drvEVRContactEmail = ''
        ,drvEVRContactPhone = ''
        ,drvGroupID = '2mdmd'
        ,drvShortTermDisBillLocation = '3838214'
        ,drvClaimLocation = '987456321'
        ,drvEligibilityIndicator = CASE WHEN eecFullTimeOrPartTime = 'F' THEN 'Y' ELSE 'N' END
        ,drvStatutoryDisIndicator = CASE WHEN eepIsDisabled  = 'Y' and EepAddressState in ('HI','NJ','NY') THEN EepAddressState ELSE 'NO' END
        ,drvEligible5075Indicator = ''
        ,drvWIPolicyNumber = '00001025746100000'
        ,drvWIPlanIdentifier = '1'
        ,drvWIClassIdentifier = CASE WHEN EecFullTimeOrPartTime  = 'F' THEN '1' ELSE '' END
        ,drvAdditionalReportsTo = ''
        ,drvActualHoursWrkLast180D = ''
        ,drvReservedField3 = ''
        ,drvReservedField2 = ''
        ,drvReservedField1 = ''
        ,drvUserDef5 = ''
        ,drvUserDef6 = ''
        ,drvUserDef7 = ''
        ,drvUserDef8 = ''
        ,drvUserDef9 = ''
        ,drvUserDef10 = ''
    INTO dbo.U_ELINABSEXP_drvTbl
    FROM dbo.U_ELINABSEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
         and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_ELINABSEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_ELINABSEXP_PEarHist_PreviousYear WITH (NOLOCK)
        On PehEEID2 =  xEEID
    JOIN dbo.U_ELINABSEXP_PEarHist WITH (NOLOCK)
        On PehEEID =  xEEID
    LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as Paygroups
    ON eecPaygroup = PgpPayGroup
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
ALTER VIEW dbo.dsi_vwELINABSEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELINABSEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELINABSEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007161'
       ,expStartPerControl     = '202007161'
       ,expLastEndPerControl   = '202007239'
       ,expEndPerControl       = '202007239'
WHERE expFormatCode = 'ELINABSEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELINABSEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELINABSEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort