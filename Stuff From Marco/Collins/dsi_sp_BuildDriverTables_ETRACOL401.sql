SET NOCOUNT ON;
IF OBJECT_ID('U_ETRACOL401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRACOL401_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETRACOL401_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETRACOL401' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETRACOL401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETRACOL401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETRACOL401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRACOL401];
GO
IF OBJECT_ID('U_ETRACOL401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETRACOL401_PEarHist];
GO
IF OBJECT_ID('U_ETRACOL401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETRACOL401_PDedHist];
GO
IF OBJECT_ID('U_ETRACOL401_File') IS NOT NULL DROP TABLE [dbo].[U_ETRACOL401_File];
GO
IF OBJECT_ID('U_ETRACOL401_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETRACOL401_EEList];
GO
IF OBJECT_ID('U_ETRACOL401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETRACOL401_drvTbl];
GO
IF OBJECT_ID('U_ETRACOL401_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETRACOL401_DedList];
GO
IF OBJECT_ID('U_ETRACOL401_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ETRACOL401_AuditFields];
GO
IF OBJECT_ID('U_ETRACOL401_Audit') IS NOT NULL DROP TABLE [dbo].[U_ETRACOL401_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ETRACOL401') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETRACOL401];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETRACOL401';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETRACOL401';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETRACOL401';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETRACOL401';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETRACOL401';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETRACOL401','TransAmerica 401k Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ETRACOL401Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETRACOL401' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account Number"','1','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','1',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number"','2','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','2',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','3','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','3',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Division/Location Code"','4','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','4',NULL,'Employee Division/Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Class Code"','5','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','5',NULL,'Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Last Name"','6','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','6',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Last Name Suffix"','7','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','7',NULL,'Employee Last Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee First Name"','8','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','8',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Middle Initial"','9','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','9',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Birth Date"','10','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','10',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date"','11','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','11',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Adjusted Service Date"','12','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','12',NULL,'Adjusted Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','13','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','13',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','14','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','14',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Street Address Line 1"','15','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','15',NULL,'Street Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Street Address Line 2"','16','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','16',NULL,'Street Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City Name"','17','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','17',NULL,'City Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State Code"','18','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','18',NULL,'State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code"','19','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','19',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E-mail address"','20','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','20',NULL,'E-mail address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Daytime/Work Phone Number"','21','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','21',NULL,'Daytime/Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Evening/Home Phone Number"','22','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','22',NULL,'Evening/Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mobile Phone Number"','23','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','23',NULL,'Mobile Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Single Sign On Eligibility Code"','24','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','24',NULL,'Single Sign On Eligibility Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Single Sign On Id"','25','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','25',NULL,'Single Sign On Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status Code"','26','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','26',NULL,'Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Payroll Frequency"','27','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','27',NULL,'Employee Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','28','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','28',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Highly Comp Code"','29','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','29',NULL,'Employee Highly Comp Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Insider Investor Code"','30','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','30',NULL,'Insider Investor Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Expected Year of Service "','31','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','31',NULL,'Expected Year of Service',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Language Code"','32','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','32',NULL,'Language Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Reason Code"','33','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','33',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Hours Paid"','34','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','34',NULL,'Current Hours Paid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Non-elective Contribution amount"','35','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','35',NULL,'Employer Non-elective Contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee After-tax Contribution amount"','36','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','36',NULL,'Employee After-tax Contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Pre Tax contribution amount"','37','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','37',NULL,'Employee Pre Tax contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Roth contribution amount"','38','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','38',NULL,'Employee Roth contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Match contribution amount "','39','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','39',NULL,'Employer Match contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Safe Harbor Match Contribution amount"','40','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','40',NULL,'Employer Safe Harbor Match Contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Loan Repayment"','41','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','41',NULL,'Employee Loan Repayment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Source 1 Contribution Amount"','42','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','42',NULL,'Additional Source 1 Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Source 2 Contribution Amount"','43','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','43',NULL,'Additional Source 2 Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Gross Compensation"','44','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','44',NULL,'Current Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Plan Compensation"','45','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','45',NULL,'Current Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Compensation_1"','46','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','46',NULL,'Additional Compensation_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Compensation_2"','47','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','47',NULL,'Additional Compensation_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Period Start Date"','48','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','48',NULL,'Payroll Period Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Period End Date"','49','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','49',NULL,'Payroll Period End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Paycheck Date"','50','(''DA''=''T|'')','ETRACOL401Z0','50','H','01','50',NULL,'Paycheck Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department"','51','(''DA''=''T'')','ETRACOL401Z0','50','H','01','51',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountNumber"','1','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','1',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSocialSecurityNumber"','2','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','2',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','3','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','3',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDivLocationCode"','4','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','4',NULL,'Employee Division/Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCode"','5','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','5',NULL,'Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLastName"','6','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','6',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLastNameSuffix"','7','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','7',NULL,'Employee Last Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeFirstName"','8','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','8',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMiddleInitial"','9','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','9',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','10','(''UD101''=''T|'')','ETRACOL401Z0','50','D','10','10',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','11','(''UD101''=''T|'')','ETRACOL401Z0','50','D','10','11',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjustedServiceDate"','12','(''UD101''=''T|'')','ETRACOL401Z0','50','D','10','12',NULL,'Adjusted Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','13','(''UD101''=''T|'')','ETRACOL401Z0','50','D','10','13',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','14','(''UD101''=''T|'')','ETRACOL401Z0','50','D','10','14',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStreetAddressLine1"','15','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','15',NULL,'Street Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStreetAddressLine2"','16','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','16',NULL,'Street Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCityName"','17','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','17',NULL,'City Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateCode"','18','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','18',NULL,'State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','19','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','19',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailaddress"','20','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','20',NULL,'E-mail address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDaytimeWorkPhoneNumber"','21','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','21',NULL,'Daytime/Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEveningHomePhoneNumber"','22','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','22',NULL,'Evening/Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMobilePhoneNumber"','23','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','23',NULL,'Mobile Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSOEligibilityCode"','24','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','24',NULL,'Single Sign On Eligibility Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSingleSignOnId"','25','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','25',NULL,'Single Sign On Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatusCode"','26','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','26',NULL,'Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePayrollFrequency"','27','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','27',NULL,'Employee Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','28','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','28',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeHighlyCompCode"','29','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','29',NULL,'Employee Highly Comp Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsiderInvestorCode"','30','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','30',NULL,'Insider Investor Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExpectedYearofService"','31','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','31',NULL,'Expected Year of Service',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguageCode"','32','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','32',NULL,'Language Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReasonCode"','33','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','33',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentHoursPaid"','34','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','34',NULL,'Current Hours Paid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerNonelectiveContAmt"','35','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','35',NULL,'Employer Non-elective Contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeAftertaxContAmt"','36','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','36',NULL,'Employee After-tax Contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePreTaxContAmt"','37','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','37',NULL,'Employee Pre Tax contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeRothContAmt"','38','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','38',NULL,'Employee Roth contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerMatchContAmt"','39','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','39',NULL,'Employer Match contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerSafeHarborContAmt"','40','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','40',NULL,'Employer Safe Harbor Match Contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLoanRepayment"','41','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','41',NULL,'Employee Loan Repayment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalSource1ContAmt"','42','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','42',NULL,'Additional Source 1 Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalSource2ContAmt"','43','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','43',NULL,'Additional Source 2 Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentGrossCompensation"','44','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','44',NULL,'Current Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentPlanCompensation"','45','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','45',NULL,'Current Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalCompensation1"','46','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','46',NULL,'Additional Compensation_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalCompensation2"','47','(''UA''=''T|'')','ETRACOL401Z0','50','D','10','47',NULL,'Additional Compensation_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollPeriodStartDate"','48','(''UD101''=''T|'')','ETRACOL401Z0','50','D','10','48',NULL,'Payroll Period Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollPeriodEndDate"','49','(''UD101''=''T|'')','ETRACOL401Z0','50','D','10','49',NULL,'Payroll Period End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPaycheckDate"','50','(''UD101''=''T|'')','ETRACOL401Z0','50','D','10','50',NULL,'Paycheck Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartment"','51','(''UA''=''T'')','ETRACOL401Z0','50','D','10','51',NULL,'Department',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ETRACOL401_20210407.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202103269','EMPEXPORT','OEACTIVE','Mar 30 2021 12:00AM','ETRACOL401',NULL,NULL,NULL,'202103269','Mar 26 2021 12:00AM','Dec 30 1899 12:00AM','202103261',NULL,'','','202103261',dbo.fn_GetTimedKey(),NULL,'MLAGROSA14',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202103299','EMPEXPORT','OEPASSIVE','Mar 30 2021 12:00AM','ETRACOL401',NULL,NULL,NULL,'202103299','Mar 29 2021 12:00AM','Dec 30 1899 12:00AM','202103291',NULL,'','','202103291',dbo.fn_GetTimedKey(),NULL,'MLAGROSA14',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TransAmerica 401k Export','202103299','EMPEXPORT','ONDEM_XOE','Mar 30 2021 12:00AM','ETRACOL401',NULL,NULL,NULL,'202103299','Mar 29 2021 12:00AM','Dec 30 1899 12:00AM','202103291',NULL,'','','202103291',dbo.fn_GetTimedKey(),NULL,'MLAGROSA14',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TransAmerica 401k Export-Sched','202103299','EMPEXPORT','SCH_ETRACO','Mar 30 2021 12:00AM','ETRACOL401',NULL,NULL,NULL,'202103299','Mar 29 2021 12:00AM','Dec 30 1899 12:00AM','202103291',NULL,'','','202103291',dbo.fn_GetTimedKey(),NULL,'MLAGROSA14',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'TransAmerica 401k Export-Test','202103319','EMPEXPORT','TEST_XOE','Apr  1 2021 10:00PM','ETRACOL401',NULL,NULL,NULL,'202103319','Mar 31 2021 12:00AM','Dec 30 1899 12:00AM','202103311','30','eecPayGroup','KLTHSL','202103311',dbo.fn_GetTimedKey(),NULL,'CPETTITTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRACOL401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRACOL401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRACOL401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRACOL401','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRACOL401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRACOL401','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ETRACOL401' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ETRACOL401' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ETRACOL401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRACOL401_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRACOL401','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRACOL401','D10','dbo.U_ETRACOL401_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ETRACOL401') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETRACOL401] (
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
IF OBJECT_ID('U_ETRACOL401_Audit') IS NULL
CREATE TABLE [dbo].[U_ETRACOL401_Audit] (
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
IF OBJECT_ID('U_ETRACOL401_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ETRACOL401_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ETRACOL401_DedList') IS NULL
CREATE TABLE [dbo].[U_ETRACOL401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETRACOL401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETRACOL401_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvAccountNumber] varchar(12) NOT NULL,
    [drvSocialSecurityNumber] char(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvEmployeeDivLocationCode] char(6) NULL,
    [drvClassCode] char(15) NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeLastNameSuffix] varchar(30) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeMiddleInitial] varchar(1) NULL,
    [drvBirthDate] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvAdjustedServiceDate] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvStreetAddressLine1] varchar(255) NULL,
    [drvStreetAddressLine2] varchar(255) NULL,
    [drvCityName] varchar(255) NULL,
    [drvStateCode] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvEmailaddress] varchar(50) NULL,
    [drvDaytimeWorkPhoneNumber] varchar(50) NULL,
    [drvEveningHomePhoneNumber] varchar(50) NULL,
    [drvMobilePhoneNumber] varchar(50) NULL,
    [drvSSOEligibilityCode] varchar(1) NOT NULL,
    [drvSingleSignOnId] varchar(1) NOT NULL,
    [drvMaritalStatusCode] varchar(1) NOT NULL,
    [drvEmployeePayrollFrequency] varchar(2) NULL,
    [drvGender] char(1) NULL,
    [drvEmployeeHighlyCompCode] varchar(1) NOT NULL,
    [drvInsiderInvestorCode] varchar(1) NOT NULL,
    [drvExpectedYearofService] varchar(1) NOT NULL,
    [drvLanguageCode] varchar(1) NOT NULL,
    [drvTerminationReasonCode] varchar(1) NULL,
    [drvCurrentHoursPaid] varchar(30) NULL,
    [drvEmployerNonelectiveContAmt] varchar(1) NOT NULL,
    [drvEmployeeAftertaxContAmt] varchar(30) NULL,
    [drvEmployeePreTaxContAmt] varchar(30) NULL,
    [drvEmployeeRothContAmt] varchar(1) NOT NULL,
    [drvEmployerMatchContAmt] varchar(1) NOT NULL,
    [drvEmployerSafeHarborContAmt] varchar(1) NOT NULL,
    [drvEmployeeLoanRepayment] varchar(1) NOT NULL,
    [drvAdditionalSource1ContAmt] varchar(1) NOT NULL,
    [drvAdditionalSource2ContAmt] varchar(1) NOT NULL,
    [drvCurrentGrossCompensation] varchar(30) NULL,
    [drvCurrentPlanCompensation] varchar(30) NULL,
    [drvAdditionalCompensation1] varchar(1) NOT NULL,
    [drvAdditionalCompensation2] varchar(1) NOT NULL,
    [drvPayrollPeriodStartDate] datetime NULL,
    [drvPayrollPeriodEndDate] datetime NULL,
    [drvPaycheckDate] datetime NULL,
    [drvDepartment] varchar(1) NULL
);
IF OBJECT_ID('U_ETRACOL401_EEList') IS NULL
CREATE TABLE [dbo].[U_ETRACOL401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETRACOL401_File') IS NULL
CREATE TABLE [dbo].[U_ETRACOL401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ETRACOL401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETRACOL401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhEmpAferTax] numeric NULL,
    [PdhEmpBeforeTax] numeric NULL
);
IF OBJECT_ID('U_ETRACOL401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETRACOL401_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRACOL401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Collins Pine

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 03/29/2021
Service Request Number: TekP-2021-02-09-0001

Purpose: TransAmerica 401k Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETRACOL401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETRACOL401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETRACOL401';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETRACOL401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETRACOL401' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRACOL401', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRACOL401', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRACOL401', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRACOL401', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRACOL401', 'SCH_ETRACO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETRACOL401';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETRACOL401', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETRACOL401';

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
    DELETE FROM dbo.U_ETRACOL401_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETRACOL401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401AN, 401AP, 401CF, 401CN, 401CP, 401F, 401NM, 401P';

    IF OBJECT_ID('U_ETRACOL401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETRACOL401_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETRACOL401_DedList
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
    IF OBJECT_ID('U_ETRACOL401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRACOL401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhEmpAferTax     = SUM(CASE WHEN PdhDedCode IN ('401AN', '401AP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEmpBeforeTax     = SUM(CASE WHEN PdhDedCode IN ('401NM', '401P', '401CF', '401CN', '401CP', '401F') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_ETRACOL401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETRACOL401_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ETRACOL401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRACOL401_PEarHist;
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
    INTO dbo.U_ETRACOL401_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    
    --Audit Table
    IF OBJECT_ID('U_ETRACOL401_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ETRACOL401_AuditFields;
    CREATE TABLE dbo.U_ETRACOL401_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ETRACOL401_AuditFields VALUES ('EmpComp','EecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ETRACOL401_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ETRACOL401_Audit;
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
    INTO dbo.U_ETRACOL401_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ETRACOL401_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ETRACOL401_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @Startdate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ETRACOL401_Audit ON dbo.U_ETRACOL401_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ETRACOL401_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETRACOL401_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETRACOL401_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvAccountNumber = 'QK6318000001'
        ,drvSocialSecurityNumber = eepSSN
        ,drvEmployeeNumber = eecEmpNo
        ,drvEmployeeDivLocationCode = eecLocation
        ,drvClassCode = EEPUDfield07
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeLastNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeMiddleInitial = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvBirthDate = EepDateOfBirth
        ,drvHireDate = eecdateoforiginalhire
        ,drvAdjustedServiceDate = ''
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvStreetAddressLine1 = EepAddressLine1
        ,drvStreetAddressLine2 = EepAddressLine2
        ,drvCityName = EepAddressCity
        ,drvStateCode = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvEmailaddress = EepAddressEMail
        ,drvDaytimeWorkPhoneNumber = EecPhoneBusinessNumber
        ,drvEveningHomePhoneNumber = EepPhoneHomeNumber
        ,drvMobilePhoneNumber = (SELECT TOP 1 efoPhoneNumber from  dbo.EmpMPhon Where efoPhoneType = 'CEL' and efoeeid = xeeid)
        ,drvSSOEligibilityCode = ''
        ,drvSingleSignOnId = ''
        ,drvMaritalStatusCode = ''
        ,drvEmployeePayrollFrequency = CASE WHEN eecPayPeriod = 'S' THEN '24'
                                            WHEN eecPayPeriod = 'B' THEN '26'
                                       END
        ,drvGender = EepGender
        ,drvEmployeeHighlyCompCode = ''
        ,drvInsiderInvestorCode = ''
        ,drvExpectedYearofService = ''
        ,drvLanguageCode = ''
        ,drvTerminationReasonCode = CASE WHEN EecEmplStatus = 'T' THEN 
                                            CASE WHEN EecTermReason NOT IN ('202','203') THEN '0'
                                                  WHEN EecTermReason  IN ('203') THEN '1'
                                                   WHEN EecTermReason  IN ('202') THEN '3'
                                                    WHEN EecTermReason  IN ('212') THEN '2'
                                                     WHEN EecTermReason  IN ('TRO') THEN ''
                                            END
                                    END


        ,drvCurrentHoursPaid = CAST(CONVERT(DECIMAL(10,2),PehCurHrs) as varchar)
        ,drvEmployerNonelectiveContAmt = '' 
        ,drvEmployeeAftertaxContAmt = CAST(CONVERT(DECIMAL(10,2),PdhEmpAferTax) as varchar)
        ,drvEmployeePreTaxContAmt = CAST(CONVERT(DECIMAL(10,2),PdhEmpBeforeTax) as varchar)
        ,drvEmployeeRothContAmt = ''
        ,drvEmployerMatchContAmt = ''
        ,drvEmployerSafeHarborContAmt = ''
        ,drvEmployeeLoanRepayment = ''
        ,drvAdditionalSource1ContAmt = ''
        ,drvAdditionalSource2ContAmt = ''
        ,drvCurrentGrossCompensation = CAST(CONVERT(DECIMAL(10,2),PehCurAmt) as varchar) 
        ,drvCurrentPlanCompensation = CAST(CONVERT(DECIMAL(10,2),PehInclInDefComp) as varchar) 
        ,drvAdditionalCompensation1 = ''
        ,drvAdditionalCompensation2 = ''
        ,drvPayrollPeriodStartDate = PrgPeriodStart
        ,drvPayrollPeriodEndDate = PrgPeriodEnd
        ,drvPaycheckDate = PayDate 
        ,drvDepartment = CASE WHEN EecPayGroup IN('PRTLND',  'KLTHSL')  THEN 'S'
                              WHEN EecPayGroup IN('KANEHR', 'FRMTHR', 'CHSTHR', 'KLTHHR')  THEN 'H'
                         END
    INTO dbo.U_ETRACOL401_drvTbl
    FROM dbo.U_ETRACOL401_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = dbo.dsi_BDM_fn_GetCurrentCOID(eeceeid)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_ETRACOL401_PDedHist WITH (NOLOCK)
        ON PdhEEID =  xeeid
    JOIN dbo.U_ETRACOL401_PEarHist  WITH (NOLOCK)
        ON PehEEID = xeeid
    JOIN (SELECT PgpPayGroup, CAST( LEFT(MAX(PgpPeriodControl),8) as datetime) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as PayGRP
        on PayGRP.PgpPayGroup =  eecpaygroup
    ;

    Delete from dbo.U_ETRACOL401_drvTbl where dbo.dsi_BDM_fn_GetCurrentCOID(drveeid) <> drvcoid


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
ALTER VIEW dbo.dsi_vwETRACOL401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETRACOL401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETRACOL401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202103221'
       ,expStartPerControl     = '202103221'
       ,expLastEndPerControl   = '202103299'
       ,expEndPerControl       = '202103299'
WHERE expFormatCode = 'ETRACOL401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETRACOL401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETRACOL401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort