SET NOCOUNT ON;
IF OBJECT_ID('U_ELINFINEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINFINEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELINFINEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELINFINEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELINFINEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINFINEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELINFINEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELINFINEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELINFINEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELINFINEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELINFINEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) VALUES ('N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','ELINFINEXP','Lincoln Financial Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','18000','N','S','N','ELINFINEXPZ0','N','Jan  1 1900 12:00AM','C','N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EDIHeader:"','1','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','1',NULL,'EDIHeader',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1630544"','2','(''DA''=''T,'')','ELINFINEXPZ0','50','H','01','2',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('":LFGV2"','3','(''DA''=''T'')','ELINFINEXPZ0','50','H','01','3',NULL,'LFGV2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID "','1','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','1',NULL,'Employee ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Change Date "','2','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','2',NULL,'Change Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Change Date "','3','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','3',NULL,'Dep Change Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date "','4','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','4',NULL,'Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr First Name "','5','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','5',NULL,'Mbr First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Last Name "','6','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','6',NULL,'Mbr Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Middle Initial "','7','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','7',NULL,'Mbr Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr SSN "','8','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','8',NULL,'Mbr SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Gender "','9','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','9',NULL,'Mbr Gender ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr DOB "','10','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','10',NULL,'Mbr DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"App Sign Date "','11','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','11',NULL,'App Sign Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation "','12','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','12',NULL,'Occupation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs Per Week "','13','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','13',NULL,'Hrs Per Week ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Amt "','14','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','14',NULL,'Salary Amt ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Code "','15','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','15',NULL,'Salary Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sal Eff Date "','16','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','16',NULL,'Sal Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Addr 1 "','17','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','17',NULL,'Mbr Addr 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Addr 2 "','18','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','18',NULL,'Mbr Addr 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr City "','19','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','19',NULL,'Mbr City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr State "','20','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','20',NULL,'Mbr State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Zip Code "','21','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','21',NULL,'Mbr Zip Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Zip Plus 4 "','22','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','22',NULL,'Mbr Zip Plus 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone "','23','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','23',NULL,'Home Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone "','24','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','24',NULL,'Work Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Ext "','25','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','25',NULL,'Work Phone Ext ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address "','26','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','26',NULL,'Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Benefits Eligibility "','27','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','27',NULL,'Date of Benefits Eligibility ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Subsequent Date of Benefits Eligibility"','28','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','28',NULL,'Subsequent Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reason for Prior Loss of Benefits Eligibility "','29','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','29',NULL,'Reason for Prior Loss of Benefits Eligibility ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene First Name "','30','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','30',NULL,'Pri Bene First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Last Name "','31','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','31',NULL,'Pri Bene Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Middle Init "','32','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','32',NULL,'Pri Bene Middle Init ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Relationship "','33','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','33',NULL,'Pri Bene Relationship ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Address 1 "','34','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','34',NULL,'Pri Bene Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Address 2 "','35','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','35',NULL,'Pri Bene Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene City "','36','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','36',NULL,'Pri Bene City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene State "','37','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','37',NULL,'Pri Bene State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Zip Code "','38','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','38',NULL,'Pri Bene Zip Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Zip Plus 4 "','39','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','39',NULL,'Pri Bene Zip Plus 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene SSN "','40','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','40',NULL,'Pri Bene SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene First Name "','41','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','41',NULL,'Co Bene First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Last Name "','42','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','42',NULL,'Co Bene Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Middle Init "','43','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','43',NULL,'Co Bene Middle Init ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Relationship "','44','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','44',NULL,'Co Bene Relationship ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Address 1 "','45','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','45',NULL,'Co Bene Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Address 2 "','46','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','46',NULL,'Co Bene Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene City "','47','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','47',NULL,'Co Bene City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene State "','48','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','48',NULL,'Co Bene State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Zip Code "','49','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','49',NULL,'Co Bene Zip Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Zip Plus 4 "','50','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','50',NULL,'Co Bene Zip Plus 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene SSN "','51','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','51',NULL,'Co Bene SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Beneficiary Comments "','52','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','52',NULL,'Beneficiary Comments ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Policy Number "','53','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','53',NULL,'Accident Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Bill Location AC Number "','54','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','54',NULL,'Accident Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Sort Group "','55','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','55',NULL,'Accident Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Eff Date "','56','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','56',NULL,'Accident Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Plan Code "','57','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','57',NULL,'Accident Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Class Code "','58','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','58',NULL,'Accident Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Tier Code "','59','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','59',NULL,'Accident Tier Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health Asses Tier "','60','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','60',NULL,'Health Asses Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Tier "','61','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','61',NULL,'Hospital Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Disability Amount "','62','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','62',NULL,'Accident Disability Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Tier "','63','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','63',NULL,'Accident DI Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Benefit Period "','64','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','64',NULL,'Accident DI Benefit Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Elim Period "','65','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','65',NULL,'Accident DI Elim Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Sickness Disability Amount "','66','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','66',NULL,'Accident Sickness Disability Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accidentsick Tier "','67','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','67',NULL,'Accident sick Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accidentsick DI Benefit Period "','68','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','68',NULL,'Accident sick DI Benefit Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accidentsick DI Elim Period "','69','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','69',NULL,'Accident sick DI Elim Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Termination Date "','70','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','70',NULL,'Accident Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Policy Number "','71','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','71',NULL,'Critical Illness Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Bill Location AC Number"','72','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','72',NULL,'Critical Illness Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Sort Group "','73','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','73',NULL,'Critical Illness Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Eff Date "','74','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','74',NULL,'Critical Illness Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Plan Code "','75','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','75',NULL,'Critical Illness Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Class Code "','76','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','76',NULL,'Critical Illness Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Termination Date "','77','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','77',NULL,'Critical Illness Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Principal Sum Amt Approved "','78','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','78',NULL,'EE Principal Sum Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Principal Sum Amt Pending "','79','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','79',NULL,'EE Principal Sum Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Principal Sum Amt Approved "','80','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','80',NULL,'SP Principal Sum Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Principal Sum Amt Pending "','81','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','81',NULL,'SP Principal Sum Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Principal Sum Amt Approved "','82','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','82',NULL,'CH Principal Sum Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Principal Sum Amt Pending "','83','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','83',NULL,'CH Principal Sum Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Heart Amt Approved "','84','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','84',NULL,'EE Heart Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Heart Amt Pending "','85','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','85',NULL,'EE Heart Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Heart Amt Approved "','86','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','86',NULL,'SP Heart Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Heart Amt Pending "','87','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','87',NULL,'SP Heart Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Heart Amt Approved "','88','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','88',NULL,'CH Heart Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Heart Amt Pending "','89','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','89',NULL,'CH Heart Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Cancer Amt Approved "','90','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','90',NULL,'EE Cancer Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Cancer Amt Pending "','91','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','91',NULL,'EE Cancer Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Cancer Amt Approved "','92','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','92',NULL,'SP Cancer Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Cancer Amt Pending "','93','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','93',NULL,'SP Cancer Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Cancer Amt Approved "','94','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','94',NULL,'CH Cancer Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Cancer Amt Pending "','95','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','95',NULL,'CH Cancer Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Organ Amt Approved "','96','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','96',NULL,'EE Organ Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Organ Amt Pending "','97','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','97',NULL,'EE Organ Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Organ Amt Approved "','98','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','98',NULL,'SP Organ Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Organ Amt Pending "','99','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','99',NULL,'SP Organ Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Organ Amt Approved "','100','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','100',NULL,'CH Organ Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Organ Amt Pending "','101','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','101',NULL,'CH Organ Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Quality of Life Amt Approved "','102','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','102',NULL,'EE Quality of Life Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Quality of Life Amt Pending "','103','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','103',NULL,'EE Quality of Life Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Quality of Life Amt Approved "','104','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','104',NULL,'SP Quality of Life Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Quality of Life Amt Pending "','105','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','105',NULL,'SP Quality of Life Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Quality of Life Amt Approved "','106','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','106',NULL,'CH Quality of Life Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Quality of Life Amt Pending "','107','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','107',NULL,'CH Quality of Life Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Category Amt Approved "','108','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','108',NULL,'Child Category Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Category Amt Pending "','109','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','109',NULL,'Child Category Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Treatment Care YN "','110','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','110',NULL,'EE Treatment Care YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Treatment Care YN "','111','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','111',NULL,'SP Treatment Care YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Treatment Care YN "','112','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','112',NULL,'CH Treatment Care YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE DI YN "','113','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','113',NULL,'EE DI YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP DI YN "','114','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','114',NULL,'SP DI YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Accident YN "','115','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','115',NULL,'EE Accident Y N ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Accident YN "','116','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','116',NULL,'SP Accident Y N ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Accident YN "','117','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','117',NULL,'CH Accident YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE OccHIV YN "','118','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','118',NULL,'EE OccHIV YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Policy Number "','119','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','119',NULL,'Life Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Bill Location AC Number "','120','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','120',NULL,'Life Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Sort Group "','121','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','121',NULL,'Life Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Eff Date "','122','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','122',NULL,'Life Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan Code "','123','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','123',NULL,'Life Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Class Code "','124','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','124',NULL,'Life Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LI Cvgs "','125','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','125',NULL,'LI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LI Termination Date "','126','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','126',NULL,'LI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AD Cvgs "','127','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','127',NULL,'AD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AD Termination Date "','128','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','128',NULL,'AD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DLI Cvgs "','129','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','129',NULL,'DLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DLI Termination Date "','130','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','130',NULL,'DLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DAD Cvgs "','131','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','131',NULL,'DAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DAD Termination Date "','132','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','132',NULL,'DAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLI Cvgs "','133','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','133',NULL,'OLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLI Termination Date "','134','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','134',NULL,'OLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OAD Cvgs "','135','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','135',NULL,'OAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OAD Termination Date "','136','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','136',NULL,'OAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODLI Cvgs "','137','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','137',NULL,'ODLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODLI Termination Date "','138','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','138',NULL,'ODLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODAD Cvgs "','139','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','139',NULL,'ODAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODAD Termination Date "','140','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','140',NULL,'ODAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SLI Cvgs "','141','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','141',NULL,'SLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SLI Termination Date "','142','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','142',NULL,'SLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAD Cvgs "','143','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','143',NULL,'SAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAD Termination Date "','144','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','144',NULL,'SAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLI Cvgs "','145','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','145',NULL,'CLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLI Termination Date "','146','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','146',NULL,'CLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSLI Cvgs "','147','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','147',NULL,'OSLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSLI Termination Date "','148','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','148',NULL,'OSLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSAD Cvgs "','149','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','149',NULL,'OSAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSAD Termination Date "','150','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','150',NULL,'OSAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OCLI Cvgs "','151','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','151',NULL,'OCLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OCLI Termination Date "','152','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','152',NULL,'OCLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Policy Number "','153','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','153',NULL,'WI Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Bill Location AC Number "','154','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','154',NULL,'WI Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Sort Group "','155','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','155',NULL,'WI Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Eff Date "','156','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','156',NULL,'WI Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Plan Code "','157','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','157',NULL,'WI Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Class Code "','158','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','158',NULL,'WI Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Cvgs "','159','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','159',NULL,'WI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Termination Date "','160','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','160',NULL,'WI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OWI Cvgs "','161','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','161',NULL,'OWI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OWI Termination Date "','162','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','162',NULL,'OWI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Policy Number "','163','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','163',NULL,'LTD Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Bill Location AC Number "','164','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','164',NULL,'LTD Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Sort Group "','165','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','165',NULL,'LTD Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Eff Date "','166','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','166',NULL,'LTD Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Plan Code "','167','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','167',NULL,'LTD Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Class Code "','168','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','168',NULL,'LTD Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Cvgs "','169','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','169',NULL,'LTD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Termination Date "','170','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','170',NULL,'LTD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLTD Cvgs "','171','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','171',NULL,'OLTD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLTD Termination Date "','172','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','172',NULL,'OLTD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Cvgs "','173','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','173',NULL,'CI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Date "','174','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','174',NULL,'CI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Policy Number "','175','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','175',NULL,'Dent Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Bill Location AC Number "','176','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','176',NULL,'Dent Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Sort Group "','177','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','177',NULL,'Dent Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Eff Date "','178','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','178',NULL,'Dent Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Plan Code "','179','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','179',NULL,'Dent Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Class Code "','180','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','180',NULL,'Dent Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Coverage Tier "','181','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','181',NULL,'Dent Coverage Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Other Ins "','182','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','182',NULL,'Dent Other Ins ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Termination Date "','183','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','183',NULL,'Dent Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Policy Number "','184','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','184',NULL,'DHMO Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Bill Location AC Number "','185','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','185',NULL,'DHMO Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Sort Group "','186','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','186',NULL,'DHMO Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Eff Date "','187','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','187',NULL,'DHMO Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Plan Code "','188','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','188',NULL,'DHMO Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Class Code "','189','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','189',NULL,'DHMO Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Coverage Tier  "','190','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','190',NULL,'DHMO Coverage Tier  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO PCP  "','191','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','191',NULL,'DHMO PCP  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Termination Date "','192','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','192',NULL,'DHMO Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Policy Number "','193','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','193',NULL,'LVC Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Bill Location AC Number "','194','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','194',NULL,'LVC Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Sort Group "','195','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','195',NULL,'LVC Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Eff Date "','196','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','196',NULL,'LVC Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Plan Code "','197','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','197',NULL,'LVC Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Class Code "','198','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','198',NULL,'LVC Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Coverage Tier "','199','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','199',NULL,'LVC Coverage Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Other Ins "','200','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','200',NULL,'LVC Other Ins ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Termination Date "','201','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','201',NULL,'LVC Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Policy Number "','202','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','202',NULL,'VLVC Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Bill Location AC Number "','203','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','203',NULL,'VLVC Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Sort Group "','204','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','204',NULL,'VLVC Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Eff Date "','205','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','205',NULL,'VLVC Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Plan Code "','206','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','206',NULL,'VLVC Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Class Code "','207','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','207',NULL,'VLVC Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Coverage Tier "','208','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','208',NULL,'VLVC Coverage Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Other Ins "','209','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','209',NULL,'VLVC Other Ins ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Termination Date "','210','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','210',NULL,'VLVC Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Policy Number "','211','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','211',NULL,'VDN Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Bill Location AC Number "','212','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','212',NULL,'VDN Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Sort Group "','213','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','213',NULL,'VDN Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Eff Date "','214','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','214',NULL,'VDN Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Plan Code "','215','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','215',NULL,'VDN Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Class Code "','216','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','216',NULL,'VDN Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Coverage Tier "','217','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','217',NULL,'VDN Coverage Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Other Ins "','218','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','218',NULL,'VDN Other Ins ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Termination Date "','219','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','219',NULL,'VDN Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Policy Number "','220','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','220',NULL,'VDHMO Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Bill Location AC Number "','221','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','221',NULL,'VDHMO Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Sort Group "','222','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','222',NULL,'VDHMO Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Eff Date "','223','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','223',NULL,'VDHMO Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Plan Code "','224','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','224',NULL,'VDHMO Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Class Code "','225','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','225',NULL,'VDHMO Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Coverage Tier  "','226','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','226',NULL,'VDHMO Coverage Tier  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO PCP  "','227','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','227',NULL,'VDHMO PCP  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Termination Date "','228','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','228',NULL,'VDHMO Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Policy Number "','229','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','229',NULL,'VLIF Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Bill Location AC Number "','230','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','230',NULL,'VLIF Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Sort Group "','231','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','231',NULL,'VLIF Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Eff Date "','232','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','232',NULL,'VLIF Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Plan Code "','233','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','233',NULL,'VLIF Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Class Code "','234','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','234',NULL,'VLIF Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLI Cvgs "','235','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','235',NULL,'VLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLI Termination Date "','236','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','236',NULL,'VLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VAD Cvgs "','237','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','237',NULL,'VAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VAD Termination Date "','238','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','238',NULL,'VAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLI Cvgs "','239','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','239',NULL,'VSLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLI Termination Date "','240','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','240',NULL,'VSLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSAD Cvgs "','241','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','241',NULL,'VSAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSAD Termination Date "','242','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','242',NULL,'VSAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLI Cvgs "','243','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','243',NULL,'VCLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLI Termination Date "','244','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','244',NULL,'VCLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Policy Number "','245','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','245',NULL,'VWI Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Bill Location AC Number "','246','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','246',NULL,'VWI Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Sort Group "','247','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','247',NULL,'VWI Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Eff Date "','248','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','248',NULL,'VWI Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Plan Code "','249','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','249',NULL,'VWI Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Class Code "','250','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','250',NULL,'VWI Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Benefit Amt "','251','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','251',NULL,'VWI Benefit Amt ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Elim Period "','252','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','252',NULL,'VWI Elim Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Benefit Duration "','253','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','253',NULL,'VWI Benefit Duration ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Termination Date "','254','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','254',NULL,'VWI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Policy Number "','255','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','255',NULL,'VLTD Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Bill Location AC Number "','256','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','256',NULL,'VLTD Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Sort Group "','257','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','257',NULL,'VLTD Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Eff Date "','258','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','258',NULL,'VLTD Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Plan Code "','259','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','259',NULL,'VLTD Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Class Code "','260','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','260',NULL,'VLTD Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Amt "','261','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','261',NULL,'VLTD Benefit Amt ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Elim Period "','262','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','262',NULL,'VLTD Elim Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Duration "','263','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','263',NULL,'VLTD Benefit Duration ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Pct "','264','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','264',NULL,'VLTD Benefit Pct ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Termination Date "','265','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','265',NULL,'VLTD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Policy Number "','266','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','266',NULL,'STAD Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Bill Location AC Number "','267','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','267',NULL,'STAD Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Sort Group "','268','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','268',NULL,'STAD Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Eff Date "','269','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','269',NULL,'STAD Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Plan Code "','270','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','270',NULL,'STAD Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Class Code "','271','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','271',NULL,'STAD Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVAD Cvgs "','272','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','272',NULL,'STVAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVAD Termination Date "','273','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','273',NULL,'STVAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVSAD Cvgs "','274','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','274',NULL,'STVSAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVSAD Termination Date "','275','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','275',NULL,'STVSAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVCAD Cvgs "','276','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','276',NULL,'STVCAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVCAD Termination Date "','277','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','277',NULL,'STVCAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualifying Event Code "','278','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','278',NULL,'Qualifying Event Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualifying Event Eff Date "','279','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','279',NULL,'Qualifying Event Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Smoker "','280','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','280',NULL,'Mbr Smoker ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Smoker  "','281','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','281',NULL,'Spouse Smoker  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse DOB "','282','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','282',NULL,'Spouse DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name "','283','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','283',NULL,'Dep First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name "','284','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','284',NULL,'Dep Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I  "','285','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','285',NULL,'Dep M I  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender "','286','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','286',NULL,'Dep Gender ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB "','287','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','287',NULL,'Dep DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code "','288','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','288',NULL,'Dep Relationship Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code "','289','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','289',NULL,'Dep Student Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled YN "','290','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','290',NULL,'Dep Disabled YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator "','291','(''DA''=''T,'')','ELINFINEXPZ0','50','H','02','291',NULL,'Dep Cvg Indicator ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP  "','292','(''DA''=''T'')','ELINFINEXPZ0','50','H','02','292',NULL,'Dep DHMO PCP  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','1','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','1',NULL,'Employee ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChangeDate"','2','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','2',NULL,'Change Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepChangeDate"','3','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','3',NULL,'Dep Change Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','4','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','4',NULL,'Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrFirstName"','5','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','5',NULL,'Mbr First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrLastName"','6','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','6',NULL,'Mbr Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrMiddleInitial"','7','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','7',NULL,'Mbr Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrSSN"','8','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','8',NULL,'Mbr SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrGender"','9','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','9',NULL,'Mbr Gender ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrDateOfBirth"','10','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','10',NULL,'Mbr DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAppSignDate"','11','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','11',NULL,'App Sign Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupation"','12','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','12',NULL,'Occupation ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourPerWeek"','13','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','13',NULL,'Hrs Per Week ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt"','14','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','14',NULL,'Salary Amt ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryCode"','15','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','15',NULL,'Salary Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalEffDate"','16','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','16',NULL,'Sal Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrAddrOne"','17','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','17',NULL,'Mbr Addr 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrAddrTwo"','18','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','18',NULL,'Mbr Addr 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrCity"','19','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','19',NULL,'Mbr City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrState"','20','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','20',NULL,'Mbr State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrZipCode"','21','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','21',NULL,'Mbr Zip Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrZipPlusFour"','22','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','22',NULL,'Mbr Zip Plus 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','23','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','23',NULL,'Home Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','24','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','24',NULL,'Work Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExt"','25','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','25',NULL,'Work Phone Ext ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','26','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','26',NULL,'Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBenEligbility"','27','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','27',NULL,'Date of Benefits Eligibility ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubsDateOfBen"','28','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','28',NULL,'Subsequent Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReasonPriorLossBenElig"','29','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','29',NULL,'Reason for Prior Loss of Benefits Eligibility ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneFirstName"','30','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','30',NULL,'Pri Bene First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneLastName"','31','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','31',NULL,'Pri Bene Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneMiddleInit"','32','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','32',NULL,'Pri Bene Middle Init ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneRelationship"','33','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','33',NULL,'Pri Bene Relationship ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneAddressOne"','34','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','34',NULL,'Pri Bene Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneAddressTwo"','35','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','35',NULL,'Pri Bene Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneCity"','36','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','36',NULL,'Pri Bene City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneState"','37','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','37',NULL,'Pri Bene State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneZipCode"','38','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','38',NULL,'Pri Bene Zip Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBeneZipPlusFour"','39','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','39',NULL,'Pri Bene Zip Plus 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProBeneSSN"','40','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','40',NULL,'Pri Bene SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneFirstName"','41','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','41',NULL,'Co Bene First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneLastName"','42','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','42',NULL,'Co Bene Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneMiddleInit"','43','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','43',NULL,'Co Bene Middle Init ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneRelationship"','44','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','44',NULL,'Co Bene Relationship ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneAddressOne"','45','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','45',NULL,'Co Bene Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneAddressTwo"','46','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','46',NULL,'Co Bene Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneCity"','47','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','47',NULL,'Co Bene City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneState"','48','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','48',NULL,'Co Bene State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneZipCode"','49','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','49',NULL,'Co Bene Zip Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneZipPlusFour"','50','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','50',NULL,'Co Bene Zip Plus 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBeneSSN"','51','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','51',NULL,'Co Bene SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneficiaryComments"','52','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','52',NULL,'Beneficiary Comments ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentPolicyNumber"','53','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','53',NULL,'Accident Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentBillLocACNumber"','54','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','54',NULL,'Accident Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSortGroup"','55','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','55',NULL,'Accident Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentEffDate"','56','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','56',NULL,'Accident Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentPlanCode"','57','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','57',NULL,'Accident Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentClassCode"','58','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','58',NULL,'Accident Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentTierCode"','59','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','59',NULL,'Accident Tier Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHealthAssesTier"','60','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','60',NULL,'Health Asses Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHospitalTier"','61','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','61',NULL,'Hospital Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentDisabilityAmt"','62','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','62',NULL,'Accident Disability Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentDiTier"','63','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','63',NULL,'Accident DI Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentDiBenefitPeriod"','64','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','64',NULL,'Accident DI Benefit Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentDiElimPeriod"','65','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','65',NULL,'Accident DI Elim Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSicknessDisaAmt"','66','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','66',NULL,'Accident Sickness Disability Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSickTier"','67','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','67',NULL,'Accidentsick Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSickDiBenePer"','68','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','68',NULL,'Accidentsick DI Benefit Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentSickDiElimPer"','69','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','69',NULL,'Accidentsick DI Elim Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccidentTermDate"','70','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','70',NULL,'Accident Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessPolicyNum"','71','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','71',NULL,'Critical Illness Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessBillLocAC"','72','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','72',NULL,'Critical Illness Bill Location AC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessSortGrp"','73','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','73',NULL,'Critical Illness Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessEffDate"','74','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','74',NULL,'Critical Illness Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessPlanCode"','75','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','75',NULL,'Critical Illness Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritIllnessClassCode"','76','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','76',NULL,'Critical Illness Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDritIllnessTErmDate"','77','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','77',NULL,'Critical Illness Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEePrincSumAmtApprove"','78','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','78',NULL,'EE Principal Sum Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEePrincSumAmtPend"','79','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','79',NULL,'EE Principal Sum Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpPrincSumAmtApprove"','80','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','80',NULL,'SP Principal Sum Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpPrincSumAmtPend"','81','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','81',NULL,'SP Principal Sum Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChPrincSumAmtApprove"','82','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','82',NULL,'CH Principal Sum Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChPrincSumAmtPend"','83','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','83',NULL,'CH Principal Sum Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeHeartAmtApprove"','84','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','84',NULL,'EE Heart Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeHeartAmtPend"','85','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','85',NULL,'EE Heart Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpHeartAmtApprove"','86','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','86',NULL,'SP Heart Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpHeartAmtPend"','87','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','87',NULL,'SP Heart Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChHeartAmtApprove"','88','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','88',NULL,'CH Heart Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChHeartAmtPend"','89','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','89',NULL,'CH Heart Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeCancerAmtApprove"','90','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','90',NULL,'EE Cancer Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeCancerAmtPend"','91','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','91',NULL,'EE Cancer Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpCancerAmtApprove"','92','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','92',NULL,'SP Cancer Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpCancerAmtPend"','93','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','93',NULL,'SP Cancer Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChCancerAmtApprove"','94','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','94',NULL,'CH Cancer Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChCancerAmtPend"','95','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','95',NULL,'CH Cancer Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeOrganAmtApprove"','96','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','96',NULL,'EE Organ Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeOrganAmtPend"','97','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','97',NULL,'EE Organ Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpOrganAmtApprove"','98','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','98',NULL,'SP Organ Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpOrganAmtPend"','99','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','99',NULL,'SP Organ Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChOrganAmtApprove"','100','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','100',NULL,'CH Organ Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChOrganAmtPend"','101','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','101',NULL,'CH Organ Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeQualOfLifeAmtApprove"','102','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','102',NULL,'EE Quality of Life Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeQualOfLifeAmtPend"','103','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','103',NULL,'EE Quality of Life Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpQualOfLifeAmtApprove"','104','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','104',NULL,'SP Quality of Life Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpQualOfLifeAmtPend"','105','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','105',NULL,'SP Quality of Life Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChQualOfLifeAmtApprove"','106','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','106',NULL,'CH Quality of Life Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChQualOfLifeAmtPend"','107','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','107',NULL,'CH Quality of Life Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildCatAmtApprove"','108','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','108',NULL,'Child Category Amt Approved ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildCatAmtPend"','109','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','109',NULL,'Child Category Amt Pending ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeTreatmentCareYN"','110','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','110',NULL,'EE Treatment Care Y N ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpTreatmentCareYN"','111','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','111',NULL,'SP Treatment Care YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChTreatmentCareYN"','112','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','112',NULL,'CH Treatment Care YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeDiYN"','113','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','113',NULL,'EE DI YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpDiYN"','114','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','114',NULL,'SP DI YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeAccidentYN"','115','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','115',NULL,'EE Accident YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpAccidentYN"','116','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','116',NULL,'SP Accident YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChAccidentYN"','117','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','117',NULL,'CH Accident YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeOccHivYN"','118','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','118',NULL,'EE OccHIV YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePolicyNumber"','119','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','119',NULL,'Life Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeBillLocACNumber"','120','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','120',NULL,'Life Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeSortGroup"','121','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','121',NULL,'Life Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeEffDate"','122','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','122',NULL,'Life Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlanCode"','123','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','123',NULL,'Life Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeClassCode"','124','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','124',NULL,'Life Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLiCvgs"','125','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','125',NULL,'LI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLiTerminationDate"','126','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','126',NULL,'LI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdCvgs"','127','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','127',NULL,'AD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdTerminationDate"','128','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','128',NULL,'AD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDliCvgs"','129','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','129',NULL,'DLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDliTerminationDate"','130','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','130',NULL,'DLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDadCvgs"','131','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','131',NULL,'DAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDadTerminationDate"','132','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','132',NULL,'DAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOliCvgs"','133','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','133',NULL,'OLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOliTerminationDate"','134','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','134',NULL,'OLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOadCvgs"','135','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','135',NULL,'OAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOadTerminationDate"','136','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','136',NULL,'OAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOdliCvgs"','137','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','137',NULL,'ODLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOdliTerminationDate"','138','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','138',NULL,'ODLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOdadCvgs"','139','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','139',NULL,'ODAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOdadTerminationDate"','140','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','140',NULL,'ODAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSliCvgs"','141','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','141',NULL,'SLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSliTerminationDate"','142','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','142',NULL,'SLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSadCvgs"','143','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','143',NULL,'SAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSadTerminationDate"','144','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','144',NULL,'SAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCliCvgs"','145','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','145',NULL,'CLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCliTerminationDate"','146','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','146',NULL,'CLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOsliCvgs"','147','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','147',NULL,'OSLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOsliTerminationDate"','148','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','148',NULL,'OSLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOsadCvgs"','149','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','149',NULL,'OSAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOsadTerminationDate"','150','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','150',NULL,'OSAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOcliCvgs"','151','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','151',NULL,'OCLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOcliTerminationDate"','152','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','152',NULL,'OCLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiPolicyNumber"','153','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','153',NULL,'WI Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiBillLocACNumber"','154','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','154',NULL,'WI Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiSortGroup"','155','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','155',NULL,'WI Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiEffDate"','156','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','156',NULL,'WI Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiPlanCode"','157','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','157',NULL,'WI Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiClassCode"','158','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','158',NULL,'WI Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiCvgs"','159','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','159',NULL,'WI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWiTerminationDate"','160','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','160',NULL,'WI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOwiCvgs"','161','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','161',NULL,'OWI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOwiTerminationDate"','162','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','162',NULL,'OWI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdPolicyNum"','163','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','163',NULL,'LTD Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdBillLocACNum"','164','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','164',NULL,'LTD Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdSortGroup"','165','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','165',NULL,'LTD Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdEffDate"','166','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','166',NULL,'LTD Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdPlanCode"','167','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','167',NULL,'LTD Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdClassCode"','168','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','168',NULL,'LTD Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdCvgs"','169','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','169',NULL,'LTD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdTerminationDate"','170','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','170',NULL,'LTD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOltdCvgs"','171','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','171',NULL,'OLTD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOltdTerminationDate"','172','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','172',NULL,'OLTD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiCvgs"','173','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','173',NULL,'CI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiTerminationDate"','174','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','174',NULL,'CI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentPolicyNumber"','175','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','175',NULL,'Dent Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentBillLocACNBR"','176','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','176',NULL,'Dent Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentSortGroup"','177','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','177',NULL,'Dent Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentEff"','178','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','178',NULL,'Dent Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentPlanCode"','179','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','179',NULL,'Dent Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentClassCode"','180','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','180',NULL,'Dent Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentCoverageCode"','181','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','181',NULL,'Dent Coverage Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentOtherIns"','182','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','182',NULL,'Dent Other Ins ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentTerminationDate"','183','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','183',NULL,'Dent Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoPolicyNumber"','184','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','184',NULL,'DHMO Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoBillLocACNumber"','185','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','185',NULL,'DHMO Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoSortGroup"','186','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','186',NULL,'DHMO Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoEffDate"','187','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','187',NULL,'DHMO Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoPlanCode"','188','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','188',NULL,'DHMO Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoClassCode"','189','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','189',NULL,'DHMO Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoCoverageTier"','190','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','190',NULL,'DHMO Coverage Tier  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoPcp"','191','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','191',NULL,'DHMO PCP  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDhmoTerminationDate"','192','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','192',NULL,'DHMO Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcPolicyNumber"','193','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','193',NULL,'LVC Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcBillLocACNumber"','194','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','194',NULL,'LVC Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcSortGroup"','195','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','195',NULL,'LVC Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcEffDate"','196','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','196',NULL,'LVC Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcPlanCode"','197','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','197',NULL,'LVC Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcClassCode"','198','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','198',NULL,'LVC Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcCoverageTier"','199','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','199',NULL,'LVC Coverage Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcOtherIns"','200','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','200',NULL,'LVC Other Ins ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLvcTerminationDate"','201','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','201',NULL,'LVC Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcPolicyNumber"','202','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','202',NULL,'VLVC Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcBillLocACNumber"','203','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','203',NULL,'VLVC Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcSortGroup"','204','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','204',NULL,'VLVC Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcEffDate"','205','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','205',NULL,'VLVC Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcPlanCode"','206','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','206',NULL,'VLVC Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcClassCode"','207','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','207',NULL,'VLVC Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcCoverageTier"','208','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','208',NULL,'VLVC Coverage Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcOtherIns"','209','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','209',NULL,'VLVC Other Ins ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlvcTerminationDate"','210','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','210',NULL,'VLVC Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnPolicyNumber"','211','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','211',NULL,'VDN Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnCillLocationACNum"','212','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','212',NULL,'VDN Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnSortGroup"','213','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','213',NULL,'VDN Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnEffDate"','214','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','214',NULL,'VDN Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnPlanCode"','215','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','215',NULL,'VDN Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnClassCode"','216','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','216',NULL,'VDN Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnCoverageTier"','217','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','217',NULL,'VDN Coverage Tier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnOtherIns"','218','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','218',NULL,'VDN Other Ins ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdnTerminationDate"','219','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','219',NULL,'VDN Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoPolicyNumber"','220','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','220',NULL,'VDHMO Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoBillLocationACNum"','221','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','221',NULL,'VDHMO Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoSortGroup"','222','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','222',NULL,'VDHMO Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoEffDate"','223','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','223',NULL,'VDHMO Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoPlanCode"','224','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','224',NULL,'VDHMO Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoClassCode"','225','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','225',NULL,'VDHMO Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoCoverageTier"','226','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','226',NULL,'VDHMO Coverage Tier  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoPcp"','227','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','227',NULL,'VDHMO PCP  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVdhmoTerminationDate"','228','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','228',NULL,'VDHMO Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifPolicyNumber"','229','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','229',NULL,'VLIF Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifBillLocationACNum"','230','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','230',NULL,'VLIF Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifSortGroup"','231','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','231',NULL,'VLIF Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifEffDate"','232','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','232',NULL,'VLIF Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifPlanCode"','233','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','233',NULL,'VLIF Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifClassCode"','234','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','234',NULL,'VLIF Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifCvgs"','235','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','235',NULL,'VLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVlifTerminationDate"','236','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','236',NULL,'VLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVadCvgs"','237','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','237',NULL,'VAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVadTerminationDate"','238','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','238',NULL,'VAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVsliCvgs"','239','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','239',NULL,'VSLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVsliTerminationDate"','240','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','240',NULL,'VSLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVsadCvgs"','241','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','241',NULL,'VSAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVsadTerminationDate"','242','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','242',NULL,'VSAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVcliCvgs"','243','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','243',NULL,'VCLI Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVcliTerminationDate"','244','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','244',NULL,'VCLI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiPolicyNumber"','245','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','245',NULL,'VWI Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiBillLocationACNumber"','246','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','246',NULL,'VWI Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiSortGroup"','247','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','247',NULL,'VWI Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiEffDate"','248','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','248',NULL,'VWI Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiPlanCode"','249','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','249',NULL,'VWI Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiClassCode"','250','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','250',NULL,'VWI Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiBenefitAmt"','251','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','251',NULL,'VWI Benefit Amt ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiElimPeriod"','252','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','252',NULL,'VWI Elim Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiBenefitDuration"','253','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','253',NULL,'VWI Benefit Duration ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVwiTerminationDate"','254','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','254',NULL,'VWI Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdPolicyNumber"','255','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','255',NULL,'VLTD Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdBillLocationACNum"','256','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','256',NULL,'VLTD Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdSortGroup"','257','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','257',NULL,'VLTD Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdEffDate"','258','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','258',NULL,'VLTD Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdPlanCode"','259','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','259',NULL,'VLTD Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdClassCode"','260','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','260',NULL,'VLTD Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdBenefitAmt"','261','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','261',NULL,'VLTD Benefit Amt ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdElimPeriod"','262','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','262',NULL,'VLTD Elim Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdBenefitDuration"','263','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','263',NULL,'VLTD Benefit Duration ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdBenefitPct"','264','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','264',NULL,'VLTD Benefit Pct ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVltdTerminationDate"','265','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','265',NULL,'VLTD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadPolicyNumber"','266','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','266',NULL,'STAD Policy Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadBillLocationACNum"','267','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','267',NULL,'STAD Bill Location AC Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadSortGroup"','268','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','268',NULL,'STAD Sort Group ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadEffDate"','269','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','269',NULL,'STAD Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadPlanCode"','270','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','270',NULL,'STAD Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStadClassCode"','271','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','271',NULL,'STAD Class Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvadCvgs"','272','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','272',NULL,'STVAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvadTerminationDate"','273','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','273',NULL,'STVAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvsadCvgs"','274','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','274',NULL,'STVSAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvsadTerminationDate"','275','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','275',NULL,'STVSAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvcadCvgs"','276','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','276',NULL,'STVCAD Cvgs ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStvcadTerminationDate"','277','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','277',NULL,'STVCAD Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifyingEventCode"','278','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','278',NULL,'Qualifying Event Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifyingEventEffDate"','279','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','279',NULL,'Qualifying Event Eff Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrSmoker"','280','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','280',NULL,'Mbr Smoker ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMbrSpouseSmoker"','281','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','281',NULL,'Spouse Smoker  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpoudDateOfBirth"','282','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','282',NULL,'Spouse DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName"','283','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','283',NULL,'Dep First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName"','284','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','284',NULL,'Dep Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleInitial"','285','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','285',NULL,'Dep M I  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender"','286','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','286',NULL,'Dep Gender ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth"','287','(''UD101''=''T,'')','ELINFINEXPZ0','50','D','10','287',NULL,'Dep DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipCode"','288','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','288',NULL,'Dep Relationship Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode"','289','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','289',NULL,'Dep Student Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabledYN"','290','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','290',NULL,'Dep Disabled YN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCvgIndicator"','291','(''UA''=''T,'')','ELINFINEXPZ0','50','D','10','291',NULL,'Dep Cvg Indicator ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDedDhmoPcp"','292','(''UA''=''T'')','ELINFINEXPZ0','50','D','10','292',NULL,'Dep DHMO PCP  ',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ELINFINEXP_20191108.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Lincoln Financial Export','201911089','EMPEXPORT','ONDEMAND',NULL,'ELINFINEXP',NULL,NULL,NULL,'201911089','Nov  8 2019 11:11AM','Nov  8 2019 11:11AM','201911081',NULL,'','','201911081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ELINFINEXP_20191108.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201911089','EMPEXPORT','TEST',NULL,'ELINFINEXP',NULL,NULL,NULL,'201911089','Nov  8 2019 11:11AM','Nov  8 2019 11:11AM','201911081',NULL,'','','201911081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ELINFINEXP_20191108.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201911089','EMPEXPORT','SCHEDULED',NULL,'ELINFINEXP',NULL,NULL,NULL,'201911089','Nov  8 2019 11:11AM','Nov  8 2019 11:11AM','201911081',NULL,'','','201911081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ELINFINEXP_20191108.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201911089','EMPEXPORT','OEACTIVE',NULL,'ELINFINEXP',NULL,NULL,NULL,'201911089','Nov  8 2019 11:11AM','Nov  8 2019 11:11AM','201911081',NULL,'','','201911081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ELINFINEXP_20191108.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201911089','EMPEXPORT','OEPASSIVE',NULL,'ELINFINEXP',NULL,NULL,NULL,'201911089','Nov  8 2019 11:11AM','Nov  8 2019 11:11AM','201911081',NULL,'','','201911081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\ELINFINEXP_20191108.txt' END WHERE expFormatCode = 'ELINFINEXP';
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

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELINFINEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELINFINEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELINFINEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvChangeDate = ''
        ,drvDepChangeDate = ''
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvMbrFirstName = EepNameFirst
        ,drvMbrLastName = EepNameLast
        ,drvMbrMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvMbrSSN = eepSSN
        ,drvMbrGender = EepGender
        ,drvMbrDateOfBirth = EepDateOfBirth
        ,drvAppSignDate = ''
        ,drvOccupation = ''
        ,drvHourPerWeek = ''
        ,drvSalaryAmt = ''
        ,drvSalaryCode = ''
        ,drvSalEffDate = ''
        ,drvMbrAddrOne = ''
        ,drvMbrAddrTwo = ''
        ,drvMbrCity = EepAddressCity
        ,drvMbrState = EepAddressState
        ,drvMbrZipCode = EepAddressZipCode
        ,drvMbrZipPlusFour = ''
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvWorkPhoneExt = EecPhoneBusinessNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvDateOfBenEligbility = ''
        ,drvSubsDateOfBen = ''
        ,drvReasonPriorLossBenElig = ''
        ,drvPriBeneFirstName = EepNameFirst
        ,drvPriBeneLastName = EepNameLast
        ,drvPriBeneMiddleInit = LEFT(EepNameMiddle,1)
        ,drvPriBeneRelationship = ''
        ,drvPriBeneAddressOne = ''
        ,drvPriBeneAddressTwo = ''
        ,drvPriBeneCity = EepAddressCity
        ,drvPriBeneState = EepAddressState
        ,drvPriBeneZipCode = EepAddressZipCode
        ,drvPriBeneZipPlusFour = ''
        ,drvProBeneSSN = eepSSN
        ,drvCoBeneFirstName = EepNameFirst
        ,drvCoBeneLastName = EepNameLast
        ,drvCoBeneMiddleInit = LEFT(EepNameMiddle,1)
        ,drvCoBeneRelationship = ''
        ,drvCoBeneAddressOne = ''
        ,drvCoBeneAddressTwo = ''
        ,drvCoBeneCity = EepAddressCity
        ,drvCoBeneState = EepAddressState
        ,drvCoBeneZipCode = EepAddressZipCode
        ,drvCoBeneZipPlusFour = ''
        ,drvCoBeneSSN = eepSSN
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
        ,drvAccidentTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvCritIllnessPolicyNum = ''
        ,drvCritIllnessBillLocAC = ''
        ,drvCritIllnessSortGrp = ''
        ,drvCritIllnessEffDate = ''
        ,drvCritIllnessPlanCode = ''
        ,drvCritIllnessClassCode = ''
        ,drvDritIllnessTErmDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
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
        ,drvLifePolicyNumber = ''
        ,drvLifeBillLocACNumber = ''
        ,drvLifeSortGroup = ''
        ,drvLifeEffDate = ''
        ,drvLifePlanCode = ''
        ,drvLifeClassCode = ''
        ,drvLiCvgs = ''
        ,drvLiTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvAdCvgs = ''
        ,drvAdTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDliCvgs = ''
        ,drvDliTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDadCvgs = ''
        ,drvDadTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvOliCvgs = ''
        ,drvOliTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvOadCvgs = ''
        ,drvOadTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvOdliCvgs = ''
        ,drvOdliTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvOdadCvgs = ''
        ,drvOdadTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvSliCvgs = ''
        ,drvSliTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvSadCvgs = ''
        ,drvSadTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvCliCvgs = ''
        ,drvCliTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvOsliCvgs = ''
        ,drvOsliTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvOsadCvgs = ''
        ,drvOsadTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvOcliCvgs = ''
        ,drvOcliTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvWiPolicyNumber = ''
        ,drvWiBillLocACNumber = ''
        ,drvWiSortGroup = ''
        ,drvWiEffDate = ''
        ,drvWiPlanCode = ''
        ,drvWiClassCode = ''
        ,drvWiCvgs = ''
        ,drvWiTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvOwiCvgs = ''
        ,drvOwiTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvLtdPolicyNum = ''
        ,drvLtdBillLocACNum = ''
        ,drvLtdSortGroup = ''
        ,drvLtdEffDate = ''
        ,drvLtdPlanCode = ''
        ,drvLtdClassCode = ''
        ,drvLtdCvgs = ''
        ,drvLtdTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvOltdCvgs = ''
        ,drvOltdTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvCiCvgs = ''
        ,drvCiTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDentPolicyNumber = ''
        ,drvDentBillLocACNBR = ''
        ,drvDentSortGroup = ''
        ,drvDentEff = ''
        ,drvDentPlanCode
        ,drvDentClassCode
        ,drvDentCoverageCode
        ,drvDentOtherIns
        ,drvDentTerminationDate
        ,drvDhmoPolicyNumber
        ,drvDhmoBillLocACNumber
        ,drvDhmoSortGroup
        ,drvDhmoEffDate
        ,drvDhmoPlanCode
        ,drvDhmoClassCode
        ,drvDhmoCoverageTier
        ,drvDhmoPcp
        ,drvDhmoTerminationDate
        ,drvLvcPolicyNumber
        ,drvLvcBillLocACNumber
        ,drvLvcSortGroup
        ,drvLvcEffDate
        ,drvLvcPlanCode
        ,drvLvcClassCode
        ,drvLvcCoverageTier
        ,drvLvcOtherIns
        ,drvLvcTerminationDate
        ,drvVlvcPolicyNumber
        ,drvVlvcBillLocACNumber
        ,drvVlvcSortGroup
        ,drvVlvcEffDate
        ,drvVlvcPlanCode
        ,drvVlvcClassCode
        ,drvVlvcCoverageTier
        ,drvVlvcOtherIns
        ,drvVlvcTerminationDate
        ,drvVdnPolicyNumber
        ,drvVdnCillLocationACNum
        ,drvVdnSortGroup
        ,drvVdnEffDate
        ,drvVdnPlanCode
        ,drvVdnClassCode
        ,drvVdnCoverageTier
        ,drvVdnOtherIns
        ,drvVdnTerminationDate
        ,drvVdhmoPolicyNumber
        ,drvVdhmoBillLocationACNum
        ,drvVdhmoSortGroup
        ,drvVdhmoEffDate
        ,drvVdhmoPlanCode
        ,drvVdhmoClassCode
        ,drvVdhmoCoverageTier
        ,drvVdhmoPcp
        ,drvVdhmoTerminationDate
        ,drvVlifPolicyNumber
        ,drvVlifBillLocationACNum
        ,drvVlifSortGroup
        ,drvVlifEffDate
        ,drvVlifPlanCode
        ,drvVlifClassCode
        ,drvVlifCvgs
        ,drvVlifTerminationDate
        ,drvVadCvgs
        ,drvVadTerminationDate
        ,drvVsliCvgs
        ,drvVsliTerminationDate
        ,drvVsadCvgs
        ,drvVsadTerminationDate
        ,drvVcliCvgs
        ,drvVcliTerminationDate
        ,drvVwiPolicyNumber
        ,drvVwiBillLocationACNumber
        ,drvVwiSortGroup
        ,drvVwiEffDate
        ,drvVwiPlanCode
        ,drvVwiClassCode
        ,drvVwiBenefitAmt
        ,drvVwiElimPeriod
        ,drvVwiBenefitDuration
        ,drvVwiTerminationDate
        ,drvVltdPolicyNumber
        ,drvVltdBillLocationACNum
        ,drvVltdSortGroup
        ,drvVltdEffDate
        ,drvVltdPlanCode
        ,drvVltdClassCode
        ,drvVltdBenefitAmt
        ,drvVltdElimPeriod
        ,drvVltdBenefitDuration
        ,drvVltdBenefitPct
        ,drvVltdTerminationDate
        ,drvStadPolicyNumber
        ,drvStadBillLocationACNum
        ,drvStadSortGroup
        ,drvStadEffDate
        ,drvStadPlanCode
        ,drvStadClassCode
        ,drvStvadCvgs
        ,drvStvadTerminationDate
        ,drvStvsadCvgs
        ,drvStvsadTerminationDate
        ,drvStvcadCvgs
        ,drvStvcadTerminationDate
        ,drvQualifyingEventCode
        ,drvQualifyingEventEffDate
        ,drvMbrSmoker
        ,drvMbrSpouseSmoker
        ,drvSpoudDateOfBirth
        ,drvDepFirstName
        ,drvDepLastName
        ,drvDepMiddleInitial
        ,drvDepGender
        ,drvDepDateOfBirth
        ,drvDepRelationshipCode
        ,drvDepStudentCode
        ,drvDepDisabledYN
        ,drvDepCvgIndicator
        ,drvDedDhmoPcp

        INTO dbo.U_ELINFINEXP_drvTbl
    FROM dbo.U_EKECACHEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ELINFINEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
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
    SET expLastStartPerControl = '201911011'
       ,expStartPerControl     = '201911011'
       ,expLastEndPerControl   = '201911089'
       ,expEndPerControl       = '201911089'
WHERE expFormatCode = 'ELINFINEXP';

**********************************************************************************/