SET NOCOUNT ON;
IF OBJECT_ID('U_EYWFML2EXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EYWFML2EXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EYWFML2EXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EYWFML2EXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEYWFML2EXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEYWFML2EXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EYWFML2EXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EYWFML2EXP];
GO
IF OBJECT_ID('U_EYWFML2EXP_PEarHistConsolidated') IS NOT NULL DROP TABLE [dbo].[U_EYWFML2EXP_PEarHistConsolidated];
GO
IF OBJECT_ID('U_EYWFML2EXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EYWFML2EXP_PEarHist];
GO
IF OBJECT_ID('U_EYWFML2EXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EYWFML2EXP_PDedHist];
GO
IF OBJECT_ID('U_EYWFML2EXP_File') IS NOT NULL DROP TABLE [dbo].[U_EYWFML2EXP_File];
GO
IF OBJECT_ID('U_EYWFML2EXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EYWFML2EXP_EEList];
GO
IF OBJECT_ID('U_EYWFML2EXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EYWFML2EXP_drvTbl];
GO
IF OBJECT_ID('U_EYWFML2EXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EYWFML2EXP_DedList];
GO
IF OBJECT_ID('U_EYWFML2EXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EYWFML2EXP_AuditFields];
GO
IF OBJECT_ID('U_EYWFML2EXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EYWFML2EXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EYWFML2EXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EYWFML2EXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EYWFML2EXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EYWFML2EXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EYWFML2EXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EYWFML2EXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EYWFML2EXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EYWFML2EXP','York/CareWorks FMLA Export V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','6000','S','N','EYWFML2EXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','1','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','2','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','2',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','3','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','4','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','4',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Initial"','5','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','5',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Suffix"','6','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','6',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Street Address 1"','7','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','7',NULL,'Street Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Street Address 2"','8','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','8',NULL,'Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code"','9','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','9',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','10','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State/Province"','11','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','11',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"County"','12','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','12',NULL,'County',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','13','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','13',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip4"','14','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','14',NULL,'Zip4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Company ID"','15','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','15',NULL,'Company ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Company Name"','16','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','16',NULL,'Company Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department"','17','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','17',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Area"','18','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','18',NULL,'Area',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation"','19','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','19',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Location ID"','20','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','20',NULL,'EE Location ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Name"','21','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','21',NULL,'Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Shift"','22','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','22',NULL,'Work Shift',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date Hired"','23','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','23',NULL,'Date Hired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Position Start Date"','24','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','24',NULL,'Position Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor"','25','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','25',NULL,'Supervisor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Phone"','26','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','26',NULL,'Supervisor Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Ext"','27','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','27',NULL,'Supervisor Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Management"','28','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','28',NULL,'Is Management',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Status"','29','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','29',NULL,'Work Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Affilliate"','30','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','30',NULL,'Union Affilliate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Work Phone"','31','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','31',NULL,'Employee Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Work Phone Ext"','32','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','32',NULL,'Employee Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Personal Phone"','33','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','33',NULL,'Employee Personal Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','34','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','34',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','35','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','35',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sex"','36','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','36',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Number of Dependents"','37','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','37',NULL,'Number of Dependents',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Citizenship"','38','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','38',NULL,'Citizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Permit Filed"','39','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','39',NULL,'Work Permit Filed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Language"','40','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','40',NULL,'Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Blank Field"','41','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','41',NULL,'Blank Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Blank Field"','42','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','42',NULL,'Blank Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Work State"','43','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','43',NULL,'Employee Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Blank Field"','44','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','44',NULL,'Blank Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','45','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','45',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Status Date"','46','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','46',NULL,'Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NCCI"','47','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','47',NULL,'NCCI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SOC"','48','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','48',NULL,'SOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Standard Hours Worked"','49','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','49',NULL,'Standard Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Standard Hours Worked Frequency"','50','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','50',NULL,'Standard Hours Worked Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked Date"','51','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','51',NULL,'Hours Worked Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Percent Full Time"','52','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','52',NULL,'Percent Full Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Participates in Group Health"','53','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','53',NULL,'Participates in Group Health',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Name with Same Employer"','54','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','54',NULL,'Spouse Name with Same Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse SSN"','55','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','55',NULL,'Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Employee ID"','56','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','56',NULL,'Spouse Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Key Employee"','57','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','57',NULL,'Key Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Effective Date of File"','58','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','58',NULL,'Effective Date of File',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Schedule Name"','59','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','59',NULL,'Work Schedule Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Wage"','60','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','60',NULL,'Wage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Wage Frequency"','61','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','61',NULL,'Wage Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Average Weekly Wage"','62','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','62',NULL,'Average Weekly Wage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Wage Effective Date"','63','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','63',NULL,'Wage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Class"','64','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','64',NULL,'Payroll Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Blank Field"','65','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','65',NULL,'Blank Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sick Time Accrued Off"','66','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','66',NULL,'Sick Time Accrued Off',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Personal Time off Accrued"','67','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','67',NULL,'Personal Time off Accrued',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vacation Time off Accrued"','68','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','68',NULL,'Vacation Time off Accrued',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Other Time Off Accrued"','69','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','69',NULL,'Other Time Off Accrued',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total Time Off Accrued"','70','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','70',NULL,'Total Time Off Accrued',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Time Off Accrued Date"','71','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','71',NULL,'Time Off Accrued Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor 1 E-mail"','72','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','72',NULL,'Supervisor 1 E-mail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor SSN"','73','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','73',NULL,'Supervisor SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor 1 ID"','74','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','74',NULL,'Supervisor 1 ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs Wrkd last 12 Months"','75','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','75',NULL,'Hrs Wrkd last 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs Wrkd last 12 Months Date"','76','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','76',NULL,'Hrs Wrkd last 12 Months Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs Paid in the Last 12 Months"','77','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','77',NULL,'Hrs Paid in the Last 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs Pd in the Last 12 Months Date"','78','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','78',NULL,'Hrs Pd in the Last 12 Months Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Cell Phone"','79','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','79',NULL,'Employee Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee E-mail"','80','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','80',NULL,'Employee E-mail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor 2"','81','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','81',NULL,'Supervisor 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor 2 Phone"','82','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','82',NULL,'Supervisor 2 Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor 2 Ext"','83','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','83',NULL,'Supervisor 2 Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor 2 E-mail"','84','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','84',NULL,'Supervisor 2 E-mail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor 2 SSN"','85','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','85',NULL,'Supervisor 2 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor 2 ID"','86','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','86',NULL,'Supervisor 2 ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire"','87','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','87',NULL,'Rehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Start Day"','88','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','88',NULL,'Pay Period Start Day',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Voluntary STD Indicator"','89','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','89',NULL,'Voluntary STD Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"International Address Line 1"','90','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','90',NULL,'International Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"International Address Line 2"','91','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','91',NULL,'International Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"International Address Line 3"','92','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','92',NULL,'International Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"International Address Line 4"','93','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','93',NULL,'International Address Line 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"International Address Line 5"','94','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','94',NULL,'International Address Line 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"International City"','95','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','95',NULL,'International City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"International Locale"','96','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','96',NULL,'International Locale',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"International Postal Code"','97','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','97',NULL,'International Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Code"','98','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','98',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Bank"','99','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','99',NULL,'STD Bank',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Date"','100','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','100',NULL,'Employment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Payment Cease Indicator"','101','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','101',NULL,'STD Payment Cease Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Payment Cease Date"','102','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','102',NULL,'STD Payment Cease Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Meets 50 in 75 Miles"','103','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','103',NULL,'Meets 50 in 75 Miles',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Service Date"','104','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','104',NULL,'Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Indicator"','105','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','105',NULL,'LTD Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reinstatement Date"','106','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','106',NULL,'Reinstatement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Rehire Date"','107','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','107',NULL,'Last Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Military Status"','108','(''DA''=''T,'')','EYWFML2EXPZ0','50','H','01','108',NULL,'Military Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Pay Code"','109','(''DA''=''T'')','EYWFML2EXPZ0','50','H','01','109',NULL,'Employee Pay Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','2','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','2',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','3','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','4','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','4',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','5','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','5',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','6','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','6',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','7','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','7',NULL,'Street Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','8','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','8',NULL,'Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCodeEmp"','9','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','9',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','10','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','11','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','11',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCounty"','12','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','12',NULL,'County',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','13','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','13',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','14','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','14',NULL,'Zip4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','15',NULL,'Company ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Ogletree Deakins"','16','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','16',NULL,'Company Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartment"','17','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','17',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvArea"','18','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','18',NULL,'Area',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','19','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','19',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationCode"','20','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','20',NULL,'EE Location ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationName"','21','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','21',NULL,'Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','22',NULL,'Work Shift',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','23','(''UD101''=''T,'')','EYWFML2EXPZ0','50','D','10','23',NULL,'Date Hired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','24',NULL,'Position Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuperVisorName"','25','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','25',NULL,'Supervisor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuperVisorPhoneNum"','26','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','26',NULL,'Supervisor Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','27',NULL,'Supervisor Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','28',NULL,'Is Management',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStatus"','29','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','29',NULL,'Work Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','30',NULL,'Union Affilliate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeWorkPhone"','31','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','31',NULL,'Employee Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeWorkPhoneExt"','32','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','32',NULL,'Employee Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonalPhone"','33','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','33',NULL,'Employee Personal Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMarialStatus"','34','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','34',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','35','(''UD101''=''T,'')','EYWFML2EXPZ0','50','D','10','35',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','36','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','36',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','37',NULL,'Number of Dependents',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','38',NULL,'Citizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','39',NULL,'Work Permit Filed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguageCode"','40','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','40',NULL,'Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','41',NULL,'Blank Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','42',NULL,'Blank Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeWorkState"','43','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','43',NULL,'Employee Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','44',NULL,'Blank Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','45','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','45',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusDate"','46','(''UD101''=''T,'')','EYWFML2EXPZ0','50','D','10','46',NULL,'Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','47',NULL,'NCCI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','48',NULL,'SOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStandardHours"','49','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','49',NULL,'Standard Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequencey"','50','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','50',NULL,'Standard Hours Worked Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedDate"','51','(''UD101''=''T,'')','EYWFML2EXPZ0','50','D','10','51',NULL,'Hours Worked Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','52',NULL,'Percent Full Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','53',NULL,'Participates in Group Health',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','54',NULL,'Spouse Name with Same Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','55',NULL,'Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','56',NULL,'Spouse Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','57',NULL,'Key Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDateOfFile"','58','(''UD101''=''T,'')','EYWFML2EXPZ0','50','D','10','58',NULL,'Effective Date of File',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','59',NULL,'Work Schedule Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','60',NULL,'Wage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','61',NULL,'Wage Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','62',NULL,'Average Weekly Wage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','63',NULL,'Wage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollClass"','64','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','64',NULL,'Payroll Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','65',NULL,'Blank Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','66',NULL,'Sick Time Accrued Off',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','67',NULL,'Personal Time off Accrued',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','68',NULL,'Vacation Time off Accrued',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','69',NULL,'Other Time Off Accrued',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','70',NULL,'Total Time Off Accrued',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTimeOffAccruedDate"','71','(''UD101''=''T,'')','EYWFML2EXPZ0','50','D','10','71',NULL,'Time Off Accrued Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuperVisorEmail1"','72','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','72',NULL,'Supervisor 1 E-mail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','73',NULL,'Supervisor SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','74',NULL,'Supervisor 1 ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkHoursLast12Months"','75','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','75',NULL,'Hrs Wrkd last 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkHoursLast12MonthsDate"','76','(''UD101''=''T,'')','EYWFML2EXPZ0','50','D','10','76',NULL,'Hrs Wrkd last 12 Months Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','77',NULL,'Hrs Paid in the Last 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','78',NULL,'Hrs Pd in the Last 12 Months Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','79',NULL,'Employee Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEmail"','80','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','80',NULL,'Employee E-mail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisor2Name"','81','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','81',NULL,'Supervisor 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','82',NULL,'Supervisor 2 Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','83',NULL,'Supervisor 2 Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisor2Email"','84','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','84',NULL,'Supervisor 2 E-mail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','85',NULL,'Supervisor 2 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','86',NULL,'Supervisor 2 ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','87','(''UD101''=''T,'')','EYWFML2EXPZ0','50','D','10','87',NULL,'Rehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','88',NULL,'Pay Period Start Day',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','89',NULL,'Voluntary STD Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','90',NULL,'International Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','91',NULL,'International Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','92',NULL,'International Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','93',NULL,'International Address Line 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','94',NULL,'International Address Line 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','95',NULL,'International City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','96',NULL,'International Locale',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','97',NULL,'International Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','98','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','98',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','99','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','99',NULL,'STD Bank',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','100',NULL,'Employment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','101',NULL,'STD Payment Cease Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','102',NULL,'STD Payment Cease Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMeets50to75Miles"','103','(''UA''=''T,'')','EYWFML2EXPZ0','50','D','10','103',NULL,'Meets 50 in 75 Miles',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','104',NULL,'Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','105',NULL,'LTD Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','106','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','106',NULL,'Reinstatement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastRehireDate"','107','(''UD101''=''T,'')','EYWFML2EXPZ0','50','D','10','107',NULL,'Last Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''DA''=''T,'')','EYWFML2EXPZ0','50','D','10','108',NULL,'Military Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''DA''=''T'')','EYWFML2EXPZ0','50','D','10','109',NULL,'Employee Pay Code',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EYWFML2EXP_20200805.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'York/CareWorks FMLA Export','201910249','EMPEXPORT','ONDEMAND',NULL,'EYWFML2EXP',NULL,NULL,NULL,'201910249','Oct 24 2019  4:22PM','Oct 24 2019  4:22PM','201910241',NULL,'','','201910241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EYWFML2EXP_20200805.txt',NULL,NULL,NULL,'JAGQI,J8Y6W,J8YIS',NULL,NULL,NULL,'York FMLA Weekly Export','202001029','EMPEXPORT','SCHEDULED','Jan  8 2020 12:00AM','EYWFML2EXP',NULL,NULL,NULL,'202006049','Jan  2 2020 12:00AM','Dec 30 1899 12:00AM','202005281',NULL,'','','201912261',dbo.fn_GetTimedKey(),NULL,'LKING01',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EYWFML2EXP_20200805.txt',NULL,NULL,NULL,'JAGQI,J8Y6W,J8YIS',NULL,NULL,NULL,'York FMLA Weekly Export','202002169','EMPEXPORT','OGL_SCHED','Jan 28 2020 12:00AM','EYWFML2EXP',NULL,NULL,NULL,'202002169','Jan 23 2020 12:00AM','Dec 30 1899 12:00AM','202002031',NULL,'','','202002031',dbo.fn_GetTimedKey(),NULL,'MLAGROSA',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EYWFML2EXP_20200805.txt',NULL,NULL,NULL,'JAGQI,J8Y6W,J8YIS',NULL,NULL,NULL,'Test Purposes Only','202008039','EMPEXPORT','TEST','Aug  3 2020  2:54PM','EYWFML2EXP',NULL,NULL,NULL,'202008039','Aug  3 2020 12:00AM','Dec 30 1899 12:00AM','202007151','1995','','','202007151',dbo.fn_GetTimedKey(),NULL,'LKING01',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EYWFML2EXP_20200805.txt' END WHERE expFormatCode = 'EYWFML2EXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYWFML2EXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYWFML2EXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYWFML2EXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYWFML2EXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYWFML2EXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EYWFML2EXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EYWFML2EXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EYWFML2EXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EYWFML2EXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EYWFML2EXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EYWFML2EXP','D10','dbo.U_EYWFML2EXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EYWFML2EXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EYWFML2EXP] (
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
IF OBJECT_ID('U_EYWFML2EXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EYWFML2EXP_Audit] (
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
IF OBJECT_ID('U_EYWFML2EXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EYWFML2EXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EYWFML2EXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EYWFML2EXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EYWFML2EXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EYWFML2EXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvZipCode] varchar(1) NOT NULL,
    [drvCity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvCounty] varchar(255) NULL,
    [drvCountry] char(3) NULL,
    [drvZipCodeEmp] varchar(5) NULL,
    [drvDepartment] varchar(8000) NULL,
    [drvArea] varchar(8000) NULL,
    [drvJobTitle] varchar(6000) NULL,
    [drvLocationCode] char(6) NULL,
    [drvLocationName] varchar(8000) NULL,
    [drvDateOfHire] datetime NULL,
    [drvSuperVisorNameBefore] varchar(8000) NULL,
    [drvSuperVisorName] varchar(8000) NULL,
    [drvSuperVisorPhoneNumBefore] varchar(256) NULL,
    [drvSuperVisorPhoneNum] varchar(256) NULL,
    [drvWorkStatus] varchar(9) NOT NULL,
    [drvEmployeeWorkPhone] varchar(50) NULL,
    [drvEmployeeWorkPhoneExt] varchar(10) NULL,
    [drvPersonalPhone] varchar(50) NOT NULL,
    [drvMarialStatus] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvLanguageCode] char(2) NOT NULL,
    [drvEmployeeWorkState] varchar(255) NULL,
    [drvEmploymentStatus] varchar(8) NOT NULL,
    [drvStatusDate] datetime NULL,
    [drvStandardHours] varchar(10) NULL,
    [drvPayFrequencey] char(1) NULL,
    [drvHoursWorkedDate] datetime NULL,
    [drvEffectiveDateOfFile] datetime NOT NULL,
    [drvPayrollClass] varchar(6) NOT NULL,
    [drvTimeOffAccruedDate] varchar(1) NOT NULL,
    [drvSuperVisorEmail1Before] varchar(256) NULL,
    [drvSuperVisorEmail1] varchar(256) NULL,
    [drvWorkHoursLast12Months] varchar(9) NULL,
    [drvWorkHoursLast12MonthsDate] datetime NOT NULL,
    [drvEmployeeEmail] varchar(50) NULL,
    [drvSupervisor2NameBefore] varchar(8000) NULL,
    [drvSupervisor2Name] varchar(8000) NULL,
    [drvSupervisor2EmailBefore] varchar(50) NULL,
    [drvSupervisor2Email] varchar(50) NULL,
    [drvLastName] varchar(25) NULL,
    [drvRehireDate] varchar(1) NOT NULL,
    [drvMeets50to75Miles] varchar(1) NOT NULL,
    [drvLastRehireDate] datetime NULL
);
IF OBJECT_ID('U_EYWFML2EXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EYWFML2EXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EYWFML2EXP_File') IS NULL
CREATE TABLE [dbo].[U_EYWFML2EXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EYWFML2EXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EYWFML2EXP_PDedHist] (
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
IF OBJECT_ID('U_EYWFML2EXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EYWFML2EXP_PEarHist] (
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
IF OBJECT_ID('U_EYWFML2EXP_PEarHistConsolidated') IS NULL
CREATE TABLE [dbo].[U_EYWFML2EXP_PEarHistConsolidated] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [NumberOfMonths] int NULL,
    [PehCurHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EYWFML2EXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Ogletree, Deakins, Nash, Smoak & Stewart

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 10/24/2019
Service Request Number: TekP-2019-09-13-0019

Purpose: York/CareWorks FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EYWFML2EXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EYWFML2EXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EYWFML2EXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EYWFML2EXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EYWFML2EXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EYWFML2EXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EYWFML2EXP', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EYWFML2EXP', @AllObjects = 'Y', @IsWeb = 'Y'


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
    SELECT @FormatCode = 'EYWFML2EXP';

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

        --==========================================

    -- Create audit tables

    --==========================================

    IF OBJECT_ID('U_EYWFML2EXP_AuditFields','U') IS NOT NULL

        DROP TABLE dbo.U_EYWFML2EXP_AuditFields;

    CREATE TABLE dbo.U_EYWFML2EXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));

    

    -- Insert tables/fields to be audited

    INSERT INTO dbo.U_EYWFML2EXP_AuditFields VALUES ('empcomp','eecemplstatus');    

    -- Create audit table

    IF OBJECT_ID('U_EYWFML2EXP_Audit','U') IS NOT NULL

        DROP TABLE dbo.U_EYWFML2EXP_Audit;

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

    INTO dbo.U_EYWFML2EXP_Audit

    FROM (SELECT *

          FROM dbo.AuditRecords WITH (NOLOCK)

          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EYWFML2EXP_AuditFields WITH (NOLOCK))) ADR

    JOIN (SELECT *

          FROM dbo.AuditFields WITH (NOLOCK)

          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EYWFML2EXP_AuditFields WITH (NOLOCK))) ADF

        ON adrSystemID = adfSystemID

       AND adrKey = adfKey

    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed

      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate + 30;

    

    -- Create Index

    CREATE CLUSTERED INDEX CDX_U_EYWFML2EXP_Audit ON dbo.U_EYWFML2EXP_Audit (audKey1Value, audKey2Value);



    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EYWFML2EXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EYWFML2EXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --Clean EE List Include only Employee whose type is REG
    DELETE FROM dbo.U_EYWFML2EXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID NOT IN (    SELECT eeceeid FROM dbo.EmpComp (NOLOCK) where eeceetype = 'REG');

    --==========================================
    -- Build Working Tables
    --==========================================
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EYWFML2EXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EYWFML2EXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate    
        --,NumberOfMonths         = CASE WHEN PehEarnCode NOT IN ('BRV','HOL','JUR','MEALP','MILPT','OFC','PFL','PFLS6','PFLS7','PFLS8','PFLS9','PRKNT','PT','STD','STD70','STD80','STD90','STDA','UNPD','VAC') and PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @StartPerControl THEN PrgPayDate END
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(CASE WHEN PehEarnCode NOT IN ('BRV','HOL','JUR','MEALP','MILPT','OFC','PFL','PFLS6','PFLS7','PFLS8','PFLS9','PRKNT','PT','STD','STD70','STD80','STD90','STDA','UNPD','VAC') and PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @StartPerControl THEN PehCurHrs ELSE 0  END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
        --,PehPayFrequency  = PgrPayFrequency
    INTO dbo.U_EYWFML2EXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN PayGroup 
       ON PgrPayGroup = PrgPayGroup
    WHERE PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @StartPerControl
    GROUP BY PehEEID,PrgPayDate--,PgrPayFrequency
    HAVING SUM(PehCurAmt) <> 0.00;


    IF OBJECT_ID('U_EYWFML2EXP_PEarHistConsolidated','U') IS NOT NULL
        DROP TABLE dbo.U_EYWFML2EXP_PEarHistConsolidated;
    SELECT DISTINCT
         PehEEID
        ,Max(PrgPayDate) as    PrgPayDate      
        ,Count(PrgPayDate) as     NumberOfMonths          
        ,Sum(PehCurHrsYTD) as PehCurHrsYTD
 
        --,Max(PehPayFrequency) as PehPayFrequency
        INTO dbo.U_EYWFML2EXP_PEarHistConsolidated
        from dbo.U_EYWFML2EXP_PEarHist
        group by PehEEID
        order by PrgPayDate
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EYWFML2EXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EYWFML2EXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EYWFML2EXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmpNo = EecEmpNo
        ,drvNameLast = EepNameLast
        ,drvNameFirst = CASE WHEN ISNULL(EepNamePreferred,'') = '' THEN EepNameFirst ELSE EepNamePreferred END
        ,drvMiddleInitial = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvNameSuffix = NULLIF(EepNameSuffix,'')
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvZipCode = ''
        ,drvCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvState = EepAddressState
        ,drvCounty = EepAddressCounty
        ,drvCountry = EepAddressCountry
        ,drvZipCodeEmp =   substring(eepAddressZipCode,1,5)
        ,drvDepartment = dbo.fn_AddDoubleQuotes((Select Top 1 OrgDesc from Orglevel where OrgLvl = 3 and OrgCode = eecOrglvl3))
        ,drvArea = dbo.fn_AddDoubleQuotes((Select Top 1 OrgDesc from Orglevel where OrgLvl = 4 and OrgCode = eecOrglvl4))
        ,drvJobTitle = dbo.dsi_fnRemoveChars('.,/-',EecJobtitle)
        ,drvLocationCode = EecLocation
        ,drvLocationName = dbo.fn_AddDoubleQuotes((Select Top 1 LocDesc from Location where LocCode in (EEcLocation)))
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvSuperVisorNameBefore = dbo.fn_AddDoubleQuotes(dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast, First'))   
        ,drvSuperVisorName = dbo.fn_AddDoubleQuotes(
                                        CASE WHEN 
                                        
                                        dbo.dsi_fnlib_GetSupervisorField('', eeceeid, 'NameLast, First') <> '' then dbo.dsi_fnlib_GetSupervisorField('', eeceeid, 'NameLast, First')
                                        ELSE 
        
                                        (Select LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst)) from dbo.Emppers JOIN dbo.EmpComp ON eeceeid = eepeeid where  eecemplstatus <> 'T' and eepeeid   in (select top 1 OrgManagerId from OrgLevel where orgcode = eecorglvl1 and orgLvl = 1) )
                                        
                                         END )    

        ,drvSuperVisorPhoneNumBefore = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'BusinessPhoneNumber')   
        ,drvSuperVisorPhoneNum = CASE WHEN  RTRIM(dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'BusinessPhoneNumber'))  <> '' THEN  dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'BusinessPhoneNumber')  ELSE 
                                                        (Select Top 1 LTRIM(RTRIM(EepPhoneHomeNumber)) from dbo.Emppers JOIN dbo.EmpComp ON eeceeid = eepeeid where eecemplstatus <> 'T' and eepeeid   in (select top 1 OrgManagerId from OrgLevel where orgcode = eecorglvl1 and orgLvl = 1)) 



          END
        ,drvWorkStatus = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'Full Time'
                                ELSE 'Part Time'
                         END
        ,drvEmployeeWorkPhone = CASE WHEN ISNULL(EecPhoneBusinessNumber,'') <> '' THEN EecPhoneBusinessNumber
                                     WHEN ISNULL(EepPhoneHomeNumber,'') <> '' THEN  EepPhoneHomeNumber
                                     WHEN (Select top 1 efoPhoneNumber from EmpMPhon where efoeeid = xeeid and  efoPhoneType = 'CEL') <> NULL THEN '999-999-9999'
                                END
        ,drvEmployeeWorkPhoneExt = EecPhoneBusinessExt
        ,drvPersonalPhone = ISNULL(EepPhoneHomeNumber,'999-999-9999')
        ,drvMarialStatus = eepMaritalStatus
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvLanguageCode = EecLanguageCode
        ,drvEmployeeWorkState = (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation))
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus = 'T' THEN 'Inactive' ELSE 'Active' END
        ,drvStatusDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvStandardHours = CAST(CONVERT(Decimal(8,2),EecScheduledWorkHrs) as Varchar(10))
        ,drvPayFrequencey = eecpayperiod
        ,drvHoursWorkedDate = EecLastRegPayDate
        ,drvEffectiveDateOfFile = GETDATE()
        ,drvPayrollClass = CASE WHEN EecSalaryOrHourly = 'H' THEN 'Hourly' ELSE 'Salary' END
        ,drvTimeOffAccruedDate = ''
        ,drvSuperVisorEmail1Before =  dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'AddressEMail') 
        ,drvSuperVisorEmail1 = CASE WHEN dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'AddressEMail') <> '' THEN dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'AddressEMail')  
                            ELSE    
                            (Select Top 1 LTRIM(RTRIM(eepAddressEMail)) from dbo.Emppers JOIN dbo.EmpComp ON eeceeid = eepeeid where eecemplstatus <> 'T' and eepeeid   in (select top 1 OrgManagerId from OrgLevel where orgcode = eecorglvl1 and orgLvl = 1)) END

        ,drvWorkHoursLast12Months = CASE WHEN PehCurHrsYTD > 0 THEN  CAST(CONVERT(DECIMAL(7,2),PehCurHrsYTD) as VARCHAR(9))
                                        ELSE         
                                    --CASE WHEN  PehPayFrequency = 'M' or EecFullTimeOrPartTime = 'P' THEN
                                         CAST(CONVERT(DECIMAL(7,2),(EecScheduledWorkHrs *     (NumberOfMonths + 1))) as VARCHAR(9)) 
                                    --END
                                    END
        ,drvWorkHoursLast12MonthsDate = GETDATE()
        ,drvEmployeeEmail = EepAddressEMail
        ,drvSupervisor2NameBefore =  dbo.fn_AddDoubleQuotes((Select top 1 LTRIM(EepNameLast) + ' ' + LTRIM(EepNameFirst) from emppers where eepeeid IN (select top 1 OrgManagerId from OrgLevel where orgcode = eecorglvl2 and orgLvl = 2)) )
        ,drvSupervisor2Name =  dbo.fn_AddDoubleQuotes((Select Top 1 LocContact from dbo.Location where LocCode = eeclocation ))

        ,drvSupervisor2EmailBefore = (Select top 1 eepaddressemail from emppers where eepeeid IN (select top 1 OrgManagerId from OrgLevel where orgcode = eecorglvl2 and orgLvl = 2)) 
        ,drvSupervisor2Email = (Select eepAddressEmail from emppers where eepNamefirst =   (Select top 1 RTRIM(LEFT(LocContact, CharIndex(' ',LocContact))) from dbo.Location WHERE LocCode = eeclocation) and eepNameLast like '%' + (select top 1 LTRIM(RIGHT(LocContact, CharIndex(' ',REVERSE(LocContact))))  from dbo.Location WHERE LocCode = eeclocation) ) 
        ,drvLastName =  (select top 1 LTRIM(RIGHT(LocContact, CharIndex(' ',REVERSE(LocContact))))  from dbo.Location WHERE LocCode = eeclocation)  + '%'

        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire  <> EecDateOfLastHire  THEN 'Y' ELSE 'N' END
        ,drvMeets50to75Miles = CASE  (Select Top 1 LocReportingCategory from Location where LocCode in (EEcLocation))
                                WHEN 'FMLA1' THEN 'Y'
                                WHEN 'FMLA2' THEN 'N'
                                ELSE ''
                               END
        ,drvLastRehireDate = CASE WHEN EecDateOfOriginalHire  <> EecDateOfLastHire  THEN EecDateOfLastHire  ELSE NULL END
    INTO dbo.U_EYWFML2EXP_drvTbl
    FROM dbo.U_EYWFML2EXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_EYWFML2EXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_EYWFML2EXP_PEarHistConsolidated WITH (NOLOCK)
        on PehEEID = xEEID
    ;


    Update dbo.U_EYWFML2EXP_drvTbl set drvNameSuffix = '' where drvNameSuffix = 'Z'

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
ALTER VIEW dbo.dsi_vwEYWFML2EXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EYWFML2EXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EYWFML2EXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201910171'
       ,expStartPerControl     = '201910171'
       ,expLastEndPerControl   = '201910249'
       ,expEndPerControl       = '201910249'
WHERE expFormatCode = 'EYWFML2EXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEYWFML2EXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EYWFML2EXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort