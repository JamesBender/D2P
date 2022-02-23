SET NOCOUNT ON;
IF OBJECT_ID('U_ELININSEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELININSEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELININSEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELININSEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELININSEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELININSEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELININSEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELININSEXP];
GO
IF OBJECT_ID('U_ELININSEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ELININSEXP_File];
GO
IF OBJECT_ID('U_ELININSEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELININSEXP_EEList];
GO
IF OBJECT_ID('U_ELININSEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELININSEXP_drvTbl];
GO
IF OBJECT_ID('U_ELININSEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELININSEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ELININSEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELININSEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELININSEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELININSEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELININSEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELININSEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELININSEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELININSEXP','Lincoln Financial Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','18000','S','N','ELININSEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELININSEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID "','1','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','1',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Change Date "','2','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','2',NULL,'Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Change Date "','3','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','3',NULL,'Dep Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date "','4','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','4',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr First Name "','5','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','5',NULL,'Mbr First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Last Name "','6','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','6',NULL,'Mbr Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Middle Initial "','7','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','7',NULL,'Mbr Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr SSN "','8','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','8',NULL,'Mbr SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Gender "','9','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','9',NULL,'Mbr Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr DOB "','10','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','10',NULL,'Mbr DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"App Sign Date "','11','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','11',NULL,'App Sign Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation "','12','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','12',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs Per Week "','13','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','13',NULL,'Hrs Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Amt "','14','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','14',NULL,'Salary Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Code "','15','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','15',NULL,'Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sal Eff Date "','16','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','16',NULL,'Sal Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Addr 1 "','17','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','17',NULL,'Mbr Addr 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Addr 2 "','18','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','18',NULL,'Mbr Addr 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr City "','19','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','19',NULL,'Mbr City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr State "','20','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','20',NULL,'Mbr State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Zip Code "','21','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','21',NULL,'Mbr Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Zip Plus 4 "','22','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','22',NULL,'Mbr Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone "','23','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','23',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone "','24','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','24',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Ext "','25','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','25',NULL,'Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address "','26','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','26',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Benefits Eligibility "','27','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','27',NULL,'Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Subsequent Date of Benefits Eligibility"','28','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','28',NULL,'Subsequent Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reason for Prior Loss of Benefits Eligibility "','29','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','29',NULL,'Reason for Prior Loss of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene First Name "','30','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','30',NULL,'Pri Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Last Name "','31','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','31',NULL,'Pri Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Middle Init "','32','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','32',NULL,'Pri Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Relationship "','33','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','33',NULL,'Pri Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Address 1 "','34','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','34',NULL,'Pri Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Address 2 "','35','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','35',NULL,'Pri Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene City "','36','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','36',NULL,'Pri Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene State "','37','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','37',NULL,'Pri Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Zip Code "','38','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','38',NULL,'Pri Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Zip Plus 4 "','39','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','39',NULL,'Pri Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene SSN "','40','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','40',NULL,'Pri Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene First Name "','41','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','41',NULL,'Co Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Last Name "','42','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','42',NULL,'Co Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Middle Init "','43','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','43',NULL,'Co Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Relationship "','44','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','44',NULL,'Co Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Address 1 "','45','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','45',NULL,'Co Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Address 2 "','46','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','46',NULL,'Co Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene City "','47','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','47',NULL,'Co Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene State "','48','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','48',NULL,'Co Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Zip Code "','49','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','49',NULL,'Co Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Zip Plus 4 "','50','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','50',NULL,'Co Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene SSN "','51','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','51',NULL,'Co Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Beneficiary Comments "','52','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','52',NULL,'Beneficiary Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Policy Number "','53','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','53',NULL,'Accident Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Bill Location AC Number "','54','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','54',NULL,'Accident Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Sort Group "','55','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','55',NULL,'Accident Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Eff Date "','56','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','56',NULL,'Accident Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Plan Code "','57','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','57',NULL,'Accident Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Class Code "','58','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','58',NULL,'Accident Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Tier Code "','59','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','59',NULL,'Accident Tier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health Asses Tier "','60','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','60',NULL,'Health Asses Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Tier "','61','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','61',NULL,'Hospital Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Disability Amount "','62','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','62',NULL,'Accident Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Tier "','63','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','63',NULL,'Accident DI Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Benefit Period "','64','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','64',NULL,'Accident DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Elim Period "','65','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','65',NULL,'Accident DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Sickness Disability Amount "','66','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','66',NULL,'Accident Sickness Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accidentsick Tier "','67','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','67',NULL,'Accident sick Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accidentsick DI Benefit Period "','68','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','68',NULL,'Accident sick DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accidentsick DI Elim Period "','69','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','69',NULL,'Accident sick DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Termination Date "','70','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','70',NULL,'Accident Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Policy Number "','71','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','71',NULL,'Critical Illness Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Bill Location AC Number"','72','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','72',NULL,'Critical Illness Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Sort Group "','73','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','73',NULL,'Critical Illness Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Eff Date "','74','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','74',NULL,'Critical Illness Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Plan Code "','75','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','75',NULL,'Critical Illness Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Class Code "','76','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','76',NULL,'Critical Illness Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Termination Date "','77','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','77',NULL,'Critical Illness Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Principal Sum Amt Approved "','78','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','78',NULL,'EE Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Principal Sum Amt Pending "','79','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','79',NULL,'EE Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Principal Sum Amt Approved "','80','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','80',NULL,'SP Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Principal Sum Amt Pending "','81','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','81',NULL,'SP Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Principal Sum Amt Approved "','82','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','82',NULL,'CH Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Principal Sum Amt Pending "','83','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','83',NULL,'CH Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Heart Amt Approved "','84','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','84',NULL,'EE Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Heart Amt Pending "','85','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','85',NULL,'EE Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Heart Amt Approved "','86','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','86',NULL,'SP Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Heart Amt Pending "','87','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','87',NULL,'SP Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Heart Amt Approved "','88','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','88',NULL,'CH Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Heart Amt Pending "','89','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','89',NULL,'CH Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Cancer Amt Approved "','90','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','90',NULL,'EE Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Cancer Amt Pending "','91','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','91',NULL,'EE Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Cancer Amt Approved "','92','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','92',NULL,'SP Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Cancer Amt Pending "','93','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','93',NULL,'SP Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Cancer Amt Approved "','94','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','94',NULL,'CH Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Cancer Amt Pending "','95','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','95',NULL,'CH Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Organ Amt Approved "','96','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','96',NULL,'EE Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Organ Amt Pending "','97','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','97',NULL,'EE Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Organ Amt Approved "','98','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','98',NULL,'SP Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Organ Amt Pending "','99','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','99',NULL,'SP Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Organ Amt Approved "','100','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','100',NULL,'CH Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Organ Amt Pending "','101','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','101',NULL,'CH Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Quality of Life Amt Approved "','102','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','102',NULL,'EE Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Quality of Life Amt Pending "','103','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','103',NULL,'EE Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Quality of Life Amt Approved "','104','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','104',NULL,'SP Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Quality of Life Amt Pending "','105','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','105',NULL,'SP Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Quality of Life Amt Approved "','106','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','106',NULL,'CH Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Quality of Life Amt Pending "','107','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','107',NULL,'CH Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Category Amt Approved "','108','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','108',NULL,'Child Category Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Category Amt Pending "','109','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','109',NULL,'Child Category Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Treatment Care YN "','110','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','110',NULL,'EE Treatment Care YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Treatment Care YN "','111','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','111',NULL,'SP Treatment Care YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Treatment Care YN "','112','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','112',NULL,'CH Treatment Care YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE DI YN "','113','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','113',NULL,'EE DI YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP DI YN "','114','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','114',NULL,'SP DI YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Accident YN "','115','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','115',NULL,'EE Accident Y N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Accident YN "','116','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','116',NULL,'SP Accident Y N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Accident YN "','117','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','117',NULL,'CH Accident YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE OccHIV YN "','118','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','118',NULL,'EE OccHIV YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Policy Number "','119','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','119',NULL,'Life Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Bill Location AC Number "','120','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','120',NULL,'Life Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Sort Group "','121','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','121',NULL,'Life Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Eff Date "','122','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','122',NULL,'Life Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan Code "','123','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','123',NULL,'Life Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Class Code "','124','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','124',NULL,'Life Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LI Cvgs "','125','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','125',NULL,'LI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LI Termination Date "','126','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','126',NULL,'LI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AD Cvgs "','127','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','127',NULL,'AD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AD Termination Date "','128','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','128',NULL,'AD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DLI Cvgs "','129','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','129',NULL,'DLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DLI Termination Date "','130','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','130',NULL,'DLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DAD Cvgs "','131','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','131',NULL,'DAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DAD Termination Date "','132','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','132',NULL,'DAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLI Cvgs "','133','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','133',NULL,'OLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLI Termination Date "','134','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','134',NULL,'OLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OAD Cvgs "','135','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','135',NULL,'OAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OAD Termination Date "','136','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','136',NULL,'OAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODLI Cvgs "','137','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','137',NULL,'ODLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODLI Termination Date "','138','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','138',NULL,'ODLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODAD Cvgs "','139','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','139',NULL,'ODAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODAD Termination Date "','140','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','140',NULL,'ODAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SLI Cvgs "','141','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','141',NULL,'SLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SLI Termination Date "','142','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','142',NULL,'SLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAD Cvgs "','143','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','143',NULL,'SAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAD Termination Date "','144','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','144',NULL,'SAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLI Cvgs "','145','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','145',NULL,'CLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLI Termination Date "','146','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','146',NULL,'CLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSLI Cvgs "','147','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','147',NULL,'OSLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSLI Termination Date "','148','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','148',NULL,'OSLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSAD Cvgs "','149','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','149',NULL,'OSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSAD Termination Date "','150','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','150',NULL,'OSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OCLI Cvgs "','151','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','151',NULL,'OCLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OCLI Termination Date "','152','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','152',NULL,'OCLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Policy Number "','153','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','153',NULL,'WI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Bill Location AC Number "','154','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','154',NULL,'WI Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Sort Group "','155','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','155',NULL,'WI Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Eff Date "','156','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','156',NULL,'WI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Plan Code "','157','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','157',NULL,'WI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Class Code "','158','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','158',NULL,'WI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Cvgs "','159','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','159',NULL,'WI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Termination Date "','160','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','160',NULL,'WI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OWI Cvgs "','161','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','161',NULL,'OWI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OWI Termination Date "','162','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','162',NULL,'OWI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Policy Number "','163','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','163',NULL,'LTD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Bill Location AC Number "','164','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','164',NULL,'LTD Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Sort Group "','165','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','165',NULL,'LTD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Eff Date "','166','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','166',NULL,'LTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Plan Code "','167','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','167',NULL,'LTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Class Code "','168','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','168',NULL,'LTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Cvgs "','169','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','169',NULL,'LTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Termination Date "','170','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','170',NULL,'LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLTD Cvgs "','171','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','171',NULL,'OLTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLTD Termination Date "','172','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','172',NULL,'OLTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Cvgs "','173','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','173',NULL,'CI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Date "','174','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','174',NULL,'CI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Policy Number "','175','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','175',NULL,'Dent Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Bill Location AC Number "','176','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','176',NULL,'Dent Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Sort Group "','177','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','177',NULL,'Dent Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Eff Date "','178','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','178',NULL,'Dent Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Plan Code "','179','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','179',NULL,'Dent Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Class Code "','180','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','180',NULL,'Dent Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Coverage Tier "','181','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','181',NULL,'Dent Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Other Ins "','182','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','182',NULL,'Dent Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Termination Date "','183','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','183',NULL,'Dent Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Policy Number "','184','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','184',NULL,'DHMO Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Bill Location AC Number "','185','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','185',NULL,'DHMO Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Sort Group "','186','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','186',NULL,'DHMO Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Eff Date "','187','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','187',NULL,'DHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Plan Code "','188','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','188',NULL,'DHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Class Code "','189','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','189',NULL,'DHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Coverage Tier  "','190','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','190',NULL,'DHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO PCP  "','191','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','191',NULL,'DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Termination Date "','192','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','192',NULL,'DHMO Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Policy Number "','193','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','193',NULL,'LVC Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Bill Location AC Number "','194','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','194',NULL,'LVC Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Sort Group "','195','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','195',NULL,'LVC Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Eff Date "','196','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','196',NULL,'LVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Plan Code "','197','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','197',NULL,'LVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Class Code "','198','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','198',NULL,'LVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Coverage Tier "','199','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','199',NULL,'LVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Other Ins "','200','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','200',NULL,'LVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Termination Date "','201','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','201',NULL,'LVC Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Policy Number "','202','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','202',NULL,'VLVC Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Bill Location AC Number "','203','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','203',NULL,'VLVC Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Sort Group "','204','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','204',NULL,'VLVC Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Eff Date "','205','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','205',NULL,'VLVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Plan Code "','206','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','206',NULL,'VLVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Class Code "','207','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','207',NULL,'VLVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Coverage Tier "','208','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','208',NULL,'VLVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Other Ins "','209','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','209',NULL,'VLVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Termination Date "','210','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','210',NULL,'VLVC Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Policy Number "','211','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','211',NULL,'VDN Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Bill Location AC Number "','212','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','212',NULL,'VDN Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Sort Group "','213','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','213',NULL,'VDN Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Eff Date "','214','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','214',NULL,'VDN Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Plan Code "','215','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','215',NULL,'VDN Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Class Code "','216','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','216',NULL,'VDN Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Coverage Tier "','217','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','217',NULL,'VDN Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Other Ins "','218','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','218',NULL,'VDN Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Termination Date "','219','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','219',NULL,'VDN Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Policy Number "','220','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','220',NULL,'VDHMO Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Bill Location AC Number "','221','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','221',NULL,'VDHMO Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Sort Group "','222','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','222',NULL,'VDHMO Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Eff Date "','223','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','223',NULL,'VDHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Plan Code "','224','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','224',NULL,'VDHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Class Code "','225','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','225',NULL,'VDHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Coverage Tier  "','226','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','226',NULL,'VDHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO PCP  "','227','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','227',NULL,'VDHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Termination Date "','228','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','228',NULL,'VDHMO Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Policy Number "','229','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','229',NULL,'VLIF Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Bill Location AC Number "','230','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','230',NULL,'VLIF Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Sort Group "','231','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','231',NULL,'VLIF Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Eff Date "','232','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','232',NULL,'VLIF Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Plan Code "','233','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','233',NULL,'VLIF Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Class Code "','234','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','234',NULL,'VLIF Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLI Cvgs "','235','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','235',NULL,'VLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLI Termination Date "','236','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','236',NULL,'VLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VAD Cvgs "','237','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','237',NULL,'VAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VAD Termination Date "','238','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','238',NULL,'VAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLI Cvgs "','239','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','239',NULL,'VSLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLI Termination Date "','240','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','240',NULL,'VSLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSAD Cvgs "','241','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','241',NULL,'VSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSAD Termination Date "','242','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','242',NULL,'VSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLI Cvgs "','243','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','243',NULL,'VCLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLI Termination Date "','244','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','244',NULL,'VCLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Policy Number "','245','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','245',NULL,'VWI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Bill Location AC Number "','246','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','246',NULL,'VWI Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Sort Group "','247','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','247',NULL,'VWI Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Eff Date "','248','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','248',NULL,'VWI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Plan Code "','249','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','249',NULL,'VWI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Class Code "','250','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','250',NULL,'VWI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Benefit Amt "','251','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','251',NULL,'VWI Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Elim Period "','252','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','252',NULL,'VWI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Benefit Duration "','253','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','253',NULL,'VWI Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Termination Date "','254','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','254',NULL,'VWI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Policy Number "','255','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','255',NULL,'VLTD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Bill Location AC Number "','256','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','256',NULL,'VLTD Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Sort Group "','257','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','257',NULL,'VLTD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Eff Date "','258','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','258',NULL,'VLTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Plan Code "','259','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','259',NULL,'VLTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Class Code "','260','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','260',NULL,'VLTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Amt "','261','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','261',NULL,'VLTD Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Elim Period "','262','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','262',NULL,'VLTD Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Duration "','263','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','263',NULL,'VLTD Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Pct "','264','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','264',NULL,'VLTD Benefit Pct',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Termination Date "','265','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','265',NULL,'VLTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Policy Number "','266','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','266',NULL,'STAD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Bill Location AC Number "','267','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','267',NULL,'STAD Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Sort Group "','268','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','268',NULL,'STAD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Eff Date "','269','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','269',NULL,'STAD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Plan Code "','270','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','270',NULL,'STAD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Class Code "','271','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','271',NULL,'STAD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVAD Cvgs "','272','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','272',NULL,'STVAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVAD Termination Date "','273','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','273',NULL,'STVAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVSAD Cvgs "','274','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','274',NULL,'STVSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVSAD Termination Date "','275','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','275',NULL,'STVSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVCAD Cvgs "','276','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','276',NULL,'STVCAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVCAD Termination Date "','277','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','277',NULL,'STVCAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualifying Event Code "','278','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','278',NULL,'Qualifying Event Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualifying Event Eff Date "','279','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','279',NULL,'Qualifying Event Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Smoker "','280','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','280',NULL,'Mbr Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Smoker  "','281','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','281',NULL,'Spouse Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse DOB "','282','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','282',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name "','283','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name "','284','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I  "','285','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender "','286','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB "','287','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code "','288','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code "','289','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN "','290','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','290',NULL,'Dep Disabled YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator "','291','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP  "','292','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 2"','293','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 2"','294','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I  2"','295','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 2"','296','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 2"','297','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 2"','298','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 2"','299','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 2"','300','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','290',NULL,'Dep Disabled YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 2"','301','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 2"','302','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 3"','303','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 3"','304','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I  3"','305','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 3"','306','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 3"','307','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 3"','308','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 3"','309','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 3"','400','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','290',NULL,'Dep Disabled YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 3"','401','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 3"','402','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 4"','403','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 4"','404','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I  4"','405','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 4"','406','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 4"','407','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 4"','408','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 4"','409','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 4"','410','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','290',NULL,'Dep Disabled YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 4"','411','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 4"','412','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 5"','413','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 5"','414','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I  5"','415','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 5"','416','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 5"','417','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 5"','418','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 5"','419','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 5"','420','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','290',NULL,'Dep Disabled YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 5"','421','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 5"','422','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 6"','423','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 6"','424','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I  6"','425','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 6"','426','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 6"','427','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 6"','428','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 6"','429','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 6"','430','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','290',NULL,'Dep Disabled YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 6"','431','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 6"','432','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 7"','433','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 7"','434','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I  7"','435','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 7"','436','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 7"','437','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 7"','438','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 7"','439','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 7"','440','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','290',NULL,'Dep Disabled YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 7"','441','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 7"','442','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 8"','443','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 8"','444','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I  8"','445','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 8"','446','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 8"','447','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 8"','448','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 8"','449','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 8"','450','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','290',NULL,'Dep Disabled YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 8"','451','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 8"','452','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name 9"','453','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name 9"','454','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I  9"','455','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender 9"','456','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB 9"','457','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code 9"','458','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code 9"','459','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN 9"','460','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','290',NULL,'Dep Disabled YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator 9"','461','(''DA''=''T,'')','ELININSEXPZ0','50','H','02','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP 9"','462','(''DA''=''T'')','ELININSEXPZ0','50','H','02','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','1','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','1',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChangeDate"','2','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','2',NULL,'Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepChangeDate"','3','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','3',NULL,'Dep Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','4','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','4',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrFirstName"','5','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','5',NULL,'Mbr First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrLastName"','6','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','6',NULL,'Mbr Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrMiddleInitial"','7','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','7',NULL,'Mbr Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrSSN"','8','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','8',NULL,'Mbr SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrGender"','9','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','9',NULL,'Mbr Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrDateOfBirth"','10','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','10',NULL,'Mbr DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAppSignDate"','11','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','11',NULL,'App Sign Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupation"','12','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','12',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourPerWeek"','13','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','13',NULL,'Hrs Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt"','14','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','14',NULL,'Salary Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryCode"','15','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','15',NULL,'Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalEffDate"','16','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','16',NULL,'Sal Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrAddrOne"','17','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','17',NULL,'Mbr Addr 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrAddrTwo"','18','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','18',NULL,'Mbr Addr 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrCity"','19','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','19',NULL,'Mbr City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrState"','20','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','20',NULL,'Mbr State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrZipCode"','21','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','21',NULL,'Mbr Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrZipPlusFour"','22','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','22',NULL,'Mbr Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','23','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','23',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','24','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','24',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExt"','25','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','25',NULL,'Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','26','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','26',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBenEligbility"','27','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','27',NULL,'Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubsDateOfBen"','28','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','28',NULL,'Subsequent Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReasonPriorLossBenElig"','29','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','29',NULL,'Reason for Prior Loss of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneFirstName"','30','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','30',NULL,'Pri Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneLastName"','31','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','31',NULL,'Pri Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneMiddleInit"','32','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','32',NULL,'Pri Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneRelationship"','33','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','33',NULL,'Pri Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneAddressOne"','34','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','34',NULL,'Pri Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneAddressTwo"','35','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','35',NULL,'Pri Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneCity"','36','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','36',NULL,'Pri Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneState"','37','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','37',NULL,'Pri Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneZipCode"','38','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','38',NULL,'Pri Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneZipPlusFour"','39','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','39',NULL,'Pri Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProBeneSSN"','40','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','40',NULL,'Pri Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneFirstName"','41','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','41',NULL,'Co Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneLastName"','42','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','42',NULL,'Co Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneMiddleInit"','43','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','43',NULL,'Co Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneRelationship"','44','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','44',NULL,'Co Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneAddressOne"','45','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','45',NULL,'Co Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneAddressTwo"','46','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','46',NULL,'Co Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneCity"','47','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','47',NULL,'Co Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneState"','48','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','48',NULL,'Co Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneZipCode"','49','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','49',NULL,'Co Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneZipPlusFour"','50','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','50',NULL,'Co Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneSSN"','51','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','51',NULL,'Co Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneficiaryComments"','52','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','52',NULL,'Beneficiary Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentPolicyNumber"','53','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','53',NULL,'Accident Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentBillLocACNumber"','54','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','54',NULL,'Accident Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSortGroup"','55','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','55',NULL,'Accident Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentEffDate"','56','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','56',NULL,'Accident Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentPlanCode"','57','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','57',NULL,'Accident Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentClassCode"','58','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','58',NULL,'Accident Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentTierCode"','59','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','59',NULL,'Accident Tier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHealthAssesTier"','60','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','60',NULL,'Health Asses Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHospitalTier"','61','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','61',NULL,'Hospital Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentDisabilityAmt"','62','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','62',NULL,'Accident Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentDiTier"','63','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','63',NULL,'Accident DI Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentDiBenefitPeriod"','64','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','64',NULL,'Accident DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentDiElimPeriod"','65','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','65',NULL,'Accident DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSicknessDisaAmt"','66','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','66',NULL,'Accident Sickness Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSickTier"','67','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','67',NULL,'Accidentsick Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSickDiBenePer"','68','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','68',NULL,'Accidentsick DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSickDiElimPer"','69','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','69',NULL,'Accidentsick DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentTermDate"','70','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','70',NULL,'Accident Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessPolicyNum"','71','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','71',NULL,'Critical Illness Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessBillLocAC"','72','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','72',NULL,'Critical Illness Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessSortGrp"','73','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','73',NULL,'Critical Illness Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessEffDate"','74','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','74',NULL,'Critical Illness Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessPlanCode"','75','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','75',NULL,'Critical Illness Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessClassCode"','76','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','76',NULL,'Critical Illness Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDritIllnessTErmDate"','77','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','77',NULL,'Critical Illness Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEePrincSumAmtApprove"','78','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','78',NULL,'EE Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEePrincSumAmtPend"','79','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','79',NULL,'EE Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpPrincSumAmtApprove"','80','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','80',NULL,'SP Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpPrincSumAmtPend"','81','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','81',NULL,'SP Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChPrincSumAmtApprove"','82','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','82',NULL,'CH Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChPrincSumAmtPend"','83','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','83',NULL,'CH Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeHeartAmtApprove"','84','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','84',NULL,'EE Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeHeartAmtPend"','85','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','85',NULL,'EE Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpHeartAmtApprove"','86','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','86',NULL,'SP Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpHeartAmtPend"','87','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','87',NULL,'SP Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChHeartAmtApprove"','88','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','88',NULL,'CH Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChHeartAmtPend"','89','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','89',NULL,'CH Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeCancerAmtApprove"','90','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','90',NULL,'EE Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeCancerAmtPend"','91','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','91',NULL,'EE Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpCancerAmtApprove"','92','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','92',NULL,'SP Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpCancerAmtPend"','93','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','93',NULL,'SP Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChCancerAmtApprove"','94','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','94',NULL,'CH Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChCancerAmtPend"','95','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','95',NULL,'CH Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeOrganAmtApprove"','96','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','96',NULL,'EE Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeOrganAmtPend"','97','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','97',NULL,'EE Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpOrganAmtApprove"','98','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','98',NULL,'SP Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpOrganAmtPend"','99','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','99',NULL,'SP Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChOrganAmtApprove"','100','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','100',NULL,'CH Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChOrganAmtPend"','101','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','101',NULL,'CH Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeQualOfLifeAmtApprove"','102','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','102',NULL,'EE Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeQualOfLifeAmtPend"','103','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','103',NULL,'EE Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpQualOfLifeAmtApprove"','104','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','104',NULL,'SP Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpQualOfLifeAmtPend"','105','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','105',NULL,'SP Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChQualOfLifeAmtApprove"','106','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','106',NULL,'CH Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChQualOfLifeAmtPend"','107','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','107',NULL,'CH Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildCatAmtApprove"','108','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','108',NULL,'Child Category Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildCatAmtPend"','109','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','109',NULL,'Child Category Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeTreatmentCareYN"','110','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','110',NULL,'EE Treatment Care Y N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpTreatmentCareYN"','111','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','111',NULL,'SP Treatment Care YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChTreatmentCareYN"','112','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','112',NULL,'CH Treatment Care YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeDiYN"','113','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','113',NULL,'EE DI YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpDiYN"','114','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','114',NULL,'SP DI YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeAccidentYN"','115','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','115',NULL,'EE Accident YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpAccidentYN"','116','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','116',NULL,'SP Accident YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChAccidentYN"','117','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','117',NULL,'CH Accident YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeOccHivYN"','118','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','118',NULL,'EE OccHIV YN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePolicyNumber"','119','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','119',NULL,'Life Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeBillLocACNumber"','120','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','120',NULL,'Life Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeSortGroup"','121','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','121',NULL,'Life Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeEffDate"','122','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','122',NULL,'Life Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlanCode"','123','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','123',NULL,'Life Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeClassCode"','124','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','124',NULL,'Life Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLiCvgs"','125','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','125',NULL,'LI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLiTerminationDate"','126','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','126',NULL,'LI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdCvgs"','127','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','127',NULL,'AD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdTerminationDate"','128','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','128',NULL,'AD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDliCvgs"','129','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','129',NULL,'DLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDliTerminationDate"','130','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','130',NULL,'DLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDadCvgs"','131','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','131',NULL,'DAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDadTerminationDate"','132','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','132',NULL,'DAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOliCvgs"','133','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','133',NULL,'OLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOliTerminationDate"','134','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','134',NULL,'OLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOadCvgs"','135','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','135',NULL,'OAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOadTerminationDate"','136','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','136',NULL,'OAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOdliCvgs"','137','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','137',NULL,'ODLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOdliTerminationDate"','138','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','138',NULL,'ODLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOdadCvgs"','139','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','139',NULL,'ODAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOdadTerminationDate"','140','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','140',NULL,'ODAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSliCvgs"','141','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','141',NULL,'SLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSliTerminationDate"','142','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','142',NULL,'SLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSadCvgs"','143','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','143',NULL,'SAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSadTerminationDate"','144','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','144',NULL,'SAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCliCvgs"','145','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','145',NULL,'CLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCliTerminationDate"','146','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','146',NULL,'CLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOsliCvgs"','147','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','147',NULL,'OSLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOsliTerminationDate"','148','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','148',NULL,'OSLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOsadCvgs"','149','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','149',NULL,'OSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOsadTerminationDate"','150','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','150',NULL,'OSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOcliCvgs"','151','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','151',NULL,'OCLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOcliTerminationDate"','152','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','152',NULL,'OCLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiPolicyNumber"','153','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','153',NULL,'WI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiBillLocACNumber"','154','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','154',NULL,'WI Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiSortGroup"','155','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','155',NULL,'WI Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiEffDate"','156','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','156',NULL,'WI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiPlanCode"','157','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','157',NULL,'WI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiClassCode"','158','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','158',NULL,'WI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiCvgs"','159','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','159',NULL,'WI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiTerminationDate"','160','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','160',NULL,'WI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOwiCvgs"','161','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','161',NULL,'OWI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOwiTerminationDate"','162','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','162',NULL,'OWI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdPolicyNum"','163','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','163',NULL,'LTD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdBillLocACNum"','164','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','164',NULL,'LTD Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdSortGroup"','165','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','165',NULL,'LTD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdEffDate"','166','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','166',NULL,'LTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdPlanCode"','167','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','167',NULL,'LTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdClassCode"','168','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','168',NULL,'LTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdCvgs"','169','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','169',NULL,'LTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdTerminationDate"','170','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','170',NULL,'LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOltdCvgs"','171','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','171',NULL,'OLTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOltdTerminationDate"','172','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','172',NULL,'OLTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiCvgs"','173','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','173',NULL,'CI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiTerminationDate"','174','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','174',NULL,'CI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentPolicyNumber"','175','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','175',NULL,'Dent Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentBillLocACNBR"','176','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','176',NULL,'Dent Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentSortGroup"','177','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','177',NULL,'Dent Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentEff"','178','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','178',NULL,'Dent Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentPlanCode"','179','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','179',NULL,'Dent Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentClassCode"','180','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','180',NULL,'Dent Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentCoverageCode"','181','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','181',NULL,'Dent Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentOtherIns"','182','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','182',NULL,'Dent Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentTerminationDate"','183','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','183',NULL,'Dent Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoPolicyNumber"','184','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','184',NULL,'DHMO Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoBillLocACNumber"','185','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','185',NULL,'DHMO Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoSortGroup"','186','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','186',NULL,'DHMO Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoEffDate"','187','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','187',NULL,'DHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoPlanCode"','188','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','188',NULL,'DHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoClassCode"','189','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','189',NULL,'DHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoCoverageTier"','190','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','190',NULL,'DHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoPcp"','191','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','191',NULL,'DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoTerminationDate"','192','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','192',NULL,'DHMO Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcPolicyNumber"','193','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','193',NULL,'LVC Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcBillLocACNumber"','194','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','194',NULL,'LVC Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcSortGroup"','195','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','195',NULL,'LVC Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcEffDate"','196','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','196',NULL,'LVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcPlanCode"','197','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','197',NULL,'LVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcClassCode"','198','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','198',NULL,'LVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcCoverageTier"','199','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','199',NULL,'LVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcOtherIns"','200','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','200',NULL,'LVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcTerminationDate"','201','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','201',NULL,'LVC Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcPolicyNumber"','202','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','202',NULL,'VLVC Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcBillLocACNumber"','203','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','203',NULL,'VLVC Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcSortGroup"','204','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','204',NULL,'VLVC Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcEffDate"','205','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','205',NULL,'VLVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcPlanCode"','206','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','206',NULL,'VLVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcClassCode"','207','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','207',NULL,'VLVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcCoverageTier"','208','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','208',NULL,'VLVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcOtherIns"','209','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','209',NULL,'VLVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcTerminationDate"','210','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','210',NULL,'VLVC Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnPolicyNumber"','211','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','211',NULL,'VDN Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnCillLocationACNum"','212','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','212',NULL,'VDN Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnSortGroup"','213','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','213',NULL,'VDN Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnEffDate"','214','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','214',NULL,'VDN Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnPlanCode"','215','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','215',NULL,'VDN Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnClassCode"','216','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','216',NULL,'VDN Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnCoverageTier"','217','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','217',NULL,'VDN Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnOtherIns"','218','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','218',NULL,'VDN Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnTerminationDate"','219','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','219',NULL,'VDN Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoPolicyNumber"','220','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','220',NULL,'VDHMO Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoBillLocationACNum"','221','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','221',NULL,'VDHMO Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoSortGroup"','222','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','222',NULL,'VDHMO Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoEffDate"','223','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','223',NULL,'VDHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoPlanCode"','224','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','224',NULL,'VDHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoClassCode"','225','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','225',NULL,'VDHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoCoverageTier"','226','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','226',NULL,'VDHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoPcp"','227','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','227',NULL,'VDHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoTerminationDate"','228','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','228',NULL,'VDHMO Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifPolicyNumber"','229','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','229',NULL,'VLIF Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifBillLocationACNum"','230','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','230',NULL,'VLIF Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifSortGroup"','231','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','231',NULL,'VLIF Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifEffDate"','232','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','232',NULL,'VLIF Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifPlanCode"','233','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','233',NULL,'VLIF Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifClassCode"','234','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','234',NULL,'VLIF Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifCvgs"','235','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','235',NULL,'VLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifTerminationDate"','236','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','236',NULL,'VLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVadCvgs"','237','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','237',NULL,'VAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVadTerminationDate"','238','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','238',NULL,'VAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVsliCvgs"','239','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','239',NULL,'VSLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVsliTerminationDate"','240','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','240',NULL,'VSLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVsadCvgs"','241','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','241',NULL,'VSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVsadTerminationDate"','242','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','242',NULL,'VSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVcliCvgs"','243','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','243',NULL,'VCLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVcliTerminationDate"','244','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','244',NULL,'VCLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiPolicyNumber"','245','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','245',NULL,'VWI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiBillLocationACNumber"','246','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','246',NULL,'VWI Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiSortGroup"','247','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','247',NULL,'VWI Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiEffDate"','248','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','248',NULL,'VWI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiPlanCode"','249','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','249',NULL,'VWI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiClassCode"','250','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','250',NULL,'VWI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiBenefitAmt"','251','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','251',NULL,'VWI Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiElimPeriod"','252','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','252',NULL,'VWI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiBenefitDuration"','253','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','253',NULL,'VWI Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiTerminationDate"','254','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','254',NULL,'VWI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdPolicyNumber"','255','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','255',NULL,'VLTD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdBillLocationACNum"','256','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','256',NULL,'VLTD Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdSortGroup"','257','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','257',NULL,'VLTD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdEffDate"','258','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','258',NULL,'VLTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdPlanCode"','259','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','259',NULL,'VLTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdClassCode"','260','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','260',NULL,'VLTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdBenefitAmt"','261','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','261',NULL,'VLTD Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdElimPeriod"','262','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','262',NULL,'VLTD Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdBenefitDuration"','263','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','263',NULL,'VLTD Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdBenefitPct"','264','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','264',NULL,'VLTD Benefit Pct',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdTerminationDate"','265','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','265',NULL,'VLTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadPolicyNumber"','266','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','266',NULL,'STAD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadBillLocationACNum"','267','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','267',NULL,'STAD Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadSortGroup"','268','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','268',NULL,'STAD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadEffDate"','269','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','269',NULL,'STAD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadPlanCode"','270','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','270',NULL,'STAD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadClassCode"','271','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','271',NULL,'STAD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvadCvgs"','272','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','272',NULL,'STVAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvadTerminationDate"','273','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','273',NULL,'STVAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvsadCvgs"','274','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','274',NULL,'STVSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvsadTerminationDate"','275','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','275',NULL,'STVSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvcadCvgs"','276','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','276',NULL,'STVCAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvcadTerminationDate"','277','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','277',NULL,'STVCAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifyingEventCode"','278','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','278',NULL,'Qualifying Event Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifyingEventEffDate"','279','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','279',NULL,'Qualifying Event Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrSmoker"','280','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','280',NULL,'Mbr Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrSpouseSmoker"','281','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','281',NULL,'Spouse Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpoudDateOfBirth"','282','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','282',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName"','283','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName"','284','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial"','285','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender"','286','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth"','287','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode"','288','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode"','289','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN"','290','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','290',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator"','291','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp"','292','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName2"','293','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName2"','294','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial2"','295','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender2"','296','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth2"','297','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode2"','298','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode2"','299','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN2"','300','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','290',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator2"','301','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp2"','302','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName3"','303','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName3"','304','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial3"','305','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender3"','306','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth3"','307','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode3"','308','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode3"','309','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN3"','310','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','290',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator3"','311','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp3"','312','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName4"','313','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName4"','314','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial4"','315','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender4"','316','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth4"','317','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode4"','318','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode4"','319','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN4"','320','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','290',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator4"','321','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp4"','322','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName5"','323','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName5"','324','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial5"','325','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender5"','326','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth5"','327','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode5"','328','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode5"','329','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN5"','330','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','290',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator5"','331','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp5"','332','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName6"','333','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName6"','334','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial6"','335','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender6"','336','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth6"','337','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode6"','338','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode6"','339','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN6"','340','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','290',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator6"','341','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp6"','342','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName7"','343','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName7"','344','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial7"','345','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender7"','346','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth7"','347','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode7"','348','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode7"','349','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN7"','350','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','290',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator7"','351','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp7"','352','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName8"','353','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName8"','354','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial8"','355','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender8"','356','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth8"','357','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode8"','358','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode8"','359','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN8"','360','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','290',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator8"','361','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp8"','362','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName9"','363','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName9"','364','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial9"','365','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender9"','366','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth9"','367','(''UD101''=''T,'')','ELININSEXPZ0','50','D','10','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode9"','368','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode9"','369','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN9"','370','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','290',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator9"','371','(''UA''=''T,'')','ELININSEXPZ0','50','D','10','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp9"','372','(''UA''=''T'')','ELININSEXPZ0','50','D','10','292',NULL,'Dep DHMO PCP',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ELININSEXP_20210625.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201911089','EMPEXPORT','OEACTIVE',NULL,'ELININSEXP',NULL,NULL,NULL,'201911089','Nov  8 2019 11:11AM','Nov  8 2019 11:11AM','201911081',NULL,'','','201911081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201911089','EMPEXPORT','OEPASSIVE',NULL,'ELININSEXP',NULL,NULL,NULL,'201911089','Nov  8 2019 11:11AM','Nov  8 2019 11:11AM','201911081',NULL,'','','201911081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Lincoln Financial Export','201911089','EMPEXPORT','ONDEMAND',NULL,'ELININSEXP',NULL,NULL,NULL,'201911089','Nov  8 2019 11:11AM','Nov  8 2019 11:11AM','201911081',NULL,'','','201911081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201911089','EMPEXPORT','SCH_LINXP',NULL,'ELININSEXP',NULL,NULL,NULL,'201911089','Nov  8 2019 11:11AM','Nov  8 2019 11:11AM','201911081',NULL,'','','201911081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','7R0E6,7R0OE,7R0UX,7R11P,7R2KY,7R17T,L1WBP,7R1E4,7R1LH,7R45U,7R3ZF,7R42Z,7R3D6,NKRBQ,7R2AZ,7R2T2,7R2YY,7R1Z2,7R24W,7R3HS,7R38Q,7R2GG,L1X2P,7R3QR,7R3VQ,7R1UM,LVQ1K',NULL,NULL,NULL,'Test Purposes Only','202106229','EMPEXPORT','TEST','Jun 21 2021  2:33PM','ELININSEXP',NULL,NULL,NULL,'202106229','Jun 22 2021 12:00AM','Dec 30 1899 12:00AM','202106221','467','','','202106221',dbo.fn_GetTimedKey(),NULL,'us3lKiINS1017',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELININSEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELININSEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELININSEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELININSEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELININSEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ELININSEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ELININSEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ELININSEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELININSEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELININSEXP','H02','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELININSEXP','D10','dbo.U_ELININSEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ELININSEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELININSEXP] (
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
IF OBJECT_ID('U_ELININSEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ELININSEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ELININSEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELININSEXP_drvTbl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvChangeDate] datetime NULL,
    [drvDepChangeDate] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvMbrFirstName] varchar(100) NULL,
    [drvMbrLastName] varchar(100) NULL,
    [drvMbrMiddleInitial] varchar(1) NULL,
    [drvMbrSSN] char(11) NULL,
    [drvMbrGender] char(1) NULL,
    [drvMbrDateOfBirth] datetime NULL,
    [drvAppSignDate] datetime NULL,
    [drvOccupation] varchar(25) NOT NULL,
    [drvHourPerWeek] varchar(30) NULL,
    [drvSalaryAmt] varchar(30) NULL,
    [drvSalaryCode] varchar(1) NOT NULL,
    [drvSalEffDate] datetime NULL,
    [drvMbrAddrOne] varchar(255) NULL,
    [drvMbrAddrTwo] varchar(255) NULL,
    [drvMbrCity] varchar(255) NULL,
    [drvMbrState] varchar(255) NULL,
    [drvMbrZipCode] varchar(50) NULL,
    [drvMbrZipPlusFour] varchar(1) NOT NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvWorkPhoneExt] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(1) NOT NULL,
    [drvDateOfBenEligbility] datetime NULL,
    [drvSubsDateOfBen] datetime NULL,
    [drvReasonPriorLossBenElig] varchar(11) NULL,
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
    [drvProBeneSSN] varchar(1) NOT NULL,
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
    [drvDritIllnessTErmDate] varchar(1) NOT NULL,
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
    [drvDentEff] datetime NULL,
    [drvDentPlanCode] varchar(1) NULL,
    [drvDentClassCode] varchar(1) NULL,
    [drvDentCoverageCode] varchar(1) NULL,
    [drvDentOtherIns] varchar(1) NULL,
    [drvDentTerminationDate] datetime NULL,
    [drvDhmoPolicyNumber] varchar(1) NOT NULL,
    [drvDhmoBillLocACNumber] varchar(1) NOT NULL,
    [drvDhmoSortGroup] varchar(1) NOT NULL,
    [drvDhmoEffDate] varchar(1) NOT NULL,
    [drvDhmoPlanCode] varchar(1) NOT NULL,
    [drvDhmoClassCode] varchar(1) NOT NULL,
    [drvDhmoCoverageTier] varchar(1) NOT NULL,
    [drvDhmoPcp] varchar(1) NOT NULL,
    [drvDhmoTerminationDate] varchar(1) NOT NULL,
    [drvLvcPolicyNumber] varchar(18) NULL,
    [drvLvcBillLocACNumber] varchar(7) NULL,
    [drvLvcSortGroup] varchar(1) NOT NULL,
    [drvLvcEffDate] datetime NULL,
    [drvLvcPlanCode] varchar(1) NULL,
    [drvLvcClassCode] varchar(1) NULL,
    [drvLvcCoverageTier] varchar(1) NULL,
    [drvLvcOtherIns] varchar(1) NULL,
    [drvLvcTerminationDate] datetime NULL,
    [drvVlvcPolicyNumber] varchar(1) NOT NULL,
    [drvVlvcBillLocACNumber] varchar(1) NOT NULL,
    [drvVlvcSortGroup] varchar(1) NOT NULL,
    [drvVlvcEffDate] varchar(1) NOT NULL,
    [drvVlvcPlanCode] varchar(1) NOT NULL,
    [drvVlvcClassCode] varchar(1) NOT NULL,
    [drvVlvcCoverageTier] varchar(1) NOT NULL,
    [drvVlvcOtherIns] varchar(1) NOT NULL,
    [drvVlvcTerminationDate] varchar(1) NOT NULL,
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
    [drvVlifCvgs] varchar(34) NULL,
    [drvVlifTerminationDate] datetime NULL,
    [drvVadCvgs] varchar(34) NULL,
    [drvVadTerminationDate] datetime NULL,
    [drvVsliCvgs] varchar(35) NULL,
    [drvVsliTerminationDate] datetime NULL,
    [drvVsadCvgs] varchar(35) NULL,
    [drvVsadTerminationDate] datetime NULL,
    [drvVcliCvgs] varchar(9) NULL,
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
    [drvMbrSpouseSmoker] varchar(1) NULL,
    [drvSpoudDateOfBirth] datetime NULL,
    [drvDepFirstName] varchar(100) NULL,
    [drvDepLastName] varchar(100) NULL,
    [drvDepMiddleInitial] varchar(50) NULL,
    [drvDepGender] char(1) NULL,
    [drvDepDateOfBirth] datetime NULL,
    [drvDepRelationshipCode] varchar(1) NULL,
    [drvDepStudentCode] varchar(1) NULL,
    [drvDepDisabledYN] char(1) NULL,
    [drvDepCvgIndicator] nvarchar(258) NULL,
    [drvDedDhmoPcp] varchar(1) NOT NULL,
    [drvDepFirstName2] varchar(100) NULL,
    [drvDepLastName2] varchar(100) NULL,
    [drvDepMiddleInitial2] varchar(50) NULL,
    [drvDepGender2] char(1) NULL,
    [drvDepDateOfBirth2] datetime NULL,
    [drvDepRelationshipCode2] varchar(1) NULL,
    [drvDepStudentCode2] varchar(1) NULL,
    [drvDepDisabledYN2] char(1) NULL,
    [drvDepCvgIndicator2] nvarchar(258) NULL,
    [drvDedDhmoPcp2] varchar(1) NOT NULL,
    [drvDepFirstName3] varchar(100) NULL,
    [drvDepLastName3] varchar(100) NULL,
    [drvDepMiddleInitial3] varchar(50) NULL,
    [drvDepGender3] char(1) NULL,
    [drvDepDateOfBirth3] datetime NULL,
    [drvDepRelationshipCode3] varchar(1) NULL,
    [drvDepStudentCode3] varchar(1) NULL,
    [drvDepDisabledYN3] char(1) NULL,
    [drvDepCvgIndicator3] nvarchar(258) NULL,
    [drvDedDhmoPcp3] varchar(1) NOT NULL,
    [drvDepFirstName4] varchar(100) NULL,
    [drvDepLastName4] varchar(100) NULL,
    [drvDepMiddleInitial4] varchar(50) NULL,
    [drvDepGender4] char(1) NULL,
    [drvDepDateOfBirth4] datetime NULL,
    [drvDepRelationshipCode4] varchar(1) NULL,
    [drvDepStudentCode4] varchar(1) NULL,
    [drvDepDisabledYN4] char(1) NULL,
    [drvDepCvgIndicator4] nvarchar(258) NULL,
    [drvDedDhmoPcp4] varchar(1) NOT NULL,
    [drvDepFirstName5] varchar(100) NULL,
    [drvDepLastName5] varchar(100) NULL,
    [drvDepMiddleInitial5] varchar(50) NULL,
    [drvDepGender5] char(1) NULL,
    [drvDepDateOfBirth5] datetime NULL,
    [drvDepRelationshipCode5] varchar(1) NULL,
    [drvDepStudentCode5] varchar(1) NULL,
    [drvDepDisabledYN5] char(1) NULL,
    [drvDepCvgIndicator5] nvarchar(258) NULL,
    [drvDedDhmoPcp5] varchar(1) NOT NULL,
    [drvDepFirstName6] varchar(100) NULL,
    [drvDepLastName6] varchar(100) NULL,
    [drvDepMiddleInitial6] varchar(50) NULL,
    [drvDepGender6] char(1) NULL,
    [drvDepDateOfBirth6] datetime NULL,
    [drvDepRelationshipCode6] varchar(1) NULL,
    [drvDepStudentCode6] varchar(1) NULL,
    [drvDepDisabledYN6] char(1) NULL,
    [drvDepCvgIndicator6] nvarchar(258) NULL,
    [drvDedDhmoPcp6] varchar(1) NOT NULL,
    [drvDepFirstName7] varchar(100) NULL,
    [drvDepLastName7] varchar(100) NULL,
    [drvDepMiddleInitial7] varchar(50) NULL,
    [drvDepGender7] char(1) NULL,
    [drvDepDateOfBirth7] datetime NULL,
    [drvDepRelationshipCode7] varchar(1) NULL,
    [drvDepStudentCode7] varchar(1) NULL,
    [drvDepDisabledYN7] char(1) NULL,
    [drvDepCvgIndicator7] nvarchar(258) NULL,
    [drvDedDhmoPcp7] varchar(1) NOT NULL,
    [drvDepFirstName8] varchar(100) NULL,
    [drvDepLastName8] varchar(100) NULL,
    [drvDepMiddleInitial8] varchar(50) NULL,
    [drvDepGender8] char(1) NULL,
    [drvDepDateOfBirth8] datetime NULL,
    [drvDepRelationshipCode8] varchar(1) NULL,
    [drvDepStudentCode8] varchar(1) NULL,
    [drvDepDisabledYN8] char(1) NULL,
    [drvDepCvgIndicator8] nvarchar(258) NULL,
    [drvDedDhmoPcp8] varchar(1) NOT NULL,
    [drvDepFirstName9] varchar(100) NULL,
    [drvDepLastName9] varchar(100) NULL,
    [drvDepMiddleInitial9] varchar(50) NULL,
    [drvDepGender9] char(1) NULL,
    [drvDepDateOfBirth9] datetime NULL,
    [drvDepRelationshipCode9] varchar(1) NULL,
    [drvDepStudentCode9] varchar(1) NULL,
    [drvDepDisabledYN9] char(1) NULL,
    [drvDepCvgIndicator9] nvarchar(258) NULL,
    [drvDedDhmoPcp9] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ELININSEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ELININSEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELININSEXP_File') IS NULL
CREATE TABLE [dbo].[U_ELININSEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELININSEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Inspire Communities

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 06/18/2021
Service Request Number: TekP-2021-04-02-0006

Purpose: Lincoln Financial Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELININSEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELININSEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELININSEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELININSEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELININSEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELININSEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELININSEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELININSEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELININSEXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELININSEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELININSEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELININSEXP';

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
    DELETE FROM dbo.U_ELININSEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELININSEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DENHI,DENLO,GLIFE,LTD,STD,SUPLC,SUPLE,SUPLS,VISC';

    IF OBJECT_ID('U_ELININSEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELININSEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELININSEXP_DedList
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


    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_ELININSEXP D
    JOIN dbo.U_dsi_bdm_ELININSEXP E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ELININSEXP
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ELININSEXP
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ELININSEXP
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ELININSEXP
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ELININSEXP
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ELININSEXP
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELININSEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELININSEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELININSEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvChangeDate = Change_DAte
        ,drvDepChangeDate = ''
        ,drvTerminationDate = Termination_Date
        ,drvMbrFirstName = EepNameFirst
        ,drvMbrLastName = EepNameLast
        ,drvMbrMiddleInitial = LEFT(Isnull(EepNameMiddle,''),1)
        ,drvMbrSSN = eepSSN
        ,drvMbrGender = EepGender
        ,drvMbrDateOfBirth = EepDateOfBirth
        ,drvAppSignDate = DateAdd(day,-1,Change_DAte)
        ,drvOccupation = JbcDesc
        ,drvHourPerWeek = CAST( CONVERT(DECIMAL(10,2),(EecScheduledWorkHrs  / 2)) as varchar)
        ,drvSalaryAmt = CAST(EecAnnSalary as varchar)
        ,drvSalaryCode = 'A'
        ,drvSalEffDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, getdate(),EecDateOfLastHire)   
        ,drvMbrAddrOne = EepAddressLine1
        ,drvMbrAddrTwo = EepAddressLine2
        ,drvMbrCity = EepAddressCity
        ,drvMbrState = EepAddressState
        ,drvMbrZipCode = EepAddressZipCode
        ,drvMbrZipPlusFour = ''
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = ''
        ,drvWorkPhoneExt = ''
        ,drvEmailAddress = ''
        ,drvDateOfBenEligbility = EecDateOfOriginalHire
        ,drvSubsDateOfBen = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvReasonPriorLossBenElig = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN 'TERMINATION' END
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
        ,drvProBeneSSN = ''
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
        ,drvDritIllnessTErmDate = ''
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
        --Start here
        ,drvLifePolicyNumber = CASE WHEN GLIFE is not null then '000010221390-00000' END
        ,drvLifeBillLocACNumber = CASE WHEN GLIFE is not null then '1568117' END
        ,drvLifeSortGroup = ''
        ,drvLifeEffDate = CASE WHEN GLIFE is not null then GLIFE_startDate END
        ,drvLifePlanCode = CASE WHEN GLIFE is not null then '1' END
        ,drvLifeClassCode = CASE WHEN GLIFE is not null then '1' END
        ,drvLiCvgs = CASE WHEN GLIFE is not null then 'LI-1' END
        ,drvLiTerminationDate = CASE WHEN GLIFE is not null then GLIFE_stopDate END
        ,drvAdCvgs = CASE WHEN GLIFE is not null then 'AD-1' END
        ,drvAdTerminationDate = CASE WHEN GLIFE is not null then GLIFE_stopDate END
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
        ,drvWiPolicyNumber = CASE WHEN STD IS NOT NULL THEN '000010221393-00000' END
        ,drvWiBillLocACNumber = CASE WHEN STD IS NOT NULL THEN '1568117' END
        ,drvWiSortGroup = ''
        ,drvWiEffDate = CASE WHEN STD IS NOT NULL THEN STD_startdate END
        ,drvWiPlanCode = CASE WHEN STD IS NOT NULL THEN '1' END
        ,drvWiClassCode = CASE WHEN STD IS NOT NULL THEN '2' END
        ,drvWiCvgs = CASE WHEN STD IS NOT NULL THEN 'WI-1' END
        ,drvWiTerminationDate = CASE WHEN STD IS NOT NULL THEN STD_stopDate END
        ,drvOwiCvgs = ''
        ,drvOwiTerminationDate = ''
        ,drvLtdPolicyNum = CASE WHEN LTD is not null then '000010221391-00000' END
        ,drvLtdBillLocACNum = CASE WHEN LTD is not null then '1568117' END
        ,drvLtdSortGroup = ''
        ,drvLtdEffDate = CASE WHEN LTD is not null then LTD_startDate END
        ,drvLtdPlanCode = CASE WHEN LTD is not null then '1' END
        ,drvLtdClassCode = CASE WHEN LTD is not null then '2' END
        ,drvLtdCvgs = CASE WHEN LTD is not null then 'LTD-1' END
        ,drvLtdTerminationDate = CASE WHEN LTD is not null then LTD_stopDate END
        ,drvOltdCvgs = ''
        ,drvOltdTerminationDate = ''
        ,drvCiCvgs = ''
        ,drvCiTerminationDate = ''


        ,drvDentPolicyNumber = CASE WHEN DENLO is not null then '00001D040083-00000' 
                                    WHEN DENHI is not null then '00001D033144-00000' 
                                END
        ,drvDentBillLocACNBR = CASE WHEN DENLO is not null or DENHI is not null then  '1568117' END
        ,drvDentSortGroup = ''
        ,drvDentEff = CASE WHEN DENLO IS NOT NULL THEN DENLO_startdate 
                           WHEN DENHI IS NOT NULL THEN DENHI_startdate
                      END
        ,drvDentPlanCode = CASE WHEN DENLO is not null or DENHI is not null then  '1' END
        ,drvDentClassCode = CASE WHEN DENLO is not null or DENHI is not null then  '1' END
        ,drvDentCoverageCode = CASE WHEN DENLO is not null or DENHI is not null then  
                                    CASE WHEN DENLO_benoption = 'EE' or DENHI_benoption = 'EE' THEN '1'
                                         WHEN DENLO_benoption = 'EES' or DENHI_benoption = 'EES' THEN '2'
                                         WHEN DENLO_benoption = 'EEC' or DENHI_benoption = 'EEC' THEN '3'
                                         WHEN DENLO_benoption = 'EEF' or DENHI_benoption = 'EEF' THEN '4'
                                    END
                                 END
        ,drvDentOtherIns = CASE WHEN DENLO is not null or DENHI is not null then  'U' END
        ,drvDentTerminationDate = CASE WHEN DENLO_stopdate is  not null then DENLO_stopdate 
                                       WHEN DENHI_stopdate is  not null then DENHI_stopdate 
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
        ,drvLvcPolicyNumber = CASE WHEN VISC is not null then '000010221392-00000' end
        ,drvLvcBillLocACNumber = CASE WHEN VISC is not null then '1568117' end
        ,drvLvcSortGroup = ''
        ,drvLvcEffDate = CASE WHEN VISC IS NOT NULL THEN VISC_startdate END
        ,drvLvcPlanCode = CASE WHEN VISC is not null then '1' end
        ,drvLvcClassCode = CASE WHEN VISC is not null then '1' end
        ,drvLvcCoverageTier = CASE WHEN VISC is not null then 
                                        CASE WHEN  VISC_benoption = 'EE' THEN '1'
                                         WHEN VISC_benoption = 'EES' THEN '2'
                                         WHEN VISC_benoption = 'EEC' THEN '3'
                                         WHEN VISC_benoption = 'EEF' THEN '4'
                                    END 
                             end
        ,drvLvcOtherIns = CASE WHEN VISC is not null then 'U' end
        ,drvLvcTerminationDate = CASE WHEN VISC is not null then VISC_stopdate end
        ,drvVlvcPolicyNumber = ''
        ,drvVlvcBillLocACNumber = ''
        ,drvVlvcSortGroup = ''
        ,drvVlvcEffDate = ''
        ,drvVlvcPlanCode = ''
        ,drvVlvcClassCode = ''
        ,drvVlvcCoverageTier = ''
        ,drvVlvcOtherIns = ''
        ,drvVlvcTerminationDate = ''
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
        ,drvVlifPolicyNumber = CASE WHEN SUPLE IS NOT NULL THEN '000400001000-21636' END
        ,drvVlifBillLocationACNum = CASE WHEN SUPLE IS NOT NULL THEN '1568117' END
        ,drvVlifSortGroup = ''
        ,drvVlifEffDate = CASE WHEN SUPLE IS NOT NULL THEN SUPLE_startdate END
        ,drvVlifPlanCode = CASE WHEN SUPLE IS NOT NULL THEN '1' END
        ,drvVlifClassCode = CASE WHEN SUPLE IS NOT NULL THEN '2' END
        ,drvVlifCvgs = CASE WHEN SUPLE IS NOT NULL THEN 'VLI-' + CAST(SUPLE_amount as varchar) END
        ,drvVlifTerminationDate = CASE WHEN SUPLE IS NOT NULL THEN SUPLE_stopdate END
        ,drvVadCvgs = CASE WHEN SUPLE IS NOT NULL THEN 'VAD-' + CAST(SUPLE_amount as varchar) END
        ,drvVadTerminationDate = CASE WHEN SUPLE IS NOT NULL THEN SUPLE_stopdate END
        ,drvVsliCvgs = CASE WHEN SUPLS IS NOT NULL THEN  'VSLI-' + CAST(SUPLS_amount as varchar) END --Need Amount
        ,drvVsliTerminationDate = CASE WHEN SUPLS IS NOT NULL THEN SUPLS_stopdate END
        ,drvVsadCvgs = CASE WHEN SUPLS  IS NOT NULL THEN 'VSAD-' + CAST(SUPLS_amount as varchar) END--Need Amount
        ,drvVsadTerminationDate = CASE WHEN SUPLS IS NOT NULL THEN SUPLS_stopdate END
        ,drvVcliCvgs = CASE WHEN SUPLC IS NOT NULL THEN 'VCL1-1000' END
        ,drvVcliTerminationDate = CASE WHEN SUPLC is not null then SUPLC_stopdate END
        --
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
        ,drvStvsadTerminationDate  = ''
        ,drvStvcadCvgs = ''
        ,drvStvcadTerminationDate = ''
        ,drvQualifyingEventCode = ''
        ,drvQualifyingEventEffDate = ''
        ,drvMbrSmoker = EepIsSmoker
        ,drvMbrSpouseSmoker = SPSSMoker
        ,drvSpoudDateOfBirth = SPSDateOfBirth
        ,drvDepFirstName = DepFirstName1
        ,drvDepLastName = DepLastName1
        ,drvDepMiddleInitial = DepMiddleName1
        ,drvDepGender = DepGender1
        ,drvDepDateOfBirth = DepDateOfBirth1
        ,drvDepRelationshipCode = DepRelationship1
        ,drvDepStudentCode = CASE WHEN DepFirstName1 is not null then 'N' END
        ,drvDepDisabledYN = DepIsDisabled1
        ,drvDepCvgIndicator = QuoteName(DedCode1,'"')
        ,drvDedDhmoPcp = ''
        ,drvDepFirstName2 = DepFirstName2
        ,drvDepLastName2 = DepLastName2
        ,drvDepMiddleInitial2 = DepMiddleName2
        ,drvDepGender2 = DepGender2
        ,drvDepDateOfBirth2 = DepDateOfBirth2
        ,drvDepRelationshipCode2 = DepRelationship2
        ,drvDepStudentCode2 = CASE WHEN DepFirstName2 is not null then 'N' END
        ,drvDepDisabledYN2 = DepIsDisabled2
        ,drvDepCvgIndicator2 =  QuoteName(DedCode2,'"')
        ,drvDedDhmoPcp2 = ''
        ,drvDepFirstName3 = DepFirstName3
        ,drvDepLastName3 = DepLastName3
        ,drvDepMiddleInitial3 = DepMiddleName3
        ,drvDepGender3 = DepGender3
        ,drvDepDateOfBirth3 = DepDateOfBirth3
        ,drvDepRelationshipCode3 = DepRelationship3
        ,drvDepStudentCode3 = CASE WHEN DepFirstName3 is not null then 'N' END
        ,drvDepDisabledYN3 = DepIsDisabled3
        ,drvDepCvgIndicator3 =  QuoteName(DedCode3,'"')
        ,drvDedDhmoPcp3 = ''
        ,drvDepFirstName4 = DepFirstName4
        ,drvDepLastName4 = DepLastName4
        ,drvDepMiddleInitial4 = DepMiddleName4
        ,drvDepGender4 = DepGender4
        ,drvDepDateOfBirth4 = DepDateOfBirth4
        ,drvDepRelationshipCode4 = DepRelationship4
        ,drvDepStudentCode4 = CASE WHEN DepFirstName4 is not null then 'N' END
        ,drvDepDisabledYN4 = DepIsDisabled4
        ,drvDepCvgIndicator4 =  QuoteName(DedCode4,'"')
        ,drvDedDhmoPcp4 = ''
        ,drvDepFirstName5 = DepFirstName5
        ,drvDepLastName5 = DepLastName5
        ,drvDepMiddleInitial5 = DepMiddleName5
        ,drvDepGender5 = DepGender5
        ,drvDepDateOfBirth5 = DepDateOfBirth5
        ,drvDepRelationshipCode5 = DepRelationship5
        ,drvDepStudentCode5 = CASE WHEN DepFirstName5 is not null then 'N' END
        ,drvDepDisabledYN5 = DepIsDisabled5
        ,drvDepCvgIndicator5 =  QuoteName(DedCode5,'"')
        ,drvDedDhmoPcp5 = ''
        ,drvDepFirstName6 = DepFirstName6
        ,drvDepLastName6 = DepLastName6
        ,drvDepMiddleInitial6 = DepMiddleName6
        ,drvDepGender6 = DepGender6
        ,drvDepDateOfBirth6 = DepDateOfBirth6
        ,drvDepRelationshipCode6 = DepRelationship6
        ,drvDepStudentCode6 = CASE WHEN DepFirstName6 is not null then 'N' END
        ,drvDepDisabledYN6 = DepIsDisabled6
        ,drvDepCvgIndicator6 =  QuoteName(DedCode6,'"')
        ,drvDedDhmoPcp6 = ''
        ,drvDepFirstName7 = DepFirstName7
        ,drvDepLastName7 = DepLastName7
        ,drvDepMiddleInitial7 = DepMiddleName7
        ,drvDepGender7 = DepGender7
        ,drvDepDateOfBirth7 = DepDateOfBirth7
        ,drvDepRelationshipCode7 = DepRelationship7
        ,drvDepStudentCode7 = CASE WHEN DepFirstName7 is not null then 'N' END
        ,drvDepDisabledYN7 = DepIsDisabled7
        ,drvDepCvgIndicator7 =  QuoteName(DedCode7,'"')
        ,drvDedDhmoPcp7 = ''
        ,drvDepFirstName8 = DepFirstName8
        ,drvDepLastName8 = DepLastName8
        ,drvDepMiddleInitial8 = DepMiddleName8
        ,drvDepGender8 = DepGender8
        ,drvDepDateOfBirth8 = DepDateOfBirth8
        ,drvDepRelationshipCode8 = DepRelationship8
        ,drvDepStudentCode8 = CASE WHEN DepFirstName8 is not null then 'N' END
        ,drvDepDisabledYN8 = DepIsDisabled8
        ,drvDepCvgIndicator8 =  QuoteName(DedCode8,'"')
        ,drvDedDhmoPcp8 = ''
        ,drvDepFirstName9 = DepFirstName9
        ,drvDepLastName9 = DepLastName9
        ,drvDepMiddleInitial9 = DepMiddleName9
        ,drvDepGender9 = DepGender9
        ,drvDepDateOfBirth9 = DepDateOfBirth9
        ,drvDepRelationshipCode9 = DepRelationship9
        ,drvDepStudentCode9 = CASE WHEN DepFirstName9 is not null then 'N' END
        ,drvDepDisabledYN9 = DepIsDisabled9
        ,drvDepCvgIndicator9 =  QuoteName(DedCode9,'"')
        ,drvDedDhmoPcp9 = ''
        INTO dbo.U_ELININSEXP_drvTbl
    FROM dbo.U_ELININSEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        on JbcJobCode =  EecJobCode
    JOIN (Select  A.bdmEEID,A.bdmcoid
            ,GLIFE  = MAX((CASE WHEN BDMDedCode = 'GLIFE ' then 'GLIFE' END))
            ,STD = MAX((CASE WHEN BDMDedCode = 'STD' then 'STD' END))
            ,LTD = MAX((CASE WHEN BDMDedCode = 'LTD' then 'LTD' END))

            ,VISC = MAX((CASE WHEN BDMDedCode = 'VISC' then 'VISC' END))
            ,DENHI  = MAX((CASE WHEN BDMDedCode = 'DENHI' then 'DENHI' END))
            ,DENLO   = MAX((CASE WHEN BDMDedCode = 'DENLO' then 'DENLO' END))
            ,SUPLE    = MAX((CASE WHEN BDMDedCode = 'SUPLE' then 'SUPLE' END))
            ,SUPLS    = MAX((CASE WHEN BDMDedCode = 'SUPLS' then 'SUPLS' END))
            ,SUPLC     = MAX((CASE WHEN BDMDedCode = 'SUPLC ' then 'SUPLC ' END))
            ,Change_Date = MAX(bdmbenstartdate)
            ,Termination_Date = MAX(bdmbenstopdate)

            ,GLIFE_startDate = MAX((CASE WHEN BDMDedCode = 'GLIFE' then bdmbenstartdate END))
            ,STD_startDate = MAX((CASE WHEN BDMDedCode = 'STD' then bdmbenstartdate END))
            ,LTD_startDate = MAX((CASE WHEN BDMDedCode = 'LTD' then bdmbenstartdate END))
            ,VISC_startdate = MAX((CASE WHEN BDMDedCode = 'VISC' then bdmbenstartdate END))
            ,DENHI_startdate = MAX((CASE WHEN BDMDedCode = 'DENHI' then bdmbenstartdate END))
            ,DENLO_startdate = MAX((CASE WHEN BDMDedCode = 'DENLO' then bdmbenstartdate END))
            ,SUPLE_startdate = MAX((CASE WHEN BDMDedCode = 'SUPLE' then bdmbenstartdate END))
            ,SUPLS_startdate = MAX((CASE WHEN BDMDedCode = 'SUPLS' then bdmbenstartdate END))
            ,SUPLC_startdate = MAX((CASE WHEN BDMDedCode = 'SUPLC' then bdmbenstartdate END))
            ,GLIFE_benoption = MAX((CASE WHEN BDMDedCode = 'GLIFE' then BdmBenOption END))
            ,STD_benoption = MAX((CASE WHEN BDMDedCode = 'STD' then BdmBenOption END))
            ,LTD_benoption = MAX((CASE WHEN BDMDedCode = 'LTD' then BdmBenOption END))
            ,VISC_benoption = MAX((CASE WHEN BDMDedCode = 'VISC' then BdmBenOption END))
            ,DENHI_benoption = MAX((CASE WHEN BDMDedCode = 'DENHI' then BdmBenOption END))
            ,DENLO_benoption = MAX((CASE WHEN BDMDedCode = 'DENLO' then BdmBenOption END))
            ,SUPLE_benoption = MAX((CASE WHEN BDMDedCode = 'SUPLE' then BdmBenOption END))
            ,SUPLS_benoption = MAX((CASE WHEN BDMDedCode = 'SUPLS' then BdmBenOption END))
            ,SUPLC_benoption = MAX((CASE WHEN BDMDedCode = 'SUPLC' then BdmBenOption END))

            ,GLIFE_stopDate = MAX((CASE WHEN BDMDedCode = 'GLIFE' then bdmbenstopdate END))
            ,STD_stopDate = MAX((CASE WHEN BDMDedCode = 'STD' then bdmbenstopdate END))
            ,LTD_stopDate = MAX((CASE WHEN BDMDedCode = 'LTD' then bdmbenstopdate END))
            ,VISC_stopdate = MAX((CASE WHEN BDMDedCode = 'VISC' then bdmbenstopdate END))
            ,DENHI_stopdate = MAX((CASE WHEN BDMDedCode = 'DENHI' then bdmbenstopdate END))
            ,DENLO_stopdate = MAX((CASE WHEN BDMDedCode = 'DENLO' then bdmbenstopdate END))
            ,SUPLE_stopdate = MAX((CASE WHEN BDMDedCode = 'SUPLE' then bdmbenstopdate END))
            ,SUPLS_stopdate = MAX((CASE WHEN BDMDedCode = 'SUPLS' then bdmbenstopdate END))
            ,SUPLC_stopdate = MAX((CASE WHEN BDMDedCode = 'SUPLC' then bdmbenstopdate END))
            ,SUPLE_amount = MAX((CASE WHEN BDMDedCode = 'SUPLE' then CONVERT(DECIMAL(10,0),BdmUSGField1) END))
            ,SUPLS_amount = MAX((CASE WHEN BDMDedCode = 'SUPLS' then CONVERT(DECIMAL(10,0),BdmUSGField1) END))
            ,SUPLC_amount = MAX((CASE WHEN BDMDedCode = 'SUPLC' then CONVERT(DECIMAL(10,0),BdmUSGField1) END))

            
            ,FSA = MAX((CASE WHEN BDMDedCode = 'FSA' then 'FSA' END))

            ,FSA_GoalAmt = MAX((CASE WHEN BDMDedCode = 'FSA' then BdmEEGoalAmt END))
            ,CobraEnventdate = MAX(BdmDateOfCOBRAEvent) 
            ,CobraStatusDate = MAX(BdmBenStatusDate) 
            ,BdmCobraReason = MAX(BdmCobraReason) 
            ,bdmbenstartdate = max(bdmbenstartdate)
            
            ,Count(CASE WHEN BdmRelationship IN ('SPS') and BdmDedcode = 'V' then 1 END) AS  Count_SPS
            ,Count(CASE WHEN BdmRelationship IN ('CHL') and BdmDedcode = 'V' then 1 END) AS  Count_CHL

            from dbo.U_dsi_BDM_ELININSEXP A
            
            group by A.bdmEEID,A.bdmcoid) as ConsolidatedBDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (Select bdmeeid AS KidEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS DepLastName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS DepFirstName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS DepSsn1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS DepDateOfBirth1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS DepRelationship1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameLast END) AS DepLastName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameFirst END) AS DepFirstName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConSSN END) AS DepSsn2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConDateOfBirth END) AS DepDateOfBirth2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConRelationship END) AS DepRelationship2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameLast END) AS DepLastName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameFirst END) AS DepFirstName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConSSN END) AS DepSsn3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConDateOfBirth END) AS DepDateOfBirth3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConRelationship END) AS DepRelationship3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameLast END) AS DepLastName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameFirst END) AS DepFirstName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConSSN END) AS DepSsn4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConDateOfBirth END) AS DepDateOfBirth4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConRelationship END) AS DepRelationship4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameLast END) AS DepLastName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameFirst END) AS DepFirstName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConSSN END) AS DepSsn5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConDateOfBirth END) AS DepDateOfBirth5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConRelationship END) AS DepRelationship5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameLast END) AS DepLastName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameFirst END) AS DepFirstName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConSSN END) AS DepSsn6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConDateOfBirth END) AS DepDateOfBirth6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConRelationship END) AS DepRelationship6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameLast END) AS DepLastName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameFirst END) AS DepFirstName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConSSN END) AS DepSsn7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConDateOfBirth END) AS DepDateOfBirth7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConRelationship END) AS DepRelationship7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameLast END) AS DepLastName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameFirst END) AS DepFirstName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConSSN END) AS DepSsn8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConDateOfBirth END) AS DepDateOfBirth8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConRelationship END) AS DepRelationship8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameLast END) AS DepLastName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameFirst END) AS DepFirstName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConSSN END) AS DepSsn9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConDateOfBirth END) AS DepDateOfBirth9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConRelationship END) AS DepRelationship9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameLast END) AS DepLastName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameFirst END) AS DepFirstName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConSSN END) AS DepSsn10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConDateOfBirth END) AS DepDateOfBirth10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConRelationship END) AS DepRelationship10
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameLast END) AS DepLastName11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameFirst END) AS DepFirstName11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConSSN END) AS DepSsn11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConDateOfBirth END) AS DepDateOfBirth11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConRelationship END) AS DepRelationship11
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConNameLast END) AS DepLastName12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConNameFirst END) AS DepFirstName12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConSSN END) AS DepSsn12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConDateOfBirth END) AS DepDateOfBirth12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConRelationship END) AS DepRelationship12
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameMiddle END) AS DepMiddleName1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameMiddle END) AS DepMiddleName2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameMiddle END) AS DepMiddleName3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameMiddle END) AS DepMiddleName4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameMiddle END) AS DepMiddleName5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameMiddle END) AS DepMiddleName6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameMiddle END) AS DepMiddleName7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameMiddle END) AS DepMiddleName8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameMiddle END) AS DepMiddleName9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameMiddle END) AS DepMiddleName10
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameMiddle END) AS DepMiddleName11
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConNameMiddle END) AS DepMiddleName12
            
                        ,MAX(CASE WHEN Dep_Number = 1 THEN ConGender END) AS DepGender1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConGender END) AS DepGender2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConGender END) AS DepGender3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConGender END) AS DepGender4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConGender END) AS DepGender5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConGender END) AS DepGender6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConGender END) AS DepGender7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConGender END) AS DepGender8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConGender END) AS DepGender9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConGender END) AS DepGender10
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConGender END) AS DepGender11
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConGender END) AS DepGender12

            ,MAX(CASE WHEN Dep_Number = 1 THEN ConIsDisabled END) AS DepIsDisabled1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConIsDisabled END) AS DepIsDisabled2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConIsDisabled END) AS DepIsDisabled3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConIsDisabled END) AS DepIsDisabled4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConIsDisabled END) AS DepIsDisabled5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConIsDisabled END) AS DepIsDisabled6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConIsDisabled END) AS DepIsDisabled7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConIsDisabled END) AS DepIsDisabled8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConIsDisabled END) AS DepIsDisabled9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConIsDisabled END) AS DepIsDisabled10
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConIsDisabled END) AS DepIsDisabled11
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConIsDisabled END) AS DepIsDisabled12
       
            ,MAX(CASE WHEN Dep_Number = 1 THEN 
                CASE WHEN BdmDedCode in ('DENLO','DENHI','VISC') THEN 'D,V'
                     WHEN BdmDedCode in ('DENLO','DENHI') and BdmDedCode NOT IN ('VISC') THEN 'D'
                     WHEN BdmDedCode not in ('DENLO','DENHI') and BdmDedCode  IN ('VISC') THEN 'V'
                END
             END) AS DedCode1

            ,MAX(CASE WHEN Dep_Number = 2 THEN 
                CASE WHEN BdmDedCode in ('DENLO','DENHI','VISC') THEN 'D,V'
                     WHEN BdmDedCode in ('DENLO','DENHI') and BdmDedCode NOT IN ('VISC') THEN 'D'
                     WHEN BdmDedCode not in ('DENLO','DENHI') and BdmDedCode  IN ('VISC') THEN 'V'
                END
             END) AS DedCode2
             ,MAX(CASE WHEN Dep_Number = 3 THEN 
                CASE WHEN BdmDedCode in ('DENLO','DENHI','VISC') THEN 'D,V'
                     WHEN BdmDedCode in ('DENLO','DENHI') and BdmDedCode NOT IN ('VISC') THEN 'D'
                     WHEN BdmDedCode not in ('DENLO','DENHI') and BdmDedCode  IN ('VISC') THEN 'V'
                END
             END) AS DedCode3
             ,MAX(CASE WHEN Dep_Number = 4 THEN 
                CASE WHEN BdmDedCode in ('DENLO','DENHI','VISC') THEN 'D,V'
                     WHEN BdmDedCode in ('DENLO','DENHI') and BdmDedCode NOT IN ('VISC') THEN 'D'
                     WHEN BdmDedCode not in ('DENLO','DENHI') and BdmDedCode  IN ('VISC') THEN 'V'
                END
             END) AS DedCode4
             ,MAX(CASE WHEN Dep_Number = 5 THEN 
                CASE WHEN BdmDedCode in ('DENLO','DENHI','VISC') THEN 'D,V'
                     WHEN BdmDedCode in ('DENLO','DENHI') and BdmDedCode NOT IN ('VISC') THEN 'D'
                     WHEN BdmDedCode not in ('DENLO','DENHI') and BdmDedCode  IN ('VISC') THEN 'V'
                END
             END) AS DedCode5
             ,MAX(CASE WHEN Dep_Number = 6 THEN 
                CASE WHEN BdmDedCode in ('DENLO','DENHI','VISC') THEN 'D,V'
                     WHEN BdmDedCode in ('DENLO','DENHI') and BdmDedCode NOT IN ('VISC') THEN 'D'
                     WHEN BdmDedCode not in ('DENLO','DENHI') and BdmDedCode  IN ('VISC') THEN 'V'
                END
             END) AS DedCode6
             ,MAX(CASE WHEN Dep_Number = 7 THEN 
                CASE WHEN BdmDedCode in ('DENLO','DENHI','VISC') THEN 'D,V'
                     WHEN BdmDedCode in ('DENLO','DENHI') and BdmDedCode NOT IN ('VISC') THEN 'D'
                     WHEN BdmDedCode not in ('DENLO','DENHI') and BdmDedCode  IN ('VISC') THEN 'V'
                END
             END) AS DedCode7
             ,MAX(CASE WHEN Dep_Number = 8 THEN 
                CASE WHEN BdmDedCode in ('DENLO','DENHI','VISC') THEN 'D,V'
                     WHEN BdmDedCode in ('DENLO','DENHI') and BdmDedCode NOT IN ('VISC') THEN 'D'
                     WHEN BdmDedCode not in ('DENLO','DENHI') and BdmDedCode  IN ('VISC') THEN 'V'
                END
             END) AS DedCode8
             ,MAX(CASE WHEN Dep_Number = 9 THEN 
                CASE WHEN BdmDedCode in ('DENLO','DENHI','VISC') THEN 'D,V'
                     WHEN BdmDedCode in ('DENLO','DENHI') and BdmDedCode NOT IN ('VISC') THEN 'D'
                     WHEN BdmDedCode not in ('DENLO','DENHI') and BdmDedCode  IN ('VISC') THEN 'V'
                END
             END) AS DedCode9
             ,MAX(CASE WHEN Dep_Number = 10 THEN 
                CASE WHEN BdmDedCode in ('DENLO','DENHI','VISC') THEN 'D,V'
                     WHEN BdmDedCode in ('DENLO','DENHI') and BdmDedCode NOT IN ('VISC') THEN 'D'
                     WHEN BdmDedCode not in ('DENLO','DENHI') and BdmDedCode  IN ('VISC') THEN 'V'
                END
             END) AS DedCode10
             ,MAX(CASE WHEN Dep_Number = 11 THEN 
                CASE WHEN BdmDedCode in ('DENLO','DENHI','VISC') THEN 'D,V'
                     WHEN BdmDedCode in ('DENLO','DENHI') and BdmDedCode NOT IN ('VISC') THEN 'D'
                     WHEN BdmDedCode not in ('DENLO','DENHI') and BdmDedCode  IN ('VISC') THEN 'V'
                END
             END) AS DedCode11
             ,MAX(CASE WHEN Dep_Number = 12 THEN 
                CASE WHEN BdmDedCode in ('DENLO','DENHI','VISC') THEN 'D,V'
                     WHEN BdmDedCode in ('DENLO','DENHI') and BdmDedCode NOT IN ('VISC') THEN 'D'
                     WHEN BdmDedCode not in ('DENLO','DENHI') and BdmDedCode  IN ('VISC') THEN 'V'
                END
             END) AS DedCode12

            ,Count(CASE WHEN ConRelationship IN ('DAU', 'SON', 'DIS', 'STC','CHL','DP','SPS') THEN Dep_Number END) as Child_Counts

        From (
                select bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, CASE WHEN ConRelationship in ('SPS','DP') THEN 'S' ELSE 'C' END as ConRelationship,ConNameMiddle,ConGender,BdmDedCode,ConIsDisabled, ROW_NUMBER() OVER (PARTITION BY bdmeeid ORDER BY bdmeeid) AS 'Dep_Number'
                from  dbo.U_dsi_BDM_ELININSEXP A 
                JOIN dbo.Contacts WITH (NOLOCK) 
                ON ConEEID = bdmeeid 
                AND ConSystemID = BdmDepRecID
                where bdmrelationship IN ('DAU', 'SON', 'DIS', 'STC','CHL','DP','SPS') and bdmdedcode in ('DENLO', 'DENHI', 'VISC', 'SUPLS','SUPLC') 
                    group by bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, CASE WHEN ConRelationship in ('SPS','DP') THEN 'S' ELSE 'C' END,ConNameMiddle,ConGender,BdmDedCode,ConIsDisabled
                    ) AS Source Group By bdmeeid)
         AS DepList on KidEEID = xEEID
         LEFT JOIN (Select bdmeeid AS SPSEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS SPSLastName
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS SPSFirstName
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS SPSSsn
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS SPSDateOfBirth
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS SPSRelationship
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConIsSmoker END) AS SPSSMoker
            ,Count(CASE WHEN ConRelationship IN ('SPS') THEN Dep_Number END) as SPS_Counts

        From (
                select bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship,ConIsSmoker, ROW_NUMBER() OVER (PARTITION BY bdmeeid ORDER BY bdmeeid) AS 'Dep_Number'
                from  dbo.U_dsi_BDM_ELININSEXP A 
                JOIN dbo.Contacts WITH (NOLOCK) 
                ON ConEEID = bdmeeid 
                AND ConSystemID = BdmDepRecID
                where bdmrelationship IN ('SPS','DP') and bdmdedcode in ('DENLO', 'DENHI', 'VISC', 'SUPLS','SUPLC')
                    group by bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship,ConIsSmoker
                    ) AS Source Group By bdmeeid) As Spouse
                on xeeid = Spouse.SPSEEID
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
ALTER VIEW dbo.dsi_vwELININSEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELININSEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELININSEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911011'
       ,expStartPerControl     = '201911011'
       ,expLastEndPerControl   = '201911089'
       ,expEndPerControl       = '201911089'
WHERE expFormatCode = 'ELININSEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELININSEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELININSEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort