SET NOCOUNT ON;
IF OBJECT_ID('U_EBETT401K_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBETT401K_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EBETT401K_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EBETT401K' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEBETT401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBETT401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBETT401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBETT401K];
GO
IF OBJECT_ID('U_EBETT401K_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBETT401K_PEarHist];
GO
IF OBJECT_ID('U_EBETT401K_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EBETT401K_PDedHist];
GO
IF OBJECT_ID('U_EBETT401K_File') IS NOT NULL DROP TABLE [dbo].[U_EBETT401K_File];
GO
IF OBJECT_ID('U_EBETT401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBETT401K_EEList];
GO
IF OBJECT_ID('U_EBETT401K_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBETT401K_drvTbl];
GO
IF OBJECT_ID('U_EBETT401K_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBETT401K_DedList];
GO
IF OBJECT_ID('U_EBETT401K_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBETT401K_AuditFields];
GO
IF OBJECT_ID('U_EBETT401K_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBETT401K_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EBETT401K';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EBETT401K';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EBETT401K';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EBETT401K';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EBETT401K';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBETT401K','Betterment 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EBETT401K0Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EBETT401K' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','1','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First name"','2','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','2',NULL,'First name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle name"','3','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','3',NULL,'Middle name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last name"','4','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','4',NULL,'Last name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 1"','5','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','5',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 2"','6','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','6',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','7','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','7',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','8','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','8',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','9','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','9',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email"','10','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone number"','11','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','11',NULL,'Phone number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of birth"','12','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','12',NULL,'Date of birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of hire"','13','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','13',NULL,'Date of hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of termination"','14','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','14',NULL,'Date of termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of rehire"','15','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','15',NULL,'Date of rehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gross Compensation"','16','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','16',NULL,'Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Eligible Compensation"','17','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','17',NULL,'Eligible Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours"','18','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','18',NULL,'Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pre-tax deferrals"','19','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','19',NULL,'Pre-tax deferrals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Roth deferrals"','20','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','20',NULL,'Roth deferrals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"After-Tax deferral"','21','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','21',NULL,'After-Tax deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Match"','22','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','22',NULL,'Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Safe Harbor Match"','23','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','23',NULL,'Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Safe Harbor Non-Elective"','24','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','24',NULL,'Safe Harbor Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Profit sharing"','25','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','25',NULL,'Profit sharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan payment"','26','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','26',NULL,'Loan payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Check Date"','27','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','27',NULL,'Check Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Begin Payroll Period"','28','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','28',NULL,'Begin Payroll Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"End Payroll Period"','29','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','29',NULL,'End Payroll Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee HSA"','30','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','30',NULL,'Employee HSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer HSA"','31','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','31',NULL,'Employer HSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Emploee HSA"','32','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','32',NULL,'YTD Emploee HSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Employer HSA"','33','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','33',NULL,'YTD Employer HSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Vacation Pay"','34','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','34',NULL,'YTD Vacation Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Sick Pay"','35','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','35',NULL,'YTD Sick Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Bereavement"','36','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','36',NULL,'YTD Bereavement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD 125 Plan"','37','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','37',NULL,'YTD 125 Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Overtime"','38','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','38',NULL,'YTD Overtime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Bonus"','39','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','39',NULL,'YTD Bonus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Commissions"','40','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','40',NULL,'YTD Commissions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Moving Expenses"','41','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','41',NULL,'YTD Moving Expenses',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Taxable Auto Allowances"','42','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','42',NULL,'YTD Taxable Auto Allowances',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Other Fringe Benefits"','43','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','43',NULL,'YTD Other Fringe Benefits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Tips"','44','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','44',NULL,'YTD Tips',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Post Severance Comp"','45','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','45',NULL,'YTD Post Severance Comp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Deferred Compensation"','46','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','46',NULL,'YTD Deferred Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Gross Compensation"','47','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','47',NULL,'YTD Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Eligible Compensation"','48','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','48',NULL,'YTD Eligible Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Hours"','49','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','49',NULL,'YTD Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Pre-tax deferrals"','50','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','50',NULL,'YTD Pre-tax deferrals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Roth deferrals"','51','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','51',NULL,'YTD Roth deferrals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD After-Tax deferral"','52','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','52',NULL,'YTD After-Tax deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Match"','53','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','53',NULL,'YTD Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Safe Harbor Match"','54','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','54',NULL,'YTD Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Safe Harbor Non-Elective"','55','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','55',NULL,'YTD Safe Harbor Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Profit sharing"','56','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','56',NULL,'YTD Profit sharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Loan payment"','57','(''DA''=''T,'')','EBETT401K0Z0','50','H','01','57',NULL,'YTD Loan payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','58','(''DA''=''T'')','EBETT401K0Z0','50','H','01','58',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstname"','2','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','2',NULL,'First name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddlename"','3','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','3',NULL,'Middle name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastname"','4','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','4',NULL,'Last name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','5','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','5',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','6','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','6',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','7','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','7',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','8','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','8',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','9','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','9',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','10','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhonenumber"','11','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','11',NULL,'Phone number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofbirth"','12','(''UD101''=''T,'')','EBETT401K0Z0','50','D','10','12',NULL,'Date of birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofhire"','13','(''UD101''=''T,'')','EBETT401K0Z0','50','D','10','13',NULL,'Date of hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateoftermination"','14','(''UD101''=''T,'')','EBETT401K0Z0','50','D','10','14',NULL,'Date of termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofrehire"','15','(''UD101''=''T,'')','EBETT401K0Z0','50','D','10','15',NULL,'Date of rehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrossCompensation"','16','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','16',NULL,'Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibleCompensation"','17','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','17',NULL,'Eligible Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHours"','18','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','18',NULL,'Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPretaxdeferrals"','19','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','19',NULL,'Pre-tax deferrals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRothdeferrals"','20','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','20',NULL,'Roth deferrals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAfterTaxdeferral"','21','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','21',NULL,'After-Tax deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMatch"','22','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','22',NULL,'Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSafeHarborMatch"','23','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','23',NULL,'Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSafeHarborNonElective"','24','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','24',NULL,'Safe Harbor Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProfitsharing"','25','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','25',NULL,'Profit sharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanpayment"','26','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','26',NULL,'Loan payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','27','(''UD101''=''T,'')','EBETT401K0Z0','50','D','10','27',NULL,'Check Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeginPayrollPeriod"','28','(''UD101''=''T,'')','EBETT401K0Z0','50','D','10','28',NULL,'Begin Payroll Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndPayrollPeriod"','29','(''UD101''=''T,'')','EBETT401K0Z0','50','D','10','29',NULL,'End Payroll Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeHSA"','30','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','30',NULL,'Employee HSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerHSA"','31','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','31',NULL,'Employer HSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDEmploeeHSA"','32','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','32',NULL,'YTD Emploee HSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDEmployerHSA"','33','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','33',NULL,'YTD Employer HSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDVacationPay"','34','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','34',NULL,'YTD Vacation Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDSickPay"','35','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','35',NULL,'YTD Sick Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDBereavement"','36','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','36',NULL,'YTD Bereavement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTD125Plan"','37','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','37',NULL,'YTD 125 Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDOvertime"','38','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','38',NULL,'YTD Overtime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDBonus"','39','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','39',NULL,'YTD Bonus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDCommissions"','40','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','40',NULL,'YTD Commissions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDMovingExpenses"','41','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','41',NULL,'YTD Moving Expenses',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTaxableAutoAllowances"','42','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','42',NULL,'YTD Taxable Auto Allowances',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDOtherFringeBenefits"','43','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','43',NULL,'YTD Other Fringe Benefits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTips"','44','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','44',NULL,'YTD Tips',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPostSeveranceComp"','45','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','45',NULL,'YTD Post Severance Comp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDDeferredCompensation"','46','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','46',NULL,'YTD Deferred Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDGrossCompensation"','47','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','47',NULL,'YTD Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDEligibleCompensation"','48','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','48',NULL,'YTD Eligible Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDHours"','49','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','49',NULL,'YTD Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPretaxdeferrals"','50','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','50',NULL,'YTD Pre-tax deferrals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDRothdeferrals"','51','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','51',NULL,'YTD Roth deferrals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDAfterTaxdeferral"','52','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','52',NULL,'YTD After-Tax deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDMatch"','53','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','53',NULL,'YTD Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDSafeHarborMatch"','54','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','54',NULL,'YTD Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDSafeHarborNonElective"','55','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','55',NULL,'YTD Safe Harbor Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDProfitsharing"','56','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','56',NULL,'YTD Profit sharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDLoanpayment"','57','(''UA''=''T,'')','EBETT401K0Z0','50','D','10','57',NULL,'YTD Loan payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatus"','58','(''UA''=''T'')','EBETT401K0Z0','50','D','10','58',NULL,'Employment Status',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EBETT401K_20210714.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Betterment 401K Export','202101289','EMPEXPORT','ONDEM_XOE',NULL,'EBETT401K',NULL,NULL,NULL,'202101289','Jan 28 2021 11:18AM','Jan 28 2021 11:18AM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Betterment 401K Export-Sched','202101289','EMPEXPORT','SCH_EBETT4',NULL,'EBETT401K',NULL,NULL,NULL,'202101289','Jan 28 2021 11:18AM','Jan 28 2021 11:18AM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','BI1HN,H3M21,NZJU7,H3MBW',NULL,NULL,NULL,'Betterment 401K Export-Test','202107091','EMPEXPORT','TEST_XOE','Jul 13 2021  2:30PM','EBETT401K',NULL,NULL,NULL,'202107091','Jul  9 2021 12:00AM','Jul  2 2021 12:00AM','202107091','165','eecPayGroup','SALARY','202107091',dbo.fn_GetTimedKey(),NULL,'us3cPeCOM1072',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBETT401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBETT401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBETT401K','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBETT401K','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBETT401K','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EBETT401K' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EBETT401K' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EBETT401K_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBETT401K_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBETT401K','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBETT401K','D10','dbo.U_EBETT401K_drvTbl',NULL);
IF OBJECT_ID('U_EBETT401K_Audit') IS NULL
CREATE TABLE [dbo].[U_EBETT401K_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EBETT401K_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBETT401K_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EBETT401K_DedList') IS NULL
CREATE TABLE [dbo].[U_EBETT401K_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EBETT401K_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBETT401K_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(11) NULL,
    [drvSSN] char(11) NULL,
    [drvFirstname] varchar(8000) NULL,
    [drvMiddlename] varchar(6000) NULL,
    [drvLastname] varchar(6000) NULL,
    [drvAddress1] varchar(8000) NULL,
    [drvAddress2] varchar(8000) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhonenumber] varchar(50) NULL,
    [drvDateofbirth] datetime NULL,
    [drvDateofhire] datetime NULL,
    [drvDateoftermination] datetime NULL,
    [drvDateofrehire] datetime NULL,
    [drvGrossCompensation] varchar(30) NULL,
    [drvEligibleCompensation] varchar(30) NULL,
    [drvHours] varchar(30) NULL,
    [drvPretaxdeferrals] varchar(30) NULL,
    [drvRothdeferrals] varchar(30) NULL,
    [drvAfterTaxdeferral] varchar(1) NOT NULL,
    [drvMatch] varchar(1) NOT NULL,
    [drvSafeHarborMatch] varchar(1) NOT NULL,
    [drvSafeHarborNonElective] varchar(1) NOT NULL,
    [drvProfitsharing] varchar(1) NOT NULL,
    [drvLoanpayment] varchar(30) NULL,
    [drvCheckDate] varchar(30) NULL,
    [drvBeginPayrollPeriod] datetime NULL,
    [drvEndPayrollPeriod] datetime NULL,
    [drvEmployeeHSA] varchar(1) NOT NULL,
    [drvEmployerHSA] varchar(1) NOT NULL,
    [drvYTDEmploeeHSA] varchar(1) NOT NULL,
    [drvYTDEmployerHSA] varchar(1) NOT NULL,
    [drvYTDVacationPay] varchar(30) NULL,
    [drvYTDSickPay] varchar(30) NULL,
    [drvYTDBereavement] varchar(30) NULL,
    [drvYTD125Plan] varchar(1) NOT NULL,
    [drvYTDOvertime] varchar(30) NULL,
    [drvYTDBonus] varchar(30) NULL,
    [drvYTDCommissions] varchar(30) NULL,
    [drvYTDMovingExpenses] varchar(30) NULL,
    [drvYTDTaxableAutoAllowances] varchar(1) NOT NULL,
    [drvYTDOtherFringeBenefits] varchar(1) NOT NULL,
    [drvYTDTips] varchar(1) NOT NULL,
    [drvYTDPostSeveranceComp] varchar(30) NULL,
    [drvYTDDeferredCompensation] varchar(30) NULL,
    [drvYTDGrossCompensation] varchar(30) NULL,
    [drvYTDEligibleCompensation] varchar(30) NULL,
    [drvYTDHours] varchar(30) NULL,
    [drvYTDPretaxdeferrals] varchar(30) NULL,
    [drvYTDRothdeferrals] varchar(30) NULL,
    [drvYTDAfterTaxdeferral] varchar(1) NOT NULL,
    [drvYTDMatch] varchar(1) NOT NULL,
    [drvYTDSafeHarborMatch] varchar(1) NOT NULL,
    [drvYTDSafeHarborNonElective] varchar(1) NOT NULL,
    [drvYTDProfitsharing] varchar(1) NOT NULL,
    [drvYTDLoanpayment] varchar(30) NULL,
    [drvEmpStatus] varchar(1) NULL,
    [drvPdhEECurAmt] numeric NOT NULL
);
IF OBJECT_ID('U_EBETT401K_EEList') IS NULL
CREATE TABLE [dbo].[U_EBETT401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EBETT401K_File') IS NULL
CREATE TABLE [dbo].[U_EBETT401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EBETT401K_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EBETT401K_PDedHist] (
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
    [PdhSource10] numeric NULL,
    [pdhCurAmt_Pretax_Def] numeric NULL,
    [pdhCurAmt_Roth_Def] numeric NULL,
    [pdhCurAmt_Loan_pmt] numeric NULL
);
IF OBJECT_ID('U_EBETT401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBETT401K_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPeriodStartDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL,
    [prgpaygroup] char(6) NOT NULL,
    [PehCurAmt] numeric NULL,
    [PehCurAmt_PTO] numeric NULL,
    [PehCurAmt_Sick] numeric NULL,
    [PehCurAmt_Berev] numeric NULL,
    [pehCurAmt_ExclBonus] numeric NULL,
    [pehCurAmt_OT] numeric NULL,
    [pehCurAmt_Bonus] numeric NULL,
    [pehCurAmt_Mov] numeric NULL,
    [pehCurAmt_COM] numeric NULL,
    [pehCurAmt_SEV] numeric NULL,
    [pehCurAmt_DEF_COMP] numeric NULL,
    [phCurAmt_Pretax_Def] numeric NULL,
    [pehCurAmt_GROSS_COMP] money NULL,
    [pehCurAmt_ELIG_COMP] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] numeric NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] numeric NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBETT401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Common Living Inc

Created By: Inshan Singh
Business Analyst: Cheryl Petiti
Create Date: 01/28/2021
Service Request Number: TekP-2020-12-08-0004

Purpose: Betterment 401K Export

Revision History
----------------
06/17/2021 by AP:
        - Updated logic for check date, period start and period end.
        - Added DELETE statement to remove termed employees with no contributions.

07/14/2021 by AP:
		- DELETE statement commented out as vendor wants to see users with 0 contributions who are termed.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBETT401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBETT401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBETT401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBETT401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBETT401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBETT401K', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBETT401K', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBETT401K', 'SCH_EBETT4';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBETT401K', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBETT401K';

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
    DELETE FROM dbo.U_EBETT401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBETT401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBETT401K_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBETT401K_AuditFields;
    CREATE TABLE dbo.U_EBETT401K_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EBETT401K_AuditFields VALUES ('Empcomp','EecEmplStatus')

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBETT401K_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBETT401K_Audit;
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
    INTO dbo.U_EBETT401K_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBETT401K_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(D, -45, @EndDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBETT401K_Audit ON dbo.U_EBETT401K_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EBETT401K_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EBETT401K_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401F,401P,401RF,401RP,401L,401L2';

    IF OBJECT_ID('U_EBETT401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBETT401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBETT401K_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EBETT401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBETT401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401F', '401P') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('401RF', '401RP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('401L','401L2') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,pdhCurAmt_Pretax_Def   = SUM(CASE WHEN PdhDedCode IN ('401F','401P') THEN PdhEECurAmt ELSE 0.00 END)
        ,pdhCurAmt_Roth_Def     = SUM(CASE WHEN PdhDedCode IN ('401RF','401RP') THEN PdhEECurAmt ELSE 0.00 END)
        ,pdhCurAmt_Loan_pmt = SUM(CASE WHEN PdhDedCode IN ('401L','401L2') THEN PdhEECurAmt ELSE 0.00 END) 
    INTO dbo.U_EBETT401K_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EBETT401K_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl AND pdhDedCode in ('401F','401P','401RF','401RP','401L','401L2')
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EBETT401K_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBETT401K_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgPeriodStartDate     = MIN(PrgPeriodStartDate)
        ,PrgPeriodEndDate       = MAX(PrgPeriodEndDate)
        ,prgpaygroup            = prgpaygroup
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmt_PTO          = SUM(CASE WHEN PehEarnCode IN ('PTO') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmt_Sick         = SUM(CASE WHEN PehEarnCode IN ('SICK','3PS') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmt_Berev        = SUM(CASE WHEN PehEarnCode IN ('BEREV') THEN PehCurAmt ELSE 0.00 END)
        ,pehCurAmt_ExclBonus    = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEarnCode NOT IN ('SEV', 'COMM', 'BONUS', 'DBNS', 'INBNS', 'NDBNS', 'SOBON') THEN PehCurAmt ELSE 0.00 END)
        ,pehCurAmt_OT            = SUM(CASE WHEN PehEarnCode IN ('OT','OTC') THEN PehCurAmt ELSE 0.00 END)
        ,pehCurAmt_Bonus         = SUM(CASE WHEN PehEarnCode IN ('SEV', 'COMM', 'BONUS', 'DBNS', 'INBNS', 'NDBNS', 'SOBON') THEN PehCurAmt ELSE 0.00 END)
        ,pehCurAmt_Mov            = SUM(CASE WHEN PehEarnCode IN ('TREXL') THEN PehCurAmt ELSE 0.00 END)
        ,pehCurAmt_COM            = SUM(CASE WHEN PehEarnCode IN ('COMM') THEN PehCurAmt ELSE 0.00 END)
        ,pehCurAmt_SEV            = SUM(CASE WHEN PehEarnCode IN ('SEV') THEN PehCurAmt ELSE 0.00 END)
        ,pehCurAmt_DEF_COMP     = SUM(CASE WHEN PehEarnCode IN ('HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAER') THEN PehCurAmt ELSE 0.00 END)
        ,phCurAmt_Pretax_Def   = SUM(CASE WHEN PehEarnCode IN ('401F','401P') THEN PehCurAmt ELSE 0.00 END)
        ,pehCurAmt_GROSS_COMP   = SUM(PehCurAmt)
        ,pehCurAmt_ELIG_COMP    = SUM(CASE WHEN PehEarnCode NOT IN ('SEV', 'COMM', 'BONUS', 'DBNS', 'INBNS', 'NDBNS', 'SOBON') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt ELSE 0.00 END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EBETT401K_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl and PehEarnCode not in ('GTL')
    GROUP BY PehEEID,PrgPayGroup
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBETT401K_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBETT401K_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBETT401K_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EepSSN
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvFirstname = REPLACE(dbo.dsi_fnremovechars(',-#.''’', EepNameFirst), 'é', 'e')
        ,drvMiddlename = dbo.dsi_fnremovechars(',-#.''’', LEFT(EepNameMiddle, 1))
        ,drvLastname = dbo.dsi_fnremovechars(',-#.''’', EepNameLast)
        ,drvAddress1 = [dbo].[fn_AddDoubleQuotes] (EepAddressLine1)
        ,drvAddress2 = [dbo].[fn_AddDoubleQuotes] (EepAddressLine2)
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvEmail = EepAddressEMail
        ,drvPhonenumber = EepPhoneHomeNumber
        ,drvDateofbirth = EepDateOfBirth
        ,drvDateofhire = EecDateOfOriginalHire
        ,drvDateoftermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDateofrehire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire ELSE NULL END
        ,drvGrossCompensation = CASE WHEN  pehCurAmt = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pehCurAmt)) END
        ,drvEligibleCompensation = CASE WHEN  pehCurAmt = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pehCurAmt)) END -- feeback to change to all earn codes--CASE WHEN  pehCurAmt_ExclBonus = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pehCurAmt_ExclBonus))END
        ,drvHours =  CONVERT(VARCHAR, CONVERT(DECIMAL(10,0), PehCurHrs)) 
        ,drvPretaxdeferrals = CASE WHEN  PdhSource1 IS NULL THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, PdhSource1)) END
        ,drvRothdeferrals = CASE WHEN  PdhSource2  IS NULL THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, PdhSource2)) END
        ,drvAfterTaxdeferral = '' -- leave blank 
        ,drvMatch = '' -- leave blank 
        ,drvSafeHarborMatch = '' -- leave blank 
        ,drvSafeHarborNonElective = '' -- leave blank 
        ,drvProfitsharing = '' -- leave blank 
        ,drvLoanpayment =  CASE WHEN  PdhSource3  IS NULL THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, PdhSource3)) END
        ,drvCheckDate =  CONVERT(VARCHAR, (CAST(PayGrp.PayDate AS DATE)), 101)
        --CASE WHEN PrgPayDate is null THEN (SELECT top 1 prgPaydate from dbo.payreg with (nolock) where prgPaydate between @startdate and @enddate and prgpaygroup = 'SALARY') 
                                  --  ELSE dbo.dsi_fnGetMinMaxDates('MAX',PrgPayDate, (SELECT top 1 prgPaydate from dbo.payreg with (nolock) where prgPaydate between @startdate and @enddate and prgpaygroup = 'SALARY') )  
                                --END  --PrgPayDate
        ,drvBeginPayrollPeriod = PayGrp.PrgPeriodStart
        --CASE WHEN PrgPeriodStartDate is null THEN (SELECT top 1  from dbo.payreg with (nolock) where prgPercontrol between @startpercontrol and @endpercontrol and prgpaygroup = 'SALARY') 
                                   -- ELSE dbo.dsi_fnGetMinMaxDates('MAX',PrgPeriodStartDate, (SELECT top 1 PrgPeriodStartDate from dbo.payreg with (nolock) where prgPercontrol between @startpercontrol and @endpercontrol and prgpaygroup = 'SALARY') )  
                               -- END --PrgPeriodStartDate
        ,drvEndPayrollPeriod = PayGrp.PrgPeriodEnd
        --CASE WHEN PrgPeriodEndDate is null THEN (SELECT top 1 PrgPeriodEndDate from dbo.payreg with (nolock) where prgPercontrol between @startpercontrol and @endpercontrol and prgpaygroup = 'SALARY') 
                                   -- ELSE dbo.dsi_fnGetMinMaxDates('MAX',PrgPeriodEndDate, (SELECT top 1 PrgPeriodEndDate from dbo.payreg with (nolock) where prgPercontrol between @startpercontrol and @endpercontrol and prgpaygroup = 'SALARY') )  
                               -- END--PrgPeriodEndDate
        ,drvEmployeeHSA = '' -- leave blank 
        ,drvEmployerHSA = '' -- leave blank 
        ,drvYTDEmploeeHSA = '' -- leave blank 
        ,drvYTDEmployerHSA = '' -- leave blank 
        ,drvYTDVacationPay = CASE WHEN  pehCurAmt_PTO = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pehCurAmt_PTO)) END 
        ,drvYTDSickPay = CASE WHEN  PehCurAmt_Sick = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, PehCurAmt_Sick)) END
        ,drvYTDBereavement = CASE WHEN  PehCurAmt_Berev = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, PehCurAmt_Berev)) END
        ,drvYTD125Plan = '' -- leave blank
        ,drvYTDOvertime = CASE WHEN  PehCurAmt_OT = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, PehCurAmt_OT)) END
        ,drvYTDBonus = CASE WHEN  pehCurAmt_Bonus = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pehCurAmt_Bonus)) END
        ,drvYTDCommissions = CASE WHEN  pehCurAmt_COM = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pehCurAmt_COM)) END
        ,drvYTDMovingExpenses = CASE WHEN  pehCurAmt_Mov = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pehCurAmt_Mov)) END
        ,drvYTDTaxableAutoAllowances = '' -- leave blank
        ,drvYTDOtherFringeBenefits = '' -- leave blank
        ,drvYTDTips = '' -- leave blank
        ,drvYTDPostSeveranceComp = CASE WHEN  pehCurAmt_SEV = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pehCurAmt_SEV)) END
        ,drvYTDDeferredCompensation = CASE WHEN  pehCurAmt_DEF_COMP = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pehCurAmt_DEF_COMP)) END 
        ,drvYTDGrossCompensation = CASE WHEN  pehCurAmt_GROSS_COMP = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pehCurAmt_GROSS_COMP)) END
        ,drvYTDEligibleCompensation = CASE WHEN  pehCurAmt_GROSS_COMP = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pehCurAmt_GROSS_COMP)) END -- feedback to use same logic as gross compensation-- CASE WHEN  pehCurAmt_ELIG_COMP = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pehCurAmt_ELIG_COMP)) END 
        ,drvYTDHours = CONVERT(VARCHAR, CONVERT(DECIMAL (10,0), PehCurHrsYTD))
        ,drvYTDPretaxdeferrals = CASE WHEN  pdhCurAmt_Pretax_Def = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pdhCurAmt_Pretax_Def)) END
        ,drvYTDRothdeferrals = CASE WHEN  pdhCurAmt_Roth_Def = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pdhCurAmt_Roth_Def)) END
        ,drvYTDAfterTaxdeferral = '' -- leave blank
        ,drvYTDMatch = '' -- leave blank
        ,drvYTDSafeHarborMatch = '' -- leave blank
        ,drvYTDSafeHarborNonElective = '' -- leave blank
        ,drvYTDProfitsharing = '' -- leave blank
        ,drvYTDLoanpayment = CASE WHEN  pdhCurAmt_Loan_pmt = 0.00 THEN '0.00' ELSE  CONVERT(VARCHAR, CONVERT(MONEY, pdhCurAmt_Loan_pmt)) END
        ,drvEmpStatus = CASE
                            WHEN EecEmplStatus IN ('A', 'L') THEN 'A'
                            WHEN  EecEmplStatus = 'T' THEN 'T'
                            WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN 'C'
                            WHEN EecEmplStatus = 'T' and EecTermReason = '202' THEN 'R'
                        END
        ,drvPdhEECurAmt = ISNULL(PdhEECurAmt, '0.00') -- To check if there is a contribution for DELETE statement below.
    INTO dbo.U_EBETT401K_drvTbl
    FROM dbo.U_EBETT401K_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID and EecEEType NOT IN ('TES','Z') and  @enddate > eecdateoflasthire 
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EBETT401K_PEarHist WITH (NOLOCK)
        ON pehEEID = xEEID and prgPaygroup in (SELECT expSelectByList FROM dbo.AscExp WITH (NOLOCK) WHERE expFormatCode = @FormatCode and expSelectByField = 'eecPayGroup')  
    LEFT JOIN (SELECT PgpPayGroup as Paygroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   --AND PgpPeriodType = 'R'
                   GROUP BY PgpPayGroup) PayGrp
    On PayGrp.Paygroup = eecpaygroup
    LEFT JOIN U_EBETT401K_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
   left JOIN dbo.U_EBETT401K_Audit with (nolock)
        ON audeeid = xEEID and audKey2 = xCOID
        where eecemplstatus in ('A', 'L')  or ((eecemplstatus in ('T') and eecTermReason <> 'TRO' and eecDateofTermination between (DATEADD( D,-45, @enddate)) and @enddate) 
           or ( eecemplstatus = 'T' and (PdhSource1 <> 0.00 or PdhSource3 <> 0.00 or PdhSource2 <> 0.00))
        )
   --left JOIN dbo.U_EBETT401K_Audit with (nolock)
   --     ON audeeid = xEEID and audKey2 = xCOID
   --     where eecemplstatus in ('A', 'L')  or eecemplstatus in ('T') and eecTermReason <> 'TRO' and eecDateofTermination between (DATEADD( D,-45, @enddate)) and @enddate
    ;

    -- Remove any termed employees that don't have a contribution
    --DELETE dbo.U_EBETT401K_drvTbl
    --WHERE drvEmpStatus = 'T' 
    --AND drvPdhEECurAmt = '0.00' 

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
ALTER VIEW dbo.dsi_vwEBETT401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBETT401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBETT401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101011'
       ,expStartPerControl     = '202101011'
       ,expLastEndPerControl   = '202101289'
       ,expEndPerControl       = '202101289'
WHERE expFormatCode = 'EBETT401K';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBETT401K_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBETT401K_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort