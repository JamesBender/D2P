SET NOCOUNT ON;
IF OBJECT_ID('U_ELINCNLIF_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELINCNLIF_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELINCNLIF' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELINCNLIF_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELINCNLIF_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELINCNLIF') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINCNLIF];
GO
IF OBJECT_ID('U_ELINCNLIF_File') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_File];
GO
IF OBJECT_ID('U_ELINCNLIF_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_EEList];
GO
IF OBJECT_ID('U_ELINCNLIF_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_drvTbl];
GO
IF OBJECT_ID('U_ELINCNLIF_Dependents') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_Dependents];
GO
IF OBJECT_ID('U_ELINCNLIF_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_DedList];
GO
IF OBJECT_ID('U_ELINCNLIF_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_AuditFields];
GO
IF OBJECT_ID('U_ELINCNLIF_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ELINCNLIF') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELINCNLIF];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELINCNLIF';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELINCNLIF';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELINCNLIF';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELINCNLIF';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELINCNLIF';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELINCNLIF','Lincoln Basic Life','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','27000','S','N','ELINCNLIF0Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELINCNLIF' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID "','1','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','1',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Change Date "','2','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','2',NULL,'Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Change Date "','3','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','3',NULL,'Dep Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date "','4','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','4',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr First Name "','5','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','5',NULL,'Mbr First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Last Name "','6','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','6',NULL,'Mbr Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Middle Initial "','7','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','7',NULL,'Mbr Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr SSN "','8','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','8',NULL,'Mbr SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Gender "','9','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','9',NULL,'Mbr Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr DOB "','10','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','10',NULL,'Mbr DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"App Sign Date "','11','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','11',NULL,'App Sign Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation "','12','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','12',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs Per Week "','13','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','13',NULL,'Hrs Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Amt "','14','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','14',NULL,'Salary Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Code "','15','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','15',NULL,'Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sal Eff Date "','16','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','16',NULL,'Sal Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Addr 1 "','17','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','17',NULL,'Mbr Addr 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Addr 2 "','18','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','18',NULL,'Mbr Addr 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr City "','19','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','19',NULL,'Mbr City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr State "','20','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','20',NULL,'Mbr State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Zip Code "','21','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','21',NULL,'Mbr Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Zip Plus 4 "','22','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','22',NULL,'Mbr Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone "','23','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','23',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone "','24','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','24',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Ext "','25','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','25',NULL,'Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address "','26','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','26',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Benefits Eligibility "','27','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','27',NULL,'Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Subsequent Date of Benefits Eligibility "','28','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','28',NULL,'Subsequent Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reason for Prior Loss of Benefits Eligibility "','29','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','29',NULL,'Reason for Prior Loss of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene First Name "','30','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','30',NULL,'Pri Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Last Name "','31','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','31',NULL,'Pri Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Middle Init "','32','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','32',NULL,'Pri Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Relationship "','33','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','33',NULL,'Pri Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Address 1 "','34','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','34',NULL,'Pri Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Address 2 "','35','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','35',NULL,'Pri Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene City "','36','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','36',NULL,'Pri Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene State "','37','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','37',NULL,'Pri Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Zip Code "','38','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','38',NULL,'Pri Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Zip Plus 4 "','39','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','39',NULL,'Pri Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene SSN "','40','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','40',NULL,'Pri Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene First Name "','41','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','41',NULL,'Co Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Last Name "','42','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','42',NULL,'Co Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Middle Init "','43','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','43',NULL,'Co Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Relationship "','44','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','44',NULL,'Co Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Address 1 "','45','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','45',NULL,'Co Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Address 2 "','46','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','46',NULL,'Co Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene City "','47','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','47',NULL,'Co Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene State "','48','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','48',NULL,'Co Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Zip Code "','49','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','49',NULL,'Co Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Zip Plus 4 "','50','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','50',NULL,'Co Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene SSN "','51','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','51',NULL,'Co Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Beneficiary Comments "','52','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','52',NULL,'Beneficiary Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Policy Number "','53','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','53',NULL,'Accident Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Bill Location A/C Number "','54','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','54',NULL,'Accident Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Sort Group "','55','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','55',NULL,'Accident Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Eff Date "','56','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','56',NULL,'Accident Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Plan Code "','57','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','57',NULL,'Accident Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Class Code "','58','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','58',NULL,'Accident Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Tier Code "','59','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','59',NULL,'Accident Tier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health Asses Tier "','60','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','60',NULL,'Health Asses Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Tier "','61','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','61',NULL,'Hospital Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Disability Amount "','62','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','62',NULL,'Accident Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Tier "','63','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','63',NULL,'Accident DI Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Benefit Period "','64','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','64',NULL,'Accident DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Elim Period "','65','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','65',NULL,'Accident DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Sickness Disability Amount "','66','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','66',NULL,'Accident Sickness Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident/sick Tier "','67','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','67',NULL,'Accident/sick Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident/sick DI Benefit Period "','68','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','68',NULL,'Accident/sick DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident/sick DI Elim Period "','69','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','69',NULL,'Accident/sick DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Termination Date "','70','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','70',NULL,'Accident Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Policy Number "','71','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','71',NULL,'Critical Illness Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Bill Location A/C Number "','72','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','72',NULL,'Critical Illness Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Sort Group "','73','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','73',NULL,'Critical Illness Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Eff Date "','74','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','74',NULL,'Critical Illness Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Plan Code "','75','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','75',NULL,'Critical Illness Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Class Code "','76','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','76',NULL,'Critical Illness Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Termination Date "','77','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','77',NULL,'Critical Illness Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Principal Sum Amt Approved "','78','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','78',NULL,'EE Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Principal Sum Amt Pending "','79','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','79',NULL,'EE Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Principal Sum Amt Approved "','80','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','80',NULL,'SP Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Principal Sum Amt Pending "','81','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','81',NULL,'SP Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Principal Sum Amt Approved "','82','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','82',NULL,'CH Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Principal Sum Amt Pending "','83','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','83',NULL,'CH Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Heart Amt Approved "','84','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','84',NULL,'EE Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Heart Amt Pending "','85','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','85',NULL,'EE Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Heart Amt Approved "','86','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','86',NULL,'SP Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Heart Amt Pending "','87','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','87',NULL,'SP Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Heart Amt Approved "','88','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','88',NULL,'CH Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Heart Amt Pending "','89','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','89',NULL,'CH Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Cancer Amt Approved "','90','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','90',NULL,'EE Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Cancer Amt Pending "','91','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','91',NULL,'EE Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Cancer Amt Approved "','92','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','92',NULL,'SP Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Cancer Amt Pending "','93','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','93',NULL,'SP Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Cancer Amt Approved "','94','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','94',NULL,'CH Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Cancer Amt Pending "','95','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','95',NULL,'CH Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Organ Amt Approved "','96','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','96',NULL,'EE Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Organ Amt Pending "','97','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','97',NULL,'EE Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Organ Amt Approved "','98','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','98',NULL,'SP Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Organ Amt Pending "','99','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','99',NULL,'SP Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Organ Amt Approved "','100','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','100',NULL,'CH Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Organ Amt Pending "','101','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','101',NULL,'CH Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Quality of Life Amt Approved "','102','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','102',NULL,'EE Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Quality of Life Amt Pending "','103','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','103',NULL,'EE Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Quality of Life Amt Approved "','104','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','104',NULL,'SP Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Quality of Life Amt Pending "','105','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','105',NULL,'SP Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Quality of Life Amt Approved "','106','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','106',NULL,'CH Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Quality of Life Amt Pending "','107','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','107',NULL,'CH Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Category Amt Approved "','108','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','108',NULL,'Child Category Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Category Amt Pending "','109','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','109',NULL,'Child Category Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Treatment Care Y/N "','110','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','110',NULL,'EE Treatment Care Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Treatment Care Y/N "','111','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','111',NULL,'SP Treatment Care Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Treatment Care Y/N "','112','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','112',NULL,'CH Treatment Care Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE DI Y/N "','113','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','113',NULL,'EE DI Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP DI Y/N "','114','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','114',NULL,'SP DI Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Accident Y/N "','115','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','115',NULL,'EE Accident Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Accident Y/N "','116','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','116',NULL,'SP Accident Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Accident Y/N "','117','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','117',NULL,'CH Accident Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Occ/HIV Y/N "','118','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','118',NULL,'EE Occ/HIV Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Policy Number "','119','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','119',NULL,'Life Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Bill Location A/C Number "','120','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','120',NULL,'Life Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Sort Group "','121','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','121',NULL,'Life Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Eff Date "','122','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','122',NULL,'Life Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan Code "','123','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','123',NULL,'Life Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Class Code "','124','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','124',NULL,'Life Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LI Cvgs "','125','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','125',NULL,'LI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LI Termination Date "','126','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','126',NULL,'LI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AD Cvgs "','127','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','127',NULL,'AD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AD Termination Date "','128','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','128',NULL,'AD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DLI Cvgs "','129','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','129',NULL,'DLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DLI Termination Date "','130','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','130',NULL,'DLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DAD Cvgs "','131','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','131',NULL,'DAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DAD Termination Date "','132','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','132',NULL,'DAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLI Cvgs "','133','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','133',NULL,'OLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLI Termination Date "','134','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','134',NULL,'OLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OAD Cvgs "','135','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','135',NULL,'OAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OAD Termination Date "','136','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','136',NULL,'OAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODLI Cvgs "','137','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','137',NULL,'ODLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODLI Termination Date "','138','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','138',NULL,'ODLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODAD Cvgs "','139','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','139',NULL,'ODAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ODAD Termination Date "','140','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','140',NULL,'ODAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SLI Cvgs "','141','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','141',NULL,'SLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SLI Termination Date "','142','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','142',NULL,'SLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAD Cvgs "','143','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','143',NULL,'SAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAD Termination Date "','144','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','144',NULL,'SAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLI Cvgs "','145','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','145',NULL,'CLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLI Termination Date "','146','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','146',NULL,'CLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSLI Cvgs "','147','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','147',NULL,'OSLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSLI Termination Date "','148','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','148',NULL,'OSLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSAD Cvgs "','149','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','149',NULL,'OSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OSAD Termination Date "','150','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','150',NULL,'OSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OCLI Cvgs "','151','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','151',NULL,'OCLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OCLI Termination Date "','152','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','152',NULL,'OCLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Policy Number "','153','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','153',NULL,'WI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Bill Location A/C Number "','154','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','154',NULL,'WI Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Sort Group "','155','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','155',NULL,'WI Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Eff Date "','156','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','156',NULL,'WI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Plan Code "','157','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','157',NULL,'WI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Class Code "','158','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','158',NULL,'WI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Cvgs "','159','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','159',NULL,'WI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Termination Date "','160','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','160',NULL,'WI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OWI Cvgs "','161','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','161',NULL,'OWI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OWI Termination Date "','162','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','162',NULL,'OWI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Policy Number "','163','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','163',NULL,'LTD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Bill Location A/C Number "','164','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','164',NULL,'LTD Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Sort Group "','165','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','165',NULL,'LTD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Eff Date "','166','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','166',NULL,'LTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Plan Code "','167','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','167',NULL,'LTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Class Code "','168','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','168',NULL,'LTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Cvgs "','169','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','169',NULL,'LTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Termination Date "','170','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','170',NULL,'LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLTD Cvgs "','171','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','171',NULL,'OLTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OLTD Termination Date "','172','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','172',NULL,'OLTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Cvgs "','173','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','173',NULL,'CI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Date "','174','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','174',NULL,'CI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Policy Number "','175','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','175',NULL,'Dent Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Bill Location A/C Number "','176','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','176',NULL,'Dent Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Sort Group "','177','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','177',NULL,'Dent Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Eff Date "','178','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','178',NULL,'Dent Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Plan Code "','179','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','179',NULL,'Dent Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Class Code "','180','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','180',NULL,'Dent Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Coverage Tier "','181','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','181',NULL,'Dent Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Other Ins "','182','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','182',NULL,'Dent Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Termination Date "','183','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','183',NULL,'Dent Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Policy Number "','184','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','184',NULL,'DHMO Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Bill Location A/C Number "','185','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','185',NULL,'DHMO Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Sort Group "','186','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','186',NULL,'DHMO Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Eff Date "','187','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','187',NULL,'DHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Plan Code "','188','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','188',NULL,'DHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Class Code "','189','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','189',NULL,'DHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Coverage Tier  "','190','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','190',NULL,'DHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO PCP  "','191','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','191',NULL,'DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Termination Date "','192','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','192',NULL,'DHMO Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Policy Number "','193','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','193',NULL,'LVC Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Bill Location A/C Number "','194','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','194',NULL,'LVC Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Sort Group "','195','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','195',NULL,'LVC Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Eff Date "','196','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','196',NULL,'LVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Plan Code "','197','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','197',NULL,'LVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Class Code "','198','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','198',NULL,'LVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Coverage Tier "','199','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','199',NULL,'LVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Other Ins "','200','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','200',NULL,'LVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Termination Date "','201','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','201',NULL,'LVC Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Policy Number "','202','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','202',NULL,'VLVC Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Bill Location A/C Number "','203','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','203',NULL,'VLVC Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Sort Group "','204','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','204',NULL,'VLVC Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Eff Date "','205','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','205',NULL,'VLVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Plan Code "','206','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','206',NULL,'VLVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Class Code "','207','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','207',NULL,'VLVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Coverage Tier "','208','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','208',NULL,'VLVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Other Ins "','209','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','209',NULL,'VLVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Termination Date "','210','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','210',NULL,'VLVC Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Policy Number "','211','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','211',NULL,'VDN Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Bill Location A/C Number "','212','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','212',NULL,'VDN Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Sort Group "','213','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','213',NULL,'VDN Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Eff Date "','214','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','214',NULL,'VDN Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Plan Code "','215','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','215',NULL,'VDN Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Class Code "','216','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','216',NULL,'VDN Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Coverage Tier "','217','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','217',NULL,'VDN Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Other Ins "','218','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','218',NULL,'VDN Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Termination Date "','219','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','219',NULL,'VDN Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Policy Number "','220','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','220',NULL,'VDHMO Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Bill Location A/C Number "','221','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','221',NULL,'VDHMO Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Sort Group "','222','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','222',NULL,'VDHMO Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Eff Date "','223','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','223',NULL,'VDHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Plan Code "','224','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','224',NULL,'VDHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Class Code "','225','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','225',NULL,'VDHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Coverage Tier  "','226','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','226',NULL,'VDHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO PCP  "','227','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','227',NULL,'VDHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDHMO Termination Date "','228','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','228',NULL,'VDHMO Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Policy Number "','229','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','229',NULL,'VLIF Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Bill Location A/C Number "','230','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','230',NULL,'VLIF Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Sort Group "','231','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','231',NULL,'VLIF Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Eff Date "','232','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','232',NULL,'VLIF Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Plan Code "','233','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','233',NULL,'VLIF Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Class Code "','234','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','234',NULL,'VLIF Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLI Cvgs "','235','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','235',NULL,'VLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLI Termination Date "','236','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','236',NULL,'VLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VAD Cvgs "','237','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','237',NULL,'VAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VAD Termination Date "','238','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','238',NULL,'VAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLI Cvgs "','239','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','239',NULL,'VSLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLI Termination Date "','240','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','240',NULL,'VSLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSAD Cvgs "','241','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','241',NULL,'VSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSAD Termination Date "','242','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','242',NULL,'VSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLI Cvgs "','243','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','243',NULL,'VCLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLI Termination Date "','244','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','244',NULL,'VCLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Policy Number "','245','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','245',NULL,'VWI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Bill Location A/C Number "','246','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','246',NULL,'VWI Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Sort Group "','247','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','247',NULL,'VWI Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Eff Date "','248','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','248',NULL,'VWI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Plan Code "','249','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','249',NULL,'VWI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Class Code "','250','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','250',NULL,'VWI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Benefit Amt "','251','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','251',NULL,'VWI Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Elim Period "','252','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','252',NULL,'VWI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Benefit Duration "','253','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','253',NULL,'VWI Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Termination Date "','254','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','254',NULL,'VWI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Policy Number "','255','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','255',NULL,'VLTD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Bill Location A/C Number "','256','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','256',NULL,'VLTD Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Sort Group "','257','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','257',NULL,'VLTD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Eff Date "','258','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','258',NULL,'VLTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Plan Code "','259','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','259',NULL,'VLTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Class Code "','260','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','260',NULL,'VLTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Amt "','261','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','261',NULL,'VLTD Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Elim Period "','262','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','262',NULL,'VLTD Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Duration "','263','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','263',NULL,'VLTD Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Pct "','264','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','264',NULL,'VLTD Benefit Pct',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Termination Date "','265','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','265',NULL,'VLTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Policy Number "','266','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','266',NULL,'STAD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Bill Location A/C Number "','267','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','267',NULL,'STAD Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Sort Group "','268','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','268',NULL,'STAD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Eff Date "','269','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','269',NULL,'STAD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Plan Code "','270','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','270',NULL,'STAD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Class Code "','271','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','271',NULL,'STAD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVAD Cvgs "','272','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','272',NULL,'STVAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVAD Termination Date "','273','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','273',NULL,'STVAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVSAD Cvgs "','274','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','274',NULL,'STVSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVSAD Termination Date "','275','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','275',NULL,'STVSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVCAD Cvgs "','276','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','276',NULL,'STVCAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STVCAD Termination Date "','277','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','277',NULL,'STVCAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualifying Event Code "','278','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','278',NULL,'Qualifying Event Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualifying Event Eff Date "','279','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','279',NULL,'Qualifying Event Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Smoker "','280','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','280',NULL,'Mbr Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Smoker  "','281','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','281',NULL,'Spouse Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse DOB "','282','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','282',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name "','283','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name "','284','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I  "','285','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender "','286','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB "','287','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code "','288','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code "','289','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled Y/N "','290','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','290',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator "','291','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP  "','292','(''DA''=''Q,'')','ELINCNLIF0Z0','50','H','01','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name"','293','(''DA''=''Q,'')','ELINCNLIF0Z0','199','H','01','293',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name"','294','(''DA''=''Q,'')','ELINCNLIF0Z0','200','H','01','294',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I"','295','(''DA''=''Q,'')','ELINCNLIF0Z0','201','H','01','295',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender"','296','(''DA''=''Q,'')','ELINCNLIF0Z0','202','H','01','296',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB"','297','(''DA''=''Q,'')','ELINCNLIF0Z0','203','H','01','297',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code"','298','(''DA''=''Q,'')','ELINCNLIF0Z0','204','H','01','298',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code"','299','(''DA''=''Q,'')','ELINCNLIF0Z0','205','H','01','299',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled Y/N"','300','(''DA''=''Q,'')','ELINCNLIF0Z0','206','H','01','300',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator"','301','(''DA''=''Q,'')','ELINCNLIF0Z0','207','H','01','301',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP"','302','(''DA''=''Q,'')','ELINCNLIF0Z0','208','H','01','302',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name"','303','(''DA''=''Q,'')','ELINCNLIF0Z0','199','H','01','303',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name"','304','(''DA''=''Q,'')','ELINCNLIF0Z0','200','H','01','304',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I"','305','(''DA''=''Q,'')','ELINCNLIF0Z0','201','H','01','305',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender"','306','(''DA''=''Q,'')','ELINCNLIF0Z0','202','H','01','306',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB"','307','(''DA''=''Q,'')','ELINCNLIF0Z0','203','H','01','307',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code"','308','(''DA''=''Q,'')','ELINCNLIF0Z0','204','H','01','308',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code"','309','(''DA''=''Q,'')','ELINCNLIF0Z0','205','H','01','309',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled Y/N"','310','(''DA''=''Q,'')','ELINCNLIF0Z0','206','H','01','310',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator"','311','(''DA''=''Q,'')','ELINCNLIF0Z0','207','H','01','311',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP"','312','(''DA''=''Q,'')','ELINCNLIF0Z0','208','H','01','312',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name"','313','(''DA''=''Q,'')','ELINCNLIF0Z0','199','H','01','313',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name"','314','(''DA''=''Q,'')','ELINCNLIF0Z0','200','H','01','314',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I"','315','(''DA''=''Q,'')','ELINCNLIF0Z0','201','H','01','315',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender"','316','(''DA''=''Q,'')','ELINCNLIF0Z0','202','H','01','316',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB"','317','(''DA''=''Q,'')','ELINCNLIF0Z0','203','H','01','317',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code"','318','(''DA''=''Q,'')','ELINCNLIF0Z0','204','H','01','318',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code"','319','(''DA''=''Q,'')','ELINCNLIF0Z0','205','H','01','319',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled Y/N"','320','(''DA''=''Q,'')','ELINCNLIF0Z0','206','H','01','320',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator"','321','(''DA''=''Q,'')','ELINCNLIF0Z0','207','H','01','321',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP"','322','(''DA''=''Q,'')','ELINCNLIF0Z0','208','H','01','322',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name"','323','(''DA''=''Q,'')','ELINCNLIF0Z0','199','H','01','323',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name"','324','(''DA''=''Q,'')','ELINCNLIF0Z0','200','H','01','324',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I"','325','(''DA''=''Q,'')','ELINCNLIF0Z0','201','H','01','325',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender"','326','(''DA''=''Q,'')','ELINCNLIF0Z0','202','H','01','326',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB"','327','(''DA''=''Q,'')','ELINCNLIF0Z0','203','H','01','327',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code"','328','(''DA''=''Q,'')','ELINCNLIF0Z0','204','H','01','328',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code"','329','(''DA''=''Q,'')','ELINCNLIF0Z0','205','H','01','329',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled Y/N"','330','(''DA''=''Q,'')','ELINCNLIF0Z0','206','H','01','330',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator"','331','(''DA''=''Q,'')','ELINCNLIF0Z0','207','H','01','331',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP"','332','(''DA''=''Q,'')','ELINCNLIF0Z0','208','H','01','332',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name"','333','(''DA''=''Q,'')','ELINCNLIF0Z0','199','H','01','333',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name"','334','(''DA''=''Q,'')','ELINCNLIF0Z0','200','H','01','334',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I"','335','(''DA''=''Q,'')','ELINCNLIF0Z0','201','H','01','335',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender"','336','(''DA''=''Q,'')','ELINCNLIF0Z0','202','H','01','336',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB"','337','(''DA''=''Q,'')','ELINCNLIF0Z0','203','H','01','337',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code"','338','(''DA''=''Q,'')','ELINCNLIF0Z0','204','H','01','338',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code"','339','(''DA''=''Q,'')','ELINCNLIF0Z0','205','H','01','339',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled Y/N"','340','(''DA''=''Q,'')','ELINCNLIF0Z0','206','H','01','340',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator"','341','(''DA''=''Q,'')','ELINCNLIF0Z0','207','H','01','341',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP"','342','(''DA''=''Q,'')','ELINCNLIF0Z0','208','H','01','342',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name"','343','(''DA''=''Q,'')','ELINCNLIF0Z0','199','H','01','343',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name"','344','(''DA''=''Q,'')','ELINCNLIF0Z0','200','H','01','344',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I"','345','(''DA''=''Q,'')','ELINCNLIF0Z0','201','H','01','345',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender"','346','(''DA''=''Q,'')','ELINCNLIF0Z0','202','H','01','346',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB"','347','(''DA''=''Q,'')','ELINCNLIF0Z0','203','H','01','347',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code"','348','(''DA''=''Q,'')','ELINCNLIF0Z0','204','H','01','348',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code"','349','(''DA''=''Q,'')','ELINCNLIF0Z0','205','H','01','349',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled Y/N"','350','(''DA''=''Q,'')','ELINCNLIF0Z0','206','H','01','350',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator"','351','(''DA''=''Q,'')','ELINCNLIF0Z0','207','H','01','351',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP"','352','(''DA''=''Q,'')','ELINCNLIF0Z0','208','H','01','352',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name"','353','(''DA''=''Q,'')','ELINCNLIF0Z0','199','H','01','353',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name"','354','(''DA''=''Q,'')','ELINCNLIF0Z0','200','H','01','354',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I"','355','(''DA''=''Q,'')','ELINCNLIF0Z0','201','H','01','355',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender"','356','(''DA''=''Q,'')','ELINCNLIF0Z0','202','H','01','356',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB"','357','(''DA''=''Q,'')','ELINCNLIF0Z0','203','H','01','357',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code"','358','(''DA''=''Q,'')','ELINCNLIF0Z0','204','H','01','358',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code"','359','(''DA''=''Q,'')','ELINCNLIF0Z0','205','H','01','359',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled Y/N"','360','(''DA''=''Q,'')','ELINCNLIF0Z0','206','H','01','360',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator"','361','(''DA''=''Q,'')','ELINCNLIF0Z0','207','H','01','361',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP"','362','(''DA''=''Q,'')','ELINCNLIF0Z0','208','H','01','362',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name"','363','(''DA''=''Q,'')','ELINCNLIF0Z0','199','H','01','363',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name"','364','(''DA''=''Q,'')','ELINCNLIF0Z0','200','H','01','364',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I"','365','(''DA''=''Q,'')','ELINCNLIF0Z0','201','H','01','365',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender"','366','(''DA''=''Q,'')','ELINCNLIF0Z0','202','H','01','366',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB"','367','(''DA''=''Q,'')','ELINCNLIF0Z0','203','H','01','367',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code"','368','(''DA''=''Q,'')','ELINCNLIF0Z0','204','H','01','368',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code"','369','(''DA''=''Q,'')','ELINCNLIF0Z0','205','H','01','369',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled Y/N"','370','(''DA''=''Q,'')','ELINCNLIF0Z0','206','H','01','370',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator"','371','(''DA''=''Q,'')','ELINCNLIF0Z0','207','H','01','371',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP"','372','(''DA''=''Q,'')','ELINCNLIF0Z0','208','H','01','372',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name"','373','(''DA''=''Q,'')','ELINCNLIF0Z0','199','H','01','373',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name"','374','(''DA''=''Q,'')','ELINCNLIF0Z0','200','H','01','374',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I"','375','(''DA''=''Q,'')','ELINCNLIF0Z0','201','H','01','375',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender"','376','(''DA''=''Q,'')','ELINCNLIF0Z0','202','H','01','376',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB"','377','(''DA''=''Q,'')','ELINCNLIF0Z0','203','H','01','377',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code"','378','(''DA''=''Q,'')','ELINCNLIF0Z0','204','H','01','378',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code"','379','(''DA''=''Q,'')','ELINCNLIF0Z0','205','H','01','379',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Disabled Y/N"','380','(''DA''=''Q,'')','ELINCNLIF0Z0','206','H','01','380',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator"','381','(''DA''=''Q,'')','ELINCNLIF0Z0','207','H','01','381',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP"','382','(''DA''=''Q'')','ELINCNLIF0Z0','208','H','01','382',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','1','(''UA''=''Q,'')','ELINCNLIF0Z0','20','D','10','1',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChangeDate"','2','(''UD101''=''T,'')','ELINCNLIF0Z0','10','D','10','2',NULL,'Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepChangeDate"','3','(''UD101''=''T,'')','ELINCNLIF0Z0','10','D','10','3',NULL,'Dep Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEedBenStopDate"','4','(''UD101''=''T,'')','ELINCNLIF0Z0','10','D','10','4',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','5',NULL,'Mbr First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','6',NULL,'Mbr Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''Q,'')','ELINCNLIF0Z0','1','D','10','7',NULL,'Mbr Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''Q,'')','ELINCNLIF0Z0','11','D','10','8',NULL,'Mbr SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''Q,'')','ELINCNLIF0Z0','1','D','10','9',NULL,'Mbr Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','10','(''UD101''=''T,'')','ELINCNLIF0Z0','10','D','10','10',NULL,'Mbr DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAppSignDate"','11','(''UD101''=''T,'')','ELINCNLIF0Z0','50','D','10','11',NULL,'App Sign Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobDesc"','12','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','12',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledWorkHrs"','13','(''UNT2''=''T,'')','ELINCNLIF0Z0','50','D','10','13',NULL,'Hrs Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnSalary"','14','(''UNT2''=''T,'')','ELINCNLIF0Z0','50','D','10','14',NULL,'Salary Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','15','(''DA''=''Q,'')','ELINCNLIF0Z0','50','D','10','15',NULL,'Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryEffDate"','16','(''UD101''=''T,'')','ELINCNLIF0Z0','50','D','10','16',NULL,'Sal Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','17','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','17',NULL,'Mbr Addr 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','18','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','18',NULL,'Mbr Addr 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','19','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','19',NULL,'Mbr City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdressState"','20','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','20',NULL,'Mbr State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','21','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','21',NULL,'Mbr Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','22',NULL,'Mbr Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','23','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','23',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','24',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','25',NULL,'Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','26',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','27','(''UD101''=''T,'')','ELINCNLIF0Z0','50','D','10','27',NULL,'Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','28','(''UD101''=''T,'')','ELINCNLIF0Z0','50','D','10','28',NULL,'Subsequent Date of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRsnLossOfBen"','29','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','29',NULL,'Reason for Prior Loss of Benefits Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','30',NULL,'Pri Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','31',NULL,'Pri Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','32',NULL,'Pri Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','33',NULL,'Pri Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','34',NULL,'Pri Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','35',NULL,'Pri Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','36',NULL,'Pri Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','37',NULL,'Pri Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','38',NULL,'Pri Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','39',NULL,'Pri Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','40',NULL,'Pri Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','41',NULL,'Co Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','42',NULL,'Co Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','43',NULL,'Co Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','44',NULL,'Co Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','45',NULL,'Co Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','46',NULL,'Co Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','47',NULL,'Co Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','48',NULL,'Co Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','49',NULL,'Co Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','50',NULL,'Co Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','51',NULL,'Co Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','52',NULL,'Beneficiary Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','53',NULL,'Accident Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','54',NULL,'Accident Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','55',NULL,'Accident Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','56',NULL,'Accident Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','57',NULL,'Accident Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','58',NULL,'Accident Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','59',NULL,'Accident Tier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','60',NULL,'Health Asses Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','61',NULL,'Hospital Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','62',NULL,'Accident Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','63',NULL,'Accident DI Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','64',NULL,'Accident DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','65',NULL,'Accident DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','66',NULL,'Accident Sickness Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','67',NULL,'Accident/sick Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','68',NULL,'Accident/sick DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','69',NULL,'Accident/sick DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','70',NULL,'Accident Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','71',NULL,'Critical Illness Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','72',NULL,'Critical Illness Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','73',NULL,'Critical Illness Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','74',NULL,'Critical Illness Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','75',NULL,'Critical Illness Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','76',NULL,'Critical Illness Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','77',NULL,'Critical Illness Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','78',NULL,'EE Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','79',NULL,'EE Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','80',NULL,'SP Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','81',NULL,'SP Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','82',NULL,'CH Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','83',NULL,'CH Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','84',NULL,'EE Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','85',NULL,'EE Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','86',NULL,'SP Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','87',NULL,'SP Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','88',NULL,'CH Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','89',NULL,'CH Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','90',NULL,'EE Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','91',NULL,'EE Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','92',NULL,'SP Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','93',NULL,'SP Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','94',NULL,'CH Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','95',NULL,'CH Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','96',NULL,'EE Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','97',NULL,'EE Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','98','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','98',NULL,'SP Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','99','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','99',NULL,'SP Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','100',NULL,'CH Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','101',NULL,'CH Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','102',NULL,'EE Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','103',NULL,'EE Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','104',NULL,'SP Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','105',NULL,'SP Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','106','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','106',NULL,'CH Quality of Life Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','107','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','107',NULL,'CH Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','108',NULL,'Child Category Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','109',NULL,'Child Category Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','110',NULL,'EE Treatment Care Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','111',NULL,'SP Treatment Care Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','112','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','112',NULL,'CH Treatment Care Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','113','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','113',NULL,'EE DI Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','114',NULL,'SP DI Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','115','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','115',NULL,'EE Accident Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','116','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','116',NULL,'SP Accident Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','117','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','117',NULL,'CH Accident Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','118','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','118',NULL,'EE Occ/HIV Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePolicyNum"','119','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','119',NULL,'Life Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifBillLocNum"','120','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','120',NULL,'Life Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','121','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','121',NULL,'Life Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeEffDate"','122','(''UD101''=''T,'')','ELINCNLIF0Z0','50','D','10','122',NULL,'Life Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlanCode"','123','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','123',NULL,'Life Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeClassCode"','124','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','124',NULL,'Life Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLICvgs"','125','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','125',NULL,'LI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLITermDate"','126','(''UD101''=''T,'')','ELINCNLIF0Z0','50','D','10','126',NULL,'LI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADCvgs"','127','(''UA''=''Q,'')','ELINCNLIF0Z0','50','D','10','127',NULL,'AD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADTermDate"','128','(''UD101''=''T,'')','ELINCNLIF0Z0','50','D','10','128',NULL,'AD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','129','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','129',NULL,'DLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','130','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','130',NULL,'DLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','131',NULL,'DAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','132','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','132',NULL,'DAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','133',NULL,'OLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','134','(''SS''=''Q,'')','ELINCNLIF0Z0','50','D','10','134',NULL,'OLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','135','(''SS''=''Q,'')','ELINCNLIF0Z0','51','D','10','135',NULL,'OAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''SS''=''Q,'')','ELINCNLIF0Z0','52','D','10','136',NULL,'OAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','137','(''SS''=''Q,'')','ELINCNLIF0Z0','53','D','10','137',NULL,'ODLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''SS''=''Q,'')','ELINCNLIF0Z0','54','D','10','138',NULL,'ODLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''SS''=''Q,'')','ELINCNLIF0Z0','55','D','10','139',NULL,'ODAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''SS''=''Q,'')','ELINCNLIF0Z0','56','D','10','140',NULL,'ODAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''SS''=''Q,'')','ELINCNLIF0Z0','57','D','10','141',NULL,'SLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''SS''=''Q,'')','ELINCNLIF0Z0','58','D','10','142',NULL,'SLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','143','(''SS''=''Q,'')','ELINCNLIF0Z0','59','D','10','143',NULL,'SAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','144','(''SS''=''Q,'')','ELINCNLIF0Z0','60','D','10','144',NULL,'SAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','145','(''SS''=''Q,'')','ELINCNLIF0Z0','61','D','10','145',NULL,'CLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','146','(''SS''=''Q,'')','ELINCNLIF0Z0','62','D','10','146',NULL,'CLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','147','(''SS''=''Q,'')','ELINCNLIF0Z0','63','D','10','147',NULL,'OSLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''SS''=''Q,'')','ELINCNLIF0Z0','64','D','10','148',NULL,'OSLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','149','(''SS''=''Q,'')','ELINCNLIF0Z0','65','D','10','149',NULL,'OSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','150','(''SS''=''Q,'')','ELINCNLIF0Z0','66','D','10','150',NULL,'OSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''SS''=''Q,'')','ELINCNLIF0Z0','67','D','10','151',NULL,'OCLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','152','(''SS''=''Q,'')','ELINCNLIF0Z0','68','D','10','152',NULL,'OCLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWIPolicyNum"','153','(''UA''=''Q,'')','ELINCNLIF0Z0','69','D','10','153',NULL,'WI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWIBillLocNum"','154','(''UA''=''Q,'')','ELINCNLIF0Z0','70','D','10','154',NULL,'WI Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','155','(''SS''=''Q,'')','ELINCNLIF0Z0','71','D','10','155',NULL,'WI Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWIEffDate"','156','(''UD101''=''T,'')','ELINCNLIF0Z0','72','D','10','156',NULL,'WI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWIPlanCode"','157','(''UA''=''Q,'')','ELINCNLIF0Z0','73','D','10','157',NULL,'WI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWIClassCode"','158','(''UA''=''Q,'')','ELINCNLIF0Z0','74','D','10','158',NULL,'WI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWICvgs"','159','(''UA''=''Q,'')','ELINCNLIF0Z0','75','D','10','159',NULL,'WI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWITermDate"','160','(''UD101''=''T,'')','ELINCNLIF0Z0','76','D','10','160',NULL,'WI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','161','(''SS''=''Q,'')','ELINCNLIF0Z0','77','D','10','161',NULL,'OWI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','162','(''SS''=''Q,'')','ELINCNLIF0Z0','78','D','10','162',NULL,'OWI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDPolicyNum"','163','(''UA''=''Q,'')','ELINCNLIF0Z0','79','D','10','163',NULL,'LTD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDBillLocNum"','164','(''UA''=''Q,'')','ELINCNLIF0Z0','80','D','10','164',NULL,'LTD Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','165','(''SS''=''Q,'')','ELINCNLIF0Z0','81','D','10','165',NULL,'LTD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEffDate"','166','(''UD101''=''T,'')','ELINCNLIF0Z0','82','D','10','166',NULL,'LTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDPlanCode"','167','(''UA''=''Q,'')','ELINCNLIF0Z0','83','D','10','167',NULL,'LTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDClassCode"','168','(''UA''=''Q,'')','ELINCNLIF0Z0','84','D','10','168',NULL,'LTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDCvgs"','169','(''UA''=''Q,'')','ELINCNLIF0Z0','85','D','10','169',NULL,'LTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDTermDate"','170','(''UD101''=''T,'')','ELINCNLIF0Z0','86','D','10','170',NULL,'LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','171','(''SS''=''Q,'')','ELINCNLIF0Z0','87','D','10','171',NULL,'OLTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','172','(''SS''=''Q,'')','ELINCNLIF0Z0','88','D','10','172',NULL,'OLTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','173','(''SS''=''Q,'')','ELINCNLIF0Z0','89','D','10','173',NULL,'CI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','174','(''SS''=''Q,'')','ELINCNLIF0Z0','90','D','10','174',NULL,'CI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','175','(''SS''=''Q,'')','ELINCNLIF0Z0','91','D','10','175',NULL,'Dent Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','176','(''SS''=''Q,'')','ELINCNLIF0Z0','92','D','10','176',NULL,'Dent Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','177','(''SS''=''Q,'')','ELINCNLIF0Z0','93','D','10','177',NULL,'Dent Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','178','(''SS''=''Q,'')','ELINCNLIF0Z0','94','D','10','178',NULL,'Dent Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','179','(''SS''=''Q,'')','ELINCNLIF0Z0','95','D','10','179',NULL,'Dent Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','180','(''SS''=''Q,'')','ELINCNLIF0Z0','96','D','10','180',NULL,'Dent Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','181','(''SS''=''Q,'')','ELINCNLIF0Z0','97','D','10','181',NULL,'Dent Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','182','(''SS''=''Q,'')','ELINCNLIF0Z0','98','D','10','182',NULL,'Dent Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','183','(''SS''=''Q,'')','ELINCNLIF0Z0','99','D','10','183',NULL,'Dent Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','184','(''SS''=''Q,'')','ELINCNLIF0Z0','100','D','10','184',NULL,'DHMO Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','185','(''SS''=''Q,'')','ELINCNLIF0Z0','101','D','10','185',NULL,'DHMO Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','186','(''SS''=''Q,'')','ELINCNLIF0Z0','102','D','10','186',NULL,'DHMO Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','187','(''SS''=''Q,'')','ELINCNLIF0Z0','103','D','10','187',NULL,'DHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','188','(''SS''=''Q,'')','ELINCNLIF0Z0','104','D','10','188',NULL,'DHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','189','(''SS''=''Q,'')','ELINCNLIF0Z0','105','D','10','189',NULL,'DHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','190','(''SS''=''Q,'')','ELINCNLIF0Z0','106','D','10','190',NULL,'DHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','191','(''SS''=''Q,'')','ELINCNLIF0Z0','107','D','10','191',NULL,'DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','192','(''SS''=''Q,'')','ELINCNLIF0Z0','108','D','10','192',NULL,'DHMO Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','193','(''SS''=''Q,'')','ELINCNLIF0Z0','109','D','10','193',NULL,'LVC Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','194','(''SS''=''Q,'')','ELINCNLIF0Z0','110','D','10','194',NULL,'LVC Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','195','(''SS''=''Q,'')','ELINCNLIF0Z0','111','D','10','195',NULL,'LVC Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','196','(''SS''=''Q,'')','ELINCNLIF0Z0','112','D','10','196',NULL,'LVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','197','(''SS''=''Q,'')','ELINCNLIF0Z0','113','D','10','197',NULL,'LVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','198','(''SS''=''Q,'')','ELINCNLIF0Z0','114','D','10','198',NULL,'LVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','199','(''SS''=''Q,'')','ELINCNLIF0Z0','115','D','10','199',NULL,'LVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','200','(''SS''=''Q,'')','ELINCNLIF0Z0','116','D','10','200',NULL,'LVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','201','(''SS''=''Q,'')','ELINCNLIF0Z0','117','D','10','201',NULL,'LVC Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','202','(''SS''=''Q,'')','ELINCNLIF0Z0','118','D','10','202',NULL,'VLVC Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','203','(''SS''=''Q,'')','ELINCNLIF0Z0','119','D','10','203',NULL,'VLVC Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','204','(''SS''=''Q,'')','ELINCNLIF0Z0','120','D','10','204',NULL,'VLVC Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','205','(''SS''=''Q,'')','ELINCNLIF0Z0','121','D','10','205',NULL,'VLVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','206','(''SS''=''Q,'')','ELINCNLIF0Z0','122','D','10','206',NULL,'VLVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','207','(''SS''=''Q,'')','ELINCNLIF0Z0','123','D','10','207',NULL,'VLVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','208','(''SS''=''Q,'')','ELINCNLIF0Z0','124','D','10','208',NULL,'VLVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','209','(''SS''=''Q,'')','ELINCNLIF0Z0','125','D','10','209',NULL,'VLVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','210','(''SS''=''Q,'')','ELINCNLIF0Z0','126','D','10','210',NULL,'VLVC Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','211','(''SS''=''Q,'')','ELINCNLIF0Z0','127','D','10','211',NULL,'VDN Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','212','(''SS''=''Q,'')','ELINCNLIF0Z0','128','D','10','212',NULL,'VDN Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','213','(''SS''=''Q,'')','ELINCNLIF0Z0','129','D','10','213',NULL,'VDN Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','214','(''SS''=''Q,'')','ELINCNLIF0Z0','130','D','10','214',NULL,'VDN Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','215','(''SS''=''Q,'')','ELINCNLIF0Z0','131','D','10','215',NULL,'VDN Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','216','(''SS''=''Q,'')','ELINCNLIF0Z0','132','D','10','216',NULL,'VDN Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','217','(''SS''=''Q,'')','ELINCNLIF0Z0','133','D','10','217',NULL,'VDN Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','218','(''SS''=''Q,'')','ELINCNLIF0Z0','134','D','10','218',NULL,'VDN Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','219','(''SS''=''Q,'')','ELINCNLIF0Z0','135','D','10','219',NULL,'VDN Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','220','(''SS''=''Q,'')','ELINCNLIF0Z0','136','D','10','220',NULL,'VDHMO Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','221','(''SS''=''Q,'')','ELINCNLIF0Z0','137','D','10','221',NULL,'VDHMO Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','222','(''SS''=''Q,'')','ELINCNLIF0Z0','138','D','10','222',NULL,'VDHMO Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','223','(''SS''=''Q,'')','ELINCNLIF0Z0','139','D','10','223',NULL,'VDHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','224','(''SS''=''Q,'')','ELINCNLIF0Z0','140','D','10','224',NULL,'VDHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','225','(''SS''=''Q,'')','ELINCNLIF0Z0','141','D','10','225',NULL,'VDHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','226','(''SS''=''Q,'')','ELINCNLIF0Z0','142','D','10','226',NULL,'VDHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','227','(''SS''=''Q,'')','ELINCNLIF0Z0','143','D','10','227',NULL,'VDHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','228','(''SS''=''Q,'')','ELINCNLIF0Z0','144','D','10','228',NULL,'VDHMO Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFPolicyNum"','229','(''UA''=''Q,'')','ELINCNLIF0Z0','145','D','10','229',NULL,'VLIF Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFBillLocNum"','230','(''UA''=''Q,'')','ELINCNLIF0Z0','146','D','10','230',NULL,'VLIF Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','231','(''SS''=''Q,'')','ELINCNLIF0Z0','147','D','10','231',NULL,'VLIF Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFEffDate"','232','(''UD101''=''T,'')','ELINCNLIF0Z0','148','D','10','232',NULL,'VLIF Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFPlanCode"','233','(''UA''=''Q,'')','ELINCNLIF0Z0','149','D','10','233',NULL,'VLIF Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFClassCode"','234','(''UA''=''Q,'')','ELINCNLIF0Z0','150','D','10','234',NULL,'VLIF Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLICvgs"','235','(''UA''=''Q,'')','ELINCNLIF0Z0','151','D','10','235',NULL,'VLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLITermDate"','236','(''UD101''=''T,'')','ELINCNLIF0Z0','152','D','10','236',NULL,'VLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVADCvgs"','237','(''UA''=''Q,'')','ELINCNLIF0Z0','153','D','10','237',NULL,'VAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVADTermDate"','238','(''UD101''=''T,'')','ELINCNLIF0Z0','154','D','10','238',NULL,'VAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSLICvgs"','239','(''UA''=''Q,'')','ELINCNLIF0Z0','155','D','10','239',NULL,'VSLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLSITermDate"','240','(''UD101''=''T,'')','ELINCNLIF0Z0','156','D','10','240',NULL,'VSLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSADCvgs"','241','(''UA''=''Q,'')','ELINCNLIF0Z0','157','D','10','241',NULL,'VSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSADTermDate"','242','(''UD101''=''T,'')','ELINCNLIF0Z0','158','D','10','242',NULL,'VSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVCLICvgs"','243','(''UA''=''Q,'')','ELINCNLIF0Z0','159','D','10','243',NULL,'VCLI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVCLITermDate"','244','(''UD101''=''T,'')','ELINCNLIF0Z0','160','D','10','244',NULL,'VCLI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','245','(''SS''=''Q,'')','ELINCNLIF0Z0','161','D','10','245',NULL,'VWI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','246','(''SS''=''Q,'')','ELINCNLIF0Z0','162','D','10','246',NULL,'VWI Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','247','(''SS''=''Q,'')','ELINCNLIF0Z0','163','D','10','247',NULL,'VWI Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','248','(''SS''=''Q,'')','ELINCNLIF0Z0','164','D','10','248',NULL,'VWI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','249','(''SS''=''Q,'')','ELINCNLIF0Z0','165','D','10','249',NULL,'VWI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','250','(''SS''=''Q,'')','ELINCNLIF0Z0','166','D','10','250',NULL,'VWI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','251','(''SS''=''Q,'')','ELINCNLIF0Z0','167','D','10','251',NULL,'VWI Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','252','(''SS''=''Q,'')','ELINCNLIF0Z0','168','D','10','252',NULL,'VWI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','253','(''SS''=''Q,'')','ELINCNLIF0Z0','169','D','10','253',NULL,'VWI Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','254','(''SS''=''Q,'')','ELINCNLIF0Z0','170','D','10','254',NULL,'VWI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','255','(''SS''=''Q,'')','ELINCNLIF0Z0','171','D','10','255',NULL,'VLTD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','256','(''SS''=''Q,'')','ELINCNLIF0Z0','172','D','10','256',NULL,'VLTD Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','257','(''SS''=''Q,'')','ELINCNLIF0Z0','173','D','10','257',NULL,'VLTD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','258','(''SS''=''Q,'')','ELINCNLIF0Z0','174','D','10','258',NULL,'VLTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','259','(''SS''=''Q,'')','ELINCNLIF0Z0','175','D','10','259',NULL,'VLTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','260','(''SS''=''Q,'')','ELINCNLIF0Z0','176','D','10','260',NULL,'VLTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','261','(''SS''=''Q,'')','ELINCNLIF0Z0','177','D','10','261',NULL,'VLTD Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','262','(''SS''=''Q,'')','ELINCNLIF0Z0','178','D','10','262',NULL,'VLTD Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','263','(''SS''=''Q,'')','ELINCNLIF0Z0','179','D','10','263',NULL,'VLTD Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','264','(''SS''=''Q,'')','ELINCNLIF0Z0','180','D','10','264',NULL,'VLTD Benefit Pct',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','265','(''SS''=''Q,'')','ELINCNLIF0Z0','181','D','10','265',NULL,'VLTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','266','(''SS''=''Q,'')','ELINCNLIF0Z0','182','D','10','266',NULL,'STAD Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','267','(''SS''=''Q,'')','ELINCNLIF0Z0','183','D','10','267',NULL,'STAD Bill Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','268','(''SS''=''Q,'')','ELINCNLIF0Z0','184','D','10','268',NULL,'STAD Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','269','(''SS''=''Q,'')','ELINCNLIF0Z0','185','D','10','269',NULL,'STAD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','270','(''SS''=''Q,'')','ELINCNLIF0Z0','186','D','10','270',NULL,'STAD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','271','(''SS''=''Q,'')','ELINCNLIF0Z0','187','D','10','271',NULL,'STAD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','272','(''SS''=''Q,'')','ELINCNLIF0Z0','188','D','10','272',NULL,'STVAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','273','(''SS''=''Q,'')','ELINCNLIF0Z0','189','D','10','273',NULL,'STVAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','274','(''SS''=''Q,'')','ELINCNLIF0Z0','190','D','10','274',NULL,'STVSAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','275','(''SS''=''Q,'')','ELINCNLIF0Z0','191','D','10','275',NULL,'STVSAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','276','(''SS''=''Q,'')','ELINCNLIF0Z0','192','D','10','276',NULL,'STVCAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','277','(''SS''=''Q,'')','ELINCNLIF0Z0','193','D','10','277',NULL,'STVCAD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','278','(''SS''=''Q,'')','ELINCNLIF0Z0','194','D','10','278',NULL,'Qualifying Event Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','279','(''SS''=''Q,'')','ELINCNLIF0Z0','195','D','10','279',NULL,'Qualifying Event Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsSmoker"','280','(''UA''=''Q,'')','ELINCNLIF0Z0','196','D','10','280',NULL,'Mbr Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSmoker"','281','(''UA''=''Q,'')','ELINCNLIF0Z0','197','D','10','281',NULL,'Spouse Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDOB"','282','(''UD101''=''T,'')','ELINCNLIF0Z0','198','D','10','282',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameFirst1"','283','(''UA''=''Q,'')','ELINCNLIF0Z0','199','D','10','283',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast1"','284','(''UA''=''Q,'')','ELINCNLIF0Z0','200','D','10','284',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameMiddle1"','285','(''UA''=''Q,'')','ELINCNLIF0Z0','201','D','10','285',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender1"','286','(''UA''=''Q,'')','ELINCNLIF0Z0','202','D','10','286',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth1"','287','(''UD101''=''T,'')','ELINCNLIF0Z0','203','D','10','287',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship1"','288','(''UA''=''Q,'')','ELINCNLIF0Z0','204','D','10','288',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode1"','289','(''UA''=''Q,'')','ELINCNLIF0Z0','205','D','10','289',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabled1"','290','(''UA''=''Q,'')','ELINCNLIF0Z0','206','D','10','290',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','291','(''SS''=''Q,'')','ELINCNLIF0Z0','207','D','10','291',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','292','(''SS''=''Q,'')','ELINCNLIF0Z0','208','D','10','292',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameFirst2"','293','(''UA''=''Q,'')','ELINCNLIF0Z0','199','D','10','293',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast2"','294','(''UA''=''Q,'')','ELINCNLIF0Z0','200','D','10','294',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameMiddle2"','295','(''UA''=''Q,'')','ELINCNLIF0Z0','201','D','10','295',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender2"','296','(''UA''=''Q,'')','ELINCNLIF0Z0','202','D','10','296',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth2"','297','(''UD101''=''T,'')','ELINCNLIF0Z0','203','D','10','297',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship2"','298','(''UA''=''Q,'')','ELINCNLIF0Z0','204','D','10','298',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode2"','299','(''UA''=''Q,'')','ELINCNLIF0Z0','205','D','10','299',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabled2"','300','(''UA''=''Q,'')','ELINCNLIF0Z0','206','D','10','300',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','301','(''SS''=''Q,'')','ELINCNLIF0Z0','207','D','10','301',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','302','(''SS''=''Q,'')','ELINCNLIF0Z0','208','D','10','302',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameFirst3"','303','(''UA''=''Q,'')','ELINCNLIF0Z0','199','D','10','303',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast3"','304','(''UA''=''Q,'')','ELINCNLIF0Z0','200','D','10','304',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameMiddle3"','305','(''UA''=''Q,'')','ELINCNLIF0Z0','201','D','10','305',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender3"','306','(''UA''=''Q,'')','ELINCNLIF0Z0','202','D','10','306',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth3"','307','(''UD101''=''T,'')','ELINCNLIF0Z0','203','D','10','307',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship3"','308','(''UA''=''Q,'')','ELINCNLIF0Z0','204','D','10','308',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode3"','309','(''UA''=''Q,'')','ELINCNLIF0Z0','205','D','10','309',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabled3"','310','(''UA''=''Q,'')','ELINCNLIF0Z0','206','D','10','310',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','311','(''SS''=''Q,'')','ELINCNLIF0Z0','207','D','10','311',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','312','(''SS''=''Q,'')','ELINCNLIF0Z0','208','D','10','312',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameFirst4"','313','(''UA''=''Q,'')','ELINCNLIF0Z0','199','D','10','313',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast4"','314','(''UA''=''Q,'')','ELINCNLIF0Z0','200','D','10','314',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameMiddle4"','315','(''UA''=''Q,'')','ELINCNLIF0Z0','201','D','10','315',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender4"','316','(''UA''=''Q,'')','ELINCNLIF0Z0','202','D','10','316',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth4"','317','(''UD101''=''T,'')','ELINCNLIF0Z0','203','D','10','317',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship4"','318','(''UA''=''Q,'')','ELINCNLIF0Z0','204','D','10','318',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode4"','319','(''UA''=''Q,'')','ELINCNLIF0Z0','205','D','10','319',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabled4"','320','(''UA''=''Q,'')','ELINCNLIF0Z0','206','D','10','320',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','321','(''SS''=''Q,'')','ELINCNLIF0Z0','207','D','10','321',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','322','(''SS''=''Q,'')','ELINCNLIF0Z0','208','D','10','322',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameFirst5"','323','(''UA''=''Q,'')','ELINCNLIF0Z0','199','D','10','323',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast5"','324','(''UA''=''Q,'')','ELINCNLIF0Z0','200','D','10','324',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameMiddle5"','325','(''UA''=''Q,'')','ELINCNLIF0Z0','201','D','10','325',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender5"','326','(''UA''=''Q,'')','ELINCNLIF0Z0','202','D','10','326',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth5"','327','(''UD101''=''T,'')','ELINCNLIF0Z0','203','D','10','327',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship5"','328','(''UA''=''Q,'')','ELINCNLIF0Z0','204','D','10','328',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode5"','329','(''UA''=''Q,'')','ELINCNLIF0Z0','205','D','10','329',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabled5"','330','(''UA''=''Q,'')','ELINCNLIF0Z0','206','D','10','330',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','331','(''SS''=''Q,'')','ELINCNLIF0Z0','207','D','10','331',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','332','(''SS''=''Q,'')','ELINCNLIF0Z0','208','D','10','332',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameFirst6"','333','(''UA''=''Q,'')','ELINCNLIF0Z0','199','D','10','333',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast6"','334','(''UA''=''Q,'')','ELINCNLIF0Z0','200','D','10','334',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameMiddle6"','335','(''UA''=''Q,'')','ELINCNLIF0Z0','201','D','10','335',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender6"','336','(''UA''=''Q,'')','ELINCNLIF0Z0','202','D','10','336',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth6"','337','(''UD101''=''T,'')','ELINCNLIF0Z0','203','D','10','337',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship6"','338','(''UA''=''Q,'')','ELINCNLIF0Z0','204','D','10','338',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode6"','339','(''UA''=''Q,'')','ELINCNLIF0Z0','205','D','10','339',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabled6"','340','(''UA''=''Q,'')','ELINCNLIF0Z0','206','D','10','340',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','341','(''SS''=''Q,'')','ELINCNLIF0Z0','207','D','10','341',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','342','(''SS''=''Q,'')','ELINCNLIF0Z0','208','D','10','342',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameFirst7"','343','(''UA''=''Q,'')','ELINCNLIF0Z0','199','D','10','343',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast7"','344','(''UA''=''Q,'')','ELINCNLIF0Z0','200','D','10','344',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameMiddle7"','345','(''UA''=''Q,'')','ELINCNLIF0Z0','201','D','10','345',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender7"','346','(''UA''=''Q,'')','ELINCNLIF0Z0','202','D','10','346',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth7"','347','(''UD101''=''T,'')','ELINCNLIF0Z0','203','D','10','347',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship7"','348','(''UA''=''Q,'')','ELINCNLIF0Z0','204','D','10','348',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode7"','349','(''UA''=''Q,'')','ELINCNLIF0Z0','205','D','10','349',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabled7"','350','(''UA''=''Q,'')','ELINCNLIF0Z0','206','D','10','350',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','351','(''SS''=''Q,'')','ELINCNLIF0Z0','207','D','10','351',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','352','(''SS''=''Q,'')','ELINCNLIF0Z0','208','D','10','352',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameFirst8"','353','(''UA''=''Q,'')','ELINCNLIF0Z0','199','D','10','353',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast8"','354','(''UA''=''Q,'')','ELINCNLIF0Z0','200','D','10','354',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameMiddle8"','355','(''UA''=''Q,'')','ELINCNLIF0Z0','201','D','10','355',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender8"','356','(''UA''=''Q,'')','ELINCNLIF0Z0','202','D','10','356',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth8"','357','(''UD101''=''T,'')','ELINCNLIF0Z0','203','D','10','357',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship8"','358','(''UA''=''Q,'')','ELINCNLIF0Z0','204','D','10','358',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode8"','359','(''UA''=''Q,'')','ELINCNLIF0Z0','205','D','10','359',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabled8"','360','(''UA''=''Q,'')','ELINCNLIF0Z0','206','D','10','360',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','361','(''SS''=''Q,'')','ELINCNLIF0Z0','207','D','10','361',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','362','(''SS''=''Q,'')','ELINCNLIF0Z0','208','D','10','362',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameFirst9"','363','(''UA''=''Q,'')','ELINCNLIF0Z0','199','D','10','363',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast9"','364','(''UA''=''Q,'')','ELINCNLIF0Z0','200','D','10','364',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameMiddle9"','365','(''UA''=''Q,'')','ELINCNLIF0Z0','201','D','10','365',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender9"','366','(''UA''=''Q,'')','ELINCNLIF0Z0','202','D','10','366',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth9"','367','(''UD101''=''T,'')','ELINCNLIF0Z0','203','D','10','367',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship9"','368','(''UA''=''Q,'')','ELINCNLIF0Z0','204','D','10','368',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode9"','369','(''UA''=''Q,'')','ELINCNLIF0Z0','205','D','10','369',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabled9"','370','(''UA''=''Q,'')','ELINCNLIF0Z0','206','D','10','370',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','371','(''SS''=''Q,'')','ELINCNLIF0Z0','207','D','10','371',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','372','(''SS''=''Q,'')','ELINCNLIF0Z0','208','D','10','372',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameFirst10"','373','(''UA''=''Q,'')','ELINCNLIF0Z0','199','D','10','373',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast10"','374','(''UA''=''Q,'')','ELINCNLIF0Z0','200','D','10','374',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameMiddle10"','375','(''UA''=''Q,'')','ELINCNLIF0Z0','201','D','10','375',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender10"','376','(''UA''=''Q,'')','ELINCNLIF0Z0','202','D','10','376',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateOfBirth10"','377','(''UD101''=''T,'')','ELINCNLIF0Z0','203','D','10','377',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship10"','378','(''UA''=''Q,'')','ELINCNLIF0Z0','204','D','10','378',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudentCode10"','379','(''UA''=''Q,'')','ELINCNLIF0Z0','205','D','10','379',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDisabled10"','380','(''UA''=''Q,'')','ELINCNLIF0Z0','206','D','10','380',NULL,'Dep Disabled Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','381','(''SS''=''Q,'')','ELINCNLIF0Z0','207','D','10','381',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','382','(''SS''=''Q'')','ELINCNLIF0Z0','208','D','10','382',NULL,'Dep DHMO PCP',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ELINCNLIF_20210724.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Lincoln Basic Life','202106299','EMPEXPORT','ONDEM_XOE',NULL,'ELINCNLIF',NULL,NULL,NULL,'202106299','Jun 29 2021  8:59PM','Jun 29 2021  8:59PM','202106011',NULL,'','','202106011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Lincoln Basic Life-Sched','202106299','EMPEXPORT','SCH_ELINCN',NULL,'ELINCNLIF',NULL,NULL,NULL,'202106299','Jun 29 2021  8:59PM','Jun 29 2021  8:59PM','202106011',NULL,'','','202106011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Lincoln Basic Life-Test','202107229','EMPEXPORT','TEST_XOE','Jul 22 2021  8:42AM','ELINCNLIF',NULL,NULL,NULL,'202107229','Jul 22 2021 12:00AM','Dec 30 1899 12:00AM','202107081','1312','','','202107081',dbo.fn_GetTimedKey(),NULL,'us3lKiPLD1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCNLIF','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCNLIF','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCNLIF','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCNLIF','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCNLIF','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ELINCNLIF' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ELINCNLIF' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ELINCNLIF_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINCNLIF','D10','dbo.U_ELINCNLIF_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ELINCNLIF') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELINCNLIF] (
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
IF OBJECT_ID('U_ELINCNLIF_Audit') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_ELINCNLIF_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ELINCNLIF_DedList') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ELINCNLIF_Dependents') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_Dependents] (
    [ConEEID] char(12) NOT NULL,
    [ConSystemID] char(12) NOT NULL,
    [ConNameFirst] varchar(100) NULL,
    [ConNameMiddle] varchar(50) NULL,
    [ConNameLast] varchar(100) NULL,
    [ConRelationship] char(3) NULL,
    [ConIsDisabled] char(1) NULL,
    [ConGender] char(1) NULL,
    [ConDateOfBirth] datetime NULL,
    [ConIsSmoker] varchar(1) NULL,
    [ConDepNo] bigint NULL
);
IF OBJECT_ID('U_ELINCNLIF_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvEmpNo] char(9) NULL,
    [drvChangeDate] datetime NULL,
    [drvDepChangeDate] datetime NULL,
    [drvEedBenStopDate] datetime NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvSSN] varchar(11) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAppSignDate] datetime NULL,
    [drvJobDesc] varchar(25) NOT NULL,
    [drvScheduledWorkHrs] decimal NULL,
    [drvAnnSalary] money NULL,
    [drvSalaryEffDate] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAdressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvRsnLossOfBen] varchar(11) NULL,
    [drvLifePolicyNum] varchar(18) NULL,
    [drvLifBillLocNum] varchar(7) NULL,
    [drvLifeEffDate] datetime NULL,
    [drvLifePlanCode] varchar(1) NULL,
    [drvLifeClassCode] varchar(1) NULL,
    [drvLICvgs] varchar(26) NULL,
    [drvLITermDate] datetime NULL,
    [drvADCvgs] varchar(4) NULL,
    [drvADTermDate] datetime NULL,
    [drvWIPolicyNum] varchar(18) NULL,
    [drvWIBillLocNum] varchar(7) NULL,
    [drvWIEffDate] datetime NULL,
    [drvWIPlanCode] varchar(1) NULL,
    [drvWIClassCode] varchar(1) NULL,
    [drvWICvgs] varchar(4) NULL,
    [drvWITermDate] datetime NULL,
    [drvLTDPolicyNum] varchar(18) NULL,
    [drvLTDBillLocNum] varchar(7) NULL,
    [drvLTDEffDate] datetime NULL,
    [drvLTDPlanCode] varchar(1) NULL,
    [drvLTDClassCode] varchar(1) NULL,
    [drvLTDCvgs] varchar(5) NULL,
    [drvLTDTermDate] datetime NULL,
    [drvVLIFPolicyNum] varchar(18) NULL,
    [drvVLIFBillLocNum] varchar(7) NULL,
    [drvVLIFEffDate] datetime NULL,
    [drvVLIFPlanCode] varchar(1) NULL,
    [drvVLIFClassCode] varchar(1) NULL,
    [drvVLICvgs] varchar(24) NULL,
    [drvVLITermDate] datetime NULL,
    [drvVADCvgs] varchar(24) NULL,
    [drvVADTermDate] datetime NULL,
    [drvVSLICvgs] varchar(25) NULL,
    [drvVLSITermDate] datetime NULL,
    [drvVSADCvgs] varchar(25) NULL,
    [drvVSADTermDate] datetime NULL,
    [drvVCLICvgs] varchar(25) NULL,
    [drvVCLITermDate] datetime NULL,
    [drvIsSmoker] varchar(1) NULL,
    [drvSpouseSmoker] varchar(1) NULL,
    [drvSpouseDOB] datetime NULL,
    [drvDepNameFirst1] varchar(100) NULL,
    [drvDepNameLast1] varchar(100) NULL,
    [drvDepNameMiddle1] varchar(1) NULL,
    [drvDepGender1] char(1) NULL,
    [drvDepDateOfBirth1] datetime NULL,
    [drvRelationship1] varchar(1) NULL,
    [drvDepStudentCode1] varchar(1) NULL,
    [drvDepDisabled1] char(1) NULL,
    [drvDepNameFirst2] varchar(100) NULL,
    [drvDepNameLast2] varchar(100) NULL,
    [drvDepNameMiddle2] varchar(2) NULL,
    [drvDepGender2] char(1) NULL,
    [drvDepDateOfBirth2] datetime NULL,
    [drvRelationship2] varchar(1) NULL,
    [drvDepStudentCode2] varchar(1) NULL,
    [drvDepDisabled2] char(1) NULL,
    [drvDepNameFirst3] varchar(100) NULL,
    [drvDepNameLast3] varchar(100) NULL,
    [drvDepNameMiddle3] varchar(3) NULL,
    [drvDepGender3] char(1) NULL,
    [drvDepDateOfBirth3] datetime NULL,
    [drvRelationship3] varchar(1) NULL,
    [drvDepStudentCode3] varchar(1) NULL,
    [drvDepDisabled3] char(1) NULL,
    [drvDepNameFirst4] varchar(100) NULL,
    [drvDepNameLast4] varchar(100) NULL,
    [drvDepNameMiddle4] varchar(4) NULL,
    [drvDepGender4] char(1) NULL,
    [drvDepDateOfBirth4] datetime NULL,
    [drvRelationship4] varchar(1) NULL,
    [drvDepStudentCode4] varchar(1) NULL,
    [drvDepDisabled4] char(1) NULL,
    [drvDepNameFirst5] varchar(100) NULL,
    [drvDepNameLast5] varchar(100) NULL,
    [drvDepNameMiddle5] varchar(5) NULL,
    [drvDepGender5] char(1) NULL,
    [drvDepDateOfBirth5] datetime NULL,
    [drvRelationship5] varchar(1) NULL,
    [drvDepStudentCode5] varchar(1) NULL,
    [drvDepDisabled5] char(1) NULL,
    [drvDepNameFirst6] varchar(100) NULL,
    [drvDepNameLast6] varchar(100) NULL,
    [drvDepNameMiddle6] varchar(6) NULL,
    [drvDepGender6] char(1) NULL,
    [drvDepDateOfBirth6] datetime NULL,
    [drvRelationship6] varchar(1) NULL,
    [drvDepStudentCode6] varchar(1) NULL,
    [drvDepDisabled6] char(1) NULL,
    [drvDepNameFirst7] varchar(100) NULL,
    [drvDepNameLast7] varchar(100) NULL,
    [drvDepNameMiddle7] varchar(7) NULL,
    [drvDepGender7] char(1) NULL,
    [drvDepDateOfBirth7] datetime NULL,
    [drvRelationship7] varchar(1) NULL,
    [drvDepStudentCode7] varchar(1) NULL,
    [drvDepDisabled7] char(1) NULL,
    [drvDepNameFirst8] varchar(100) NULL,
    [drvDepNameLast8] varchar(100) NULL,
    [drvDepNameMiddle8] varchar(8) NULL,
    [drvDepGender8] char(1) NULL,
    [drvDepDateOfBirth8] datetime NULL,
    [drvRelationship8] varchar(1) NULL,
    [drvDepStudentCode8] varchar(1) NULL,
    [drvDepDisabled8] char(1) NULL,
    [drvDepNameFirst9] varchar(100) NULL,
    [drvDepNameLast9] varchar(100) NULL,
    [drvDepNameMiddle9] varchar(9) NULL,
    [drvDepGender9] char(1) NULL,
    [drvDepDateOfBirth9] datetime NULL,
    [drvRelationship9] varchar(1) NULL,
    [drvDepStudentCode9] varchar(1) NULL,
    [drvDepDisabled9] char(1) NULL,
    [drvDepNameFirst10] varchar(100) NULL,
    [drvDepNameLast10] varchar(100) NULL,
    [drvDepNameMiddle10] varchar(10) NULL,
    [drvDepGender10] char(1) NULL,
    [drvDepDateOfBirth10] datetime NULL,
    [drvRelationship10] varchar(1) NULL,
    [drvDepStudentCode10] varchar(1) NULL,
    [drvDepDisabled10] char(1) NULL
);
IF OBJECT_ID('U_ELINCNLIF_EEList') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELINCNLIF_File') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINCNLIF]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: PL Development

Created By: Keary McCutchen
Business Analyst: Lea King
Create Date: 06/29/2021
Service Request Number: SR-2016-00012345

Purpose: Lincoln Basic Life

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELINCNLIF';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELINCNLIF';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELINCNLIF';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELINCNLIF';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELINCNLIF' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCNLIF', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCNLIF', 'TEST_XOE';                                                                                        
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCNLIF', 'SCH_ELINCN';

EXEC dbo.dsi_Bdm_sp_ErrorCheck 'ELINCNLIF';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELINCNLIF', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'ELINCNLIF';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = '20190901'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ELINCNLIF_EEList
    WHERE xCoID <> dbo.dsi_Bdm_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELINCNLIF_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --DELETE TEST/BAD EMPLOYEES
    DELETE EE
    FROM dbo.U_ELINCNLIF_EEList EE
    JOIN dbo.EmpComp WITH (NOLOCK)
      ON EecEEID = xEEID
     AND EecCOID = xCOID
        JOIN dbo.EmpPers WITH (NOLOCK)
      ON EepEEID = xEEID
    WHERE LTRIM(RTRIM(EepSSN)) = '000000000'
       OR LTRIM(RTRIM(EepSSN)) = '111111111'
       OR LTRIM(RTRIM(EepSSN)) = '888888888'
       OR LEFT(LTRIM(EepSSN),3) = '999'
       OR LEFT(LTRIM(EepSSN),3) = '998'
       OR LTRIM(RTRIM(EepSSN)) = '123456789'
       OR EepSSN IS NULL
       OR EecEEType = 'TES';
 
    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ELINCNLIF_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCNLIF_AuditFields;
    CREATE TABLE dbo.U_ELINCNLIF_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ELINCNLIF_AuditFields VALUES ('EmpComp','EecDateOfTermination');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ELINCNLIF_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCNLIF_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_ELINCNLIF_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ELINCNLIF_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ELINCNLIF_Audit ON dbo.U_ELINCNLIF_Audit (audEEID,audCOID);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GTL,GTLB,GTLCP,GTLW,LFDEP,LFSPO,LIFEE,LTD,WKSTD';

    IF OBJECT_ID('U_ELINCNLIF_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCNLIF_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELINCNLIF_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- Bdm Section
    --==========================================
    DELETE FROM dbo.U_dsi_Bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_Bdm_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_Bdm_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_Bdm_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_Bdm_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
  
    -- Run Bdm Module
    EXEC dbo.dsi_Bdm_sp_PopulateDeductionsTable @FormatCode;

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_BDM_EmpDeductions
        SET EedUSGField1 =  CONVERT(VARCHAR(20),EDF.EedBenAmt)
    FROM dbo.U_dsi_BDM_EmpDeductions BDM
    JOIN dbo.EmpDedFull EDF WITH (NOLOCK)
        ON EDF.EedEmpDedTVID = BDM.EedEmpDedTVID
       AND BDM.EedFormatCode = @FormatCode;



    --==========================================
    -- Working Tables
    --==========================================    
    IF OBJECT_ID('U_ELINCNLIF_Dependents','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCNLIF_Dependents;
    SELECT ConEEID
          ,ConSystemID
          ,ConNameFirst
          ,ConNameMiddle
          ,ConNameLast
          ,ConRelationship
          ,ConIsDisabled
          ,ConGender 
          ,ConDateOfBirth 
          ,ConIsSmoker
          ,ConDepNo = ROW_NUMBER() OVER (PARTITION BY RTRIM(ConEEID) ORDER BY conDateOfBirth ASC)
      INTO dbo.U_ELINCNLIF_Dependents
      FROM dbo.Contacts WITH (NOLOCK)
      JOIN dbo.U_ELINCNLIF_EEList WITH (NOLOCK)
        ON ConEEID = xEEID
     WHERE ConRelationship IN ('CH','CHL','DPC','STC','SPS','DP')
     AND ConIsDependent = 'Y'
     AND ConIsActive = 'Y'
     ;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELINCNLIF_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELINCNLIF_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCNLIF_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvChangeDate =  dbo.dsi_fnGetMinMaxDates('MAX',(SELECT MAX(EedBenStartDate) FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) WHERE  EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedEEID = xEEID AND EedCoID = xCoID AND EedHasEmpBen = 'Y'), @FileMinCovDate)
        ,drvDepChangeDate = dbo.dsi_fnGetMinMaxDates('MAX',(SELECT MAX(EedBenStartDate) FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) WHERE  EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedEEID = xEEID AND EedCoID = xCoID AND EedHasDepBen = 'Y'), @FileMinCovDate)
        ,drvEedBenStopDate =  dbo.dsi_fnGetMinMaxDates('MAX',EedBenStopDate , @FileMinCovDate)
        ,drvNameFirst =  EepNameFirst 
        ,drvNameLast = EepNameLast 
        ,drvNameMiddle = LEFT(EepNameMiddle,1) 
        ,drvSSN =  SUBSTRING(eepSSN, 1, 3) + '-' + SUBSTRING(eepSSN, 4, 2) + '-' + SUBSTRING(eepSSN, 6,4)  
        ,drvGender = EepGender
        ,drvDateOfBirth = EepDateOfBirth
        ,drvAppSignDate = dbo.dsi_fnGetMinMaxDates('MAX',(SELECT MAX(EedBenStartDate) FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) WHERE  EedFormatCode = @FormatCode AND EedValidForExport = 'Y'), @FileMinCovDate)
        ,drvJobDesc = JbcDesc
        ,drvScheduledWorkHrs = CASE WHEN PgrPayFrequency = 'B' THEN EecScheduledWorkHrs/2 ELSE EecScheduledWorkHrs END
        ,drvAnnSalary = EecAnnSalary
        ,drvSalaryEffDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GetDATE(), eecDateOfLastHire) 
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAdressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfLastHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire ELSE EecDateOfOriginalHire END
        ,drvRsnLossOfBen = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN 'TERMINATION' END
        ,drvLifePolicyNum = CASE WHEN EedHasLife = 'Y' THEN '000010254603-00000' END
        ,drvLifBillLocNum = CASE WHEN EedHasLife = 'Y' THEN
                                 CASE EecOrgLvl1 
                                      WHEN '01' THEN '1688505'
                                      WHEN '03' THEN '1688506'
                                      WHEN '13' THEN '1688508'
                                      WHEN '14' THEN '1688509'
                                      WHEN '19' THEN '1688511'
                                      WHEN '22' THEN '1688512'
                                      WHEN '24' THEN '1688513'
                                      WHEN '25' THEN '1688514'
                                  END
                             END
        ,drvLifeEffDate = EedLifeEffDate
        ,drvLifePlanCode = CASE WHEN  EedHasLife = 'Y' THEN '1' END
        ,drvLifeClassCode = CASE WHEN  EedHasLife = 'Y' THEN '1' END
        ,drvLICvgs = CASE WHEN  EedHasLife = 'Y' THEN 'LI-' + EedLICvgs END 
        ,drvLITermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvADCvgs = CASE WHEN  EedHasLife = 'Y' THEN 'AD-1' END
        ,drvADTermDate = CASE WHEN  EedHasLife = 'Y' THEN EedADTermDate END
        ,drvWIPolicyNum = CASE WHEN EedHasWI = 'Y' THEN '000010238521-00000' END
        ,drvWIBillLocNum = CASE WHEN EedHasWI = 'Y' THEN
                                 CASE EecOrgLvl1 
                                      WHEN '01' THEN '1688505'
                                      WHEN '03' THEN '1688506'
                                      WHEN '13' THEN '1688508'
                                      WHEN '14' THEN '1688509'
                                      WHEN '19' THEN '1688511'
                                      WHEN '22' THEN '1688512'
                                      WHEN '24' THEN '1688513'
                                      WHEN '25' THEN '1688514'
                                  END
                             END
        ,drvWIEffDate = CASE WHEN EedHasWI = 'Y' THEN EedWIEffDate END
        ,drvWIPlanCode = CASE WHEN EedHasWI = 'Y' THEN '1' END
        ,drvWIClassCode = CASE WHEN EedHasWI = 'Y' THEN '1' END
        ,drvWICvgs = CASE WHEN EedHasWI = 'Y' THEN 'WI-1' END
        ,drvWITermDate = CASE WHEN EedHasWI = 'Y' THEN EedWITermDate END
        ,drvLTDPolicyNum = CASE WHEN EedHasLTD = 'Y' THEN '000010254605-00000' END
        ,drvLTDBillLocNum = CASE WHEN EedHasLTD = 'Y' THEN
                                 CASE EecOrgLvl1 
                                      WHEN '01' THEN '1688505'
                                      WHEN '03' THEN '1688506'
                                      WHEN '13' THEN '1688508'
                                      WHEN '14' THEN '1688509'
                                      WHEN '19' THEN '1688511'
                                      WHEN '22' THEN '1688512'
                                      WHEN '24' THEN '1688513'
                                      WHEN '25' THEN '1688514'
                                  END
                             END
        ,drvLTDEffDate = CASE WHEN EedHasLTD = 'Y' THEN EedLTDEffDate END
        ,drvLTDPlanCode = CASE WHEN EedHasLTD = 'Y' THEN '1' END
        ,drvLTDClassCode = CASE WHEN EedHasLTD = 'Y' THEN '1' END
        ,drvLTDCvgs = CASE WHEN EedHasLTD = 'Y' THEN 'LTD-1' END
        ,drvLTDTermDate = CASE WHEN EedHasLTD = 'Y' THEN EedLTDTermDate END
        ,drvVLIFPolicyNum = CASE WHEN EedHasLIFEE = 'Y' THEN '000400254604-00000' END
        ,drvVLIFBillLocNum = CASE WHEN EedHasLIFEE = 'Y' THEN
                                 CASE EecOrgLvl1 
                                      WHEN '01' THEN '1688505'
                                      WHEN '03' THEN '1688506'
                                      WHEN '13' THEN '1688508'
                                      WHEN '14' THEN '1688509'
                                      WHEN '19' THEN '1688511'
                                      WHEN '22' THEN '1688512'
                                      WHEN '24' THEN '1688513'
                                      WHEN '25' THEN '1688514'
                                  END
                             END
        ,drvVLIFEffDate = EedVLIFEffDate
        ,drvVLIFPlanCode = CASE WHEN EedHasLIFEE = 'Y' THEN '1' END
        ,drvVLIFClassCode = CASE WHEN EedHasLIFEE = 'Y' THEN '1' END
        ,drvVLICvgs = CASE WHEN EedHasLIFEE = 'Y' THEN EedVLICvgs END 
        ,drvVLITermDate = CASE WHEN EedHasLIFEE = 'Y' THEN EedVLITermDate END
        ,drvVADCvgs = CASE WHEN EedHasLIFEE = 'Y' THEN EedVADCvgs END 
        ,drvVADTermDate = CASE WHEN EedHasLIFEE = 'Y' THEN EedVADTermDate END
        ,drvVSLICvgs = CASE WHEN EedDepHasLFSPO = 'Y' THEN EedVSLICvgs END 
        ,drvVLSITermDate = CASE WHEN EedDepHasLFSPO = 'Y' THEN EedVLSITermDate END
        ,drvVSADCvgs = CASE WHEN EedDepHasLFSPO = 'Y' THEN EedVSADCvgs END 
        ,drvVSADTermDate = CASE WHEN EedDepHasLFSPO = 'Y' THEN EedVSADTermDate END
        ,drvVCLICvgs = CASE WHEN EedDepHasLFDEP = 'Y' THEN EedVCLICvgs END 
        ,drvVCLITermDate = CASE WHEN EedDepHasLFDEP = 'Y' THEN EedVCLITermDate END
        ,drvIsSmoker = EepIsSmoker
        ,drvSpouseSmoker = CASE WHEN EedDepHasLFSPO = 'Y' AND Dep1.ConRelationship IN ('SPS','DP') THEN Dep1.ConIsSmoker END
        ,drvSpouseDOB = CASE WHEN EedDepHasLFSPO = 'Y' AND Dep1.ConRelationship IN ('SPS','DP') THEN Dep1.ConDateOfBirth END
        --DEP1
        ,drvDepNameFirst1 = CASE WHEN EedHasDepBen = 'Y' THEN Dep1.ConNameFirst END
        ,drvDepNameLast1 = CASE WHEN EedHasDepBen = 'Y' THEN Dep1.ConNameLast END
        ,drvDepNameMiddle1 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep1.ConNameMiddle,1) END
        ,drvDepGender1 = CASE WHEN EedHasDepBen = 'Y' THEN Dep1.ConGender END
        ,drvDepDateOfBirth1 = CASE WHEN EedHasDepBen = 'Y' THEN Dep1.ConDateOFBirth END
        ,drvRelationship1 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep1.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep1.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode1 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep1.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled1 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep1.ConSystemID,'') <> '' THEN ISNULL(Dep1.ConIsDisabled,'N') END
        --DEP2
        ,drvDepNameFirst2 = CASE WHEN EedHasDepBen = 'Y' THEN Dep2.ConNameFirst END
        ,drvDepNameLast2 = CASE WHEN EedHasDepBen = 'Y' THEN Dep2.ConNameLast END
        ,drvDepNameMiddle2 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep2.ConNameMiddle,2) END
        ,drvDepGender2 = CASE WHEN EedHasDepBen = 'Y' THEN Dep2.ConGender END
        ,drvDepDateOfBirth2 = CASE WHEN EedHasDepBen = 'Y' THEN Dep2.ConDateOFBirth END
        ,drvRelationship2 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep2.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep2.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode2 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep2.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled2 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep2.ConSystemID,'') <> '' THEN ISNULL(Dep2.ConIsDisabled,'N') END
        --DEP3
        ,drvDepNameFirst3 = CASE WHEN EedHasDepBen = 'Y' THEN Dep3.ConNameFirst END
        ,drvDepNameLast3 = CASE WHEN EedHasDepBen = 'Y' THEN Dep3.ConNameLast END
        ,drvDepNameMiddle3 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep3.ConNameMiddle,3) END
        ,drvDepGender3 = CASE WHEN EedHasDepBen = 'Y' THEN Dep3.ConGender END
        ,drvDepDateOfBirth3 = CASE WHEN EedHasDepBen = 'Y' THEN Dep3.ConDateOFBirth END
        ,drvRelationship3 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep3.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep3.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode3 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep3.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled3 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep3.ConSystemID,'') <> '' THEN ISNULL(Dep3.ConIsDisabled,'N') END
        --DEP4
        ,drvDepNameFirst4 = CASE WHEN EedHasDepBen = 'Y' THEN Dep4.ConNameFirst END
        ,drvDepNameLast4 = CASE WHEN EedHasDepBen = 'Y' THEN Dep4.ConNameLast END
        ,drvDepNameMiddle4 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep4.ConNameMiddle,4) END
        ,drvDepGender4 = CASE WHEN EedHasDepBen = 'Y' THEN Dep4.ConGender END
        ,drvDepDateOfBirth4 = CASE WHEN EedHasDepBen = 'Y' THEN Dep4.ConDateOFBirth END
        ,drvRelationship4 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep4.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep4.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode4 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep4.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled4 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep4.ConSystemID,'') <> '' THEN ISNULL(Dep4.ConIsDisabled,'N') END
        --DEP5
        ,drvDepNameFirst5 = CASE WHEN EedHasDepBen = 'Y' THEN Dep5.ConNameFirst END
        ,drvDepNameLast5 = CASE WHEN EedHasDepBen = 'Y' THEN Dep5.ConNameLast END
        ,drvDepNameMiddle5 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep5.ConNameMiddle,5) END
        ,drvDepGender5 = CASE WHEN EedHasDepBen = 'Y' THEN Dep5.ConGender END
        ,drvDepDateOfBirth5 = CASE WHEN EedHasDepBen = 'Y' THEN Dep5.ConDateOFBirth END
        ,drvRelationship5 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep5.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep5.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode5 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep5.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled5 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep5.ConSystemID,'') <> '' THEN ISNULL(Dep5.ConIsDisabled,'N') END
        --DEP6
        ,drvDepNameFirst6 = CASE WHEN EedHasDepBen = 'Y' THEN Dep6.ConNameFirst END
        ,drvDepNameLast6 = CASE WHEN EedHasDepBen = 'Y' THEN Dep6.ConNameLast END
        ,drvDepNameMiddle6 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep6.ConNameMiddle,6) END
        ,drvDepGender6 = CASE WHEN EedHasDepBen = 'Y' THEN Dep6.ConGender END
        ,drvDepDateOfBirth6 = CASE WHEN EedHasDepBen = 'Y' THEN Dep6.ConDateOFBirth END
        ,drvRelationship6 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep6.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep6.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode6 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep6.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled6 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep6.ConSystemID,'') <> '' THEN ISNULL(Dep6.ConIsDisabled,'N') END
        --DEP7
        ,drvDepNameFirst7 = CASE WHEN EedHasDepBen = 'Y' THEN Dep7.ConNameFirst END
        ,drvDepNameLast7 = CASE WHEN EedHasDepBen = 'Y' THEN Dep7.ConNameLast END
        ,drvDepNameMiddle7 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep7.ConNameMiddle,7) END
        ,drvDepGender7 = CASE WHEN EedHasDepBen = 'Y' THEN Dep7.ConGender END
        ,drvDepDateOfBirth7 = CASE WHEN EedHasDepBen = 'Y' THEN Dep7.ConDateOFBirth END
        ,drvRelationship7 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep7.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep7.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode7 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep7.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled7 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep7.ConSystemID,'') <> '' THEN ISNULL(Dep7.ConIsDisabled,'N') END
        --DEP8
        ,drvDepNameFirst8 = CASE WHEN EedHasDepBen = 'Y' THEN Dep8.ConNameFirst END
        ,drvDepNameLast8 = CASE WHEN EedHasDepBen = 'Y' THEN Dep8.ConNameLast END
        ,drvDepNameMiddle8 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep8.ConNameMiddle,8) END
        ,drvDepGender8 = CASE WHEN EedHasDepBen = 'Y' THEN Dep8.ConGender END
        ,drvDepDateOfBirth8 = CASE WHEN EedHasDepBen = 'Y' THEN Dep8.ConDateOFBirth END
        ,drvRelationship8 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep8.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep8.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode8 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep8.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled8 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep8.ConSystemID,'') <> '' THEN ISNULL(Dep8.ConIsDisabled,'N') END
        --DEP9
        ,drvDepNameFirst9 = CASE WHEN EedHasDepBen = 'Y' THEN Dep9.ConNameFirst END
        ,drvDepNameLast9 = CASE WHEN EedHasDepBen = 'Y' THEN Dep9.ConNameLast END
        ,drvDepNameMiddle9 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep9.ConNameMiddle,9) END
        ,drvDepGender9 = CASE WHEN EedHasDepBen = 'Y' THEN Dep9.ConGender END
        ,drvDepDateOfBirth9 = CASE WHEN EedHasDepBen = 'Y' THEN Dep9.ConDateOFBirth END
        ,drvRelationship9 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep9.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep9.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode9 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep9.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled9 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep9.ConSystemID,'') <> '' THEN ISNULL(Dep9.ConIsDisabled,'N') END
        --DEP10
        ,drvDepNameFirst10 = CASE WHEN EedHasDepBen = 'Y' THEN Dep10.ConNameFirst END
        ,drvDepNameLast10 = CASE WHEN EedHasDepBen = 'Y' THEN Dep10.ConNameLast END
        ,drvDepNameMiddle10 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep10.ConNameMiddle,10) END
        ,drvDepGender10 = CASE WHEN EedHasDepBen = 'Y' THEN Dep10.ConGender END
        ,drvDepDateOfBirth10 = CASE WHEN EedHasDepBen = 'Y' THEN Dep10.ConDateOFBirth END
        ,drvRelationship10 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep10.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep10.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode10 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep10.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled10 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep10.ConSystemID,'') <> '' THEN ISNULL(Dep10.ConIsDisabled,'N') END
    INTO dbo.U_ELINCNLIF_drvTbl
    FROM dbo.U_ELINCNLIF_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (EecEmplStatus= 'T' and EecTermReason <>'TRO' 
        AND EXISTS(SELECT 1 FROM dbo.U_ELINCNLIF_Audit WITH (NOLOCK) WHERE  audEEID = xEEID AND audCOID = xcoid)))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN (SELECT EedEEID, EedCOID
                ,EedBenStopDate = MAX(EedBenStopDate)
                ,EedHasEmpBen = MAX(CASE WHEN EedDedCode IN ('GTL','GTLB','GTLCP','GTLW','WKSTD','LTD','LIFEE') THEN 'Y' END)
                ,EedHasDepBen = MAX(CASE WHEN EedDedCode IN ('LFSPO','LFDEP') THEN 'Y' END)
                ,EedHasLife = MAX(CASE WHEN EedDedCode IN ('GTL','GTLB','GTLCP','GTLW') THEN 'Y' END)
                ,EedLifeEffDate = MAX(CASE  WHEN EedDedCode IN ('GTL','GTLB','GTLCP','GTLW') THEN EedBenStartDate END)
                ,EedLICvgs = MAX(CASE WHEN EedDedCode IN ('GTL','GTLB','GTLCP','GTLW') THEN 'LI-' + CASE WHEN ISNULL(EedBenAmt,0) = 0 THEN CONVERT(VARCHAR(20),DedEEBenAmt) ELSE CONVERT(VARCHAR(20),EedBenAmt) END END) 
                ,EedADTermDate = MAX(CASE WHEN EedDedCode IN ('GTL','GTLB','GTLCP','GTLW') THEN EedBenStopDate END)
                ,EedHasWI = MAX(CASE WHEN EedDedCode IN ('WKSTD') THEN 'Y'END)
                ,EedWIEffDate = MAX(CASE WHEN EedDedCode = 'WKSTD' THEN EedBenStartDate END)
                ,EedWITermDate = MAX(CASE WHEN EedDedCode = 'WKSTD' THEN EedBenStopDate END)
                ,EedHASLTD = MAX(CASE WHEN EedDedCode IN ('LTD') THEN 'Y' END)
                ,EedLTDEffDate = MAX(CASE WHEN EedDedCode = 'LTD' THEN EedBenStartDate END)
                ,EedLTDTermDate = MAX(CASE WHEN EedDedCode = 'LTD' THEN EedBenStopDate END)
                ,EedHasLIFEE = MAX(CASE WHEN EedDedCode IN ('LIFEE') THEN 'Y' END)
                ,EedVLIFEffDate = MAX(CASE WHEN EedDedCode IN ('LIFEE') THEN EedBenStartDate END)
                ,EedVLICvgs = MAX(CASE WHEN EedDedCode IN ('LIFEE') THEN 'VLI-' + CASE WHEN ISNULL(EedBenAmt,0) = 0 THEN CONVERT(VARCHAR(20),DedEEBenAmt) ELSE CONVERT(VARCHAR(20),EedBenAmt) END END)  
                ,EedVLITermDate = MAX(CASE WHEN EedDedCode IN ('LIFEE') THEN EedBenStopDate END)
                ,EedVADCvgs = MAX(CASE WHEN EedDedCode IN ('LIFEE') THEN 'VAD-' + CASE WHEN ISNULL(EedBenAmt,0) = 0 THEN CONVERT(VARCHAR(20),DedEEBenAmt) ELSE CONVERT(VARCHAR(20),EedBenAmt) END END)  
                ,EedVADTermDate = MAX(CASE WHEN EedDedCode IN ('LIFEE') THEN EedBenStopDate END)
                ,EedVSLICvgs = MAX(CASE WHEN EedDedCode IN ('LFSPO') THEN 'VSLI-' + CASE WHEN ISNULL(EedBenAmt,0) = 0 THEN CONVERT(VARCHAR(20),DedEEBenAmt) ELSE CONVERT(VARCHAR(20),EedBenAmt) END END)  
                ,EedVLSITermDate = MAX(CASE WHEN EedDedCode = 'LFSPO' THEN EedBenStopDate END)
                ,EedVSADCvgs = MAX(CASE WHEN EedDedCode IN ('LFSPO') THEN 'VSAD-' + CASE WHEN ISNULL(EedBenAmt,0) = 0 THEN CONVERT(VARCHAR(20),DedEEBenAmt) ELSE CONVERT(VARCHAR(20),EedBenAmt) END END)  
                ,EedVSADTermDate = MAX(CASE WHEN EedDedCode = 'LFSPO' THEN EedBenStopDate END)
                ,EedVCLICvgs = MAX(CASE WHEN EedDedCode IN ('LFDEP') THEN 'VCLI-' + CASE WHEN ISNULL(EedBenAmt,0) = 0 THEN CONVERT(VARCHAR(20),DedEEBenAmt) ELSE CONVERT(VARCHAR(20),EedBenAmt) END END)  
                ,EedVCLITermDate = MAX(CASE WHEN EedDedCode = 'LFDEP' THEN EedBenStopDate END)
                ,EedDepHasLFSPO = MAX(CASE WHEN EedDedCode IN ('LFSPO') THEN  'Y' END)
                ,EedDepHasLFDEP = MAX(CASE WHEN EedDedCode IN ('LFDEP') THEN  'Y' END)
            FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) 
            JOIN dbo.U_ELINCNLIF_DedList WITH (NOLOCK)
                ON DedCode = EedDedCode
           WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y'
            GROUP BY EedEEID, EedCoID ) AS Eed
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep1 WITH (NOLOCK)
        ON Dep1.ConEEID = xEEID
       AND Dep1.ConDepNo = 1
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep2 WITH (NOLOCK)
        ON Dep2.ConEEID = xEEID
       AND Dep2.ConDepNo = 2
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep3 WITH (NOLOCK)
        ON Dep3.ConEEID = xEEID
       AND Dep3.ConDepNo = 3
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep4 WITH (NOLOCK)
        ON Dep4.ConEEID = xEEID
       AND Dep4.ConDepNo = 4
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep5 WITH (NOLOCK)
        ON Dep5.ConEEID = xEEID
       AND Dep5.ConDepNo = 5
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep6 WITH (NOLOCK)
        ON Dep6.ConEEID = xEEID
       AND Dep6.ConDepNo = 6
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep7 WITH (NOLOCK)
        ON Dep7.ConEEID = xEEID
       AND Dep7.ConDepNo = 7
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep8 WITH (NOLOCK)
        ON Dep8.ConEEID = xEEID
       AND Dep8.ConDepNo = 8
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep9 WITH (NOLOCK)
        ON Dep9.ConEEID = xEEID
       AND Dep9.ConDepNo = 9
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep10 WITH (NOLOCK)
        ON Dep10.ConEEID = xEEID
       AND Dep10.ConDepNo = 10
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
ALTER VIEW dbo.dsi_vwELINCNLIF_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELINCNLIF_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELINCNLIF%'
ORDER BY AdfSetNumber, AdfFieldNumber;

UPDATE dbo.AscDefF
SET ADFFORCOND = '(''UD101''=''T,'')'
WHERE AdfHeaderSystemID LIKE 'ELINCNLIF%' and adfsetnumber = 10 and adffieldnumber = 282

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106011'
       ,expStartPerControl     = '202106011'
       ,expLastEndPerControl   = '202106299'
       ,expEndPerControl       = '202106299'
WHERE expFormatCode = 'ELINCNLIF';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELINCNLIF_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELINCNLIF_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort