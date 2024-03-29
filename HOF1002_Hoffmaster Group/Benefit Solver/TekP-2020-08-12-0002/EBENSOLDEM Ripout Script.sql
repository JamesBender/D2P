SET NOCOUNT ON;
IF OBJECT_ID('U_EBENSOLDEM_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBENSOLDEM_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EBENSOLDEM_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EBENSOLDEM' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEBENSOLDEM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBENSOLDEM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBENSOLDEM_G10_BKP_2020_PROD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENSOLDEM_G10_BKP_2020_PROD];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBENSOLDEM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENSOLDEM];
GO
IF OBJECT_ID('U_EBENSOLDEM_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBENSOLDEM_PEarHist];
GO
IF OBJECT_ID('U_EBENSOLDEM_File') IS NOT NULL DROP TABLE [dbo].[U_EBENSOLDEM_File];
GO
IF OBJECT_ID('U_EBENSOLDEM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBENSOLDEM_EEList];
GO
IF OBJECT_ID('U_EBENSOLDEM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBENSOLDEM_drvTbl];
GO
IF OBJECT_ID('U_EBENSOLDEM_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBENSOLDEM_AuditFields];
GO
IF OBJECT_ID('U_EBENSOLDEM_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBENSOLDEM_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EBENSOLDEM';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EBENSOLDEM';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EBENSOLDEM';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EBENSOLDEM';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EBENSOLDEM';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBENSOLDEM','BenfitSolver Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EBENSOLDEMZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EBENSOLDEM' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Name (Last Suffix First MI)"','1','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','1',NULL,'Employee Name (Last Suffix, First MI)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','2','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','3','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Suffix"','4','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','4',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Status"','5','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','5',NULL,'Benefit Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','6','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','6',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Deduction/Benefit Group"','7','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','7',NULL,'Deduction/Benefit Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','8','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','8',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Title"','9','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','9',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Group"','10','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','10',NULL,'Pay Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Frequency"','11','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','11',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location"','12','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','12',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 1 Code"','13','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','13',NULL,'Org Level 1 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 1"','14','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','14',NULL,'Org Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 2 Code"','15','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','15',NULL,'Org Level 2 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 2"','16','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','16',NULL,'Org Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 3 Code"','17','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','17',NULL,'Org Level 3 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 3"','18','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','18',NULL,'Org Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 4 Code"','19','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','19',NULL,'Org Level 4 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 4"','20','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','20',NULL,'Org Level 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Retirement Date"','21','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','21',NULL,'Retirement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Annual Salary"','22','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','22',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary or Hourly"','23','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','23',NULL,'Salary or Hourly',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Full/Part Time"','24','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','24',NULL,'Full/Part Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date Of Birth"','25','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','25',NULL,'Date Of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN (Unformatted)"','26','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','26',NULL,'SSN (Unformatted)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','27','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','27',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Ethnicity"','28','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','28',NULL,'Ethnicity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','29','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','29',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','30','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','30',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','31','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','31',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State/Province"','32','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','32',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code"','33','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','33',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','34','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','34',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Alternate Email Address"','35','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','35',NULL,'Alternate Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','36','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','36',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','37','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','37',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone (Formatted)"','38','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','38',NULL,'Home Phone (Formatted)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone (Formatted)"','39','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','39',NULL,'Work Phone (Formatted)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','40','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','40',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Hire Date"','41','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','41',NULL,'Last Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','42','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','42',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Type Code"','43','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','43',NULL,'Termination Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Reason"','44','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','44',NULL,'Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Hire Date"','45','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','45',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Annual Hours"','46','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','46',NULL,'Scheduled Annual Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Work Hours"','47','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','47',NULL,'Scheduled Work Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hourly Pay Rate"','48','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','48',NULL,'Hourly Pay Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Deduction/Benefit Group Code"','49','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','49',NULL,'Deduction/Benefit Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Type Code"','50','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','50',NULL,'Employee Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','51','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','51',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Contact ID"','52','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','52',NULL,'HR Contact ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefits Seniority Date"','53','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','53',NULL,'Benefits Seniority Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work State','54','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','54',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Zip Code"','55','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','55',NULL,'Work Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked"','56','(''DA''=''T'')','EBENSOLDEMZ0','50','H','01','56',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeName"','1','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','1',NULL,'Employee Name (Last Suffix, First MI)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','2','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','3','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','4','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','4',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Active"','5','(''DA''=''T,'')','EBENSOLDEMZ0','50','D','10','5',NULL,'Benefit Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','6',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeductionBenefitGroup"','7','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','7',NULL,'Deduction/Benefit Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','8','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','8',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','9','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','9',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayGroup"','10','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','10',NULL,'Pay Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','11','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','11',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','12','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','12',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl1Code"','13','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','13',NULL,'Org Level 1 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl1"','14','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','14',NULL,'Org Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl2Code"','15','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','15',NULL,'Org Level 2 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl2"','16','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','16',NULL,'Org Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl3Code"','17','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','17',NULL,'Org Level 3 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl3"','18','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','18',NULL,'Org Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl4Code"','19','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','19',NULL,'Org Level 4 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl4"','20','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','20',NULL,'Org Level 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRetirementDate"','21','(''UD101''=''T,'')','EBENSOLDEMZ0','50','D','10','21',NULL,'Retirement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','22','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','22',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryOrHourly"','23','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','23',NULL,'Salary or Hourly',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullPartTime"','24','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','24',NULL,'Full/Part Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','25','(''UD101''=''T,'')','EBENSOLDEMZ0','50','D','10','25',NULL,'Date Of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','26','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','26',NULL,'SSN (Unformatted)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','27','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','27',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEhtnicity"','28','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','28',NULL,'Ethnicity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','29','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','29',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','30','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','30',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','31','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','31',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','32','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','32',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','33','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','33',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','34','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','34',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmailAlternate"','35','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','35',NULL,'Alternate Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','36','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','36',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneWork"','37','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','37',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeFormatted"','38','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','38',NULL,'Home Phone (Formatted)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneWorkFormatted"','39','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','39',NULL,'Work Phone (Formatted)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHome"','40','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','40',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastHireDate"','41','(''UD101''=''T,'')','EBENSOLDEMZ0','50','D','10','41',NULL,'Last Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','42','(''UD101''=''T,'')','EBENSOLDEMZ0','50','D','10','42',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationTypeCode"','43','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','43',NULL,'Termination Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReason"','44','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','44',NULL,'Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalHireDate"','45','(''UD101''=''T,'')','EBENSOLDEMZ0','50','D','10','45',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledAnnualHours"','46','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','46',NULL,'Scheduled Annual Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledWorkHours"','47','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','47',NULL,'Scheduled Work Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlyPayRate"','48','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','48',NULL,'Hourly Pay Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeductionBenefitGroupCode"','49','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','49',NULL,'Deduction/Benefit Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeTypeCode"','50','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','50',NULL,'Employee Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','51','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','51',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRContactId"','52','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','52',NULL,'HR Contact ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvenefitsSeniorityDate"','53','(''UD101''=''T,'')','EBENSOLDEMZ0','50','D','10','53',NULL,'Benefits Seniority Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','54','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','54',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkZipCode"','55','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','55',NULL,'Work Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','56','(''UA''=''T'')','EBENSOLDEMZ0','50','D','10','56',NULL,'Hours Worked',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EBENSOLDEM_20201112.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Business Solver Demo Export','202011119','EMPEXPORT','ONDEM_XOE','Sep 22 2020 10:33AM','EBENSOLDEM',NULL,NULL,NULL,'202011119','Sep 17 2020 12:01PM','Sep 17 2020 12:01PM','202011041','1300','','','202011041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','OFPDO',NULL,NULL,NULL,'Benefitsolver Demo - Wed 2am','202011119','EMPEXPORT','SCH_EBENSO','Sep 22 2020 10:33AM','EBENSOLDEM',NULL,NULL,NULL,'202011119','Sep 17 2020 12:01PM','Sep 17 2020 12:01PM','202011041','1300','','','202011041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Business Solver Demo Exp-Test','202011119','EMPEXPORT','TEST_XOE','Oct 27 2020  9:43AM','EBENSOLDEM',NULL,NULL,NULL,'202011119','Oct 27 2020 12:00AM','Dec 30 1899 12:00AM','202011041','1149','','','202011041',dbo.fn_GetTimedKey(),NULL,'us3lKiHOF1002',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENSOLDEM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENSOLDEM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENSOLDEM','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENSOLDEM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENSOLDEM','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EBENSOLDEM' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EBENSOLDEM' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EBENSOLDEM_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBENSOLDEM_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBENSOLDEM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBENSOLDEM','D10','dbo.U_EBENSOLDEM_drvTbl',NULL);
IF OBJECT_ID('U_EBENSOLDEM_Audit') IS NULL
CREATE TABLE [dbo].[U_EBENSOLDEM_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBENSOLDEM_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBENSOLDEM_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EBENSOLDEM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBENSOLDEM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeName] varchar(8000) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvDeductionBenefitGroup] varchar(25) NULL,
    [drvEmploymentStatus] varchar(45) NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvPayGroup] varchar(25) NULL,
    [drvPayFrequency] varchar(8) NULL,
    [drvLocation] varchar(27) NULL,
    [drvOrgLvl1Code] varchar(10) NULL,
    [drvOrgLvl1] varchar(25) NULL,
    [drvOrgLvl2Code] varchar(10) NULL,
    [drvOrgLvl2] varchar(25) NULL,
    [drvOrgLvl3Code] varchar(10) NULL,
    [drvOrgLvl3] varchar(25) NULL,
    [drvOrgLvl4Code] varchar(10) NULL,
    [drvOrgLvl4] varchar(25) NULL,
    [drvRetirementDate] datetime NULL,
    [drvAnnualSalary] nvarchar(4000) NULL,
    [drvSalaryOrHourly] varchar(8) NOT NULL,
    [drvFullPartTime] varchar(9) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvMaritalStatus] varchar(45) NULL,
    [drvEhtnicity] varchar(45) NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(257) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvAddressEmailAlternate] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvPhoneWork] varchar(50) NULL,
    [drvPhoneHomeFormatted] varchar(12) NULL,
    [drvPhoneWorkFormatted] varchar(12) NULL,
    [drvPhoneHome] varchar(50) NULL,
    [drvLastHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvTerminationTypeCode] char(6) NULL,
    [drvTerminationReason] varchar(25) NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvScheduledAnnualHours] nvarchar(4000) NULL,
    [drvScheduledWorkHours] nvarchar(4000) NULL,
    [drvHourlyPayRate] nvarchar(4000) NULL,
    [drvDeductionBenefitGroupCode] char(5) NULL,
    [drvEmployeeTypeCode] char(3) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvHRContactId] varchar(25) NULL,
    [drvenefitsSeniorityDate] datetime NULL,
    [drvWorkState] varchar(255) NULL,
    [drvWorkZipCode] varchar(50) NULL,
    [drvHoursWorked] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EBENSOLDEM_EEList') IS NULL
CREATE TABLE [dbo].[U_EBENSOLDEM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EBENSOLDEM_File') IS NULL
CREATE TABLE [dbo].[U_EBENSOLDEM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EBENSOLDEM_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBENSOLDEM_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENSOLDEM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Hoffmaster Group

Created By: James Bender
Business Analyst: Lea King
Create Date: 09/17/2020
Service Request Number: TekP-2020-08-12-0002

Purpose: BenfitSolver Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBENSOLDEM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBENSOLDEM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBENSOLDEM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBENSOLDEM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBENSOLDEM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENSOLDEM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENSOLDEM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENSOLDEM', 'SCH_EBENSO';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBENSOLDEM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBENSOLDEM';

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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBENSOLDEM_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBENSOLDEM_AuditFields;
    CREATE TABLE dbo.U_EBENSOLDEM_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EBENSOLDEM_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBENSOLDEM_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBENSOLDEM_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EBENSOLDEM_Audit
    FROM dbo.U_EBENSOLDEM_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EBENSOLDEM_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';
    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EBENSOLDEM_Audit WHERE audRowNo > 1;








    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EBENSOLDEM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBENSOLDEM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    -----------------------------
    -- Working Table - vw_int_PEarHist
    -----------------------------
    IF OBJECT_ID('U_EBENSOLDEM_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBENSOLDEM_PEarHist;
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
    INTO dbo.U_EBENSOLDEM_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE CAST(LEFT(PehPerControl, 8) AS DATE) BETWEEN DATEADD(YEAR, -1, GETDATE()) AND GETDATE()
    --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBENSOLDEM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBENSOLDEM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBENSOLDEM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeName = '"' + REPLACE(EepNameLast + ' ' + ISNULL(EepNameSuffix, '') + ', ' + EepNameFirst + CASE WHEN ISNULL(EepNameMiddle, '') <> '' THEN ' ' + LEFT(ISNULL(EepNameMiddle, ''), 1)  ELSE '' END, ' ,', ',') + '"'
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvNameSuffix = EepNameSuffix
        ,drvNameMiddle = EepNameMiddle
        ,drvDeductionBenefitGroup = CbgBenGroupDesc
        ,drvEmploymentStatus = CodDesc
        ,drvJobTitle = JbcDesc
        ,drvPayGroup = PgrDesc
        ,drvPayFrequency =    CASE WHEN PgrPayFrequency = 'B' THEN 'BiWeekly'
                                WHEN PgrPayFrequency = 'W' THEN 'Weekly'
                            END
        ,drvLocation = '"' + LocDesc + '"'
        ,drvOrgLvl1Code = EecOrgLvl1
        ,drvOrgLvl1 = OrgLvl1Desc
        ,drvOrgLvl2Code = EecOrgLvl2
        ,drvOrgLvl2 = OrgLvl2Desc
        ,drvOrgLvl3Code = EecOrgLvl3
        ,drvOrgLvl3 = OrgLvl3Desc
        ,drvOrgLvl4Code = EecOrgLvl4
        ,drvOrgLvl4 = OrgLvl4Desc
        ,drvRetirementDate = CASE WHEN EecTermReason IN ('202','EARET','NORET') THEN EecDateOfTermination END
        ,drvAnnualSalary = FORMAT(EecAnnSalary, '#0.00')
        ,drvSalaryOrHourly = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Salaried' ELSE 'Hourly' END
        ,drvFullPartTime = CASE WHEN EecfullTimeOrPartTime = 'F' THEN 'Full Time' ELSE 'Part Time' END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSSN = eepSSN
        ,drvMaritalStatus = MsDesc
        ,drvEhtnicity = EDesc
        ,drvAddressLine1 = '"' + EepAddressLine1 + '"'
        ,drvAddressLine2 = CASE WHEN ISNULL(EepAddressLine2, '') <> '' THEN '"' + EepAddressLine2 + '"' END
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressEmail = EepAddressEMail
        ,drvAddressEmailAlternate = EepAddressEMailAlternate
        ,drvGender = EepGender
        ,drvPhoneWork = EecPhoneBusinessNumber
        ,drvPhoneHomeFormatted = LEFT(EepPhoneHomeNumber,3) + '-' + RIGHT(LEFT(EepPhoneHomeNumber, 6), 3) + '-' + RIGHT(EepPhoneHomeNumber, 4)
        ,drvPhoneWorkFormatted = CASE WHEN ISNULL(EecPhoneBusinessNumber, '') <> '' THEN LEFT(EecPhoneBusinessNumber,3) + '-' + RIGHT(LEFT(EecPhoneBusinessNumber, 6), 3) + '-' + RIGHT(EecPhoneBusinessNumber, 4) END
        ,drvPhoneHome = EepPhoneHomeNumber
        ,drvLastHireDate = EecDateOfLastHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTerminationTypeCode = EecTermType
        ,drvTerminationReason = TchDesc 
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvScheduledAnnualHours = FORMAT(EecScheduledAnnualHrs, '#0.00')
        ,drvScheduledWorkHours = FORMAT(EecScheduledWorkHrs, '#0.00')
        ,drvHourlyPayRate = FORMAT(EecHourlyPayRate, '#0.00')
        ,drvDeductionBenefitGroupCode = EecDedGroupCode
        ,drvEmployeeTypeCode = EecEEType
        ,drvEmployeeID = EecEmpNo
        ,drvHRContactId = EecUDField14
        ,drvenefitsSeniorityDate = EecDateOfBenefitSeniority
        ,drvWorkState = LocAddressState
        ,drvWorkZipCode =    CASE WHEN LocAddressCity = 'Remote' THEN EepAddressZipCode ELSE LocAddressZipCode END
        ,drvHoursWorked = FORMAT(PehCurHrsYTD, '#0.00')
    INTO dbo.U_EBENSOLDEM_drvTbl
    FROM dbo.U_EBENSOLDEM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.BenGrp WITH (NOLOCK)
        ON EecDedGroupCode = CbgBenGroupCode
    JOIN dbo.Codes WITH (NOLOCK)
        ON EecEmplStatus = CodCode
        AND CodTable = 'EMPLOYEESTATUS'
    LEFT JOIN (
            SELECT CodCode AS MsCode, CodDesc AS MsDesc
            FROM dbo.Codes WITH (NOLOCK)
            WHERE CodTable = 'MARITALSTATUS'
            ) AS MStatus
        ON MsCode = EepMaritalStatus
    LEFT JOIN (
            SELECT CodCode AS ECode, CodDesc AS EDesc
            FROM dbo.Codes WITH (NOLOCK)
            WHERE CodTable = 'ETHNICCODE'
            ) AS EStatus
        ON EepEthnicID = ECode
    LEFT JOIN dbo.PayGroup WITH (NOLOCK)
        ON EecPayGroup = PgrPayGroup
    LEFT JOIN dbo.Location WITH (NOLOCK)
        ON EecLocation = LocCode
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl1Code, OrgDesc AS OrgLvl1Desc
                FROM dbo.vw_int_OrgLevel WITH (NOLOCK)) AS Lvl1
    ON EecOrgLvl1 = OrgLvl1Code
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl2Code, OrgDesc AS OrgLvl2Desc
                FROM dbo.vw_int_OrgLevel WITH (NOLOCK)) AS Lvl2
    ON EecOrgLvl2 = OrgLvl2Code
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl3Code, OrgDesc AS OrgLvl3Desc
                FROM dbo.vw_int_OrgLevel WITH (NOLOCK)) AS Lvl3
    ON EecOrgLvl3 = OrgLvl3Code
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl4Code, OrgDesc AS OrgLvl4Desc
                FROM dbo.vw_int_OrgLevel WITH (NOLOCK)) AS Lvl4
    ON EecOrgLvl4 = OrgLvl4Code
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.U_EBENSOLDEM_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EBENSOLDEM_Audit WITH (NOLOCK)
        ON audEEID = xEEID 
        AND audKey2 = xCOID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND /*EecDateOfTermination*/ audDateTime BETWEEN @StartDate AND @EndDAte)
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
ALTER VIEW dbo.dsi_vwEBENSOLDEM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBENSOLDEM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBENSOLDEM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202011041'
       ,expStartPerControl     = '202011041'
       ,expLastEndPerControl   = '202011119'
       ,expEndPerControl       = '202011119'
WHERE expFormatCode = 'EBENSOLDEM';

**********************************************************************************/
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENSOLDEM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Hoffmaster Group

Created By: James Bender
Business Analyst: Lea King
Create Date: 09/17/2020
Service Request Number: TekP-2020-08-12-0002

Purpose: BenfitSolver Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBENSOLDEM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBENSOLDEM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBENSOLDEM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBENSOLDEM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBENSOLDEM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENSOLDEM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENSOLDEM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENSOLDEM', 'SCH_EBENSO';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBENSOLDEM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBENSOLDEM';

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
    DELETE FROM dbo.U_EBENSOLDEM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBENSOLDEM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EBENSOLDEM_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBENSOLDEM_PEarHist;
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
    INTO dbo.U_EBENSOLDEM_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE CAST(LEFT(PehPerControl, 8) AS DATE) BETWEEN DATEADD(YEAR, -1, GETDATE()) AND GETDATE()
    --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBENSOLDEM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBENSOLDEM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBENSOLDEM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeName = '"' + REPLACE(EepNameLast + ' ' + ISNULL(EepNameSuffix, '') + ', ' + EepNameFirst + CASE WHEN ISNULL(EepNameMiddle, '') <> '' THEN ' ' + LEFT(ISNULL(EepNameMiddle, ''), 1)  ELSE '' END, ' ,', ',') + '"'
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvNameSuffix = EepNameSuffix
        ,drvNameMiddle = EepNameMiddle
        ,drvDeductionBenefitGroup = CbgBenGroupDesc
        ,drvEmploymentStatus = CodDesc
        ,drvJobTitle = JbcDesc
        ,drvPayGroup = PgrDesc
        ,drvPayFrequency =    CASE WHEN PgrPayFrequency = 'B' THEN 'BiWeekly'
                                WHEN PgrPayFrequency = 'W' THEN 'Weekly'
                            END
        ,drvLocation = '"' + LocDesc + '"'
        ,drvOrgLvl1Code = EecOrgLvl1
        ,drvOrgLvl1 = OrgLvl1Desc
        ,drvOrgLvl2Code = EecOrgLvl2
        ,drvOrgLvl2 = OrgLvl2Desc
        ,drvOrgLvl3Code = EecOrgLvl3
        ,drvOrgLvl3 = OrgLvl3Desc
        ,drvOrgLvl4Code = EecOrgLvl4
        ,drvOrgLvl4 = OrgLvl4Desc
        ,drvRetirementDate = CASE WHEN EecTermReason IN ('202','EARET','NORET') THEN EecDateOfTermination END
        ,drvAnnualSalary = FORMAT(EecAnnSalary, '#0.00')
        ,drvSalaryOrHourly = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Salaried' ELSE 'Hourly' END
        ,drvFullPartTime = CASE WHEN EecfullTimeOrPartTime = 'F' THEN 'Full Time' ELSE 'Part Time' END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSSN = eepSSN
        ,drvMaritalStatus = MsDesc
        ,drvEhtnicity = EDesc
        ,drvAddressLine1 = '"' + EepAddressLine1 + '"'
        ,drvAddressLine2 = CASE WHEN ISNULL(EepAddressLine2, '') <> '' THEN '"' + EepAddressLine2 + '"' END
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressEmail = EepAddressEMail
        ,drvAddressEmailAlternate = EepAddressEMailAlternate
        ,drvGender = EepGender
        ,drvPhoneWork = EecPhoneBusinessNumber
        ,drvPhoneHomeFormatted = LEFT(EepPhoneHomeNumber,3) + '-' + RIGHT(LEFT(EepPhoneHomeNumber, 6), 3) + '-' + RIGHT(EepPhoneHomeNumber, 4)
        ,drvPhoneWorkFormatted = CASE WHEN ISNULL(EecPhoneBusinessNumber, '') <> '' THEN LEFT(EecPhoneBusinessNumber,3) + '-' + RIGHT(LEFT(EecPhoneBusinessNumber, 6), 3) + '-' + RIGHT(EecPhoneBusinessNumber, 4) END
        ,drvPhoneHome = EepPhoneHomeNumber
        ,drvLastHireDate = EecDateOfLastHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTerminationTypeCode = EecTermType
        ,drvTerminationReason = TchDesc 
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvScheduledAnnualHours = FORMAT(EecScheduledAnnualHrs, '#0.00')
        ,drvScheduledWorkHours = FORMAT(EecScheduledWorkHrs, '#0.00')
        ,drvHourlyPayRate = FORMAT(EecHourlyPayRate, '#0.00')
        ,drvDeductionBenefitGroupCode = EecDedGroupCode
        ,drvEmployeeTypeCode = EecEEType
        ,drvEmployeeID = EecEmpNo
        ,drvHRContactId = EecUDField14
        ,drvenefitsSeniorityDate = EecDateOfBenefitSeniority
        ,drvWorkState = LocAddressState
        ,drvWorkZipCode =    CASE WHEN LocAddressCity = 'Remote' THEN EepAddressZipCode ELSE LocAddressZipCode END
        ,drvHoursWorked = FORMAT(PehCurHrsYTD, '#0.00')
    INTO dbo.U_EBENSOLDEM_drvTbl
    FROM dbo.U_EBENSOLDEM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.BenGrp WITH (NOLOCK)
        ON EecDedGroupCode = CbgBenGroupCode
    JOIN dbo.Codes WITH (NOLOCK)
        ON EecEmplStatus = CodCode
        AND CodTable = 'EMPLOYEESTATUS'
    LEFT JOIN (
            SELECT CodCode AS MsCode, CodDesc AS MsDesc
            FROM dbo.Codes WITH (NOLOCK)
            WHERE CodTable = 'MARITALSTATUS'
            ) AS MStatus
        ON MsCode = EepMaritalStatus
    LEFT JOIN (
            SELECT CodCode AS ECode, CodDesc AS EDesc
            FROM dbo.Codes WITH (NOLOCK)
            WHERE CodTable = 'ETHNICCODE'
            ) AS EStatus
        ON EepEthnicID = ECode
    LEFT JOIN dbo.PayGroup WITH (NOLOCK)
        ON EecPayGroup = PgrPayGroup
    LEFT JOIN dbo.Location WITH (NOLOCK)
        ON EecLocation = LocCode
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl1Code, OrgDesc AS OrgLvl1Desc
                FROM dbo.OrgLevel WITH (NOLOCK)) AS Lvl1
    ON EecOrgLvl1 = OrgLvl1Code
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl2Code, OrgDesc AS OrgLvl2Desc
                FROM dbo.OrgLevel WITH (NOLOCK)) AS Lvl2
    ON EecOrgLvl2 = OrgLvl2Code
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl3Code, OrgDesc AS OrgLvl3Desc
                FROM dbo.OrgLevel WITH (NOLOCK)) AS Lvl3
    ON EecOrgLvl3 = OrgLvl3Code
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl4Code, OrgDesc AS OrgLvl4Desc
                FROM dbo.OrgLevel WITH (NOLOCK)) AS Lvl4
    ON EecOrgLvl4 = OrgLvl4Code
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    JOIN dbo.U_EBENSOLDEM_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDAte)
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
ALTER VIEW dbo.dsi_vwEBENSOLDEM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBENSOLDEM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBENSOLDEM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202008011'
       ,expStartPerControl     = '202008011'
       ,expLastEndPerControl   = '202009179'
       ,expEndPerControl       = '202009179'
WHERE expFormatCode = 'EBENSOLDEM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBENSOLDEM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBENSOLDEM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort