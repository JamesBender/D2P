SET NOCOUNT ON;
IF OBJECT_ID('U_ESUNLFTRNS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFTRNS_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESUNLFTRNS_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESUNLFTRNS' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESUNLFTRNS_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESUNLFTRNS_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESUNLFTRNS') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNLFTRNS];
GO
IF OBJECT_ID('U_ESUNLFTRNS_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFTRNS_PTaxHist];
GO
IF OBJECT_ID('U_ESUNLFTRNS_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFTRNS_PEarHist];
GO
IF OBJECT_ID('U_ESUNLFTRNS_File') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFTRNS_File];
GO
IF OBJECT_ID('U_ESUNLFTRNS_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFTRNS_EEList];
GO
IF OBJECT_ID('U_ESUNLFTRNS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFTRNS_drvTbl];
GO
IF OBJECT_ID('U_ESUNLFTRNS_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFTRNS_DedList];
GO
IF OBJECT_ID('U_ESUNLFTRNS_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFTRNS_AuditFields];
GO
IF OBJECT_ID('U_ESUNLFTRNS_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFTRNS_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESUNLFTRNS';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESUNLFTRNS';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESUNLFTRNS';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESUNLFTRNS';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESUNLFTRNS';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESUNLFTRNS','SunLife Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','6000','S','N','ESUNLFTRNSZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESUNLFTRNS' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee SSN"','1','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','1',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','2','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','2',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Title"','3','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','3',NULL,'Employee Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee First Name"','4','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','4',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Middle Name"','5','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','5',NULL,'Employee Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Last Name"','6','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','6',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Gender"','7','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','7',NULL,'Employee Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Date of Birth"','8','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','8',NULL,'Employee Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Home Address Line 1"','9','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','9',NULL,'Employee Home Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Home Address Line 2"','10','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','10',NULL,'Employee Home Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Home City"','11','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','11',NULL,'Employee Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Home State"','12','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','12',NULL,'Employee Home State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Home Zip Code"','13','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','13',NULL,'Employee Home Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee County"','14','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','14',NULL,'Employee County',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Country"','15','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','15',NULL,'Employee Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Home Phone Number"','16','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','16',NULL,'Employee Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Mobile Phone Number"','17','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','17',NULL,'Employee Mobile Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Phone Type"','18','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','18',NULL,'Primary Phone Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Email Address"','19','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','19',NULL,'Employee Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Work Email Address"','20','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','20',NULL,'Employee Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Work State"','21','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','21',NULL,'Employee Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Original Date of Hire"','22','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','22',NULL,'Employee Original Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Most Recent Date of Hire"','23','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','23',NULL,'Employee Most Recent Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Adjusted Date of Hire"','24','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','24',NULL,'Employee Adjusted Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Job Title"','25','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','25',NULL,'Employee Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','26','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','26',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Full Time/Part Time Status"','27','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','27',NULL,'Full Time/Part Time Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Exempt Status"','28','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','28',NULL,'Exempt Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Compensation Method"','29','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','29',NULL,'Compensation Method',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Type"','30','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','30',NULL,'Union Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Name"','31','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','31',NULL,'Union Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Hours per Week"','32','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','32',NULL,'Scheduled Hours per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Days per Week"','33','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','33',NULL,'Scheduled Days per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Type"','34','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','34',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Site Name"','35','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','35',NULL,'Work Site Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Organization Unit"','36','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','36',NULL,'Organization Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Business Unit"','37','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','37',NULL,'Business Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','38','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','38',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Group Type"','39','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','39',NULL,'Group Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Earning"','40','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','40',NULL,'Employee Earning',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Frequency"','41','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','41',NULL,'Earnings Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Effective Date"','42','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','42',NULL,'Earnings Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Weekly Earnings"','43','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','43',NULL,'STD Weekly Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Monthly Earnings"','44','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','44',NULL,'LTD Monthly Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','45','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','45',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Eligibility Date"','46','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','46',NULL,'STD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Election"','47','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','47',NULL,'STD Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Benefit Amount"','48','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','48',NULL,'STD Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Class"','49','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','49',NULL,'STD Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Termination Date"','50','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','50',NULL,'STD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Statutory Disability Type"','51','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','51',NULL,'Statutory Disability Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Eligibility Date"','52','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','52',NULL,'LTD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Election"','53','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','53',NULL,'LTD Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Benefit Amount"','54','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','54',NULL,'LTD Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Class"','55','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','55',NULL,'LTD Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Termination Date"','56','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','56',NULL,'LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Policy Number"','57','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','57',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Key Employee Indicator"','58','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','58',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work At Home Indicator"','59','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','59',NULL,'Work At Home Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"50 In 75 Rule Indicator"','60','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','60',NULL,'50 In 75 Rule Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked Previous 12 Months"','61','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','61',NULL,'Hours Worked Previous 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Employee ID"','62','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','62',NULL,'Supervisor Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor First Name"','63','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','63',NULL,'Supervisor First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Last Name"','64','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','64',NULL,'Supervisor Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation Qualifier1"','65','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','65',NULL,'Occupation Qualifier1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation Qualifier2"','66','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','66',NULL,'Occupation Qualifier2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation Qualifier3"','67','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','67',NULL,'Occupation Qualifier3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation Qualifier4"','68','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','68',NULL,'Occupation Qualifier4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation Qualifier5"','69','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','69',NULL,'Occupation Qualifier5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation Qualifier6"','70','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','70',NULL,'Occupation Qualifier6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation Qualifier7"','71','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','71',NULL,'Occupation Qualifier7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation Qualifier8"','72','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','72',NULL,'Occupation Qualifier8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation Qualifier9"','73','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','73',NULL,'Occupation Qualifier9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation Qualifier10"','74','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','74',NULL,'Occupation Qualifier10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 1"','75','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','75',NULL,'Employer Contact 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 2"','76','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','76',NULL,'Employer Contact 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 3"','77','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','77',NULL,'Employer Contact 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 4"','78','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','78',NULL,'Employer Contact 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 5"','79','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','79',NULL,'Employer Contact 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 6"','80','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','80',NULL,'Employer Contact 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 7"','81','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','81',NULL,'Employer Contact 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 8"','82','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','82',NULL,'Employer Contact 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 9"','83','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','83',NULL,'Employer Contact 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 10"','84','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','84',NULL,'Employer Contact 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Field1"','85','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','85',NULL,'Reporting Field1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Field2"','86','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','86',NULL,'Reporting Field2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Field3"','87','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','87',NULL,'Reporting Field3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Field4"','88','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','88',NULL,'Reporting Field4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Date of Change"','89','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','89',NULL,'Spouse Date of Change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse First Name"','90','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','90',NULL,'Spouse First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Last Name"','91','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','91',NULL,'Spouse Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Date of Birth"','92','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','92',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse SSN"','93','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','93',NULL,'Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Employee ID"','94','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','94',NULL,'Spouse Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','95','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','95',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Reason of Change"','96','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','96',NULL,'Spouse Reason of Change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Class"','97','(''DA''=''T,'')','ESUNLFTRNSZ0','50','H','01','97',NULL,'Employment Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Strength"','98','(''DA''=''T'')','ESUNLFTRNSZ0','50','H','01','98',NULL,'Employment Strength',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSsn"','1','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','1',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','2','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','2',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTitle"','3','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','3',NULL,'Employee Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','4','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','4',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','5','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','5',NULL,'Employee Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','6',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','7','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','7',NULL,'Employee Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','8','(''UD101''=''T,'')','ESUNLFTRNSZ0','50','D','10','8',NULL,'Employee Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''Q,'')','ESUNLFTRNSZ0','50','D','10','9',NULL,'Employee Home Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLIne2"','10','(''UA''=''Q,'')','ESUNLFTRNSZ0','50','D','10','10',NULL,'Employee Home Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','11','(''UA''=''Q,'')','ESUNLFTRNSZ0','50','D','10','11',NULL,'Employee Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','12','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','12',NULL,'Employee Home State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip"','13','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','13',NULL,'Employee Home Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCounty"','14','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','14',NULL,'Employee County',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','15','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','15',NULL,'Employee Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','16','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','16',NULL,'Employee Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMobilePhone"','17','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','17',NULL,'Employee Mobile Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrefferedPhone"','18','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','18',NULL,'Primary Phone Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEMailAlternate"','19','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','19',NULL,'Employee Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','20','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','20',NULL,'Employee Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocState"','21','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','21',NULL,'Employee Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','22','(''UD101''=''T,'')','ESUNLFTRNSZ0','50','D','10','22',NULL,'Employee Original Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','23','(''UD101''=''T,'')','ESUNLFTRNSZ0','50','D','10','23',NULL,'Employee Most Recent Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeniorityDate"','24','(''UD101''=''T,'')','ESUNLFTRNSZ0','50','D','10','24',NULL,'Employee Adjusted Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobDesc"','25','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','25',NULL,'Employee Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplStatus"','26','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','26',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullTimePartTime"','27','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','27',NULL,'Full Time/Part Time Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptStatus"','28','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','28',NULL,'Exempt Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryOrHourly"','29','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','29',NULL,'Compensation Method',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionType"','30','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','30',NULL,'Union Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionName"','31','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','31',NULL,'Union Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledHoursPerWeek"','32','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','32',NULL,'Scheduled Hours per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledDaysPerWeek"','33','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','33',NULL,'Scheduled Days per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentType"','34','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','34',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','35','(''UA''=''Q,'')','ESUNLFTRNSZ0','50','D','10','35',NULL,'Work Site Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLevel"','36','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','36',NULL,'Organization Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBusinessUnit"','37','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','37',NULL,'Business Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','38','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','38',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupType"','39','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','39',NULL,'Group Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEarning"','40','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','40',NULL,'Employee Earning',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsFrequency"','41','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','41',NULL,'Earnings Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsEffectiveDate"','42','(''UD101''=''T,'')','ESUNLFTRNSZ0','50','D','10','42',NULL,'Earnings Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDWeeklyEarnings"','43','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','43',NULL,'STD Weekly Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDMonthlyEarnings"','44','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','44',NULL,'LTD Monthly Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','45','(''UD101''=''T,'')','ESUNLFTRNSZ0','50','D','10','45',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDEligibilityDate"','46','(''UD101''=''T,'')','ESUNLFTRNSZ0','50','D','10','46',NULL,'STD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDElection"','47','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','47',NULL,'STD Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDBenefitAmount"','48','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','48',NULL,'STD Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDClass"','49','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','49',NULL,'STD Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDTerminationDate"','50','(''UD101''=''T,'')','ESUNLFTRNSZ0','50','D','10','50',NULL,'STD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatutoryDisabilityType"','51','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','51',NULL,'Statutory Disability Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEligibilityDate"','52','(''UD101''=''T,'')','ESUNLFTRNSZ0','50','D','10','52',NULL,'LTD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDElection"','53','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','53',NULL,'LTD Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDBenefitAmount"','54','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','54',NULL,'LTD Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDClass"','55','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','55',NULL,'LTD Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDTerminationDate"','56','(''UD101''=''T,'')','ESUNLFTRNSZ0','50','D','10','56',NULL,'LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber"','57','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','57',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmployeeIndicator"','58','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','58',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAtHomeIndicator"','59','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','59',NULL,'Work At Home Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv50In75RuleIndicator"','60','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','60',NULL,'50 In 75 Rule Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsWrkd12Months"','61','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','61',NULL,'Hours Worked Previous 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorEmployeeID"','62','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','62',NULL,'Supervisor Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorFirstName"','63','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','63',NULL,'Supervisor First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorLastName"','64','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','64',NULL,'Supervisor Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationQualifier1"','65','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','65',NULL,'Occupation Qualifier1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationQualifier2"','66','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','66',NULL,'Occupation Qualifier2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationQualifier3"','67','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','67',NULL,'Occupation Qualifier3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationQualifier4"','68','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','68',NULL,'Occupation Qualifier4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationQualifier5"','69','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','69',NULL,'Occupation Qualifier5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationQualifier6"','70','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','70',NULL,'Occupation Qualifier6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationQualifier7"','71','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','71',NULL,'Occupation Qualifier7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationQualifier8"','72','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','72',NULL,'Occupation Qualifier8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationQualifier9"','73','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','73',NULL,'Occupation Qualifier9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationQualifier10"','74','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','74',NULL,'Occupation Qualifier10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact1"','75','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','75',NULL,'Employer Contact 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact2"','76','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','76',NULL,'Employer Contact 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact3"','77','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','77',NULL,'Employer Contact 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact4"','78','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','78',NULL,'Employer Contact 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact5"','79','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','79',NULL,'Employer Contact 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact6"','80','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','80',NULL,'Employer Contact 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact7"','81','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','81',NULL,'Employer Contact 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact8"','82','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','82',NULL,'Employer Contact 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact9"','83','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','83',NULL,'Employer Contact 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact10"','84','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','84',NULL,'Employer Contact 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportingField1"','85','(''UA''=''T,'')','ESUNLFTRNSZ0','100','D','10','85',NULL,'Reporting Field1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportingField2"','86','(''UA''=''T,'')','ESUNLFTRNSZ0','100','D','10','86',NULL,'Reporting Field2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportingField3"','87','(''UA''=''T,'')','ESUNLFTRNSZ0','100','D','10','87',NULL,'Reporting Field3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportingField4"','88','(''UA''=''T,'')','ESUNLFTRNSZ0','100','D','10','88',NULL,'Reporting Field4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDateofChange"','89','(''UD101''=''T,'')','ESUNLFTRNSZ0','50','D','10','89',NULL,'Spouse Date of Change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseFirstName"','90','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','90',NULL,'Spouse First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLastName"','91','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','91',NULL,'Spouse Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDateofBirth"','92','(''UD101''=''T,'')','ESUNLFTRNSZ0','50','D','10','92',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSSN"','93','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','93',NULL,'Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseEmployeeID"','94','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','94',NULL,'Spouse Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','95','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','95',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseReasonofChange"','96','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','96',NULL,'Spouse Reason of Change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentClass"','97','(''UA''=''T,'')','ESUNLFTRNSZ0','50','D','10','97',NULL,'Employment Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStrength"','98','(''UA''=''T'')','ESUNLFTRNSZ0','50','D','10','98',NULL,'Employment Strength',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ESUNLFTRNS_20210731.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202106109','EMPEXPORT','OEACTIVE',NULL,'ESUNLFTRNS',NULL,NULL,NULL,'202106109','Jun 10 2021  8:12AM','Jun 10 2021  8:12AM','202106101',NULL,'','','202106101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202106109','EMPEXPORT','OEPASSIVE',NULL,'ESUNLFTRNS',NULL,NULL,NULL,'202106109','Jun 10 2021  8:12AM','Jun 10 2021  8:12AM','202106101',NULL,'','','202106101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sunlife Export','202106109','EMPEXPORT','ONDEM_XOE','Jul  6 2021 12:00AM','ESUNLFTRNS',NULL,NULL,NULL,'202106109','Jun 10 2021 12:00AM','Dec 30 1899 12:00AM','202106101',NULL,'','','202106101',dbo.fn_GetTimedKey(),NULL,'us3kMcPAP1002',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sunlife Sched Export','202106109','EMPEXPORT','SCH_ESUNLF','Jul  6 2021 12:00AM','ESUNLFTRNS',NULL,NULL,NULL,'202106109','Jun 10 2021 12:00AM','Dec 30 1899 12:00AM','202106101',NULL,'','','202106101',dbo.fn_GetTimedKey(),NULL,'us3kMcPAP1002',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Sunlife Test Export','202107071','EMPEXPORT','TEST_XOE','Jul  7 2021 10:08AM','ESUNLFTRNS',NULL,NULL,NULL,'202107071','Jul  7 2021 12:00AM','Jun 26 2021 12:00AM','202107071','825','','','202107071',dbo.fn_GetTimedKey(),NULL,'us3rVaPAP1002',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLFTRNS','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLFTRNS','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLFTRNS','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLFTRNS','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ESUNLFTRNS' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ESUNLFTRNS' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ESUNLFTRNS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESUNLFTRNS_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLFTRNS','D10','dbo.U_ESUNLFTRNS_drvTbl',NULL);
IF OBJECT_ID('U_ESUNLFTRNS_Audit') IS NULL
CREATE TABLE [dbo].[U_ESUNLFTRNS_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audKey1] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audEffectiveDate] smalldatetime NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_ESUNLFTRNS_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESUNLFTRNS_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ESUNLFTRNS_DedList') IS NULL
CREATE TABLE [dbo].[U_ESUNLFTRNS_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESUNLFTRNS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESUNLFTRNS_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSsn] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvTitle] varchar(30) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvMiddleName] varchar(1) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLIne2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip] varchar(5) NULL,
    [drvAddressCounty] varchar(1) NOT NULL,
    [drvAddressCountry] varchar(1) NOT NULL,
    [drvHomePhone] varchar(12) NULL,
    [drvMobilePhone] varchar(1) NOT NULL,
    [drvPrefferedPhone] varchar(4) NOT NULL,
    [drvAddressEMailAlternate] varchar(50) NULL,
    [drvAddressEmail] varchar(1) NOT NULL,
    [drvLocState] varchar(255) NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvSeniorityDate] datetime NULL,
    [drvJobDesc] varchar(25) NOT NULL,
    [drvEmplStatus] char(1) NULL,
    [drvFullTimePartTime] char(1) NULL,
    [drvExemptStatus] varchar(1) NOT NULL,
    [drvSalaryOrHourly] char(1) NULL,
    [drvUnionType] char(12) NULL,
    [drvUnionName] varchar(1) NOT NULL,
    [drvScheduledHoursPerWeek] varchar(20) NULL,
    [drvScheduledDaysPerWeek] varchar(1) NOT NULL,
    [drvEmploymentType] varchar(1) NOT NULL,
    [drvLocation] varchar(21) NOT NULL,
    [drvOrgLevel] varchar(1) NOT NULL,
    [drvBusinessUnit] varchar(1) NOT NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvGroupType] varchar(1) NOT NULL,
    [drvEmployeeEarning] varchar(20) NULL,
    [drvEarningsFrequency] varchar(1) NOT NULL,
    [drvEarningsEffectiveDate] varchar(1) NOT NULL,
    [drvSTDWeeklyEarnings] varchar(1) NOT NULL,
    [drvLTDMonthlyEarnings] varchar(1) NOT NULL,
    [drvTerminationDate] varchar(1) NOT NULL,
    [drvSTDEligibilityDate] datetime NULL,
    [drvSTDElection] varchar(1) NOT NULL,
    [drvSTDBenefitAmount] varchar(1) NOT NULL,
    [drvSTDClass] varchar(3) NOT NULL,
    [drvSTDTerminationDate] varchar(1) NOT NULL,
    [drvStatutoryDisabilityType] varchar(1) NOT NULL,
    [drvLTDEligibilityDate] datetime NULL,
    [drvLTDElection] varchar(1) NOT NULL,
    [drvLTDBenefitAmount] varchar(1) NOT NULL,
    [drvLTDClass] varchar(1) NOT NULL,
    [drvLTDTerminationDate] varchar(1) NOT NULL,
    [drvPolicyNumber] varchar(1) NOT NULL,
    [drvKeyEmployeeIndicator] varchar(1) NOT NULL,
    [drvWorkAtHomeIndicator] varchar(1) NOT NULL,
    [drv50In75RuleIndicator] varchar(1) NOT NULL,
    [drvHrsWrkd12Months] varchar(1) NOT NULL,
    [drvSupervisorEmployeeID] varchar(1) NOT NULL,
    [drvSupervisorFirstName] varchar(1) NOT NULL,
    [drvSupervisorLastName] varchar(1) NOT NULL,
    [drvOccupationQualifier1] varchar(1) NOT NULL,
    [drvOccupationQualifier2] varchar(1) NOT NULL,
    [drvOccupationQualifier3] varchar(1) NOT NULL,
    [drvOccupationQualifier4] varchar(1) NOT NULL,
    [drvOccupationQualifier5] varchar(1) NOT NULL,
    [drvOccupationQualifier6] varchar(1) NOT NULL,
    [drvOccupationQualifier7] varchar(1) NOT NULL,
    [drvOccupationQualifier8] varchar(1) NOT NULL,
    [drvOccupationQualifier9] varchar(1) NOT NULL,
    [drvOccupationQualifier10] varchar(1) NOT NULL,
    [drvEmployerContact1] varchar(1) NOT NULL,
    [drvEmployerContact2] varchar(1) NOT NULL,
    [drvEmployerContact3] varchar(1) NOT NULL,
    [drvEmployerContact4] varchar(1) NOT NULL,
    [drvEmployerContact5] varchar(1) NOT NULL,
    [drvEmployerContact6] varchar(1) NOT NULL,
    [drvEmployerContact7] varchar(1) NOT NULL,
    [drvEmployerContact8] varchar(1) NOT NULL,
    [drvEmployerContact9] varchar(1) NOT NULL,
    [drvEmployerContact10] varchar(1) NOT NULL,
    [drvReportingField1] varchar(1) NOT NULL,
    [drvReportingField2] varchar(1) NOT NULL,
    [drvReportingField3] varchar(1) NOT NULL,
    [drvReportingField4] varchar(1) NOT NULL,
    [drvSpouseDateofChange] varchar(1) NOT NULL,
    [drvSpouseFirstName] varchar(1) NOT NULL,
    [drvSpouseLastName] varchar(1) NOT NULL,
    [drvSpouseDateofBirth] varchar(1) NOT NULL,
    [drvSpouseSSN] varchar(1) NOT NULL,
    [drvSpouseEmployeeID] varchar(1) NOT NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvSpouseReasonofChange] varchar(1) NOT NULL,
    [drvEmploymentClass] varchar(1) NOT NULL,
    [drvEmploymentStrength] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ESUNLFTRNS_EEList') IS NULL
CREATE TABLE [dbo].[U_ESUNLFTRNS_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESUNLFTRNS_File') IS NULL
CREATE TABLE [dbo].[U_ESUNLFTRNS_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_ESUNLFTRNS_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESUNLFTRNS_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] money NULL
);
IF OBJECT_ID('U_ESUNLFTRNS_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_ESUNLFTRNS_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthUSFITTaxWages] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNLFTRNS]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Paper Transport

Created By: Keary McCutchen
Business Analyst: 
Create Date: 06/10/2021
Service Request Number: TekP-2021-03-09-0001

Purpose: Sunlife

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESUNLFTRNS';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESUNLFTRNS';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESUNLFTRNS';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESUNLFTRNS';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESUNLFTRNS' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLFTRNS', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLFTRNS', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLFTRNS', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLFTRNS', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLFTRNS', 'SCH_ESUNLF';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESUNLFTRNS';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESUNLFTRNS', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESUNLFTRNS';

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
    DELETE FROM dbo.U_ESUNLFTRNS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESUNLFTRNS_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --DELETE TEST/BAD EMPLOYEES
    DELETE EE
    FROM dbo.U_ESUNLFTRNS_EEList EE
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
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_ESUNLFTRNS_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLFTRNS_AuditFields;
    
    CREATE TABLE dbo.U_ESUNLFTRNS_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_ESUNLFTRNS_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESUNLFTRNS_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLFTRNS_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_ESUNLFTRNS_Audit
    FROM dbo.U_ESUNLFTRNS_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_ESUNLFTRNS_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    ;
    -- Cleans EE List of terms not this period
    DELETE FROM dbo.U_ESUNLFTRNS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID NOT IN (SELECT xEEID FROM dbo.U_ESUNLFTRNS_Audit WHERE audEEID = xEEID)
    AND XEEID IN (SELECT EecEEID FROM dbo.EmpComp WHERE EecEEID = xEEID and EecEmplStatus = 'T')
    ;

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD, STDD, LTD, LTDD';

    IF OBJECT_ID('U_ESUNLFTRNS_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLFTRNS_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESUNLFTRNS_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStartDateDays', '30');     INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStopDateDays', '30'); 
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
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ESUNLFTRNS_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLFTRNS_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours      
        ,PehCurAmt              = SUM(PehCurAmt)
    INTO dbo.U_ESUNLFTRNS_PEarHist
    FROM dbo.U_ESUNLFTRNS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_PayReg WITH (NOLOCK)
        ON prgEEID = xEEID
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PrgPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    -----------------------------
    -- Working Table - PTaxHist
    -----------------------------
    IF OBJECT_ID('U_ESUNLFTRNS_PTaxHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLFTRNS_PTaxHist;
    SELECT DISTINCT
         PthEEID
    -- Current Payroll Amount/Hours      
        ,PthUSFITTaxWages       = SUM(PthCurTaxableWages)
    INTO dbo.U_ESUNLFTRNS_PTaxHist
    FROM dbo.U_ESUNLFTRNS_EEList WITH (NOLOCK)
    JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
    WHERE CAST(LEFT(PthPerControl,4) AS INT) = CAST(LEFT(@EndPerControl,4) AS INT) - 1
    AND PthTaxCode = 'USFIT'
    GROUP BY PthEEID
    HAVING SUM(PthCurTaxableWages) <> 0.00; 


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESUNLFTRNS_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESUNLFTRNS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLFTRNS_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSsn = eepSSN
        ,drvEmpNo = EecEmpNo
        ,drvTitle = EepNamePrefix
        ,drvNameFirst = EepNameFirst
        ,drvMiddleName = ''--LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvGender = CASE WHEN ISNULL(RTRIM(EepGender),'') IN ('M','F') THEN EepGender END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLIne2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZip = LEFT(LTRIM(EepAddressZipCode),5)
        ,drvAddressCounty = ''--EepAddressCounty
        ,drvAddressCountry = ''--CASE WHEN EepAddressCountry <> 'USA' THEN EepAddressCountry END
        ,drvHomePhone =  SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + SUBSTRING(EepPhoneHomeNumber, 7,4)  
        ,drvMobilePhone = ''--SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + SUBSTRING(EepPhoneHomeNumber, 7,4)  
        ,drvPrefferedPhone = 'Home'
        ,drvAddressEMailAlternate = EepAddressEmailAlternate
        ,drvAddressEmail = ''--EepAddressEMail
        ,drvLocState = LocAddressState
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvSeniorityDate = EecDateOfSeniority
        ,drvJobDesc = JbcDesc
        ,drvEmplStatus = EecEmplStatus --WHEN 'L' THEN 'OL' WHEN 'T' THEN 'TE' ELSE 'AE' END
        ,drvFullTimePartTime = CASE WHEN EecFullTimeOrPartTime IN ('F','P') THEN EecFullTimeOrPartTime END
        ,drvExemptStatus = ''--EecEEType
        ,drvSalaryOrHourly = EecSalaryOrHourly
        ,drvUnionType = EecUnionLocal --EecUnionNational
        ,drvUnionName = ''--RTRIM(UniLongDesc) -- RTRIM(EmpComp.NationalUnionLongDesc)
        ,drvScheduledHoursPerWeek = CONVERT(VARCHAR(20),CASE WHEN  EecDedGroupCode IN ('EXEC','FT','PT','FTDM') AND EecScheduledWorkHrs = 0 THEN 40 ELSE EecScheduledWorkHrs END)
        ,drvScheduledDaysPerWeek = '' --EecScheduledWorkHrs/8
        ,drvEmploymentType = '' --ExemptStatus.CodDesc
        ,drvLocation= 'Paper Transport, Inc.'
        ,drvOrgLevel = ''--ORG2.OrgDesc
        ,drvBusinessUnit = ''
        ,drvDivision = ''
        ,drvGroupType = ''
        ,drvEmployeeEarning = CONVERT(VARCHAR(20),CASE WHEN EecEarnGroupCode IN ('MDRVR','HRLY','HDRVR','SAL') AND ISNULL(PthUSFITTaxWages,0) > 0 THEN PthUSFITTaxWages
                                   WHEN EecEarnGroupCode IN ('MDRVR','HRLY','HDRVR','SAL') THEN PehCurAmt
                               END)
        ,drvEarningsFrequency = ''
        ,drvEarningsEffectiveDate = ''
        ,drvSTDWeeklyEarnings = ''
        ,drvLTDMonthlyEarnings = ''
        ,drvTerminationDate = ''
        ,drvSTDEligibilityDate = EedSTDStartDate
        ,drvSTDElection = ''
        ,drvSTDBenefitAmount = ''
        ,drvSTDClass = CASE WHEN EecEarnGroupCode IN ('MDRVR') THEN '002' ELSE '001' END
        ,drvSTDTerminationDate = ''
        ,drvStatutoryDisabilityType = ''
        ,drvLTDEligibilityDate = EedLTDStartDate
        ,drvLTDElection = ''
        ,drvLTDBenefitAmount = ''
        ,drvLTDClass = ''
        ,drvLTDTerminationDate = '' 
        ,drvPolicyNumber = ''
        ,drvKeyEmployeeIndicator = ''
        ,drvWorkAtHomeIndicator = ''
        ,drv50In75RuleIndicator = ''
        ,drvHrsWrkd12Months = ''
        ,drvSupervisorEmployeeID = ''
        ,drvSupervisorFirstName = ''
        ,drvSupervisorLastName = ''
        ,drvOccupationQualifier1 = ''
        ,drvOccupationQualifier2 = ''
        ,drvOccupationQualifier3 = ''
        ,drvOccupationQualifier4 = ''
        ,drvOccupationQualifier5 = ''
        ,drvOccupationQualifier6 = ''
        ,drvOccupationQualifier7 = ''
        ,drvOccupationQualifier8 = ''
        ,drvOccupationQualifier9 = ''
        ,drvOccupationQualifier10 = ''
        ,drvEmployerContact1 = ''
        ,drvEmployerContact2 = ''
        ,drvEmployerContact3 = ''
        ,drvEmployerContact4 = ''
        ,drvEmployerContact5 = ''
        ,drvEmployerContact6 = ''
        ,drvEmployerContact7 = ''
        ,drvEmployerContact8 = ''
        ,drvEmployerContact9 = ''
        ,drvEmployerContact10 = ''
        ,drvReportingField1 = ''
        ,drvReportingField2 = ''
        ,drvReportingField3 = ''
        ,drvReportingField4 = ''
        ,drvSpouseDateofChange = ''
        ,drvSpouseFirstName = ''
        ,drvSpouseLastName = ''
        ,drvSpouseDateofBirth = ''
        ,drvSpouseSSN = ''
        ,drvSpouseEmployeeID = ''
        ,drvMaritalStatus = ''
        ,drvSpouseReasonofChange = ''
        ,drvEmploymentClass = ''
        ,drvEmploymentStrength = ''
    INTO dbo.U_ESUNLFTRNS_drvTbl
    FROM dbo.U_ESUNLFTRNS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT
    JOIN dbo.U_ESUNLFTRNS_PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
    LEFT
    JOIN dbo.U_ESUNLFTRNS_PEarHist WITH (NOLOCK)
        ON PthEEID = xEEID
    JOIN (SELECT EedEEID, EedCoID 
                ,EedSTDStartDate = MAX(CASE WHEN EedDedCode IN ('STD','STDD') THEN EedBenStartDate END)
                ,EedLTDStartDate = MAX(CASE WHEN EedDedCode IN ('LTD','LTDD') THEN EedBenStartDate END)
            FROM
                 dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
           WHERE EedFormatCode = @FormatCode 
              AND EedValidForExport = 'Y'
           GROUP
              BY EedEEID, EedCoID) BDM
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
    --LEFT
    --JOIN dbo.LabUnion WITH (NOLOCK)
    --  ON [UniCode] = EecUnionLocal
    --LEFT 
    --JOIN (SELECT TOP 1 
    --              EfoEEID
    --            , EfoPhoneNumber 
    --        FROM dbo.EmpMPhon WITH(NOLOCK) 
    --       WHERE efoPhoneType = 'CEL'
    --      ) AS M 
    --  ON M.EfoEEID = xEEID
    --JOIN dbo.BenGrp WITH (NOLOCK)
    --  ON EecDedGroupCode = CbgBenGroupCode
    --LEFT 
    --JOIN dbo.CODES AS ExemptStatus WITH (NOLOCK)
    --  ON CodCode = JbcFLSAType
    --AND  CodTable = 'FLSATYPE'
    --JOIN dbo.OrgLevel AS ORG2 WITH (NOLOCK) 
    --  ON Org2.OrgCode = EecOrgLvl2
    -- AND OrgLvl = 2
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
ALTER VIEW dbo.dsi_vwESUNLFTRNS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESUNLFTRNS_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESUNLFTRNS%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106031'
       ,expStartPerControl     = '202106031'
       ,expLastEndPerControl   = '202106109'
       ,expEndPerControl       = '202106109'
WHERE expFormatCode = 'ESUNLFTRNS';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESUNLFTRNS_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESUNLFTRNS_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort