SET NOCOUNT ON;
IF OBJECT_ID('U_EBENSOLDEM_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBENSOLDEM_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EBENSOLDEM_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EBENSOLDEM' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBENSOLDEM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENSOLDEM];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EBENSOLDEM';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EBENSOLDEM';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EBENSOLDEM';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EBENSOLDEM';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EBENSOLDEM';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) VALUES ('N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','EBENSOLDEM','Business Solver Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','N','S','N','EBENSOLDEMZ0','N','Jan  1 1900 12:00AM','C','N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Name (Last Suffix, First MI)"','1','(''DA''=''T,'')','EBENSOLDEMZ0','50','H','01','1',NULL,'Employee Name (Last Suffix, First MI)',NULL,NULL);
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
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Contact ID"','52','(''DA''=''T'')','EBENSOLDEMZ0','50','H','01','52',NULL,'HR Contact ID',NULL,NULL);
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
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRetirementDate"','21','''UD101''=''T,'')','EBENSOLDEMZ0','50','D','10','21',NULL,'Retirement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','22','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','22',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryOrHourly"','23','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','23',NULL,'Salary or Hourly',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullPartTime"','24','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','24',NULL,'Full/Part Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','25','''UD101''=''T,'')','EBENSOLDEMZ0','50','D','10','25',NULL,'Date Of Birth',NULL,NULL);
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
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastHireDate"','41','''UD101''=''T,'')','EBENSOLDEMZ0','50','D','10','41',NULL,'Last Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','42','''UD101''=''T,'')','EBENSOLDEMZ0','50','D','10','42',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationTypeCode"','43','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','43',NULL,'Termination Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReason"','44','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','44',NULL,'Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalHireDate"','45','''UD101''=''T,'')','EBENSOLDEMZ0','50','D','10','45',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledAnnualHours"','46','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','46',NULL,'Scheduled Annual Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledWorkHours"','47','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','47',NULL,'Scheduled Work Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlyPayRate"','48','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','48',NULL,'Hourly Pay Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeductionBenefitGroupCode"','49','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','49',NULL,'Deduction/Benefit Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeTypeCode"','50','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','50',NULL,'Employee Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','51','(''UA''=''T,'')','EBENSOLDEMZ0','50','D','10','51',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRContactId"','52','(''UA''=''T'')','EBENSOLDEMZ0','50','D','10','52',NULL,'HR Contact ID',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\EBENSOLDEM_20200917.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Business Solver Demo Export','202009179','EMPEXPORT','ONDEM_XOE',NULL,'EBENSOLDEM',NULL,NULL,NULL,'202009179','Sep 17 2020 12:01PM','Sep 17 2020 12:01PM','202009171',NULL,'','','202009171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\EBENSOLDEM_20200917.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Business Solver Demo Exp-Test','202009179','EMPEXPORT','TEST_XOE',NULL,'EBENSOLDEM',NULL,NULL,NULL,'202009179','Sep 17 2020 12:01PM','Sep 17 2020 12:01PM','202009171',NULL,'','','202009171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\EBENSOLDEM_20200917.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Business Solver Demo Exp-Sched','202009179','EMPEXPORT','SCH_EBENSO',NULL,'EBENSOLDEM',NULL,NULL,NULL,'202009179','Sep 17 2020 12:01PM','Sep 17 2020 12:01PM','202009171',NULL,'','','202009171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\EBENSOLDEM_20200917.txt' END WHERE expFormatCode = 'EBENSOLDEM';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENSOLDEM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENSOLDEM','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENSOLDEM','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENSOLDEM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENSOLDEM','UseFileName','V','N');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EBENSOLDEM' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EBENSOLDEM' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EBENSOLDEM_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBENSOLDEM_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBENSOLDEM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBENSOLDEM','D10','dbo.U_EBENSOLDEM_drvTbl',NULL);
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

Purpose: Business Solver Demo Export

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
        ,drvEmployeeName = ''
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvDeductionBenefitGroup = ''
        ,drvEmploymentStatus = ''
        ,drvJobTitle = ''
        ,drvPayGroup = EecPayGroup
        ,drvPayFrequency = ''
        ,drvLocation = EecLocation
        ,drvOrgLvl1Code = ''
        ,drvOrgLvl1 = EecOrgLvl1
        ,drvOrgLvl2Code = ''
        ,drvOrgLvl2 = EecOrgLvl2
        ,drvOrgLvl3Code = ''
        ,drvOrgLvl3 = EecOrgLvl3
        ,drvOrgLvl4Code = ''
        ,drvOrgLvl4 = EecOrgLvl4
        ,drvRetirementDate = ''
        ,drvAnnualSalary = ''
        ,drvSalaryOrHourly = EecSalaryOrHourly
        ,drvFullPartTime = ''
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSSN = eepSSN
        ,drvMaritalStatus = eepMaritalStatus
        ,drvEhtnicity = EepAddressCity
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressEmail = EepAddressEMail
        ,drvAddressEmailAlternate = EepAddressEMail
        ,drvGender = EepGender
        ,drvPhoneWork = ''
        ,drvPhoneHomeFormatted = ''
        ,drvPhoneWorkFormatted = ''
        ,drvPhoneHome = ''
        ,drvLastHireDate = EecDateOfLastHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTerminationTypeCode = ''
        ,drvTerminationReason = CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvOriginalHireDate = EecDateOfLastHire
        ,drvScheduledAnnualHours = ''
        ,drvScheduledWorkHours = ''
        ,drvHourlyPayRate = ''
        ,drvDeductionBenefitGroupCode = ''
        ,drvEmployeeTypeCode = ''
        ,drvEmployeeID = EecEmpNo
        ,drvHRContactId = ''
    INTO dbo.U_EBENSOLDEM_drvTbl
    FROM dbo.U_EBENSOLDEM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
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
    SET expLastStartPerControl = '202009101'
       ,expStartPerControl     = '202009101'
       ,expLastEndPerControl   = '202009179'
       ,expEndPerControl       = '202009179'
WHERE expFormatCode = 'EBENSOLDEM';

**********************************************************************************/