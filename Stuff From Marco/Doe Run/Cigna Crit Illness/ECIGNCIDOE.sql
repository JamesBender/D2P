SET NOCOUNT ON;
IF OBJECT_ID('U_ECIGCIXDOE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIGCIXDOE_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECIGCIXDOE_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECIGCIXDOE' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECIGCIXDOE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECIGCIXDOE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECIGCIXDOE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGCIXDOE];
GO
IF OBJECT_ID('U_ECIGCIXDOE_File') IS NOT NULL DROP TABLE [dbo].[U_ECIGCIXDOE_File];
GO
IF OBJECT_ID('U_ECIGCIXDOE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECIGCIXDOE_EEList];
GO
IF OBJECT_ID('U_ECIGCIXDOE_drvTbl_Tmp') IS NOT NULL DROP TABLE [dbo].[U_ECIGCIXDOE_drvTbl_Tmp];
GO
IF OBJECT_ID('U_ECIGCIXDOE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECIGCIXDOE_drvTbl];
GO
IF OBJECT_ID('U_ECIGCIXDOE_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECIGCIXDOE_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECIGCIXDOE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECIGCIXDOE];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECIGCIXDOE';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECIGCIXDOE';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECIGCIXDOE';
DELETE [dbo].[iAscDefF] FROM [dbo].[iAscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECIGCIXDOE';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECIGCIXDOE';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECIGCIXDOE','Cigna Accident/Critical Illness/Hospital Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ECIGCIXDOEZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Legal Company Name"','1','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','1',NULL,'Legal Company Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client ID"','2','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','2',NULL,'Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE First Name"','3','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','3',NULL,'EE First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Last Name"','4','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','4',NULL,'EE Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Street Address"','5','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','5',NULL,'EE Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE City"','6','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','6',NULL,'EE City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE State"','7','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','7',NULL,'EE State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Zip Code"','8','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','8',NULL,'EE Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE SSN"','9','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','9',NULL,'EE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Gender"','10','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','10',NULL,'EE Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE DOB"','11','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','11',NULL,'EE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Smoker Status"','12','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','12',NULL,'EE Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Date of Hire"','13','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','13',NULL,'EE Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Status"','14','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','14',NULL,'EE Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Status Date"','15','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','15',NULL,'EE Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE LOA Type"','16','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','16',NULL,'EE LOA Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cigna Product Class"','17','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','17',NULL,'Cigna Product Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cigna Billing Account"','18','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','18',NULL,'Cigna Billing Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Elected"','19','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','19',NULL,'Benefit Elected',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Election Date"','20','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','20',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Effective Date"','21','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','21',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QLE/Revised Eligibility Date"','22','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','22',NULL,'QLE/Revised Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Type"','23','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','23',NULL,'Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AI/CI/HC Coverage Tier"','24','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','24',NULL,'AI/CI/HC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE CI Approved Coverage Amount"','25','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','25',NULL,'EE CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP CI Approved Coverage Amount"','26','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','26',NULL,'SP CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Coverage Effective Date"','27','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','27',NULL,'SP Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH CI Approved Coverage Amount"','28','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','28',NULL,'CH CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Coverage Effective Date"','29','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','29',NULL,'CH Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP First Name"','30','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','30',NULL,'SP First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Last Name"','31','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','31',NULL,'SP Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP SSN"','32','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','32',NULL,'SP SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Gender"','33','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','33',NULL,'SP Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP DOB"','34','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','34',NULL,'SP DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Smoker Status"','35','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','35',NULL,'SP Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Frequency"','36','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','36',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Deduction Amt"','37','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','37',NULL,'Payroll Deduction Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Premium Paid to Date"','38','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','38',NULL,'Premium Paid to Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AI termination Status Code"','39','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','39',NULL,'AI termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AI Termination Status Effective Date"','40','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','40',NULL,'AI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Status Code"','41','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','41',NULL,'CI Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Status Effective Date"','42','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','42',NULL,'CI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HC Termination Status Code"','43','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','43',NULL,'HC Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HC Termination Status Effective Date"','44','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','44',NULL,'HC Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Takeover Indicator"','45','(''DA''=''T,'')','ECIGCIXDOEZ0','50','H','01','45',NULL,'Takeover Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"File Type"','46','(''DA''=''T'')','ECIGCIXDOEZ0','50','H','01','46',NULL,'File Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLegalCompanyName"','1','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','1',NULL,'Legal Company Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientId"','2','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','2',NULL,'Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEFirstName"','3','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','3',NULL,'EE First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELastName"','4','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','4',NULL,'EE Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEStreetAddress"','5','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','5',NULL,'EE Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECity"','6','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','6',NULL,'EE City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEState"','7','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','7',NULL,'EE State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEZipCode"','8','(''UNT0''=''T,'')','ECIGCIXDOEZ0','50','D','10','8',NULL,'EE Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEESSN"','9','(''UNT0''=''T,'')','ECIGCIXDOEZ0','50','D','10','9',NULL,'EE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEGender"','10','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','10',NULL,'EE Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDateOfBirth"','11','(''UD101''=''T,'')','ECIGCIXDOEZ0','50','D','10','11',NULL,'EE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEESmokerStatus"','12','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','12',NULL,'EE Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDateOfHire"','13','(''UD101''=''T,'')','ECIGCIXDOEZ0','50','D','10','13',NULL,'EE Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEStatus"','14','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','14',NULL,'EE Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEStatusDate"','15','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','15',NULL,'EE Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELoaType"','16','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','16',NULL,'EE LOA Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECignaProductClass"','17','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','17',NULL,'Cigna Product Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECignaBillingAccount"','18','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','18',NULL,'Cigna Billing Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitElected"','19','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','19',NULL,'Benefit Elected',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageElectionDate"','20','(''UD101''=''T,'')','ECIGCIXDOEZ0','50','D','10','20',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDate"','21','(''UD101''=''T,'')','ECIGCIXDOEZ0','50','D','10','21',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQleRevisedEligibilityDate"','22','(''UD101''=''T,'')','ECIGCIXDOEZ0','50','D','10','22',NULL,'QLE/Revised Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanType"','23','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','23',NULL,'Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAiCiHcCoverageTier"','24','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','24',NULL,'AI/CI/HC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECiApprovedCoverageAmount"','25','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','25',NULL,'EE CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPCiApprovedCoverageAmount"','26','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','26',NULL,'SP CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpCoverageEffectiveDate"','27','(''UD101''=''T,'')','ECIGCIXDOEZ0','50','D','10','27',NULL,'SP Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChCiApprovedCoverageAmount"','28','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','28',NULL,'CH CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChCoverageEffectiveDate"','29','(''UD101''=''T,'')','ECIGCIXDOEZ0','50','D','10','29',NULL,'CH Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpFirstName"','30','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','30',NULL,'SP First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpLastName"','31','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','31',NULL,'SP Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpSSN"','32','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','32',NULL,'SP SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpGender"','33','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','33',NULL,'SP Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpDateOfBirth"','34','(''UD101''=''T,'')','ECIGCIXDOEZ0','50','D','10','34',NULL,'SP DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpSmokerStatus"','35','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','35',NULL,'SP Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFrequency"','36','(''UNT0''=''T,'')','ECIGCIXDOEZ0','50','D','10','36',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDeductionAmount"','37','(''UNT2''=''T,'')','ECIGCIXDOEZ0','50','D','10','37',NULL,'Payroll Deduction Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"devPremiumPaidToDate"','38','(''UD101''=''T,'')','ECIGCIXDOEZ0','50','D','10','38',NULL,'Premium Paid to Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAiTermStatusCode"','39','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','39',NULL,'AI termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAiTermStatusEffectiveDate"','40','(''UD101''=''T,'')','ECIGCIXDOEZ0','50','D','10','40',NULL,'AI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiTermStatusCode"','41','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','41',NULL,'CI Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiTermStatusEffectiveDate"','42','(''UD101''=''T,'')','ECIGCIXDOEZ0','50','D','10','42',NULL,'CI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHcTermStatusCode"','43','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','43',NULL,'HC Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHcTermStatusEffectiveDate"','44','(''UD101''=''T,'')','ECIGCIXDOEZ0','50','D','10','44',NULL,'HC Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTakeoverIndicator"','45','(''UA''=''T,'')','ECIGCIXDOEZ0','50','D','10','45',NULL,'Takeover Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileType"','46','(''UA''=''T'')','ECIGCIXDOEZ0','50','D','10','46',NULL,'File Type',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ECIGCIXDOE_20200107.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cigna Accident & Hospital Exp','202001079','EMPEXPORT','ONDEMAND',NULL,'ECIGCIXDOE',NULL,NULL,NULL,'202001079','Jan  7 2020  6:13AM','Jan  7 2020  6:13AM','202001071',NULL,'','','202001071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ECIGCIXDOE_20200107.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202001079','EMPEXPORT','TEST',NULL,'ECIGCIXDOE',NULL,NULL,NULL,'202001079','Jan  7 2020  6:13AM','Jan  7 2020  6:13AM','202001071',NULL,'','','202001071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ECIGCIXDOE_20200107.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202001079','EMPEXPORT','CCH_SCHED',NULL,'ECIGCIXDOE',NULL,NULL,NULL,'202001079','Jan  7 2020  6:13AM','Jan  7 2020  6:13AM','202001071',NULL,'','','202001071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ECIGCIXDOE_20200107.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202001079','EMPEXPORT','OEACTIVE',NULL,'ECIGCIXDOE',NULL,NULL,NULL,'202001079','Jan  7 2020  6:13AM','Jan  7 2020  6:13AM','202001071',NULL,'','','202001071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\ECIGCIXDOE_20200107.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202001079','EMPEXPORT','OEPASSIVE',NULL,'ECIGCIXDOE',NULL,NULL,NULL,'202001079','Jan  7 2020  6:13AM','Jan  7 2020  6:13AM','202001071',NULL,'','','202001071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ECIGCIXDOE_20200127.txt' END WHERE expFormatCode = 'ECIGCIXDOE';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGCIXDOE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGCIXDOE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGCIXDOE','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGCIXDOE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGCIXDOE','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ECIGCIXDOE' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECIGCIXDOE' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ECIGCIXDOE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIGCIXDOE_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGCIXDOE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGCIXDOE','D10','dbo.U_ECIGCIXDOE_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGCIXDOE','T90','dbo.U_ECIGCIXDOE_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_ECIGCIXDOE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECIGCIXDOE] (
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
IF OBJECT_ID('U_ECIGCIXDOE_DedList') IS NULL
CREATE TABLE [dbo].[U_ECIGCIXDOE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECIGCIXDOE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECIGCIXDOE_drvTbl] (
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
IF OBJECT_ID('U_ECIGCIXDOE_drvTbl_Tmp') IS NULL
CREATE TABLE [dbo].[U_ECIGCIXDOE_drvTbl_Tmp] (
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
IF OBJECT_ID('U_ECIGCIXDOE_EEList') IS NULL
CREATE TABLE [dbo].[U_ECIGCIXDOE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECIGCIXDOE_File') IS NULL
CREATE TABLE [dbo].[U_ECIGCIXDOE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Doe Run Company

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 11/01/2021
Service Request Number: TekP-2021-08-10-0001

Purpose: Cigna Accident and Hospital Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX
 
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECIGCIXDOE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECIGCIXDOE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECIGCIXDOE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECIGCIXDOE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECIGCIXDOE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGCIXDOE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGCIXDOE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGCIXDOE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGCIXDOE', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGCIXDOE', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECIGCIXDOE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECIGCIXDOE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECIGCIXDOE';
    SELECT @FileMinCovDate = CAST('1/1/2022' as DATETIME);

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
    DELETE FROM dbo.U_ECIGCIXDOE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECIGCIXDOE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CRTL1,CRT20,CRT30,CRTL2,CRTC,CRTC1,CRTL3,CRTS,CRTS1,CRTL4,CRTF,CRTF1,ACCI,AFLAC ';

    IF OBJECT_ID('U_ECIGCIXDOE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGCIXDOE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECIGCIXDOE_DedList
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


    UPDATE dbo.U_dsi_bdm_ECIGCIXDOE 
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ECIGCIXDOE
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;


    UPDATE dbo.U_dsi_bdm_ECIGCIXDOE
       SET BdmUSGField2 = DbnDepBPlanTVID
   FROM dbo.U_dsi_bdm_ECIGCIXDOE
   JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
       ON DbnEEID = BdmEEID
       AND DbnCOID = BdmCOID
       AND DbnDedCode = BdmDedCode
   WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

   

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECIGCIXDOE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECIGCIXDOE_drvTbl_Tmp','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGCIXDOE_drvTbl_Tmp;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvLegalCompanyName = 'The Doe Run Company' 
        ,drvClientId = '318290'
        ,drvEEFirstName = EepNameFirst
        ,drvEELastName = '"' + EepNameLast + '"'
        ,drvEEStreetAddress = EepAddressLine1 + ' ' + EepAddressLine2 --Remove any commas
        ,drvEECity = EepAddressCity
        ,drvEEState = EepAddressState
        ,drvEEZipCode = LEFT(EepAddressZipCode, 5)
        ,drvEESSN = QuoteName(eepSSN,'"')
        ,drvEEGender = EepGender
        ,drvEEDateOfBirth = EepDateOfBirth
        ,drvEESmokerStatus = 'N'
        ,drvEEDateOfHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOFLastHire ELSE EecDateOfOriginalHire END
        ,drvEEStatus =  CASE EecEmplStatus
                             WHEN 'T' THEN 
                                CASE WHEN EecTermReason = '203' THEN 'D' ELSE 'T' END
                            WHEN 'L' THEN 'L'
                            ELSE 'A'
                        END
        ,drvEEStatusDate = CASE WHEN EecEmplStatus = 'T' THEN FORMAT(EecDateOfTermination, 'MM/dd/yyyy') 
                                WHEN EecEmplStatus = 'L' THEN FORMAT(DATEADD(Day,-1,EecStatusStartDate), 'MM/dd/yyyy') 
                         END
        ,drvEELoaType = CASE WHEN EecEmplStatus = 'L' THEN 'U' END
        ,drvEECignaProductClass = '001'
        ,drvEECignaBillingAccount = '001'
        ,drvBenefitElected = PLAN_Code
        ,drvCoverageElectionDate = '' --(SELECT MAX(EdhEffDate) from EmpHDed where EdhEEID = xEEID  AND EdhCOID = xCOID)
        ,drvCoverageEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',StartDate, @FileMinCovDate) 
        ,drvQleRevisedEligibilityDate = ''
        
        ,drvPlanType = CASE PLAN_Code 
                                    WHEN 'VAI' THEN 'AI961884'
                                    WHEN 'VCI' THEN 'CI961796'
                                END
                              
        ,drvAiCiHcCoverageTier =    CASE 
                                        WHEN PLAN_Code IN ('VAI' ) THEN
                                            CASE WHEN BenOptions in ('EEF','EEDPF') THEN 'Family' 
                                                 WHEN BenOptions in ('EE') THEN 'EE'
                                                 WHEN BenOptions in ('EES','EEDP') THEN 'EE Plus SP'
                                                 WHEN BenOptions in ('EEC') THEN 'EE Plus CH'

                                                 END
                                        WHEN PLAN_Code IN ('VCI') and IsFamily = '1' THEN 'Family'
                                        WHEN PLAN_Code IN ('VCI') and IsEE = '1' THEN 'EE'
                                        WHEN PLAN_Code IN ('VCI') and IsSpouse = '1' THEN 'EE Plus SP'
                                        WHEN PLAN_Code IN ('VCI') and IsCH = '1' THEN 'EE Plus CH'
                                            END
                                    END
        ,drvEECiApprovedCoverageAmount =    Amount
        ,drvSPCiApprovedCoverageAmount =  CASE WHEN SPS is not null then CAST(SPS_AMT as varchar) END
        

        ,drvSpCoverageEffectiveDate =  CASE 
                                                WHEN PLAN_Code in ('VHC','VAI') and  BenOptions IN ('EES','EEDP','EEF','EEDPF') THEN  dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime) ) 
                                                WHEN SPS is not null then dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime) ) 
                                           
                                           END
   
        ,drvChCiApprovedCoverageAmount =   CASE WHEN CHD is not null then Cast( CONVERT(DECIMAL(10,0),(Cast (Amount as money) * 0.25)) as varchar) END
        ,drvChCoverageEffectiveDate = WHEN CHD is not null then dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime) )
        ,drvSpFirstName = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConNameFirst from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSpLastName = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConNameLast from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSpSSN =  CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConSSN from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSpGender = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConGender from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSpDateOfBirth = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConDateOfBirth from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSpSmokerStatus = 'N'
        ,drvPayrollFrequency =    '24' --TODO
        ,drvPayrollDeductionAmount = 
                    CASE WHEN PLAN_Code = 'VAI' THEN CAST(BenefitAmounts.VAI as varchar) 
                                        WHEN PLAN_Code = 'VHC' THEN CAST(BenefitAmounts.VHC as varchar)
                                        WHEN PLAN_Code = 'VCI' THEN CAST(BenefitAmounts.VCI + ISNULL(BenefitAmounts.VCI_Dep,0) as varchar)
                                         END
        
        ,devPremiumPaidToDate = ''
        ,drvAiTermStatusCode = ''--CASE WHEN BdmDedCode = 'CIACC' AND BdmBenStatus = 'T' THEN 'T' END
        ,drvAiTermStatusEffectiveDate = ''--CASE WHEN BdmDedCode = 'CIACC' THEN BdmBenStopDate END
    ,drvCiTermStatusCode = '' --CASE WHEN BdmDedCode in ('CISC', 'CIEE') AND BdmBenStatus = 'T' THEN 'T' END
        ,drvCiTermStatusEffectiveDate = '' --CASE WHEN BdmDedCode in ('CISC', 'CIEE') THEN BdmBenStopDate END
        ,drvHcTermStatusCode = ''--CASE WHEN BdmDedCode = 'CIHOS' AND BdmBenStatus ='T' THEN 'T' END 
        ,drvHcTermStatusEffectiveDate = ''--CASE WHEN BdmDedCode = 'CIHOS' THEN BdmBenStopDate END
        ,drvTakeoverIndicator = 'N'
        ,drvFileType = 'F'
    INTO dbo.U_ECIGCIXDOE_drvTbl_Tmp
    FROM dbo.U_ECIGCIXDOE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (Select bdmeeid,bdmcoid,
    IsFamily = MAX(    CASE 
                                  WHEN bdmDedCode IN('CRTL4', 'CRTF', 'CRTF1' )  THEN '1'                             END 
                             ),
    IsEE = MAX(    CASE 
                                  WHEN bdmDedCode IN('CRTL1', 'CRT20', 'CRT30' )  THEN '1'                             END 
                             ),
    IsCH = MAX(    CASE 
                                  WHEN bdmDedCode IN('CRTL2', 'CRTC', 'CRTC1')  THEN '1'                             END 
                             ),  
    IsSpouse = MAX(    CASE 
                                  WHEN bdmDedCode IN('CRTL3', 'CRTS', 'CRTS1')  THEN '1'                             END 
                             ),                    
    BenOptions= MAX(    CASE --WHEN bdmDedCode='HOSPI' THEN BdmBenOption
                                  WHEN bdmDedCode IN ('ACC' , 'AFLAC') THEN BdmBenOption
                                  WHEN bdmDedCode IN('CRTL1', 'CRT20', 'CRT30', 'CRTL2', 'CRTC', 'CRTC1', 'CRTL3', 'CRTS', 'CRTS1', 'CRTL4', 'CRTF', 'CRTF1' )  THEN BdmBenOption
                             END 
                             ),
    CASE --WHEN bdmDedCode='HOSPI' THEN 'VHC'
                                  WHEN bdmDedCode IN ('ACC' , 'AFLAC') THEN 'VAI'
                                  WHEN bdmDedCode IN('CRTL1', 'CRT20', 'CRT30', 'CRTL2', 'CRTC', 'CRTC1', 'CRTL3', 'CRTS', 'CRTS1', 'CRTL4', 'CRTF', 'CRTF1' )  THEN 'VCI'
                             END AS PLAN_Code,
            StartDate= MAX(    CASE --WHEN bdmDedCode='HOSPI' THEN bdmbenstartdate
                                  WHEN bdmDedCode IN ('ACC' , 'AFLAC')THEN bdmbenstartdate
                                  WHEN bdmDedCode IN('CRTL1', 'CRT20', 'CRT30', 'CRTL2', 'CRTC', 'CRTC1', 'CRTL3', 'CRTS', 'CRTS1', 'CRTL4', 'CRTF', 'CRTF1' )   THEN bdmbenstartdate
                             END 
                             ),
            StopDate= MAX(    CASE --WHEN bdmDedCode='HOSPI' THEN bdmbenstopdate
                                  WHEN bdmDedCode IN ('ACC' , 'AFLAC') THEN bdmbenstopdate
                                  WHEN bdmDedCode IN('CRTL1', 'CRT20', 'CRT30', 'CRTL2', 'CRTC', 'CRTC1', 'CRTL3', 'CRTS', 'CRTS1', 'CRTL4', 'CRTF', 'CRTF1' )   THEN bdmbenstopdate
                             END 
                             ),
                                     if ConRelationship = SP or DP and dbndedcode = ACC, AFLAC, CRTL3, CRTS, CRTS1, CRTL4, CRTF, CRTF1 send dbnbenstartdate

            SPS = MAX(CASE WHEN bdmdedcode in ('CRTL3', 'CRTL4','CRTS','CRTF','CRTS1','CRTF1' ) THEN '1' END ) ,
            SPS_AMT = MAX(CASE  WHEN BdmDedCode IN ('CRTL3', 'CRTL4')  THEN '5000'
                    WHEN BdmDedCode IN ('CRTS', 'CRTF')  THEN '10000'
                    WHEN BdmDedCode IN ('CRTS1', 'CRTF1')  THEN '15000'
                 END ) ,
            CHD = MAX(CASE WHEN bdmdedcode in ('CIC25') THEN '1' END ) ,

            BenefitAmount =  MAX(    CASE 
                                  WHEN bdmDedCode = 'AI' THEN bdmeeamt 
                                  WHEN bdmdedcode = 'HOSPI' THEN bdmeeamt
                                  END
                             ),


            Amount = MAX(CASE WHEN bdmDedCode IN ('CRTL1, CRTL3, CRTL2, CRTL4') THEN '10000'
                            WHEN bdmDedCode IN('CRT20', 'CRTS', 'CRTC', 'CRTF') THEN '20000'
                            WHEN bdmDedCode IN('CRT30', 'CRTS1', 'CRTC1', 'CRTF1') THEN '30000'
                           
                            END),
            BenStatus= MAX(    CASE --WHEN bdmDedCode='HOSPI' THEN BdmBenStatus
                                  WHEN bdmDedCode IN ('ACC' , 'AFLAC') THEN BdmBenStatus
                                  WHEN bdmDedCode IN('CRTL1', 'CRT20', 'CRT30', 'CRTL2', 'CRTC', 'CRTC1', 'CRTL3', 'CRTS', 'CRTS1', 'CRTL4', 'CRTF', 'CRTF1' )   THEN BdmBenStatus
                             END 
                             )
 from dbo.U_dsi_BDM_ECIGCIXDOE

 group by bdmeeid,bdmcoid,CASE --WHEN bdmDedCode='HOSPI' THEN BdmBenStatus
                                  WHEN bdmDedCode IN ('ACC' , 'AFLAC') THEN BdmBenStatus
                                  WHEN bdmDedCode IN('CRTL1', 'CRT20', 'CRT30', 'CRTL2', 'CRTC', 'CRTC1', 'CRTL3', 'CRTS', 'CRTS1', 'CRTL4', 'CRTF', 'CRTF1' )   THEN BdmBenStatus
                             END ) as bdmConsolidated
        ON bdmConsolidated.BdmCOID =  xCOID
        and bdmConsolidated.BdmEEID =  xeeid
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
ALTER VIEW dbo.dsi_vwECIGCIXDOE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECIGCIXDOE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECIGCIXDOE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911011'
       ,expStartPerControl     = '201911011'
       ,expLastEndPerControl   = '201911089'
       ,expEndPerControl       = '201911089'
WHERE expFormatCode = 'ECIGCIXDOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECIGCIXDOE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECIGCIXDOE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort