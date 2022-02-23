SET NOCOUNT ON;
IF OBJECT_ID('U_EFUALOK401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFUALOK401_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFUALOK401_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFUALOK401' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFUALOK401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFUALOK401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFUALOK401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFUALOK401];
GO
IF OBJECT_ID('U_EFUALOK401_PEarHistNet') IS NOT NULL DROP TABLE [dbo].[U_EFUALOK401_PEarHistNet];
GO
IF OBJECT_ID('U_EFUALOK401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFUALOK401_PEarHist];
GO
IF OBJECT_ID('U_EFUALOK401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFUALOK401_PDedHist];
GO
IF OBJECT_ID('U_EFUALOK401_File') IS NOT NULL DROP TABLE [dbo].[U_EFUALOK401_File];
GO
IF OBJECT_ID('U_EFUALOK401_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFUALOK401_EEList];
GO
IF OBJECT_ID('U_EFUALOK401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EFUALOK401_drvTbl];
GO
IF OBJECT_ID('U_EFUALOK401_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFUALOK401_DedList];
GO
IF OBJECT_ID('U_EFUALOK401_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFUALOK401_AuditFields];
GO
IF OBJECT_ID('U_EFUALOK401_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFUALOK401_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EFUALOK401') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFUALOK401];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFUALOK401';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFUALOK401';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFUALOK401';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFUALOK401';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFUALOK401';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFUALOK401','ForUsAll 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EFUALOK401Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','1','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','1',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','2','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','2',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','3','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','4','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','4',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','5','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','5',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Status"','6','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','6',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','7','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','7',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Type"','8','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','8',NULL,'Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 1"','9','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','9',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 2"','10','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','10',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','11','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','12','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','13','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','13',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','14','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','14',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mobile Phone"','15','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','15',NULL,'Mobile Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','16','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','16',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Birth Date"','17','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','17',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Personal Email"','18','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','18',NULL,'Personal Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Email"','19','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','19',NULL,'Work Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Annual Salary"','20','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','20',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Class"','21','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','21',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date"','22','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','22',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','23','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','23',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','24','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','24',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Check Date"','25','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','25',NULL,'Check Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Begin Date"','26','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','26',NULL,'Payroll Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll End Date"','27','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','27',NULL,'Payroll End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Frequency"','28','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','28',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gross Earnings"','29','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','29',NULL,'Gross Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Earnings"','30','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','30',NULL,'Plan Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked"','31','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','31',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Net Pay"','32','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','32',NULL,'Net Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Bonus Pay"','33','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','33',NULL,'Bonus Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Gross Earnings"','34','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','34',NULL,'YTD Gross Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Plan Earnings"','35','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','35',NULL,'YTD Plan Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Hours Worked"','36','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','36',NULL,'YTD Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Net Pay"','37','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','37',NULL,'YTD Net Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Bonus Pay"','38','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','38',NULL,'YTD Bonus Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Excluded Earnings"','39','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','39',NULL,'YTD Excluded Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Deferral"','40','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','40',NULL,'Employee Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Roth"','41','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','41',NULL,'Employee Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Match "','42','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','42',NULL,'Employer Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Safe Harbor Match"','43','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','43',NULL,'Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualified Matching"','44','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','44',NULL,'Qualified Matching',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Safe Harbor Non-Elective"','45','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','45',NULL,'Safe Harbor Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Qualified Non-Elective"','46','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','46',NULL,'Qualified Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Profit Sharing"','47','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','47',NULL,'Profit Sharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment 1"','48','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','48',NULL,'Loan Payment 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Number 1"','49','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','49',NULL,'Loan Number 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment 2"','50','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','50',NULL,'Loan Payment 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Number 2"','51','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','51',NULL,'Loan Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment 3"','52','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','52',NULL,'Loan Payment 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Number 3"','53','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','53',NULL,'Loan Number 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment 4"','54','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','54',NULL,'Loan Payment 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Number 4"','55','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','55',NULL,'Loan Number 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment 5"','56','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','56',NULL,'Loan Payment 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Number 5"','57','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','57',NULL,'Loan Number 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Employee Deferral"','58','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','58',NULL,'YTD Employee Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Employee Roth"','59','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','59',NULL,'YTD Employee Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Employer Match "','60','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','60',NULL,'YTD Employer Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Safe Harbor Match"','61','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','61',NULL,'YTD Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Qualified Match"','62','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','62',NULL,'YTD Qualified Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Safe Harbor Non-Elective"','63','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','63',NULL,'YTD Safe Harbor Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Qual Non-Elective"','64','(''DA''=''T,'')','EFUALOK401Z0','50','H','01','64',NULL,'YTD Qual Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Profit Sharing"','65','(''DA''=''T'')','EFUALOK401Z0','50','H','01','65',NULL,'YTD Profit Sharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','1','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','1',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','2','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','2',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','3','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','4',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','5','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','5',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','6','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','6',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','7','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','7',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayType"','8','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','8',NULL,'Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','9','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','9',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','10','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','10',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','11','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','12','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','13','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','13',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','14','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','14',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMobilePhone"','15','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','15',NULL,'Mobile Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','16','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','16',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','17','(''UD101''=''T,'')','EFUALOK401Z0','50','D','10','17',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonalEmail"','18','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','18',NULL,'Personal Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmail"','19','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','19',NULL,'Work Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','20','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','20',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeClass"','21','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','21',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','22','(''UD101''=''T,'')','EFUALOK401Z0','50','D','10','22',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','23','(''UD101''=''T,'')','EFUALOK401Z0','50','D','10','23',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','24','(''UD101''=''T,'')','EFUALOK401Z0','50','D','10','24',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','25','(''UD101''=''T,'')','EFUALOK401Z0','50','D','10','25',NULL,'Check Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollBeginDate"','26','(''UD101''=''T,'')','EFUALOK401Z0','50','D','10','26',NULL,'Payroll Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollEndDate"','27','(''UD101''=''T,'')','EFUALOK401Z0','50','D','10','27',NULL,'Payroll End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFrequency"','28','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','28',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrossEarnings"','29','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','29',NULL,'Gross Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEarnings"','30','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','30',NULL,'Plan Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','31','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','31',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNetPay"','32','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','32',NULL,'Net Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBonusPay"','33','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','33',NULL,'Bonus Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDGrossEarnings"','34','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','34',NULL,'YTD Gross Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPlanEarnings"','35','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','35',NULL,'YTD Plan Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDHoursWorked"','36','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','36',NULL,'YTD Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDNetPay"','37','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','37',NULL,'YTD Net Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDBonusPay"','38','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','38',NULL,'YTD Bonus Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDExcludedEarnings"','39','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','39',NULL,'YTD Excluded Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDeferral"','40','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','40',NULL,'Employee Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeRoth"','41','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','41',NULL,'Employee Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerMatch"','42','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','42',NULL,'Employer Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSafeHarborMatch"','43','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','43',NULL,'Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifiedMatching"','44','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','44',NULL,'Qualified Matching',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSafeHarborNonElective"','45','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','45',NULL,'Safe Harbor Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifiedNonElective"','46','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','46',NULL,'Qualified Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProfitSharing"','47','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','47',NULL,'Profit Sharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment1"','48','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','48',NULL,'Loan Payment 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber1"','49','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','49',NULL,'Loan Number 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment2"','50','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','50',NULL,'Loan Payment 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber2"','51','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','51',NULL,'Loan Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment3"','52','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','52',NULL,'Loan Payment 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber3"','53','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','53',NULL,'Loan Number 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment4"','54','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','54',NULL,'Loan Payment 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber4"','55','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','55',NULL,'Loan Number 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment5"','56','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','56',NULL,'Loan Payment 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber5"','57','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','57',NULL,'Loan Number 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDEmployeeDeferral"','58','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','58',NULL,'YTD Employee Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDEmployeeRoth"','59','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','59',NULL,'YTD Employee Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDEmployerMatch"','60','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','60',NULL,'YTD Employer Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDSafeHarborMatch"','61','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','61',NULL,'YTD Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDQualifiedMatch"','62','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','62',NULL,'YTD Qualified Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDSafeHarborNonElective"','63','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','63',NULL,'YTD Safe Harbor Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDQualNonElective"','64','(''UA''=''T,'')','EFUALOK401Z0','50','D','10','64',NULL,'YTD Qual Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDProfitSharing"','65','(''UA''=''T'')','EFUALOK401Z0','50','D','10','65',NULL,'YTD Profit Sharing',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFUALOK401_20200813.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ForUsAll 401K Export','202006179','EMPEXPORT','ONDEMAND',NULL,'EFUALOK401',NULL,NULL,NULL,'202006179','Jun 17 2020 10:31AM','Jun 17 2020 10:31AM','202006171',NULL,'','','202006171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFUALOK401_20200813.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202006179','EMPEXPORT','SCH_FUALO',NULL,'EFUALOK401',NULL,NULL,NULL,'202006179','Jun 17 2020 10:31AM','Jun 17 2020 10:31AM','202006171',NULL,'','','202006171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFUALOK401_20200813.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202006179','EMPEXPORT','OEACTIVE',NULL,'EFUALOK401',NULL,NULL,NULL,'202006179','Jun 17 2020 10:31AM','Jun 17 2020 10:31AM','202006171',NULL,'','','202006171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFUALOK401_20200813.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202006179','EMPEXPORT','OEPASSIVE',NULL,'EFUALOK401',NULL,NULL,NULL,'202006179','Jun 17 2020 10:31AM','Jun 17 2020 10:31AM','202006171',NULL,'','','202006171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFUALOK401_20200813.txt',NULL,'','','LRVCT',NULL,NULL,NULL,'Test Purposes Only','202008059','EMPEXPORT','TEST','Aug 10 2020 12:00AM','EFUALOK401',NULL,NULL,NULL,'202008059','Aug  5 2020 12:00AM','Dec 30 1899 12:00AM','202008051','231','','','202008051',dbo.fn_GetTimedKey(),NULL,'us3lKiLOO1000',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EFUALOK401_20200813.txt' END WHERE expFormatCode = 'EFUALOK401';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFUALOK401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFUALOK401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFUALOK401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFUALOK401','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFUALOK401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFUALOK401','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFUALOK401','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EFUALOK401' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFUALOK401' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EFUALOK401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFUALOK401_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFUALOK401','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFUALOK401','D10','dbo.U_EFUALOK401_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EFUALOK401') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFUALOK401] (
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
IF OBJECT_ID('U_EFUALOK401_Audit') IS NULL
CREATE TABLE [dbo].[U_EFUALOK401_Audit] (
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
IF OBJECT_ID('U_EFUALOK401_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFUALOK401_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EFUALOK401_DedList') IS NULL
CREATE TABLE [dbo].[U_EFUALOK401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFUALOK401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EFUALOK401_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvGender] char(1) NULL,
    [drvEmployeeStatus] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvPayType] char(1) NULL,
    [drvAddress1] nvarchar(258) NULL,
    [drvAddress2] nvarchar(258) NULL,
    [drvCity] nvarchar(258) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvMobilePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvBirthDate] datetime NULL,
    [drvPersonalEmail] varchar(50) NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvAnnualSalary] varchar(12) NULL,
    [drvEmployeeClass] char(1) NULL,
    [drvHireDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvCheckDate] datetime NULL,
    [drvPayrollBeginDate] datetime NULL,
    [drvPayrollEndDate] datetime NULL,
    [drvPayrollFrequency] char(1) NULL,
    [drvGrossEarnings] varchar(12) NULL,
    [drvPlanEarnings] varchar(12) NULL,
    [drvHoursWorked] varchar(12) NULL,
    [drvNetPay] varchar(12) NULL,
    [drvBonusPay] varchar(12) NULL,
    [drvYTDGrossEarnings] varchar(12) NULL,
    [drvYTDPlanEarnings] varchar(12) NULL,
    [drvYTDHoursWorked] varchar(12) NULL,
    [drvYTDNetPay] varchar(12) NULL,
    [drvYTDBonusPay] varchar(12) NULL,
    [drvYTDExcludedEarnings] varchar(12) NULL,
    [drvEmployeeDeferral] varchar(12) NULL,
    [drvEmployeeRoth] varchar(12) NULL,
    [drvEmployerMatch] varchar(1) NOT NULL,
    [drvSafeHarborMatch] varchar(12) NULL,
    [drvQualifiedMatching] varchar(1) NOT NULL,
    [drvSafeHarborNonElective] varchar(1) NOT NULL,
    [drvQualifiedNonElective] varchar(1) NOT NULL,
    [drvProfitSharing] varchar(1) NOT NULL,
    [drvLoanPayment1] varchar(12) NULL,
    [drvLoanNumber1] varchar(4) NULL,
    [drvLoanPayment2] varchar(12) NULL,
    [drvLoanNumber2] varchar(5) NULL,
    [drvLoanPayment3] varchar(1) NOT NULL,
    [drvLoanNumber3] varchar(1) NOT NULL,
    [drvLoanPayment4] varchar(1) NOT NULL,
    [drvLoanNumber4] varchar(1) NOT NULL,
    [drvLoanPayment5] varchar(1) NOT NULL,
    [drvLoanNumber5] varchar(1) NOT NULL,
    [drvYTDEmployeeDeferral] varchar(12) NULL,
    [drvYTDEmployeeRoth] varchar(12) NULL,
    [drvYTDEmployerMatch] varchar(1) NOT NULL,
    [drvYTDSafeHarborMatch] varchar(1) NOT NULL,
    [drvYTDQualifiedMatch] varchar(1) NOT NULL,
    [drvYTDSafeHarborNonElective] varchar(1) NOT NULL,
    [drvYTDQualNonElective] varchar(1) NOT NULL,
    [drvYTDProfitSharing] varchar(1) NOT NULL,
    [drvDivisionID] char(5) NULL
);
IF OBJECT_ID('U_EFUALOK401_EEList') IS NULL
CREATE TABLE [dbo].[U_EFUALOK401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFUALOK401_File') IS NULL
CREATE TABLE [dbo].[U_EFUALOK401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_EFUALOK401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFUALOK401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhEmpDef] numeric NULL,
    [PdhRoth] numeric NULL,
    [Pdh401L] numeric NULL,
    [Pdh401L2] numeric NULL,
    [Pdh401M] numeric NULL,
    [PdhEmpDefYTD] numeric NULL,
    [PdhRothYTD] numeric NULL,
    [PdhDedCalcBasisAmt] numeric NULL,
    [PdhDedCalcBasisAmt401k] numeric NULL,
    [PdhDedCalcBasisAmtROTH] numeric NULL,
    [PdhDedCalcBasisAmtYTD] numeric NULL,
    [PdhDedCalcBasisAmt401kYTD] numeric NULL,
    [PdhDedCalcBasisAmtROTHYTD] numeric NULL
);
IF OBJECT_ID('U_EFUALOK401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFUALOK401_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurAmtBonus] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PrgNetAmt] numeric NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PrgNetAmtYTD] money NULL,
    [PehInclInDefComp2] numeric NULL,
    [PehCurAmtBonusYTD] numeric NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL,
    [PehInclInDefCompAmtPensionYTD] money NULL
);
IF OBJECT_ID('U_EFUALOK401_PEarHistNet') IS NULL
CREATE TABLE [dbo].[U_EFUALOK401_PEarHistNet] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgNetAmt] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFUALOK401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Looking Glass

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 07/27/2020
Service Request Number: TekP-2020-06-05-0001

Purpose: ForUsAll 401K Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFUALOK401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFUALOK401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFUALOK401';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFUALOK401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFUALOK401' ORDER BY RunID DESC;

Execute Export
--------------te
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFUALOK401', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFUALOK401', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFUALOK401', 'TEST';
PehInclInDefComp
EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFUALOK401';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFUALOK401', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFUALOK401';

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




    DELETE FROM dbo.U_EFUALOK401_EEList
    WHERE  xEEID IN (SELECT eeceeid from dbo.empcomp where  eeceetype NOT IN ('REG') )

    
    DELETE FROM dbo.U_EFUALOK401_EEList
    WHERE  xEEID IN (SELECT eeceeid FROM dbo.EmpComp where eecempno in('999991','999992','999993','100613','100827','100614'
    ,'100647','100647','100610','100942','100939','100611','100941','100651','100943','100944') )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CF,401CP,401F,401L,401L2,401M,401P,RTHCF,RTHCP,ROTHF,ROTHP';

    IF OBJECT_ID('U_EFUALOK401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFUALOK401_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFUALOK401_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@EndDate-30);
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

    IF OBJECT_ID('U_EFUALOK401_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFUALOK401_AuditFields;
    CREATE TABLE dbo.U_EFUALOK401_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EFUALOK401_AuditFields VALUES ('EmpComp','EecEmplStatus');    
    -- Create audit table
    IF OBJECT_ID('U_EFUALOK401_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFUALOK401_Audit;
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
    INTO dbo.U_EFUALOK401_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EFUALOK401_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EFUALOK401_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate -30 AND @EndDate + 30;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EFUALOK401_Audit ON dbo.U_EFUALOK401_Audit (audKey1Value, audKey2Value);

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFUALOK401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFUALOK401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhEmpDef     = SUM(CASE WHEN PdhDedCode IN ('401F', '401P', '401CF', '401CP') and  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRoth    = SUM(CASE WHEN PdhDedCode IN ('ROTHF', 'ROTHP', 'RTHCF', 'RTHCP')  and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)

        ,Pdh401L     = SUM(CASE WHEN PdhDedCode IN ('401L') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,Pdh401L2     = SUM(CASE WHEN PdhDedCode IN ('401L2') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,Pdh401M     = SUM(CASE WHEN PdhDedCode IN ('401M') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)

        ,PdhEmpDefYTD     = SUM(CASE WHEN PdhDedCode IN ('401F', '401P', '401CF', '401CP')  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRothYTD    = SUM(CASE WHEN PdhDedCode IN ('ROTHF', 'ROTHP', 'RTHCF', 'RTHCP')   THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhDedCalcBasisAmt = sum(CASE WHEN  PdhDedCode IN ('401F', '401P', '401CF', '401CP', 'ROTHF', 'ROTHP', 'RTHCF', 'RTHCP') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhDedCalcBasisAmt401k = sum(CASE WHEN  PdhDedCode IN ('401F', '401P', '401CF', '401CP') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhDedCalcBasisAmtROTH = sum(CASE WHEN  PdhDedCode IN ('ROTHF', 'ROTHP', 'RTHCF', 'RTHCP') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhDedCalcBasisAmt ELSE 0.00 END)

        ,PdhDedCalcBasisAmtYTD = sum(CASE WHEN  PdhDedCode IN ('401F', '401P', '401CF', '401CP', 'ROTHF', 'ROTHP', 'RTHCF', 'RTHCP') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhDedCalcBasisAmt401kYTD = sum(CASE WHEN  PdhDedCode IN ('401F', '401P', '401CF', '401CP')  THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhDedCalcBasisAmtROTHYTD = sum(CASE WHEN  PdhDedCode IN ('ROTHF', 'ROTHP', 'RTHCF', 'RTHCP')  THEN PdhDedCalcBasisAmt ELSE 0.00 END)

    INTO dbo.U_EFUALOK401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFUALOK401_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EFUALOK401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFUALOK401_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN   PehPerControl BETWEEN @StartPerControl AND @EndPerControl and PehEarnCode  <> 'HSAER' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtBonus          = SUM(CASE WHEN PehPerControl >= @StartPerControl and PehEarnCode in  ('BONUS') THEN PehCurAmt ELSE 0.00 END)
         
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        ,PrgNetAmt                 = SUM(CASE WHEN PehPerControl between @StartPerControl and @EndPerControl THEN PrgNetAmt ELSE 0.00 END)    
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,PrgNetAmtYTD                 = SUM(PrgNetAmt)
        ,PehInclInDefComp2 = SUM(CASE WHEN  PehPerControl BETWEEN @StartPerControl AND @EndPerControl THEN CASE WHEN PehEarnCode NOT IN('PTOO','SEV','GTL', 'HSAEE', 'HSARF', 'HSRSC')  THEN PehCurAmt ELSE 0.00  END END) 

        ,PehCurAmtBonusYTD          = SUM(CASE WHEN PehEarnCode in  ('BONUS') THEN PehCurAmt ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInPensionAccum = 'Y' AND PehEarnCode <> 'XMSBN' or PehEarnCode = 'TEMP' and  PehPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInPensionAccum = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehEarnCode NOT IN('PTOO','SEV','GTL', 'HSAEE', 'HSARF', 'HSRSC') THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInPensionAccum = 'Y' THEN PehCurHrs END)
        ,PehInclInDefCompAmtPensionYTD = SUM(CASE WHEN PehInclInPensionAccum = 'N' THEN PehCurAmt END) 
    INTO dbo.U_EFUALOK401_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    ---

      IF OBJECT_ID('U_EFUALOK401_PEarHistNet','U') IS NOT NULL
        DROP TABLE dbo.U_EFUALOK401_PEarHistNet;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PrgNetAmt                   

    INTO dbo.U_EFUALOK401_PEarHistNet
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID,PrgNetAmt
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFUALOK401_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EFUALOK401_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFUALOK401_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = EepNameMiddle
        ,drvLastName = EepNameLast
        ,drvSSN = eepSSN
        ,drvGender = EepGender
        ,drvEmployeeStatus = eecemplstatus
        ,drvMaritalStatus = eepMaritalStatus
        ,drvPayType = EecSalaryOrHourly
        ,drvAddress1 = QuoteName(EepAddressLine1,'"')
        ,drvAddress2 =  QuoteName(EepAddressLine2,'"') 
        ,drvCity = QuoteName(EepAddressCity,'"')  
        ,drvState = EepAddressState
        ,drvZip = eepaddresszipcode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvMobilePhone = (Select top 1 efoPhoneNumber from dbo.EmpMPhon where efoPhoneType = 'CEL')
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvBirthDate = EepDateOfBirth
        ,drvPersonalEmail = eepAddressEMailAlternate 
        ,drvWorkEmail = EepAddressEMail
        ,drvAnnualSalary = CAST(eecannsalary as varchar(12))
        ,drvEmployeeClass = EecFullTimeOrPartTime
        ,drvHireDate = eecdateoforiginalhire
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvCheckDate = dbo.dsi_fnGetMinMaxDates('MAX',PayDate, PrgPayDate)
        ,drvPayrollBeginDate = PrgPeriodStart
        ,drvPayrollEndDate = PrgPeriodEnd
        ,drvPayrollFrequency = EecPayPeriod
        ,drvGrossEarnings = CAST(CONVERT(DECIMAL(10,2),PehCurAmt) as varchar(12))
        ,drvPlanEarnings =  
        
        CAST(CONVERT(DECIMAL(10,2),CASE WHEN PdhDedCalcBasisAmt401k <> 0 and PdhDedCalcBasisAmtRoth <> 0 THEN CASE WHEN PdhDedCalcBasisAmt401k <> 0 THEN PdhDedCalcBasisAmt401k ELSE  PdhDedCalcBasisAmtRoth END  ELSE PdhDedCalcBasisAmt END ) as varchar(12)) 
        CAST(CONVERT(DECIMAL(10,2),CASE WHEN PdhDedCalcBasisAmt401k <> 0 and PdhDedCalcBasisAmtRoth <> 0 THEN CASE WHEN PdhDedCalcBasisAmt401k <> 0 THEN PdhDedCalcBasisAmt401k ELSE  PdhDedCalcBasisAmtRoth END  ELSE PdhDedCalcBasisAmt END ) as varchar(12)) 
        ,drvHoursWorked = CAST(CONVERT(DECIMAL(10,2),PehCurHrs) as varchar(12)) 
        ,drvNetPay = CAST(CONVERT(DECIMAL(10,2),(Select sum(PrgNetAmt)  from dbo.U_EFUALOK401_PEarHistNet   where peheeid = xeeid and prgPaydate = dbo.dsi_fnGetMinMaxDates('MAX',PayDate, PrgPayDate) ) ) as varchar(12))  
        ,drvBonusPay = CAST(CONVERT(DECIMAL(10,2),PehCurAmtBonus) as varchar(12)) 
        ,drvYTDGrossEarnings =  CAST(CONVERT(DECIMAL(10,2),PehCurAmtYTD) as varchar(12))  
        ,drvYTDPlanEarnings = CAST(CONVERT(DECIMAL(10,2),CASE WHEN PdhDedCalcBasisAmt401kYTD <> 0 and PdhDedCalcBasisAmtRothYTD <> 0 THEN CASE WHEN PdhDedCalcBasisAmt401kYTD > 0 THEN PdhDedCalcBasisAmt401kYTD ELSE  PdhDedCalcBasisAmtRothYTD END  ELSE PdhDedCalcBasisAmtYTD END ) as varchar(12)) 
        ,drvYTDHoursWorked =  CAST(CONVERT(DECIMAL(10,2),PehCurHrsYTD) as varchar(12))
        ,drvYTDNetPay = CAST(CONVERT(DECIMAL(10,2),(Select sum(PrgNetAmt)  from dbo.U_EFUALOK401_PEarHistNet   where peheeid = xeeid) ) as varchar(12)) 
        ,drvYTDBonusPay = CAST(CONVERT(DECIMAL(10,2),PehCurAmtBonusYTD) as varchar(12))
        ,drvYTDExcludedEarnings = CAST(CONVERT(DECIMAL(10,2),PehInclInDefCompAmtPensionYTD) as varchar(12)) 
        ,drvEmployeeDeferral =  CAST(CONVERT(DECIMAL(10,2),PdhEmpDef) as varchar(12))  
        ,drvEmployeeRoth = CAST(CONVERT(DECIMAL(10,2),PdhRoth) as varchar(12))  
        ,drvEmployerMatch = ''
        ,drvSafeHarborMatch = CAST(CONVERT(DECIMAL(10,2),Pdh401M) as varchar(12))   
        ,drvQualifiedMatching = ''
        ,drvSafeHarborNonElective = ''
        ,drvQualifiedNonElective = ''
        ,drvProfitSharing = ''
        ,drvLoanPayment1 = CASE WHEN Pdh401L > 0.00 THEN CAST(CONVERT(DECIMAL(10,2),Pdh401L) as varchar(12))    END
        ,drvLoanNumber1 = CASE WHEN Pdh401L > 0.00 THEN '401L' END
        ,drvLoanPayment2 =  CASE WHEN Pdh401L2 > 0.00 THEN CAST(CONVERT(DECIMAL(10,2),Pdh401L2) as varchar(12))    END
        ,drvLoanNumber2 = CASE WHEN Pdh401L2 > 0.00 THEN '401L2' END
        ,drvLoanPayment3 = ''
        ,drvLoanNumber3 = ''
        ,drvLoanPayment4 = ''
        ,drvLoanNumber4 = ''
        ,drvLoanPayment5 = ''
        ,drvLoanNumber5 = ''
        ,drvYTDEmployeeDeferral = CAST(CONVERT(DECIMAL(10,2),PdhEmpDefYTD) as varchar(12)) 
        ,drvYTDEmployeeRoth = CAST(CONVERT(DECIMAL(10,2),PdhRothYTD) as varchar(12))
        ,drvYTDEmployerMatch = ''
        ,drvYTDSafeHarborMatch = ''
        ,drvYTDQualifiedMatch = ''
        ,drvYTDSafeHarborNonElective = ''
        ,drvYTDQualNonElective = ''
        ,drvYTDProfitSharing = ''
        ,drvDivisionID = cmpcompanycode
    INTO dbo.U_EFUALOK401_drvTbl
    FROM dbo.U_EFUALOK401_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
            and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_EFUALOK401_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
        
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EFUALOK401_PEarHist WITH (NOLOCK)
        ON PehEEID =  xEEID
    LEFT JOIN U_EFUALOK401_PDedHist  WITH (NOLOCK)
        ON PdhEEID =  xEEID
    LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as PayrollDate
    on PayrollDate.PgpPayGroup =  eecPayGroup
     JOIN dbo.Company  WITH (NOLOCK)
        on cmpcoid = xcoid

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
ALTER VIEW dbo.dsi_vwEFUALOK401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFUALOK401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFUALOK401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202006101'
       ,expStartPerControl     = '202006101'
       ,expLastEndPerControl   = '202006179'
       ,expEndPerControl       = '202006179'
WHERE expFormatCode = 'EFUALOK401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFUALOK401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFUALOK401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort