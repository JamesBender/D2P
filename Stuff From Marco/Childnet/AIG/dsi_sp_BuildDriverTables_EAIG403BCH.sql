SET NOCOUNT ON;
IF OBJECT_ID('U_EAIG403BCH_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EAIG403BCH_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EAIG403BCH_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EAIG403BCH' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEAIG403BCH_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAIG403BCH_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAIG403BCH') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAIG403BCH];
GO
IF OBJECT_ID('U_EAIG403BCH_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EAIG403BCH_PEarHist];
GO
IF OBJECT_ID('U_EAIG403BCH_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EAIG403BCH_PDedHist];
GO
IF OBJECT_ID('U_EAIG403BCH_File') IS NOT NULL DROP TABLE [dbo].[U_EAIG403BCH_File];
GO
IF OBJECT_ID('U_EAIG403BCH_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAIG403BCH_EEList];
GO
IF OBJECT_ID('U_EAIG403BCH_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAIG403BCH_drvTbl];
GO
IF OBJECT_ID('U_EAIG403BCH_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAIG403BCH_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EAIG403BCH';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EAIG403BCH';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EAIG403BCH';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EAIG403BCH';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EAIG403BCH';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAIG403BCH','AIG 403b Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EAIG403BCHZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Format Code"','1','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','1',NULL,'Format Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Paygroup ID"','2','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','2',NULL,'Paygroup ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','3','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','3',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','4','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Participant First Name"','5','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','5',NULL,'Participant First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Participant Middle Name"','6','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','6',NULL,'Participant Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Participant Last Name"','7','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','7',NULL,'Participant Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 1"','8','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','8',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 2"','9','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','9',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','10','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State/Country Code"','11','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','11',NULL,'State/Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','12','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','12',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Frequency Code"','13','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','13',NULL,'Payroll Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Date"','14','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','14',NULL,'Payroll Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Mandatory"','15','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','15',NULL,'Employee Mandatory',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Basic"','16','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','16',NULL,'Employer Basic',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Match"','17','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','17',NULL,'Employer Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Designated Roth"','18','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','18',NULL,'Designated Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Not Used"','19','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','19',NULL,'Not Used',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan ID"','20','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','20',NULL,'Loan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Birth Date"','21','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','21',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Hire Date"','22','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','22',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone"','23','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','23',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 3"','24','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','24',NULL,'Address 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender ID"','25','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','25',NULL,'Gender ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','26','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','26',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Participant Status"','27','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','27',NULL,'Participant Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Participant Status Change Date"','28','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','28',NULL,'Participant Status Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Code / HR Area"','29','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','29',NULL,'Location Code / HR Area',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Sub Area"','30','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','30',NULL,'HR Sub Area',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Status code"','31','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','31',NULL,'Payroll Status code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Annual Salary"','32','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','32',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Hours"','33','(''DA''=''T,'')','EAIG403BCHZ0','50','H','01','33',NULL,'YTD Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','34','(''DA''=''T'')','EAIG403BCHZ0','50','H','01','34',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFormatCode"','1','(''UA''=''T,'')','EAIG403BCHZ0','4','D','10','1',NULL,'Format Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayGroupId"','2','(''UA''=''T,'')','EAIG403BCHZ0','12','D','10','2',NULL,'Paygroup ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T,'')','EAIG403BCHZ0','9','D','10','3',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeId"','4','(''UA''=''T,'')','EAIG403BCHZ0','20','D','10','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFirstName"','5','(''UA''=''T,'')','EAIG403BCHZ0','30','D','10','5',NULL,'Participant First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMiddleName"','6','(''UA''=''T,'')','EAIG403BCHZ0','30','D','10','6',NULL,'Participant Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLastName"','7','(''UA''=''T,'')','EAIG403BCHZ0','30','D','10','7',NULL,'Participant Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','8','(''UA''=''T,'')','EAIG403BCHZ0','35','D','10','8',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','9','(''UA''=''T,'')','EAIG403BCHZ0','35','D','10','9',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','10','(''UA''=''T,'')','EAIG403BCHZ0','20','D','10','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','11','(''UA''=''T,'')','EAIG403BCHZ0','2','D','10','11',NULL,'State/Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','12','(''UA''=''T,'')','EAIG403BCHZ0','9','D','10','12',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFrequency"','13','(''UA''=''T,'')','EAIG403BCHZ0','2','D','10','13',NULL,'Payroll Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDate"','14','(''UD101''=''T,'')','EAIG403BCHZ0','8','D','10','14',NULL,'Payroll Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEMandatory"','15','(''UA''=''T,'')','EAIG403BCHZ0','7','D','10','15',NULL,'Employee Mandatory',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERBasic"','16','(''UA''=''T,'')','EAIG403BCHZ0','7','D','10','16',NULL,'Employer Basic',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERMatch"','17','(''UA''=''T,'')','EAIG403BCHZ0','7','D','10','17',NULL,'Employer Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERDesignatedRoth"','18','(''UA''=''T,'')','EAIG403BCHZ0','7','D','10','18',NULL,'Designated Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNotUsed"','19','(''UA''=''T,'')','EAIG403BCHZ0','7','D','10','19',NULL,'Not Used',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanID"','20','(''UA''=''T,'')','EAIG403BCHZ0','2','D','10','20',NULL,'Loan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','21','(''UD101''=''T,'')','EAIG403BCHZ0','8','D','10','21',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOrigHireDate"','22','(''UD101''=''T,'')','EAIG403BCHZ0','8','D','10','22',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','23','(''UA''=''T,'')','EAIG403BCHZ0','15','D','10','23',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine3"','24','(''UA''=''T,'')','EAIG403BCHZ0','35','D','10','24',NULL,'Address 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGenderId"','25','(''UA''=''T,'')','EAIG403BCHZ0','1','D','10','25',NULL,'Gender ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','26','(''UA''=''T,'')','EAIG403BCHZ0','1','D','10','26',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartStatus"','27','(''UA''=''T,'')','EAIG403BCHZ0','1','D','10','27',NULL,'Participant Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipanyChangeDate"','28','(''UA''=''T,'')','EAIG403BCHZ0','8','D','10','28',NULL,'Participant Status Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationCode"','29','(''UA''=''T,'')','EAIG403BCHZ0','4','D','10','29',NULL,'Location Code / HR Area',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRSubArea"','30','(''UA''=''T,'')','EAIG403BCHZ0','4','D','10','30',NULL,'HR Sub Area',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollStatusCode"','31','(''UA''=''T,'')','EAIG403BCHZ0','2','D','10','31',NULL,'Payroll Status code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnSalary"','32','(''UA''=''T,'')','EAIG403BCHZ0','10','D','10','32',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDhours"','33','(''UA''=''T,'')','EAIG403BCHZ0','4','D','10','33',NULL,'YTD Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','34','(''UA''=''T'')','EAIG403BCHZ0','100','D','10','34',NULL,'Email Address',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EAIG403BCH_20191202.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'AIG 403b Export','201912029','EMPEXPORT','ONDEMAND',NULL,'EAIG403BCH',NULL,NULL,NULL,'201912029','Dec  2 2019 12:21PM','Dec  2 2019 12:21PM','201912021',NULL,'','','201912021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EAIG403BCH_20191202.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201912029','EMPEXPORT','SCHEDULED',NULL,'EAIG403BCH',NULL,NULL,NULL,'201912029','Dec  2 2019 12:21PM','Dec  2 2019 12:21PM','201912021',NULL,'','','201912021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EAIG403BCH_20191202.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201912029','EMPEXPORT','TEST','Dec  2 2019  1:05PM','EAIG403BCH',NULL,NULL,NULL,'201912029','Dec  2 2019 12:00AM','Dec 30 1899 12:00AM','201911221','455','','','201911221',dbo.fn_GetTimedKey(),NULL,'us3mLaCHI1014',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EAIG403BCH_20191202.txt' END WHERE expFormatCode = 'EAIG403BCH';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAIG403BCH','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAIG403BCH','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAIG403BCH','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAIG403BCH','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAIG403BCH','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EAIG403BCH' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EAIG403BCH' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EAIG403BCH_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EAIG403BCH_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAIG403BCH','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAIG403BCH','D10','dbo.U_EAIG403BCH_drvTbl',NULL);
IF OBJECT_ID('U_EAIG403BCH_DedList') IS NULL
CREATE TABLE [dbo].[U_EAIG403BCH_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EAIG403BCH_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAIG403BCH_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(11) NULL,
    [drvFormatCode] varchar(2) NOT NULL,
    [drvPayGroupId] varchar(9) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvPartFirstName] varchar(8000) NULL,
    [drvPartMiddleName] varchar(8000) NULL,
    [drvPartLastName] varchar(8000) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvPayrollFrequency] char(1) NULL,
    [drvPayrollDate] datetime NULL,
    [drvEEMandatory] varchar(12) NULL,
    [drvERBasic] varchar(12) NULL,
    [drvERMatch] varchar(12) NULL,
    [drvERDesignatedRoth] varchar(12) NULL,
    [drvNotUsed] varchar(1) NOT NULL,
    [drvLoanID] varchar(2) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOrigHireDate] datetime NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvGenderId] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvPartStatus] varchar(1) NOT NULL,
    [drvParticipanyChangeDate] datetime NULL,
    [drvLocationCode] varchar(4) NOT NULL,
    [drvHRSubArea] varchar(1) NOT NULL,
    [drvPayrollStatusCode] varchar(2) NOT NULL,
    [drvAnnSalary] varchar(12) NULL,
    [drvYTDhours] varchar(12) NULL,
    [drvEmailAddress] varchar(50) NULL
);
IF OBJECT_ID('U_EAIG403BCH_EEList') IS NULL
CREATE TABLE [dbo].[U_EAIG403BCH_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EAIG403BCH_File') IS NULL
CREATE TABLE [dbo].[U_EAIG403BCH_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EAIG403BCH_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EAIG403BCH_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [EmpMandatory] numeric NULL,
    [ERBasic] numeric NULL,
    [ERMatching] numeric NULL,
    [EEDesignated] numeric NULL
);
IF OBJECT_ID('U_EAIG403BCH_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EAIG403BCH_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAIG403BCH]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: ChildNet

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 12/02/2019
Service Request Number: TekP-2019-11-1-0001

Purpose: AIG 403b Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAIG403BCH';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAIG403BCH';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAIG403BCH';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAIG403BCH';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAIG403BCH' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAIG403BCH', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EAIG403BCH', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EAIG403BCH';

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
    DELETE FROM dbo.U_EAIG403BCH_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAIG403BCH_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================

    
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '403BP, 403BF, 403CU,ROTH,ROTHP,403FX, ROTH, ROTHP, 403BP, 403BF, 403CU'                ;

    IF OBJECT_ID('U_EAIG403BCH_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAIG403BCH_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAIG403BCH_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EAIG403BCH_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAIG403BCH_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,EmpMandatory     = SUM(CASE WHEN PdhDedCode IN ('403BF', '403BP', '403CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,ERBasic     = SUM(CASE WHEN PdhDedCode IN ('403FX') THEN PdhERCurAmt ELSE 0.00 END)
        ,ERMatching     = SUM(CASE WHEN PdhDedCode IN ('403BF', '403BP', '403CU', 'ROTH', 'ROTHP') THEN PdhERCurAmt ELSE 0.00 END)        
        ,EEDesignated     = SUM(CASE WHEN PdhDedCode IN ('ROTH', 'ROTHP') THEN PdhEECurAmt ELSE 0.00 END)

    INTO dbo.U_EAIG403BCH_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EAIG403BCH_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EAIG403BCH_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAIG403BCH_PEarHist;
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
    INTO dbo.U_EAIG403BCH_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EAIG403BCH_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAIG403BCH_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAIG403BCH_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvFormatCode = 'CR'
        ,drvPayGroupId = '645820001'
        ,drvSSN = eepSSN
        ,drvEmployeeId = EecEmpNo
        ,drvPartFirstName = dbo.fn_AddDoubleQuotes(EepNameFirst)
        ,drvPartMiddleName = dbo.fn_AddDoubleQuotes(EepNameMiddle)
        ,drvPartLastName = dbo.fn_AddDoubleQuotes(EepNameLast)
        ,drvAddressLine1 = dbo.fn_AddDoubleQuotes(EepAddressLine1)
        ,drvAddressLine2 = dbo.fn_AddDoubleQuotes(EepAddressLine2)
        ,drvCity = dbo.fn_AddDoubleQuotes(EepAddressCity)
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvPayrollFrequency = (select Top 1 PgrPayFrequency from paygroup where pgrPaygroup =  eecPaygroup) 
        ,drvPayrollDate = PrgPayDate
        ,drvEEMandatory = CAST(CONVERT(DECIMAL(10,2),EmpMandatory) as varchar(12))
        ,drvERBasic = CAST(CONVERT(DECIMAL(10,2),ERBasic) as varchar(12))
        ,drvERMatch =  CAST(CONVERT(DECIMAL(10,2),ERMatching) as varchar(12))
        ,drvERDesignatedRoth = CAST(CONVERT(DECIMAL(10,2),EEDesignated) as varchar(12))
        ,drvNotUsed = ''
        ,drvLoanID = '00'
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOrigHireDate = eecdateoforiginalhire
        ,drvPhoneNumber = EepPhoneHomeNumber
        ,drvAddressLine3 = ''
        ,drvGenderId = eepgender
        ,drvMaritalStatus = eepMaritalStatus
        ,drvPartStatus = CASE WHEN eecemplstatus = 'T' THEN 'T' ELSE 'A' END
        ,drvParticipanyChangeDate = CASE  WHEN eecemplstatus = 'T' THEN eecdateoftermination
                                          WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire 
                                    END 
        ,drvLocationCode = '0001'
        ,drvHRSubArea = ''
        ,drvPayrollStatusCode = CASE WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' 
                                 ELSE 'FT' End
        ,drvAnnSalary = CAST(CONVERT(DECIMAL(10,2),EecAnnSalary) as varchar(12))
        ,drvYTDhours = CAST(PehCurHrsYTD as varchar(12))
        ,drvEmailAddress = EepAddressEMail
    INTO dbo.U_EAIG403BCH_drvTbl
    FROM dbo.U_EAIG403BCH_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EAIG403BCH_PDedHist WITH (NOLOCK)
       ON  PdhEEID = XEEID
    JOIN dbo.U_EAIG403BCH_PEarHist WITH (NOLOCK)
      ON PEHEEID = XEEID
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
ALTER VIEW dbo.dsi_vwEAIG403BCH_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAIG403BCH_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EAIG403BCH%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911251'
       ,expStartPerControl     = '201911251'
       ,expLastEndPerControl   = '201912029'
       ,expEndPerControl       = '201912029'
WHERE expFormatCode = 'EAIG403BCH';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAIG403BCH_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EAIG403BCH_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort