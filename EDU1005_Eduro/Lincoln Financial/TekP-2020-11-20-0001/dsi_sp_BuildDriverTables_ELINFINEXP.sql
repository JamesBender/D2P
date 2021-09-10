SET NOCOUNT ON;
IF OBJECT_ID('U_ELINFINEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELINFINEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELINFINEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELINFINEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELINFINEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELINFINEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINFINEXP];
GO
IF OBJECT_ID('U_ELINFINEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_PEarHist];
GO
IF OBJECT_ID('U_ELINFINEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_PDedHist];
GO
IF OBJECT_ID('U_ELINFINEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_File];
GO
IF OBJECT_ID('U_ELINFINEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_EEList];
GO
IF OBJECT_ID('U_ELINFINEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_drvTbl];
GO
IF OBJECT_ID('U_ELINFINEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ELINFINEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELINFINEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELINFINEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELINFINEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELINFINEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELINFINEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELINFINEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELINFINEXP','Lincoln Financial Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','20000','S','N','ELINFINEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELINFINEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','1','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','1',NULL,'Employee ID?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Change Date"','2','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','2',NULL,'Change Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Change Date"','3','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','3',NULL,'Dep Change Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','4','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','4',NULL,'Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr First Name"','5','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','5',NULL,'Mbr First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Last Name"','6','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','6',NULL,'Mbr Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Middle Initial"','7','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','7',NULL,'Mbr Middle Initial?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr SSN"','8','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','8',NULL,'Mbr SSN?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Gender"','9','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','9',NULL,'Mbr Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr DOB"','10','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','10',NULL,'Mbr DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"App Sign Date"','11','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','11',NULL,'App Sign Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation"','12','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','12',NULL,'Occupation?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs Per Week"','13','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','13',NULL,'Hrs Per Week?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Amt"','14','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','14',NULL,'Salary Amt?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Code"','15','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','15',NULL,'Salary Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sal Eff Date"','16','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','16',NULL,'Sal Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Addr 1"','17','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','17',NULL,'Mbr Addr 1?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Addr 2"','18','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','18',NULL,'Mbr Addr 2?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr City"','19','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','19',NULL,'Mbr City?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr State"','20','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','20',NULL,'Mbr State?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Zip Code"','21','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','21',NULL,'Mbr Zip Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Zip Plus 4"','22','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','22',NULL,'Mbr Zip Plus 4?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','23','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','23',NULL,'Home Phone?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','24','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','24',NULL,'Work Phone?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Ext"','25','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','25',NULL,'Work Phone Ext?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','26','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','26',NULL,'Email Address?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Benefits Eligibility"','27','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','27',NULL,'Date of Benefits Eligibility?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Subsequent Date of Benefits Eligibility"','28','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','28',NULL,'Subsequent Date of Benefits?Eligibility?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reason for Prior Loss of Benefits Eligibility"','29','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','29',NULL,'Reason for Prior Loss of Benefits?Eligibility?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene First Name"','30','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','30',NULL,'Pri Bene First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Last Name"','31','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','31',NULL,'Pri Bene Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Middle Init"','32','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','32',NULL,'Pri Bene Middle Init?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Relationship"','33','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','33',NULL,'Pri Bene Relationship?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Address 1"','34','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','34',NULL,'Pri Bene Address 1?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Address 2"','35','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','35',NULL,'Pri Bene Address 2?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene City"','36','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','36',NULL,'Pri Bene City?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene State"','37','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','37',NULL,'Pri Bene State?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Zip Code"','38','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','38',NULL,'Pri Bene Zip Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Zip Plus 4"','39','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','39',NULL,'Pri Bene Zip Plus 4?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene SSN"','40','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','40',NULL,'Pri Bene SSN?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene First Name"','41','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','41',NULL,'Co Bene First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Last Name"','42','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','42',NULL,'Co Bene Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Middle Init"','43','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','43',NULL,'Co Bene Middle Init?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Relationship"','44','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','44',NULL,'Co Bene Relationship?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Address 1"','45','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','45',NULL,'Co Bene Address 1?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Address 2"','46','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','46',NULL,'Co Bene Address 2?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene City"','47','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','47',NULL,'Co Bene City?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene State"','48','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','48',NULL,'Co Bene State?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Zip Code"','49','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','49',NULL,'Co Bene Zip Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Zip Plus 4"','50','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','50',NULL,'Co Bene Zip Plus 4?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene SSN"','51','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','51',NULL,'Co Bene SSN?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Beneficiary Comments"','52','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','52',NULL,'Beneficiary Comments?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Policy Number"','53','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','53',NULL,'Accident Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Bill Location A/C Number"','54','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','54',NULL,'Accident Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Sort Group"','55','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','55',NULL,'Accident Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Eff Date"','56','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','56',NULL,'Accident Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Plan Code"','57','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','57',NULL,'Accident Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Class Code"','58','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','58',NULL,'Accident Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Tier Code"','59','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','59',NULL,'Accident Tier Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health Asses Tier"','60','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','60',NULL,'Health Asses Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Tier"','61','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','61',NULL,'Hospital Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Disability Amount"','62','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','62',NULL,'Accident Disability Amount?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Tier"','63','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','63',NULL,'Accident DI Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Benefit Period"','64','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','64',NULL,'Accident DI Benefit Period?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Elim Period"','65','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','65',NULL,'Accident DI Elim Period?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Sickness Disability Amount"','66','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','66',NULL,'Accident Sickness Disability?Amount?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident/sick Tier"','67','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','67',NULL,'Accident/sick Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident/sick DI Benefit Period"','68','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','68',NULL,'Accident/sick DI Benefit Period?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident/sick DI Elim Period"','69','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','69',NULL,'Accident/sick DI Elim Period?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Termination Date"','70','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','70',NULL,'Accident Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Policy Number"','71','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','71',NULL,'Critical Illness Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Bill Location A/C Number"','72','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','72',NULL,'Critical Illness Bill Location A/C?Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Sort Group"','73','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','73',NULL,'Critical Illness Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Eff Date"','74','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','74',NULL,'Critical Illness Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Plan Code"','75','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','75',NULL,'Critical Illness Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Class Code"','76','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','76',NULL,'Critical Illness Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Termination Date"','77','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','77',NULL,'Critical Illness Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Principal Sum Amt Approved"','78','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','78',NULL,'EE Principal Sum Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Principal Sum Amt Pending"','79','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','79',NULL,'EE Principal Sum Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Principal Sum Amt Approved"','80','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','80',NULL,'SP Principal Sum Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Principal Sum Amt Pending"','81','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','81',NULL,'SP Principal Sum Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Principal Sum Amt Approved"','82','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','82',NULL,'CH Principal Sum Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Principal Sum Amt Pending"','83','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','83',NULL,'CH Principal Sum Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Heart Amt Approved"','84','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','84',NULL,'EE Heart Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Heart Amt Pending"','85','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','85',NULL,'EE Heart Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Heart Amt Approved"','86','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','86',NULL,'SP Heart Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Heart Amt Pending"','87','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','87',NULL,'SP Heart Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Heart Amt Approved"','88','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','88',NULL,'CH Heart Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Heart Amt Pending"','89','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','89',NULL,'CH Heart Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Cancer Amt Approved"','90','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','90',NULL,'EE Cancer Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Cancer Amt Pending"','91','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','91',NULL,'EE Cancer Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Cancer Amt Approved"','92','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','92',NULL,'SP Cancer Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Cancer Amt Pending"','93','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','93',NULL,'SP Cancer Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Cancer Amt Approved"','94','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','94',NULL,'CH Cancer Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Cancer Amt Pending"','95','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','95',NULL,'CH Cancer Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Organ Amt Approved"','96','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','96',NULL,'EE Organ Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Organ Amt Pending"','97','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','97',NULL,'EE Organ Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Organ Amt Approved"','98','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','98',NULL,'SP Organ Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Organ Amt Pending"','99','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','99',NULL,'SP Organ Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Organ Amt Approved"','100','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','100',NULL,'CH Organ Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Organ Amt Pending"','101','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','101',NULL,'CH Organ Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Quality of Life Amt Approved"','102','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','102',NULL,'EE Quality of Life Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Quality of Life Amt Pending"','103','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','103',NULL,'EE Quality of Life Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Quality of Life Amt Approved"','104','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','104',NULL,'SP Quality of Life Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Quality of Life Amt Pending"','105','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','105',NULL,'SP Quality of Life Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Quality of Life Amt Approved"','106','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','106',NULL,'CH Quality of Life Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Quality of Life Amt Pending"','107','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','107',NULL,'CH Quality of Life Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Category Amt Approved"','108','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','108',NULL,'Child Category Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Category Amt Pending"','109','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','109',NULL,'Child Category Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Treatment Care Y/N"','110','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','110',NULL,'EE Treatment Care Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Treatment Care Y/N"','111','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','111',NULL,'SP Treatment Care Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Treatment Care Y/N"','112','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','112',NULL,'CH Treatment Care Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE DI Y/N"','113','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','113',NULL,'EE DI Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP DI Y/N"','114','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','114',NULL,'SP DI Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Accident Y/N"','115','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','115',NULL,'EE Accident Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Accident Y/N"','116','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','116',NULL,'SP Accident Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Accident Y/N"','117','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','117',NULL,'CH Accident Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Occ/HIV Y/N"','118','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','118',NULL,'EE Occ/HIV Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Policy Number"','119','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','119',NULL,'Life Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Bill Location A/C Number"','120','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','120',NULL,'Life Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Sort Group"','121','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','121',NULL,'Life Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Eff Date"','122','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','122',NULL,'Life Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan Code"','123','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','123',NULL,'Life Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Class Code"','124','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','124',NULL,'Life Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LI Cvgs"','125','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','125',NULL,'LI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LI Termination Date"','126','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','126',NULL,'LI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AD Cvgs"','127','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','127',NULL,'AD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AD Termination Date"','128','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','128',NULL,'AD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DLI Cvgs"','129','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','129',NULL,'DLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DLI Termination Date"','130','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','130',NULL,'DLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DAD Cvgs"','131','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','131',NULL,'DAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DAD Termination Date"','132','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','132',NULL,'DAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLI Cvgs"','133','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','133',NULL,'OLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLI Termination Date"','134','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','134',NULL,'OLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OAD Cvgs"','135','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','135',NULL,'OAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OAD Termination Date"','136','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','136',NULL,'OAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODLI Cvgs"','137','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','137',NULL,'ODLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODLI Termination Date"','138','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','138',NULL,'ODLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODAD Cvgs"','139','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','139',NULL,'ODAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODAD Termination Date"','140','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','140',NULL,'ODAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SLI Cvgs"','141','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','141',NULL,'SLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SLI Termination Date"','142','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','142',NULL,'SLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAD Cvgs"','143','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','143',NULL,'SAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAD Termination Date"','144','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','144',NULL,'SAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLI Cvgs"','145','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','145',NULL,'CLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLI Termination Date"','146','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','146',NULL,'CLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSLI Cvgs"','147','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','147',NULL,'OSLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSLI Termination Date"','148','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','148',NULL,'OSLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSAD Cvgs"','149','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','149',NULL,'OSAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSAD Termination Date"','150','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','150',NULL,'OSAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OCLI Cvgs"','151','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','151',NULL,'OCLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OCLI Termination Date"','152','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','152',NULL,'OCLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Policy Number"','153','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','153',NULL,'WI Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Bill Location A/C Number"','154','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','154',NULL,'WI Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Sort Group"','155','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','155',NULL,'WI Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Eff Date"','156','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','156',NULL,'WI Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Plan Code"','157','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','157',NULL,'WI Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Class Code"','158','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','158',NULL,'WI Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Cvgs"','159','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','159',NULL,'WI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Termination Date"','160','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','160',NULL,'WI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OWI Cvgs"','161','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','161',NULL,'OWI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OWI Termination Date"','162','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','162',NULL,'OWI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Policy Number"','163','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','163',NULL,'LTD Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Bill Location A/C Number"','164','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','164',NULL,'LTD Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Sort Group"','165','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','165',NULL,'LTD Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Eff Date"','166','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','166',NULL,'LTD Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Plan Code"','167','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','167',NULL,'LTD Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Class Code"','168','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','168',NULL,'LTD Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Cvgs"','169','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','169',NULL,'LTD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Termination Date"','170','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','170',NULL,'LTD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLTD Cvgs"','171','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','171',NULL,'OLTD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLTD Termination Date"','172','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','172',NULL,'OLTD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Cvgs"','173','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','173',NULL,'CI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Date"','174','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','174',NULL,'CI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Policy Number"','175','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','175',NULL,'Dent Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Bill Location A/C Number"','176','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','176',NULL,'Dent Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Sort Group"','177','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','177',NULL,'Dent Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Eff Date"','178','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','178',NULL,'Dent Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Plan Code"','179','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','179',NULL,'Dent Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Class Code"','180','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','180',NULL,'Dent Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Coverage Tier"','181','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','181',NULL,'Dent Coverage Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Other Ins"','182','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','182',NULL,'Dent Other Ins?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Termination Date"','183','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','183',NULL,'Dent Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Policy Number"','184','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','184',NULL,'DHMO Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Bill Location A/C Number"','185','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','185',NULL,'DHMO Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Sort Group"','186','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','186',NULL,'DHMO Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Eff Date"','187','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','187',NULL,'DHMO Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Plan Code"','188','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','188',NULL,'DHMO Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Class Code"','189','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','189',NULL,'DHMO Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Coverage Tier"','190','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','190',NULL,'DHMO Coverage Tier??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO PCP"','191','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','191',NULL,'DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Termination Date"','192','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','192',NULL,'DHMO Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Policy Number"','193','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','193',NULL,'LVC Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Bill Location A/C Number"','194','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','194',NULL,'LVC Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Sort Group"','195','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','195',NULL,'LVC Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Eff Date"','196','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','196',NULL,'LVC Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Plan Code"','197','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','197',NULL,'LVC Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Class Code"','198','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','198',NULL,'LVC Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Coverage Tier"','199','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','199',NULL,'LVC Coverage Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Other Ins"','200','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','200',NULL,'LVC Other Ins?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Termination Date"','201','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','201',NULL,'LVC Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Policy Number"','202','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','202',NULL,'VLVC Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Bill Location A/C Number"','203','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','203',NULL,'VLVC Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Sort Group"','204','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','204',NULL,'VLVC Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Eff Date"','205','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','205',NULL,'VLVC Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Plan Code"','206','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','206',NULL,'VLVC Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Class Code"','207','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','207',NULL,'VLVC Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Coverage Tier"','208','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','208',NULL,'VLVC Coverage Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Other Ins"','209','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','209',NULL,'VLVC Other Ins?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Termination Date"','210','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','210',NULL,'VLVC Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Policy Number"','211','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','211',NULL,'VDN Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Bill Location A/C Number"','212','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','212',NULL,'VDN Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Sort Group"','213','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','213',NULL,'VDN Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Eff Date"','214','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','214',NULL,'VDN Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Plan Code"','215','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','215',NULL,'VDN Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Class Code"','216','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','216',NULL,'VDN Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Coverage Tier"','217','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','217',NULL,'VDN Coverage Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Other Ins"','218','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','218',NULL,'VDN Other Ins?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Termination Date"','219','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','219',NULL,'VDN Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Policy Number"','220','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','220',NULL,'VDHMO Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Bill Location A/C Number"','221','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','221',NULL,'VDHMO Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Sort Group"','222','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','222',NULL,'VDHMO Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Eff Date"','223','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','223',NULL,'VDHMO Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Plan Code"','224','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','224',NULL,'VDHMO Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Class Code"','225','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','225',NULL,'VDHMO Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Coverage Tier"','226','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','226',NULL,'VDHMO Coverage Tier??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO PCP"','227','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','227',NULL,'VDHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Termination Date"','228','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','228',NULL,'VDHMO Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Policy Number"','229','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','229',NULL,'VLIF Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Bill Location A/C Number"','230','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','230',NULL,'VLIF Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Sort Group"','231','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','231',NULL,'VLIF Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Eff Date"','232','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','232',NULL,'VLIF Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Plan Code"','233','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','233',NULL,'VLIF Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Class Code"','234','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','234',NULL,'VLIF Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLI Cvgs"','235','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','235',NULL,'VLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLI Termination Date"','236','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','236',NULL,'VLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VAD Cvgs"','237','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','237',NULL,'VAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VAD Termination Date"','238','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','238',NULL,'VAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLI Cvgs"','239','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','239',NULL,'VSLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLI Termination Date"','240','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','240',NULL,'VSLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSAD Cvgs"','241','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','241',NULL,'VSAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSAD Termination Date"','242','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','242',NULL,'VSAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLI Cvgs"','243','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','243',NULL,'VCLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLI Termination Date"','244','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','244',NULL,'VCLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Policy Number"','245','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','245',NULL,'VWI Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Bill Location A/C Number"','246','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','246',NULL,'VWI Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Sort Group"','247','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','247',NULL,'VWI Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Eff Date"','248','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','248',NULL,'VWI Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Plan Code"','249','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','249',NULL,'VWI Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Class Code"','250','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','250',NULL,'VWI Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Benefit Amt"','251','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','251',NULL,'VWI Benefit Amt?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Elim Period"','252','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','252',NULL,'VWI Elim Period?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Benefit Duration"','253','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','253',NULL,'VWI Benefit Duration?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Termination Date"','254','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','254',NULL,'VWI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Policy Number"','255','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','255',NULL,'VLTD Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Bill Location A/C Number"','256','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','256',NULL,'VLTD Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Sort Group"','257','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','257',NULL,'VLTD Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Eff Date"','258','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','258',NULL,'VLTD Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Plan Code"','259','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','259',NULL,'VLTD Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Class Code"','260','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','260',NULL,'VLTD Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Amt"','261','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','261',NULL,'VLTD Benefit Amt?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Elim Period"','262','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','262',NULL,'VLTD Elim Period?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Duration"','263','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','263',NULL,'VLTD Benefit Duration?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Pct"','264','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','264',NULL,'VLTD Benefit Pct?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Termination Date"','265','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','265',NULL,'VLTD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Policy Number"','266','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','266',NULL,'STAD Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Bill Location A/C Number"','267','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','267',NULL,'STAD Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Sort Group"','268','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','268',NULL,'STAD Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Eff Date"','269','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','269',NULL,'STAD Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Plan Code"','270','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','270',NULL,'STAD Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Class Code"','271','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','271',NULL,'STAD Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVAD Cvgs"','272','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','272',NULL,'STVAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVAD Termination Date"','273','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','273',NULL,'STVAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVSAD Cvgs"','274','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','274',NULL,'STVSAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVSAD Termination Date"','275','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','275',NULL,'STVSAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVCAD Cvgs"','276','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','276',NULL,'STVCAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVCAD Termination Date"','277','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','277',NULL,'STVCAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualifying Event Code"','278','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','278',NULL,'Qualifying Event Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualifying Event Eff Date"','279','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','279',NULL,'Qualifying Event Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Smoker"','280','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','280',NULL,'Mbr Smoker?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Smoker"','281','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','281',NULL,'Spouse Smoker??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse DOB"','282','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','282',NULL,'Spouse DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name"','283','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','283',NULL,'Dep First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name"','284','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','284',NULL,'Dep Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I"','285','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','285',NULL,'Dep M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender"','286','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','286',NULL,'Dep Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB"','287','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','287',NULL,'Dep DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code"','288','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','288',NULL,'Dep Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code"','289','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','289',NULL,'Dep Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled Y/N"','290','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','290',NULL,'Dep Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator"','291','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','291',NULL,'Dep Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP"','292','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','292',NULL,'Dep DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 First Name"','293','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','293',NULL,'Dep 2 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 Last Name"','294','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','294',NULL,'Dep 2 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 M I"','295','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','295',NULL,'Dep 2 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 Gender"','296','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','296',NULL,'Dep 2 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 DOB"','297','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','297',NULL,'Dep 2 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 Relationship Code"','298','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','298',NULL,'Dep 2 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 Student Code"','299','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','299',NULL,'Dep 2 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 Disabled Y/N"','300','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','300',NULL,'Dep 2 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 Cvg Indicator"','301','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','301',NULL,'Dep 2 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 DHMO PCP"','302','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','302',NULL,'Dep 2 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 First Name"','303','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','303',NULL,'Dep 3 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 Last Name"','304','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','304',NULL,'Dep 3 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 M I"','305','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','305',NULL,'Dep 3 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 Gender"','306','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','306',NULL,'Dep 3 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 DOB"','307','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','307',NULL,'Dep 3 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 Relationship Code"','308','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','308',NULL,'Dep 3 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 Student Code"','309','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','309',NULL,'Dep 3 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 Disabled Y/N"','310','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','310',NULL,'Dep 3 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 Cvg Indicator"','311','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','311',NULL,'Dep 3 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 DHMO PCP"','312','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','312',NULL,'Dep 3 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 First Name"','313','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','313',NULL,'Dep 4 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 Last Name"','314','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','314',NULL,'Dep 4 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 M I"','315','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','315',NULL,'Dep 4 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 Gender"','316','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','316',NULL,'Dep 4 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 DOB"','317','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','317',NULL,'Dep 4 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 Relationship Code"','318','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','318',NULL,'Dep 4 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 Student Code"','319','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','319',NULL,'Dep 4 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 Disabled Y/N"','320','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','320',NULL,'Dep 4 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 Cvg Indicator"','321','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','321',NULL,'Dep 4 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 DHMO PCP"','322','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','322',NULL,'Dep 4 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 First Name"','323','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','323',NULL,'Dep 5 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 Last Name"','324','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','324',NULL,'Dep 5 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 M I"','325','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','325',NULL,'Dep 5 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 Gender"','326','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','326',NULL,'Dep 5 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 DOB"','327','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','327',NULL,'Dep 5 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 Relationship Code"','328','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','328',NULL,'Dep 5 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 Student Code"','329','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','329',NULL,'Dep 5 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 Disabled Y/N"','330','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','330',NULL,'Dep 5 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 Cvg Indicator"','331','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','331',NULL,'Dep 5 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 DHMO PCP"','332','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','332',NULL,'Dep 5 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 First Name"','333','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','333',NULL,'Dep 6 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 Last Name"','334','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','334',NULL,'Dep 6 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 M I"','335','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','335',NULL,'Dep 6 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 Gender"','336','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','336',NULL,'Dep 6 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 DOB"','337','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','337',NULL,'Dep 6 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 Relationship Code"','338','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','338',NULL,'Dep 6 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 Student Code"','339','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','339',NULL,'Dep 6 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 Disabled Y/N"','340','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','340',NULL,'Dep 6 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 Cvg Indicator"','341','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','341',NULL,'Dep 6 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 DHMO PCP"','342','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','342',NULL,'Dep 6 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 7 First Name"','343','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','343',NULL,'Dep 7 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 7 Last Name"','344','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','344',NULL,'Dep 7 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 7 M I"','345','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','345',NULL,'Dep 7 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 7 Gender"','346','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','346',NULL,'Dep 7 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 7 DOB"','347','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','347',NULL,'Dep 7 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 7 Relationship Code"','348','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','348',NULL,'Dep 7 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 7 Student Code"','349','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','349',NULL,'Dep 7 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 7 Disabled Y/N"','350','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','350',NULL,'Dep 7 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 7 Cvg Indicator"','351','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','351',NULL,'Dep 7 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 7 DHMO PCP"','352','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','352',NULL,'Dep 7 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 8 First Name"','353','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','353',NULL,'Dep 8 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 8 Last Name"','354','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','354',NULL,'Dep 8 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 8 M I"','355','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','355',NULL,'Dep 8 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 8 Gender"','356','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','356',NULL,'Dep 8 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 8 DOB"','357','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','357',NULL,'Dep 8 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 8 Relationship Code"','358','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','358',NULL,'Dep 8 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 8 Student Code"','359','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','359',NULL,'Dep 8 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 8 Disabled Y/N"','360','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','360',NULL,'Dep 8 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 8 Cvg Indicator"','361','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','361',NULL,'Dep 8 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 8 DHMO PCP"','362','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','362',NULL,'Dep 8 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 9 First Name"','363','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','363',NULL,'Dep 9 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 9 Last Name"','364','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','364',NULL,'Dep 9 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 9 M I"','365','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','365',NULL,'Dep 9 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 9 Gender"','366','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','366',NULL,'Dep 9 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 9 DOB"','367','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','367',NULL,'Dep 9 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 9 Relationship Code"','368','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','368',NULL,'Dep 9 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 9 Student Code"','369','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','369',NULL,'Dep 9 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 9 Disabled Y/N"','370','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','370',NULL,'Dep 9 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 9 Cvg Indicator"','371','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','371',NULL,'Dep 9 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 9 DHMO PCP"','372','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','372',NULL,'Dep 9 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 10 First Name"','373','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','373',NULL,'Dep 10 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 10 Last Name"','374','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','374',NULL,'Dep 10 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 10 M I"','375','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','375',NULL,'Dep 10 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 10 Gender"','376','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','376',NULL,'Dep 10 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 10 DOB"','377','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','377',NULL,'Dep 10 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 10 Relationship Code"','378','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','378',NULL,'Dep 10 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 10 Student Code"','379','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','379',NULL,'Dep 10 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 10 Disabled Y/N"','380','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','380',NULL,'Dep 10 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 10 Cvg Indicator"','381','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','381',NULL,'Dep 10 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 10 DHMO PCP"','382','(''DA''=''T'')','ELINFINEXPZ0','50','H','01','382',NULL,'Dep 10 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','1','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','1',NULL,'Employee ID?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChangeDate"','2','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','2',NULL,'Change Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','3',NULL,'Dep Change Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','4','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','4',NULL,'Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','5',NULL,'Mbr First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','6',NULL,'Mbr Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','7',NULL,'Mbr Middle Initial?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','8',NULL,'Mbr SSN?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','9',NULL,'Mbr Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','10','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','10',NULL,'Mbr DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAppSignDate"','11','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','11',NULL,'App Sign Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupation"','12','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','12',NULL,'Occupation?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"40"','13','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','13',NULL,'Hrs Per Week?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt"','14','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','14',NULL,'Salary Amt?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryCode"','15','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','15',NULL,'Salary Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalEffDate"','16','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','16',NULL,'Sal Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','17','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','17',NULL,'Mbr Addr 1?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','18','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','18',NULL,'Mbr Addr 2?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','19','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','19',NULL,'Mbr City?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','20','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','20',NULL,'Mbr State?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','21','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','21',NULL,'Mbr Zip Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','22',NULL,'Mbr Zip Plus 4?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','23','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','23',NULL,'Home Phone?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','24',NULL,'Work Phone?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','25',NULL,'Work Phone Ext?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','26',NULL,'Email Address?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBenefitElig"','27','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','27',NULL,'Date of Benefits Eligibility?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubsDateOfBenElig"','28','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','28',NULL,'Subsequent Date of Benefits?Eligibility?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','29',NULL,'Reason for Prior Loss of Benefits?Eligibility?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','30',NULL,'Pri Bene First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','31',NULL,'Pri Bene Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','32',NULL,'Pri Bene Middle Init?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','33',NULL,'Pri Bene Relationship?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','34',NULL,'Pri Bene Address 1?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','35',NULL,'Pri Bene Address 2?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','36',NULL,'Pri Bene City?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','37',NULL,'Pri Bene State?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','38',NULL,'Pri Bene Zip Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','39',NULL,'Pri Bene Zip Plus 4?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','40',NULL,'Pri Bene SSN?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','41',NULL,'Co Bene First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','42',NULL,'Co Bene Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','43',NULL,'Co Bene Middle Init?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','44',NULL,'Co Bene Relationship?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','45',NULL,'Co Bene Address 1?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','46',NULL,'Co Bene Address 2?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','47',NULL,'Co Bene City?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','48',NULL,'Co Bene State?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','49',NULL,'Co Bene Zip Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','50',NULL,'Co Bene Zip Plus 4?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','51',NULL,'Co Bene SSN?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','52',NULL,'Beneficiary Comments?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','53',NULL,'Accident Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','54',NULL,'Accident Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','55',NULL,'Accident Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','56',NULL,'Accident Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','57',NULL,'Accident Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','58',NULL,'Accident Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','59',NULL,'Accident Tier Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','60',NULL,'Health Asses Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','61',NULL,'Hospital Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','62',NULL,'Accident Disability Amount?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','63',NULL,'Accident DI Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','64',NULL,'Accident DI Benefit Period?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','65',NULL,'Accident DI Elim Period?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','66',NULL,'Accident Sickness Disability?Amount?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','67',NULL,'Accident/sick Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','68',NULL,'Accident/sick DI Benefit Period?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','69',NULL,'Accident/sick DI Elim Period?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','70',NULL,'Accident Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','71',NULL,'Critical Illness Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','72',NULL,'Critical Illness Bill Location A/C?Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','73',NULL,'Critical Illness Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','74',NULL,'Critical Illness Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','75',NULL,'Critical Illness Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','76',NULL,'Critical Illness Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','77',NULL,'Critical Illness Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','78',NULL,'EE Principal Sum Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','79',NULL,'EE Principal Sum Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','80',NULL,'SP Principal Sum Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','81',NULL,'SP Principal Sum Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','82',NULL,'CH Principal Sum Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','83',NULL,'CH Principal Sum Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','84',NULL,'EE Heart Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','85',NULL,'EE Heart Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','86',NULL,'SP Heart Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','87',NULL,'SP Heart Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','88',NULL,'CH Heart Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','89',NULL,'CH Heart Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','90',NULL,'EE Cancer Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','91',NULL,'EE Cancer Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','92',NULL,'SP Cancer Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','93',NULL,'SP Cancer Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','94',NULL,'CH Cancer Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','95',NULL,'CH Cancer Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','96',NULL,'EE Organ Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','97',NULL,'EE Organ Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','98','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','98',NULL,'SP Organ Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','99','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','99',NULL,'SP Organ Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','100',NULL,'CH Organ Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','101',NULL,'CH Organ Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','102',NULL,'EE Quality of Life Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','103',NULL,'EE Quality of Life Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','104',NULL,'SP Quality of Life Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','105',NULL,'SP Quality of Life Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','106','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','106',NULL,'CH Quality of Life Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','107','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','107',NULL,'CH Quality of Life Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','108',NULL,'Child Category Amt Approved?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','109',NULL,'Child Category Amt Pending?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','110',NULL,'EE Treatment Care Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','111',NULL,'SP Treatment Care Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','112','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','112',NULL,'CH Treatment Care Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','113','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','113',NULL,'EE DI Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','114',NULL,'SP DI Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','115','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','115',NULL,'EE Accident Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','116','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','116',NULL,'SP Accident Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','117','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','117',NULL,'CH Accident Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','118','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','118',NULL,'EE Occ/HIV Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePolicyNumber"','119','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','119',NULL,'Life Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeBillLocACNum"','120','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','120',NULL,'Life Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeSortGroup"','121','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','121',NULL,'Life Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeEffDate"','122','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','122',NULL,'Life Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlanCode"','123','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','123',NULL,'Life Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeClassCode"','124','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','124',NULL,'Life Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLiCvgs"','125','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','125',NULL,'LI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLiTerminationDate"','126','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','126',NULL,'LI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdCvgs"','127','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','127',NULL,'AD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdTerminationDate"','128','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','128',NULL,'AD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','129','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','129',NULL,'DLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','130','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','130',NULL,'DLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','131',NULL,'DAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','132','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','132',NULL,'DAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','133',NULL,'OLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','134','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','134',NULL,'OLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','135','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','135',NULL,'OAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','136',NULL,'OAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','137','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','137',NULL,'ODLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','138',NULL,'ODLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','139',NULL,'ODAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','140',NULL,'ODAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','141',NULL,'SLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','142',NULL,'SLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','143','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','143',NULL,'SAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','144','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','144',NULL,'SAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','145','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','145',NULL,'CLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','146','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','146',NULL,'CLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','147','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','147',NULL,'OSLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','148',NULL,'OSLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','149','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','149',NULL,'OSAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','150','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','150',NULL,'OSAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','151',NULL,'OCLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','152','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','152',NULL,'OCLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiPolicyNumber"','153','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','153',NULL,'WI Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiBillLocACNum"','154','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','154',NULL,'WI Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiSortGroup"','155','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','155',NULL,'WI Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiEffDate"','156','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','156',NULL,'WI Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiPlanCode"','157','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','157',NULL,'WI Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiClassCode"','158','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','158',NULL,'WI Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"divWiCvgs"','159','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','159',NULL,'WI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiTerminationDate"','160','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','160',NULL,'WI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOwiCvgs"','161','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','161',NULL,'OWI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOwiTerminationDate"','162','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','162',NULL,'OWI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdPolicyNumber"','163','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','163',NULL,'LTD Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdBillLocACNum"','164','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','164',NULL,'LTD Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdSortGoup"','165','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','165',NULL,'LTD Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdEffDate"','166','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','166',NULL,'LTD Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdPlanCode"','167','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','167',NULL,'LTD Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdClassCode"','168','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','168',NULL,'LTD Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdCvgs"','169','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','169',NULL,'LTD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdTerminationDate"','170','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','170',NULL,'LTD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','171','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','171',NULL,'OLTD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','172','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','172',NULL,'OLTD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','173','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','173',NULL,'CI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','174','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','174',NULL,'CI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','175','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','175',NULL,'Dent Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','176','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','176',NULL,'Dent Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','177','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','177',NULL,'Dent Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','178','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','178',NULL,'Dent Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','179','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','179',NULL,'Dent Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','180','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','180',NULL,'Dent Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','181','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','181',NULL,'Dent Coverage Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','182','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','182',NULL,'Dent Other Ins?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','183','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','183',NULL,'Dent Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','184','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','184',NULL,'DHMO Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','185','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','185',NULL,'DHMO Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','186','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','186',NULL,'DHMO Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','187','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','187',NULL,'DHMO Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','188','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','188',NULL,'DHMO Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','189','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','189',NULL,'DHMO Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','190','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','190',NULL,'DHMO Coverage Tier??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','191','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','191',NULL,'DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','192','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','192',NULL,'DHMO Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','193','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','193',NULL,'LVC Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','194','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','194',NULL,'LVC Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','195','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','195',NULL,'LVC Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','196','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','196',NULL,'LVC Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','197','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','197',NULL,'LVC Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','198','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','198',NULL,'LVC Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','199','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','199',NULL,'LVC Coverage Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','200','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','200',NULL,'LVC Other Ins?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','201','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','201',NULL,'LVC Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','202','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','202',NULL,'VLVC Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','203','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','203',NULL,'VLVC Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','204','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','204',NULL,'VLVC Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','205','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','205',NULL,'VLVC Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','206','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','206',NULL,'VLVC Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','207','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','207',NULL,'VLVC Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','208','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','208',NULL,'VLVC Coverage Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','209','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','209',NULL,'VLVC Other Ins?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','210','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','210',NULL,'VLVC Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','211','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','211',NULL,'VDN Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','212','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','212',NULL,'VDN Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','213','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','213',NULL,'VDN Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','214','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','214',NULL,'VDN Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','215','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','215',NULL,'VDN Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','216','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','216',NULL,'VDN Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','217','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','217',NULL,'VDN Coverage Tier?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','218','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','218',NULL,'VDN Other Ins?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','219','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','219',NULL,'VDN Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','220','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','220',NULL,'VDHMO Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','221','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','221',NULL,'VDHMO Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','222','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','222',NULL,'VDHMO Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','223','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','223',NULL,'VDHMO Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','224','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','224',NULL,'VDHMO Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','225','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','225',NULL,'VDHMO Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','226','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','226',NULL,'VDHMO Coverage Tier??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','227','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','227',NULL,'VDHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','228','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','228',NULL,'VDHMO Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFPolicyNumber"','229','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','229',NULL,'VLIF Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFBillLocACNum"','230','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','230',NULL,'VLIF Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFSortGroup"','231','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','231',NULL,'VLIF Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFEffDate"','232','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','232',NULL,'VLIF Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFPlanCode"','233','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','233',NULL,'VLIF Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFClassCode"','234','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','234',NULL,'VLIF Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLICvgs"','235','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','235',NULL,'VLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLITerminationDate"','236','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','236',NULL,'VLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVADCvgs"','237','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','237',NULL,'VAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVADTerminationDate"','238','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','238',NULL,'VAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSLICvgs"','239','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','239',NULL,'VSLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSLITerminationDate"','240','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','240',NULL,'VSLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSADCvgs"','241','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','241',NULL,'VSAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSADTerminationDate"','242','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','242',NULL,'VSAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVCLICvgs"','243','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','243',NULL,'VCLI Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVCLITerminationDate"','244','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','244',NULL,'VCLI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','245','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','245',NULL,'VWI Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','246','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','246',NULL,'VWI Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','247','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','247',NULL,'VWI Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','248','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','248',NULL,'VWI Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','249','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','249',NULL,'VWI Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','250','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','250',NULL,'VWI Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','251','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','251',NULL,'VWI Benefit Amt?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','252','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','252',NULL,'VWI Elim Period?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','253','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','253',NULL,'VWI Benefit Duration?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','254','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','254',NULL,'VWI Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','255','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','255',NULL,'VLTD Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','256','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','256',NULL,'VLTD Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','257','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','257',NULL,'VLTD Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','258','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','258',NULL,'VLTD Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','259','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','259',NULL,'VLTD Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','260','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','260',NULL,'VLTD Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','261','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','261',NULL,'VLTD Benefit Amt?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','262','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','262',NULL,'VLTD Elim Period?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','263','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','263',NULL,'VLTD Benefit Duration?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','264','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','264',NULL,'VLTD Benefit Pct?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','265','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','265',NULL,'VLTD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','266','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','266',NULL,'STAD Policy Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','267','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','267',NULL,'STAD Bill Location A/C Number?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','268','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','268',NULL,'STAD Sort Group?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','269','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','269',NULL,'STAD Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','270','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','270',NULL,'STAD Plan Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','271','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','271',NULL,'STAD Class Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','272','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','272',NULL,'STVAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','273','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','273',NULL,'STVAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','274','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','274',NULL,'STVSAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','275','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','275',NULL,'STVSAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','276','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','276',NULL,'STVCAD Cvgs?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','277','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','277',NULL,'STVCAD Termination Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','278','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','278',NULL,'Qualifying Event Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','279','(''DA''=''T,'')','ELINFINEXPZ0','50','D','10','279',NULL,'Qualifying Event Eff Date?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrSmoker"','280','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','280',NULL,'Mbr Smoker?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSmoker"','281','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','281',NULL,'Spouse Smoker??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDOB"','282','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','282',NULL,'Spouse DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName"','283','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','283',NULL,'Dep First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName"','284','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','284',NULL,'Dep Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI"','285','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','285',NULL,'Dep M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"devDepGender"','286','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','286',NULL,'Dep Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB"','287','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','287',NULL,'Dep DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode"','288','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','288',NULL,'Dep Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode"','289','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','289',NULL,'Dep Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabled"','290','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','290',NULL,'Dep Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator"','291','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','291',NULL,'Dep Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDhmoPcp"','292','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','292',NULL,'Dep DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName2"','293','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','293',NULL,'Dep 2 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName2"','294','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','294',NULL,'Dep 2 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI2"','295','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','295',NULL,'Dep 2 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"devDepGender2"','296','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','296',NULL,'Dep 2 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB2"','297','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','297',NULL,'Dep 2 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode2"','298','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','298',NULL,'Dep 2 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode2"','299','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','299',NULL,'Dep 2 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabled2"','300','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','300',NULL,'Dep 2 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator2"','301','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','301',NULL,'Dep 2 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDhmoPcp2"','302','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','302',NULL,'Dep 2 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName3"','303','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','303',NULL,'Dep 3 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName3"','304','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','304',NULL,'Dep 3 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI3"','305','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','305',NULL,'Dep 3 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"devDepGender3"','306','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','306',NULL,'Dep 3 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB3"','307','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','307',NULL,'Dep 3 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode3"','308','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','308',NULL,'Dep 3 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode3"','309','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','309',NULL,'Dep 3 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabled3"','310','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','310',NULL,'Dep 3 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator3"','311','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','311',NULL,'Dep 3 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDhmoPcp3"','312','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','312',NULL,'Dep 3 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName4"','313','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','313',NULL,'Dep 4 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName4"','314','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','314',NULL,'Dep 4 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI4"','315','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','315',NULL,'Dep 4 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"devDepGender4"','316','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','316',NULL,'Dep 4 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB4"','317','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','317',NULL,'Dep 4 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode4"','318','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','318',NULL,'Dep 4 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode4"','319','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','319',NULL,'Dep 4 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabled4"','320','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','320',NULL,'Dep 4 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator4"','321','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','321',NULL,'Dep 4 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDhmoPcp4"','322','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','322',NULL,'Dep 4 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName5"','323','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','323',NULL,'Dep 5 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName5"','324','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','324',NULL,'Dep 5 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI5"','325','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','325',NULL,'Dep 5 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"devDepGender5"','326','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','326',NULL,'Dep 5 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB5"','327','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','327',NULL,'Dep 5 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode5"','328','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','328',NULL,'Dep 5 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode5"','329','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','329',NULL,'Dep 5 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabled5"','330','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','330',NULL,'Dep 5 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator5"','331','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','331',NULL,'Dep 5 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDhmoPcp5"','332','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','332',NULL,'Dep 5 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName6"','333','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','333',NULL,'Dep 6 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName6"','334','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','334',NULL,'Dep 6 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI6"','335','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','335',NULL,'Dep 6 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"devDepGender6"','336','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','336',NULL,'Dep 6 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB6"','337','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','337',NULL,'Dep 6 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode6"','338','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','338',NULL,'Dep 6 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode6"','339','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','339',NULL,'Dep 6 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabled6"','340','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','340',NULL,'Dep 6 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator6"','341','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','341',NULL,'Dep 6 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDhmoPcp6"','342','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','342',NULL,'Dep 6 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName7"','343','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','343',NULL,'Dep 7 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName7"','344','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','344',NULL,'Dep 7 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI7"','345','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','345',NULL,'Dep 7 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"devDepGender7"','346','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','346',NULL,'Dep 7 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB7"','347','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','347',NULL,'Dep 7 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode7"','348','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','348',NULL,'Dep 7 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode7"','349','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','349',NULL,'Dep 7 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabled7"','350','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','350',NULL,'Dep 7 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator7"','351','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','351',NULL,'Dep 7 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDhmoPcp7"','352','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','352',NULL,'Dep 7 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName8"','353','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','353',NULL,'Dep 8 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName8"','354','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','354',NULL,'Dep 8 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI8"','355','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','355',NULL,'Dep 8 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"devDepGender8"','356','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','356',NULL,'Dep 8 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB8"','357','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','357',NULL,'Dep 8 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode8"','358','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','358',NULL,'Dep 8 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode8"','359','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','359',NULL,'Dep 8 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabled8"','360','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','360',NULL,'Dep 8 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator8"','361','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','361',NULL,'Dep 8 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDhmoPcp8"','362','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','362',NULL,'Dep 8 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName9"','363','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','363',NULL,'Dep 9 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName9"','364','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','364',NULL,'Dep 9 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI9"','365','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','365',NULL,'Dep 9 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"devDepGender9"','366','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','366',NULL,'Dep 9 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB9"','367','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','367',NULL,'Dep 9 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode9"','368','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','368',NULL,'Dep 9 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode9"','369','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','369',NULL,'Dep 9 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabled9"','370','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','370',NULL,'Dep 9 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator9"','371','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','371',NULL,'Dep 9 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDhmoPcp9"','372','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','372',NULL,'Dep 9 DHMO PCP??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName10"','373','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','373',NULL,'Dep 10 First Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName10"','374','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','374',NULL,'Dep 10 Last Name?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI10"','375','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','375',NULL,'Dep 10 M I??',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"devDepGender10"','376','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','376',NULL,'Dep 10 Gender?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB10"','377','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','377',NULL,'Dep 10 DOB?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode10"','378','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','378',NULL,'Dep 10 Relationship Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode10"','379','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','379',NULL,'Dep 10 Student Code?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabled10"','380','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','380',NULL,'Dep 10 Disabled Y/N?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator10"','381','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','381',NULL,'Dep 10 Cvg Indicator?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDhmoPcp10"','382','(''UA''=''T'')','ELINFINEXPZ0','50','D','10','382',NULL,'Dep 10 DHMO PCP??',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ELINFINEXP_20210902.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202107069','EMPEXPORT','OEACTIVE','Jul  8 2021  5:14AM','ELINFINEXP',NULL,NULL,NULL,'202107069','Jul  6 2021 12:17PM','Jul  6 2021 12:17PM','202107061','8','','','202107061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202107069','EMPEXPORT','OEPASSIVE','Jul  8 2021  5:14AM','ELINFINEXP',NULL,NULL,NULL,'202107069','Jul  6 2021 12:17PM','Jul  6 2021 12:17PM','202107061','1552','','','202107061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Lincoln Financial Export','202107069','EMPEXPORT','ONDEM_XOE','Jul  8 2021  5:14AM','ELINFINEXP',NULL,NULL,NULL,'202107069','Jul  6 2021 12:17PM','Jul  6 2021 12:17PM','202107061','1558','','','202107061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Lincoln Financial Export-Sched','202107069','EMPEXPORT','SCH_ELINFI','Jul  8 2021  5:15AM','ELINFINEXP',NULL,NULL,NULL,'202107069','Jul  6 2021 12:17PM','Jul  6 2021 12:17PM','202107061','1558','','','202107061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Lincoln Financial Export-Test','202108251','EMPEXPORT','TEST_XOE','Aug 25 2021  3:55PM','ELINFINEXP',NULL,NULL,NULL,'202108251','Aug 25 2021 12:00AM','Aug 15 2021 12:00AM','202108181','1573','','','202108181',dbo.fn_GetTimedKey(),NULL,'us3cPeEDU1005',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINFINEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINFINEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINFINEXP','SubSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINFINEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINFINEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ELINFINEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ELINFINEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ELINFINEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINFINEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINFINEXP','D10','dbo.U_ELINFINEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ELINFINEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELINFINEXP] (
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
IF OBJECT_ID('U_ELINFINEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ELINFINEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ELINFINEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELINFINEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvChangeDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(102) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvSSN] varchar(11) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAppSignDate] datetime NULL,
    [drvOccupation] varchar(25) NOT NULL,
    [drvSalaryAmt] nvarchar(4000) NULL,
    [drvSalaryCode] varchar(1) NULL,
    [drvSalEffDate] datetime NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(5) NULL,
    [drvHomePhone] varchar(12) NULL,
    [drvDateOfBenefitElig] datetime NULL,
    [drvSubsDateOfBenElig] datetime NULL,
    [drvLifePolicyNumber] varchar(18) NULL,
    [drvLifeBillLocACNum] varchar(7) NULL,
    [drvLifeSortGroup] varchar(40) NULL,
    [drvLifeEffDate] datetime NULL,
    [drvLifePlanCode] varchar(1) NULL,
    [drvLifeClassCode] varchar(1) NULL,
    [drvLiCvgs] varchar(5) NULL,
    [drvLiTerminationDate] datetime NULL,
    [drvAdCvgs] varchar(5) NULL,
    [drvAdTerminationDate] datetime NULL,
    [drvWiPolicyNumber] varchar(18) NULL,
    [drvWiBillLocACNum] varchar(7) NULL,
    [drvWiSortGroup] varchar(40) NULL,
    [drvWiEffDate] datetime NULL,
    [drvWiPlanCode] varchar(1) NULL,
    [drvWiClassCode] varchar(1) NULL,
    [divWiCvgs] varchar(5) NULL,
    [drvWiTerminationDate] datetime NULL,
    [drvOwiCvgs] varchar(1) NOT NULL,
    [drvOwiTerminationDate] varchar(1) NOT NULL,
    [drvLtdPolicyNumber] varchar(18) NULL,
    [drvLtdBillLocACNum] varchar(7) NULL,
    [drvLtdSortGoup] varchar(40) NULL,
    [drvLtdEffDate] datetime NULL,
    [drvLtdPlanCode] varchar(1) NULL,
    [drvLtdClassCode] varchar(1) NULL,
    [drvLtdCvgs] varchar(5) NULL,
    [drvLtdTerminationDate] datetime NULL,
    [drvVLIFPolicyNumber] varchar(18) NULL,
    [drvVLIFBillLocACNum] varchar(8) NULL,
    [drvVLIFSortGroup] varchar(40) NULL,
    [drvVLIFEffDate] datetime NULL,
    [drvVLIFPlanCode] varchar(1) NULL,
    [drvVLIFClassCode] varchar(1) NULL,
    [drvVLICvgs] nvarchar(4000) NULL,
    [drvVLITerminationDate] datetime NULL,
    [drvVADCvgs] nvarchar(4000) NULL,
    [drvVADTerminationDate] datetime NULL,
    [drvVSLICvgs] nvarchar(4000) NULL,
    [drvVSLITerminationDate] datetime NULL,
    [drvVSADCvgs] nvarchar(4000) NULL,
    [drvVSADTerminationDate] datetime NULL,
    [drvVCLICvgs] varchar(10) NULL,
    [drvVCLITerminationDate] datetime NULL,
    [drvMbrSmoker] varchar(1) NOT NULL,
    [drvSpouseSmoker] varchar(1) NOT NULL,
    [drvSpouseDOB] datetime NULL,
    [drvDepFirstName] varchar(1) NOT NULL,
    [drvDepLastName] varchar(1) NOT NULL,
    [drvDepMI] varchar(1) NOT NULL,
    [devDepGender] varchar(1) NOT NULL,
    [drvDepDOB] varchar(1) NOT NULL,
    [drvDepRelationshipCode] varchar(1) NOT NULL,
    [drvDepStudentCode] varchar(1) NOT NULL,
    [drvDisabled] varchar(1) NOT NULL,
    [drvDepCvgIndicator] varchar(1) NOT NULL,
    [drvDepDhmoPcp] varchar(1) NOT NULL,
    [drvDepFirstName2] varchar(1) NOT NULL,
    [drvDepLastName2] varchar(1) NOT NULL,
    [drvDepMI2] varchar(1) NOT NULL,
    [devDepGender2] varchar(1) NOT NULL,
    [drvDepDOB2] varchar(1) NOT NULL,
    [drvDepRelationshipCode2] varchar(1) NOT NULL,
    [drvDepStudentCode2] varchar(1) NOT NULL,
    [drvDisabled2] varchar(1) NOT NULL,
    [drvDepCvgIndicator2] varchar(1) NOT NULL,
    [drvDepDhmoPcp2] varchar(1) NOT NULL,
    [drvDepFirstName3] varchar(1) NOT NULL,
    [drvDepLastName3] varchar(1) NOT NULL,
    [drvDepMI3] varchar(1) NOT NULL,
    [devDepGender3] varchar(1) NOT NULL,
    [drvDepDOB3] varchar(1) NOT NULL,
    [drvDepRelationshipCode3] varchar(1) NOT NULL,
    [drvDepStudentCode3] varchar(1) NOT NULL,
    [drvDisabled3] varchar(1) NOT NULL,
    [drvDepCvgIndicator3] varchar(1) NOT NULL,
    [drvDepDhmoPcp3] varchar(1) NOT NULL,
    [drvDepFirstName4] varchar(1) NOT NULL,
    [drvDepLastName4] varchar(1) NOT NULL,
    [drvDepMI4] varchar(1) NOT NULL,
    [devDepGender4] varchar(1) NOT NULL,
    [drvDepDOB4] varchar(1) NOT NULL,
    [drvDepRelationshipCode4] varchar(1) NOT NULL,
    [drvDepStudentCode4] varchar(1) NOT NULL,
    [drvDisabled4] varchar(1) NOT NULL,
    [drvDepCvgIndicator4] varchar(1) NOT NULL,
    [drvDepDhmoPcp4] varchar(1) NOT NULL,
    [drvDepFirstName5] varchar(1) NOT NULL,
    [drvDepLastName5] varchar(1) NOT NULL,
    [drvDepMI5] varchar(1) NOT NULL,
    [devDepGender5] varchar(1) NOT NULL,
    [drvDepDOB5] varchar(1) NOT NULL,
    [drvDepRelationshipCode5] varchar(1) NOT NULL,
    [drvDepStudentCode5] varchar(1) NOT NULL,
    [drvDisabled5] varchar(1) NOT NULL,
    [drvDepCvgIndicator5] varchar(1) NOT NULL,
    [drvDepDhmoPcp5] varchar(1) NOT NULL,
    [drvDepFirstName6] varchar(1) NOT NULL,
    [drvDepLastName6] varchar(1) NOT NULL,
    [drvDepMI6] varchar(1) NOT NULL,
    [devDepGender6] varchar(1) NOT NULL,
    [drvDepDOB6] varchar(1) NOT NULL,
    [drvDepRelationshipCode6] varchar(1) NOT NULL,
    [drvDepStudentCode6] varchar(1) NOT NULL,
    [drvDisabled6] varchar(1) NOT NULL,
    [drvDepCvgIndicator6] varchar(1) NOT NULL,
    [drvDepDhmoPcp6] varchar(1) NOT NULL,
    [drvDepFirstName7] varchar(1) NOT NULL,
    [drvDepLastName7] varchar(1) NOT NULL,
    [drvDepMI7] varchar(1) NOT NULL,
    [devDepGender7] varchar(1) NOT NULL,
    [drvDepDOB7] varchar(1) NOT NULL,
    [drvDepRelationshipCode7] varchar(1) NOT NULL,
    [drvDepStudentCode7] varchar(1) NOT NULL,
    [drvDisabled7] varchar(1) NOT NULL,
    [drvDepCvgIndicator7] varchar(1) NOT NULL,
    [drvDepDhmoPcp7] varchar(1) NOT NULL,
    [drvDepFirstName8] varchar(1) NOT NULL,
    [drvDepLastName8] varchar(1) NOT NULL,
    [drvDepMI8] varchar(1) NOT NULL,
    [devDepGender8] varchar(1) NOT NULL,
    [drvDepDOB8] varchar(1) NOT NULL,
    [drvDepRelationshipCode8] varchar(1) NOT NULL,
    [drvDepStudentCode8] varchar(1) NOT NULL,
    [drvDisabled8] varchar(1) NOT NULL,
    [drvDepCvgIndicator8] varchar(1) NOT NULL,
    [drvDepDhmoPcp8] varchar(1) NOT NULL,
    [drvDepFirstName9] varchar(1) NOT NULL,
    [drvDepLastName9] varchar(1) NOT NULL,
    [drvDepMI9] varchar(1) NOT NULL,
    [devDepGender9] varchar(1) NOT NULL,
    [drvDepDOB9] varchar(1) NOT NULL,
    [drvDepRelationshipCode9] varchar(1) NOT NULL,
    [drvDepStudentCode9] varchar(1) NOT NULL,
    [drvDisabled9] varchar(1) NOT NULL,
    [drvDepCvgIndicator9] varchar(1) NOT NULL,
    [drvDepDhmoPcp9] varchar(1) NOT NULL,
    [drvDepFirstName10] varchar(1) NOT NULL,
    [drvDepLastName10] varchar(1) NOT NULL,
    [drvDepMI10] varchar(1) NOT NULL,
    [devDepGender10] varchar(1) NOT NULL,
    [drvDepDOB10] varchar(1) NOT NULL,
    [drvDepRelationshipCode10] varchar(1) NOT NULL,
    [drvDepStudentCode10] varchar(1) NOT NULL,
    [drvDisabled10] varchar(1) NOT NULL,
    [drvDepCvgIndicator10] varchar(1) NOT NULL,
    [drvDepDhmoPcp10] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ELINFINEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ELINFINEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELINFINEXP_File') IS NULL
CREATE TABLE [dbo].[U_ELINFINEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_ELINFINEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ELINFINEXP_PDedHist] (
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
IF OBJECT_ID('U_ELINFINEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ELINFINEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINFINEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Eduro

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 07/06/2021
Service Request Number: TekP-2020-11-20-0001

Purpose: Lincoln Financial Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELINFINEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELINFINEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELINFINEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELINFINEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELINFINEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINFINEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINFINEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINFINEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINFINEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINFINEXP', 'SCH_ELINFI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELINFINEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELINFINEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELINFINEXP';

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
    DELETE FROM dbo.U_ELINFINEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELINFINEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ELINFINEXP_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES'
    )

    DELETE FROM dbo.U_ELINFINEXP_EEList WHERE xEEID IN (
        SELECT DISTINCT EepEEID FROM dbo.EmpPers WITH (NOLOCK) WHERE EepSSN = '999999997'
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GLIFE,STD,LTD,LIFEE,LIFES,LIFEC';

    IF OBJECT_ID('U_ELINFINEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELINFINEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELINFINEXP_DedList
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
    IF OBJECT_ID('U_ELINFINEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELINFINEXP_PDedHist;
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
    INTO dbo.U_ELINFINEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ELINFINEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ELINFINEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELINFINEXP_PEarHist;
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
    INTO dbo.U_ELINFINEXP_PEarHist
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

    DECLARE @LIFEC_EedBenAmt VARCHAR(5);

    SELECT @LIFEC_EedBenAmt = FORMAT(DedEEBenAmt, '#0')
    FROM dbo.DedCode WITH (NOLOCK)
    WHERE DedDedCode = 'LIFEC'
    ;
    


    ---------------------------------
    -- DETAIL RECORD - U_ELINFINEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELINFINEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELINFINEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvChangeDate = dbo.dsi_fnGetMinMaxDates('MAX', Max_StartDate, '1/1/2020')  
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = '"' + EepNameLast + '"'
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvAppSignDate =    CASE WHEN LIFEE_DedCode IS NOT NULL THEN LIFEE_BdmBenStartDate 
                                WHEN GLIFE_DedCode IS NOT NULL THEN GLIFE_BdmBenStartDate 
                            END
        ,drvOccupation = JbcDesc
        ,drvSalaryAmt = FORMAT(
                                CASE WHEN EecSalaryOrHourly = 'S' THEN EecAnnSalary
                                    WHEN EecSalaryOrHourly = 'H' THEN EecHourlyPayRate
                                END
                                , '#0.00')
        ,drvSalaryCode =    CASE WHEN EecSalaryOrHourly = 'H' THEN 'H'
                                WHEN EecSalaryOrHourly = 'S' THEN 'A'
                            END
        ,drvSalEffDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, '1/1/2021', eecDateOfLastHire) 
        ,drvAddressLine1 = '"' + EepAddressLine1 + '"'
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = LEFT(EepAddressZipCode, 5)
        ,drvHomePhone = CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN LEFT(EepPhoneHomeNumber, 3) + '-' + RIGHT(LEFT(EepPhoneHomeNumber, 6), 3) + '-' + RIGHT(EepPhoneHomeNumber, 4) END
        ,drvDateOfBenefitElig = EecDateOfOriginalHire
        ,drvSubsDateOfBenElig = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire AND EjhReason NOT IN ('TRI','500') THEN EecDateOfLastHire END
        ,drvLifePolicyNumber = CASE WHEN GLIFE_DedCode IS NOT NULL THEN '000010258457-00000' END 
        ,drvLifeBillLocACNum = CASE WHEN GLIFE_DedCode IS NOT NULL THEN '1648211' END 
        ,drvLifeSortGroup =    CASE WHEN GLIFE_DedCode IS NOT NULL THEN
                                CASE WHEN EepHomeCoID = 'Y305K' THEN '1 EDURO HEALTH CARE'
                                    WHEN EepHomeCoID = 'XGNEO' THEN '13 SPEARFISH NURSING & REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNPN' THEN '17 STOCKTON NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGMRE' THEN '5 SUITES FORT COLLINS LLC'
                                    WHEN EepHomeCoID = 'AFJQO' THEN 'AURORA'
                                    WHEN EepHomeCoID = 'DK362' THEN 'HELENA'
                                    WHEN EepHomeCoID = 'XGN1Y' THEN 'VALLEY VIEW'
                                    WHEN EepHomeCoID = 'XGN5C' THEN '10 ABERDEEN NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNHV' THEN '14 BELLE FOURCHE NURSING & REHAB CENTER'
                                    WHEN EepHomeCoID = 'XGM9Z' THEN '2 BEAVER VALLEY HOSPITAL'
                                    WHEN EepHomeCoID = 'XGMUJ' THEN '7 COPPER RIDGE HEALTH AND REHAB'
                                    WHEN EepHomeCoID = 'DCILO' THEN 'CLANCY'
                                    WHEN EepHomeCoID = 'O5F1B' THEN 'HURST HURST NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGN9H' THEN '11 FARGO NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNKJ' THEN '15 BOISE NURSING AND REHAB'
                                    WHEN EepHomeCoID = 'XGMKS' THEN '3 BETHANY NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGMY5' THEN '8 CABEZON NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'O5EU5' THEN 'CLEB CLEBURNE NURSING AND REHAB CENTER'
                                    WHEN EepHomeCoID = 'B54NT' THEN 'OAKHURST'
                                    WHEN EepHomeCoID = 'XGNBV' THEN '12 PARKER NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNMP' THEN '16 FRESNO NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGMOF' THEN '4 FOX VALLEY TRANSITIONAL CARE LLC'
                                    WHEN EepHomeCoID = 'O5E2U' THEN 'ANGLETON NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'O5DLK' THEN 'HACOA HACIENDA OAKS NURSING AND REHAB'
                                    WHEN EepHomeCoID = 'EY15H' THEN 'SWMVH'
                                END
                            END
        ,drvLifeEffDate = CASE WHEN GLIFE_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', GLIFE_BdmBenStartDate, '1/1/2020') END 
        ,drvLifePlanCode = CASE WHEN GLIFE_DedCode IS NOT NULL THEN '1' END 
        ,drvLifeClassCode = CASE WHEN GLIFE_DedCode IS NOT NULL THEN 
                                CASE WHEN EecDedGroupCode = 'EXEC' THEN '2' ELSE '1' END
                            END 
        ,drvLiCvgs = CASE WHEN GLIFE_DedCode IS NOT NULL THEN 'LI- 1' END 
        ,drvLiTerminationDate = CASE WHEN GLIFE_DedCode IS NOT NULL THEN GLIFE_BdmBenStopDate END 
        ,drvAdCvgs = CASE WHEN GLIFE_DedCode IS NOT NULL THEN 'AD- 1' END 
        ,drvAdTerminationDate = CASE WHEN GLIFE_DedCode IS NOT NULL THEN GLIFE_BdmBenStopDate END 
        ,drvWiPolicyNumber = CASE WHEN STD_DedCode IS NOT NULL THEN '000010258458-00000' END 
        ,drvWiBillLocACNum = CASE WHEN STD_DedCode IS NOT NULL THEN '1648211' END 
        ,drvWiSortGroup =    CASE WHEN STD_DedCode IS NOT NULL THEN
                                CASE WHEN EepHomeCoID = 'Y305K' THEN '1 EDURO HEALTH CARE'
                                    WHEN EepHomeCoID = 'XGNEO' THEN '13 SPEARFISH NURSING & REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNPN' THEN '17 STOCKTON NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGMRE' THEN '5 SUITES FORT COLLINS LLC'
                                    WHEN EepHomeCoID = 'AFJQO' THEN 'AURORA'
                                    WHEN EepHomeCoID = 'DK362' THEN 'HELENA'
                                    WHEN EepHomeCoID = 'XGN1Y' THEN 'VALLEY VIEW'
                                    WHEN EepHomeCoID = 'XGN5C' THEN '10 ABERDEEN NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNHV' THEN '14 BELLE FOURCHE NURSING & REHAB CENTER'
                                    WHEN EepHomeCoID = 'XGM9Z' THEN '2 BEAVER VALLEY HOSPITAL'
                                    WHEN EepHomeCoID = 'XGMUJ' THEN '7 COPPER RIDGE HEALTH AND REHAB'
                                    WHEN EepHomeCoID = 'DCILO' THEN 'CLANCY'
                                    WHEN EepHomeCoID = 'O5F1B' THEN 'HURST HURST NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGN9H' THEN '11 FARGO NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNKJ' THEN '15 BOISE NURSING AND REHAB'
                                    WHEN EepHomeCoID = 'XGMKS' THEN '3 BETHANY NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGMY5' THEN '8 CABEZON NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'O5EU5' THEN 'CLEB CLEBURNE NURSING AND REHAB CENTER'
                                    WHEN EepHomeCoID = 'B54NT' THEN 'OAKHURST'
                                    WHEN EepHomeCoID = 'XGNBV' THEN '12 PARKER NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNMP' THEN '16 FRESNO NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGMOF' THEN '4 FOX VALLEY TRANSITIONAL CARE LLC'
                                    WHEN EepHomeCoID = 'O5E2U' THEN 'ANGLETON NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'O5DLK' THEN 'HACOA HACIENDA OAKS NURSING AND REHAB'
                                    WHEN EepHomeCoID = 'EY15H' THEN 'SWMVH'
                                END
                            END
        ,drvWiEffDate = CASE WHEN STD_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', STD_BdmBenStartDate, '1/1/2020') END 
        ,drvWiPlanCode = CASE WHEN STD_DedCode IS NOT NULL THEN '1' END 
        ,drvWiClassCode =    CASE WHEN STD_DedCode IS NOT NULL THEN 
                                CASE WHEN EecDedGroupCode = 'EXEC' THEN '2' ELSE '1' END
                            END 
        ,divWiCvgs = CASE WHEN STD_DedCode IS NOT NULL THEN 'WI- 1' END 
        ,drvWiTerminationDate = CASE WHEN STD_DedCode IS NOT NULL THEN STD_BdmBenStopDate END 
        ,drvOwiCvgs = ''
        ,drvOwiTerminationDate = ''
        ,drvLtdPolicyNumber = CASE WHEN LTD_DedCode IS NOT NULL THEN '000010258455-00000' END 
        ,drvLtdBillLocACNum = CASE WHEN LTD_DedCode IS NOT NULL THEN '1648211' END 
        ,drvLtdSortGoup =    CASE WHEN LTD_DedCode IS NOT NULL THEN
                                CASE WHEN EepHomeCoID = 'Y305K' THEN '1 EDURO HEALTH CARE'
                                    WHEN EepHomeCoID = 'XGNEO' THEN '13 SPEARFISH NURSING & REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNPN' THEN '17 STOCKTON NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGMRE' THEN '5 SUITES FORT COLLINS LLC'
                                    WHEN EepHomeCoID = 'AFJQO' THEN 'AURORA'
                                    WHEN EepHomeCoID = 'DK362' THEN 'HELENA'
                                    WHEN EepHomeCoID = 'XGN1Y' THEN 'VALLEY VIEW'
                                    WHEN EepHomeCoID = 'XGN5C' THEN '10 ABERDEEN NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNHV' THEN '14 BELLE FOURCHE NURSING & REHAB CENTER'
                                    WHEN EepHomeCoID = 'XGM9Z' THEN '2 BEAVER VALLEY HOSPITAL'
                                    WHEN EepHomeCoID = 'XGMUJ' THEN '7 COPPER RIDGE HEALTH AND REHAB'
                                    WHEN EepHomeCoID = 'DCILO' THEN 'CLANCY'
                                    WHEN EepHomeCoID = 'O5F1B' THEN 'HURST HURST NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGN9H' THEN '11 FARGO NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNKJ' THEN '15 BOISE NURSING AND REHAB'
                                    WHEN EepHomeCoID = 'XGMKS' THEN '3 BETHANY NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGMY5' THEN '8 CABEZON NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'O5EU5' THEN 'CLEB CLEBURNE NURSING AND REHAB CENTER'
                                    WHEN EepHomeCoID = 'B54NT' THEN 'OAKHURST'
                                    WHEN EepHomeCoID = 'XGNBV' THEN '12 PARKER NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNMP' THEN '16 FRESNO NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGMOF' THEN '4 FOX VALLEY TRANSITIONAL CARE LLC'
                                    WHEN EepHomeCoID = 'O5E2U' THEN 'ANGLETON NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'O5DLK' THEN 'HACOA HACIENDA OAKS NURSING AND REHAB'
                                    WHEN EepHomeCoID = 'EY15H' THEN 'SWMVH'
                                END
                            END
        ,drvLtdEffDate = CASE WHEN LTD_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', LTD_BdmBenStartDate, '1/1/2020') END 
        ,drvLtdPlanCode = CASE WHEN LTD_DedCode IS NOT NULL THEN '1' END
        ,drvLtdClassCode =    CASE WHEN LTD_DedCode IS NOT NULL THEN 
                                CASE WHEN EecDedGroupCode = 'EXEC' THEN '2' ELSE '1' END
                            END 
        ,drvLtdCvgs = CASE WHEN LTD_DedCode IS NOT NULL THEN 'LTD-1' END
        ,drvLtdTerminationDate = CASE WHEN LTD_DedCode IS NOT NULL THEN LTD_BdmBenStopDate END 
        ,drvVLIFPolicyNumber = CASE WHEN LIFEE_DedCode IS NOT NULL THEN '000400001000-25817' END
        ,drvVLIFBillLocACNum = CASE WHEN LIFEE_DedCode IS NOT NULL THEN '1648211 ' END
        ,drvVLIFSortGroup =    CASE WHEN LIFEE_DedCode IS NOT NULL THEN
                                CASE WHEN EepHomeCoID = 'Y305K' THEN '1 EDURO HEALTH CARE'
                                    WHEN EepHomeCoID = 'XGNEO' THEN '13 SPEARFISH NURSING & REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNPN' THEN '17 STOCKTON NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGMRE' THEN '5 SUITES FORT COLLINS LLC'
                                    WHEN EepHomeCoID = 'AFJQO' THEN 'AURORA'
                                    WHEN EepHomeCoID = 'DK362' THEN 'HELENA'
                                    WHEN EepHomeCoID = 'XGN1Y' THEN 'VALLEY VIEW'
                                    WHEN EepHomeCoID = 'XGN5C' THEN '10 ABERDEEN NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNHV' THEN '14 BELLE FOURCHE NURSING & REHAB CENTER'
                                    WHEN EepHomeCoID = 'XGM9Z' THEN '2 BEAVER VALLEY HOSPITAL'
                                    WHEN EepHomeCoID = 'XGMUJ' THEN '7 COPPER RIDGE HEALTH AND REHAB'
                                    WHEN EepHomeCoID = 'DCILO' THEN 'CLANCY'
                                    WHEN EepHomeCoID = 'O5F1B' THEN 'HURST HURST NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGN9H' THEN '11 FARGO NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNKJ' THEN '15 BOISE NURSING AND REHAB'
                                    WHEN EepHomeCoID = 'XGMKS' THEN '3 BETHANY NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGMY5' THEN '8 CABEZON NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'O5EU5' THEN 'CLEB CLEBURNE NURSING AND REHAB CENTER'
                                    WHEN EepHomeCoID = 'B54NT' THEN 'OAKHURST'
                                    WHEN EepHomeCoID = 'XGNBV' THEN '12 PARKER NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGNMP' THEN '16 FRESNO NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'XGMOF' THEN '4 FOX VALLEY TRANSITIONAL CARE LLC'
                                    WHEN EepHomeCoID = 'O5E2U' THEN 'ANGLETON NURSING AND REHAB CENTER LLC'
                                    WHEN EepHomeCoID = 'O5DLK' THEN 'HACOA HACIENDA OAKS NURSING AND REHAB'
                                    WHEN EepHomeCoID = 'EY15H' THEN 'SWMVH'
                                END
                            END
        ,drvVLIFEffDate = CASE WHEN LIFEE_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', LIFEE_BdmBenStartDate, '1/1/2020') END 
        ,drvVLIFPlanCode = CASE WHEN LIFEE_DedCode IS NOT NULL THEN '1' END
        ,drvVLIFClassCode =    CASE WHEN LIFEE_DedCode IS NOT NULL THEN 
                                CASE WHEN EecDedGroupCode = 'EXEC' THEN '2' ELSE '1' END
                            END 
        ,drvVLICvgs = CASE WHEN LIFEE_DedCode IS NOT NULL THEN 'VLI-' + FORMAT(LIFEE_EedBenAmt, '#0') END
        ,drvVLITerminationDate = CASE WHEN LIFEE_DedCode IS NOT NULL THEN LIFEE_BdmBenStopDate END 
        ,drvVADCvgs = CASE WHEN LIFEE_DedCode IS NOT NULL THEN 'VAD-' + FORMAT(LIFEE_EedBenAmt, '#0') END
        ,drvVADTerminationDate = CASE WHEN LIFEE_DedCode IS NOT NULL THEN LIFEE_BdmBenStopDate END 
        ,drvVSLICvgs = CASE WHEN LIFES_DedCode IS NOT NULL THEN 'VSLI-' + FORMAT(LIFES_EedBenAmt, '#0') END
        ,drvVSLITerminationDate = CASE WHEN LIFES_DedCode IS NOT NULL THEN LIFES_BdmBenStopDate END 
        ,drvVSADCvgs = CASE WHEN LIFES_DedCode IS NOT NULL THEN 'VSAD-' + FORMAT(LIFES_EedBenAmt, '#0') END 
        ,drvVSADTerminationDate = CASE WHEN LIFES_DedCode IS NOT NULL THEN LIFES_BdmBenStopDate END 
        ,drvVCLICvgs = CASE WHEN LIFEC_DedCode IS NOT NULL THEN 'VCLI-' + @LIFEC_EedBenAmt END 
        ,drvVCLITerminationDate = CASE WHEN LIFEC_DedCode IS NOT NULL THEN LIFEC_BdmBenStopDate END 
        ,drvMbrSmoker = CASE WHEN EepIsSmoker = 'Y' THEN 'Y' ELSE 'N' END
        ,drvSpouseSmoker =    CASE WHEN LIFES_DedCode IS NOT NULL AND (ConRelationship IN ('SPS','DP') OR LfsConRelationship IN ('SPS','DP')) THEN 
                                CASE WHEN ConIsSmoker IS NOT NULL THEN 
                                    CASE WHEN ConIsSmoker = 'Y' THEN 'Y' ELSE 'N' END
                                ELSE
                                    CASE WHEN LfsConIsSmoker = 'Y' THEN 'Y' ELSE 'N' END
                                END
                            ELSE 'N'
                            END
        --CASE WHEN LIFES_DedCode IS NOT NULL AND ConRelationship IN ('SPS','DP') AND ConIsSmoker = 'Y' THEN 'Y' END
        ,drvSpouseDOB =    CASE WHEN LIFES_DedCode IS NOT NULL AND (ConRelationship IN ('SPS','DP') OR LfsConRelationship IN ('SPS','DP')) THEN 
                            CASE WHEN ConDateOfBirth IS NOT NULL THEN ConDateOfBirth ELSE LfsConDateOfBirth END
                        END
        ,drvDepFirstName = ''
        ,drvDepLastName = ''
        ,drvDepMI = ''
        ,devDepGender = ''
        ,drvDepDOB = ''
        ,drvDepRelationshipCode = ''
        ,drvDepStudentCode = ''
        ,drvDisabled = ''
        ,drvDepCvgIndicator = ''
        ,drvDepDhmoPcp = ''
        ,drvDepFirstName2 = ''
        ,drvDepLastName2 = ''
        ,drvDepMI2 = ''
        ,devDepGender2 = ''
        ,drvDepDOB2 = ''
        ,drvDepRelationshipCode2 = ''
        ,drvDepStudentCode2 = ''
        ,drvDisabled2 = ''
        ,drvDepCvgIndicator2 = ''
        ,drvDepDhmoPcp2 = ''
        ,drvDepFirstName3 = ''
        ,drvDepLastName3 = ''
        ,drvDepMI3 = ''
        ,devDepGender3 = ''
        ,drvDepDOB3 = ''
        ,drvDepRelationshipCode3 = ''
        ,drvDepStudentCode3 = ''
        ,drvDisabled3 = ''
        ,drvDepCvgIndicator3 = ''
        ,drvDepDhmoPcp3 = ''
        ,drvDepFirstName4 = ''
        ,drvDepLastName4 = ''
        ,drvDepMI4 = ''
        ,devDepGender4 = ''
        ,drvDepDOB4 = ''
        ,drvDepRelationshipCode4 = ''
        ,drvDepStudentCode4 = ''
        ,drvDisabled4 = ''
        ,drvDepCvgIndicator4 = ''
        ,drvDepDhmoPcp4 = ''
        ,drvDepFirstName5 = ''
        ,drvDepLastName5 = ''
        ,drvDepMI5 = ''
        ,devDepGender5 = ''
        ,drvDepDOB5 = ''
        ,drvDepRelationshipCode5 = ''
        ,drvDepStudentCode5 = ''
        ,drvDisabled5 = ''
        ,drvDepCvgIndicator5 = ''
        ,drvDepDhmoPcp5 = ''
        ,drvDepFirstName6 = ''
        ,drvDepLastName6 = ''
        ,drvDepMI6 = ''
        ,devDepGender6 = ''
        ,drvDepDOB6 = ''
        ,drvDepRelationshipCode6 = ''
        ,drvDepStudentCode6 = ''
        ,drvDisabled6 = ''
        ,drvDepCvgIndicator6 = ''
        ,drvDepDhmoPcp6 = ''
        ,drvDepFirstName7 = ''
        ,drvDepLastName7 = ''
        ,drvDepMI7 = ''
        ,devDepGender7 = ''
        ,drvDepDOB7 = ''
        ,drvDepRelationshipCode7 = ''
        ,drvDepStudentCode7 = ''
        ,drvDisabled7 = ''
        ,drvDepCvgIndicator7 = ''
        ,drvDepDhmoPcp7 = ''
        ,drvDepFirstName8 = ''
        ,drvDepLastName8 = ''
        ,drvDepMI8 = ''
        ,devDepGender8 = ''
        ,drvDepDOB8 = ''
        ,drvDepRelationshipCode8 = ''
        ,drvDepStudentCode8 = ''
        ,drvDisabled8 = ''
        ,drvDepCvgIndicator8 = ''
        ,drvDepDhmoPcp8 = ''
        ,drvDepFirstName9 = ''
        ,drvDepLastName9 = ''
        ,drvDepMI9 = ''
        ,devDepGender9 = ''
        ,drvDepDOB9 = ''
        ,drvDepRelationshipCode9 = ''
        ,drvDepStudentCode9 = ''
        ,drvDisabled9 = ''
        ,drvDepCvgIndicator9 = ''
        ,drvDepDhmoPcp9 = ''
        ,drvDepFirstName10 = ''
        ,drvDepLastName10 = ''
        ,drvDepMI10 = ''
        ,devDepGender10 = ''
        ,drvDepDOB10 = ''
        ,drvDepRelationshipCode10 = ''
        ,drvDepStudentCode10 = ''
        ,drvDisabled10 = ''
        ,drvDepCvgIndicator10 = ''
        ,drvDepDhmoPcp10 = ''
    INTO  dbo.U_ELINFINEXP_drvTbl
    FROM dbo.U_ELINFINEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT BdmEEID, BdmCOID
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmDedCode END) AS GLIFE_DedCode 
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmDedCode END) AS STD_DedCode 
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmDedCode END) AS LTD_DedCode 
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmDedCode END) AS LIFEE_DedCode 
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmDedCode END) AS LIFES_DedCode 
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmDedCode END) AS LIFEC_DedCode 
                ,MAX(BdmBenStartDate) AS Max_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStartDate END) AS GLIFE_BdmBenStartDate 
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStartDate END) AS STD_BdmBenStartDate 
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStartDate END) AS LTD_BdmBenStartDate 
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStartDate END) AS LIFEE_BdmBenStartDate 
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStartDate END) AS LIFES_BdmBenStartDate 
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStartDate END) AS LIFEC_BdmBenStartDate 
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStopDate END) AS GLIFE_BdmBenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStopDate END) AS STD_BdmBenStopDate 
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStopDate END) AS LTD_BdmBenStopDate 
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStopDate END) AS LIFEE_BdmBenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStopDate END) AS LIFES_BdmBenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStopDate END) AS LIFEC_BdmBenStopDate
            FROM dbo.U_dsi_BDM_ELINFINEXP WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (
                SELECT EedEEID AS LIFEE_EedEEID, EedCOID AS LIFEE_EedCOID, EedBenAmt AS LIFEE_EedBenAmt
                FROM dbo.EmpDed WITH (NOLOCK) 
                WHERE EedDedCode= 'LIFEE') AS LIFEE_BenAmt
        ON xEEID = LIFEE_EedEEID
        AND xCOID = LIFEE_EedCOID
    LEFT JOIN (
                SELECT EedEEID AS LIFES_EedEEID, EedCOID AS LIFES_EedCOID, EedBenAmt AS LIFES_EedBenAmt
                FROM dbo.EmpDed WITH (NOLOCK) 
                WHERE EedDedCode= 'LIFES') AS LIFES_BenAmt
        ON xEEID = LIFES_EedEEID
        AND xCOID = LIFES_EedCOID
    LEFT JOIN (
                SELECT DISTINCT BdmEEID, BdmCOID, BdmDepRecId, BdmRelationship
                FROM dbo.U_dsi_BDM_ELINFINEXP WITH (NOLOCK)
                WHERE BdmRelationship IN ('SPS','DP')) AS SpouseList
        ON xEEID = SpouseList.BdmEEID
        AND xCOID = SpouseList.BdmCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = SpouseList.BdmDepRecID
    LEFT JOIN (
                SELECT EjhEEID 
                    ,MAX(EjhReason) AS EjhReason
                    ,MAX(EjhJobEffDate) AS EjhJobEffDate 
                FROM dbo.EmpHJob WITH (NOLOCK)
                WHERE EjhReason IN ('TRI','500') 
                GROUP BY EjhEEID) AS Ejh
        ON EjhEEID = xEEID
    LEFT JOIN (
                SELECT EedEEID AS LfsEEID, EedCOID AS LfsCOID, ConRelationship AS LfsConRelationship, ConDateOfBirth AS LfsConDateOfBirth, ConIsSmoker AS LfsConIsSmoker
                FROM dbo.EmpDed WITH (NOLOCK)
                JOIN dbo.Contacts WITH (NOLOCK)
                    ON ConEEID = EedEEID
                    AND ConSystemId = EedDepRecId
                WHERE EedDedCode = 'LIFES') AS LIFES_SPS_BEN
        ON LfsEEID = xEEID
        AND LfsCOID = xCOID
        
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate and @EndDate)
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
ALTER VIEW dbo.dsi_vwELINFINEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELINFINEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELINFINEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106291'
       ,expStartPerControl     = '202106291'
       ,expLastEndPerControl   = '202107069'
       ,expEndPerControl       = '202107069'
WHERE expFormatCode = 'ELINFINEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELINFINEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELINFINEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort