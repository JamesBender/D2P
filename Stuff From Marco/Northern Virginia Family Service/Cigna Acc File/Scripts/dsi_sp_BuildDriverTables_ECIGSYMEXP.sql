SET NOCOUNT ON;
IF OBJECT_ID('U_ECIGSYMEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIGSYMEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECIGSYMEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECIGSYMEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECIGSYMEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECIGSYMEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECIGSYMEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGSYMEXP];
GO
IF OBJECT_ID('U_ECIGSYMEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECIGSYMEXP_PEarHist];
GO
IF OBJECT_ID('U_ECIGSYMEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECIGSYMEXP_PDedHist];
GO
IF OBJECT_ID('U_ECIGSYMEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECIGSYMEXP_File];
GO
IF OBJECT_ID('U_ECIGSYMEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECIGSYMEXP_EEList];
GO
IF OBJECT_ID('U_ECIGSYMEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECIGSYMEXP_drvTbl];
GO
IF OBJECT_ID('U_ECIGSYMEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECIGSYMEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECIGSYMEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECIGSYMEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECIGSYMEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECIGSYMEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECIGSYMEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECIGSYMEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECIGSYMEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','Tek','ECIGSYMEXP','Cigna Acc, Crit Hosp Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ECIGSYMEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Legal Company Name"','1','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','1',NULL,'Legal Company Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client ID"','2','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','2',NULL,'Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE First Name"','3','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','3',NULL,'EE First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Last Name"','4','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','4',NULL,'EE Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Street Address"','5','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','5',NULL,'EE Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE City"','6','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','6',NULL,'EE City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE State"','7','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','7',NULL,'EE State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Zip Code"','8','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','8',NULL,'EE Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE SSN"','9','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','9',NULL,'EE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Gender"','10','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','10',NULL,'EE Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE DOB"','11','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','11',NULL,'EE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Smoker Status"','12','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','12',NULL,'EE Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Date of Hire"','13','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','13',NULL,'EE Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Status"','14','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','14',NULL,'EE Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Status Date"','15','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','15',NULL,'EE Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE LOA Type"','16','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','16',NULL,'EE LOA Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cigna Product Class"','17','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','17',NULL,'Cigna Product Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cigna Billing Account"','18','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','18',NULL,'Cigna Billing Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Elected"','19','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','19',NULL,'Benefit Elected',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Election Date"','20','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','20',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Effective Date"','21','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','21',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QLE/Revised Eligibility Date"','22','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','22',NULL,'QLE/Revised Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Type"','23','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','23',NULL,'Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AI/CI/HC Coverage Tier"','24','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','24',NULL,'AI/CI/HC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE CI Approved Coverage Amount"','25','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','25',NULL,'EE CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP CI Approved Coverage Amount"','26','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','26',NULL,'SP CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Coverage Effective Date"','27','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','27',NULL,'SP Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH CI Approved Coverage Amount"','28','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','28',NULL,'CH CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Coverage Effective Date"','29','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','29',NULL,'CH Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP First Name"','30','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','30',NULL,'SP First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Last Name"','31','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','31',NULL,'SP Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP SSN"','32','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','32',NULL,'SP SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Gender"','33','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','33',NULL,'SP Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP DOB"','34','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','34',NULL,'SP DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Smoker Status"','35','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','35',NULL,'SP Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Frequency"','36','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','36',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Deduction  Amt"','37','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','37',NULL,'Payroll Deduction  Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Premium Paid to Date"','38','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','38',NULL,'Premium Paid to Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AI termination Status Code"','39','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','39',NULL,'AI termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AI Termination Status Effective Date"','40','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','40',NULL,'AI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Status Code"','41','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','41',NULL,'CI Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Status Effective Date"','42','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','42',NULL,'CI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HC Termination Status Code"','43','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','43',NULL,'HC Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HC Termination Status Effective Date"','44','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','44',NULL,'HC Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Takeover Indicator"','45','(''DA''=''T,'')','ECIGSYMEXPZ0','50','H','01','45',NULL,'Takeover Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"File Type"','46','(''DA''=''T'')','ECIGSYMEXPZ0','50','H','01','46',NULL,'File Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLegalCompanyName"','1','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','1',NULL,'Legal Company Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientId"','2','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','2',NULL,'Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEFirstName"','3','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','3',NULL,'EE First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELastName"','4','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','4',NULL,'EE Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEAddress"','5','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','5',NULL,'EE Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECity"','6','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','6',NULL,'EE City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEState"','7','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','7',NULL,'EE State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEZipCode"','8','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','8',NULL,'EE Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEESSN"','9','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','9',NULL,'EE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEGener"','10','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','10',NULL,'EE Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDob"','11','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','11',NULL,'EE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEESmokerStatus"','12','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','12',NULL,'EE Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDateofHire"','13','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','13',NULL,'EE Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEStatus"','14','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','14',NULL,'EE Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEStatusDate"','15','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','15',NULL,'EE Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELOAType"','16','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','16',NULL,'EE LOA Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCignaProdClass"','17','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','17',NULL,'Cigna Product Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCignaBillingAcct"','18','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','18',NULL,'Cigna Billing Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitElected"','19','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','19',NULL,'Benefit Elected',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageElectionDate"','20','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','20',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovEffDate"','21','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','21',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOLEEligDate"','22','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','22',NULL,'QLE/Revised Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanType"','23','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','23',NULL,'Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAICIHCCovTier"','24','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','24',NULL,'AI/CI/HC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECIApprovedCovAmt"','25','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','25',NULL,'EE CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPCIApprviedCovAmt"','26','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','26',NULL,'SP CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPCovEffDate"','27','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','27',NULL,'SP Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHCHApprovedCovAmt"','28','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','28',NULL,'CH CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHCovEffDate"','29','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','29',NULL,'CH Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPFirstName"','30','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','30',NULL,'SP First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPLastName"','31','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','31',NULL,'SP Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPSSN"','32','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','32',NULL,'SP SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPGender"','33','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','33',NULL,'SP Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPDBO"','34','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','34',NULL,'SP DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPSmokeStatus"','35','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','35',NULL,'SP Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFreq"','36','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','36',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDedAmt"','37','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','37',NULL,'Payroll Deduction  Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremPaidToDate"','38','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','38',NULL,'Premium Paid to Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAITermStatusCode"','39','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','39',NULL,'AI termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAITermStaEffDAte"','40','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','40',NULL,'AI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCITermStatusCode"','41','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','41',NULL,'CI Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCITermStatusEffDate"','42','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','42',NULL,'CI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHCTermStatusCode"','43','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','43',NULL,'HC Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHCTermStatusEffDate"','44','(''UD101''=''T,'')','ECIGSYMEXPZ0','50','D','10','44',NULL,'HC Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTakeOverInd"','45','(''UA''=''T,'')','ECIGSYMEXPZ0','50','D','10','45',NULL,'Takeover Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileType"','46','(''UA''=''T'')','ECIGSYMEXPZ0','50','D','10','46',NULL,'File Type',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECIGSYMEXP_20200616.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cigna Acc, Crit Hosp Export','202004199','EMPEXPORT','ONDEMAND',NULL,'ECIGSYMEXP',NULL,NULL,NULL,'202004199','Apr 19 2020  5:12PM','Apr 19 2020  5:12PM','202004191',NULL,'','','202004191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECIGSYMEXP_20200616.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202004199','EMPEXPORT','SCH_CCCH',NULL,'ECIGSYMEXP',NULL,NULL,NULL,'202004199','Apr 19 2020  5:12PM','Apr 19 2020  5:12PM','202004191',NULL,'','','202004191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECIGSYMEXP_20200616.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202004199','EMPEXPORT','OEACTIVE',NULL,'ECIGSYMEXP',NULL,NULL,NULL,'202004199','Apr 19 2020  5:12PM','Apr 19 2020  5:12PM','202004191',NULL,'','','202004191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECIGSYMEXP_20200616.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202004199','EMPEXPORT','OEPASSIVE',NULL,'ECIGSYMEXP',NULL,NULL,NULL,'202004199','Apr 19 2020  5:12PM','Apr 19 2020  5:12PM','202004191',NULL,'','','202004191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECIGSYMEXP_20200616.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202006109','EMPEXPORT','TEST','Jun 10 2020 12:54PM','ECIGSYMEXP',NULL,NULL,NULL,'202006109','Jun 10 2020 12:00AM','Dec 30 1899 12:00AM','202005151','302','','','202005151',dbo.fn_GetTimedKey(),NULL,'us3lKiVEN1002',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ECIGSYMEXP_20200616.txt' END WHERE expFormatCode = 'ECIGSYMEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGSYMEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGSYMEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGSYMEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGSYMEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGSYMEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGSYMEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ECIGSYMEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECIGSYMEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ECIGSYMEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIGSYMEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGSYMEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGSYMEXP','D10','dbo.U_ECIGSYMEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ECIGSYMEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECIGSYMEXP] (
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
IF OBJECT_ID('U_ECIGSYMEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ECIGSYMEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECIGSYMEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECIGSYMEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvLegalCompanyName] varchar(28) NOT NULL,
    [drvClientId] varchar(6) NOT NULL,
    [drvEEFirstName] varchar(100) NULL,
    [drvEELastName] varchar(100) NULL,
    [drvEEAddress] varchar(6000) NULL,
    [drvEECity] varchar(255) NULL,
    [drvEEState] varchar(255) NULL,
    [drvEEZipCode] varchar(5) NULL,
    [drvEESSN] nvarchar(258) NULL,
    [drvEEGener] char(1) NULL,
    [drvEEDob] datetime NULL,
    [drvEESmokerStatus] varchar(1) NOT NULL,
    [drvEEDateofHire] datetime NULL,
    [drvEEStatus] varchar(1) NULL,
    [drvEEStatusDate] datetime NULL,
    [drvEELOAType] varchar(1) NULL,
    [drvCignaProdClass] varchar(3) NOT NULL,
    [drvCignaBillingAcct] varchar(3) NOT NULL,
    [drvBenefitElected] varchar(3) NULL,
    [drvCoverageElectionDate] varchar(1) NOT NULL,
    [drvCovEffDate] datetime NULL,
    [drvOLEEligDate] varchar(1) NOT NULL,
    [drvPlanType] varchar(15) NULL,
    [drvAICIHCCovTier] varchar(10) NULL,
    [drvEECIApprovedCovAmt] varchar(5) NULL,
    [drvSPCIApprviedCovAmt] varchar(5) NULL,
    [drvSPCovEffDate] datetime NULL,
    [drvCHCHApprovedCovAmt] varchar(4) NULL,
    [drvCHCovEffDate] datetime NULL,
    [drvSPFirstName] varchar(100) NULL,
    [drvSPLastName] varchar(100) NULL,
    [drvSPSSN] char(11) NULL,
    [drvSPGender] char(1) NULL,
    [drvSPDBO] datetime NULL,
    [drvSPSmokeStatus] varchar(1) NOT NULL,
    [drvPayrollFreq] varchar(2) NOT NULL,
    [drvPayrollDedAmt] varchar(256) NULL,
    [drvPremPaidToDate] varchar(1) NOT NULL,
    [drvAITermStatusCode] varchar(1) NULL,
    [drvAITermStaEffDAte] datetime NULL,
    [drvCITermStatusCode] varchar(1) NULL,
    [drvCITermStatusEffDate] datetime NULL,
    [drvHCTermStatusCode] varchar(1) NULL,
    [drvHCTermStatusEffDate] datetime NULL,
    [drvTakeOverInd] varchar(1) NOT NULL,
    [drvFileType] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECIGSYMEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECIGSYMEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECIGSYMEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECIGSYMEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ECIGSYMEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECIGSYMEXP_PDedHist] (
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
IF OBJECT_ID('U_ECIGSYMEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECIGSYMEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGSYMEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Symplr

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 04/19/2020
Service Request Number: TekP-2020-02-18-0002

Purpose: Cigna Acc, Crit Hosp Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECIGSYMEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECIGSYMEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECIGSYMEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECIGSYMEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECIGSYMEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGSYMEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGSYMEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGSYMEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGSYMEXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECIGSYMEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECIGSYMEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECIGSYMEXP';

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
    DELETE FROM dbo.U_ECIGSYMEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECIGSYMEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ILL, ILLEC, ILLEF, ILLES,HOSP,ACC';

    IF OBJECT_ID('U_ECIGSYMEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGSYMEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECIGSYMEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@EndDate - 30);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EmployeeElectedRateorPct',@DedList);

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

    --Benefit Calculation
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;


    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_ECIGSYMEXP D
    JOIN dbo.U_dsi_bdm_ECIGSYMEXP E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ECIGSYMEXP
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ECIGSYMEXP
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ECIGSYMEXP
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ECIGSYMEXP
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedEELstAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ECIGSYMEXP
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedEELstAmt)
    FROM dbo.U_dsi_bdm_ECIGSYMEXP
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECIGSYMEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGSYMEXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_ECIGSYMEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECIGSYMEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ECIGSYMEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGSYMEXP_PEarHist;
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
    INTO dbo.U_ECIGSYMEXP_PEarHist
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
    -- DETAIL RECORD - U_ECIGSYMEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECIGSYMEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGSYMEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvLegalCompanyName = 'Vendor Credentialing Service'
        ,drvClientId = '426573'
        ,drvEEFirstName = EepNameFirst
        ,drvEELastName = EepNameLast
        ,drvEEAddress = dbo.dsi_fnRemoveChars('.,/-',Concat(eepAddressLine1,' ' , eepAddressLine2))
        ,drvEECity = EepAddressCity
        ,drvEEState = EepAddressState
        ,drvEEZipCode = LEFT(EepAddressZipCode,5)
        ,drvEESSN = QuoteName(rtrim(eepSSN),'"')
        ,drvEEGener = eepGender
        ,drvEEDob = EepDateOfBirth
        ,drvEESmokerStatus = 'N'
        --If EecDateOfOriginalHire does not = EecDateOfLastHire, send EecDateOfLastHire, else send EecDateOfOriginalHire
        ,drvEEDateofHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire ELSE EecDateOfOriginalHire END
        ,drvEEStatus = CASE WHEN EecEmplStatus = 'T' and EecTermReason  ='203' THEN  'D'
                            WHEN EecEmplStatus  in ('L','T')  THEN  EecEmplStatus
                            ELSE 'A'
                       END

        ,drvEEStatusDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                WHEN EecEmplStatus = 'L' THEN DateAdd(Day,-1,EecEmplStatusStartDate)
                           END
        ,drvEELOAType = CASE WHEN EecEmplStatus ='L' THEN 'U' END -- else leave blank
        ,drvCignaProdClass = '001'
        ,drvCignaBillingAcct = '001'
        
        ,drvBenefitElected = code
        ,drvCoverageElectionDate = ''
        ,drvCovEffDate = bdmBenStartDate
        ,drvOLEEligDate = ''
        ,drvPlanType = CASE WHEN code in ('VHC') THEN 'HC960678 Plan 1'    
                                   WHEN code in ('VAI') THEN 'AI961390 Mid'
                                   WHEN code in ('VCI') THEN 'CI961325'
                             END
        /*
        if eeddedcode = ACC or HOSP and EedBenOption  = EE send EE
        if eeddedcode = ACC or HOSP and EedBenOption  = EES or EEDP send EE Plus SP
        if eeddedcode = ACC or HOSP and EedBenOption  = EEC send EE Plus CH
        if eeddedcode = ACC or HOSP and EedBenOption  = EEF or EEDPF send Family

        if eeddedcode = ILL send EE
        if eeddedcode = ILLES send EE Plus SP
        if eeddedcode = ILLEC send EE Plus CH
        if eeddedcode = ILLEF send EE Plus Family 
        */
        ,drvAICIHCCovTier = Case WHEN Code in ('VHC','VAI') and bdmBenOption = 'EE' THEN 'EE'
                                 WHEN Code in ('VHC','VAI') and bdmBenOption in ('EES','EEDP') THEN 'EE Plus SP'
                                 WHEN Code in ('VHC','VAI') and bdmBenOption in ('EEC') THEN 'EE Plus CH'
                                 WHEN Code in ('VHC','VAI') and bdmBenOption in ('EEF','EEDPF') THEN 'Family'
                                 WHEN ILL is not null then 'EE'
                                 WHEN ILLES is not null then 'EE Plus SP'
                                 WHEN ILLEC is not null then 'EE Plus CH'
                                 WHEN ILLEF is not null then 'Family'
                                  
                            END
        ,drvEECIApprovedCovAmt = CASE WHEN Code = 'VCI' THEN '10000' END
        ,drvSPCIApprviedCovAmt =   CASE WHEN ILLES is not null or ILLEF is not null then '10000' END
        ,drvSPCovEffDate = SpsBenStartDate 
        ,drvCHCHApprovedCovAmt = CASE WHEN ChdBenStartDate is not null and code  in ('VCI') and (ILLEC_BENSTATUS = 'A' and ILLEF_BENSTATUS = 'A') then '2500' END
        ,drvCHCovEffDate = CASE WHEN   (ILLEC_BENSTATUS = 'A' and ILLEF_BENSTATUS = 'A') THEN  ChdBenStartDate END
        ,drvSPFirstName = ConNameFirst
        ,drvSPLastName = ConNameLast
        ,drvSPSSN = conSSN
        ,drvSPGender = ConGender
        ,drvSPDBO = ConDateofBirth
        ,drvSPSmokeStatus = 'N'
        ,drvPayrollFreq = '26'
        ,drvPayrollDedAmt = CASE WHEN ISNULL(bdmusgfield1,'') = '0.00' THEN CAST(bcaeeamt as varchar(12)) ELSE bdmusgfield1 END
        ,drvPremPaidToDate = ''
        /*if eeddedcode = HOSP send VHC
            if eeddedcode = ACC send VAI
        if eeddedcode = ILL, ILLEC, ILLEF, ILLES send VCI
    */
        ,drvAITermStatusCode = CASE WHEN Code = 'VAI'  and EecEmplStatus <> 'T 'and bdmBenStatus in ('T', 'C') THEN 'T' END --send T else leave blank
        ,drvAITermStaEffDAte = CASE WHEN Code = 'VAI'  and EecEmplStatus <> 'T 'and bdmBenStatus in ('T', 'C') THEN bdmbenstopdate END  
        ,drvCITermStatusCode = CASE WHEN (Code = 'VCI'  and  EecEmplStatus <> 'T' and bdmBenStatus in ('T', 'C') ) AND not (ILL_BENSTATUS <> 'A' OR ILLEC_BENSTATUS <> 'A'  OR ILLEF_BENSTATUS <> 'A'  OR ILLES_BENSTATUS <> 'A' ) THEN 'T' END
        ,drvCITermStatusEffDate = CASE WHEN (Code = 'VCI'  and EecEmplStatus <> 'T' and bdmBenStatus in ('T', 'C'))  AND not (ILL_BENSTATUS <> 'A' OR ILLEC_BENSTATUS <> 'A'  OR ILLEF_BENSTATUS <> 'A'  OR ILLES_BENSTATUS <> 'A' )  THEN bdmbenstopdate END  
        ,drvHCTermStatusCode = CASE WHEN Code = 'VHC'  and EecEmplStatus <> 'T 'and bdmBenStatus in ('T', 'C') THEN 'T' END
        ,drvHCTermStatusEffDate =  CASE WHEN Code = 'VHC'  and EecEmplStatus <> 'T 'and bdmBenStatus in ('T', 'C') THEN bdmbenstopdate END 
        ,drvTakeOverInd = ''
        ,drvFileType = 'F'
    INTO dbo.U_ECIGSYMEXP_drvTbl
    FROM dbo.U_ECIGSYMEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (select 
    bdmeeid,bdmcoid,
    CASE WHEN BdmDedcode in ('HOSP') THEN 'VHC'    
    WHEN BdmDedcode in ('ACC') THEN 'VAI'
    WHEN BdmDedcode in ('ILL','ILLEC','ILLEF','ILLES','ILLEC') THEN 'VCI' 
    END as code,
     max(bdmbenstartdate) as bdmbenstartdate
     ,max(bdmbenstopdate) as bdmbenstopdate
    ,max(bdmBenOption) as bdmBenOption
    ,max(bdmbenstatus) as bdmbenstatus
    ,max(CASE WHEN bdmdedcode in ( 'HOSP', 'ACC', 'ILLEF' , 'ILLES') and bdmrelationship in ('SPS','DP')  THEN bdmbenstartdate END) as SpsBenStartDate
    ,max(CASE WHEN bdmdedcode in ( 'HOSP', 'ACC', 'ILLEF' , 'ILLES') and bdmrelationship in ('SPS','DP')  THEN bdmdeprecid END) as SpsRecId
    ,max(CASE WHEN bdmdedcode in ( 'HOSP', 'ACC', 'ILLEF' , 'ILLES','ILLEC') and bdmrelationship in ('CHL','DPC','CHD','STC')  THEN bdmbenstartdate END) as ChdBenStartDate
    ,max(CASE WHEN bdmdedcode in ('ILL') THEN '1' END) as ILL
    ,max(CASE WHEN bdmdedcode in ('ILLEC') THEN '1' END) as ILLEC
    ,max(CASE WHEN bdmdedcode in ('ILLEF') THEN '1' END) as ILLEF
    ,max(CASE WHEN bdmdedcode in ('ILLES') THEN '1' END) as ILLES
    ,max(CASE WHEN bdmdedcode in ('ILL') THEN bdmbenstatus END) as ILL_BENSTATUS
    ,max(CASE WHEN bdmdedcode in ('ILLEC') THEN bdmbenstatus END) as ILLEC_BENSTATUS
    ,max(CASE WHEN bdmdedcode in ('ILLEF') THEN bdmbenstatus END) as ILLEF_BENSTATUS
    ,max(CASE WHEN bdmdedcode in ('ILLES') THEN bdmbenstatus END) as ILLES_BENSTATUS
    ,max(bdmusgfield1) as bdmusgfield1
    ,max(bcaeeamt) as bcaeeamt
from U_dsi_BDM_ECIGSYMEXP 
    LEFT JOIN dbo.u_dsi_bdm_BenCalculationAmounts ON bdmeeid = bcaeeid AND bdmcoid = bcacoid
    AND bdmdedcode = bcadedcode --where bdmeeid = 'BSDK4Q0180K0'
 group by bdmeeid,bdmcoid,CASE WHEN BdmDedcode in ('HOSP') THEN 'VHC'    
    WHEN BdmDedcode in ('ACC') THEN 'VAI'
    WHEN BdmDedcode in ('ILL','ILLEC','ILLEF','ILLES','ILLEC') THEN 'VCI' 
    END ) as bdmConsolidated
 on bdmeeid = xeeid
 and bdmcoid = xcoid
      LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = SpsRecId

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
ALTER VIEW dbo.dsi_vwECIGSYMEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECIGSYMEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECIGSYMEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202004121'
       ,expStartPerControl     = '202004121'
       ,expLastEndPerControl   = '202004199'
       ,expEndPerControl       = '202004199'
WHERE expFormatCode = 'ECIGSYMEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECIGSYMEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECIGSYMEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort