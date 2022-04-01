SET NOCOUNT ON;
IF OBJECT_ID('U_ELINFINEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELINFINEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELINFINEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELINFINEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELINFINEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELINFINEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINFINEXP];
GO
IF OBJECT_ID('U_ELINFINEXP_PEmpDed') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_PEmpDed];
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
IF OBJECT_ID('U_ELINFINEXP_BdmDepRecID') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_BdmDepRecID];
GO
IF OBJECT_ID('U_ELINFINEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_AuditFields];
GO
IF OBJECT_ID('U_ELINFINEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ELINFINEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELINFINEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELINFINEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELINFINEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELINFINEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELINFINEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELINFINEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELINFINEXP','Lincoln Financial Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','18000','S','N','ELINFINEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','1','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','1',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Change Date"','2','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','2',NULL,'Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Change Date"','3','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','3',NULL,'Dep Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','4','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','4',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr First Name"','5','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','5',NULL,'Mbr First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Last Name"','6','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','6',NULL,'Mbr Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Middle Initial"','7','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','7',NULL,'Mbr Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr SSN"','8','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','8',NULL,'Mbr SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Gender"','9','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','9',NULL,'Mbr Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr DOB"','10','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','10',NULL,'Mbr DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"App Sign Date"','11','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','11',NULL,'App Sign Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation"','12','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','12',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs Per Week"','13','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','13',NULL,'Hrs Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Amt"','14','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','14',NULL,'Salary Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Code"','15','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','15',NULL,'Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sal Eff Date"','16','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','16',NULL,'Sal Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Addr 1"','17','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','17',NULL,'Mbr Addr 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Addr 2"','18','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','18',NULL,'Mbr Addr 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr City"','19','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','19',NULL,'Mbr City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr State"','20','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','20',NULL,'Mbr State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Zip Code"','21','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','21',NULL,'Mbr Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Zip Plus 4"','22','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','22',NULL,'Mbr Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','23','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','23',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','24','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','24',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Ext"','25','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','25',NULL,'Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','26','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','26',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Benefits Eligibility"','27','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','27',NULL,'Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Subsequent Date of Benefits Eligibility"','28','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','28',NULL,'Subsequent Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reason for Prior Loss of Benefits Eligibility"','29','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','29',NULL,'Reason for Prior Loss of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene First Name"','30','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','30',NULL,'Pri Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Last Name"','31','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','31',NULL,'Pri Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Middle Init"','32','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','32',NULL,'Pri Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Relationship"','33','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','33',NULL,'Pri Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Address 1"','34','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','34',NULL,'Pri Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Address 2"','35','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','35',NULL,'Pri Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene City"','36','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','36',NULL,'Pri Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene State"','37','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','37',NULL,'Pri Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Zip Code"','38','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','38',NULL,'Pri Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Zip Plus 4"','39','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','39',NULL,'Pri Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene SSN"','40','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','40',NULL,'Pri Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene First Name"','41','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','41',NULL,'Co Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Last Name"','42','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','42',NULL,'Co Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Middle Init"','43','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','43',NULL,'Co Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Relationship"','44','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','44',NULL,'Co Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Address 1"','45','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','45',NULL,'Co Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Address 2"','46','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','46',NULL,'Co Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene City"','47','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','47',NULL,'Co Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene State"','48','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','48',NULL,'Co Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Zip Code"','49','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','49',NULL,'Co Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Zip Plus 4"','50','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','50',NULL,'Co Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene SSN"','51','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','51',NULL,'Co Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Beneficiary Comments"','52','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','52',NULL,'Beneficiary Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Policy Number"','53','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','53',NULL,'Accident Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Bill Location AC Number"','54','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','54',NULL,'Accident Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Sort Group "','55','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','55',NULL,'Accident Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Eff Date"','56','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','56',NULL,'Accident Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Plan Code"','57','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','57',NULL,'Accident Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Class Code"','58','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','58',NULL,'Accident Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Tier Code"','59','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','59',NULL,'Accident Tier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health Asses Tier"','60','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','60',NULL,'Health Asses Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Tier"','61','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','61',NULL,'Hospital Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Disability Amount"','62','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','62',NULL,'Accident Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Tier"','63','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','63',NULL,'Accident DI Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Benefit Period"','64','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','64',NULL,'Accident DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Elim Period"','65','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','65',NULL,'Accident DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Sickness Disability Amount"','66','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','66',NULL,'Accident Sickness Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accidentsick Tier"','67','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','67',NULL,'Accident sick Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accidentsick DI Benefit Period"','68','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','68',NULL,'Accident sick DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accidentsick DI Elim Period"','69','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','69',NULL,'Accident sick DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Termination Date"','70','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','70',NULL,'Accident Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Policy Number"','71','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','71',NULL,'Critical Illness Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Bill Location AC Number"','72','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','72',NULL,'Critical Illness Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Sort Group"','73','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','73',NULL,'Critical Illness Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Eff Date"','74','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','74',NULL,'Critical Illness Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Plan Code"','75','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','75',NULL,'Critical Illness Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Class Code"','76','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','76',NULL,'Critical Illness Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Termination Date"','77','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','77',NULL,'Critical Illness Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Principal Sum Amt Approved"','78','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','78',NULL,'EE Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Principal Sum Amt Pending"','79','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','79',NULL,'EE Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Principal Sum Amt Approved"','80','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','80',NULL,'SP Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Principal Sum Amt Pending"','81','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','81',NULL,'SP Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Principal Sum Amt Approved"','82','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','82',NULL,'CH Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Principal Sum Amt Pending"','83','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','83',NULL,'CH Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Heart Amt Approved"','84','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','84',NULL,'EE Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Heart Amt Pending"','85','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','85',NULL,'EE Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Heart Amt Approved"','86','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','86',NULL,'SP Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Heart Amt Pending"','87','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','87',NULL,'SP Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Heart Amt Approved"','88','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','88',NULL,'CH Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Heart Amt Pending"','89','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','89',NULL,'CH Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Cancer Amt Approved"','90','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','90',NULL,'EE Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Cancer Amt Pending"','91','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','91',NULL,'EE Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Cancer Amt Approved"','92','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','92',NULL,'SP Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Cancer Amt Pending"','93','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','93',NULL,'SP Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Cancer Amt Approved"','94','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','94',NULL,'CH Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Cancer Amt Pending"','95','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','95',NULL,'CH Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Organ Amt Approved"','96','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','96',NULL,'EE Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Organ Amt Pending"','97','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','97',NULL,'EE Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Organ Amt Approved"','98','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','98',NULL,'SP Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Organ Amt Pending"','99','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','99',NULL,'SP Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Organ Amt Approved"','100','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','100',NULL,'CH Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Organ Amt Pending"','101','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','101',NULL,'CH Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Quality of Life Amt Approved"','102','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','102',NULL,'EE Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Quality of Life Amt Pending"','103','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','103',NULL,'EE Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Quality of Life Amt Approved"','104','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','104',NULL,'SP Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Quality of Life Amt Pending"','105','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','105',NULL,'SP Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Quality of Life Amt Approved"','106','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','106',NULL,'CH Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Quality of Life Amt Pending"','107','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','107',NULL,'CH Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Category Amt Approved"','108','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','108',NULL,'Child Category Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Category Amt Pending"','109','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','109',NULL,'Child Category Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Treatment Care YN"','110','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','110',NULL,'EE Treatment Care YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Treatment Care YN"','111','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','111',NULL,'SP Treatment Care YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Treatment Care YN"','112','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','112',NULL,'CH Treatment Care YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE DI YN"','113','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','113',NULL,'EE DI YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP DI YN"','114','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','114',NULL,'SP DI YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Accident YN"','115','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','115',NULL,'EE Accident Y N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Accident YN"','116','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','116',NULL,'SP Accident Y N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Accident YN"','117','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','117',NULL,'CH Accident YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE OccHIV YN"','118','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','118',NULL,'EE OccHIV YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Policy Number"','119','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','119',NULL,'Life Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Bill Location AC Number"','120','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','120',NULL,'Life Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Sort Group"','121','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','121',NULL,'Life Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Eff Date"','122','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','122',NULL,'Life Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan Code"','123','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','123',NULL,'Life Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Class Code"','124','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','124',NULL,'Life Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LI Cvgs"','125','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','125',NULL,'LI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LI Termination Date"','126','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','126',NULL,'LI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AD Cvgs"','127','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','127',NULL,'AD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AD Termination Date"','128','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','128',NULL,'AD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DLI Cvgs"','129','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','129',NULL,'DLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DLI Termination Date"','130','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','130',NULL,'DLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DAD Cvgs"','131','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','131',NULL,'DAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DAD Termination Date"','132','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','132',NULL,'DAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLI Cvgs"','133','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','133',NULL,'OLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLI Termination Date"','134','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','134',NULL,'OLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OAD Cvgs"','135','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','135',NULL,'OAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OAD Termination Date"','136','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','136',NULL,'OAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODLI Cvgs"','137','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','137',NULL,'ODLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODLI Termination Date"','138','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','138',NULL,'ODLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODAD Cvgs"','139','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','139',NULL,'ODAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODAD Termination Date"','140','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','140',NULL,'ODAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SLI Cvgs"','141','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','141',NULL,'SLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SLI Termination Date"','142','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','142',NULL,'SLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAD Cvgs"','143','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','143',NULL,'SAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAD Termination Date"','144','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','144',NULL,'SAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLI Cvgs"','145','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','145',NULL,'CLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLI Termination Date"','146','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','146',NULL,'CLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSLI Cvgs"','147','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','147',NULL,'OSLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSLI Termination Date"','148','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','148',NULL,'OSLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSAD Cvgs"','149','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','149',NULL,'OSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSAD Termination Date"','150','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','150',NULL,'OSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OCLI Cvgs"','151','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','151',NULL,'OCLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OCLI Termination Date"','152','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','152',NULL,'OCLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Policy Number"','153','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','153',NULL,'WI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Bill Location AC Number"','154','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','154',NULL,'WI Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Sort Group"','155','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','155',NULL,'WI Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Eff Date"','156','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','156',NULL,'WI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Plan Code"','157','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','157',NULL,'WI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Class Code"','158','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','158',NULL,'WI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Cvgs"','159','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','159',NULL,'WI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Termination Date"','160','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','160',NULL,'WI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OWI Cvgs"','161','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','161',NULL,'OWI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OWI Termination Date"','162','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','162',NULL,'OWI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Policy Number"','163','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','163',NULL,'LTD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Bill Location AC Number"','164','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','164',NULL,'LTD Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Sort Group"','165','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','165',NULL,'LTD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Eff Date"','166','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','166',NULL,'LTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Plan Code"','167','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','167',NULL,'LTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Class Code"','168','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','168',NULL,'LTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Cvgs"','169','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','169',NULL,'LTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Termination Date"','170','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','170',NULL,'LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLTD Cvgs"','171','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','171',NULL,'OLTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLTD Termination Date"','172','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','172',NULL,'OLTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Cvgs"','173','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','173',NULL,'CI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Date"','174','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','174',NULL,'CI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Policy Number"','175','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','175',NULL,'Dent Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Bill Location AC Number"','176','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','176',NULL,'Dent Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Sort Group"','177','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','177',NULL,'Dent Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Eff Date"','178','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','178',NULL,'Dent Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Plan Code"','179','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','179',NULL,'Dent Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Class Code"','180','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','180',NULL,'Dent Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Coverage Tier"','181','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','181',NULL,'Dent Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Other Ins"','182','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','182',NULL,'Dent Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Termination Date"','183','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','183',NULL,'Dent Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Policy Number"','184','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','184',NULL,'DHMO Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Bill Location AC Number"','185','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','185',NULL,'DHMO Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Sort Group"','186','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','186',NULL,'DHMO Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Eff Date"','187','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','187',NULL,'DHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Plan Code"','188','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','188',NULL,'DHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Class Code"','189','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','189',NULL,'DHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Coverage Tier "','190','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','190',NULL,'DHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO PCP"','191','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','191',NULL,'DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Termination Date"','192','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','192',NULL,'DHMO Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Policy Number"','193','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','193',NULL,'LVC Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Bill Location AC Number"','194','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','194',NULL,'LVC Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Sort Group"','195','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','195',NULL,'LVC Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Eff Date"','196','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','196',NULL,'LVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Plan Code"','197','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','197',NULL,'LVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Class Code"','198','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','198',NULL,'LVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Coverage Tier"','199','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','199',NULL,'LVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Other Ins"','200','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','200',NULL,'LVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Termination Date"','201','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','201',NULL,'LVC Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Policy Number"','202','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','202',NULL,'VLVC Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Bill Location AC Number"','203','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','203',NULL,'VLVC Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Sort Group"','204','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','204',NULL,'VLVC Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Eff Date"','205','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','205',NULL,'VLVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Plan Code"','206','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','206',NULL,'VLVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Class Code"','207','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','207',NULL,'VLVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Coverage Tier"','208','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','208',NULL,'VLVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Other Ins"','209','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','209',NULL,'VLVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Termination Date"','210','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','210',NULL,'VLVC Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Policy Number"','211','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','211',NULL,'VDN Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Bill Location AC Number"','212','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','212',NULL,'VDN Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Sort Group"','213','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','213',NULL,'VDN Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Eff Date"','214','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','214',NULL,'VDN Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Plan Code"','215','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','215',NULL,'VDN Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Class Code"','216','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','216',NULL,'VDN Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Coverage Tier"','217','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','217',NULL,'VDN Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Other Ins"','218','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','218',NULL,'VDN Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Termination Date"','219','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','219',NULL,'VDN Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Policy Number"','220','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','220',NULL,'VDHMO Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Bill Location AC Number"','221','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','221',NULL,'VDHMO Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Sort Group"','222','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','222',NULL,'VDHMO Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Eff Date"','223','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','223',NULL,'VDHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Plan Code"','224','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','224',NULL,'VDHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Class Code"','225','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','225',NULL,'VDHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Coverage Tier"','226','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','226',NULL,'VDHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO PCP"','227','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','227',NULL,'VDHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Termination Date"','228','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','228',NULL,'VDHMO Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Policy Number"','229','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','229',NULL,'VLIF Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Bill Location AC Number"','230','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','230',NULL,'VLIF Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Sort Group"','231','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','231',NULL,'VLIF Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Eff Date"','232','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','232',NULL,'VLIF Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Plan Code"','233','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','233',NULL,'VLIF Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Class Code"','234','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','234',NULL,'VLIF Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLI Cvgs"','235','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','235',NULL,'VLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLI Termination Date"','236','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','236',NULL,'VLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VAD Cvgs"','237','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','237',NULL,'VAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VAD Termination Date"','238','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','238',NULL,'VAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLI Cvgs"','239','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','239',NULL,'VSLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLI Termination Date"','240','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','240',NULL,'VSLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSAD Cvgs"','241','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','241',NULL,'VSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSAD Termination Date"','242','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','242',NULL,'VSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLI Cvgs"','243','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','243',NULL,'VCLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLI Termination Date"','244','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','244',NULL,'VCLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Policy Number"','245','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','245',NULL,'VWI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Bill Location AC Number"','246','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','246',NULL,'VWI Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Sort Group"','247','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','247',NULL,'VWI Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Eff Date"','248','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','248',NULL,'VWI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Plan Code"','249','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','249',NULL,'VWI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Class Code"','250','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','250',NULL,'VWI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Benefit Amt"','251','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','251',NULL,'VWI Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Elim Period"','252','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','252',NULL,'VWI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Benefit Duration"','253','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','253',NULL,'VWI Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Termination Date"','254','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','254',NULL,'VWI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Policy Number"','255','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','255',NULL,'VLTD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Bill Location AC Number"','256','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','256',NULL,'VLTD Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Sort Group"','257','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','257',NULL,'VLTD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Eff Date"','258','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','258',NULL,'VLTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Plan Code"','259','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','259',NULL,'VLTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Class Code"','260','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','260',NULL,'VLTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Amt"','261','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','261',NULL,'VLTD Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Elim Period"','262','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','262',NULL,'VLTD Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Duration"','263','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','263',NULL,'VLTD Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Pct"','264','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','264',NULL,'VLTD Benefit Pct',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Termination Date"','265','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','265',NULL,'VLTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Policy Number"','266','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','266',NULL,'STAD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Bill Location AC Number"','267','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','267',NULL,'STAD Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Sort Group"','268','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','268',NULL,'STAD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Eff Date"','269','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','269',NULL,'STAD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Plan Code"','270','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','270',NULL,'STAD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Class Code"','271','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','271',NULL,'STAD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVAD Cvgs"','272','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','272',NULL,'STVAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVAD Termination Date"','273','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','273',NULL,'STVAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVSAD Cvgs"','274','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','274',NULL,'STVSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVSAD Termination Date"','275','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','275',NULL,'STVSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVCAD Cvgs"','276','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','276',NULL,'STVCAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVCAD Termination Date"','277','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','277',NULL,'STVCAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualifying Event Code"','278','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','278',NULL,'Qualifying Event Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualifying Event Eff Date"','279','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','279',NULL,'Qualifying Event Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Smoker"','280','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','280',NULL,'Mbr Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Smoker "','281','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','281',NULL,'Spouse Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse DOB"','282','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','282',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 1"','283','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','283',NULL,'Dep First Name 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 1"','284','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','284',NULL,'Dep Last Name 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 1"','285','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','285',NULL,'Dep M I 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 1"','286','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','286',NULL,'Dep Gender 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 1"','287','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','287',NULL,'Dep DOB 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 1"','288','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','288',NULL,'Dep Relationship Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 1"','289','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','289',NULL,'Dep Student Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 1"','290','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','290',NULL,'Dep Disabled YN 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 1"','291','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','291',NULL,'Dep Cvg Indicator 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 1"','292','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','292',NULL,'Dep DHMO PCP 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 2"','293','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','293',NULL,'Dep First Name 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 2"','294','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','294',NULL,'Dep Last Name 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 2"','295','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','295',NULL,'Dep M I 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 2"','296','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','296',NULL,'Dep Gender 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 2"','297','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','297',NULL,'Dep DOB 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 2"','298','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','298',NULL,'Dep Relationship Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 2"','299','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','299',NULL,'Dep Student Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 2"','300','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','300',NULL,'Dep Disabled YN 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 2"','301','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','301',NULL,'Dep Cvg Indicator 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 2"','302','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','302',NULL,'Dep DHMO PCP 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 3"','303','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','303',NULL,'Dep First Name 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 3"','304','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','304',NULL,'Dep Last Name 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 3"','305','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','305',NULL,'Dep M I 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 3"','306','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','306',NULL,'Dep Gender 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 3"','307','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','307',NULL,'Dep DOB 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 3"','308','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','308',NULL,'Dep Relationship Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 3"','309','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','309',NULL,'Dep Student Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 3"','310','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','310',NULL,'Dep Disabled YN 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 3"','311','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','311',NULL,'Dep Cvg Indicator 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 3"','312','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','312',NULL,'Dep DHMO PCP 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 4"','313','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','313',NULL,'Dep First Name 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 4"','314','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','314',NULL,'Dep Last Name 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 4"','315','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','315',NULL,'Dep M I 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 4"','316','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','316',NULL,'Dep Gender 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 4"','317','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','317',NULL,'Dep DOB 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 4"','318','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','318',NULL,'Dep Relationship Code 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 4"','319','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','319',NULL,'Dep Student Code 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 4"','320','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','320',NULL,'Dep Disabled YN 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 4"','321','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','321',NULL,'Dep Cvg Indicator 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 4"','322','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','322',NULL,'Dep DHMO PCP 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 5"','323','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','323',NULL,'Dep First Name 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 5"','324','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','324',NULL,'Dep Last Name 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 5"','325','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','325',NULL,'Dep M I 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 5"','326','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','326',NULL,'Dep Gender 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 5"','327','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','327',NULL,'Dep DOB 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 5"','328','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','328',NULL,'Dep Relationship Code 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 5"','329','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','329',NULL,'Dep Student Code 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 5"','330','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','330',NULL,'Dep Disabled YN 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 5"','331','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','331',NULL,'Dep Cvg Indicator 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 5"','332','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','332',NULL,'Dep DHMO PCP 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 6"','333','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','333',NULL,'Dep First Name 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 6"','334','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','334',NULL,'Dep Last Name 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 6"','335','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','335',NULL,'Dep M I 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 6"','336','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','336',NULL,'Dep Gender 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 6"','337','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','337',NULL,'Dep DOB 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 6"','338','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','338',NULL,'Dep Relationship Code 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 6"','339','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','339',NULL,'Dep Student Code 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 6"','340','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','340',NULL,'Dep Disabled YN 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 6"','341','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','341',NULL,'Dep Cvg Indicator 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 6"','342','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','342',NULL,'Dep DHMO PCP 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 7"','343','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','343',NULL,'Dep First Name 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 7"','344','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','344',NULL,'Dep Last Name 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 7"','345','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','345',NULL,'Dep M I 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 7"','346','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','346',NULL,'Dep Gender 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 7"','347','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','347',NULL,'Dep DOB 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 7"','348','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','348',NULL,'Dep Relationship Code 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 7"','349','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','349',NULL,'Dep Student Code 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 7"','350','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','350',NULL,'Dep Disabled YN 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 7"','351','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','351',NULL,'Dep Cvg Indicator 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 7"','352','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','352',NULL,'Dep DHMO PCP 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 8"','353','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','353',NULL,'Dep First Name 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 8"','354','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','354',NULL,'Dep Last Name 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 8"','355','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','355',NULL,'Dep M I 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 8"','356','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','356',NULL,'Dep Gender 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 8"','357','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','357',NULL,'Dep DOB 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 8"','358','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','358',NULL,'Dep Relationship Code 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 8"','359','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','359',NULL,'Dep Student Code 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 8"','360','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','360',NULL,'Dep Disabled YN 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 8"','361','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','361',NULL,'Dep Cvg Indicator 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 8"','362','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','362',NULL,'Dep DHMO PCP 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 9"','363','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','363',NULL,'Dep First Name 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 9"','364','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','364',NULL,'Dep Last Name 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 9"','365','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','365',NULL,'Dep M I 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 9"','366','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','366',NULL,'Dep Gender 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 9"','367','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','367',NULL,'Dep DOB 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 9"','368','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','368',NULL,'Dep Relationship Code 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 9"','369','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','369',NULL,'Dep Student Code 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 9"','370','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','370',NULL,'Dep Disabled YN 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 9"','371','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','371',NULL,'Dep Cvg Indicator 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 9"','372','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','372',NULL,'Dep DHMO PCP 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 10"','373','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','373',NULL,'Dep First Name 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 10"','374','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','374',NULL,'Dep Last Name 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 10"','375','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','375',NULL,'Dep M I 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 10"','376','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','376',NULL,'Dep Gender 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 10"','377','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','377',NULL,'Dep DOB 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 10"','378','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','378',NULL,'Dep Relationship Code 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 10"','379','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','379',NULL,'Dep Student Code 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 10"','380','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','380',NULL,'Dep Disabled YN 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 10"','381','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','381',NULL,'Dep Cvg Indicator 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 10"','382','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','382',NULL,'Dep DHMO PCP 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 11"','383','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','383',NULL,'Dep First Name 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 11"','384','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','384',NULL,'Dep Last Name 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 11"','385','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','385',NULL,'Dep M I 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 11"','386','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','386',NULL,'Dep Gender 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 11"','387','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','387',NULL,'Dep DOB 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 11"','388','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','388',NULL,'Dep Relationship Code 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 11"','389','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','389',NULL,'Dep Student Code 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 11"','390','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','390',NULL,'Dep Disabled YN 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 11"','391','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','391',NULL,'Dep Cvg Indicator 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 11"','392','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','392',NULL,'Dep DHMO PCP 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 12"','393','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','393',NULL,'Dep First Name 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 12"','394','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','394',NULL,'Dep Last Name 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 12"','395','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','395',NULL,'Dep M I 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 12"','396','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','396',NULL,'Dep Gender 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 12"','397','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','397',NULL,'Dep DOB 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 12"','398','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','398',NULL,'Dep Relationship Code 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 12"','399','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','399',NULL,'Dep Student Code 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 12"','400','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','400',NULL,'Dep Disabled YN 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 12"','401','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','401',NULL,'Dep Cvg Indicator 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 12"','402','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','402',NULL,'Dep DHMO PCP 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 13"','403','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','403',NULL,'Dep First Name 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 13"','404','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','404',NULL,'Dep Last Name 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 13"','405','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','405',NULL,'Dep M I 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 13"','406','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','406',NULL,'Dep Gender 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 13"','407','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','407',NULL,'Dep DOB 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 13"','408','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','408',NULL,'Dep Relationship Code 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 13"','409','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','409',NULL,'Dep Student Code 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 13"','410','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','410',NULL,'Dep Disabled YN 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 13"','411','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','411',NULL,'Dep Cvg Indicator 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 13"','412','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','412',NULL,'Dep DHMO PCP 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 14"','413','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','413',NULL,'Dep First Name 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 14"','414','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','414',NULL,'Dep Last Name 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 14"','415','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','415',NULL,'Dep M I 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 14"','416','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','416',NULL,'Dep Gender 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 14"','417','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','417',NULL,'Dep DOB 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 14"','418','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','418',NULL,'Dep Relationship Code 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 14"','419','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','419',NULL,'Dep Student Code 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 14"','420','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','420',NULL,'Dep Disabled YN 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 14"','421','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','421',NULL,'Dep Cvg Indicator 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 14"','422','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','422',NULL,'Dep DHMO PCP 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 15"','423','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','423',NULL,'Dep First Name 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 15"','424','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','424',NULL,'Dep Last Name 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I 15"','425','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','425',NULL,'Dep M I 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 15"','426','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','426',NULL,'Dep Gender 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 15"','427','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','427',NULL,'Dep DOB 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 15"','428','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','428',NULL,'Dep Relationship Code 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 15"','429','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','429',NULL,'Dep Student Code 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 15"','430','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','430',NULL,'Dep Disabled YN 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 15"','431','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','431',NULL,'Dep Cvg Indicator 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 15"','432','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','432',NULL,'Dep DHMO PCP 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','1','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','1',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChangeDate"','2','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','2',NULL,'Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepChangeDate"','3','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','3',NULL,'Dep Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','4','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','4',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrFirstName"','5','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','5',NULL,'Mbr First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrLastName"','6','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','6',NULL,'Mbr Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrMiddleInitial"','7','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','7',NULL,'Mbr Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrSSN"','8','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','8',NULL,'Mbr SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrGender"','9','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','9',NULL,'Mbr Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrDateOfBirth"','10','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','10',NULL,'Mbr DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAppSignDate"','11','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','11',NULL,'App Sign Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupation"','12','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','12',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourPerWeek"','13','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','13',NULL,'Hrs Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt"','14','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','14',NULL,'Salary Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryCode"','15','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','15',NULL,'Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalEffDate"','16','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','16',NULL,'Sal Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrAddrOne"','17','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','17',NULL,'Mbr Addr 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrAddrTwo"','18','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','18',NULL,'Mbr Addr 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrCity"','19','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','19',NULL,'Mbr City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrState"','20','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','20',NULL,'Mbr State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrZipCode"','21','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','21',NULL,'Mbr Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrZipPlusFour"','22','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','22',NULL,'Mbr Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','23','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','23',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','24','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','24',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExt"','25','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','25',NULL,'Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','26','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','26',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBenEligbility"','27','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','27',NULL,'Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubsDateOfBen"','28','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','28',NULL,'Subsequent Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReasonPriorLossBenElig"','29','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','29',NULL,'Reason for Prior Loss of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneFirstName"','30','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','30',NULL,'Pri Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneLastName"','31','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','31',NULL,'Pri Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneMiddleInit"','32','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','32',NULL,'Pri Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneRelationship"','33','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','33',NULL,'Pri Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneAddressOne"','34','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','34',NULL,'Pri Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneAddressTwo"','35','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','35',NULL,'Pri Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneCity"','36','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','36',NULL,'Pri Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneState"','37','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','37',NULL,'Pri Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneZipCode"','38','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','38',NULL,'Pri Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneZipPlusFour"','39','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','39',NULL,'Pri Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneSSN"','40','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','40',NULL,'Pri Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneFirstName"','41','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','41',NULL,'Co Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneLastName"','42','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','42',NULL,'Co Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneMiddleInit"','43','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','43',NULL,'Co Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneRelationship"','44','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','44',NULL,'Co Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneAddressOne"','45','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','45',NULL,'Co Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneAddressTwo"','46','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','46',NULL,'Co Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneCity"','47','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','47',NULL,'Co Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneState"','48','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','48',NULL,'Co Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneZipCode"','49','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','49',NULL,'Co Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneZipPlusFour"','50','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','50',NULL,'Co Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneSSN"','51','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','51',NULL,'Co Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneficiaryComments"','52','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','52',NULL,'Beneficiary Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentPolicyNumber"','53','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','53',NULL,'Accident Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentBillLocACNumber"','54','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','54',NULL,'Accident Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSortGroup"','55','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','55',NULL,'Accident Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentEffDate"','56','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','56',NULL,'Accident Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentPlanCode"','57','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','57',NULL,'Accident Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentClassCode"','58','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','58',NULL,'Accident Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentTierCode"','59','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','59',NULL,'Accident Tier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHealthAssesTier"','60','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','60',NULL,'Health Asses Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHospitalTier"','61','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','61',NULL,'Hospital Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentDisabilityAmt"','62','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','62',NULL,'Accident Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentDiTier"','63','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','63',NULL,'Accident DI Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentDiBenefitPeriod"','64','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','64',NULL,'Accident DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentDiElimPeriod"','65','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','65',NULL,'Accident DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSicknessDisaAmt"','66','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','66',NULL,'Accident Sickness Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSickTier"','67','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','67',NULL,'Accidentsick Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSickDiBenePer"','68','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','68',NULL,'Accidentsick DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSickDiElimPer"','69','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','69',NULL,'Accidentsick DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentTermDate"','70','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','70',NULL,'Accident Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessPolicyNum"','71','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','71',NULL,'Critical Illness Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessBillLocAC"','72','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','72',NULL,'Critical Illness Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessSortGrp"','73','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','73',NULL,'Critical Illness Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessEffDate"','74','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','74',NULL,'Critical Illness Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessPlanCode"','75','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','75',NULL,'Critical Illness Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessClassCode"','76','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','76',NULL,'Critical Illness Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessTermDate"','77','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','77',NULL,'Critical Illness Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEePrincSumAmtApprove"','78','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','78',NULL,'EE Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEePrincSumAmtPend"','79','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','79',NULL,'EE Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpPrincSumAmtApprove"','80','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','80',NULL,'SP Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpPrincSumAmtPend"','81','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','81',NULL,'SP Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChPrincSumAmtApprove"','82','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','82',NULL,'CH Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChPrincSumAmtPend"','83','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','83',NULL,'CH Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeHeartAmtApprove"','84','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','84',NULL,'EE Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeHeartAmtPend"','85','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','85',NULL,'EE Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpHeartAmtApprove"','86','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','86',NULL,'SP Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpHeartAmtPend"','87','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','87',NULL,'SP Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChHeartAmtApprove"','88','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','88',NULL,'CH Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChHeartAmtPend"','89','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','89',NULL,'CH Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeCancerAmtApprove"','90','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','90',NULL,'EE Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeCancerAmtPend"','91','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','91',NULL,'EE Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpCancerAmtApprove"','92','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','92',NULL,'SP Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpCancerAmtPend"','93','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','93',NULL,'SP Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChCancerAmtApprove"','94','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','94',NULL,'CH Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChCancerAmtPend"','95','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','95',NULL,'CH Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeOrganAmtApprove"','96','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','96',NULL,'EE Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeOrganAmtPend"','97','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','97',NULL,'EE Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpOrganAmtApprove"','98','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','98',NULL,'SP Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpOrganAmtPend"','99','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','99',NULL,'SP Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChOrganAmtApprove"','100','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','100',NULL,'CH Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChOrganAmtPend"','101','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','101',NULL,'CH Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeQualOfLifeAmtApprove"','102','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','102',NULL,'EE Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeQualOfLifeAmtPend"','103','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','103',NULL,'EE Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpQualOfLifeAmtApprove"','104','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','104',NULL,'SP Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpQualOfLifeAmtPend"','105','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','105',NULL,'SP Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChQualOfLifeAmtApprove"','106','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','106',NULL,'CH Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChQualOfLifeAmtPend"','107','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','107',NULL,'CH Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildCatAmtApprove"','108','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','108',NULL,'Child Category Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildCatAmtPend"','109','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','109',NULL,'Child Category Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeTreatmentCareYN"','110','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','110',NULL,'EE Treatment Care Y N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpTreatmentCareYN"','111','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','111',NULL,'SP Treatment Care YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChTreatmentCareYN"','112','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','112',NULL,'CH Treatment Care YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeDiYN"','113','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','113',NULL,'EE DI YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpDiYN"','114','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','114',NULL,'SP DI YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeAccidentYN"','115','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','115',NULL,'EE Accident YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpAccidentYN"','116','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','116',NULL,'SP Accident YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChAccidentYN"','117','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','117',NULL,'CH Accident YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeOccHivYN"','118','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','118',NULL,'EE OccHIV YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePolicyNumber"','119','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','119',NULL,'Life Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeBillLocACNumber"','120','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','120',NULL,'Life Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeSortGroup"','121','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','121',NULL,'Life Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeEffDate"','122','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','122',NULL,'Life Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlanCode"','123','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','123',NULL,'Life Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeClassCode"','124','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','124',NULL,'Life Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLiCvgs"','125','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','125',NULL,'LI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLiTerminationDate"','126','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','126',NULL,'LI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdCvgs"','127','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','127',NULL,'AD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdTerminationDate"','128','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','128',NULL,'AD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDliCvgs"','129','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','129',NULL,'DLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDliTerminationDate"','130','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','130',NULL,'DLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDadCvgs"','131','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','131',NULL,'DAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDadTerminationDate"','132','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','132',NULL,'DAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOliCvgs"','133','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','133',NULL,'OLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOliTerminationDate"','134','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','134',NULL,'OLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOadCvgs"','135','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','135',NULL,'OAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOadTerminationDate"','136','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','136',NULL,'OAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOdliCvgs"','137','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','137',NULL,'ODLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOdliTerminationDate"','138','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','138',NULL,'ODLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOdadCvgs"','139','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','139',NULL,'ODAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOdadTerminationDate"','140','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','140',NULL,'ODAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSliCvgs"','141','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','141',NULL,'SLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSliTerminationDate"','142','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','142',NULL,'SLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSadCvgs"','143','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','143',NULL,'SAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSadTerminationDate"','144','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','144',NULL,'SAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCliCvgs"','145','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','145',NULL,'CLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCliTerminationDate"','146','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','146',NULL,'CLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOsliCvgs"','147','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','147',NULL,'OSLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOsliTerminationDate"','148','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','148',NULL,'OSLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOsadCvgs"','149','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','149',NULL,'OSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOsadTerminationDate"','150','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','150',NULL,'OSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOcliCvgs"','151','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','151',NULL,'OCLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOcliTerminationDate"','152','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','152',NULL,'OCLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiPolicyNumber"','153','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','153',NULL,'WI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiBillLocACNumber"','154','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','154',NULL,'WI Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiSortGroup"','155','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','155',NULL,'WI Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiEffDate"','156','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','156',NULL,'WI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiPlanCode"','157','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','157',NULL,'WI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiClassCode"','158','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','158',NULL,'WI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiCvgs"','159','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','159',NULL,'WI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiTerminationDate"','160','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','160',NULL,'WI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOwiCvgs"','161','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','161',NULL,'OWI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOwiTerminationDate"','162','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','162',NULL,'OWI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdPolicyNum"','163','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','163',NULL,'LTD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdBillLocACNum"','164','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','164',NULL,'LTD Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdSortGroup"','165','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','165',NULL,'LTD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdEffDate"','166','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','166',NULL,'LTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdPlanCode"','167','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','167',NULL,'LTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdClassCode"','168','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','168',NULL,'LTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdCvgs"','169','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','169',NULL,'LTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdTerminationDate"','170','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','170',NULL,'LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOltdCvgs"','171','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','171',NULL,'OLTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOltdTerminationDate"','172','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','172',NULL,'OLTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiCvgs"','173','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','173',NULL,'CI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiTerminationDate"','174','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','174',NULL,'CI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentPolicyNumber"','175','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','175',NULL,'Dent Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentBillLocACNBR"','176','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','176',NULL,'Dent Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentSortGroup"','177','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','177',NULL,'Dent Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentEff"','178','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','178',NULL,'Dent Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentPlanCode"','179','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','179',NULL,'Dent Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentClassCode"','180','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','180',NULL,'Dent Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentCoverageCode"','181','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','181',NULL,'Dent Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentOtherIns"','182','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','182',NULL,'Dent Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentTerminationDate"','183','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','183',NULL,'Dent Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoPolicyNumber"','184','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','184',NULL,'DHMO Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoBillLocACNumber"','185','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','185',NULL,'DHMO Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoSortGroup"','186','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','186',NULL,'DHMO Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoEffDate"','187','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','187',NULL,'DHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoPlanCode"','188','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','188',NULL,'DHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoClassCode"','189','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','189',NULL,'DHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoCoverageTier"','190','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','190',NULL,'DHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoPcp"','191','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','191',NULL,'DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoTerminationDate"','192','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','192',NULL,'DHMO Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcPolicyNumber"','193','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','193',NULL,'LVC Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcBillLocACNumber"','194','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','194',NULL,'LVC Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcSortGroup"','195','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','195',NULL,'LVC Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcEffDate"','196','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','196',NULL,'LVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcPlanCode"','197','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','197',NULL,'LVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcClassCode"','198','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','198',NULL,'LVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcCoverageTier"','199','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','199',NULL,'LVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcOtherIns"','200','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','200',NULL,'LVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcTerminationDate"','201','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','201',NULL,'LVC Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcPolicyNumber"','202','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','202',NULL,'VLVC Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcBillLocACNumber"','203','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','203',NULL,'VLVC Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcSortGroup"','204','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','204',NULL,'VLVC Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcEffDate"','205','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','205',NULL,'VLVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcPlanCode"','206','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','206',NULL,'VLVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcClassCode"','207','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','207',NULL,'VLVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcCoverageTier"','208','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','208',NULL,'VLVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcOtherIns"','209','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','209',NULL,'VLVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcTerminationDate"','210','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','210',NULL,'VLVC Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnPolicyNumber"','211','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','211',NULL,'VDN Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnCillLocationACNum"','212','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','212',NULL,'VDN Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnSortGroup"','213','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','213',NULL,'VDN Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnEffDate"','214','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','214',NULL,'VDN Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnPlanCode"','215','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','215',NULL,'VDN Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnClassCode"','216','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','216',NULL,'VDN Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnCoverageTier"','217','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','217',NULL,'VDN Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnOtherIns"','218','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','218',NULL,'VDN Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnTerminationDate"','219','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','219',NULL,'VDN Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoPolicyNumber"','220','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','220',NULL,'VDHMO Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoBillLocationACNum"','221','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','221',NULL,'VDHMO Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoSortGroup"','222','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','222',NULL,'VDHMO Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoEffDate"','223','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','223',NULL,'VDHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoPlanCode"','224','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','224',NULL,'VDHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoClassCode"','225','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','225',NULL,'VDHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoCoverageTier"','226','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','226',NULL,'VDHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoPcp"','227','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','227',NULL,'VDHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoTerminationDate"','228','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','228',NULL,'VDHMO Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifPolicyNumber"','229','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','229',NULL,'VLIF Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifBillLocationACNum"','230','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','230',NULL,'VLIF Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifSortGroup"','231','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','231',NULL,'VLIF Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifEffDate"','232','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','232',NULL,'VLIF Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifPlanCode"','233','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','233',NULL,'VLIF Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifClassCode"','234','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','234',NULL,'VLIF Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifCvgs"','235','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','235',NULL,'VLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifTerminationDate"','236','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','236',NULL,'VLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVadCvgs"','237','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','237',NULL,'VAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVadTerminationDate"','238','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','238',NULL,'VAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVsliCvgs"','239','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','239',NULL,'VSLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVsliTerminationDate"','240','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','240',NULL,'VSLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVsadCvgs"','241','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','241',NULL,'VSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVsadTerminationDate"','242','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','242',NULL,'VSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVcliCvgs"','243','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','243',NULL,'VCLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVcliTerminationDate"','244','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','244',NULL,'VCLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiPolicyNumber"','245','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','245',NULL,'VWI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiBillLocationACNumber"','246','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','246',NULL,'VWI Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiSortGroup"','247','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','247',NULL,'VWI Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiEffDate"','248','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','248',NULL,'VWI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiPlanCode"','249','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','249',NULL,'VWI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiClassCode"','250','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','250',NULL,'VWI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiBenefitAmt"','251','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','251',NULL,'VWI Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiElimPeriod"','252','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','252',NULL,'VWI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiBenefitDuration"','253','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','253',NULL,'VWI Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiTerminationDate"','254','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','254',NULL,'VWI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdPolicyNumber"','255','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','255',NULL,'VLTD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdBillLocationACNum"','256','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','256',NULL,'VLTD Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdSortGroup"','257','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','257',NULL,'VLTD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdEffDate"','258','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','258',NULL,'VLTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdPlanCode"','259','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','259',NULL,'VLTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdClassCode"','260','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','260',NULL,'VLTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdBenefitAmt"','261','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','261',NULL,'VLTD Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdElimPeriod"','262','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','262',NULL,'VLTD Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdBenefitDuration"','263','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','263',NULL,'VLTD Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdBenefitPct"','264','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','264',NULL,'VLTD Benefit Pct',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdTerminationDate"','265','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','265',NULL,'VLTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadPolicyNumber"','266','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','266',NULL,'STAD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadBillLocationACNum"','267','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','267',NULL,'STAD Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadSortGroup"','268','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','268',NULL,'STAD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadEffDate"','269','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','269',NULL,'STAD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadPlanCode"','270','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','270',NULL,'STAD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadClassCode"','271','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','271',NULL,'STAD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvadCvgs"','272','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','272',NULL,'STVAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvadTerminationDate"','273','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','273',NULL,'STVAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvsadCvgs"','274','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','274',NULL,'STVSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvsadTerminationDate"','275','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','275',NULL,'STVSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvcadCvgs"','276','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','276',NULL,'STVCAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvcadTerminationDate"','277','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','277',NULL,'STVCAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifyingEventCode"','278','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','278',NULL,'Qualifying Event Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifyingEventEffDate"','279','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','279',NULL,'Qualifying Event Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrSmoker"','280','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','280',NULL,'Mbr Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrSpouseSmoker"','281','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','281',NULL,'Spouse Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpoudDateOfBirth"','282','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','282',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName1"','283','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','283',NULL,'Dep First Name 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName1"','284','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','284',NULL,'Dep Last Name 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial1"','285','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','285',NULL,'Dep M I 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender1"','286','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','286',NULL,'Dep Gender 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth1"','287','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','287',NULL,'Dep DOB 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode1"','288','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','288',NULL,'Dep Relationship Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode1"','289','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','289',NULL,'Dep Student Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN1"','290','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','290',NULL,'Dep Disabled YN 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator1"','291','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','291',NULL,'Dep Cvg Indicator 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp1"','292','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','292',NULL,'Dep DHMO PCP 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName2"','293','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','293',NULL,'Dep First Name 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName2"','294','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','294',NULL,'Dep Last Name 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial2"','295','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','295',NULL,'Dep M I 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender2"','296','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','296',NULL,'Dep Gender 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth2"','297','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','297',NULL,'Dep DOB 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode2"','298','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','298',NULL,'Dep Relationship Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode2"','299','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','299',NULL,'Dep Student Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN2"','300','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','300',NULL,'Dep Disabled YN 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator2"','301','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','301',NULL,'Dep Cvg Indicator 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp2"','302','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','302',NULL,'Dep DHMO PCP 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName3"','303','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','303',NULL,'Dep First Name 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName3"','304','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','304',NULL,'Dep Last Name 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial3"','305','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','305',NULL,'Dep M I 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender3"','306','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','306',NULL,'Dep Gender 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth3"','307','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','307',NULL,'Dep DOB 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode3"','308','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','308',NULL,'Dep Relationship Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode3"','309','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','309',NULL,'Dep Student Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN3"','310','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','310',NULL,'Dep Disabled YN 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator3"','311','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','311',NULL,'Dep Cvg Indicator 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp3"','312','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','312',NULL,'Dep DHMO PCP 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName4"','313','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','313',NULL,'Dep First Name 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName4"','314','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','314',NULL,'Dep Last Name 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial4"','315','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','315',NULL,'Dep M I 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender4"','316','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','316',NULL,'Dep Gender 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth4"','317','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','317',NULL,'Dep DOB 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode4"','318','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','318',NULL,'Dep Relationship Code 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode4"','319','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','319',NULL,'Dep Student Code 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN4"','320','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','320',NULL,'Dep Disabled YN 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator4"','321','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','321',NULL,'Dep Cvg Indicator 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp4"','322','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','322',NULL,'Dep DHMO PCP 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName5"','323','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','323',NULL,'Dep First Name 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName5"','324','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','324',NULL,'Dep Last Name 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial5"','325','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','325',NULL,'Dep M I 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender5"','326','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','326',NULL,'Dep Gender 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth5"','327','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','327',NULL,'Dep DOB 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode5"','328','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','328',NULL,'Dep Relationship Code 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode5"','329','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','329',NULL,'Dep Student Code 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN5"','330','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','330',NULL,'Dep Disabled YN 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator5"','331','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','331',NULL,'Dep Cvg Indicator 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp5"','332','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','332',NULL,'Dep DHMO PCP 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName6"','333','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','333',NULL,'Dep First Name 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName6"','334','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','334',NULL,'Dep Last Name 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial6"','335','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','335',NULL,'Dep M I 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender6"','336','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','336',NULL,'Dep Gender 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth6"','337','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','337',NULL,'Dep DOB 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode6"','338','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','338',NULL,'Dep Relationship Code 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode6"','339','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','339',NULL,'Dep Student Code 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN6"','340','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','340',NULL,'Dep Disabled YN 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator6"','341','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','341',NULL,'Dep Cvg Indicator 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp6"','342','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','342',NULL,'Dep DHMO PCP 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName7"','343','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','343',NULL,'Dep First Name 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName7"','344','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','344',NULL,'Dep Last Name 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial7"','345','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','345',NULL,'Dep M I 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender7"','346','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','346',NULL,'Dep Gender 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth7"','347','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','347',NULL,'Dep DOB 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode7"','348','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','348',NULL,'Dep Relationship Code 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode7"','349','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','349',NULL,'Dep Student Code 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN7"','350','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','350',NULL,'Dep Disabled YN 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator7"','351','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','351',NULL,'Dep Cvg Indicator 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp7"','352','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','352',NULL,'Dep DHMO PCP 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName8"','353','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','353',NULL,'Dep First Name 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName8"','354','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','354',NULL,'Dep Last Name 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial8"','355','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','355',NULL,'Dep M I 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender8"','356','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','356',NULL,'Dep Gender 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth8"','357','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','357',NULL,'Dep DOB 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode8"','358','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','358',NULL,'Dep Relationship Code 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode8"','359','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','359',NULL,'Dep Student Code 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN8"','360','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','360',NULL,'Dep Disabled YN 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator8"','361','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','361',NULL,'Dep Cvg Indicator 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp8"','362','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','362',NULL,'Dep DHMO PCP 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName9"','363','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','363',NULL,'Dep First Name 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName9"','364','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','364',NULL,'Dep Last Name 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial9"','365','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','365',NULL,'Dep M I 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender9"','366','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','366',NULL,'Dep Gender 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth9"','367','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','367',NULL,'Dep DOB 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode9"','368','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','368',NULL,'Dep Relationship Code 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode9"','369','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','369',NULL,'Dep Student Code 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN9"','370','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','370',NULL,'Dep Disabled YN 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator9"','371','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','371',NULL,'Dep Cvg Indicator 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp9"','372','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','372',NULL,'Dep DHMO PCP 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName10"','373','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','373',NULL,'Dep First Name 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName10"','374','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','374',NULL,'Dep Last Name 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial10"','375','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','375',NULL,'Dep M I 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender10"','376','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','376',NULL,'Dep Gender 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth10"','377','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','377',NULL,'Dep DOB 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode10"','378','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','378',NULL,'Dep Relationship Code 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode10"','379','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','379',NULL,'Dep Student Code 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN10"','380','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','380',NULL,'Dep Disabled YN 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator10"','381','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','381',NULL,'Dep Cvg Indicator 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp10"','382','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','382',NULL,'Dep DHMO PCP 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName11"','383','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','383',NULL,'Dep First Name 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName11"','384','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','384',NULL,'Dep Last Name 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial11"','385','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','385',NULL,'Dep M I 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender11"','386','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','386',NULL,'Dep Gender 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth11"','387','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','387',NULL,'Dep DOB 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode11"','388','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','388',NULL,'Dep Relationship Code 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode11"','389','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','389',NULL,'Dep Student Code 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN11"','390','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','390',NULL,'Dep Disabled YN 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator11"','391','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','391',NULL,'Dep Cvg Indicator 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp11"','392','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','392',NULL,'Dep DHMO PCP 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName12"','393','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','393',NULL,'Dep First Name 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName12"','394','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','394',NULL,'Dep Last Name 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial12"','395','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','395',NULL,'Dep M I 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender12"','396','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','396',NULL,'Dep Gender 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth12"','397','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','397',NULL,'Dep DOB 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode12"','398','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','398',NULL,'Dep Relationship Code 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode12"','399','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','399',NULL,'Dep Student Code 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN12"','400','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','400',NULL,'Dep Disabled YN 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator12"','401','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','401',NULL,'Dep Cvg Indicator 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp12"','402','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','402',NULL,'Dep DHMO PCP 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName13"','403','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','403',NULL,'Dep First Name 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName13"','404','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','404',NULL,'Dep Last Name 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial13"','405','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','405',NULL,'Dep M I 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender13"','406','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','406',NULL,'Dep Gender 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth13"','407','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','407',NULL,'Dep DOB 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode13"','408','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','408',NULL,'Dep Relationship Code 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode13"','409','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','409',NULL,'Dep Student Code 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN13"','410','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','410',NULL,'Dep Disabled YN 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator13"','411','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','411',NULL,'Dep Cvg Indicator 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp13"','412','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','412',NULL,'Dep DHMO PCP 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName14"','413','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','413',NULL,'Dep First Name 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName14"','414','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','414',NULL,'Dep Last Name 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial14"','415','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','415',NULL,'Dep M I 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender14"','416','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','416',NULL,'Dep Gender 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth14"','417','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','417',NULL,'Dep DOB 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode14"','418','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','418',NULL,'Dep Relationship Code 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode14"','419','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','419',NULL,'Dep Student Code 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN14"','420','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','420',NULL,'Dep Disabled YN 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator14"','421','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','421',NULL,'Dep Cvg Indicator 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp14"','422','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','422',NULL,'Dep DHMO PCP 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName15"','423','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','423',NULL,'Dep First Name 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName15"','424','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','424',NULL,'Dep Last Name 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial15"','425','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','425',NULL,'Dep M I 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender15"','426','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','426',NULL,'Dep Gender 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth15"','427','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','427',NULL,'Dep DOB 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode15"','428','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','428',NULL,'Dep Relationship Code 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode15"','429','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','429',NULL,'Dep Student Code 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN15"','430','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','430',NULL,'Dep Disabled YN 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator15"','431','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','431',NULL,'Dep Cvg Indicator 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp15"','432','(''UA''=''T'')','ELINFINEXPZ0','50','D','10','432',NULL,'Dep DHMO PCP 15',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINFINEXP_20200724.txt',NULL,'','','',NULL,NULL,NULL,'Lincoln Financial Export','202012319','EMPEXPORT','ONDEMAND','Nov 15 2019 11:57AM','ELINFINEXP',NULL,NULL,NULL,'202012319','Nov  8 2019 11:11AM','Nov  8 2019 11:11AM','202002011','782','','','202002011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINFINEXP_20200724.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202012319','EMPEXPORT','OEPASSIVE','Nov 15 2019 11:54AM','ELINFINEXP',NULL,NULL,NULL,'202012319','Nov  8 2019 11:11AM','Nov  8 2019 11:11AM','202002011','782','','','202002011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINFINEXP_20200724.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202012319','EMPEXPORT','OEACTIVE','Nov 20 2019 12:53PM','ELINFINEXP',NULL,NULL,NULL,'202012319','Jan  1 2020 12:00AM','Dec 30 1899 12:00AM','202002011','2','','','202002011',dbo.fn_GetTimedKey(),NULL,'us3lKiDIA1002',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINFINEXP_20200724.txt',NULL,'','',',F2U9M,F2U6Z,FOST7,F2U2H,F2UDK,F2UBO,IAGFG',NULL,NULL,NULL,'Lincoln - Fridays 8pm','202006299','EMPEXPORT','SCHEDULED','Nov 22 2019 12:00AM','ELINFINEXP',NULL,NULL,NULL,'202007179','Jan  1 2020 12:00AM','Dec 30 1899 12:00AM','202007101','782','','','202002011',dbo.fn_GetTimedKey(),NULL,'us3jBeDIA1002',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINFINEXP_20200724.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202006189','EMPEXPORT','TEST','Jun 18 2020  3:41PM','ELINFINEXP',NULL,NULL,NULL,'202006189','Jun 18 2020 12:00AM','Dec 30 1899 12:00AM','202006051','671','','','202006051',dbo.fn_GetTimedKey(),NULL,'us3lKiDIA1002',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ELINFINEXP_20200724.txt' END WHERE expFormatCode = 'ELINFINEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINFINEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINFINEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINFINEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINFINEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINFINEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ELINFINEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELINFINEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ELINFINEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINFINEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINFINEXP','H02','None',NULL);
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
IF OBJECT_ID('U_ELINFINEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ELINFINEXP_Audit] (
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
IF OBJECT_ID('U_ELINFINEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELINFINEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ELINFINEXP_BdmDepRecID') IS NULL
CREATE TABLE [dbo].[U_ELINFINEXP_BdmDepRecID] (
    [BdmDepRecID] char(12) NULL
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
    [drvSort] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvChangeDate] varchar(1) NOT NULL,
    [drvDepChangeDate] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvMbrFirstName] varchar(100) NULL,
    [drvMbrLastName] varchar(100) NULL,
    [drvMbrMiddleInitial] varchar(1) NOT NULL,
    [drvMbrSSN] varchar(11) NULL,
    [drvMbrGender] char(1) NULL,
    [drvMbrDateOfBirth] datetime NULL,
    [drvAppSignDate] nvarchar(4000) NULL,
    [drvOccupation] varchar(25) NOT NULL,
    [drvHourPerWeek] varchar(30) NULL,
    [drvSalaryAmt] money NULL,
    [drvSalaryCode] varchar(1) NOT NULL,
    [drvSalEffDate] datetime NULL,
    [drvMbrAddrOne] varchar(257) NULL,
    [drvMbrAddrTwo] varchar(255) NULL,
    [drvMbrCity] varchar(255) NULL,
    [drvMbrState] varchar(255) NULL,
    [drvMbrZipCode] varchar(5) NULL,
    [drvMbrZipPlusFour] varchar(1) NOT NULL,
    [drvHomePhone] varchar(12) NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvWorkPhoneExt] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(1) NOT NULL,
    [drvDateOfBenEligbility] datetime NULL,
    [drvSubsDateOfBen] nvarchar(4000) NULL,
    [drvReasonPriorLossBenElig] varchar(11) NOT NULL,
    [drvPriBeneFirstName] varchar(1) NOT NULL,
    [drvPriBeneLastName] varchar(1) NOT NULL,
    [drvPriBeneMiddleInit] varchar(1) NOT NULL,
    [drvPriBeneRelationship] varchar(1) NOT NULL,
    [drvPriBeneAddressOne] varchar(1) NOT NULL,
    [drvPriBeneAddressTwo] varchar(1) NOT NULL,
    [drvPriBeneCity] varchar(1) NOT NULL,
    [drvPriBeneState] varchar(1) NOT NULL,
    [drvPriBeneZipCode] varchar(1) NOT NULL,
    [drvPriBeneZipPlusFour] varchar(1) NOT NULL,
    [drvPriBeneSSN] varchar(1) NOT NULL,
    [drvCoBeneFirstName] varchar(1) NOT NULL,
    [drvCoBeneLastName] varchar(1) NOT NULL,
    [drvCoBeneMiddleInit] varchar(1) NOT NULL,
    [drvCoBeneRelationship] varchar(1) NOT NULL,
    [drvCoBeneAddressOne] varchar(1) NOT NULL,
    [drvCoBeneAddressTwo] varchar(1) NOT NULL,
    [drvCoBeneCity] varchar(1) NOT NULL,
    [drvCoBeneState] varchar(1) NOT NULL,
    [drvCoBeneZipCode] varchar(1) NOT NULL,
    [drvCoBeneZipPlusFour] varchar(1) NOT NULL,
    [drvCoBeneSSN] varchar(1) NOT NULL,
    [drvBeneficiaryComments] varchar(1) NOT NULL,
    [drvAccidentPolicyNumber] varchar(1) NOT NULL,
    [drvAccidentBillLocACNumber] varchar(1) NOT NULL,
    [drvAccidentSortGroup] varchar(1) NOT NULL,
    [drvAccidentEffDate] varchar(1) NOT NULL,
    [drvAccidentPlanCode] varchar(1) NOT NULL,
    [drvAccidentClassCode] varchar(1) NOT NULL,
    [drvAccidentTierCode] varchar(1) NOT NULL,
    [drvHealthAssesTier] varchar(1) NOT NULL,
    [drvHospitalTier] varchar(1) NOT NULL,
    [drvAccidentDisabilityAmt] varchar(1) NOT NULL,
    [drvAccidentDiTier] varchar(1) NOT NULL,
    [drvAccidentDiBenefitPeriod] varchar(1) NOT NULL,
    [drvAccidentDiElimPeriod] varchar(1) NOT NULL,
    [drvAccidentSicknessDisaAmt] varchar(1) NOT NULL,
    [drvAccidentSickTier] varchar(1) NOT NULL,
    [drvAccidentSickDiBenePer] varchar(1) NOT NULL,
    [drvAccidentSickDiElimPer] varchar(1) NOT NULL,
    [drvAccidentTermDate] varchar(1) NOT NULL,
    [drvCritIllnessPolicyNum] varchar(1) NOT NULL,
    [drvCritIllnessBillLocAC] varchar(1) NOT NULL,
    [drvCritIllnessSortGrp] varchar(1) NOT NULL,
    [drvCritIllnessEffDate] varchar(1) NOT NULL,
    [drvCritIllnessPlanCode] varchar(1) NOT NULL,
    [drvCritIllnessClassCode] varchar(1) NOT NULL,
    [drvCritIllnessTermDate] varchar(1) NOT NULL,
    [drvEePrincSumAmtApprove] varchar(1) NOT NULL,
    [drvEePrincSumAmtPend] varchar(1) NOT NULL,
    [drvSpPrincSumAmtApprove] varchar(1) NOT NULL,
    [drvSpPrincSumAmtPend] varchar(1) NOT NULL,
    [drvChPrincSumAmtApprove] varchar(1) NOT NULL,
    [drvChPrincSumAmtPend] varchar(1) NOT NULL,
    [drvEeHeartAmtApprove] varchar(1) NOT NULL,
    [drvEeHeartAmtPend] varchar(1) NOT NULL,
    [drvSpHeartAmtApprove] varchar(1) NOT NULL,
    [drvSpHeartAmtPend] varchar(1) NOT NULL,
    [drvChHeartAmtApprove] varchar(1) NOT NULL,
    [drvChHeartAmtPend] varchar(1) NOT NULL,
    [drvEeCancerAmtApprove] varchar(1) NOT NULL,
    [drvEeCancerAmtPend] varchar(1) NOT NULL,
    [drvSpCancerAmtApprove] varchar(1) NOT NULL,
    [drvSpCancerAmtPend] varchar(1) NOT NULL,
    [drvChCancerAmtApprove] varchar(1) NOT NULL,
    [drvChCancerAmtPend] varchar(1) NOT NULL,
    [drvEeOrganAmtApprove] varchar(1) NOT NULL,
    [drvEeOrganAmtPend] varchar(1) NOT NULL,
    [drvSpOrganAmtApprove] varchar(1) NOT NULL,
    [drvSpOrganAmtPend] varchar(1) NOT NULL,
    [drvChOrganAmtApprove] varchar(1) NOT NULL,
    [drvChOrganAmtPend] varchar(1) NOT NULL,
    [drvEeQualOfLifeAmtApprove] varchar(1) NOT NULL,
    [drvEeQualOfLifeAmtPend] varchar(1) NOT NULL,
    [drvSpQualOfLifeAmtApprove] varchar(1) NOT NULL,
    [drvSpQualOfLifeAmtPend] varchar(1) NOT NULL,
    [drvChQualOfLifeAmtApprove] varchar(1) NOT NULL,
    [drvChQualOfLifeAmtPend] varchar(1) NOT NULL,
    [drvChildCatAmtApprove] varchar(1) NOT NULL,
    [drvChildCatAmtPend] varchar(1) NOT NULL,
    [drvEeTreatmentCareYN] varchar(1) NOT NULL,
    [drvSpTreatmentCareYN] varchar(1) NOT NULL,
    [drvChTreatmentCareYN] varchar(1) NOT NULL,
    [drvEeDiYN] varchar(1) NOT NULL,
    [drvSpDiYN] varchar(1) NOT NULL,
    [drvEeAccidentYN] varchar(1) NOT NULL,
    [drvSpAccidentYN] varchar(1) NOT NULL,
    [drvChAccidentYN] varchar(1) NOT NULL,
    [drvEeOccHivYN] varchar(1) NOT NULL,
    [drvLifePolicyNumber] varchar(18) NULL,
    [drvLifeBillLocACNumber] varchar(7) NULL,
    [drvLifeSortGroup] varchar(1) NOT NULL,
    [drvLifeEffDate] datetime NULL,
    [drvLifePlanCode] varchar(1) NULL,
    [drvLifeClassCode] varchar(1) NULL,
    [drvLiCvgs] varchar(4) NULL,
    [drvLiTerminationDate] datetime NULL,
    [drvAdCvgs] varchar(4) NULL,
    [drvAdTerminationDate] datetime NULL,
    [drvDliCvgs] varchar(1) NOT NULL,
    [drvDliTerminationDate] varchar(1) NOT NULL,
    [drvDadCvgs] varchar(1) NOT NULL,
    [drvDadTerminationDate] varchar(1) NOT NULL,
    [drvOliCvgs] varchar(1) NOT NULL,
    [drvOliTerminationDate] varchar(1) NOT NULL,
    [drvOadCvgs] varchar(1) NOT NULL,
    [drvOadTerminationDate] varchar(1) NOT NULL,
    [drvOdliCvgs] varchar(1) NOT NULL,
    [drvOdliTerminationDate] varchar(1) NOT NULL,
    [drvOdadCvgs] varchar(1) NOT NULL,
    [drvOdadTerminationDate] varchar(1) NOT NULL,
    [drvSliCvgs] varchar(1) NOT NULL,
    [drvSliTerminationDate] varchar(1) NOT NULL,
    [drvSadCvgs] varchar(1) NOT NULL,
    [drvSadTerminationDate] varchar(1) NOT NULL,
    [drvCliCvgs] varchar(1) NOT NULL,
    [drvCliTerminationDate] varchar(1) NOT NULL,
    [drvOsliCvgs] varchar(1) NOT NULL,
    [drvOsliTerminationDate] varchar(1) NOT NULL,
    [drvOsadCvgs] varchar(1) NOT NULL,
    [drvOsadTerminationDate] varchar(1) NOT NULL,
    [drvOcliCvgs] varchar(1) NOT NULL,
    [drvOcliTerminationDate] varchar(1) NOT NULL,
    [drvWiPolicyNumber] varchar(18) NULL,
    [drvWiBillLocACNumber] varchar(7) NULL,
    [drvWiSortGroup] varchar(1) NOT NULL,
    [drvWiEffDate] datetime NULL,
    [drvWiPlanCode] varchar(1) NULL,
    [drvWiClassCode] varchar(1) NULL,
    [drvWiCvgs] varchar(4) NULL,
    [drvWiTerminationDate] datetime NULL,
    [drvOwiCvgs] varchar(1) NOT NULL,
    [drvOwiTerminationDate] varchar(1) NOT NULL,
    [drvLtdPolicyNum] varchar(18) NULL,
    [drvLtdBillLocACNum] varchar(7) NULL,
    [drvLtdSortGroup] varchar(1) NOT NULL,
    [drvLtdEffDate] datetime NULL,
    [drvLtdPlanCode] varchar(1) NULL,
    [drvLtdClassCode] varchar(1) NULL,
    [drvLtdCvgs] varchar(5) NULL,
    [drvLtdTerminationDate] datetime NULL,
    [drvOltdCvgs] varchar(1) NOT NULL,
    [drvOltdTerminationDate] varchar(1) NOT NULL,
    [drvCiCvgs] varchar(1) NOT NULL,
    [drvCiTerminationDate] varchar(1) NOT NULL,
    [drvDentPolicyNumber] varchar(18) NULL,
    [drvDentBillLocACNBR] varchar(7) NULL,
    [drvDentSortGroup] varchar(1) NOT NULL,
    [drvDentEff] nvarchar(4000) NULL,
    [drvDentPlanCode] varchar(1) NULL,
    [drvDentClassCode] varchar(1) NULL,
    [drvDentCoverageCode] varchar(1) NULL,
    [drvDentOtherIns] varchar(1) NULL,
    [drvDentTerminationDate] nvarchar(4000) NULL,
    [drvDhmoPolicyNumber] varchar(1) NOT NULL,
    [drvDhmoBillLocACNumber] varchar(1) NOT NULL,
    [drvDhmoSortGroup] varchar(1) NOT NULL,
    [drvDhmoEffDate] varchar(1) NOT NULL,
    [drvDhmoPlanCode] varchar(1) NOT NULL,
    [drvDhmoClassCode] varchar(1) NOT NULL,
    [drvDhmoCoverageTier] varchar(1) NOT NULL,
    [drvDhmoPcp] varchar(1) NOT NULL,
    [drvDhmoTerminationDate] varchar(1) NOT NULL,
    [drvLvcPolicyNumber] varchar(1) NOT NULL,
    [drvLvcBillLocACNumber] varchar(1) NOT NULL,
    [drvLvcSortGroup] varchar(1) NOT NULL,
    [drvLvcEffDate] varchar(1) NOT NULL,
    [drvLvcPlanCode] varchar(1) NOT NULL,
    [drvLvcClassCode] varchar(1) NOT NULL,
    [drvLvcCoverageTier] varchar(1) NOT NULL,
    [drvLvcOtherIns] varchar(1) NOT NULL,
    [drvLvcTerminationDate] varchar(1) NOT NULL,
    [drvVlvcPolicyNumber] varchar(18) NULL,
    [drvVlvcBillLocACNumber] varchar(7) NULL,
    [drvVlvcSortGroup] varchar(1) NOT NULL,
    [drvVlvcEffDate] datetime NULL,
    [drvVlvcPlanCode] varchar(1) NULL,
    [drvVlvcClassCode] varchar(1) NULL,
    [drvVlvcCoverageTier] varchar(1) NULL,
    [drvVlvcOtherIns] varchar(1) NULL,
    [drvVlvcTerminationDate] datetime NULL,
    [drvVdnPolicyNumber] varchar(1) NOT NULL,
    [drvVdnCillLocationACNum] varchar(1) NOT NULL,
    [drvVdnSortGroup] varchar(1) NOT NULL,
    [drvVdnEffDate] varchar(1) NOT NULL,
    [drvVdnPlanCode] varchar(1) NOT NULL,
    [drvVdnClassCode] varchar(1) NOT NULL,
    [drvVdnCoverageTier] varchar(1) NOT NULL,
    [drvVdnOtherIns] varchar(1) NOT NULL,
    [drvVdnTerminationDate] varchar(1) NOT NULL,
    [drvVdhmoPolicyNumber] varchar(1) NOT NULL,
    [drvVdhmoBillLocationACNum] varchar(1) NOT NULL,
    [drvVdhmoSortGroup] varchar(1) NOT NULL,
    [drvVdhmoEffDate] varchar(1) NOT NULL,
    [drvVdhmoPlanCode] varchar(1) NOT NULL,
    [drvVdhmoClassCode] varchar(1) NOT NULL,
    [drvVdhmoCoverageTier] varchar(1) NOT NULL,
    [drvVdhmoPcp] varchar(1) NOT NULL,
    [drvVdhmoTerminationDate] varchar(1) NOT NULL,
    [drvVlifPolicyNumber] varchar(18) NULL,
    [drvVlifBillLocationACNum] varchar(7) NULL,
    [drvVlifSortGroup] varchar(1) NOT NULL,
    [drvVlifEffDate] datetime NULL,
    [drvVlifPlanCode] varchar(1) NULL,
    [drvVlifClassCode] varchar(1) NULL,
    [drvVlifCvgs] nvarchar(4000) NULL,
    [drvVlifTerminationDate] datetime NULL,
    [drvVadCvgs] nvarchar(4000) NULL,
    [drvVadTerminationDate] datetime NULL,
    [drvVsliCvgs] nvarchar(4000) NULL,
    [drvVsliTerminationDate] datetime NULL,
    [drvVsadCvgs] nvarchar(4000) NULL,
    [drvVsadTerminationDate] datetime NULL,
    [drvVcliCvgs] nvarchar(4000) NULL,
    [drvVcliTerminationDate] datetime NULL,
    [drvVwiPolicyNumber] varchar(1) NOT NULL,
    [drvVwiBillLocationACNumber] varchar(1) NOT NULL,
    [drvVwiSortGroup] varchar(1) NOT NULL,
    [drvVwiEffDate] varchar(1) NOT NULL,
    [drvVwiPlanCode] varchar(1) NOT NULL,
    [drvVwiClassCode] varchar(1) NOT NULL,
    [drvVwiBenefitAmt] varchar(1) NOT NULL,
    [drvVwiElimPeriod] varchar(1) NOT NULL,
    [drvVwiBenefitDuration] varchar(1) NOT NULL,
    [drvVwiTerminationDate] varchar(1) NOT NULL,
    [drvVltdPolicyNumber] varchar(1) NOT NULL,
    [drvVltdBillLocationACNum] varchar(1) NOT NULL,
    [drvVltdSortGroup] varchar(1) NOT NULL,
    [drvVltdEffDate] varchar(1) NOT NULL,
    [drvVltdPlanCode] varchar(1) NOT NULL,
    [drvVltdClassCode] varchar(1) NOT NULL,
    [drvVltdBenefitAmt] varchar(1) NOT NULL,
    [drvVltdElimPeriod] varchar(1) NOT NULL,
    [drvVltdBenefitDuration] varchar(1) NOT NULL,
    [drvVltdBenefitPct] varchar(1) NOT NULL,
    [drvVltdTerminationDate] varchar(1) NOT NULL,
    [drvStadPolicyNumber] varchar(1) NOT NULL,
    [drvStadBillLocationACNum] varchar(1) NOT NULL,
    [drvStadSortGroup] varchar(1) NOT NULL,
    [drvStadEffDate] varchar(1) NOT NULL,
    [drvStadPlanCode] varchar(1) NOT NULL,
    [drvStadClassCode] varchar(1) NOT NULL,
    [drvStvadCvgs] varchar(1) NOT NULL,
    [drvStvadTerminationDate] varchar(1) NOT NULL,
    [drvStvsadCvgs] varchar(1) NOT NULL,
    [drvStvsadTerminationDate] varchar(1) NOT NULL,
    [drvStvcadCvgs] varchar(1) NOT NULL,
    [drvStvcadTerminationDate] varchar(1) NOT NULL,
    [drvQualifyingEventCode] varchar(1) NOT NULL,
    [drvQualifyingEventEffDate] varchar(1) NOT NULL,
    [drvMbrSmoker] varchar(1) NULL,
    [drvMbrSpouseSmoker] varchar(1) NOT NULL,
    [drvSpoudDateOfBirth] datetime NULL,
    [drvDepFirstName1] varchar(100) NULL,
    [drvDepLastName1] varchar(100) NULL,
    [drvDepMiddleInitial1] varchar(1) NULL,
    [drvDepGender1] char(1) NULL,
    [drvDepDateOfBirth1] datetime NULL,
    [drvDepRelationshipCode1] varchar(1) NULL,
    [drvDepStudentCode1] varchar(1) NULL,
    [drvDepDisabledYN1] char(1) NULL,
    [drvDepCvgIndicator1] varchar(5) NULL,
    [drvDedDhmoPcp1] varchar(1) NOT NULL,
    [drvDepFirstName2] varchar(100) NULL,
    [drvDepLastName2] varchar(100) NULL,
    [drvDepMiddleInitial2] varchar(1) NULL,
    [drvDepGender2] char(1) NULL,
    [drvDepDateOfBirth2] datetime NULL,
    [drvDepRelationshipCode2] varchar(1) NULL,
    [drvDepStudentCode2] varchar(1) NULL,
    [drvDepDisabledYN2] char(1) NULL,
    [drvDepCvgIndicator2] varchar(5) NULL,
    [drvDedDhmoPcp2] varchar(1) NOT NULL,
    [drvDepFirstName3] varchar(100) NULL,
    [drvDepLastName3] varchar(100) NULL,
    [drvDepMiddleInitial3] varchar(1) NULL,
    [drvDepGender3] char(1) NULL,
    [drvDepDateOfBirth3] datetime NULL,
    [drvDepRelationshipCode3] varchar(1) NULL,
    [drvDepStudentCode3] varchar(1) NULL,
    [drvDepDisabledYN3] char(1) NULL,
    [drvDepCvgIndicator3] varchar(5) NULL,
    [drvDedDhmoPcp3] varchar(1) NOT NULL,
    [drvDepFirstName4] varchar(100) NULL,
    [drvDepLastName4] varchar(100) NULL,
    [drvDepMiddleInitial4] varchar(1) NULL,
    [drvDepGender4] char(1) NULL,
    [drvDepDateOfBirth4] datetime NULL,
    [drvDepRelationshipCode4] varchar(1) NULL,
    [drvDepStudentCode4] varchar(1) NULL,
    [drvDepDisabledYN4] char(1) NULL,
    [drvDepCvgIndicator4] varchar(5) NULL,
    [drvDedDhmoPcp4] varchar(1) NOT NULL,
    [drvDepFirstName5] varchar(100) NULL,
    [drvDepLastName5] varchar(100) NULL,
    [drvDepMiddleInitial5] varchar(1) NULL,
    [drvDepGender5] char(1) NULL,
    [drvDepDateOfBirth5] datetime NULL,
    [drvDepRelationshipCode5] varchar(1) NULL,
    [drvDepStudentCode5] varchar(1) NULL,
    [drvDepDisabledYN5] char(1) NULL,
    [drvDepCvgIndicator5] varchar(5) NULL,
    [drvDedDhmoPcp5] varchar(1) NOT NULL,
    [drvDepFirstName6] varchar(100) NULL,
    [drvDepLastName6] varchar(100) NULL,
    [drvDepMiddleInitial6] varchar(1) NULL,
    [drvDepGender6] char(1) NULL,
    [drvDepDateOfBirth6] datetime NULL,
    [drvDepRelationshipCode6] varchar(1) NULL,
    [drvDepStudentCode6] varchar(1) NULL,
    [drvDepDisabledYN6] char(1) NULL,
    [drvDepCvgIndicator6] varchar(5) NULL,
    [drvDedDhmoPcp6] varchar(1) NOT NULL,
    [drvDepFirstName7] varchar(100) NULL,
    [drvDepLastName7] varchar(100) NULL,
    [drvDepMiddleInitial7] varchar(1) NULL,
    [drvDepGender7] char(1) NULL,
    [drvDepDateOfBirth7] datetime NULL,
    [drvDepRelationshipCode7] varchar(1) NULL,
    [drvDepStudentCode7] varchar(1) NULL,
    [drvDepDisabledYN7] char(1) NULL,
    [drvDepCvgIndicator7] varchar(5) NULL,
    [drvDedDhmoPcp7] varchar(1) NOT NULL,
    [drvDepFirstName8] varchar(100) NULL,
    [drvDepLastName8] varchar(100) NULL,
    [drvDepMiddleInitial8] varchar(1) NULL,
    [drvDepGender8] char(1) NULL,
    [drvDepDateOfBirth8] datetime NULL,
    [drvDepRelationshipCode8] varchar(1) NULL,
    [drvDepStudentCode8] varchar(1) NULL,
    [drvDepDisabledYN8] char(1) NULL,
    [drvDepCvgIndicator8] varchar(5) NULL,
    [drvDedDhmoPcp8] varchar(1) NOT NULL,
    [drvDepFirstName9] varchar(100) NULL,
    [drvDepLastName9] varchar(100) NULL,
    [drvDepMiddleInitial9] varchar(1) NULL,
    [drvDepGender9] char(1) NULL,
    [drvDepDateOfBirth9] datetime NULL,
    [drvDepRelationshipCode9] varchar(1) NULL,
    [drvDepStudentCode9] varchar(1) NULL,
    [drvDepDisabledYN9] char(1) NULL,
    [drvDepCvgIndicator9] varchar(5) NULL,
    [drvDedDhmoPcp9] varchar(1) NOT NULL,
    [drvDepFirstName10] varchar(100) NULL,
    [drvDepLastName10] varchar(100) NULL,
    [drvDepMiddleInitial10] varchar(1) NULL,
    [drvDepGender10] char(1) NULL,
    [drvDepDateOfBirth10] datetime NULL,
    [drvDepRelationshipCode10] varchar(1) NULL,
    [drvDepStudentCode10] varchar(1) NULL,
    [drvDepDisabledYN10] char(1) NULL,
    [drvDepCvgIndicator10] varchar(5) NULL,
    [drvDedDhmoPcp10] varchar(1) NOT NULL,
    [drvDepFirstName11] varchar(100) NULL,
    [drvDepLastName11] varchar(100) NULL,
    [drvDepMiddleInitial11] varchar(1) NULL,
    [drvDepGender11] char(1) NULL,
    [drvDepDateOfBirth11] datetime NULL,
    [drvDepRelationshipCode11] varchar(1) NULL,
    [drvDepStudentCode11] varchar(1) NULL,
    [drvDepDisabledYN11] char(1) NULL,
    [drvDepCvgIndicator11] varchar(5) NULL,
    [drvDedDhmoPcp11] varchar(1) NOT NULL,
    [drvDepFirstName12] varchar(100) NULL,
    [drvDepLastName12] varchar(100) NULL,
    [drvDepMiddleInitial12] varchar(1) NULL,
    [drvDepGender12] char(1) NULL,
    [drvDepDateOfBirth12] datetime NULL,
    [drvDepRelationshipCode12] varchar(1) NULL,
    [drvDepStudentCode12] varchar(1) NULL,
    [drvDepDisabledYN12] char(1) NULL,
    [drvDepCvgIndicator12] varchar(5) NULL,
    [drvDedDhmoPcp12] varchar(1) NOT NULL,
    [drvDepFirstName13] varchar(100) NULL,
    [drvDepLastName13] varchar(100) NULL,
    [drvDepMiddleInitial13] varchar(1) NULL,
    [drvDepGender13] char(1) NULL,
    [drvDepDateOfBirth13] datetime NULL,
    [drvDepRelationshipCode13] varchar(1) NULL,
    [drvDepStudentCode13] varchar(1) NULL,
    [drvDepDisabledYN13] char(1) NULL,
    [drvDepCvgIndicator13] varchar(5) NULL,
    [drvDedDhmoPcp13] varchar(1) NOT NULL,
    [drvDepFirstName14] varchar(100) NULL,
    [drvDepLastName14] varchar(100) NULL,
    [drvDepMiddleInitial14] varchar(1) NULL,
    [drvDepGender14] char(1) NULL,
    [drvDepDateOfBirth14] datetime NULL,
    [drvDepRelationshipCode14] varchar(1) NULL,
    [drvDepStudentCode14] varchar(1) NULL,
    [drvDepDisabledYN14] char(1) NULL,
    [drvDepCvgIndicator14] varchar(5) NULL,
    [drvDedDhmoPcp14] varchar(1) NOT NULL,
    [drvDepFirstName15] varchar(100) NULL,
    [drvDepLastName15] varchar(100) NULL,
    [drvDepMiddleInitial15] varchar(1) NULL,
    [drvDepGender15] char(1) NULL,
    [drvDepDateOfBirth15] datetime NULL,
    [drvDepRelationshipCode15] varchar(1) NULL,
    [drvDepStudentCode15] varchar(1) NULL,
    [drvDepDisabledYN15] char(1) NULL,
    [drvDepCvgIndicator15] varchar(5) NULL,
    [drvDedDhmoPcp15] varchar(1) NOT NULL
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
    [PdhVlifeEE] numeric NULL,
    [PdhVlifeCalcBasisCurAmt] numeric NULL,
    [PdhBlifeAmt] numeric NULL,
    [PdhStdAmt] numeric NULL,
    [PdhLtdAmt] numeric NULL
);
IF OBJECT_ID('U_ELINFINEXP_PEmpDed') IS NULL
CREATE TABLE [dbo].[U_ELINFINEXP_PEmpDed] (
    [EedEEID] char(12) NOT NULL,
    [EedVlifeAmt] numeric NULL,
    [EedVlifsAmt] numeric NULL,
    [EedVlifcAmt] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINFINEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Diamond Healthcare

Created By: James Bender
Business Analyst: Lea King
Create Date: 11/08/2019
Service Request Number: SR-2019-00245093

Purpose: Lincoln Financial Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELINFINEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELINFINEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELINFINEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELINFINEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELINFINEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINFINEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINFINEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINFINEXP', 'OEACTIVE';

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
            ,@EndPerControl     VARCHAR(9)
            ,@FileMinCovDate    DATETIME;;

    DECLARE @DedBenCodes table (Code varchar(4));
    Insert Into @DedBenCodes VALUES ('DEN1'), ('DEN2'), ('VIS'), ('VLIS'), ('VLIC')

    DECLARE @DepRelCodes table (Code varchar(3));
    INSERT INTO @DepRelCodes VALUES ('DIS'), ('CHL'), ('DPC'), ('STC'), ('SPS'), ('DP')
    
    -- Set FormatCode
    SELECT @FormatCode = 'ELINFINEXP';
    SELECT @FileMinCovDate = CAST('9/1/2019' as DATETIME);

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

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BLIFE, DEN1, DEN2, LTD, STD, VIS, VLIFC, VLIFE, VLIFS';

    IF OBJECT_ID('U_ELINFINEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELINFINEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELINFINEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

        -- XXX

    --==========================================
    -- Create audit tables
    --==========================================
    IF OBJECT_ID('U_ELINFINEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELINFINEXP_AuditFields;
    CREATE TABLE dbo.U_ELINFINEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ELINFINEXP_AuditFields VALUES ('empcomp','eecemplstatus');   
    --INSERT INTO dbo.U_ELINFINEXP_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_ELINFINEXP_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    --INSERT INTO dbo.U_ELINFINEXP_AuditFields VALUES ('DepBPlan','DbnBenStartDate');
    --INSERT INTO dbo.U_ELINFINEXP_AuditFields VALUES ('DepBPlan','DbnBenStopDate');
    --INSERT INTO dbo.U_ELINFINEXP_AuditFields VALUES ('DepBPlan','DbnBenStatusDate');
    -- Create audit table
    IF OBJECT_ID('U_ELINFINEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELINFINEXP_Audit;
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
    INTO dbo.U_ELINFINEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ELINFINEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ELINFINEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ELINFINEXP_Audit ON dbo.U_ELINFINEXP_Audit (audKey1Value, audKey2Value);



    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;
    
    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes', @DedList);
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

     /*UPDATE dbo.U_dsi_bdm_ELINFINEXP
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ELINFINEXP
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;*/

    PRINT 'Updates Field1'
    UPDATE dbo.U_dsi_bdm_ELINFINEXP -- WTF 1
    --SET BdmUSGField1 = CONVERT(VARCHAR(20), EedBenAmt)
        SET BdmUSGField1 = FORMAT(EedBenAmt, '#0')
    FROM dbo.U_dsi_bdm_ELINFINEXP
    JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedDedCode = BdmDedCode
    WHERE BDMDEDCODE = 'VLIFE'

    PRint @@ROWCOUNT

    PRINT 'Updates Done'

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
        ,PdhVlifeEE     = SUM(CASE WHEN PdhDedCode IN ('VLIFE') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhVlifeCalcBasisCurAmt    = SUM(CASE WHEN PdhDedCode IN ('VLIFE') THEN PdhDedCalcBasisAmt ELSE 0.00 END)   
        ,PdhBlifeAmt = MAX(CASE WHEN PdhDedCode IN ('BLIFE') THEN PdhDedCalcBasisAmt ELSE 0.00 END)   
        ,PdhStdAmt = MAX(CASE WHEN PdhDedCode IN ('STD') THEN PdhDedCalcBasisAmt ELSE 0.00 END)  
        ,PdhLtdAmt = MAX(CASE WHEN PdhDedCode IN ('LTD') THEN PdhDedCalcBasisAmt ELSE 0.00 END)   
--        ,PdhVlifeAmt = MAX(CASE WHEN PdhDedCode IN ('VLIFE') THEN PdhBenAmt ELSE 0.00 END) 
--        ,PdhVlifsAmt = MAX(CASE WHEN PdhDedCode IN ('VLIFS') THEN PdhBenAmt ELSE 0.00 END) 
--        ,PdhVlifcAmt = MAX(CASE WHEN PdhDedCode IN ('VLIFC') THEN PdhBenAmt ELSE 0.00 END) 
    INTO dbo.U_ELINFINEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ELINFINEXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    IF OBJECT_ID('dbo.U_ELINFINEXP_PEmpDed','U') IS NOT NULL 
        DROP TABLE dbo.U_ELINFINEXP_PEmpDed;
    SELECT DISTINCT
         EedEEID
        ,EedVlifeAmt = MAX(CASE WHEN EedDedCode IN ('VLIFE') THEN EedBenAmt ELSE 0.00 END) 
        ,EedVlifsAmt = MAX(CASE WHEN EedDedCode IN ('VLIFS') THEN EedBenAmt ELSE 0.00 END) 
        ,EedVlifcAmt = MAX(CASE WHEN EedDedCode IN ('VLIFC') THEN EedBenAmt ELSE 0.00 END) 
    INTO dbo.U_ELINFINEXP_PEmpDed
    FROM dbo.EmpDed A WITH (NOLOCK)
    JOIN dbo.U_ELINFINEXP_DedList WITH (NOLOCK)
        ON DedCode = EedDedCode
    JOIN dbo.U_ELINFINEXP_EEList WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        --Where EedEEID IN ('CV72L6001020','CY2KEK000020','D0DW85000020', '9GPY600000K0','9GPXYO0020K0')
    GROUP BY EedEEID
    ;

    IF OBJECT_ID('U_ELINFINEXP_BdmDepRecID', 'U') IS NOT NULL -- JCB
        DROP TABLE dbo.U_ELINFINEXP_BdmDepRecID;
    SELECT DISTINCT BdmDepRecID
    INTO dbo.U_ELINFINEXP_BdmDepRecID
    FROM dbo.U_dsi_BDM_ELINFINEXP WITH (NOLOCK)
    WHERE BdmRecType = 'DEP'
    ;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELINFINEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELINFINEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELINFINEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvChangeDate = '' /*    CASE WHEN EecDateOfLastHire BETWEEN @StartDate AND @EndDate THEN '' ELSE
                                CASE WHEN (select MAX(edhEffDate) from EmpHDed where edhBenStatus = 'A' and edhEEId = xEEID AND EdhDedCode IN ('BLIFE','DEN1','DEN2','LTD','STD','VIS','VLIFC','VLIFE','VLIFS')) < '9/1/2019' THEN '09/01/2019' -- jcb
                                    ELSE FORMAT((select MAX(edhEffDate) from EmpHDed where edhBenStatus = 'A' and edhEEId = xEEID AND EdhDedCode IN ('BLIFE','DEN1','DEN2','LTD','STD','VIS','VLIFC','VLIFE','VLIFS')), 'MM/dd/yyyy')
                                END
                            END*/
        ,drvDepChangeDate = '' /* CASE WHEN EecDateOfLastHire BETWEEN @StartDate AND @EndDate THEN '' 
                                ELSE FORMAT((SELECT TOP 1 AudDateTime FROM dbo.U_ELINFINEXP_Audit WITH (NOLOCK) WHERE audKey1Value = xEEID AND audFieldName = 'DbnBenStatus' AND audKey2Value IN ('DEN1', 'DEN2', 'VIS', 'VLIFC', 'VLIFE', 'VLIFS')), 'MM/dd/yyyy')
                            END*/
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN (select MAX(BdmStopDate) from dbo.U_dsi_bdm_ELINFINEXP where BdmEEID = xEEID) END 
        ,drvMbrFirstName = EepNameFirst
        ,drvMbrLastName = EepNameLast
        ,drvMbrMiddleInitial =ISNULL(LEFT(EepNameMiddle,1), '')
        ,drvMbrSSN = LEFT(RTRIM(LTRIM(eepSSN)), 3) + '-' + RIGHT(LEFT(RTRIM(LTRIM(eepSSN)), 5), 2) + '-' + RIGHT(RTRIM(LTRIM(eepSSN)), 4)
        ,drvMbrGender = EepGender
        ,drvMbrDateOfBirth = EepDateOfBirth
        ,drvAppSignDate =    CASE WHEN (select MIN(edhEffDate) from EmpHDed where edhBenStatus = 'A' and edhEEId = xEEID) < '9/1/2019' THEN '09/01/2019'
                                ELSE 
                                    CASE WHEN (select MIN(edhEffDate) from EmpHDed where edhBenStatus = 'A' and edhEEId = xEEID) < EecDateOfLastHire THEN FORMAT(EecDateOfLastHire, 'MM/dd/yyyy')
                                        ELSE FORMAT((select MIN(edhEffDate) from EmpHDed where edhBenStatus = 'A' and edhEEId = xEEID), 'MM/dd/yyyy')
                                    END
                            END
        ,drvOccupation = jbcDesc -- eecJobTitle
        ,drvHourPerWeek =    CASE WHEN (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) = 'B' THEN 
                                CASE WHEN CONVERT(NUMERIC(4,2), eecScheduledWorkHrs/2) < 30 AND EecEmplStatus = 'L' THEN '30.00'
                                    ELSE CAST((CONVERT(NUMERIC(4,2), eecScheduledWorkHrs/2)) AS VARCHAR) 
                                END
                            END
        ,drvSalaryAmt = eecAnnSalary 
        ,drvSalaryCode = 'A'
        ,drvSalEffDate = CASE
                                WHEN ISNULL(BLIFE_BenStartdate, '') <> '' THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, BLIFE_BenStartdate, eecDateOfLastHire)
                                WHEN ISNULL(DEN1_BenStartdate, '') <> '' THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, DEN1_BenStartdate, eecDateOfLastHire)
                                WHEN ISNULL(DEN2_BenStartdate, '') <> '' THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, DEN2_BenStartdate, eecDateOfLastHire)
                                WHEN ISNULL(LTD_BenStartdate, '') <> '' THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, LTD_BenStartdate, eecDateOfLastHire)
                                WHEN ISNULL(STD_BenStartdate, '') <> '' THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, STD_BenStartdate, eecDateOfLastHire)
                                WHEN ISNULL(VIS_BenStartdate, '') <> '' THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, VIS_BenStartdate, eecDateOfLastHire)
                                WHEN ISNULL(VLIFC_BenStartdate, '') <> '' THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, VLIFC_BenStartdate, eecDateOfLastHire)
                                WHEN ISNULL(VLIFE_BenStartdate, '') <> '' THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, VLIFE_BenStartdate, eecDateOfLastHire)
                                WHEN ISNULL(VLIFS_BenStartdate, '') <> '' THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, VLIFS_BenStartdate, eecDateOfLastHire)
                            END
        ,drvMbrAddrOne = '"' + eepAddressLine1 + '"'
        ,drvMbrAddrTwo = eepAddressLine2
        ,drvMbrCity = EepAddressCity
        ,drvMbrState = EepAddressState
        ,drvMbrZipCode = LEFT(EepAddressZipCode, 5)
        ,drvMbrZipPlusFour = ''
        ,drvHomePhone = CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN LEFT(EepPhoneHomeNumber, 3) + '-' + RIGHT(LEFT(EepPhoneHomeNumber, 6), 3) + '-' + RIGHT(EepPhoneHomeNumber, 4) END
        ,drvWorkPhone = ''
        ,drvWorkPhoneExt = ''
        ,drvEmailAddress = ''
        ,drvDateOfBenEligbility = eecDateOfOriginalHire
        ,drvSubsDateOfBen = CASE WHEN eecDateOfOriginalHire != eecDateOfLastHire THEN FORMAT(eecDateOfLastHire, 'MM/dd/yyyy') ELSE '' END
        ,drvReasonPriorLossBenElig = CASE WHEN EecDateOfOriginalHire != EecDateOfLastHire THEN 'TERMINATION' ELSE '' END
        ,drvPriBeneFirstName = ''
        ,drvPriBeneLastName = ''
        ,drvPriBeneMiddleInit = ''
        ,drvPriBeneRelationship = ''
        ,drvPriBeneAddressOne = ''
        ,drvPriBeneAddressTwo = ''
        ,drvPriBeneCity = ''
        ,drvPriBeneState = ''
        ,drvPriBeneZipCode = ''
        ,drvPriBeneZipPlusFour = ''
        ,drvPriBeneSSN = '' 
        ,drvCoBeneFirstName = ''
        ,drvCoBeneLastName = ''
        ,drvCoBeneMiddleInit = ''
        ,drvCoBeneRelationship = ''
        ,drvCoBeneAddressOne = ''
        ,drvCoBeneAddressTwo = ''
        ,drvCoBeneCity = ''
        ,drvCoBeneState = ''
        ,drvCoBeneZipCode = ''
        ,drvCoBeneZipPlusFour = ''
        ,drvCoBeneSSN = ''
        ,drvBeneficiaryComments = ''
        ,drvAccidentPolicyNumber = ''
        ,drvAccidentBillLocACNumber = ''
        ,drvAccidentSortGroup = ''
        ,drvAccidentEffDate = ''
        ,drvAccidentPlanCode = ''
        ,drvAccidentClassCode = ''
        ,drvAccidentTierCode = ''
        ,drvHealthAssesTier = ''
        ,drvHospitalTier = ''
        ,drvAccidentDisabilityAmt = ''
        ,drvAccidentDiTier = ''
        ,drvAccidentDiBenefitPeriod = ''
        ,drvAccidentDiElimPeriod = ''
        ,drvAccidentSicknessDisaAmt = ''
        ,drvAccidentSickTier = ''
        ,drvAccidentSickDiBenePer = ''
        ,drvAccidentSickDiElimPer = ''
        ,drvAccidentTermDate = ''
        ,drvCritIllnessPolicyNum = ''
        ,drvCritIllnessBillLocAC = ''
        ,drvCritIllnessSortGrp = ''
        ,drvCritIllnessEffDate = ''
        ,drvCritIllnessPlanCode = ''
        ,drvCritIllnessClassCode = ''
        ,drvCritIllnessTermDate = '' 
        ,drvEePrincSumAmtApprove = ''
        ,drvEePrincSumAmtPend = ''
        ,drvSpPrincSumAmtApprove = ''
        ,drvSpPrincSumAmtPend = ''
        ,drvChPrincSumAmtApprove = ''
        ,drvChPrincSumAmtPend = ''
        ,drvEeHeartAmtApprove = ''
        ,drvEeHeartAmtPend = ''
        ,drvSpHeartAmtApprove = ''
        ,drvSpHeartAmtPend = ''
        ,drvChHeartAmtApprove = ''
        ,drvChHeartAmtPend = ''
        ,drvEeCancerAmtApprove = ''
        ,drvEeCancerAmtPend = ''
        ,drvSpCancerAmtApprove = ''
        ,drvSpCancerAmtPend = ''
        ,drvChCancerAmtApprove = ''
        ,drvChCancerAmtPend = ''
        ,drvEeOrganAmtApprove = ''
        ,drvEeOrganAmtPend = ''
        ,drvSpOrganAmtApprove = ''
        ,drvSpOrganAmtPend = ''
        ,drvChOrganAmtApprove = ''
        ,drvChOrganAmtPend = ''
        ,drvEeQualOfLifeAmtApprove = ''
        ,drvEeQualOfLifeAmtPend = ''
        ,drvSpQualOfLifeAmtApprove = ''
        ,drvSpQualOfLifeAmtPend = ''
        ,drvChQualOfLifeAmtApprove = ''
        ,drvChQualOfLifeAmtPend = ''
        ,drvChildCatAmtApprove = ''
        ,drvChildCatAmtPend = ''
        ,drvEeTreatmentCareYN = ''
        ,drvSpTreatmentCareYN = ''
        ,drvChTreatmentCareYN = ''
        ,drvEeDiYN = ''
        ,drvSpDiYN = ''
        ,drvEeAccidentYN = ''
        ,drvSpAccidentYN = ''
        ,drvChAccidentYN = ''
        ,drvEeOccHivYN = '' 
        ,drvLifePolicyNumber = CASE WHEN BLIFE_DedCode = 'BLIFE' THEN  '000010255392-00000' END
        ,drvLifeBillLocACNumber = CASE WHEN BLIFE_DedCode = 'BLIFE' THEN  '1630544' END
        ,drvLifeSortGroup = ''        
        ,drvLifeEffDate = CASE WHEN BLIFE_DedCode = 'BLIFE' THEN dbo.dsi_fnGetMinMaxDates('MAX', BLIFE_BenStartdate, @FileMinCovDate) END
        ,drvLifePlanCode = CASE WHEN BLIFE_DedCode = 'BLIFE' THEN  '1' END
        ,drvLifeClassCode = CASE WHEN BLIFE_DedCode = 'BLIFE' THEN  '1' END
        ,drvLiCvgs = CASE WHEN BLIFE_DedCode = 'BLIFE' THEN 'LI-1' END-- + CAST(FLOOR((PdhBlifeAmt+999)/1000)*1000 AS VARCHAR) END 
        ,drvLiTerminationDate = CASE WHEN BLIFE_DedCode = 'BLIFE' THEN BLIFE_BenStopDate END       
        ,drvAdCvgs = CASE WHEN BLIFE_DedCode = 'BLIFE' THEN 'AD-1' END --+ CAST(FLOOR((PdhBlifeAmt+999)/1000)*1000 AS VARCHAR) END 
        ,drvAdTerminationDate = CASE WHEN BLIFE_DedCode = 'BLIFE' THEN BLIFE_BenStopDate END
        ,drvDliCvgs = ''
        ,drvDliTerminationDate = ''
        ,drvDadCvgs = ''
        ,drvDadTerminationDate = ''
        ,drvOliCvgs = ''
        ,drvOliTerminationDate = ''
        ,drvOadCvgs = ''
        ,drvOadTerminationDate = ''
        ,drvOdliCvgs = ''
        ,drvOdliTerminationDate = ''
        ,drvOdadCvgs = ''
        ,drvOdadTerminationDate = ''
        ,drvSliCvgs = ''
        ,drvSliTerminationDate = ''
        ,drvSadCvgs = ''
        ,drvSadTerminationDate = ''
        ,drvCliCvgs = ''
        ,drvCliTerminationDate = ''
        ,drvOsliCvgs = ''
        ,drvOsliTerminationDate = ''
        ,drvOsadCvgs = ''
        ,drvOsadTerminationDate = ''
        ,drvOcliCvgs = ''
        ,drvOcliTerminationDate = ''
        ,drvWiPolicyNumber = CASE WHEN STD_DedCode = 'STD' THEN  '000010255394-00000' END
        ,drvWiBillLocACNumber = CASE WHEN STD_DedCode = 'STD' THEN  '1630544' END
        ,drvWiSortGroup = ''        
        ,drvWiEffDate = CASE WHEN STD_DedCode = 'STD' THEN dbo.dsi_fnGetMinMaxDates('MAX',STD_BenStartdate, @FileMinCovDate)  END
        ,drvWiPlanCode = CASE WHEN STD_DedCode = 'STD' THEN '1' END
        ,drvWiClassCode = CASE WHEN STD_DedCode = 'STD' THEN  '1' END
        ,drvWiCvgs = CASE WHEN STD_DedCode = 'STD' THEN 'WI-1' END --+ FORMAT(ROUND(PdhStdAmt, 2), '##') END 
        ,drvWiTerminationDate = CASE WHEN STD_DedCode = 'STD' THEN STD_BenStopDate END
        ,drvOwiCvgs = ''
        ,drvOwiTerminationDate = ''
        ,drvLtdPolicyNum = CASE WHEN LTD_DedCode = 'LTD' THEN  '000010255393-00000' END 
        ,drvLtdBillLocACNum = CASE WHEN LTD_DedCode = 'LTD' THEN  '1630544' END
        ,drvLtdSortGroup = ''
        ,drvLtdEffDate = CASE WHEN LTD_DedCode = 'LTD' THEN dbo.dsi_fnGetMinMaxDates('MAX', LTD_BenStartdate, @FileMinCovDate)  END
        ,drvLtdPlanCode = CASE WHEN LTD_DedCode = 'LTD' THEN  '1' END
        ,drvLtdClassCode = CASE WHEN LTD_DedCode = 'LTD' THEN  '1' END
        ,drvLtdCvgs = CASE WHEN LTD_DedCode = 'LTD' THEN 'LTD-1' END -- + FORMAT(ROUND(PdhLtdAmt, 2), '##') END 
        ,drvLtdTerminationDate = CASE WHEN LTD_DedCode = 'LTD' THEN LTD_BenStopDate END
        ,drvOltdCvgs = ''
        ,drvOltdTerminationDate = ''
        ,drvCiCvgs = ''
        ,drvCiTerminationDate = ''
        ,drvDentPolicyNumber = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL THEN '00001D039852-00000' END
        ,drvDentBillLocACNBR = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL THEN '1630544' END
        ,drvDentSortGroup = ''        
        ,drvDentEff = CASE WHEN DEN1_DedCode IS NOT NULL THEN FORMAT(dbo.dsi_fnGetMinMaxDates('MAX',DEN1_BenStartDate, @FileMinCovDate), 'MM/dd/yyyy')
                                        WHEN DEN2_DedCode IS NOT NULL  THEN  FORMAT(dbo.dsi_fnGetMinMaxDates('MAX',DEN2_BenStartDate, @FileMinCovDate), 'MM/dd/yyyy') 
                                    END
        ,drvDentPlanCode =    CASE 
                                WHEN (DEN1_DedCode IS NOT NULL) THEN '1'
                                WHEN (DEN2_DedCode IS NOT NULL) THEN '2'
                            END
        ,drvDentClassCode = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL THEN '1' END
        ,drvDentCoverageCode =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL THEN -- ??? typo This should be coverage tier
                                    CASE 
                                        WHEN DEN1_DedOption in ('EE') OR DEN2_DedOption in ('EE') THEN '1'
                                        WHEN DEN1_DedOption in ('EES', 'EEDP', 'EEO') OR DEN2_DedOption in ('EES', 'EEDP', 'EEO') THEN '2'
                                        WHEN DEN1_DedOption in ('EEC', 'EEF', 'EEDPF') OR DEN2_DedOption in ('EEC', 'EEF', 'EEDPF') THEN '3'
                                        ELSE '4'
                                    END
                                END
        ,drvDentOtherIns = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL THEN 'U' END
        ,drvDentTerminationDate =    CASE WHEN DEN1_DedCode IS NOT NULL THEN FORMAT(DEN1_BenStopDate, 'MM/dd/yyyy') -- 2/26
                                        WHEN DEN2_DedCode IS NOT NULL  THEN FORMAT(DEN2_BenStopDate, 'MM/dd/yyyy') 
                                    END
        ,drvDhmoPolicyNumber = ''
        ,drvDhmoBillLocACNumber = ''
        ,drvDhmoSortGroup = ''
        ,drvDhmoEffDate = ''
        ,drvDhmoPlanCode = ''
        ,drvDhmoClassCode = ''
        ,drvDhmoCoverageTier = ''
        ,drvDhmoPcp = ''
        ,drvDhmoTerminationDate = ''
        ,drvLvcPolicyNumber = ''
        ,drvLvcBillLocACNumber = ''
        ,drvLvcSortGroup = ''
        ,drvLvcEffDate = ''
        ,drvLvcPlanCode = ''
        ,drvLvcClassCode = ''
        ,drvLvcCoverageTier = ''
        ,drvLvcOtherIns = ''
        ,drvLvcTerminationDate = ''
        ,drvVlvcPolicyNumber = CASE WHEN VIS_DedCode = 'VIS' THEN  '000400255395-00000' END 
        ,drvVlvcBillLocACNumber = CASE WHEN VIS_DedCode = 'VIS' THEN  '1630544' END
        ,drvVlvcSortGroup = ''        
        ,drvVlvcEffDate = CASE WHEN VIS_DedCode = 'VIS' THEN dbo.dsi_fnGetMinMaxDates('MAX',VIS_BenStartdate, @FileMinCovDate)  END
        ,drvVlvcPlanCode = CASE WHEN VIS_DedCode = 'VIS' THEN  '1' END
        ,drvVlvcClassCode = CASE WHEN VIS_DedCode = 'VIS' THEN  '1' END
        ,drvVlvcCoverageTier =    CASE WHEN VIS_DedCode = 'VIS' THEN 
                                    CASE 
                                        WHEN VIS_DedOption in ('EE') THEN '1'
                                        WHEN VIS_DedOption in ('EEO', 'EES', 'EEDP') THEN '2'
                                        WHEN VIS_DedOption in ('EEC', 'EEF', 'EEDPF') THEN '3'
                                        ELSE '4'
                                    END
                                END
        ,drvVlvcOtherIns = CASE WHEN VIS_DedCode = 'VIS' THEN 'U' END
        ,drvVlvcTerminationDate = CASE WHEN VIS_DedCode = 'VIS' THEN VIS_BenStopDate END
        ,drvVdnPolicyNumber = ''
        ,drvVdnCillLocationACNum = ''
        ,drvVdnSortGroup = ''
        ,drvVdnEffDate = ''
        ,drvVdnPlanCode = ''
        ,drvVdnClassCode = ''
        ,drvVdnCoverageTier = ''
        ,drvVdnOtherIns = ''
        ,drvVdnTerminationDate = ''
        ,drvVdhmoPolicyNumber = ''
        ,drvVdhmoBillLocationACNum = ''
        ,drvVdhmoSortGroup = ''
        ,drvVdhmoEffDate = ''
        ,drvVdhmoPlanCode = ''
        ,drvVdhmoClassCode = ''
        ,drvVdhmoCoverageTier = ''
        ,drvVdhmoPcp = ''
        ,drvVdhmoTerminationDate = ''
        ,drvVlifPolicyNumber = CASE WHEN VLIFE_DedCode = 'VLIFE' THEN  '000400001000-25450' END 
        ,drvVlifBillLocationACNum = CASE WHEN VLIFE_DedCode = 'VLIFE' THEN  '1630544' END
        ,drvVlifSortGroup = ''        
        ,drvVlifEffDate = CASE WHEN VLIFE_DedCode = 'VLIFE' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStartdate, @FileMinCovDate)  END
        ,drvVlifPlanCode = CASE WHEN VLIFE_DedCode = 'VLIFE' THEN  '1' END
        ,drvVlifClassCode =    CASE WHEN VLIFE_DedCode = 'VLIFE' THEN
                                CASE WHEN EepUDField07 = '2' THEN '2' ELSE  '1' END -- JCB
                            END
        ,drvVlifCvgs = CASE WHEN VLIFE_DedCode = 'VLIFE' THEN 'VLI-' + FORMAT(EedVlifeAmt, '#0') END 
        ,drvVlifTerminationDate = CASE WHEN VLIFE_DedCode= 'VLIFE' THEN VLIFE_BenStopDate END
        ,drvVadCvgs = CASE WHEN VLIFE_DedCode = 'VLIFE' THEN  'VAD-' + FORMAT(EedVlifeAmt, '#0') END  
        ,drvVadTerminationDate = CASE WHEN VLIFE_DedCode = 'VLIFE' THEN VLIFE_BenStopDate END         
        ,drvVsliCvgs = CASE WHEN VLIFS_DedCode = 'VLIFS' THEN 'VSLI-' + FORMAT(EedVlifsAmt , '##') END 
        ,drvVsliTerminationDate = CASE WHEN VLIFS_DedCode  = 'VLIFS' THEN VLIFS_BenStopDate END
        ,drvVsadCvgs = CASE WHEN VLIFS_DedCode = 'VLIFS' THEN 'VSAD-' + FORMAT(EedVlifsAmt, '##') END 
        ,drvVsadTerminationDate = CASE WHEN VLIFE_DedCode = 'VLIFE' THEN VLIFE_BenStopDate END
        ,drvVcliCvgs = CASE WHEN VLIFC_DedCode = 'VLIFC' THEN 'VCLI-' + FORMAT(EedVlifcAmt, '##') END 
        ,drvVcliTerminationDate = CASE WHEN VLIFC_DedCode = 'VLIFC' THEN VLIFC_BenStopDate END
        ,drvVwiPolicyNumber = ''
        ,drvVwiBillLocationACNumber = ''
        ,drvVwiSortGroup = ''
        ,drvVwiEffDate = ''
        ,drvVwiPlanCode = ''
        ,drvVwiClassCode = ''
        ,drvVwiBenefitAmt = ''
        ,drvVwiElimPeriod = ''
        ,drvVwiBenefitDuration = ''
        ,drvVwiTerminationDate = ''
        ,drvVltdPolicyNumber = ''
        ,drvVltdBillLocationACNum = ''
        ,drvVltdSortGroup = ''
        ,drvVltdEffDate = ''
        ,drvVltdPlanCode = ''
        ,drvVltdClassCode = ''
        ,drvVltdBenefitAmt = ''
        ,drvVltdElimPeriod = ''
        ,drvVltdBenefitDuration = ''
        ,drvVltdBenefitPct = ''
        ,drvVltdTerminationDate = ''
        ,drvStadPolicyNumber = ''
        ,drvStadBillLocationACNum = ''
        ,drvStadSortGroup = ''
        ,drvStadEffDate = ''
        ,drvStadPlanCode = ''
        ,drvStadClassCode = ''
        ,drvStvadCvgs = ''
        ,drvStvadTerminationDate = ''
        ,drvStvsadCvgs = ''
        ,drvStvsadTerminationDate = ''
        ,drvStvcadCvgs = ''
        ,drvStvcadTerminationDate = ''
        ,drvQualifyingEventCode = ''
        ,drvQualifyingEventEffDate = ''
        ,drvMbrSmoker = EepIsSmoker
        -- Spouse
        ,drvMbrSpouseSmoker = ISNULL(ConIsSmoker, 'N') --CASE WHEN ConRelationship in ('SPS', 'DP') THEN ISNULL(ConIsSmoker, 'N') END
        ,drvSpoudDateOfBirth = ConDateOfBirth --CASE WHEN ConRelationship in ('SPS', 'DP') THEN ConDateOfBirth END -- JCB
        -- Dependant Start
        ,drvDepFirstName1 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName1 END
        ,drvDepLastName1 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName1 END
        ,drvDepMiddleInitial1 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit1 END
        ,drvDepGender1 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender1 END
        ,drvDepDateOfBirth1 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth1 END
        ,drvDepRelationshipCode1 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship1 END
        ,drvDepStudentCode1 =    CASE WHEN DepFirstName1 IS NOT NULL THEN CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode1 END END
        ,drvDepDisabledYN1 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled1 END

        ,drvDepCvgIndicator1 =    CASE WHEN DepFirstName1 IS NOT NULL THEN -- JCB
                                    CASE WHEN (DEN1_Dep_DedCode1 IS NOT NULL OR DEN2_Dep_DedCode1 IS NOT NULL) AND VIS_Dep_DedCode1 IS NOT NULL THEN '"D,V"' 
                                        WHEN (DEN1_Dep_DedCode1 IS NOT NULL OR DEN2_Dep_DedCode1 IS NOT NULL) AND VIS_Dep_DedCode1 IS NULL THEN 'D' 
                                        WHEN (DEN1_Dep_DedCode1 IS NULL AND DEN2_Dep_DedCode1 IS NULL) AND VIS_Dep_DedCode1 IS NOT NULL THEN 'V' 
                                    END 
                                END

        ,drvDedDhmoPcp1 = ''  
        ,drvDepFirstName2 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName2 END
        ,drvDepLastName2 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName2 END
        ,drvDepMiddleInitial2 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit2 END
        ,drvDepGender2 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender2 END
        ,drvDepDateOfBirth2 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth2 END
        ,drvDepRelationshipCode2 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship2 END
        ,drvDepStudentCode2 = CASE WHEN DepFirstName2 IS NOT NULL THEN  CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode2 END END
        ,drvDepDisabledYN2 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled2 END
        ,drvDepCvgIndicator2 =    CASE WHEN DepFirstName2 IS NOT NULL THEN 
                                    CASE WHEN (DEN1_Dep_DedCode2 IS NOT NULL OR DEN2_Dep_DedCode2 IS NOT NULL) AND VIS_Dep_DedCode2 IS NOT NULL THEN '"D,V"' WHEN (DEN1_Dep_DedCode2 IS NOT NULL OR DEN2_Dep_DedCode2 IS NOT NULL) AND VIS_Dep_DedCode2 IS NULL THEN 'D' WHEN (DEN1_Dep_DedCode2 IS NULL AND DEN2_Dep_DedCode2 IS NULL) AND VIS_Dep_DedCode2 IS NOT NULL THEN 'V' END
                                END
        ,drvDedDhmoPcp2 = ''  
        ,drvDepFirstName3 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName3 END
        ,drvDepLastName3 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName3 END
        ,drvDepMiddleInitial3 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit3 END
        ,drvDepGender3 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender3 END
        ,drvDepDateOfBirth3 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth3 END
        ,drvDepRelationshipCode3 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship3 END
        ,drvDepStudentCode3 = CASE WHEN DepFirstName3 IS NOT NULL THEN CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode3 END END
        ,drvDepDisabledYN3 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled3 END
        ,drvDepCvgIndicator3 =    CASE WHEN DepFirstName3 IS NOT NULL THEN 
                                    CASE WHEN (DEN1_Dep_DedCode3 IS NOT NULL OR DEN2_Dep_DedCode3 IS NOT NULL) AND VIS_Dep_DedCode3 IS NOT NULL THEN '"D,V"' WHEN (DEN1_Dep_DedCode3 IS NOT NULL OR DEN2_Dep_DedCode3 IS NOT NULL) AND VIS_Dep_DedCode3 IS NULL THEN 'D' WHEN (DEN1_Dep_DedCode3 IS NULL AND DEN2_Dep_DedCode3 IS NULL) AND VIS_Dep_DedCode3 IS NOT NULL THEN 'V' END
                                END
        ,drvDedDhmoPcp3 = ''  
        ,drvDepFirstName4 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName4 END
        ,drvDepLastName4 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName4 END
        ,drvDepMiddleInitial4 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit4 END
        ,drvDepGender4 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender4 END
        ,drvDepDateOfBirth4 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth4 END
        ,drvDepRelationshipCode4 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship4 END
        ,drvDepStudentCode4 = CASE WHEN DepFirstName4 IS NOT NULL THEN  CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode4 END END
        ,drvDepDisabledYN4 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled4 END
        ,drvDepCvgIndicator4 = CASE WHEN DepFirstName4 IS NOT NULL THEN CASE WHEN (DEN1_Dep_DedCode4 IS NOT NULL OR DEN2_Dep_DedCode4 IS NOT NULL) AND VIS_Dep_DedCode4 IS NOT NULL THEN '"D,V"' WHEN (DEN1_Dep_DedCode4 IS NOT NULL OR DEN2_Dep_DedCode4 IS NOT NULL) AND VIS_Dep_DedCode4 IS NULL THEN 'D' WHEN (DEN1_Dep_DedCode4 IS NULL AND DEN2_Dep_DedCode4 IS NULL) AND VIS_Dep_DedCode4 IS NOT NULL THEN 'V' END END
        ,drvDedDhmoPcp4 = ''  
        ,drvDepFirstName5 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName5 END
        ,drvDepLastName5 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName5 END
        ,drvDepMiddleInitial5 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit5 END
        ,drvDepGender5 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender5 END
        ,drvDepDateOfBirth5 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth5 END
        ,drvDepRelationshipCode5 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship5 END
        ,drvDepStudentCode5 = CASE WHEN DepFirstName5 IS NOT NULL THEN CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode5 END END
        ,drvDepDisabledYN5 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled5 END
        ,drvDepCvgIndicator5 = CASE WHEN DepFirstName5 IS NOT NULL THEN CASE WHEN (DEN1_Dep_DedCode5 IS NOT NULL OR DEN2_Dep_DedCode5 IS NOT NULL) AND VIS_Dep_DedCode5 IS NOT NULL THEN '"D,V"' WHEN (DEN1_Dep_DedCode5 IS NOT NULL OR DEN2_Dep_DedCode5 IS NOT NULL) AND VIS_Dep_DedCode5 IS NULL THEN 'D' WHEN (DEN1_Dep_DedCode5 IS NULL AND DEN2_Dep_DedCode5 IS NULL) AND VIS_Dep_DedCode5 IS NOT NULL THEN 'V' END END
        ,drvDedDhmoPcp5 = ''  
        ,drvDepFirstName6 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName6 END
        ,drvDepLastName6 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName6 END
        ,drvDepMiddleInitial6 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit6 END
        ,drvDepGender6 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender6 END
        ,drvDepDateOfBirth6 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth6 END
        ,drvDepRelationshipCode6 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship6 END
        ,drvDepStudentCode6 = CASE WHEN DepFirstName6 IS NOT NULL THEN  CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode6 END END
        ,drvDepDisabledYN6 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled6 END
        ,drvDepCvgIndicator6 = CASE WHEN DepFirstName6 IS NOT NULL THEN CASE WHEN (DEN1_Dep_DedCode6 IS NOT NULL OR DEN2_Dep_DedCode6 IS NOT NULL) AND VIS_Dep_DedCode6 IS NOT NULL THEN '"D,V"' WHEN (DEN1_Dep_DedCode6 IS NOT NULL OR DEN2_Dep_DedCode6 IS NOT NULL) AND VIS_Dep_DedCode6 IS NULL THEN 'D' WHEN (DEN1_Dep_DedCode6 IS NULL AND DEN2_Dep_DedCode6 IS NULL) AND VIS_Dep_DedCode6 IS NOT NULL THEN 'V' END END
        ,drvDedDhmoPcp6 = ''  
        ,drvDepFirstName7 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName7 END
        ,drvDepLastName7 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName7 END
        ,drvDepMiddleInitial7 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit7 END
        ,drvDepGender7 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender7 END
        ,drvDepDateOfBirth7 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth7 END
        ,drvDepRelationshipCode7 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship7 END
        ,drvDepStudentCode7 = CASE WHEN DepFirstName7 IS NOT NULL THEN CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode7 END END
        ,drvDepDisabledYN7 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled7 END
        ,drvDepCvgIndicator7 = CASE WHEN DepFirstName7 IS NOT NULL THEN CASE WHEN (DEN1_Dep_DedCode7 IS NOT NULL OR DEN2_Dep_DedCode7 IS NOT NULL) AND VIS_Dep_DedCode7 IS NOT NULL THEN '"D,V"' WHEN (DEN1_Dep_DedCode7 IS NOT NULL OR DEN2_Dep_DedCode7 IS NOT NULL) AND VIS_Dep_DedCode7 IS NULL THEN 'D' WHEN (DEN1_Dep_DedCode7 IS NULL AND DEN2_Dep_DedCode7 IS NULL) AND VIS_Dep_DedCode7 IS NOT NULL THEN 'V' END END
        ,drvDedDhmoPcp7 = ''  
        ,drvDepFirstName8 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName8 END
        ,drvDepLastName8 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName8 END
        ,drvDepMiddleInitial8 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit8 END
        ,drvDepGender8 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender8 END
        ,drvDepDateOfBirth8 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth8 END
        ,drvDepRelationshipCode8 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship8 END
        ,drvDepStudentCode8 = CASE WHEN DepFirstName8 IS NOT NULL THEN  CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode8 END END
        ,drvDepDisabledYN8 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled8 END
        ,drvDepCvgIndicator8 = CASE WHEN DepFirstName8 IS NOT NULL THEN CASE WHEN (DEN1_Dep_DedCode8 IS NOT NULL OR DEN2_Dep_DedCode8 IS NOT NULL) AND VIS_Dep_DedCode8 IS NOT NULL THEN '"D,V"' WHEN (DEN1_Dep_DedCode8 IS NOT NULL OR DEN2_Dep_DedCode8 IS NOT NULL) AND VIS_Dep_DedCode8 IS NULL THEN 'D' WHEN (DEN1_Dep_DedCode8 IS NULL AND DEN2_Dep_DedCode8 IS NULL) AND VIS_Dep_DedCode8 IS NOT NULL THEN 'V' END END
        ,drvDedDhmoPcp8 = ''  
        ,drvDepFirstName9 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName9 END
        ,drvDepLastName9 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName9 END
        ,drvDepMiddleInitial9 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit9 END
        ,drvDepGender9 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender9 END
        ,drvDepDateOfBirth9 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth9 END
        ,drvDepRelationshipCode9 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship9 END
        ,drvDepStudentCode9 = CASE WHEN DepFirstName9 IS NOT NULL THEN  CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode9 END END
        ,drvDepDisabledYN9 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled9 END
        ,drvDepCvgIndicator9 = CASE WHEN DepFirstName9 IS NOT NULL THEN CASE WHEN (DEN1_Dep_DedCode9 IS NOT NULL OR DEN2_Dep_DedCode9 IS NOT NULL) AND VIS_Dep_DedCode9 IS NOT NULL THEN '"D,V"' WHEN (DEN1_Dep_DedCode9 IS NOT NULL OR DEN2_Dep_DedCode9 IS NOT NULL) AND VIS_Dep_DedCode9 IS NULL THEN 'D' WHEN (DEN1_Dep_DedCode9 IS NULL AND DEN2_Dep_DedCode9 IS NULL) AND VIS_Dep_DedCode9 IS NOT NULL THEN 'V' END END
        ,drvDedDhmoPcp9 = ''  
        ,drvDepFirstName10 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName10 END
        ,drvDepLastName10 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName10 END
        ,drvDepMiddleInitial10 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit10 END
        ,drvDepGender10 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender10 END
        ,drvDepDateOfBirth10 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth10 END
        ,drvDepRelationshipCode10 =    CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship10 END
        ,drvDepStudentCode10 = CASE WHEN DepFirstName10 IS NOT NULL THEN  CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode10 END END
        ,drvDepDisabledYN10 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled10 END
        ,drvDepCvgIndicator10 =    CASE WHEN DepFirstName10 IS NOT NULL THEN CASE WHEN (DEN1_Dep_DedCode10 IS NOT NULL OR DEN2_Dep_DedCode10 IS NOT NULL) AND VIS_Dep_DedCode10 IS NOT NULL THEN '"D,V"' WHEN (DEN1_Dep_DedCode10 IS NOT NULL OR DEN2_Dep_DedCode10 IS NOT NULL) AND VIS_Dep_DedCode10 IS NULL THEN 'D' WHEN (DEN1_Dep_DedCode10 IS NULL AND DEN2_Dep_DedCode10 IS NULL) AND VIS_Dep_DedCode10 IS NOT NULL THEN 'V' END END
        ,drvDedDhmoPcp10 = ''  
        ,drvDepFirstName11 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName11 END
        ,drvDepLastName11 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName11 END
        ,drvDepMiddleInitial11 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit11 END
        ,drvDepGender11 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender11 END
        ,drvDepDateOfBirth11 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth11 END
        ,drvDepRelationshipCode11 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship11 END
        ,drvDepStudentCode11 = CASE WHEN DepFirstName11 IS NOT NULL THEN  CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode11 END END
        ,drvDepDisabledYN11 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled11 END
        ,drvDepCvgIndicator11 = CASE WHEN DepFirstName11 IS NOT NULL THEN CASE WHEN (DEN1_Dep_DedCode11 IS NOT NULL OR DEN2_Dep_DedCode11 IS NOT NULL) AND VIS_Dep_DedCode11 IS NOT NULL THEN '"D,V"' WHEN (DEN1_Dep_DedCode11 IS NOT NULL OR DEN2_Dep_DedCode11 IS NOT NULL) AND VIS_Dep_DedCode11 IS NULL THEN 'D' WHEN (DEN1_Dep_DedCode11 IS NULL AND DEN2_Dep_DedCode11 IS NULL) AND VIS_Dep_DedCode11 IS NOT NULL THEN 'V' END END
        ,drvDedDhmoPcp11 = ''  
        ,drvDepFirstName12 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName12 END
        ,drvDepLastName12 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName12 END
        ,drvDepMiddleInitial12 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit12 END
        ,drvDepGender12 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender12 END
        ,drvDepDateOfBirth12 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth12 END
        ,drvDepRelationshipCode12 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship12 END
        ,drvDepStudentCode12 = CASE WHEN DepFirstName12 IS NOT NULL THEN  CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode12 END END
        ,drvDepDisabledYN12 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled12 END
        ,drvDepCvgIndicator12 = CASE WHEN DepFirstName12 IS NOT NULL THEN CASE WHEN (DEN1_Dep_DedCode12 IS NOT NULL OR DEN2_Dep_DedCode12 IS NOT NULL) AND VIS_Dep_DedCode12 IS NOT NULL THEN '"D,V"' WHEN (DEN1_Dep_DedCode12 IS NOT NULL OR DEN2_Dep_DedCode12 IS NOT NULL) AND VIS_Dep_DedCode12 IS NULL THEN 'D' WHEN (DEN1_Dep_DedCode12 IS NULL AND DEN2_Dep_DedCode12 IS NULL) AND VIS_Dep_DedCode12 IS NOT NULL THEN 'V' END END
        ,drvDedDhmoPcp12 = ''  
        ,drvDepFirstName13 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName13 END
        ,drvDepLastName13 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName13 END
        ,drvDepMiddleInitial13 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit13 END
        ,drvDepGender13 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender13 END
        ,drvDepDateOfBirth13 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth13 END
        ,drvDepRelationshipCode13 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship13 END
        ,drvDepStudentCode13 = CASE WHEN DepFirstName13 IS NOT NULL THEN CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode13 END END
        ,drvDepDisabledYN13 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled13 END
        ,drvDepCvgIndicator13 =    CASE WHEN DepFirstName13 IS NOT NULL THEN 
                                    CASE WHEN (DEN1_Dep_DedCode13 IS NOT NULL OR DEN2_Dep_DedCode13 IS NOT NULL) AND VIS_Dep_DedCode13 IS NOT NULL THEN '"D,V"' 
                                        WHEN (DEN1_Dep_DedCode13 IS NOT NULL OR DEN2_Dep_DedCode13 IS NOT NULL) AND VIS_Dep_DedCode13 IS NULL THEN 'D' 
                                        WHEN (DEN1_Dep_DedCode13 IS NULL AND DEN2_Dep_DedCode13 IS NULL) AND VIS_Dep_DedCode13 IS NOT NULL THEN 'V' 
                                    END 
                                END
        ,drvDedDhmoPcp13 = '' 
        ,drvDepFirstName14 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName14 END
        ,drvDepLastName14 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName14 END
        ,drvDepMiddleInitial14 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit14 END
        ,drvDepGender14 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender14 END
        ,drvDepDateOfBirth14 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth14 END
        ,drvDepRelationshipCode14 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship14 END
        ,drvDepStudentCode14 = CASE WHEN DepFirstName14 IS NOT NULL THEN CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode14 END END
        ,drvDepDisabledYN14 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled14 END
        ,drvDepCvgIndicator14 =    CASE WHEN DepFirstName14 IS NOT NULL THEN 
                                    CASE WHEN (DEN1_Dep_DedCode14 IS NOT NULL OR DEN2_Dep_DedCode14 IS NOT NULL) AND VIS_Dep_DedCode14 IS NOT NULL THEN '"D,V"' 
                                        WHEN (DEN1_Dep_DedCode14 IS NOT NULL OR DEN2_Dep_DedCode14 IS NOT NULL) AND VIS_Dep_DedCode14 IS NULL THEN 'D' 
                                        WHEN (DEN1_Dep_DedCode14 IS NULL AND DEN2_Dep_DedCode14 IS NULL) AND VIS_Dep_DedCode14 IS NOT NULL THEN 'V' 
                                    END 
                                END
        ,drvDedDhmoPcp14 = ''  
        ,drvDepFirstName15 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepFirstName15 END
        ,drvDepLastName15 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepLastName15 END
        ,drvDepMiddleInitial15 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepMiddleInit15 END
        ,drvDepGender15 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepGender15 END
        ,drvDepDateOfBirth15 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepDateOfBirth15 END
        ,drvDepRelationshipCode15 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepRelationship15 END
        ,drvDepStudentCode15 = CASE WHEN DepFirstName15 IS NOT NULL THEN CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepStudentCode15 END END
        ,drvDepDisabledYN15 = CASE WHEN DEN1_DedCode IS NOT NULL OR DEN2_DedCode IS NOT NULL OR VIS_DedCode IS NOT NULL OR VLIFC_DedCode IS NOT NULL OR VLIFS_DedCode IS NOT NULL THEN DepIsDisabled15 END
        ,drvDepCvgIndicator15 = CASE WHEN DepFirstName15 IS NOT NULL THEN CASE WHEN (DEN1_Dep_DedCode15 IS NOT NULL OR DEN2_Dep_DedCode15 IS NOT NULL) AND VIS_Dep_DedCode15 IS NOT NULL THEN '"D,V"' WHEN (DEN1_Dep_DedCode15 IS NOT NULL OR DEN2_Dep_DedCode15 IS NOT NULL) AND VIS_Dep_DedCode15 IS NULL THEN 'D' WHEN (DEN1_Dep_DedCode15 IS NULL AND DEN2_Dep_DedCode15 IS NULL) AND VIS_Dep_DedCode15 IS NOT NULL THEN 'V' END END
        ,drvDedDhmoPcp15 = ''          
        -- Dependant End
        INTO dbo.U_ELINFINEXP_drvTbl
    FROM dbo.U_ELINFINEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON EecJobCode = jbcJobCode
    JOIN (Select  bdmEEID,bdmcoid
            ,BLIFE_DedCode = MAX((CASE WHEN BDMDedCode = 'BLIFE' then BDMDedCode END))
            ,BLIFE_BenStartdate = MAX((CASE WHEN BDMDedCode = 'BLIFE' then BdmBenStartDate END))
            ,BLIFE_GoalAmt = SUM((CASE WHEN BDMDedCode = 'BLIFE' then BdmEEGoalAMt END))
            ,BLIFE_DedAmt = SUM((CASE WHEN BDMDedCode = 'BLIFE' then CAST(BdmUSGField1 as Money) END))
            ,BLIFE_BenStopDate = MAX((CASE WHEN BDMDedCode = 'BLIFE' then BdmBenStopDate END))
            ,DEN1_DedCode = MAX((CASE WHEN BDMDedCode = 'DEN1' AND BdmRecType = 'EMP' then BDMDedCode END)) 
--            ,DEN1_Dep_DedCode = MAX((CASE WHEN BDMDedCode = 'DEN1' AND BdmRecType <> 'EMP' then BDMDedCode END))
            ,DEN1_DedOption = MAX((CASE WHEN BDMDedCode = 'DEN1' then BdmBenOption END))
            ,DEN1_BenStartdate = MAX((CASE WHEN BDMDedCode = 'DEN1' then BdmBenStartDate END))
            ,DEN1_GoalAmt = SUM((CASE WHEN BDMDedCode = 'DEN1' then BdmEEGoalAMt END))
            ,DEN1_DedAmt = SUM((CASE WHEN BDMDedCode = 'DEN1' then CAST(BdmUSGField1 as Money) END))
            ,DEN1_BenStopDate = MAX((CASE WHEN BDMDedCode = 'DEN1' then BdmBenStopDate END))
            ,DEN2_DedCode = MAX((CASE WHEN BDMDedCode = 'DEN2' AND BdmRecType = 'EMP' then BDMDedCode END))
--            ,DEN2_Dep_DedCode = MAX((CASE WHEN BDMDedCode = 'DEN2' AND BdmRecType <> 'EMP' then BDMDedCode END))
            ,DEN2_DedOption = MAX((CASE WHEN BDMDedCode = 'DEN2' then BdmBenOption END))
            ,DEN2_BenStartdate = MAX((CASE WHEN BDMDedCode = 'DEN2' then BdmBenStartDate END))
            ,DEN2_GoalAmt = SUM((CASE WHEN BDMDedCode = 'DEN2' then BdmEEGoalAMt END))
            ,DEN2_DedAmt = SUM((CASE WHEN BDMDedCode = 'DEN2' then CAST(BdmUSGField1 as Money) END))
            ,DEN2_BenStopDate = MAX((CASE WHEN BDMDedCode = 'DEN2' then BdmBenStopDate END))
            ,LTD_DedCode = MAX((CASE WHEN BDMDedCode = 'LTD' then BDMDedCode END))
            ,LTD_BenStartdate = MAX((CASE WHEN BDMDedCode = 'LTD' then BdmBenStartDate END))
            ,LTD_GoalAmt = SUM((CASE WHEN BDMDedCode = 'LTD' then BdmEEGoalAMt END))
            ,LTD_DedAmt = SUM((CASE WHEN BDMDedCode = 'LTD' then CAST(BdmUSGField1 as Money) END))
            ,LTD_BenStopDate = MAX((CASE WHEN BDMDedCode = 'LTD' then BdmBenStopDate END))
            ,STD_DedCode = MAX((CASE WHEN BDMDedCode = 'STD' then BDMDedCode END))
            ,STD_BenStartdate = MAX((CASE WHEN BDMDedCode = 'STD' then BdmBenStartDate END))
            ,STD_GoalAmt = SUM((CASE WHEN BDMDedCode = 'STD' then BdmEEGoalAMt END))
            ,STD_DedAmt = SUM((CASE WHEN BDMDedCode = 'STD' then CAST(BdmUSGField1 as Money) END))
            ,STD_BenStopDate = MAX((CASE WHEN BDMDedCode = 'STD' then BdmBenStopDate END))
            ,VIS_DedCode = MAX((CASE WHEN BDMDedCode = 'VIS' AND BdmRecType = 'EMP' then BDMDedCode END))
--            ,VIS_Dep_DedCode = MAX((CASE WHEN BDMDedCode = 'VIS' AND BdmRecType <> 'EMP' then BDMDedCode END))
            ,VIS_DedOption = MAX((CASE WHEN BDMDedCode = 'VIS' then BdmBenOption END))
            ,VIS_BenStartdate = MAX((CASE WHEN BDMDedCode = 'VIS' then BdmBenStartDate END))
            ,VIS_GoalAmt = SUM((CASE WHEN BDMDedCode = 'VIS' then BdmEEGoalAMt END))
            ,VIS_DedAmt = SUM((CASE WHEN BDMDedCode = 'VIS' then CAST(BdmUSGField1 as Money) END))
            ,VIS_BenStopDate = MAX((CASE WHEN BDMDedCode = 'VIS' then BdmBenStopDate END))
            ,VLIFC_DedCode = MAX((CASE WHEN BDMDedCode = 'VLIFC' then BDMDedCode END))
            ,VLIFC_BenStartdate = MAX((CASE WHEN BDMDedCode = 'VLIFC' then BdmBenStartDate END))
            ,VLIFC_GoalAmt = SUM((CASE WHEN BDMDedCode = 'VLIFC' then BdmEEGoalAMt END))
            ,VLIFC_DedAmt = SUM((CASE WHEN BDMDedCode = 'VLIFC' then CAST(BdmUSGField1 as Money) END))
            ,VLIFC_BenStopDate = MAX((CASE WHEN BDMDedCode = 'VLIFC' then BdmBenStopDate END))
            ,VLIFE_DedCode = MAX((CASE WHEN BDMDedCode = 'VLIFE' then BDMDedCode END)) 
            ,VLIFE_BenStartdate = MAX((CASE WHEN BDMDedCode = 'VLIFE' then BdmBenStartDate END))
            ,VLIFE_GoalAmt = SUM((CASE WHEN BDMDedCode = 'VLIFE' then BdmEEGoalAMt END))
            ,VLIFE_DedAmt = SUM((CASE WHEN BDMDedCode = 'VLIFE' then CAST(BdmUSGField1 as Money) END))
            ,VLIFE_BenStopDate = MAX((CASE WHEN BDMDedCode = 'VLIFE' then BdmBenStopDate END))
            ,VLIFS_DedCode = MAX((CASE WHEN BDMDedCode = 'VLIFS' then BDMDedCode END)) 
            ,VLIFS_BenStartdate = MAX((CASE WHEN BDMDedCode = 'VLIFS' then BdmBenStartDate END))
            ,VLIFS_GoalAmt = SUM((CASE WHEN BDMDedCode = 'VLIFS' then BdmEEGoalAMt END)) 
            ,VLIFS_DedAmt = SUM((CASE WHEN BDMDedCode = 'VLIFS' then CAST(BdmUSGField1 as Money) END)) 
            ,VLIFS_BenStopDate = MAX((CASE WHEN BDMDedCode = 'VLIFS' then BdmBenStopDate END))    
            from dbo.U_dsi_BDM_ELINFINEXP  group by bdmEEID,bdmcoid) 
             as BdmConsolidated
        ON BdmConsolidated.BdmEEID = xEEID
        AND BdmConsolidated.BdmCOID = xCOID
    /*LEFT JOIN dbo.Contacts WITH (NOLOCK) -- ???
        ON ConEEID = xEEID
        AND ConSystemID IN (SELECT BdmDepRecID FROM dbo.U_ELINFINEXP_BdmDepRecID WITH (NOLOCK))
        AND ConRelationship in ('SPS', 'DP')
        AND ConIsActive = 'Y'*/
    LEFT JOIN (    SELECT DbnEEID,  DbnCoID
                    ,MAX(DbnBenStartDate) AS DbnBenStartDate
                FROM dbo.DepBPLan WITH (NOLOCK)
                WHERE DbnBenStatus = 'A' 
                GROUP BY DbnEEID, DbnCoID) AS Dep_Ben
        ON DbnEEID = xEEID
    LEFT JOIN (
                
SELECT DISTINCT EdhEEID, EdhEffDate, EdhChangeReason
FROM dbo.EmpHDed WITH (NOLOCK)
WHERE edhBenStatus = 'A' 
--AND edhEEId ='D3ZW1U000020' --xEEID
AND EdhDedCode IN ('BLIFE','DEN1','DEN2','LTD','STD','VIS','VLIFC','VLIFE','VLIFS') 
AND EdhEffDate = (
                    SELECT MAX(EdhEffDate) --, EdhChangeReason
                    FROM dbo.EmpHDed WITH (NOLOCK)
                    WHERE edhBenStatus = 'A' 
                    --AND edhEEId ='D3ZW1U000020' --xEEID
                    AND EdhDedCode IN ('BLIFE','DEN1','DEN2','LTD','STD','VIS','VLIFC','VLIFE','VLIFS')
                ) 
AND EdhChangeReason IN ('100', 'LEVNT1')
                ) AS EdhChgReason
                ON EdhEEID = xEEID
    LEFT JOIN (
        Select ConEEID as KidEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) as DepLastName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) as DepFirstName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConGender END) as DepGender1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) as DepDateOfBirth1
            ,MAX(CASE WHEN Dep_Number = 1 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship1
            ,'N' as DepStudentCode1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConIsDisabled END) as DepIsDisabled1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConIsSmoker END) AS ConIsSmoker
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS ConDateOfBirth
            ,MAX(CASE WHEN Dep_Number = 1 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode1 -- JCB
            ,MAX(CASE WHEN Dep_Number = 1 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode1
            ,MAX(CASE WHEN Dep_Number = 1 THEN VIS_DedCode END) AS VIS_Dep_DedCode1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameLast END) as DepLastName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameFirst END) as DepFirstName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConGender END) as DepGender2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConDateOfBirth END) as DepDateOfBirth2
            ,MAX(CASE WHEN Dep_Number = 2 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship2
            ,'N' as DepStudentCode2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConIsDisabled END) as DepIsDisabled2
            ,MAX(CASE WHEN Dep_Number = 2 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode2
            ,MAX(CASE WHEN Dep_Number = 2 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode2
            ,MAX(CASE WHEN Dep_Number = 2 THEN VIS_DedCode END) AS VIS_Dep_DedCode2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameLast END) as DepLastName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameFirst END) as DepFirstName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConGender END) as DepGender3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConDateOfBirth END) as DepDateOfBirth3
            ,MAX(CASE WHEN Dep_Number = 3 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship3
            ,'N' as DepStudentCode3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConIsDisabled END) as DepIsDisabled3
            ,MAX(CASE WHEN Dep_Number = 3 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode3
            ,MAX(CASE WHEN Dep_Number = 3 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode3
            ,MAX(CASE WHEN Dep_Number = 3 THEN VIS_DedCode END) AS VIS_Dep_DedCode3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameLast END) as DepLastName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameFirst END) as DepFirstName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConGender END) as DepGender4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConDateOfBirth END) as DepDateOfBirth4
            ,MAX(CASE WHEN Dep_Number = 4 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship4
            ,'N' as DepStudentCode4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConIsDisabled END) as DepIsDisabled4
            ,MAX(CASE WHEN Dep_Number = 4 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode4
            ,MAX(CASE WHEN Dep_Number = 4 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode4
            ,MAX(CASE WHEN Dep_Number = 4 THEN VIS_DedCode END) AS VIS_Dep_DedCode4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameLast END) as DepLastName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameFirst END) as DepFirstName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConGender END) as DepGender5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConDateOfBirth END) as DepDateOfBirth5
            ,MAX(CASE WHEN Dep_Number = 5 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship5
            ,'N' as DepStudentCode5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConIsDisabled END) as DepIsDisabled5
            ,MAX(CASE WHEN Dep_Number = 5 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode5
            ,MAX(CASE WHEN Dep_Number = 5 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode5
            ,MAX(CASE WHEN Dep_Number = 5 THEN VIS_DedCode END) AS VIS_Dep_DedCode5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameLast END) as DepLastName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameFirst END) as DepFirstName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConGender END) as DepGender6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConDateOfBirth END) as DepDateOfBirth6
            ,MAX(CASE WHEN Dep_Number = 6 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship6
            ,'N' as DepStudentCode6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConIsDisabled END) as DepIsDisabled6
            ,MAX(CASE WHEN Dep_Number = 6 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode6
            ,MAX(CASE WHEN Dep_Number = 6 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode6
            ,MAX(CASE WHEN Dep_Number = 6 THEN VIS_DedCode END) AS VIS_Dep_DedCode6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameLast END) as DepLastName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameFirst END) as DepFirstName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConGender END) as DepGender7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConDateOfBirth END) as DepDateOfBirth7
            ,MAX(CASE WHEN Dep_Number = 7 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship7
            ,'N' as DepStudentCode7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConIsDisabled END) as DepIsDisabled7
            ,MAX(CASE WHEN Dep_Number = 7 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode7
            ,MAX(CASE WHEN Dep_Number = 7 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode7
            ,MAX(CASE WHEN Dep_Number = 7 THEN VIS_DedCode END) AS VIS_Dep_DedCode7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameLast END) as DepLastName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameFirst END) as DepFirstName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConGender END) as DepGender8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConDateOfBirth END) as DepDateOfBirth8
            ,MAX(CASE WHEN Dep_Number = 8 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship8
            ,'N' as DepStudentCode8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConIsDisabled END) as DepIsDisabled8
            ,MAX(CASE WHEN Dep_Number = 8 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode8
            ,MAX(CASE WHEN Dep_Number = 8 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode8
            ,MAX(CASE WHEN Dep_Number = 8 THEN VIS_DedCode END) AS VIS_Dep_DedCode8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameLast END) as DepLastName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameFirst END) as DepFirstName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConGender END) as DepGender9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConDateOfBirth END) as DepDateOfBirth9
            ,MAX(CASE WHEN Dep_Number = 9 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship9
            ,'N' as DepStudentCode9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConIsDisabled END) as DepIsDisabled9
            ,MAX(CASE WHEN Dep_Number = 9 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode9
            ,MAX(CASE WHEN Dep_Number = 9 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode9
            ,MAX(CASE WHEN Dep_Number = 9 THEN VIS_DedCode END) AS VIS_Dep_DedCode9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameLast END) as DepLastName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameFirst END) as DepFirstName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConGender END) as DepGender10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConDateOfBirth END) as DepDateOfBirth10
            ,MAX(CASE WHEN Dep_Number = 10 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship10
            ,'N' as DepStudentCode10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConIsDisabled END) as DepIsDisabled10
            ,MAX(CASE WHEN Dep_Number = 10 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode10
            ,MAX(CASE WHEN Dep_Number = 10 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode10
            ,MAX(CASE WHEN Dep_Number = 10 THEN VIS_DedCode END) AS VIS_Dep_DedCode10
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameLast END) as DepLastName11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameFirst END) as DepFirstName11
            ,MAX(CASE WHEN Dep_Number = 11 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConGender END) as DepGender11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConDateOfBirth END) as DepDateOfBirth11
            ,MAX(CASE WHEN Dep_Number = 11 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship11
            ,'N' as DepStudentCode11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConIsDisabled END) as DepIsDisabled11
            ,MAX(CASE WHEN Dep_Number = 11 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode11
            ,MAX(CASE WHEN Dep_Number = 11 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode11
            ,MAX(CASE WHEN Dep_Number = 11 THEN VIS_DedCode END) AS VIS_Dep_DedCode11
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConNameLast END) as DepLastName12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConNameFirst END) as DepFirstName12
            ,MAX(CASE WHEN Dep_Number = 12 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConGender END) as DepGender12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConDateOfBirth END) as DepDateOfBirth12
            ,MAX(CASE WHEN Dep_Number = 12 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship12
            ,'N' as DepStudentCode12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConIsDisabled END) as DepIsDisabled12
            ,MAX(CASE WHEN Dep_Number = 12 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode12
            ,MAX(CASE WHEN Dep_Number = 12 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode12
            ,MAX(CASE WHEN Dep_Number = 12 THEN VIS_DedCode END) AS VIS_Dep_DedCode12
            ,MAX(CASE WHEN Dep_Number = 13 THEN ConNameLast END) as DepLastName13
            ,MAX(CASE WHEN Dep_Number = 13 THEN ConNameFirst END) as DepFirstName13
            ,MAX(CASE WHEN Dep_Number = 13 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit13
            ,MAX(CASE WHEN Dep_Number = 13 THEN ConGender END) as DepGender13
            ,MAX(CASE WHEN Dep_Number = 13 THEN ConDateOfBirth END) as DepDateOfBirth13
            ,MAX(CASE WHEN Dep_Number = 13 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship13
            ,'N' as DepStudentCode13
            ,MAX(CASE WHEN Dep_Number = 13 THEN ConIsDisabled END) as DepIsDisabled13
            ,MAX(CASE WHEN Dep_Number = 13 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode13
            ,MAX(CASE WHEN Dep_Number = 13 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode13
            ,MAX(CASE WHEN Dep_Number = 13 THEN VIS_DedCode END) AS VIS_Dep_DedCode13
            ,MAX(CASE WHEN Dep_Number = 14 THEN ConNameLast END) as DepLastName14
            ,MAX(CASE WHEN Dep_Number = 14 THEN ConNameFirst END) as DepFirstName14
            ,MAX(CASE WHEN Dep_Number = 14 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit14
            ,MAX(CASE WHEN Dep_Number = 14 THEN ConGender END) as DepGender14
            ,MAX(CASE WHEN Dep_Number = 14 THEN ConDateOfBirth END) as DepDateOfBirth14
            ,MAX(CASE WHEN Dep_Number = 14 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship14
            ,'N' as DepStudentCode14
            ,MAX(CASE WHEN Dep_Number = 14 THEN ConIsDisabled END) as DepIsDisabled14
            ,MAX(CASE WHEN Dep_Number = 14 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode14
            ,MAX(CASE WHEN Dep_Number = 14 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode14
            ,MAX(CASE WHEN Dep_Number = 14 THEN VIS_DedCode END) AS VIS_Dep_DedCode14
            ,MAX(CASE WHEN Dep_Number = 15 THEN ConNameLast END) as DepLastName15
            ,MAX(CASE WHEN Dep_Number = 15 THEN ConNameFirst END) as DepFirstName15
            ,MAX(CASE WHEN Dep_Number = 15 THEN LEFT(ISNULL(ConNameMiddle, ''), 1) END) as DepMiddleInit15
            ,MAX(CASE WHEN Dep_Number = 15 THEN ConGender END) as DepGender15
            ,MAX(CASE WHEN Dep_Number = 15 THEN ConDateOfBirth END) as DepDateOfBirth15
            ,MAX(CASE WHEN Dep_Number = 15 THEN CASE WHEN ConRelationship IN ('SPS', 'DP') THEN 'S' ELSE 'C' END END) as DepRelationship15
            ,'N' as DepStudentCode15
            ,MAX(CASE WHEN Dep_Number = 15 THEN ConIsDisabled END) as DepIsDisabled15
            ,MAX(CASE WHEN Dep_Number = 15 THEN DEN1_DedCode END) AS DEN1_Dep_DedCode15
            ,MAX(CASE WHEN Dep_Number = 15 THEN DEN2_DedCode END) AS DEN2_Dep_DedCode15
            ,MAX(CASE WHEN Dep_Number = 15 THEN VIS_DedCode END) AS VIS_Dep_DedCode15
        FROM (SELECT ConEEID, ConNameLast, ConNameFirst, ConNameMIddle, ConGender, ConDateOfBirth, ConRelationship, ConIsDisabled, ConIsSmoker, DEN1_DedCode, DEN2_DedCode, VIS_DedCode, ROW_NUMBER() 
                    OVER (PARTITION BY ConEEID ORDER BY CASE ConRelationship
                                                            WHEN 'SPS' THEN 1
                                                            WHEN 'DP' THEN 1
                                                            ELSE 2
                                                        END, ConSSN) AS 'Dep_Number'
                FROM dbo.Contacts WITH (NOLOCK)
                JOIN dbo.U_ELINFINEXP_EEList WITH (NOLOCK)
                    ON xEEID = ConEEID
                JOIN (SELECT BdmEEID, BdmDepRecID
                        ,MAX(CASE WHEN BDMDedCode = 'DEN1' THEN BdmDedCode END) AS DEN1_DedCode
                        ,MAX(CASE WHEN BDMDedCode = 'DEN2' THEN BdmDedCode END) AS DEN2_DedCode
                        ,MAX(CASE WHEN BDMDedCode = 'VIS' THEN BdmDedCode END) AS VIS_DedCode
                        FROM dbo.U_dsi_BDM_ELINFINEXP WITH (NOLOCK)
                        GROUP BY BdmEEID, BdmDepRecID
                    ) AS T
                    ON ConEEID = xEEID
                    AND ConSystemID = BdmDepRecID                    
                WHERE ConIsActive = 'Y' 
                    AND ConIsDependent = 'Y' 
                    AND ConSSN IS NOT NULL
                    AND ConSystemID IN (SELECT BdmDepRecID FROM dbo.U_ELINFINEXP_BdmDepRecID WITH (NOLOCK))
                    AND ConRelationship in ('DIS','CHL','DPC','STC','SPS','DP') 
                ) AS Source Group BY ConEEID
        ) AS Kids ON KidEEID = xEEID
    LEFT JOIN dbo.U_ELINFINEXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_ELINFINEXP_PEmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
    WHERE (eecemplstatus <> 'T' 
            OR (eecemplstatus= 'T' 
            and eectermreason <>'TRO' 
            and EXISTS(select 1 from dbo.U_ELINFINEXP_Audit where  audKey1Value = xEEID  and audfieldname = 'eecemplstatus' and audNewValue = 'T'))) -- AND audKey2Value = xcoid
    ;        

--Select EedBenAmt, EedDedCode, * From EmpDed Where EedEEID = 'C3W4GE0000K0' and EedDedCode = 'VLIFE'

--select * from EmpDedFull Where EedEEID = 'C3W4GE0000K0' and EedDedCode = 'VLIFE'


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
    SET expLastStartPerControl = '202002011'
       ,expStartPerControl     = '202002011'
       ,expLastEndPerControl   = '202012319'
       ,expEndPerControl       = '202012319'
WHERE expFormatCode = 'ELINFINEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELINFINEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELINFINEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort