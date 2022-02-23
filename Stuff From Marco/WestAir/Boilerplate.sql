SET NOCOUNT ON;
IF OBJECT_ID('U_ECIGNCCHOS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIGNCCHOS_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECIGNCCHOS_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECIGNCCHOS' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECIGNCCHOS_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECIGNCCHOS_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECIGNCCHOS') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGNCCHOS];
GO
IF OBJECT_ID('U_ECIGNCCHOS_File') IS NOT NULL DROP TABLE [dbo].[U_ECIGNCCHOS_File];
GO
IF OBJECT_ID('U_ECIGNCCHOS_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECIGNCCHOS_EEList];
GO
IF OBJECT_ID('U_ECIGNCCHOS_drvTbl_Tmp') IS NOT NULL DROP TABLE [dbo].[U_ECIGNCCHOS_drvTbl_Tmp];
GO
IF OBJECT_ID('U_ECIGNCCHOS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECIGNCCHOS_drvTbl];
GO
IF OBJECT_ID('U_ECIGNCCHOS_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECIGNCCHOS_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECIGNCCHOS') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECIGNCCHOS];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECIGNCCHOS';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECIGNCCHOS';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECIGNCCHOS';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECIGNCCHOS';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECIGNCCHOS';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECIGNCCHOS','Cigna Accident/Critical Illness/Hospital Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ECIGNCCHOSZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Legal Company Name"','1','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','1',NULL,'Legal Company Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client ID"','2','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','2',NULL,'Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE First Name"','3','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','3',NULL,'EE First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Last Name"','4','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','4',NULL,'EE Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Street Address"','5','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','5',NULL,'EE Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE City"','6','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','6',NULL,'EE City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE State"','7','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','7',NULL,'EE State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Zip Code"','8','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','8',NULL,'EE Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE SSN"','9','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','9',NULL,'EE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Gender"','10','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','10',NULL,'EE Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE DOB"','11','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','11',NULL,'EE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Smoker Status"','12','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','12',NULL,'EE Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Date of Hire"','13','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','13',NULL,'EE Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Status"','14','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','14',NULL,'EE Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Status Date"','15','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','15',NULL,'EE Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE LOA Type"','16','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','16',NULL,'EE LOA Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cigna Product Class"','17','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','17',NULL,'Cigna Product Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cigna Billing Account"','18','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','18',NULL,'Cigna Billing Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Elected"','19','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','19',NULL,'Benefit Elected',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Election Date"','20','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','20',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Effective Date"','21','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','21',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QLE/Revised Eligibility Date"','22','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','22',NULL,'QLE/Revised Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Type"','23','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','23',NULL,'Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AI/CI/HC Coverage Tier"','24','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','24',NULL,'AI/CI/HC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE CI Approved Coverage Amount"','25','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','25',NULL,'EE CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP CI Approved Coverage Amount"','26','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','26',NULL,'SP CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Coverage Effective Date"','27','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','27',NULL,'SP Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH CI Approved Coverage Amount"','28','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','28',NULL,'CH CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Coverage Effective Date"','29','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','29',NULL,'CH Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP First Name"','30','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','30',NULL,'SP First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Last Name"','31','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','31',NULL,'SP Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP SSN"','32','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','32',NULL,'SP SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Gender"','33','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','33',NULL,'SP Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP DOB"','34','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','34',NULL,'SP DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Smoker Status"','35','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','35',NULL,'SP Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Frequency"','36','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','36',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Deduction Amt"','37','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','37',NULL,'Payroll Deduction Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Premium Paid to Date"','38','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','38',NULL,'Premium Paid to Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AI termination Status Code"','39','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','39',NULL,'AI termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AI Termination Status Effective Date"','40','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','40',NULL,'AI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Status Code"','41','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','41',NULL,'CI Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Status Effective Date"','42','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','42',NULL,'CI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HC Termination Status Code"','43','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','43',NULL,'HC Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HC Termination Status Effective Date"','44','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','44',NULL,'HC Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Takeover Indicator"','45','(''DA''=''T,'')','ECIGNCCHOSZ0','50','H','01','45',NULL,'Takeover Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"File Type"','46','(''DA''=''T'')','ECIGNCCHOSZ0','50','H','01','46',NULL,'File Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLegalCompanyName"','1','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','1',NULL,'Legal Company Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientId"','2','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','2',NULL,'Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEFirstName"','3','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','3',NULL,'EE First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELastName"','4','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','4',NULL,'EE Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEStreetAddress"','5','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','5',NULL,'EE Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECity"','6','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','6',NULL,'EE City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEState"','7','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','7',NULL,'EE State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEZipCode"','8','(''UNT0''=''T,'')','ECIGNCCHOSZ0','50','D','10','8',NULL,'EE Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEESSN"','9','(''UNT0''=''T,'')','ECIGNCCHOSZ0','50','D','10','9',NULL,'EE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEGender"','10','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','10',NULL,'EE Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDateOfBirth"','11','(''UD101''=''T,'')','ECIGNCCHOSZ0','50','D','10','11',NULL,'EE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEESmokerStatus"','12','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','12',NULL,'EE Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDateOfHire"','13','(''UD101''=''T,'')','ECIGNCCHOSZ0','50','D','10','13',NULL,'EE Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEStatus"','14','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','14',NULL,'EE Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEStatusDate"','15','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','15',NULL,'EE Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELoaType"','16','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','16',NULL,'EE LOA Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECignaProductClass"','17','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','17',NULL,'Cigna Product Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECignaBillingAccount"','18','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','18',NULL,'Cigna Billing Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitElected"','19','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','19',NULL,'Benefit Elected',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageElectionDate"','20','(''UD101''=''T,'')','ECIGNCCHOSZ0','50','D','10','20',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDate"','21','(''UD101''=''T,'')','ECIGNCCHOSZ0','50','D','10','21',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQleRevisedEligibilityDate"','22','(''UD101''=''T,'')','ECIGNCCHOSZ0','50','D','10','22',NULL,'QLE/Revised Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanType"','23','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','23',NULL,'Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAiCiHcCoverageTier"','24','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','24',NULL,'AI/CI/HC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECiApprovedCoverageAmount"','25','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','25',NULL,'EE CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPCiApprovedCoverageAmount"','26','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','26',NULL,'SP CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpCoverageEffectiveDate"','27','(''UD101''=''T,'')','ECIGNCCHOSZ0','50','D','10','27',NULL,'SP Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChCiApprovedCoverageAmount"','28','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','28',NULL,'CH CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChCoverageEffectiveDate"','29','(''UD101''=''T,'')','ECIGNCCHOSZ0','50','D','10','29',NULL,'CH Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpFirstName"','30','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','30',NULL,'SP First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpLastName"','31','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','31',NULL,'SP Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpSSN"','32','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','32',NULL,'SP SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpGender"','33','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','33',NULL,'SP Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpDateOfBirth"','34','(''UD101''=''T,'')','ECIGNCCHOSZ0','50','D','10','34',NULL,'SP DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpSmokerStatus"','35','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','35',NULL,'SP Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFrequency"','36','(''UNT0''=''T,'')','ECIGNCCHOSZ0','50','D','10','36',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDeductionAmount"','37','(''UNT2''=''T,'')','ECIGNCCHOSZ0','50','D','10','37',NULL,'Payroll Deduction Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"devPremiumPaidToDate"','38','(''UD101''=''T,'')','ECIGNCCHOSZ0','50','D','10','38',NULL,'Premium Paid to Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAiTermStatusCode"','39','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','39',NULL,'AI termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAiTermStatusEffectiveDate"','40','(''UD101''=''T,'')','ECIGNCCHOSZ0','50','D','10','40',NULL,'AI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiTermStatusCode"','41','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','41',NULL,'CI Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiTermStatusEffectiveDate"','42','(''UD101''=''T,'')','ECIGNCCHOSZ0','50','D','10','42',NULL,'CI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHcTermStatusCode"','43','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','43',NULL,'HC Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHcTermStatusEffectiveDate"','44','(''UD101''=''T,'')','ECIGNCCHOSZ0','50','D','10','44',NULL,'HC Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTakeoverIndicator"','45','(''UA''=''T,'')','ECIGNCCHOSZ0','50','D','10','45',NULL,'Takeover Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileType"','46','(''UA''=''T'')','ECIGNCCHOSZ0','50','D','10','46',NULL,'File Type',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ECIGNCCHOS_20200107.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cigna Accident & Hospital Exp','202001079','EMPEXPORT','ONDEMAND',NULL,'ECIGNCCHOS',NULL,NULL,NULL,'202001079','Jan  7 2020  6:13AM','Jan  7 2020  6:13AM','202001071',NULL,'','','202001071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ECIGNCCHOS_20200107.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202001079','EMPEXPORT','TEST',NULL,'ECIGNCCHOS',NULL,NULL,NULL,'202001079','Jan  7 2020  6:13AM','Jan  7 2020  6:13AM','202001071',NULL,'','','202001071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ECIGNCCHOS_20200107.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202001079','EMPEXPORT','CCH_SCHED',NULL,'ECIGNCCHOS',NULL,NULL,NULL,'202001079','Jan  7 2020  6:13AM','Jan  7 2020  6:13AM','202001071',NULL,'','','202001071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ECIGNCCHOS_20200107.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202001079','EMPEXPORT','OEACTIVE',NULL,'ECIGNCCHOS',NULL,NULL,NULL,'202001079','Jan  7 2020  6:13AM','Jan  7 2020  6:13AM','202001071',NULL,'','','202001071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ECIGNCCHOS_20200107.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202001079','EMPEXPORT','OEPASSIVE',NULL,'ECIGNCCHOS',NULL,NULL,NULL,'202001079','Jan  7 2020  6:13AM','Jan  7 2020  6:13AM','202001071',NULL,'','','202001071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ECIGNCCHOS_20200127.txt' END WHERE expFormatCode = 'ECIGNCCHOS';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNCCHOS','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNCCHOS','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNCCHOS','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNCCHOS','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNCCHOS','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ECIGNCCHOS' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECIGNCCHOS' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ECIGNCCHOS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIGNCCHOS_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGNCCHOS','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGNCCHOS','D10','dbo.U_ECIGNCCHOS_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGNCCHOS','T90','dbo.U_ECIGNCCHOS_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_ECIGNCCHOS') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECIGNCCHOS] (
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
IF OBJECT_ID('U_ECIGNCCHOS_DedList') IS NULL
CREATE TABLE [dbo].[U_ECIGNCCHOS_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECIGNCCHOS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECIGNCCHOS_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NULL,
    [drvLegalCompanyName] varchar(7) NULL,
    [drvClientId] varchar(6) NULL,
    [drvEEFirstName] varchar(100) NULL,
    [drvEELastName] varchar(102) NULL,
    [drvEEStreetAddress] varchar(511) NULL,
    [drvEECity] varchar(255) NULL,
    [drvEEState] varchar(255) NULL,
    [drvEEZipCode] varchar(5) NULL,
    [drvEESSN] char(11) NULL,
    [drvEEGender] char(1) NULL,
    [drvEEDateOfBirth] datetime NULL,
    [drvEESmokerStatus] varchar(1) NULL,
    [drvEEDateOfHire] datetime NULL,
    [drvEEStatus] varchar(1) NULL,
    [drvEEStatusDate] nvarchar(4000) NULL,
    [drvEELoaType] varchar(1) NULL,
    [drvEECignaProductClass] varchar(3) NULL,
    [drvEECignaBillingAccount] varchar(3) NULL,
    [drvBenefitElected] varchar(3) NULL,
    [drvCoverageElectionDate] varchar(1) NULL,
    [drvCoverageEffectiveDate] datetime NULL,
    [drvQleRevisedEligibilityDate] varchar(1) NULL,
    [drvPlanType] varchar(9) NULL,
    [drvAiCiHcCoverageTier] varchar(10) NULL,
    [drvEECiApprovedCoverageAmount] varchar(30) NULL,
    [drvSPCiApprovedCoverageAmount] varchar(256) NULL,
    [drvSpCoverageEffectiveDate] datetime NULL,
    [drvChCiApprovedCoverageAmount] varchar(256) NULL,
    [drvChCoverageEffectiveDate] datetime NULL,
    [drvSpFirstName] varchar(100) NULL,
    [drvSpLastName] varchar(100) NULL,
    [drvSpSSN] char(11) NULL,
    [drvSpGender] char(1) NULL,
    [drvSpDateOfBirth] datetime NULL,
    [drvSpSmokerStatus] varchar(1) NULL,
    [drvPayrollFrequency] varchar(2) NULL,
    [drvPayrollDeductionAmount] money NULL,
    [devPremiumPaidToDate] datetime NULL,
    [drvAiTermStatusCode] varchar(1) NULL,
    [drvAiTermStatusEffectiveDate] datetime NULL,
    [drvCiTermStatusCode] varchar(1) NULL,
    [drvCiTermStatusEffectiveDate] datetime NULL,
    [drvHcTermStatusCode] varchar(1) NULL,
    [drvHcTermStatusEffectiveDate] datetime NULL,
    [drvTakeoverIndicator] varchar(1) NULL,
    [drvFileType] varchar(1) NULL,
    [drvEmpSmoke] varchar(1) NULL,
    [drvConSmoker] varchar(1) NULL
);
IF OBJECT_ID('U_ECIGNCCHOS_drvTbl_Tmp') IS NULL
CREATE TABLE [dbo].[U_ECIGNCCHOS_drvTbl_Tmp] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvLegalCompanyName] varchar(7) NOT NULL,
    [drvClientId] varchar(6) NOT NULL,
    [drvEEFirstName] varchar(100) NULL,
    [drvEELastName] varchar(102) NULL,
    [drvEEStreetAddress] varchar(511) NULL,
    [drvEECity] varchar(255) NULL,
    [drvEEState] varchar(255) NULL,
    [drvEEZipCode] varchar(5) NULL,
    [drvEESSN] char(11) NULL,
    [drvEEGender] char(1) NULL,
    [drvEEDateOfBirth] datetime NULL,
    [drvEESmokerStatus] varchar(1) NULL,
    [drvEEDateOfHire] datetime NULL,
    [drvEEStatus] varchar(1) NOT NULL,
    [drvEEStatusDate] nvarchar(4000) NULL,
    [drvEELoaType] varchar(1) NOT NULL,
    [drvEECignaProductClass] varchar(3) NOT NULL,
    [drvEECignaBillingAccount] varchar(3) NOT NULL,
    [drvBenefitElected] varchar(3) NULL,
    [drvCoverageElectionDate] varchar(1) NOT NULL,
    [drvCoverageEffectiveDate] datetime NULL,
    [drvQleRevisedEligibilityDate] varchar(1) NOT NULL,
    [drvPlanType] varchar(9) NULL,
    [drvAiCiHcCoverageTier] varchar(10) NULL,
    [drvEECiApprovedCoverageAmount] varchar(30) NULL,
    [drvSPCiApprovedCoverageAmount] varchar(256) NULL,
    [drvSpCoverageEffectiveDate] datetime NULL,
    [drvChCiApprovedCoverageAmount] varchar(256) NULL,
    [drvChCoverageEffectiveDate] datetime NULL,
    [drvSpFirstName] varchar(100) NULL,
    [drvSpLastName] varchar(100) NULL,
    [drvSpSSN] char(11) NULL,
    [drvSpGender] char(1) NULL,
    [drvSpDateOfBirth] datetime NULL,
    [drvSpSmokerStatus] varchar(1) NULL,
    [drvPayrollFrequency] varchar(2) NOT NULL,
    [drvPayrollDeductionAmount] money NULL,
    [devPremiumPaidToDate] datetime NULL,
    [drvAiTermStatusCode] varchar(1) NULL,
    [drvAiTermStatusEffectiveDate] datetime NULL,
    [drvCiTermStatusCode] varchar(1) NULL,
    [drvCiTermStatusEffectiveDate] datetime NULL,
    [drvHcTermStatusCode] varchar(1) NULL,
    [drvHcTermStatusEffectiveDate] datetime NULL,
    [drvTakeoverIndicator] varchar(1) NOT NULL,
    [drvFileType] varchar(1) NOT NULL,
    [drvEmpSmoke] varchar(1) NULL,
    [drvConSmoker] varchar(1) NULL
);
IF OBJECT_ID('U_ECIGNCCHOS_EEList') IS NULL
CREATE TABLE [dbo].[U_ECIGNCCHOS_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECIGNCCHOS_File') IS NULL
CREATE TABLE [dbo].[U_ECIGNCCHOS_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGNCCHOS]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Westair Gasses and Equipment

Created By: James Bender / Marco Lagrosa
Business Analyst: Lea King
Create Date: 01/27/2019
Service Request Number: TekP-2019-10-24-0001

Purpose: Cigna Accident and Hospital Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECIGNCCHOS';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECIGNCCHOS';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECIGNCCHOS';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECIGNCCHOS';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECIGNCCHOS' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNCCHOS', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNCCHOS', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNCCHOS', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNCCHOS', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNCCHOS', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECIGNCCHOS';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECIGNCCHOS', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECIGNCCHOS';
    SELECT @FileMinCovDate = CAST('1/1/2020' as DATETIME);

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
    DELETE FROM dbo.U_ECIGNCCHOS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECIGNCCHOS_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CIACC,CIHOS';

    IF OBJECT_ID('U_ECIGNCCHOS_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNCCHOS_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECIGNCCHOS_DedList
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


    UPDATE dbo.U_dsi_bdm_ECIGNCCHOS 
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ECIGNCCHOS
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;


    UPDATE dbo.U_dsi_bdm_ECIGNCCHOS
       SET BdmUSGField2 = DbnDepBPlanTVID
   FROM dbo.U_dsi_bdm_ECIGNCCHOS
   JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
       ON DbnEEID = BdmEEID
       AND DbnCOID = BdmCOID
       AND DbnDedCode = BdmDedCode
   WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

   

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECIGNCCHOS_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECIGNCCHOS_drvTbl_Tmp','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNCCHOS_drvTbl_Tmp;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvLegalCompanyName = 'West Air Gases and Equipment' 
        ,drvClientId = '57535'
        ,drvEEFirstName = EepNameFirst
        ,drvEELastName = '"' + EepNameLast + '"'
        ,drvEEStreetAddress = EepAddressLine1 + ' ' + EepAddressLine2
        ,drvEECity = EepAddressCity
        ,drvEEState = EepAddressState
        ,drvEEZipCode = LEFT(EepAddressZipCode, 5)
        ,drvEESSN = eepSSN
        ,drvEEGender = EepGender
        ,drvEEDateOfBirth = EepDateOfBirth
        ,drvEESmokerStatus = EepIsSmoker
        ,drvEEDateOfHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOFLastHire ELSE EecDateOfOriginalHire END
        ,drvEEStatus =  CASE EecEmplStatus
                             WHEN 'T' THEN 
                                CASE WHEN EecTermReason = '203' THEN 'D' ELSE 'T' END
                            WHEN 'L' THEN 'L'
                            ELSE 'A'
                        END
        ,drvEEStatusDate = CASE WHEN EecEmplStatus = 'T' THEN FORMAT(EecDateOfTermination, 'MM/dd/yyyy') ELSE '' END
        ,drvEELoaType = 'U'
        ,drvEECignaProductClass = '001'
        ,drvEECignaBillingAccount = '001'
        ,drvBenefitElected = CASE BdmDedCode 
                                    WHEN 'CIHOS' THEN 'VHC'
                                    WHEN 'CIACC' THEN 'VAI'
                        
                                END
        ,drvCoverageElectionDate = '' --(SELECT MAX(EdhEffDate) from EmpHDed where EdhEEID = xEEID  AND EdhCOID = xCOID)
        ,drvCoverageEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) 
        ,drvQleRevisedEligibilityDate = ''
        ,drvPlanType = CASE BdmDedCode 
                                    WHEN 'CIHOS' THEN 'HC960623'
                                    WHEN 'CIACC' THEN 'AI961306'
                                END
                                /*
if eeddedcode = CIEE and not CISC send EE
if eeddedcode = CISC or (CIEE and CISC) send Family
if eeddedcode = ACDI  or HIP and EedBenOption  = EE send EE
if eeddedcode = ACDI  or HIP and EedBenOption  = EES send EE Plus SP
if eeddedcode = ACDI  or HIP and EedBenOption  = EEC send EE Plus CH
if eeddedcode = ACDI  or HIP and EedBenOption  = EEF send Family */

        ,drvAiCiHcCoverageTier =    CASE /*WHEN BdmDedCode = 'CIEE' AND (SELECT COUNT(*) FROM dbo.U_dsi_BDM_ECIGNCCHOS WHERE BdmEEID = xEEID AND BdmDedCode = 'CISC') = 0 THEN 'EE'
                                        WHEN BdmDedCode = 'CISC' OR (SELECT COUNT(*) FROM dbo.U_dsi_BDM_ECIGNCCHOS WHERE BdmEEID = xEEID AND BdmDedCode IN ('CIEE', 'CISC')) > 0 THEN 'Family' */
                                        WHEN BdmDedCode IN ('CIHOS' , 'DIACC' ) THEN
                                            CASE BdmBenOption
                                                WHEN 'EE' THEN 'EE'
                                                WHEN 'EES' THEN 'EE Plus SP'
                                                WHEN 'EEC' THEN 'EE Plus CH'
                                                WHEN 'EEF' THEN 'Family'
                                            END
                                    END
         /*CASE BdmDedCode
                                        WHEN 'CIEE' THEN 'EE'
                                        WHEN 'CISC' THEN 'Family'
                                        WHEN 'ACDI' THEN 
                                            CASE BdmBenOption
                                                WHEN 'EE' THEN 'EE'
                                                WHEN 'EES' THEN 'EE Plus SP'
                                                WHEN 'EEC' THEN 'EE Plus CH'
                                                WHEN 'EEF' THEN 'Family'
                                            END
                                        WHEN 'HIP' THEN 
                                            CASE BdmBenOption
                                                WHEN 'EE' THEN 'EE'
                                                WHEN 'EES' THEN 'EE Plus SP'
                                                WHEN 'EEC' THEN 'EE Plus CH'
                                                WHEN 'EEF' THEN 'Family'
                                            END
                                    END*/
        ,drvEECiApprovedCoverageAmount =    ''
        ,drvSPCiApprovedCoverageAmount =  ''
        ,drvSpCoverageEffectiveDate =  CASE WHEN BdmDedCode  IN ( 'CIHOS' , 'CIACC') AND ConRelationship in ('SPS', 'DP') THEN BdmBenStartDate END
        /* AND ConIsActive = 'Y'
        AND ConRelationship in ('SPS', 'DP') --, 'CHL', 'STC', 'DPC')
        AND ConSSN is NOT NULL */
        ,drvChCiApprovedCoverageAmount =   ''
        ,drvChCoverageEffectiveDate = CASE WHEN BdmDedCode IN ( 'CIHOS' , 'CIACC')  AND (
                                                                            SELECT COUNT(*) 
                                                                            FROM dbo.Contacts WITH (NOLOCK) 
                                                                            WHERE ConRelationship in ('CHL', 'STC', 'DPC') 
                                                                            AND ConIsActive = 'Y' 
                                                                            AND ConSSN is NOT NULL) > 0 THEN BdmBenStartDate END
        ,drvSpFirstName = CASE WHEN ConRelationship in ('SPS', 'DP') THEN ConNameFirst END
        ,drvSpLastName = CASE WHEN ConRelationship in ('SPS', 'DP') THEN ConNameLast END
        ,drvSpSSN =  CASE WHEN ConRelationship in ('SPS', 'DP') THEN ConSSN END
        ,drvSpGender = CASE WHEN ConRelationship in ('SPS', 'DP') THEN ConGender END
        ,drvSpDateOfBirth = CASE WHEN ConRelationship in ('SPS', 'DP') THEN ConDateOfBirth END
        ,drvSpSmokerStatus = 'N'
        ,drvPayrollFrequency =    '24'
        ,drvPayrollDeductionAmount = 
                    CASE WHEN BdmDedCode in ('ACDI','HIP') THEN
                            (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption)
                         WHEN  BdmDedCode in ( 'CIHOS' , 'CIACC') THEN 
                            0
                    END
        
        --calcEECurAmt --pdhEECurAmt -- EedEELstAmt maybe EedEEAmt -- Lea
        ,devPremiumPaidToDate = ''
        ,drvAiTermStatusCode = CASE WHEN BdmDedCode = 'CIACC' AND BdmBenStatus = 'T' THEN 'T' END
        ,drvAiTermStatusEffectiveDate = CASE WHEN BdmDedCode = 'CIACC' THEN BdmBenStopDate END
    ,drvCiTermStatusCode = '' --CASE WHEN BdmDedCode in ('CISC', 'CIEE') AND BdmBenStatus = 'T' THEN 'T' END
        ,drvCiTermStatusEffectiveDate = '' --CASE WHEN BdmDedCode in ('CISC', 'CIEE') THEN BdmBenStopDate END
        ,drvHcTermStatusCode = CASE WHEN BdmDedCode = 'CIHOS' AND BdmBenStatus ='T' THEN 'T' END 
        ,drvHcTermStatusEffectiveDate = CASE WHEN BdmDedCode = 'CIHOS' THEN BdmBenStopDate END
        ,drvTakeoverIndicator = 'N'
        ,drvFileType = 'F'
        ,drvEmpSmoke = EepIsSmoker
        ,drvConSmoker = ConIsSmoker
    INTO dbo.U_ECIGNCCHOS_drvTbl_Tmp
    FROM dbo.U_ECIGNCCHOS_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECIGNCCHOS WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRecType = 'EMP'
        --AND BdmDedCode IN ('ACDI', 'HIP')
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConIsActive = 'Y'
        AND ConRelationship in ('SPS', 'DP') --, 'CHL', 'STC', 'DPC')
        AND ConSSN is NOT NULL
    LEFT JOIN (SELECT TOP 1 pdhEEID, 
                SUM(pdhEECurAmt) as calcEECurAmt, 
                pdhPayDate
                FROM pDedHist a
                WHERE pdhDedCode in (@DedList) 
                GROUP BY a.pdhEEID, a.pdhPayDate
                ORDER BY a.pdhPayDAte DESC) AS DedHistFlat
        ON DedHistFlat.pdhEEID = xEEID        
    ;



    IF OBJECT_ID('U_ECIGNCCHOS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNCCHOS_drvTbl;
select MAX(drvEEID) AS drvEEID
        ,MAX(drvCoID) AS drvCoID
        ,MAX(drvDepRecID) AS drvDepRecID
        ,MAX(drvSort) AS drvSort
        ,MAX(drvLegalCompanyName) AS drvLegalCompanyName
        ,MAX(drvClientId) AS drvClientId
        ,MAX(drvEEFirstName) AS drvEEFirstName
        ,MAX(drvEELastName) AS drvEELastName
        ,MAX(drvEEStreetAddress) AS drvEEStreetAddress
        ,MAX(drvEECity) AS drvEECity
        ,MAX(drvEEState) AS drvEEState
        ,MAX(drvEEZipCode) AS drvEEZipCode
        ,MAX(drvEESSN) AS drvEESSN
        ,MAX(drvEEGender) AS drvEEGender
        ,MAX(drvEEDateOfBirth) AS drvEEDateOfBirth
        ,MAX(drvEESmokerStatus) AS drvEESmokerStatus
        ,MAX(drvEEDateOfHire) AS drvEEDateOfHire
        ,MAX(drvEEStatus) AS drvEEStatus
        ,MAX(drvEEStatusDate) AS drvEEStatusDate
        ,MAX(drvEELoaType) AS drvEELoaType
        ,MAX(drvEECignaProductClass) AS drvEECignaProductClass
        ,MAX(drvEECignaBillingAccount) AS drvEECignaBillingAccount
        ,MAX(drvBenefitElected) AS drvBenefitElected
        ,MAX(drvCoverageElectionDate) AS drvCoverageElectionDate
        ,MAX(drvCoverageEffectiveDate) AS drvCoverageEffectiveDate
        ,MAX(drvQleRevisedEligibilityDate) AS drvQleRevisedEligibilityDate
        ,MAX(drvPlanType) AS drvPlanType
        ,MAX(drvAiCiHcCoverageTier) AS drvAiCiHcCoverageTier
        ,MAX(drvEECiApprovedCoverageAmount) AS drvEECiApprovedCoverageAmount
        ,MAX(drvSPCiApprovedCoverageAmount) AS drvSPCiApprovedCoverageAmount
        ,MAX(drvSpCoverageEffectiveDate) AS drvSpCoverageEffectiveDate
        ,MAX(drvChCiApprovedCoverageAmount) AS drvChCiApprovedCoverageAmount
        ,MAX(drvChCoverageEffectiveDate) AS drvChCoverageEffectiveDate
        ,MAX(drvSpFirstName) AS drvSpFirstName
        ,MAX(drvSpLastName) AS drvSpLastName
        ,MAX(drvSpSSN) AS drvSpSSN
        ,MAX(drvSpGender) AS drvSpGender
        ,MAX(drvSpDateOfBirth) AS drvSpDateOfBirth
        ,MAX(drvSpSmokerStatus) AS drvSpSmokerStatus
        ,MAX(drvPayrollFrequency) AS drvPayrollFrequency
        ,MAX(drvPayrollDeductionAmount) AS drvPayrollDeductionAmount
        ,MAX(devPremiumPaidToDate) AS devPremiumPaidToDate
        ,MAX(drvAiTermStatusCode) AS drvAiTermStatusCode
        ,MAX(drvAiTermStatusEffectiveDate) AS drvAiTermStatusEffectiveDate
        ,MAX(drvCiTermStatusCode) AS drvCiTermStatusCode
        ,MAX(drvCiTermStatusEffectiveDate) AS drvCiTermStatusEffectiveDate
        ,MAX(drvHcTermStatusCode) AS drvHcTermStatusCode
        ,MAX(drvHcTermStatusEffectiveDate) AS drvHcTermStatusEffectiveDate
        ,MAX(drvTakeoverIndicator) AS drvTakeoverIndicator
        ,MAX(drvFileType) AS drvFileType
        ,MAX(drvEmpSmoke) AS drvEmpSmoke 
        ,MAX(drvConSmoker) AS drvConSmoker 
        INTO dbo.U_ECIGNCCHOS_drvTbl
from    dbo.U_ECIGNCCHOS_drvTbl_Tmp 
group by drvEEID, drvCOID, drvBenefitElected;

  --Update Benefit Premium based from the rates table

  
UPDATE D SET D.drvPayrollDeductionAmount 
= A.EmpPremAmount
FROM U_ECIGNCCHOS_drvTbl  D
JOIN 
(select drveeid,
    DateDiff(year,drvSpDateOfBirth,drvCoverageEffectiveDate) as SpsAge,
    DateDiff(year,drvEEDateOfBirth,drvCoverageEffectiveDate) as EmpAge,
    drvEmpSmoke,drvConSmoker,
    EmpPremAmount = ISNULL((CASE WHEN drvEECiApprovedCoverageAmount IS NOT NULL THEN (
            CASE WHEN drvEmpSmoke = 'Y' and drvEEGender  = 'M' THEN ( Select Top 1 RatEERateSMMale from InsRate   where RatDedCode = 'CIACC' and  DateDiff(year,drvEEDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = (CASE WHEN drvPayrollFrequency = '26' THEN 'B' ELSE 'W' END) order by RatEffDate desc  )
                 WHEN drvEmpSmoke = 'Y' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateSMFemale from InsRate   where RatDedCode = 'CIACC' and  DateDiff(year,drvEEDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = (CASE WHEN drvPayrollFrequency = '26' THEN 'B' ELSE 'W' END) order by RatEffDate desc  )
                 WHEN drvEmpSmoke = 'N' and drvEEGender  = 'M' THEN  ( Select Top 1 RatEERateNSMale from InsRate   where RatDedCode = 'CIACC' and  DateDiff(year,drvEEDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge  and RatPayFreq = (CASE WHEN drvPayrollFrequency = '26' THEN 'B' ELSE 'W' END) order by RatEffDate desc  )
                 WHEN drvEmpSmoke = 'N' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateNSFemale from InsRate   where RatDedCode = 'CIACC' and  DateDiff(year,drvEEDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = (CASE WHEN drvPayrollFrequency = '26' THEN 'B' ELSE 'W' END) order by RatEffDate desc  )
            END
    ) 
    END * (drvEECiApprovedCoverageAmount / 1000)),0)    +
    ISNULL(
         (CASE WHEN drvSPCiApprovedCoverageAmount IS NOT NULL THEN (
            CASE WHEN drvEmpSmoke = 'Y' and drvEEGender  = 'M' THEN ( Select Top 1 RatEERateSMMale from InsRate   where RatDedCode = 'CIHOS' and  DateDiff(year,drvSpDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge order by RatEffDate desc  )
                 WHEN drvEmpSmoke = 'Y' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateSMFemale from InsRate   where RatDedCode = 'CIHOS' and  DateDiff(year,drvSpDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge order by RatEffDate desc  )
                 WHEN drvEmpSmoke = 'N' and drvEEGender  = 'M' THEN  ( Select Top 1 RatEERateNSMale from InsRate   where RatDedCode = 'CIHOS' and  DateDiff(year,drvSpDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge order by RatEffDate desc  )
                 WHEN drvEmpSmoke = 'N' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateNSFemale from InsRate   where RatDedCode = 'CIHOS' and  DateDiff(year,drvSpDateOfBirth,drvCoverageEffectiveDate) BETWEEN RatMinAge and RatMaxAge order by RatEffDate desc  )
            END
    * (drvSPCiApprovedCoverageAmount / 1000))
    END),0)

 from U_ECIGNCCHOS_drvTbl where drvBenefitElected not IN('VAI','VHC')) A
 ON A.drveeid = D.drveeid
 and D.drvBenefitElected not IN('VAI','VHC');



    /* 
select top 1 pdhEEID, SUM(pdhEECurAmt) as calcEECurAmt, pdhPayDate
from pDedHist a
where 
pdhEEID = 'CBT23R0000K0'
group by a.pdhEEID, a.pdhPayDate
order by a.pdhPayDAte desc*/

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
ALTER VIEW dbo.dsi_vwECIGNCCHOS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECIGNCCHOS_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECIGNCCHOS%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911011'
       ,expStartPerControl     = '201911011'
       ,expLastEndPerControl   = '201911089'
       ,expEndPerControl       = '201911089'
WHERE expFormatCode = 'ECIGNCCHOS';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECIGNCCHOS_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECIGNCCHOS_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort