/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "@DeveloperName" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

-- Integration parameters
@CustomerName - Replace with customer name
@DeveloperName - Replace with TC name
@IntegrationAnalystName - Replace with BA/IC name
@CreateDate - Replace with date of creation
@SRNumber - Replace with SR number
@CustomFormatCode - Replace with Format Code (i.e., @CustomFormatCode)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Lincoln Financial Export (v2))
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File Parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@TestFilePath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@UDESFilePath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

-- Data parameters
@FileNamePrefix - Replace with client prefix for filename (i.e., AGGREGATOR_GROUPID)

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_Translations') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Translations];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_Contacts') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Contacts];
GO
IF OBJECT_ID('U_@CustomFormatCode_Benefits') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Benefits];
GO
IF OBJECT_ID('U_@CustomFormatCode_Beneficiary') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Beneficiary];
GO
IF OBJECT_ID('U_dsi_BDM_@CustomFormatCode') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_@CustomFormatCode];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName = LEFT('@CustomFormatName',50);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','9000','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee ID"','1','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','1',NULL,'Employee ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Change Date"','2','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','2',NULL,'Change Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep Change Date"','3','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','3',NULL,'Dep Change Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Termination Date"','4','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','4',NULL,'Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr First Name"','5','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','5',NULL,'Mbr First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr Last Name"','6','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','6',NULL,'Mbr Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr Middle Initial"','7','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','7',NULL,'Mbr Middle Initial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr SSN"','8','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','8',NULL,'Mbr SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr Gender"','9','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','9',NULL,'Mbr Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr DOB"','10','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','10',NULL,'Mbr DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"App Sign Date"','11','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','11',NULL,'App Sign Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Occupation"','12','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','12',NULL,'Occupation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Hrs Per Week"','13','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','13',NULL,'Hrs Per Week',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Salary Amt"','14','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','14',NULL,'Salary Amt',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Salary Code"','15','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','15',NULL,'Salary Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Sal Eff Date"','16','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','16',NULL,'Sal Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr Addr 1"','17','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','17',NULL,'Mbr Addr 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr Addr 2"','18','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','18',NULL,'Mbr Addr 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr City"','19','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','19',NULL,'Mbr City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr State"','20','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','20',NULL,'Mbr State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr Zip Code"','21','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','21',NULL,'Mbr Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr Zip Plus 4"','22','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','22',NULL,'Mbr Zip Plus 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Home Phone"','23','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','23',NULL,'Home Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Work Phone"','24','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','24',NULL,'Work Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Work Phone Ext"','25','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','25',NULL,'Work Phone Ext',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Email Address"','26','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','26',NULL,'Email Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Date of Benefits Eligibility"','27','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','27',NULL,'Date of Benefits Eligibility',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Subsequent Date of Benefits Eligibility"','28','(''DA''=''Q,'')',@AdhSystemID,'40','H','01','28',NULL,'Subsequent Date of Benefits Eligibility',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Reason for Prior Loss of Benefits Eligibility"','29','(''DA''=''Q,'')',@AdhSystemID,'50','H','01','29',NULL,'Reason for Prior Loss of Benefits Eligibility',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Pri Bene First Name"','30','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','30',NULL,'Pri Bene First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Pri Bene Last Name"','31','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','31',NULL,'Pri Bene Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Pri Bene Middle Init"','32','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','32',NULL,'Pri Bene Middle Init',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Pri Bene Relationship"','33','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','33',NULL,'Pri Bene Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Pri Bene Address 1"','34','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','34',NULL,'Pri Bene Address 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Pri Bene Address 2"','35','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','35',NULL,'Pri Bene Address 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Pri Bene City"','36','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','36',NULL,'Pri Bene City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Pri Bene State"','37','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','37',NULL,'Pri Bene State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Pri Bene Zip Code"','38','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','38',NULL,'Pri Bene Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Pri Bene Zip Plus 4"','39','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','39',NULL,'Pri Bene Zip Plus 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Pri Bene SSN"','40','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','40',NULL,'Pri Bene SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Co Bene First Name"','41','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','41',NULL,'Co Bene First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Co Bene Last Name"','42','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','42',NULL,'Co Bene Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Co Bene Middle Init"','43','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','43',NULL,'Co Bene Middle Init',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Co Bene Relationship"','44','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','44',NULL,'Co Bene Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Co Bene Address 1"','45','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','45',NULL,'Co Bene Address 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Co Bene Address 2"','46','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','46',NULL,'Co Bene Address 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Co Bene City"','47','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','47',NULL,'Co Bene City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Co Bene State"','48','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','48',NULL,'Co Bene State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Co Bene Zip Code"','49','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','49',NULL,'Co Bene Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Co Bene Zip Plus 4"','50','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','50',NULL,'Co Bene Zip Plus 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Co Bene SSN"','51','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','51',NULL,'Co Bene SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Beneficiary Comments"','52','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','52',NULL,'Beneficiary Comments',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident Policy Number"','53','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','53',NULL,'Accident Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident Bill Location A/C Number"','54','(''DA''=''Q,'')',@AdhSystemID,'35','H','01','54',NULL,'Accident Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident Sort Group"','55','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','55',NULL,'Accident Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident Eff Date"','56','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','56',NULL,'Accident Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident Plan Code"','57','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','57',NULL,'Accident Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident Class Code"','58','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','58',NULL,'Accident Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident Tier Code"','59','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','59',NULL,'Accident Tier Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Health Asses Tier"','60','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','60',NULL,'Health Asses Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Hospital Tier"','61','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','61',NULL,'Hospital Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident Disability Amount"','62','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','62',NULL,'Accident Disability Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident DI Tier"','63','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','63',NULL,'Accident DI Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident DI Benefit Period"','64','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','64',NULL,'Accident DI Benefit Period',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident DI Elim Period"','65','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','65',NULL,'Accident DI Elim Period',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident Sickness Disability Amount"','66','(''DA''=''Q,'')',@AdhSystemID,'40','H','01','66',NULL,'Accident Sickness Disability Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident/sick Tier"','67','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','67',NULL,'Accident/sick Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident/sick DI Benefit Period"','68','(''DA''=''Q,'')',@AdhSystemID,'35','H','01','68',NULL,'Accident/sick DI Benefit Period',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident/sick DI Elim Period"','69','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','69',NULL,'Accident/sick DI Elim Period',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accident Termination Date"','70','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','70',NULL,'Accident Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Critical Illness Policy Number"','71','(''DA''=''Q,'')',@AdhSystemID,'35','H','01','71',NULL,'Critical Illness Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Critical Illness Bill Location A/C Number"','72','(''DA''=''Q,'')',@AdhSystemID,'45','H','01','72',NULL,'Critical Illness Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Critical Illness Sort Group"','73','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','73',NULL,'Critical Illness Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Critical Illness Eff Date"','74','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','74',NULL,'Critical Illness Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Critical Illness Plan Code"','75','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','75',NULL,'Critical Illness Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Critical Illness Class Code"','76','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','76',NULL,'Critical Illness Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Critical Illness Termination Date"','77','(''DA''=''Q,'')',@AdhSystemID,'35','H','01','77',NULL,'Critical Illness Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Principal Sum Amt Approved"','78','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','78',NULL,'EE Principal Sum Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Principal Sum Amt Pending"','79','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','79',NULL,'EE Principal Sum Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP Principal Sum Amt Approved"','80','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','80',NULL,'SP Principal Sum Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP Principal Sum Amt Pending"','81','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','81',NULL,'SP Principal Sum Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CH Principal Sum Amt Approved"','82','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','82',NULL,'CH Principal Sum Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CH Principal Sum Amt Pending"','83','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','83',NULL,'CH Principal Sum Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Heart Amt Approved"','84','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','84',NULL,'EE Heart Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Heart Amt Pending"','85','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','85',NULL,'EE Heart Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP Heart Amt Approved"','86','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','86',NULL,'SP Heart Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP Heart Amt Pending"','87','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','87',NULL,'SP Heart Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CH Heart Amt Approved"','88','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','88',NULL,'CH Heart Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CH Heart Amt Pending"','89','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','89',NULL,'CH Heart Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Cancer Amt Approved"','90','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','90',NULL,'EE Cancer Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Cancer Amt Pending"','91','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','91',NULL,'EE Cancer Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP Cancer Amt Approved"','92','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','92',NULL,'SP Cancer Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP Cancer Amt Pending"','93','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','93',NULL,'SP Cancer Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CH Cancer Amt Approved"','94','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','94',NULL,'CH Cancer Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CH Cancer Amt Pending"','95','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','95',NULL,'CH Cancer Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Organ Amt Approved"','96','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','96',NULL,'EE Organ Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Organ Amt Pending"','97','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','97',NULL,'EE Organ Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP Organ Amt Approved"','98','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','98',NULL,'SP Organ Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP Organ Amt Pending"','99','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','99',NULL,'SP Organ Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CH Organ Amt Approved"','100','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','100',NULL,'CH Organ Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CH Organ Amt Pending"','101','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','101',NULL,'CH Organ Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Quality of Life Amt Approved"','102','(''DA''=''Q,'')',@AdhSystemID,'35','H','01','102',NULL,'EE Quality of Life Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Quality of Life Amt Pending"','103','(''DA''=''Q,'')',@AdhSystemID,'35','H','01','103',NULL,'EE Quality of Life Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP Quality of Life Amt Approved"','104','(''DA''=''Q,'')',@AdhSystemID,'35','H','01','104',NULL,'SP Quality of Life Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP Quality of Life Amt Pending"','105','(''DA''=''Q,'')',@AdhSystemID,'35','H','01','105',NULL,'SP Quality of Life Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CH Quality of Life Amt Approved"','106','(''DA''=''Q,'')',@AdhSystemID,'35','H','01','106',NULL,'CH Quality of Life Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CH Quality of Life Amt Pending"','107','(''DA''=''Q,'')',@AdhSystemID,'35','H','01','107',NULL,'CH Quality of Life Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Child Category Amt Approved"','108','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','108',NULL,'Child Category Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Child Category Amt Pending"','109','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','109',NULL,'Child Category Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Treatment Care Y/N"','110','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','110',NULL,'EE Treatment Care Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP Treatment Care Y/N"','111','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','111',NULL,'SP Treatment Care Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CH Treatment Care Y/N"','112','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','112',NULL,'CH Treatment Care Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE DI Y/N"','113','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','113',NULL,'EE DI Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP DI Y/N"','114','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','114',NULL,'SP DI Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Accident Y/N"','115','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','115',NULL,'EE Accident Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SP Accident Y/N"','116','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','116',NULL,'SP Accident Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CH Accident Y/N"','117','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','117',NULL,'CH Accident Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EE Occ/HIV Y/N"','118','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','118',NULL,'EE Occ/HIV Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Life Policy Number"','119','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','119',NULL,'Life Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Life Bill Location A/C Number"','120','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','120',NULL,'Life Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Life Sort Group"','121','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','121',NULL,'Life Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Life Eff Date"','122','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','122',NULL,'Life Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Life Plan Code"','123','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','123',NULL,'Life Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Life Class Code"','124','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','124',NULL,'Life Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LI Cvgs"','125','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','125',NULL,'LI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LI Termination Date"','126','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','126',NULL,'LI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"AD Cvgs"','127','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','127',NULL,'AD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"AD Termination Date"','128','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','128',NULL,'AD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DLI Cvgs"','129','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','129',NULL,'DLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DLI Termination Date"','130','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','130',NULL,'DLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DAD Cvgs"','131','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','131',NULL,'DAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DAD Termination Date"','132','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','132',NULL,'DAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OLI Cvgs"','133','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','133',NULL,'OLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OLI Termination Date"','134','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','134',NULL,'OLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OAD Cvgs"','135','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','135',NULL,'OAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OAD Termination Date"','136','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','136',NULL,'OAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"ODLI Cvgs"','137','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','137',NULL,'ODLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"ODLI Termination Date"','138','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','138',NULL,'ODLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"ODAD Cvgs"','139','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','139',NULL,'ODAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"ODAD Termination Date"','140','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','140',NULL,'ODAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SLI Cvgs"','141','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','141',NULL,'SLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SLI Termination Date"','142','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','142',NULL,'SLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SAD Cvgs"','143','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','143',NULL,'SAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SAD Termination Date"','144','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','144',NULL,'SAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CLI Cvgs"','145','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','145',NULL,'CLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CLI Termination Date"','146','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','146',NULL,'CLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OSLI Cvgs"','147','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','147',NULL,'OSLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OSLI Termination Date"','148','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','148',NULL,'OSLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OSAD Cvgs"','149','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','149',NULL,'OSAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OSAD Termination Date"','150','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','150',NULL,'OSAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OCLI Cvgs"','151','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','151',NULL,'OCLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OCLI Termination Date"','152','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','152',NULL,'OCLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"WI Policy Number"','153','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','153',NULL,'WI Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"WI Bill Location A/C Number"','154','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','154',NULL,'WI Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"WI Sort Group"','155','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','155',NULL,'WI Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"WI Eff Date"','156','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','156',NULL,'WI Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"WI Plan Code"','157','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','157',NULL,'WI Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"WI Class Code"','158','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','158',NULL,'WI Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"WI Cvgs"','159','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','159',NULL,'WI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"WI Termination Date"','160','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','160',NULL,'WI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OWI Cvgs"','161','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','161',NULL,'OWI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OWI Termination Date"','162','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','162',NULL,'OWI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LTD Policy Number"','163','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','163',NULL,'LTD Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LTD Bill Location A/C Number"','164','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','164',NULL,'LTD Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LTD Sort Group"','165','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','165',NULL,'LTD Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LTD Eff Date"','166','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','166',NULL,'LTD Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LTD Plan Code"','167','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','167',NULL,'LTD Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LTD Class Code"','168','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','168',NULL,'LTD Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LTD Cvgs"','169','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','169',NULL,'LTD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LTD Termination Date"','170','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','170',NULL,'LTD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OLTD Cvgs"','171','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','171',NULL,'OLTD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"OLTD Termination Date"','172','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','172',NULL,'OLTD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CI Cvgs"','173','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','173',NULL,'CI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CI Termination Date"','174','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','174',NULL,'CI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dent Policy Number"','175','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','175',NULL,'Dent Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dent Bill Location A/C Number"','176','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','176',NULL,'Dent Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dent Sort Group"','177','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','177',NULL,'Dent Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dent Eff Date"','178','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','178',NULL,'Dent Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dent Plan Code"','179','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','179',NULL,'Dent Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dent Class Code"','180','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','180',NULL,'Dent Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dent Coverage Tier"','181','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','181',NULL,'Dent Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dent Other Ins"','182','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','182',NULL,'Dent Other Ins',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dent Termination Date"','183','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','183',NULL,'Dent Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DHMO Policy Number"','184','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','184',NULL,'DHMO Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DHMO Bill Location A/C Number"','185','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','185',NULL,'DHMO Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DHMO Sort Group"','186','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','186',NULL,'DHMO Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DHMO Eff Date"','187','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','187',NULL,'DHMO Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DHMO Plan Code"','188','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','188',NULL,'DHMO Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DHMO Class Code"','189','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','189',NULL,'DHMO Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DHMO Coverage Tier"','190','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','190',NULL,'DHMO Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DHMO PCP"','191','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','191',NULL,'DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DHMO Termination Date"','192','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','192',NULL,'DHMO Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LVC Policy Number"','193','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','193',NULL,'LVC Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LVC Bill Location A/C Number"','194','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','194',NULL,'LVC Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LVC Sort Group"','195','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','195',NULL,'LVC Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LVC Eff Date"','196','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','196',NULL,'LVC Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LVC Plan Code"','197','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','197',NULL,'LVC Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LVC Class Code"','198','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','198',NULL,'LVC Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LVC Coverage Tier"','199','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','199',NULL,'LVC Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LVC Other Ins"','200','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','200',NULL,'LVC Other Ins',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LVC Termination Date"','201','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','201',NULL,'LVC Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLVC Policy Number"','202','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','202',NULL,'VLVC Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLVC Bill Location A/C Number"','203','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','203',NULL,'VLVC Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLVC Sort Group"','204','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','204',NULL,'VLVC Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLVC Eff Date"','205','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','205',NULL,'VLVC Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLVC Plan Code"','206','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','206',NULL,'VLVC Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLVC Class Code"','207','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','207',NULL,'VLVC Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLVC Coverage Tier"','208','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','208',NULL,'VLVC Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLVC Other Ins"','209','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','209',NULL,'VLVC Other Ins',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLVC Termination Date"','210','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','210',NULL,'VLVC Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDN Policy Number"','211','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','211',NULL,'VDN Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDN Bill Location A/C Number"','212','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','212',NULL,'VDN Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDN Sort Group"','213','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','213',NULL,'VDN Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDN Eff Date"','214','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','214',NULL,'VDN Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDN Plan Code"','215','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','215',NULL,'VDN Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDN Class Code"','216','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','216',NULL,'VDN Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDN Coverage Tier"','217','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','217',NULL,'VDN Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDN Other Ins"','218','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','218',NULL,'VDN Other Ins',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDN Termination Date"','219','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','219',NULL,'VDN Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDHMO Policy Number"','220','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','220',NULL,'VDHMO Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDHMO Bill Location A/C Number"','221','(''DA''=''Q,'')',@AdhSystemID,'35','H','01','221',NULL,'VDHMO Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDHMO Sort Group"','222','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','222',NULL,'VDHMO Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDHMO Eff Date"','223','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','223',NULL,'VDHMO Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDHMO Plan Code"','224','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','224',NULL,'VDHMO Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDHMO Class Code"','225','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','225',NULL,'VDHMO Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDHMO Coverage Tier"','226','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','226',NULL,'VDHMO Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDHMO PCP"','227','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','227',NULL,'VDHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VDHMO Termination Date"','228','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','228',NULL,'VDHMO Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLIF Policy Number"','229','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','229',NULL,'VLIF Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLIF Bill Location A/C Number"','230','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','230',NULL,'VLIF Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLIF Sort Group"','231','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','231',NULL,'VLIF Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLIF Eff Date"','232','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','232',NULL,'VLIF Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLIF Plan Code"','233','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','233',NULL,'VLIF Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLIF Class Code"','234','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','234',NULL,'VLIF Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLI Cvgs"','235','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','235',NULL,'VLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLI Termination Date"','236','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','236',NULL,'VLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VAD Cvgs"','237','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','237',NULL,'VAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VAD Termination Date"','238','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','238',NULL,'VAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VSLI Cvgs"','239','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','239',NULL,'VSLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VSLI Termination Date"','240','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','240',NULL,'VSLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VSAD Cvgs"','241','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','241',NULL,'VSAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VSAD Termination Date"','242','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','242',NULL,'VSAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VCLI Cvgs"','243','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','243',NULL,'VCLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VCLI Termination Date"','244','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','244',NULL,'VCLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VWI Policy Number"','245','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','245',NULL,'VWI Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VWI Bill Location A/C Number"','246','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','246',NULL,'VWI Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VWI Sort Group"','247','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','247',NULL,'VWI Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VWI Eff Date"','248','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','248',NULL,'VWI Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VWI Plan Code"','249','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','249',NULL,'VWI Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VWI Class Code"','250','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','250',NULL,'VWI Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VWI Benefit Amt"','251','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','251',NULL,'VWI Benefit Amt',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VWI Elim Period"','252','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','252',NULL,'VWI Elim Period',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VWI Benefit Duration"','253','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','253',NULL,'VWI Benefit Duration',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VWI Termination Date"','254','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','254',NULL,'VWI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLTD Policy Number"','255','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','255',NULL,'VLTD Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLTD Bill Location A/C Number"','256','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','256',NULL,'VLTD Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLTD Sort Group"','257','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','257',NULL,'VLTD Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLTD Eff Date"','258','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','258',NULL,'VLTD Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLTD Plan Code"','259','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','259',NULL,'VLTD Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLTD Class Code"','260','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','260',NULL,'VLTD Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLTD Benefit Amt"','261','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','261',NULL,'VLTD Benefit Amt',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLTD Elim Period"','262','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','262',NULL,'VLTD Elim Period',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLTD Benefit Duration"','263','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','263',NULL,'VLTD Benefit Duration',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLTD Benefit Pct"','264','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','264',NULL,'VLTD Benefit Pct',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"VLTD Termination Date"','265','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','265',NULL,'VLTD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STAD Policy Number"','266','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','266',NULL,'STAD Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STAD Bill Location A/C Number"','267','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','267',NULL,'STAD Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STAD Sort Group"','268','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','268',NULL,'STAD Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STAD Eff Date"','269','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','269',NULL,'STAD Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STAD Plan Code"','270','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','270',NULL,'STAD Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STAD Class Code"','271','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','271',NULL,'STAD Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STVAD Cvgs"','272','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','272',NULL,'STVAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STVAD Termination Date"','273','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','273',NULL,'STVAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STVSAD Cvgs"','274','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','274',NULL,'STVSAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STVSAD Termination Date"','275','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','275',NULL,'STVSAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STVCAD Cvgs"','276','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','276',NULL,'STVCAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STVCAD Termination Date"','277','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','277',NULL,'STVCAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Qualifying Event Code"','278','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','278',NULL,'Qualifying Event Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Qualifying Event Eff Date"','279','(''DA''=''Q,'')',@AdhSystemID,'30','H','01','279',NULL,'Qualifying Event Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Mbr Smoker"','280','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','280',NULL,'Mbr Smoker',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Spouse Smoker"','281','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','281',NULL,'Spouse Smoker',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Spouse DOB"','282','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','282',NULL,'Spouse DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep First Name"','283','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','283',NULL,'Dep First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep Last Name"','284','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','284',NULL,'Dep Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep M I"','285','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','285',NULL,'Dep M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep Gender"','286','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','286',NULL,'Dep Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep DOB"','287','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','287',NULL,'Dep DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep Relationship Code"','288','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','288',NULL,'Dep Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep Student Code"','289','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','289',NULL,'Dep Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep Disabled Y/N"','290','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','290',NULL,'Dep Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep Cvg Indicator"','291','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','291',NULL,'Dep Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep DHMO PCP"','292','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','292',NULL,'Dep DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 2 First Name"','293','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','293',NULL,'Dep 2 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 2 Last Name"','294','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','294',NULL,'Dep 2 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 2 M I"','295','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','295',NULL,'Dep 2 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 2 Gender"','296','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','296',NULL,'Dep 2 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 2 DOB"','297','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','297',NULL,'Dep 2 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 2 Relationship Code"','298','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','298',NULL,'Dep 2 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 2 Student Code"','299','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','299',NULL,'Dep 2 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 2 Cvg Indicator"','300','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','300',NULL,'Dep 2 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 2 Disabled Y/N"','301','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','301',NULL,'Dep 2 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 2 DHMO PCP"','302','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','302',NULL,'Dep 2 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 3 First Name"','303','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','303',NULL,'Dep 3 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 3 Last Name"','304','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','304',NULL,'Dep 3 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 3 M I"','305','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','305',NULL,'Dep 3 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 3 Gender"','306','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','306',NULL,'Dep 3 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 3 DOB"','307','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','307',NULL,'Dep 3 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 3 Relationship Code"','308','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','308',NULL,'Dep 3 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 3 Student Code"','309','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','309',NULL,'Dep 3 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 3 Disabled Y/N"','310','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','310',NULL,'Dep 3 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 3 Cvg Indicator"','311','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','311',NULL,'Dep 3 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 3 DHMO PCP"','312','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','312',NULL,'Dep 3 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 4 First Name"','313','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','313',NULL,'Dep 4 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 4 Last Name"','314','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','314',NULL,'Dep 4 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 4 M I"','315','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','315',NULL,'Dep 4 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 4 Gender"','316','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','316',NULL,'Dep 4 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 4 DOB"','317','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','317',NULL,'Dep 4 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 4 Relationship Code"','318','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','318',NULL,'Dep 4 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 4 Student Code"','319','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','319',NULL,'Dep 4 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 4 Disabled Y/N"','320','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','320',NULL,'Dep 4 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 4 Cvg Indicator"','321','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','321',NULL,'Dep 4 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 4 DHMO PCP"','322','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','322',NULL,'Dep 4 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 5 First Name"','323','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','323',NULL,'Dep 5 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 5 Last Name"','324','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','324',NULL,'Dep 5 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 5 M I"','325','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','325',NULL,'Dep 5 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 5 Gender"','326','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','326',NULL,'Dep 5 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 5 DOB"','327','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','327',NULL,'Dep 5 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 5 Relationship Code"','328','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','328',NULL,'Dep 5 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 5 Student Code"','329','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','329',NULL,'Dep 5 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 5 Disabled Y/N"','330','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','330',NULL,'Dep 5 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 5 Cvg Indicator"','331','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','331',NULL,'Dep 5 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 5 DHMO PCP"','332','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','332',NULL,'Dep 5 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 6 First Name"','333','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','333',NULL,'Dep 6 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 6 Last Name"','334','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','334',NULL,'Dep 6 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 6 M I"','335','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','335',NULL,'Dep 6 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 6 Gender"','336','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','336',NULL,'Dep 6 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 6 DOB"','337','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','337',NULL,'Dep 6 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 6 Relationship Code"','338','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','338',NULL,'Dep 6 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 6 Student Code"','339','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','339',NULL,'Dep 6 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 6 Disabled Y/N"','340','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','340',NULL,'Dep 6 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 6 Cvg Indicator"','341','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','341',NULL,'Dep 6 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 6 DHMO PCP"','342','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','342',NULL,'Dep 6 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 7 First Name"','343','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','343',NULL,'Dep 7 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 7 Last Name"','344','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','344',NULL,'Dep 7 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 7 M I"','345','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','345',NULL,'Dep 7 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 7 Gender"','346','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','346',NULL,'Dep 7 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 7 DOB"','347','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','347',NULL,'Dep 7 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 7 Relationship Code"','348','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','348',NULL,'Dep 7 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 7 Student Code"','349','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','349',NULL,'Dep 7 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 7 Disabled Y/N"','350','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','350',NULL,'Dep 7 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 7 Cvg Indicator"','351','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','351',NULL,'Dep 7 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 7 DHMO PCP"','352','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','352',NULL,'Dep 7 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 8 First Name"','353','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','353',NULL,'Dep 8 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 8 Last Name"','354','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','354',NULL,'Dep 8 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 8 M I"','355','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','355',NULL,'Dep 8 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 8 Gender"','356','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','356',NULL,'Dep 8 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 8 DOB"','357','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','357',NULL,'Dep 8 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 8 Relationship Code"','358','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','358',NULL,'Dep 8 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 8 Student Code"','359','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','359',NULL,'Dep 8 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 8 Disabled Y/N"','360','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','360',NULL,'Dep 8 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 8 Cvg Indicator"','361','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','361',NULL,'Dep 8 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 8 DHMO PCP"','362','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','362',NULL,'Dep 8 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 9 First Name"','363','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','363',NULL,'Dep 9 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 9 Last Name"','364','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','364',NULL,'Dep 9 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 9 M I"','365','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','365',NULL,'Dep 9 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 9 Gender"','366','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','366',NULL,'Dep 9 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 9 DOB"','367','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','367',NULL,'Dep 9 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 9 Relationship Code"','368','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','368',NULL,'Dep 9 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 9 Student Code"','369','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','369',NULL,'Dep 9 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 9 Disabled Y/N"','370','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','370',NULL,'Dep 9 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 9 Cvg Indicator"','371','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','371',NULL,'Dep 9 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 9 DHMO PCP"','372','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','372',NULL,'Dep 9 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 10 First Name"','373','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','373',NULL,'Dep 10 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 10 Last Name"','374','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','374',NULL,'Dep 10 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 10 M I"','375','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','375',NULL,'Dep 10 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 10 Gender"','376','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','376',NULL,'Dep 10 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 10 DOB"','377','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','377',NULL,'Dep 10 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 10 Relationship Code"','378','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','378',NULL,'Dep 10 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 10 Student Code"','379','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','379',NULL,'Dep 10 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 10 Disabled Y/N"','380','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','380',NULL,'Dep 10 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 10 Cvg Indicator"','381','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','381',NULL,'Dep 10 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 10 DHMO PCP"','382','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','382',NULL,'Dep 10 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 11 First Name"','383','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','383',NULL,'Dep 11 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 11 Last Name"','384','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','384',NULL,'Dep 11 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 11 M I"','385','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','385',NULL,'Dep 11 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 11 Gender"','386','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','386',NULL,'Dep 11 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 11 DOB"','387','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','387',NULL,'Dep 11 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 11 Relationship Code"','388','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','388',NULL,'Dep 11 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 11Student Code"','389','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','389',NULL,'Dep 11Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 11 Disabled Y/N"','390','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','390',NULL,'Dep 11 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 11 Cvg Indicator"','391','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','391',NULL,'Dep 11 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 11 DHMO PCP"','392','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','392',NULL,'Dep 11 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 12 First Name"','393','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','393',NULL,'Dep 12 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 12 Last Name"','394','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','394',NULL,'Dep 12 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 12 M I"','395','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','395',NULL,'Dep 12 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 12 Gender"','396','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','396',NULL,'Dep 12 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 12 DOB"','397','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','397',NULL,'Dep 12 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 12 Relationship Code"','398','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','398',NULL,'Dep 12 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 12 Student Code"','399','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','399',NULL,'Dep 12 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 12 Cvg Indicator"','400','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','400',NULL,'Dep 12 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 12 Disabled Y/N"','401','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','401',NULL,'Dep 12 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 12 DHMO PCP"','402','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','402',NULL,'Dep 12 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 13 First Name"','403','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','403',NULL,'Dep 13 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 13 Last Name"','404','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','404',NULL,'Dep 13 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 13 M I"','405','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','405',NULL,'Dep 13 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 13 Gender"','406','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','406',NULL,'Dep 13 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 13 DOB"','407','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','407',NULL,'Dep 13 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 13 Relationship Code"','408','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','408',NULL,'Dep 13 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 13 Student Code"','409','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','409',NULL,'Dep 13 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 13 Disabled Y/N"','410','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','410',NULL,'Dep 13 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 13 Cvg Indicator"','411','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','411',NULL,'Dep 13 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 13 DHMO PCP"','412','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','412',NULL,'Dep 13 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 14 First Name"','413','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','413',NULL,'Dep 14 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 14 Last Name"','414','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','414',NULL,'Dep 14 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 14 M I"','415','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','415',NULL,'Dep 14 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 14 Gender"','416','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','416',NULL,'Dep 14 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 14 DOB"','417','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','417',NULL,'Dep 14 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 14 Relationship Code"','418','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','418',NULL,'Dep 14 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 14 Student Code"','419','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','419',NULL,'Dep 14 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 14 Disabled Y/N"','420','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','420',NULL,'Dep 14 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 14 Cvg Indicator"','421','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','421',NULL,'Dep 14 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 14 DHMO PCP"','422','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','422',NULL,'Dep 14 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 15 First Name"','423','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','423',NULL,'Dep 15 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 15 Last Name"','424','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','424',NULL,'Dep 15 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 15 M I"','425','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','425',NULL,'Dep 15 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 15 Gender"','426','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','426',NULL,'Dep 15 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 15 DOB"','427','(''DA''=''Q,'')',@AdhSystemID,'15','H','01','427',NULL,'Dep 15 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 15 Relationship Code"','428','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','428',NULL,'Dep 15 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 15 Student Code"','429','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','429',NULL,'Dep 15 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 15 Disabled Y/N"','430','(''DA''=''Q,'')',@AdhSystemID,'20','H','01','430',NULL,'Dep 15 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 15 Cvg Indicator"','431','(''DA''=''Q,'')',@AdhSystemID,'25','H','01','431',NULL,'Dep 15 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dep 15 DHMO PCP"','432','(''DA''=''Q'')',@AdhSystemID,'20','H','01','432',NULL,'Dep 15 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeID"','1','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','1',NULL,'Employee ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvChangeDate"','2','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','2',NULL,'Change Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepChangeDate"','3','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','3',NULL,'Dep Change Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTerminationDate"','4','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','4',NULL,'Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrFirstName"','5','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','5',NULL,'Mbr First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrLastName"','6','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','6',NULL,'Mbr Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrMiddleInitial"','7','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','7',NULL,'Mbr Middle Initial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrSSN"','8','(''UA''=''Q,'')',@AdhSystemID,'11','D','10','8',NULL,'Mbr SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrGender"','9','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','9',NULL,'Mbr Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrDOB"','10','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','10',NULL,'Mbr DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAppSignDate"','11','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','11',NULL,'App Sign Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOccupation"','12','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','12',NULL,'Occupation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHrsPerWeek"','13','(''UNT2''=''Q,'')',@AdhSystemID,'6','D','10','13',NULL,'Hrs Per Week',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSalaryAmt"','14','(''UNT2''=''Q,'')',@AdhSystemID,'12','D','10','14',NULL,'Salary Amt',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSalaryCode"','15','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','15',NULL,'Salary Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSalEffDate"','16','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','16',NULL,'Sal Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrAddr1"','17','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','17',NULL,'Mbr Addr 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrAddr2"','18','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','18',NULL,'Mbr Addr 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrCity"','19','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','19',NULL,'Mbr City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrState"','20','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','20',NULL,'Mbr State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrZipCode"','21','(''UA''=''Q,'')',@AdhSystemID,'7','D','10','21',NULL,'Mbr Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrZipPlus4"','22','(''UA''=''Q,'')',@AdhSystemID,'4','D','10','22',NULL,'Mbr Zip Plus 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHomePhone"','23','(''UA''=''Q,'')',@AdhSystemID,'12','D','10','23',NULL,'Home Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWorkPhone"','24','(''UA''=''Q,'')',@AdhSystemID,'12','D','10','24',NULL,'Work Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWorkPhoneExt"','25','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','25',NULL,'Work Phone Ext',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmailAddress"','26','(''UA''=''Q,'')',@AdhSystemID,'100','D','10','26',NULL,'Email Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofBenefitsEligibility"','27','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','27',NULL,'Date of Benefits Eligibility',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSubDateofBenefitsElig"','28','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','28',NULL,'Subsequent Date of Benefits Eligibility',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReasonPriorLossBenefitElig"','29','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','29',NULL,'Reason for Prior Loss of Benefits Eligibility',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPriBeneFirstName"','30','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','30',NULL,'Pri Bene First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPriBeneLastName"','31','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','31',NULL,'Pri Bene Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPriBeneMiddleInit"','32','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','32',NULL,'Pri Bene Middle Init',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPriBeneRelationship"','33','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','33',NULL,'Pri Bene Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPriBeneAddress1"','34','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','34',NULL,'Pri Bene Address 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPriBeneAddress2"','35','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','35',NULL,'Pri Bene Address 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPriBeneCity"','36','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','36',NULL,'Pri Bene City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPriBeneState"','37','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','37',NULL,'Pri Bene State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPriBeneZipCode"','38','(''UA''=''Q,'')',@AdhSystemID,'7','D','10','38',NULL,'Pri Bene Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPriBeneZipPlus4"','39','(''UA''=''Q,'')',@AdhSystemID,'4','D','10','39',NULL,'Pri Bene Zip Plus 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPriBeneSSN"','40','(''UA''=''Q,'')',@AdhSystemID,'11','D','10','40',NULL,'Pri Bene SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoBeneFirstName"','41','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','41',NULL,'Co Bene First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoBeneLastName"','42','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','42',NULL,'Co Bene Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoBeneMiddleInit"','43','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','43',NULL,'Co Bene Middle Init',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoBeneRelationship"','44','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','44',NULL,'Co Bene Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoBeneAddress1"','45','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','45',NULL,'Co Bene Address 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoBeneAddress2"','46','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','46',NULL,'Co Bene Address 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoBeneCity"','47','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','47',NULL,'Co Bene City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoBeneState"','48','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','48',NULL,'Co Bene State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoBeneZipCode"','49','(''UA''=''Q,'')',@AdhSystemID,'7','D','10','49',NULL,'Co Bene Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoBeneZipPlus4"','50','(''UA''=''Q,'')',@AdhSystemID,'4','D','10','50',NULL,'Co Bene Zip Plus 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoBeneSSN"','51','(''UA''=''Q,'')',@AdhSystemID,'11','D','10','51',NULL,'Co Bene SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBeneficiaryComments"','52','(''UA''=''Q,'')',@AdhSystemID,'500','D','10','52',NULL,'Beneficiary Comments',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentPolicyNumber"','53','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','53',NULL,'Accident Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentBLOCAccountNum"','54','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','54',NULL,'Accident Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentSortGroup"','55','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','55',NULL,'Accident Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentEffDate"','56','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','56',NULL,'Accident Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentPlanCode"','57','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','57',NULL,'Accident Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentClassCode"','58','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','58',NULL,'Accident Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentTierCode"','59','(''UA''=''Q,'')',@AdhSystemID,'9','D','10','59',NULL,'Accident Tier Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHealthAssesTier"','60','(''UA''=''Q,'')',@AdhSystemID,'9','D','10','60',NULL,'Health Asses Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHospitalTier"','61','(''UA''=''Q,'')',@AdhSystemID,'9','D','10','61',NULL,'Hospital Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentDisabilityAmount"','62','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','62',NULL,'Accident Disability Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentDITier"','63','(''UA''=''Q,'')',@AdhSystemID,'9','D','10','63',NULL,'Accident DI Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentDIBenefitPeriod"','64','(''UA''=''Q,'')',@AdhSystemID,'3','D','10','64',NULL,'Accident DI Benefit Period',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentDIElimPeriod"','65','(''UA''=''Q,'')',@AdhSystemID,'3','D','10','65',NULL,'Accident DI Elim Period',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentSickDisabilityAmt"','66','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','66',NULL,'Accident Sickness Disability Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentSickTier"','67','(''UA''=''Q,'')',@AdhSystemID,'9','D','10','67',NULL,'Accident/sick Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentSickDIBenefitPer"','68','(''UA''=''Q,'')',@AdhSystemID,'3','D','10','68',NULL,'Accident/sick DI Benefit Period',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentSickDIElimPeriod"','69','(''UA''=''Q,'')',@AdhSystemID,'7','D','10','69',NULL,'Accident/sick DI Elim Period',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccidentTerminationDate"','70','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','70',NULL,'Accident Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCIPolicyNumber"','71','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','71',NULL,'Critical Illness Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCIBLOCAccountNum"','72','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','72',NULL,'Critical Illness Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCISortGroup"','73','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','73',NULL,'Critical Illness Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCIEffDate"','74','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','74',NULL,'Critical Illness Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCIPlanCode"','75','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','75',NULL,'Critical Illness Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCIClassCode"','76','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','76',NULL,'Critical Illness Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCITerminationDate"','77','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','77',NULL,'Critical Illness Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEPrincipalSumAmtApproved"','78','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','78',NULL,'EE Principal Sum Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEPrincipalSumAmtPending"','79','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','79',NULL,'EE Principal Sum Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPPrincipalSumAmtApproved"','80','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','80',NULL,'SP Principal Sum Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPPrincipalSumAmtPending"','81','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','81',NULL,'SP Principal Sum Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCHPrincipalSumAmtApproved"','82','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','82',NULL,'CH Principal Sum Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCHPrincipalSumAmtPending"','83','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','83',NULL,'CH Principal Sum Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEHeartAmtApproved"','84','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','84',NULL,'EE Heart Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEHeartAmtPending"','85','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','85',NULL,'EE Heart Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPHeartAmtApproved"','86','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','86',NULL,'SP Heart Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPHeartAmtPending"','87','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','87',NULL,'SP Heart Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCHHeartAmtApproved"','88','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','88',NULL,'CH Heart Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCHHeartAmtPending"','89','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','89',NULL,'CH Heart Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEECancerAmtApproved"','90','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','90',NULL,'EE Cancer Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEECancerAmtPending"','91','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','91',NULL,'EE Cancer Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPCancerAmtApproved"','92','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','92',NULL,'SP Cancer Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPCancerAmtPending"','93','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','93',NULL,'SP Cancer Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCHCancerAmtApproved"','94','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','94',NULL,'CH Cancer Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCHCancerAmtPending"','95','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','95',NULL,'CH Cancer Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEOrganAmtApproved"','96','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','96',NULL,'EE Organ Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEOrganAmtPending"','97','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','97',NULL,'EE Organ Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPOrganAmtApproved"','98','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','98',NULL,'SP Organ Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPOrganAmtPending"','99','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','99',NULL,'SP Organ Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCHOrganAmtApproved"','100','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','100',NULL,'CH Organ Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCHOrganAmtPending"','101','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','101',NULL,'CH Organ Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEQualityofLifeAmtApproved"','102','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','102',NULL,'EE Quality of Life Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEQualityofLifeAmtPending"','103','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','103',NULL,'EE Quality of Life Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPQualityofLifeAmtApproved"','104','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','104',NULL,'SP Quality of Life Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPQualityofLifeAmtPending"','105','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','105',NULL,'SP Quality of Life Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCHQualityofLifeAmtApproved"','106','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','106',NULL,'CH Quality of Life Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCHQualityofLifeAmtPending"','107','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','107',NULL,'CH Quality of Life Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvChildCategoryAmtApproved"','108','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','108',NULL,'Child Category Amt Approved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvChildCategoryAmtPending"','109','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','109',NULL,'Child Category Amt Pending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEETreatmentCareYN"','110','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','110',NULL,'EE Treatment Care Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPTreatmentCareYN"','111','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','111',NULL,'SP Treatment Care Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCHTreatmentCareYN"','112','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','112',NULL,'CH Treatment Care Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEDIYN"','113','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','113',NULL,'EE DI Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPDIYN"','114','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','114',NULL,'SP DI Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEAccidentYN"','115','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','115',NULL,'EE Accident Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPAccidentYN"','116','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','116',NULL,'SP Accident Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCHAccidentYN"','117','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','117',NULL,'CH Accident Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEEOccHIVYN"','118','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','118',NULL,'EE Occ/HIV Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLifePolicyNumber"','119','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','119',NULL,'Life Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLifeBillLocationACNumber"','120','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','120',NULL,'Life Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLifeSortGroup"','121','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','121',NULL,'Life Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLifeEffDate"','122','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','122',NULL,'Life Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLifePlanCode"','123','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','123',NULL,'Life Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLifeClassCode"','124','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','124',NULL,'Life Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLICvgs"','125','(''UA''=''Q,'')',@AdhSystemID,'200','D','10','125',NULL,'LI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLITerminationDate"','126','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','126',NULL,'LI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvADCvgs"','127','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','127',NULL,'AD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvADTerminationDate"','128','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','128',NULL,'AD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDLICvgs"','129','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','129',NULL,'DLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDLITerminationDate"','130','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','130',NULL,'DLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDADCvgs"','131','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','131',NULL,'DAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDADTerminationDate"','132','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','132',NULL,'DAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOLICvgs"','133','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','133',NULL,'OLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOLITerminationDate"','134','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','134',NULL,'OLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOADCvgs"','135','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','135',NULL,'OAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOADTerminationDate"','136','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','136',NULL,'OAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvODLICvgs"','137','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','137',NULL,'ODLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvODLITerminationDate"','138','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','138',NULL,'ODLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvODADCvgs"','139','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','139',NULL,'ODAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvODADTerminationDate"','140','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','140',NULL,'ODAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSLICvgs"','141','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','141',NULL,'SLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSLITerminationDate"','142','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','142',NULL,'SLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSADCvgs"','143','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','143',NULL,'SAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSADTerminationDate"','144','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','144',NULL,'SAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCLICvgs"','145','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','145',NULL,'CLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCLITerminationDate"','146','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','146',NULL,'CLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOSLICvgs"','147','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','147',NULL,'OSLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOSLITerminationDate"','148','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','148',NULL,'OSLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOSADCvgs"','149','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','149',NULL,'OSAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOSADTerminationDate"','150','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','150',NULL,'OSAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOCLICvgs"','151','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','151',NULL,'OCLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOCLITerminationDate"','152','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','152',NULL,'OCLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWIPolicyNumber"','153','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','153',NULL,'WI Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWIBillLocationACNumber"','154','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','154',NULL,'WI Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWISortGroup"','155','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','155',NULL,'WI Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWIEffDate"','156','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','156',NULL,'WI Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWIPlanCode"','157','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','157',NULL,'WI Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWIClassCode"','158','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','158',NULL,'WI Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWICvgs"','159','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','159',NULL,'WI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWITerminationDate"','160','(''UD101''=''Q,'')',@AdhSystemID,'2','D','10','160',NULL,'WI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOWICvgs"','161','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','161',NULL,'OWI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOWITerminationDate"','162','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','162',NULL,'OWI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLTDPolicyNumber"','163','(''UA''=''Q,'')',@AdhSystemID,'50','D','10','163',NULL,'LTD Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLTDBillLocationACNumber"','164','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','164',NULL,'LTD Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLTDSortGroup"','165','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','165',NULL,'LTD Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLTDEffDate"','166','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','166',NULL,'LTD Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLTDPlanCode"','167','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','167',NULL,'LTD Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLTDClassCode"','168','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','168',NULL,'LTD Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLTDCvgs"','169','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','169',NULL,'LTD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLTDTerminationDate"','170','(''UD101''=''Q,'')',@AdhSystemID,'2','D','10','170',NULL,'LTD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOLTDCvgs"','171','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','171',NULL,'OLTD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOLTDTerminationDate"','172','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','172',NULL,'OLTD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCICvgs"','173','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','173',NULL,'CI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCITerminationDate"','174','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','174',NULL,'CI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDentPolicyNumber"','175','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','175',NULL,'Dent Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDentBillLocationACNumber"','176','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','176',NULL,'Dent Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDentSortGroup"','177','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','177',NULL,'Dent Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDentEffDate"','178','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','178',NULL,'Dent Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDentPlanCode"','179','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','179',NULL,'Dent Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDentClassCode"','180','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','180',NULL,'Dent Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDentCoverageTier"','181','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','181',NULL,'Dent Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDentOtherIns"','182','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','182',NULL,'Dent Other Ins',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDentTerminationDate"','183','(''UD101''=''Q,'')',@AdhSystemID,'1','D','10','183',NULL,'Dent Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDHMOPolicyNumber"','184','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','184',NULL,'DHMO Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDHMOBillLocationACNumber"','185','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','185',NULL,'DHMO Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDHMOSortGroup"','186','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','186',NULL,'DHMO Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDHMOEffDate"','187','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','187',NULL,'DHMO Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDHMOPlanCode"','188','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','188',NULL,'DHMO Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDHMOClassCode"','189','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','189',NULL,'DHMO Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDHMOCoverageTier"','190','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','190',NULL,'DHMO Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDHMOPCP"','191','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','191',NULL,'DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDHMOTerminationDate"','192','(''UD101''=''Q,'')',@AdhSystemID,'1','D','10','192',NULL,'DHMO Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLVCPolicyNumber"','193','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','193',NULL,'LVC Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLVCBillLocationACNumber"','194','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','194',NULL,'LVC Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLVCSortGroup"','195','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','195',NULL,'LVC Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLVCEffDate"','196','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','196',NULL,'LVC Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLVCPlanCode"','197','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','197',NULL,'LVC Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLVCClassCode"','198','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','198',NULL,'LVC Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLVCCoverageTier"','199','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','199',NULL,'LVC Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLVCOtherIns"','200','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','200',NULL,'LVC Other Ins',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLVCTerminationDate"','201','(''UD101''=''Q,'')',@AdhSystemID,'1','D','10','201',NULL,'LVC Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLVCPolicyNumber"','202','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','202',NULL,'VLVC Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLVCBillLocationACNumber"','203','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','203',NULL,'VLVC Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLVCSortGroup"','204','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','204',NULL,'VLVC Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLVCEffDate"','205','(''UD101''=''Q,'')',@AdhSystemID,'40','D','10','205',NULL,'VLVC Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLVCPlanCode"','206','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','206',NULL,'VLVC Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLVCClassCode"','207','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','207',NULL,'VLVC Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLVCCoverageTier"','208','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','208',NULL,'VLVC Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLVCOtherIns"','209','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','209',NULL,'VLVC Other Ins',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLVCTerminationDate"','210','(''UD101''=''Q,'')',@AdhSystemID,'1','D','10','210',NULL,'VLVC Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDNPolicyNumber"','211','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','211',NULL,'VDN Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDNBillLocationACNumber"','212','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','212',NULL,'VDN Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDNSortGroup"','213','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','213',NULL,'VDN Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDNEffDate"','214','(''UD101''=''Q,'')',@AdhSystemID,'40','D','10','214',NULL,'VDN Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDNPlanCode"','215','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','215',NULL,'VDN Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDNClassCode"','216','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','216',NULL,'VDN Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDNCoverageTier"','217','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','217',NULL,'VDN Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDNOtherIns"','218','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','218',NULL,'VDN Other Ins',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDNTerminationDate"','219','(''UD101''=''Q,'')',@AdhSystemID,'1','D','10','219',NULL,'VDN Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDHMOPolicyNumber"','220','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','220',NULL,'VDHMO Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDHMOBillLocationACNumber"','221','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','221',NULL,'VDHMO Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDHMOSortGroup"','222','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','222',NULL,'VDHMO Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDHMOEffDate"','223','(''UD101''=''Q,'')',@AdhSystemID,'40','D','10','223',NULL,'VDHMO Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDHMOPlanCode"','224','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','224',NULL,'VDHMO Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDHMOClassCode"','225','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','225',NULL,'VDHMO Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDHMOCoverageTier"','226','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','226',NULL,'VDHMO Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDHMOPCP"','227','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','227',NULL,'VDHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVDHMOTerminationDate"','228','(''UD101''=''Q,'')',@AdhSystemID,'40','D','10','228',NULL,'VDHMO Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLIFPolicyNumber"','229','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','229',NULL,'VLIF Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLIFBillLocationACNumber"','230','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','230',NULL,'VLIF Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLIFSortGroup"','231','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','231',NULL,'VLIF Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLIFEffDate"','232','(''UD101''=''Q,'')',@AdhSystemID,'40','D','10','232',NULL,'VLIF Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLIFPlanCode"','233','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','233',NULL,'VLIF Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLIFClassCode"','234','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','234',NULL,'VLIF Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLICvgs"','235','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','235',NULL,'VLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLITerminationDate"','236','(''UD101''=''Q,'')',@AdhSystemID,'40','D','10','236',NULL,'VLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVADCvgs"','237','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','237',NULL,'VAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVADTerminationDate"','238','(''UD101''=''Q,'')',@AdhSystemID,'40','D','10','238',NULL,'VAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVSLICvgs"','239','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','239',NULL,'VSLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVSLITerminationDate"','240','(''UD101''=''Q,'')',@AdhSystemID,'40','D','10','240',NULL,'VSLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVSADCvgs"','241','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','241',NULL,'VSAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVSADTerminationDate"','242','(''UD101''=''Q,'')',@AdhSystemID,'40','D','10','242',NULL,'VSAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVCLICvgs"','243','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','243',NULL,'VCLI Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVCLITerminationDate"','244','(''UD101''=''Q,'')',@AdhSystemID,'40','D','10','244',NULL,'VCLI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVWIPolicyNumber"','245','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','245',NULL,'VWI Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVWIBillLocationACNumber"','246','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','246',NULL,'VWI Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVWISortGroup"','247','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','247',NULL,'VWI Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVWIEffDate"','248','(''UD101''=''Q,'')',@AdhSystemID,'40','D','10','248',NULL,'VWI Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVWIPlanCode"','249','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','249',NULL,'VWI Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVWIClassCode"','250','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','250',NULL,'VWI Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVWIBenefitAmt"','251','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','251',NULL,'VWI Benefit Amt',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVWIElimPeriod"','252','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','252',NULL,'VWI Elim Period',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVWIBenefitDuration"','253','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','253',NULL,'VWI Benefit Duration',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVWITerminationDate"','254','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','254',NULL,'VWI Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLTDPolicyNumber"','255','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','255',NULL,'VLTD Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLTDBillLocationACNumber"','256','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','256',NULL,'VLTD Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLTDSortGroup"','257','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','257',NULL,'VLTD Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLTDEffDate"','258','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','258',NULL,'VLTD Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLTDPlanCode"','259','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','259',NULL,'VLTD Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLTDClassCode"','260','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','260',NULL,'VLTD Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLTDBenefitAmt"','261','(''UA''=''Q,'')',@AdhSystemID,'6','D','10','261',NULL,'VLTD Benefit Amt',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLTDElimPeriod"','262','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','262',NULL,'VLTD Elim Period',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLTDBenefitDuration"','263','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','263',NULL,'VLTD Benefit Duration',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLTDBenefitPct"','264','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','264',NULL,'VLTD Benefit Pct',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVLTDTerminationDate"','265','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','265',NULL,'VLTD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTADPolicyNumber"','266','(''UA''=''Q,'')',@AdhSystemID,'18','D','10','266',NULL,'STAD Policy Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTADBillLocationACNumber"','267','(''UA''=''Q,'')',@AdhSystemID,'10','D','10','267',NULL,'STAD Bill Location A/C Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTADSortGroup"','268','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','268',NULL,'STAD Sort Group',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTADEffDate"','269','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','269',NULL,'STAD Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTADPlanCode"','270','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','270',NULL,'STAD Plan Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTADClassCode"','271','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','271',NULL,'STAD Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTVADCvgs"','272','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','272',NULL,'STVAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTVADTerminationDate"','273','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','273',NULL,'STVAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTVSADCvgs"','274','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','274',NULL,'STVSAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTVSADTerminationDate"','275','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','275',NULL,'STVSAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTVCADCvgs"','276','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','276',NULL,'STVCAD Cvgs',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTVCADTerminationDate"','277','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','277',NULL,'STVCAD Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReasonCode"','278','(''UA''=''Q,'')',@AdhSystemID,'2','D','10','278',NULL,'Qualifying Event Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReasonEffDate"','279','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','279',NULL,'Qualifying Event Eff Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMbrSmoker"','280','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','280',NULL,'Mbr Smoker',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSpouseSmoker"','281','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','281',NULL,'Spouse Smoker',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSpouseDOB"','282','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','282',NULL,'Spouse DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepFirstName"','283','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','283',NULL,'Dep First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepLastName"','284','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','284',NULL,'Dep Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepMI"','285','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','285',NULL,'Dep M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepGender"','286','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','286',NULL,'Dep Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepDOB"','287','(''UD101''=''Q,'')',@AdhSystemID,'10','D','10','287',NULL,'Dep DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepRelationshipCode"','288','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','288',NULL,'Dep Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepStudentCode"','289','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','289',NULL,'Dep Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepDisabledYN"','290','(''UA''=''Q,'')',@AdhSystemID,'1','D','10','290',NULL,'Dep Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepCvgIndicator"','291','(''UA''=''Q,'')',@AdhSystemID,'3','D','10','291',NULL,'Dep Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDepDHMOPCP"','292','(''UA''=''Q,'')',@AdhSystemID,'40','D','10','292',NULL,'Dep DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep2FirstName"','293','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','293',NULL,'Dep 2 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep2LastName"','294','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','294',NULL,'Dep 2 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep2MI"','295','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','295',NULL,'Dep 2 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep2Gender"','296','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','296',NULL,'Dep 2 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep2DOB"','297','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','297',NULL,'Dep 2 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep2RelationshipCode"','298','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','298',NULL,'Dep 2 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep2StudentCode"','299','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','299',NULL,'Dep 2 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep2CvgIndicator"','300','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','300',NULL,'Dep 2 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep2DisabledYN"','301','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','301',NULL,'Dep 2 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep2DHMOPCP"','302','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','302',NULL,'Dep 2 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep3FirstName"','303','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','303',NULL,'Dep 3 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep3LastName"','304','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','304',NULL,'Dep 3 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep3MI"','305','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','305',NULL,'Dep 3 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep3Gender"','306','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','306',NULL,'Dep 3 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep3DOB"','307','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','307',NULL,'Dep 3 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep3RelationshipCode"','308','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','308',NULL,'Dep 3 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep3StudentCode"','309','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','309',NULL,'Dep 3 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep3DisabledYN"','310','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','310',NULL,'Dep 3 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep3CvgIndicator"','311','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','311',NULL,'Dep 3 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep3DHMOPCP"','312','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','312',NULL,'Dep 3 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep4FirstName"','313','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','313',NULL,'Dep 4 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep4LastName"','314','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','314',NULL,'Dep 4 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep4MI"','315','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','315',NULL,'Dep 4 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep4Gender"','316','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','316',NULL,'Dep 4 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep4DOB"','317','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','317',NULL,'Dep 4 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep4RelationshipCode"','318','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','318',NULL,'Dep 4 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep4StudentCode"','319','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','319',NULL,'Dep 4 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep4DisabledYN"','320','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','320',NULL,'Dep 4 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep4CvgIndicator"','321','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','321',NULL,'Dep 4 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep4DHMOPCP"','322','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','322',NULL,'Dep 4 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep5FirstName"','323','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','323',NULL,'Dep 5 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep5LastName"','324','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','324',NULL,'Dep 5 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep5MI"','325','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','325',NULL,'Dep 5 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep5Gender"','326','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','326',NULL,'Dep 5 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep5DOB"','327','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','327',NULL,'Dep 5 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep5RelationshipCode"','328','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','328',NULL,'Dep 5 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep5StudentCode"','329','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','329',NULL,'Dep 5 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep5DisabledYN"','330','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','330',NULL,'Dep 5 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep5CvgIndicator"','331','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','331',NULL,'Dep 5 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep5DHMOPCP"','332','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','332',NULL,'Dep 5 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep6FirstName"','333','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','333',NULL,'Dep 6 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep6LastName"','334','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','334',NULL,'Dep 6 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep6MI"','335','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','335',NULL,'Dep 6 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep6Gender"','336','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','336',NULL,'Dep 6 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep6DOB"','337','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','337',NULL,'Dep 6 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep6RelationshipCode"','338','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','338',NULL,'Dep 6 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep6StudentCode"','339','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','339',NULL,'Dep 6 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep6DisabledYN"','340','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','340',NULL,'Dep 6 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep6CvgIndicator"','341','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','341',NULL,'Dep 6 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep6DHMOPCP"','342','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','342',NULL,'Dep 6 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep7FirstName"','343','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','343',NULL,'Dep 7 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep7LastName"','344','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','344',NULL,'Dep 7 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep7MI"','345','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','345',NULL,'Dep 7 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep7Gender"','346','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','346',NULL,'Dep 7 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep7DOB"','347','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','347',NULL,'Dep 7 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep7RelationshipCode"','348','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','348',NULL,'Dep 7 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep7StudentCode"','349','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','349',NULL,'Dep 7 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep7DisabledYN"','350','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','350',NULL,'Dep 7 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep7CvgIndicator"','351','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','351',NULL,'Dep 7 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep7DHMOPCP"','352','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','352',NULL,'Dep 7 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep8FirstName"','353','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','353',NULL,'Dep 8 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep8LastName"','354','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','354',NULL,'Dep 8 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep8MI"','355','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','355',NULL,'Dep 8 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep8Gender"','356','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','356',NULL,'Dep 8 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep8DOB"','357','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','357',NULL,'Dep 8 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep8RelationshipCode"','358','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','358',NULL,'Dep 8 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep8StudentCode"','359','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','359',NULL,'Dep 8 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep8DisabledYN"','360','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','360',NULL,'Dep 8 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep8CvgIndicator"','361','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','361',NULL,'Dep 8 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep8DHMOPCP"','362','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','362',NULL,'Dep 8 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep9FirstName"','363','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','363',NULL,'Dep 9 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep9LastName"','364','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','364',NULL,'Dep 9 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep9MI"','365','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','365',NULL,'Dep 9 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep9Gender"','366','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','366',NULL,'Dep 9 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep9DOB"','367','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','367',NULL,'Dep 9 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep9RelationshipCode"','368','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','368',NULL,'Dep 9 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep9StudentCode"','369','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','369',NULL,'Dep 9 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep9DisabledYN"','370','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','370',NULL,'Dep 9 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep9CvgIndicator"','371','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','371',NULL,'Dep 9 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep9DHMOPCP"','372','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','372',NULL,'Dep 9 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep10FirstName"','373','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','373',NULL,'Dep 10 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep10LastName"','374','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','374',NULL,'Dep 10 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep10MI"','375','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','375',NULL,'Dep 10 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep10Gender"','376','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','376',NULL,'Dep 10 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep10DOB"','377','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','377',NULL,'Dep 10 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep10RelationshipCode"','378','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','378',NULL,'Dep 10 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep10StudentCode"','379','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','379',NULL,'Dep 10 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep10DisabledYN"','380','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','380',NULL,'Dep 10 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep10CvgIndicator"','381','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','381',NULL,'Dep 10 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep10DHMOPCP"','382','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','382',NULL,'Dep 10 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep11FirstName"','383','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','383',NULL,'Dep 11 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep11LastName"','384','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','384',NULL,'Dep 11 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep11MI"','385','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','385',NULL,'Dep 11 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep11Gender"','386','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','386',NULL,'Dep 11 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep11DOB"','387','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','387',NULL,'Dep 11 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep11RelationshipCode"','388','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','388',NULL,'Dep 11 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep11StudentCode"','389','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','389',NULL,'Dep 11Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep11DisabledYN"','390','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','390',NULL,'Dep 11 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep11CvgIndicator"','391','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','391',NULL,'Dep 11 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep11DHMOPCP"','392','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','392',NULL,'Dep 11 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep12FirstName"','393','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','393',NULL,'Dep 12 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep12LastName"','394','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','394',NULL,'Dep 12 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep12MI"','395','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','395',NULL,'Dep 12 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep12Gender"','396','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','396',NULL,'Dep 12 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep12DOB"','397','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','397',NULL,'Dep 12 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep12RelationshipCode"','398','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','398',NULL,'Dep 12 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep12StudentCode"','399','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','399',NULL,'Dep 12 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep12CvgIndicator"','400','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','400',NULL,'Dep 12 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep12DisabledYN"','401','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','401',NULL,'Dep 12 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep12DHMOPCP"','402','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','402',NULL,'Dep 12 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep13FirstName"','403','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','403',NULL,'Dep 13 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep13LastName"','404','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','404',NULL,'Dep 13 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep13MI"','405','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','405',NULL,'Dep 13 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep13Gender"','406','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','406',NULL,'Dep 13 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep13DOB"','407','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','407',NULL,'Dep 13 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep13RelationshipCode"','408','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','408',NULL,'Dep 13 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep13StudentCode"','409','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','409',NULL,'Dep 13 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep13DisabledYN"','410','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','410',NULL,'Dep 13 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep13CvgIndicator"','411','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','411',NULL,'Dep 13 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep13DHMOPCP"','412','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','412',NULL,'Dep 13 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep14FirstName"','413','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','413',NULL,'Dep 14 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep14LastName"','414','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','414',NULL,'Dep 14 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep14MI"','415','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','415',NULL,'Dep 14 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep14Gender"','416','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','416',NULL,'Dep 14 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep14DOB"','417','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','417',NULL,'Dep 14 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep14RelationshipCode"','418','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','418',NULL,'Dep 14 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep14StudentCode"','419','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','419',NULL,'Dep 14 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep14DisabledYN"','420','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','420',NULL,'Dep 14 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep14CvgIndicator"','421','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','421',NULL,'Dep 14 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep14DHMOPCP"','422','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','422',NULL,'Dep 14 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep15FirstName"','423','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','423',NULL,'Dep 15 First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep15LastName"','424','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','424',NULL,'Dep 15 Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep15MI"','425','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','425',NULL,'Dep 15 M I',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep15Gender"','426','(''UA''=''Q,'')',@AdhSystemID,'15','D','10','426',NULL,'Dep 15 Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep15DOB"','427','(''UD101''=''Q,'')',@AdhSystemID,'15','D','10','427',NULL,'Dep 15 DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep15RelationshipCode"','428','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','428',NULL,'Dep 15 Relationship Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep15StudentCode"','429','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','429',NULL,'Dep 15 Student Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep15DisabledYN"','430','(''UA''=''Q,'')',@AdhSystemID,'20','D','10','430',NULL,'Dep 15 Disabled Y/N',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep15CvgIndicator"','431','(''UA''=''Q,'')',@AdhSystemID,'25','D','10','431',NULL,'Dep 15 Cvg Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDep15DHMOPCP"','432','(''UA''=''Q'')',@AdhSystemID,'20','D','10','432',NULL,'Dep 15 DHMO PCP',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,LEFT(@FixedFormatName,30),'201707129','EMPEXPORT','ONDEMAND',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201707129','Jul 12 2017 12:00PM','Jul 12 2017 12:00PM','201707121',NULL,'','','201707121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201707129','EMPEXPORT','OEACTIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201707129','Jul 12 2017 12:00PM','Jul 12 2017 12:00PM','201707121',NULL,'','','201707121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201707129','EMPEXPORT','OEPASSIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201707129','Jul 12 2017 12:00PM','Jul 12 2017 12:00PM','201707121',NULL,'','','201707121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201707129','EMPEXPORT','TEST',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201707129','Jul 12 2017 12:00PM','Jul 12 2017 12:00PM','201707121',NULL,'','','201707121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@TestFilePath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@UDESFilePath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl',NULL);
GO
IF ('@IsWebFlag' = 'Y')
BEGIN
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = '@CustomFormatCode' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = '@CustomFormatCode.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
UPDATE dbo.AscExp SET expAscFileName = @FILEPATH + @FILENAME WHERE expFormatCode = '@CustomFormatCode';

/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'ExportPath' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
/*03*/ DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'TestPath'; /* Remove Test Path for Web Exports */

END
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_@CustomFormatCode_File') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: Lincoln Financial Export (v2)

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@PlanDate          DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = '@CustomFormatCode';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@PlanDate        = '01/01/' + CONVERT(CHAR(4),YEAR(GETDATE()))
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedTypes','OPT,OPC,OPS,ADD,LTD,STD,DEN,VIS,OTH');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES(@FormatCode,'ExcludeDedCodes','<exclude deduction codes>'); -- Exclude any Deduction Codes with the Deduction Type that should not be on file
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'SkipAgeGradedRateCalcRule','<enter deduction codes>'); --Include Deduction Codes using Calc Rule: 'Benefit Age Graded * Rate'
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DependentBenefitAgeGradedRate','<enter deduction codes>'); --Include Deduction Codes using Calc Rule: 'Benefit amt * dependent age graded rates'

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

    -- Run Calculate Benefit Amount SP
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --===========================
    -- Invalidate Benefit Plans 
    --===========================

    -- Invalidate Dependents with Dental/Vision that Lost Coverage
    UPDATE dbo.U_dsi_BDM_DepDeductions
    SET DbnValidForExport = 'N'
        ,DbnDedRowStatus = ISNULL(RTRIM(DbnDedRowStatus),'') + '; Manually Invalidated Dependents Losing Coverage'
    WHERE DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y'
    AND DedDedType IN ('DEN','VIS')
    AND DbnBenStopDate IS NOT NULL;

    -- Run Consolidate Table
    EXEC dbo.dsi_BDM_sp_BuildConsolidatedTable @FormatCode, 'Standard';

    /************************************************************************************************************************************************************************
        Populate Translations/Mappings for Each Coverage Type

        NOTE: These will drive the Relationship, Coverage Tier, Plan Type, Policy Number, Bill Location A/C Number, Sort Group, and Coverage Code Mappings in the File
              Once configured properly, then you should NOT need to adjust any of the Driver Table Code
    ************************************************************************************************************************************************************************/

    --=======================================================
    -- Create Custom Translation Table
    --=======================================================
    IF OBJECT_ID('U_@CustomFormatCode_Translations','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Translations;
    CREATE TABLE dbo.U_@CustomFormatCode_Translations (
         TransCode VARCHAR(50) NOT NULL
        ,SrcValue1 VARCHAR(100) NULL
        ,SrcValue2 VARCHAR(100) NULL
        ,SrcValue3 VARCHAR(100) NULL
        ,SrcValue4 VARCHAR(100) NULL
        ,SrcValue5 VARCHAR(100) NULL
        ,TransValue1 VARCHAR(100) NULL
        ,TransValue2 VARCHAR(100) NULL
        ,TransValue3 VARCHAR(100) NULL
        ,TransValue4 VARCHAR(100) NULL
        ,TransValue5 VARCHAR(100) NULL
    );

    --=================================================================
    -- Lincoln Specific Relationship Codes Mappings
    -- TransCode = Translation Name ('Relationship') - DO NOT CHANGE
    --=================================================================
    INSERT INTO dbo.U_@CustomFormatCode_Translations (TransCode,SrcValue1,TransValue1) VALUES
        --S = Spouse
        ('Relationship','SPS','S')
        ,('Relationship','DP','S')

        --C = Child
        ,('Relationship','CHL','C')
        ,('Relationship','STC','C')
        ,('Relationship','DPC','C');

    --==============================================================================================
    -- Lincoln Specific Benefit Options Mappings in Alpha and Numeric Results
        -- TransCode = Translation Name ('CoverageTier') - DO NOT CHANGE
        
        -- TransValue1 = Alpha Values (i.e, 'EE')
        -- TransValue2 = Numeric Values (i.e., '1')
    --==============================================================================================
    INSERT INTO dbo.U_@CustomFormatCode_Translations (TransCode,SrcValue1,TransValue1,TransValue2) VALUES
        ('CoverageTier','EE','EE','1') --EE = Member Only | 1-Employee Only
        ,('CoverageTier','EES','EE/Spouse','2') --EE/Spouse = Member + Spouse | 2-Employee + Spouse
        ,('CoverageTier','EECH','EE/Child','3') --EE/Child = Member + Child | 3-Employee + Child(ren)
        ,('CoverageTier','FAM','EE/Family','4'); --EE/Family = Member + Family | 4-Employee + Spouse + Child(ren)

    --==============================================================================================
    -- Lincoln Specific Mappings based on 'Plan Type' (i.e., Life, VLIF, LTD, STD)
        -- TransCode = Translation Name ('Plan Type') - DO NOT CHANGE

        -- TransValue1 = Lincoln Specific 'Plan Type'
        -- TransValue2 = Lincoln Specific 'Policy Number'
        -- TransValue3 = Lincoln Specific 'Bill Location A/C Number'
        -- TransValue4 = Lincoln Specific 'Sort Group'
        -- TransValue5 = Lincoln Specific 'Coverage Code'

        -- SrcValue1 = Deduction Codes Mapped to Plan Type
    --==============================================================================================
    INSERT INTO dbo.U_@CustomFormatCode_Translations (TransCode,TransValue1,TransValue2,TransValue3,TransValue4,TransValue5,SrcValue1) VALUES

        -----------------------------------------------
        --'Accident' - Accident policy elections
        -----------------------------------------------
        ('PlanType','Accident','000000000000-00000','0000000','',NULL,'@AccidentDedCode')

        -----------------------------------------------
        --'HealthAssessment' - Health Assessment Rider
        -----------------------------------------------
        ,('PlanType','HealthAssessment',NULL,NULL,NULL,NULL,'@HealthAssessmentDedCode')

        -----------------------------------------------
        --'Hospital' - Sickness Hospital Rider
        -----------------------------------------------
        ,('PlanType','Hospital',NULL,NULL,NULL,NULL,'@HospitalDedCode')

        -----------------------------------------------
        --'AccidentDI' - Accident Disability Rider
        -----------------------------------------------
        ,('PlanType','AccidentDI',NULL,NULL,NULL,NULL,'@AccidentDIDedCode')

        ---------------------------------------------------------
        --'AccidentSickDI' - Accident/Sickness Disability Rider
        ---------------------------------------------------------
        ,('PlanType','AccidentSickDI',NULL,NULL,NULL,NULL,'@AccidentSickDIDedCode')

        -----------------------------------------------
        --'CI' - Critical Illness policy elections
        -----------------------------------------------
        ,('PlanType','CI','000000000000-00000','0000000','',NULL,'@CIDedCode')

        -----------------------------------------------
        --'CICancer' - Critical Illness Cancer Category
        -----------------------------------------------
        ,('PlanType','CICancer',NULL,NULL,NULL,NULL,'@CICancerDedCode')

        -----------------------------------------------
        --'CIHeart' - Critical Illness Heart Category
        -----------------------------------------------
        ,('PlanType','CIHeart',NULL,NULL,NULL,NULL,'@CIHeartDedCode')

        -----------------------------------------------
        --'CIOrgan' - Critical Illness Organ Category
        -----------------------------------------------
        ,('PlanType','CIOrgan',NULL,NULL,NULL,NULL,'@CIOrganDedCode')

        -----------------------------------------------------------------
        --'CIQualityOfLife' - Critical Illness Quality of Life Category
        -----------------------------------------------------------------
        ,('PlanType','CIQualityOfLife',NULL,NULL,NULL,NULL,'@CIQualityOfLifeDedCode')

        -----------------------------------------------------------------
        --'CITreatmentCare' - Critical Illness Treatment Care Rider
        -----------------------------------------------------------------
        ,('PlanType','CITreatmentCare',NULL,NULL,NULL,NULL,'@CITreatmentCareDedCode')

        -----------------------------------------------------------------
        --'CIDI' - Critical Illness Disability Income (DI) Rider
        -----------------------------------------------------------------
        ,('PlanType','CIDI',NULL,NULL,NULL,NULL,'@CIDIDedCode')

        -------------------------------------------------
        --'CIAccident' - Critical Illness Accident Rider
        -------------------------------------------------
        ,('PlanType','CIAccident',NULL,NULL,NULL,NULL,'@CIAccidentDedCode')

        -----------------------------------------------
        --'Life' - Basic Life and AD&D policy elections
        -----------------------------------------------
        --LI = Member Life
        ,('PlanType','Life','000000000000-00000','0000000','','LI','@LifeLIDedCode')

        --AD = Member AD&D
        ,('PlanType','Life','000000000000-00000','0000000','','AD','@LifeADDedCode')

        --DLI = Dependent Life
        ,('PlanType','Life','000000000000-00000','0000000','','DLI','@LifeDLIDedCode')

        --DAD = Dependent AD&D
        ,('PlanType','Life','000000000000-00000','0000000','','DAD','@LifeDADDedCode')

        --OLI = Optional Member Life
        ,('PlanType','Life','000000000000-00000','0000000','','OLI','@LifeOLIDedCode')

        --OAD = Optional Member AD&D
        ,('PlanType','Life','000000000000-00000','0000000','','OAD','@LifeOADDedCode')

        --ODLI = Optional Dependent Life
        ,('PlanType','Life','000000000000-00000','0000000','','ODLI','@LifeODLIDedCode')

        --ODAD = Optional Dependent AD&D
        ,('PlanType','Life','000000000000-00000','0000000','','ODAD','@LifeODADDedCode')

        --SLI = Spouse Life
        ,('PlanType','Life','000000000000-00000','0000000','','SLI','@LifeSLIDedCode')

        --SAD = Spouse AD&D
        ,('PlanType','Life','000000000000-00000','0000000','','SAD','@LifeSADDedCode')

        --CLI = Child Life
        ,('PlanType','Life','000000000000-00000','0000000','','CLI','@LifeCLIDedCode')

        --OSLI = Optional Spouse Life
        ,('PlanType','Life','000000000000-00000','0000000','','OSLI','@LifeOSLIDedCode')
        
        --OSAD = Optional Spouse AD&D
        ,('PlanType','Life','000000000000-00000','0000000','','OSAD','@LifeOSADDedCode')
        
        --OCLI = Optional Child Life
        ,('PlanType','Life','000000000000-00000','0000000','','OCLI','@LifeOCLIDedCode')

        -----------------------------------------------
        --'WI' - Weekly Income (STD) policy elections
        -----------------------------------------------
        --WI = Weekly Income/Short Term Disability
        ,('PlanType','WI','000000000000-00000','0000000','','WI','@WIWIDedCode')

        --OWI = Optional Weekly Income/Short Term Disability
        ,('PlanType','WI','000000000000-00000','0000000','','OWI','@WIOWIDedCode')

        -----------------------------------------------
        --'LTD' - Long-Term Disability policy elections
        -----------------------------------------------
        --LTD = Long Term Disability
        ,('PlanType','LTD','000000000000-00000','0000000','','LTD','LTD') --LTD = Long Term Disability

        --OLTD = Optional Long Term Disability
        ,('PlanType','LTD','000000000000-00000','0000000','','OLTD','@OLTDDedCode')
        
        --CI = Critical Illness
        ,('PlanType','LTD','000000000000-00000','0000000','','CI','@CIDedCode')

        -----------------------------------------------
        --'Dent' - Dental (DN) policy elections
        -----------------------------------------------
        ,('PlanType','Dent','000000000000-00000','0000000','',NULL,'@DentDedCode')

        -----------------------------------------------
        --'DHMO' - DHMO policy elections
        -----------------------------------------------
        ,('PlanType','DHMO','000000000000-00000','0000000','',NULL,'@DHMODedCode')

        -----------------------------------------------
        --'LVC' - Lincoln Vision Connect (LVC) policy elections
        -----------------------------------------------
        ,('PlanType','LVC','000000000000-00000','0000000','',NULL,'@LVCDedCode')

        ---------------------------------------------------------------------
        --'VLVC' - Voluntary Lincoln Vision Connect (VLVC) policy elections
        ---------------------------------------------------------------------
        ,('PlanType','VLVC','000000000000-00000','0000000','',NULL,'@VLVCDedCode')

        -----------------------------------------------
        --'VDN' - Voluntary Dental policy elections
        -----------------------------------------------
        ,('PlanType','VDN','000000000000-00000','0000000','',NULL,'@VDNDedCode')

        -----------------------------------------------
        --'VDHMO' - Voluntary DHMO policy elections
        -----------------------------------------------
        ,('PlanType','VDHMO','000000000000-00000','0000000','',NULL,'@VDHMODedCode')

        -----------------------------------------------
        --'VLIF' - Voluntary Life policy elections
        -----------------------------------------------
        --VLI = Voluntary Member Life
        ,('PlanType','VLIF','000000000000-00000','0000000','','VLI','@VLIFVLIDedCode')

        --VAD = Voluntary Member AD&D
        ,('PlanType','VLIF','000000000000-00000','0000000','','VAD','@VLIFVADedCode')

        --VSAD = Voluntary Spouse AD&D
        ,('PlanType','VLIF','000000000000-00000','0000000','','VSAD','@VLIFVSADedCode')

        --VCLI = Voluntary Child Life
        ,('PlanType','VLIF','000000000000-00000','0000000','','VCLI','@VLIFVCLIDedCode')

        --VSLI = Voluntary Spouse Life
        ,('PlanType','VLIF','000000000000-00000','0000000','','VSLI','@VLIFVSLIDedCode')

        ---------------------------------------------------------------------------
        --'VWI' - Voluntary Weekly Income/Short-Term Disability policy elections
        ---------------------------------------------------------------------------
        ,('PlanType','VWI','000000000000-00000','0000000','',NULL,'@VWIDedCode')

        -------------------------------------------------------------
        --'VLTD' - Voluntary Long-Term Disability policy elections
        -------------------------------------------------------------
        ,('PlanType','VLTD','000000000000-00000','0000000','',NULL,'@VLTDDedCode')

        -----------------------------------------------
        --'STAD' - Standalone AD&D policy elections
        -----------------------------------------------
        --STVSAD = Stand Alone Voluntary Spouse AD&D
        ,('PlanType','STAD','000000000000-00000','0000000','','STVSAD','@STADSTVSADDedCode')
        
        --STVCAD = Stand Alone Voluntary Child AD&D
        ,('PlanType','STAD','000000000000-00000','0000000','','STVCAD','@STADSTVCADDedCode');

    --==========================================
    -- Build Working Tables
    --==========================================

    ---------------------------------
    -- Create Benefit Plan Table
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Benefits','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Benefits;
    CREATE TABLE dbo.U_@CustomFormatCode_Benefits (
         BdmEEID CHAR(12) NOT NULL
        ,BdmCOID CHAR(5) NULL
        ,BdmBenStartDate DATETIME NULL
        ,BdmBenStopDate DATETIME NULL
        ,BcaBenAmtCalc VARCHAR(12) NULL
        ,BcaBenAmtCalcSP VARCHAR(12) NULL
        ,BcaBenAmtCalcCH VARCHAR(12) NULL
        ,BdmPlanType VARCHAR(20) NULL
        ,BdmPolicyNumber VARCHAR(20) NULL
        ,BdmBillLocationACNumber VARCHAR(20) NULL
        ,BdmSortGroup VARCHAR(20) NULL
        ,BdmPlanCode VARCHAR(1) NULL
        ,BdmClassCode VARCHAR(1) NULL
        ,BdmCvgs VARCHAR(500) NULL
        ,BdmCoverageTier VARCHAR(20) NULL
        ,BdmOtherIns VARCHAR(1) NULL
        ,BdmElimPeriod VARCHAR(1) NULL
        ,BdmBenefitPeriod VARCHAR(1) NULL
        ,BdmBenefitDuration VARCHAR(1) NULL
        ,BdmBenefitPct VARCHAR(20) NULL
        ,BdmPCP VARCHAR(20) NULL
        ,BdmYNFlag VARCHAR(1) NULL
        ,BdmYNFlagSP VARCHAR(1) NULL
        ,BdmYNFlagCH VARCHAR(1) NULL
        ,BdmRowNo INT NULL
    );

    -- Create Clustered Index
    CREATE CLUSTERED INDEX CDX_U_@CustomFormatCode_Benefits ON dbo.U_@CustomFormatCode_Benefits (BdmEEID,BdmCoID);
    
    -- Create Non-Clustered Index
    CREATE NONCLUSTERED INDEX NCDX_U_@CustomFormatCode_Benefits_BdmPlanType ON dbo.U_@CustomFormatCode_Benefits (BdmPlanType);

    ---------------------------------
    -- Beneficiaries Table
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Beneficiary','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Beneficiary;
    SELECT DISTINCT BfpEEID
        ,BfpConRecID
        ,BfpBeneficiaryType
        ,BfpNameFirst = dbo.dsi_fnRemoveChars(',',ConNameFirst)
        ,BfpNameLast = dbo.dsi_fnRemoveChars(',',ConNameLast)
        ,BfpNameMiddle = LEFT(ConNameMiddle,1)
        ,BfpRelationship = RELATION.CodDesc
        ,BfpAddressLine1 = dbo.dsi_fnRemoveChars(',',ConAddressLine1)
        ,BfpAddressLine2 = dbo.dsi_fnRemoveChars(',',ConAddressLine2)
        ,BfpAddressCity = dbo.dsi_fnRemoveChars(',',ConAddressCity)
        ,BfpAddressState = ConAddressState
        ,BfpAddressZipCode = ConAddressZipCode
        ,BfpSSN = STUFF(STUFF(ConSSN,4,0,'-'), 7,0,'-')
        ,BfpPctToAlloc
        ,Relationship.TransValue1
        ,BfpRowNo = ROW_NUMBER() OVER (PARTITION BY BfpEEID, BfpBeneficiaryType ORDER BY BfpPctToAlloc DESC, CASE WHEN Relationship.TransValue1 = 'S' THEN 1 ELSE 2 END, ConDateOfBirth, ConNameFirst, ConNameLast)
    INTO dbo.U_@CustomFormatCode_Beneficiary
    FROM dbo.Contacts WITH (NOLOCK)
    JOIN (-- Get Beneficiary Information
        SELECT DISTINCT BfpEEID, BfpConRecID, BfpBeneficiaryType, BfpPctToAlloc
        FROM dbo.BnfBPlan
        WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_@CustomFormatCode WHERE BdmEEID = BfpEEID AND BdmDedCode = BfpDedCode)
    ) BnfBPlan
        ON ConEEID = BfpEEID
        AND ConSystemID = BfpConRecID
    LEFT JOIN dbo.Codes RELATION WITH (NOLOCK)
        ON RELATION.CodCode = ConRelationship
        AND RELATION.CodTable = 'RELATION'
    LEFT JOIN dbo.U_@CustomFormatCode_Translations Relationship WITH (NOLOCK)
        ON Relationship.SrcValue1 = ConRelationship
        AND Relationship.TransCode = 'Relationship'

    -- Create Clustered Index
    CREATE CLUSTERED INDEX CDX_U_@CustomFormatCode_Beneficiary ON dbo.U_@CustomFormatCode_Beneficiary (BfpEEID,BfpConRecID,BfpBeneficiaryType,BfpRowNo);

    ---------------------------------
    -- Dependents Table
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Contacts','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Contacts;
    SELECT ConEEID
        ,ConSystemID
        ,ConNameFirst = dbo.dsi_fnRemoveChars(',',ConNameFirst)
        ,ConNameLast = dbo.dsi_fnRemoveChars(',',ConNameLast)
        ,ConNameMiddle = LEFT(ConNameMiddle,1)
        ,ConGender
        ,ConDateOfBirth
        ,ConRelationship
        ,ConIsStudent
        ,ConIsSmoker
        ,ConIsDisabled
        ,ConCoverage = CASE WHEN DEN.BdmDedCode IS NOT NULL AND VIS.BdmDedCode IS NOT NULL THEN 'D,V'
                            WHEN DEN.BdmDedCode IS NOT NULL THEN 'D'
                            WHEN VIS.BdmDedCode IS NOT NULL THEN 'V'
                       END
        ,ConDHMOPCP = ''
        ,ConIsSpouse = CASE WHEN Relationship.TransValue1 = 'S' THEN 'Y' ELSE 'N' END
        ,ConRowNo = ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY CASE WHEN Relationship.TransValue1 = 'S' THEN 1 ELSE 2 END, ConDateOfBirth, ConNameFirst, ConNameLast)
    INTO dbo.U_@CustomFormatCode_Contacts
    FROM dbo.Contacts WITH (NOLOCK)
    LEFT JOIN dbo.U_@CustomFormatCode_Translations Relationship WITH (NOLOCK)
        ON Relationship.SrcValue1 = ConRelationship
        AND Relationship.TransCode = 'Relationship'
    LEFT JOIN dbo.U_dsi_BDM_@CustomFormatCode DEN WITH (NOLOCK)
        ON ConEEID = DEN.BdmEEID
        AND ConSystemID = DEN.BdmDepRecID
        AND DEN.BdmDedType = 'DEN'
    LEFT JOIN dbo.U_dsi_BDM_@CustomFormatCode VIS WITH (NOLOCK)
        ON ConEEID = VIS.BdmEEID
        AND ConSystemID = VIS.BdmDepRecID
        AND VIS.BdmDedType = 'VIS'
    WHERE (DEN.BdmDedCode IS NOT NULL OR VIS.BdmDedCode IS NOT NULL); -- Only Include Dependents with Dental/Vision Plans

    -- Create Clustered Index
    CREATE CLUSTERED INDEX CDX_U_@CustomFormatCode_Contacts ON dbo.U_@CustomFormatCode_Contacts (ConEEID,ConSystemID,ConRowNo);

    /************************************************************************************************************************************************************************
        Populate Benefits Table with Each Coverage Type

        NOTE: The Mappings within this section will drive the values populated in the Driver Table
            --BdmPlanType - Used for the JOINS to defined each Category Type (DO NOT CHANGE)
            --BcaBenAmtCalc - Related to dsi_bdm_sp_CalculateBenefitAmounts used to calculate the Benefit Amounts, EE Amount, ER Amount based on Calc Rules
    ************************************************************************************************************************************************************************/

    --==================================================================
    -- Populate Benefits Table based on Mapping/Translation Settings
    --==================================================================
    INSERT INTO dbo.U_@CustomFormatCode_Benefits (BdmEEID,BdmCOID,BdmBenStartDate,BdmBenStopDate,BcaBenAmtCalc,BcaBenAmtCalcSP,BcaBenAmtCalcCH,BdmPlanType,BdmPolicyNumber,BdmBillLocationACNumber
        ,BdmSortGroup,BdmPlanCode,BdmClassCode,BdmCvgs,BdmCoverageTier,BdmBenefitPeriod,BdmElimPeriod,BdmYNFlag,BdmYNFlagSP,BdmYNFlagCH,BdmRowNo)
    SELECT DISTINCT BdmEEID
        ,BdmCOID
        ,BdmBenStartDate = MIN(BdmBenStartDate)
        ,BdmBenStopDate = MAX(BdmBenStopDate)
        ,BcaBenAmtCalc = MAX(CONVERT(VARCHAR(12),CONVERT(INT,COALESCE(BcaBenAmtCalc,0))))
        ,BcaBenAmtCalcSP = MAX(CONVERT(VARCHAR(12),CONVERT(INT,COALESCE(BcaBenAmtCalc,0))))
        ,BcaBenAmtCalcCH = MAX(CONVERT(VARCHAR(12),CONVERT(INT,COALESCE(BcaBenAmtCalc,0))))
        ,BdmPlanType = PlanType.TransValue1
        ,BdmPolicyNumber = PlanType.TransValue2
        ,BdmBillLocationACNumber = PlanType.TransValue3
        ,BdmSortGroup = PlanType.TransValue4
        ,BdmPlanCode = '1' --If only one Plan Code, default all enrolled Members to 1.
        ,BdmClassCode = '1' --If only one Class Code, default all enrolled Members to 1.
        ,BdmCvgs = ISNULL(PlanType.TransValue5,'') + '-'
                    + CASE WHEN PlanType.TransValue5 IN ('LI','AD','WI') THEN '1' --Basic Life, AD&D, STD should be '1'
                           ELSE MAX(CONVERT(VARCHAR(10),CONVERT(INT,COALESCE(BcaBenAmtCalc,0)))) --Calculated Benefit Amount
                      END
        ,BdmCoverageTier = CASE WHEN PlanType.TransValue1 IN ('Dent','DHMO','LVC','VLVC','VDN','VDHMO') THEN CovTier.TransValue2
                                WHEN PlanType.TransValue1 IN ('Accident','HealthAssessment','Hospital','AccidentDI','AccidentSickDI') THEN CovTier.TransValue1
                           END
        ,BdmBenefitPeriod = ''
        ,BdmElimPeriod = ''
        ,BdmYNFlag = MAX(CASE WHEN BdmRecType = 'EMP' THEN
                            CASE PlanType.TransValue1
                                 WHEN 'CITreatmentCare' THEN 'Y'
                                 WHEN 'CIDI' THEN 'Y'
                                 WHEN 'CIAccident' THEN 'Y'
                            END
                     END)
        ,BdmYNFlagSP = MAX(CASE WHEN BdmRecType = 'DEP' AND Relationship.TransValue1 = 'S' THEN
                            CASE PlanType.TransValue1
                                 WHEN 'CITreatmentCare' THEN 'Y'
                                 WHEN 'CIDI' THEN 'Y'
                                 WHEN 'CIAccident' THEN 'Y'
                            END
                       END)
        ,BdmYNFlagCH = MAX(CASE WHEN BdmRecType = 'DEP' AND Relationship.TransValue1 = 'C' THEN
                            CASE PlanType.TransValue1
                                 WHEN 'CITreatmentCare' THEN 'Y'
                                 WHEN 'CIDI' THEN 'Y'
                                 WHEN 'CIAccident' THEN 'Y'
                            END
                       END)
        ,BdmRowNo = ROW_NUMBER() OVER (PARTITION BY BdmEEID, BdmCOID, PlanType.TransValue1 ORDER BY PlanType.TransValue1)
    FROM dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
    LEFT JOIN dbo.U_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
        ON BcaFormatCode = @FormatCode
        AND BcaEEID = BdmEEID
        AND BcaCOID = BdmCOID
        AND ISNULL(BcaDepRecID,'') = ISNULL(BdmDepRecID,'')
        AND BcaDedCode = BdmDedCode
    LEFT JOIN dbo.U_@CustomFormatCode_Translations PlanType WITH (NOLOCK)
        ON PlanType.SrcValue1 = BdmDedCode
        AND PlanType.TransCode = 'PlanType'
    LEFT JOIN dbo.U_@CustomFormatCode_Translations Relationship WITH (NOLOCK)
        ON Relationship.SrcValue1 = BdmRelationship
        AND Relationship.TransCode = 'Relationship'
    LEFT JOIN dbo.U_@CustomFormatCode_Translations CovTier WITH (NOLOCK)
        ON CovTier.SrcValue1 = BdmBenOption
        AND CovTier.TransCode = 'CoverageTier'
    WHERE PlanType.TransValue1 IS NOT NULL
    GROUP BY BdmEEID, BdmCOID, PlanType.TransValue1, PlanType.TransValue2, PlanType.TransValue3, PlanType.TransValue4, CovTier.TransValue1, CovTier.TransValue2, PlanType.TransValue5;

    --==========================================
    -- Build Driver Tables
    --==========================================

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvChangeDate = '' --Effective Date of Member Change (Changes Only File)
        ,drvDepChangeDate = '' --Effective Date of Covered Dependent Change (Changes Only File)
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvMbrFirstName = dbo.dsi_fnRemoveChars(',',EepNameFirst)
        ,drvMbrLastName = dbo.dsi_fnRemoveChars(',',EepNameLast)
        ,drvMbrMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvMbrSSN = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvMbrGender = EepGender
        ,drvMbrDOB = EepDateOfBirth
        ,drvAppSignDate = dbo.dsi_fnGetMinMaxDates('MAX',dbo.dsi_fnGetMinMaxDates('MAX',(SELECT MIN(BdmBenStartDate) FROM dbo.U_@CustomFormatCode_Benefits WHERE BdmEEID = xEEID),@PlanDate),EecDateOfLastHire)
        ,drvOccupation = dbo.dsi_fnRemoveChars(',',JbcDesc)
        ,drvHrsPerWeek = CASE EecPayPeriod
                              WHEN 'W' THEN EecScheduledWorkHrs
                              WHEN 'B' THEN EecScheduledWorkHrs / 2
                              WHEN 'S' THEN (EecScheduledWorkHrs * 24) / 52
                              WHEN 'M' THEN (EecScheduledWorkHrs * 12) / 52
                         END
        ,drvSalaryAmt = CASE EecSalaryOrHourly
                             WHEN 'S' THEN EecAnnSalary
                             ELSE EecHourlyPayRate
                        END
        ,drvSalaryCode = CASE EecSalaryOrHourly
                              WHEN 'S' THEN 'A'
                              ELSE 'H'
                         END
        ,drvSalEffDate = COALESCE(EjhJobEffDate,EecDateOfLastHire)
        ,drvMbrAddr1 = dbo.dsi_fnRemoveChars(',',EepAddressLine1)
        ,drvMbrAddr2 = dbo.dsi_fnRemoveChars(',',EepAddressLine2)
        ,drvMbrCity = dbo.dsi_fnRemoveChars(',',EepAddressCity)
        ,drvMbrState = EepAddressState
        ,drvMbrZipCode = LEFT(LTRIM(EepAddressZipCode),5)
        ,drvMbrZipPlus4 = SUBSTRING(EepAddressZipCode,6,4)
        ,drvHomePhone = STUFF(STUFF(NULLIF(EepPhoneHomeNumber,''),7,0,'-'),4,0,'-')
        ,drvWorkPhone = STUFF(STUFF(NULLIF(EecPhoneBusinessNumber,''),7,0,'-'),4,0,'-')
        ,drvWorkPhoneExt = EecPhoneBusinessExt
        ,drvEmailAddress = EepAddressEMail
        ,drvDateofBenefitsEligibility = EecDateOfLastHire
        ,drvSubDateofBenefitsElig = EecDateOfBenefitSeniority
        ,drvReasonPriorLossBenefitElig = NULL --Valid Values: TERMINATION, LEAVE OF ABSENCE, LAYOFF, LOST ELIGIBILITY
        ,drvPriBeneFirstName = P.BfpNameFirst
        ,drvPriBeneLastName = P.BfpNameLast
        ,drvPriBeneMiddleInit = P.BfpNameMiddle
        ,drvPriBeneRelationship = P.BfpRelationship
        ,drvPriBeneAddress1 = P.BfpAddressLine1
        ,drvPriBeneAddress2 = P.BfpAddressLine2
        ,drvPriBeneCity = P.BfpAddressCity
        ,drvPriBeneState = P.BfpAddressState
        ,drvPriBeneZipCode = LEFT(LTRIM(P.BfpAddressZipCode),5)
        ,drvPriBeneZipPlus4 = SUBSTRING(P.BfpAddressZipCode,6,4)
        ,drvPriBeneSSN = P.BfpSSN
        ,drvCoBeneFirstName = C.BfpNameFirst
        ,drvCoBeneLastName = C.BfpNameLast
        ,drvCoBeneMiddleInit = C.BfpNameMiddle
        ,drvCoBeneRelationship = C.BfpRelationship
        ,drvCoBeneAddress1 = C.BfpAddressLine1
        ,drvCoBeneAddress2 = C.BfpAddressLine2
        ,drvCoBeneCity = C.BfpAddressCity
        ,drvCoBeneState = C.BfpAddressState
        ,drvCoBeneZipCode = LEFT(LTRIM(C.BfpAddressZipCode),5)
        ,drvCoBeneZipPlus4 = SUBSTRING(C.BfpAddressZipCode,6,4)
        ,drvCoBeneSSN = C.BfpSSN
        ,drvBeneficiaryComments = ''
        --Accident policy
        ,drvAccidentPolicyNumber = Accident.BdmPolicyNumber
        ,drvAccidentBLOCAccountNum = Accident.BdmBillLocationACNumber
        ,drvAccidentSortGroup = Accident.BdmSortGroup
        ,drvAccidentEffDate = Accident.BdmBenStartDate
        ,drvAccidentPlanCode = Accident.BdmPlanCode
        ,drvAccidentClassCode = Accident.BdmClassCode
        ,drvAccidentTierCode = Accident.BdmCoverageTier
        --Health Assessment
        ,drvHealthAssesTier = HealthAssessment.BdmCoverageTier
        --Sickness Hospital
        ,drvHospitalTier = Hospital.BdmCoverageTier
        --Accident Disability Rider
        ,drvAccidentDisabilityAmount = AccidentDI.BcaBenAmtCalc
        ,drvAccidentDITier = AccidentDI.BdmCoverageTier
        ,drvAccidentDIBenefitPeriod = AccidentDI.BdmBenefitPeriod
        ,drvAccidentDIElimPeriod = AccidentDI.BdmElimPeriod
        --Accident/Sickness Disability Rider
        ,drvAccidentSickDisabilityAmt = AccidentSickDI.BcaBenAmtCalc
        ,drvAccidentSickTier = AccidentSickDI.BdmCoverageTier
        ,drvAccidentSickDIBenefitPer = AccidentSickDI.BdmBenefitPeriod
        ,drvAccidentSickDIElimPeriod = AccidentSickDI.BdmElimPeriod
        ,drvAccidentTerminationDate = Accident.BdmBenStopDate
        --Critical Illness policy
        ,drvCIPolicyNumber = CI.BdmPolicyNumber
        ,drvCIBLOCAccountNum = CI.BdmBillLocationACNumber
        ,drvCISortGroup = CI.BdmSortGroup
        ,drvCIEffDate = CI.BdmBenStartDate
        ,drvCIPlanCode = CI.BdmPlanCode
        ,drvCIClassCode = CI.BdmClassCode
        ,drvEEPrincipalSumAmtApproved = CI.BcaBenAmtCalc
        ,drvEEPrincipalSumAmtPending = ''
        ,drvSPPrincipalSumAmtApproved = CI.BcaBenAmtCalcSP
        ,drvSPPrincipalSumAmtPending = ''
        ,drvCHPrincipalSumAmtApproved = CI.BcaBenAmtCalcCH
        ,drvCHPrincipalSumAmtPending = ''
        --Critical Illness Heart Category
        ,drvEEHeartAmtApproved = CIHeart.BcaBenAmtCalc
        ,drvEEHeartAmtPending = ''
        ,drvSPHeartAmtApproved = CIHeart.BcaBenAmtCalcSP
        ,drvSPHeartAmtPending = ''
        ,drvCHHeartAmtApproved = CIHeart.BcaBenAmtCalcCH
        ,drvCHHeartAmtPending = ''
        --Critical Illness Cancer Category
        ,drvEECancerAmtApproved = COALESCE(CICancer.BcaBenAmtCalc,CI.BcaBenAmtCalc)
        ,drvEECancerAmtPending = ''
        ,drvSPCancerAmtApproved = COALESCE(CICancer.BcaBenAmtCalcSP,CI.BcaBenAmtCalcSP)
        ,drvSPCancerAmtPending = ''
        ,drvCHCancerAmtApproved = COALESCE(CICancer.BcaBenAmtCalcCH,CI.BcaBenAmtCalcCH)
        ,drvCHCancerAmtPending = ''
        --Critical Illness Organ Category
        ,drvEEOrganAmtApproved = COALESCE(CIOrgan.BcaBenAmtCalc,CI.BcaBenAmtCalc)
        ,drvEEOrganAmtPending = ''
        ,drvSPOrganAmtApproved = COALESCE(CIOrgan.BcaBenAmtCalcSP,CI.BcaBenAmtCalcSP)
        ,drvSPOrganAmtPending = ''
        ,drvCHOrganAmtApproved = COALESCE(CIOrgan.BcaBenAmtCalcCH,CI.BcaBenAmtCalcCH)
        ,drvCHOrganAmtPending = ''
        --Critical Illness Quality of Life Category
        ,drvEEQualityofLifeAmtApproved = COALESCE(CIQualityOfLife.BcaBenAmtCalc,CI.BcaBenAmtCalc)
        ,drvEEQualityofLifeAmtPending = ''
        ,drvSPQualityofLifeAmtApproved = COALESCE(CIQualityOfLife.BcaBenAmtCalcSP,CI.BcaBenAmtCalcSP)
        ,drvSPQualityofLifeAmtPending = ''
        ,drvCHQualityofLifeAmtApproved = COALESCE(CIQualityOfLife.BcaBenAmtCalcCH,CI.BcaBenAmtCalcCH)
        ,drvCHQualityofLifeAmtPending = ''
        ,drvChildCategoryAmtApproved = ''
        ,drvChildCategoryAmtPending = ''
        --Critical Illness Treatment Care Rider
        ,drvEETreatmentCareYN = CITreatmentCare.BdmYNFlag
        ,drvSPTreatmentCareYN = CITreatmentCare.BdmYNFlagSP
        ,drvCHTreatmentCareYN = CITreatmentCare.BdmYNFlagCH
        --Critical Illness Disability Income Rider
        ,drvEEDIYN = CIDI.BdmYNFlag
        ,drvSPDIYN = CIDI.BdmYNFlagSP
        --Critical Illness Accident Rider
        ,drvEEAccidentYN = CIAccident.BdmYNFlag
        ,drvSPAccidentYN = CIAccident.BdmYNFlagSP
        ,drvCHAccidentYN = CIAccident.BdmYNFlagCH
        ,drvEEOccHIVYN = ''
        --Life and AD&D (Life) policy
        ,drvLifePolicyNumber = Life.BdmPolicyNumber
        ,drvLifeBillLocationACNumber = Life.BdmBillLocationACNumber
        ,drvLifeSortGroup = Life.BdmSortGroup
        ,drvLifeEffDate = Life.BdmBenStartDate
        ,drvLifePlanCode = Life.BdmPlanCode
        ,drvLifeClassCode = Life.BdmClassCode
        ,drvLICvgs = Life.BdmCvgs
        ,drvLITerminationDate = Life.BdmBenStopDate
        ,drvADCvgs = LifeAD.BdmCvgs
        ,drvADTerminationDate = LifeAD.BdmBenStopDate
        ,drvDLICvgs = LifeDLI.BdmCvgs
        ,drvDLITerminationDate = LifeDLI.BdmBenStopDate
        ,drvDADCvgs = LifeDAD.BdmCvgs
        ,drvDADTerminationDate = LifeDAD.BdmBenStopDate
        ,drvOLICvgs = LifeOLI.BdmCvgs
        ,drvOLITerminationDate = LifeOLI.BdmBenStopDate
        ,drvOADCvgs = LifeOAD.BdmCvgs
        ,drvOADTerminationDate = LifeOAD.BdmBenStopDate
        ,drvODLICvgs = LifeODLI.BdmCvgs
        ,drvODLITerminationDate = LifeODLI.BdmBenStopDate
        ,drvODADCvgs = LifeODAD.BdmCvgs
        ,drvODADTerminationDate = LifeODAD.BdmBenStopDate
        ,drvSLICvgs = LifeSLI.BdmCvgs
        ,drvSLITerminationDate = LifeSLI.BdmBenStopDate
        ,drvSADCvgs = LifeSAD.BdmCvgs
        ,drvSADTerminationDate = LifeSAD.BdmBenStopDate
        ,drvCLICvgs = LifeCLI.BdmCvgs
        ,drvCLITerminationDate = LifeCLI.BdmBenStopDate
        ,drvOSLICvgs = LifeOSLI.BdmCvgs
        ,drvOSLITerminationDate = LifeOSLI.BdmBenStopDate
        ,drvOSADCvgs = LifeOSAD.BdmCvgs
        ,drvOSADTerminationDate = LifeOSAD.BdmBenStopDate
        ,drvOCLICvgs = LifeOCLI.BdmCvgs
        ,drvOCLITerminationDate = LifeOCLI.BdmBenStopDate
        --Weekly Income (STD) policy
        ,drvWIPolicyNumber = WI.BdmPolicyNumber
        ,drvWIBillLocationACNumber = WI.BdmBillLocationACNumber
        ,drvWISortGroup = WI.BdmSortGroup
        ,drvWIEffDate = WI.BdmBenStartDate
        ,drvWIPlanCode = WI.BdmPlanCode
        ,drvWIClassCode = WI.BdmClassCode
        ,drvWICvgs = WI.BdmCvgs
        ,drvWITerminationDate = WI.BdmBenStopDate
        ,drvOWICvgs = WIOWI.BdmCvgs
        ,drvOWITerminationDate = WIOWI.BdmBenStopDate
        --Long-Term Disability (LTD) policy
        ,drvLTDPolicyNumber = LTD.BdmPolicyNumber
        ,drvLTDBillLocationACNumber = LTD.BdmBillLocationACNumber
        ,drvLTDSortGroup = LTD.BdmSortGroup
        ,drvLTDEffDate = LTD.BdmBenStartDate
        ,drvLTDPlanCode = LTD.BdmPlanCode
        ,drvLTDClassCode = LTD.BdmClassCode
        ,drvLTDCvgs = LTD.BdmCvgs
        ,drvLTDTerminationDate = LTD.BdmBenStopDate
        ,drvOLTDCvgs = LTDOLTD.BdmCvgs
        ,drvOLTDTerminationDate = LTDOLTD.BdmBenStopDate
        ,drvCICvgs = LTDCI.BdmCvgs
        ,drvCITerminationDate = LTDCI.BdmBenStopDate
        --Dental policy
        ,drvDentPolicyNumber = Dent.BdmPolicyNumber
        ,drvDentBillLocationACNumber = Dent.BdmBillLocationACNumber
        ,drvDentSortGroup = Dent.BdmSortGroup
        ,drvDentEffDate = Dent.BdmBenStartDate
        ,drvDentPlanCode = Dent.BdmPlanCode
        ,drvDentClassCode = Dent.BdmClassCode
        ,drvDentCoverageTier = Dent.BdmCoverageTier
        ,drvDentOtherIns = Dent.BdmOtherIns
        ,drvDentTerminationDate = Dent.BdmBenStopDate
        --(Dental) DHMO policy
        ,drvDHMOPolicyNumber = DHMO.BdmPolicyNumber
        ,drvDHMOBillLocationACNumber = DHMO.BdmBillLocationACNumber
        ,drvDHMOSortGroup = DHMO.BdmSortGroup
        ,drvDHMOEffDate = DHMO.BdmBenStartDate
        ,drvDHMOPlanCode = DHMO.BdmPlanCode
        ,drvDHMOClassCode = DHMO.BdmClassCode
        ,drvDHMOCoverageTier = DHMO.BdmCoverageTier
        ,drvDHMOPCP = DHMO.BdmPCP
        ,drvDHMOTerminationDate = DHMO.BdmBenStopDate
        --Lincoln Vision Connect (LVC) policy
        ,drvLVCPolicyNumber = LVC.BdmPolicyNumber
        ,drvLVCBillLocationACNumber = LVC.BdmBillLocationACNumber
        ,drvLVCSortGroup = LVC.BdmSortGroup
        ,drvLVCEffDate = LVC.BdmBenStartDate
        ,drvLVCPlanCode = LVC.BdmPlanCode
        ,drvLVCClassCode = LVC.BdmClassCode
        ,drvLVCCoverageTier = LVC.BdmCoverageTier
        ,drvLVCOtherIns = LVC.BdmOtherIns
        ,drvLVCTerminationDate = LVC.BdmBenStopDate
        --Voluntary Lincoln Vision Connect (VLVC) policy
        ,drvVLVCPolicyNumber = VLVC.BdmPolicyNumber
        ,drvVLVCBillLocationACNumber = VLVC.BdmBillLocationACNumber
        ,drvVLVCSortGroup = VLVC.BdmSortGroup
        ,drvVLVCEffDate = VLVC.BdmBenStartDate
        ,drvVLVCPlanCode = VLVC.BdmPlanCode
        ,drvVLVCClassCode = VLVC.BdmClassCode
        ,drvVLVCCoverageTier = VLVC.BdmCoverageTier
        ,drvVLVCOtherIns = VLVC.BdmOtherIns
        ,drvVLVCTerminationDate = VLVC.BdmBenStopDate
        --Voluntary Dental (VDN) policy
        ,drvVDNPolicyNumber = VDN.BdmPolicyNumber
        ,drvVDNBillLocationACNumber = VDN.BdmBillLocationACNumber
        ,drvVDNSortGroup = VDN.BdmSortGroup
        ,drvVDNEffDate = VDN.BdmBenStartDate
        ,drvVDNPlanCode = VDN.BdmPlanCode
        ,drvVDNClassCode = VDN.BdmClassCode
        ,drvVDNCoverageTier = VDN.BdmCoverageTier
        ,drvVDNOtherIns = VDN.BdmOtherIns
        ,drvVDNTerminationDate = VDN.BdmBenStopDate
        --Voluntary Dental DHMO (VDHMO) policy
        ,drvVDHMOPolicyNumber = VDHMO.BdmPolicyNumber
        ,drvVDHMOBillLocationACNumber = VDHMO.BdmBillLocationACNumber
        ,drvVDHMOSortGroup = VDHMO.BdmSortGroup
        ,drvVDHMOEffDate = VDHMO.BdmBenStartDate
        ,drvVDHMOPlanCode = VDHMO.BdmPlanCode
        ,drvVDHMOClassCode = VDHMO.BdmClassCode
        ,drvVDHMOCoverageTier = VDHMO.BdmCoverageTier
        ,drvVDHMOPCP = VDHMO.BdmPCP
        ,drvVDHMOTerminationDate = VDHMO.BdmBenStopDate
        --Voluntary Life (VLIF) policy
        ,drvVLIFPolicyNumber = VLIF.BdmPolicyNumber
        ,drvVLIFBillLocationACNumber = VLIF.BdmBillLocationACNumber
        ,drvVLIFSortGroup = VLIF.BdmSortGroup
        ,drvVLIFEffDate = VLIF.BdmBenStartDate
        ,drvVLIFPlanCode = VLIF.BdmPlanCode
        ,drvVLIFClassCode = VLIF.BdmClassCode
        ,drvVLICvgs = VLIF.BdmCvgs
        ,drvVLITerminationDate = VLIF.BdmBenStopDate
        ,drvVADCvgs = VLIFVAD.BdmCvgs
        ,drvVADTerminationDate = VLIFVAD.BdmBenStopDate
        ,drvVSLICvgs = VLIFVSLI.BdmCvgs
        ,drvVSLITerminationDate = VLIFVSLI.BdmBenStopDate
        ,drvVSADCvgs = VLIFVSAD.BdmCvgs
        ,drvVSADTerminationDate = VLIFVSAD.BdmBenStopDate
        ,drvVCLICvgs = VLIFVCLI.BdmCvgs
        ,drvVCLITerminationDate = VLIFVCLI.BdmBenStopDate
        --Voluntary Weekly Income/Short-Term Disability (VWI) policy
        ,drvVWIPolicyNumber = VWI.BdmPolicyNumber
        ,drvVWIBillLocationACNumber = VWI.BdmBillLocationACNumber
        ,drvVWISortGroup = VWI.BdmSortGroup
        ,drvVWIEffDate = VWI.BdmBenStartDate
        ,drvVWIPlanCode = VWI.BdmPlanCode
        ,drvVWIClassCode = VWI.BdmClassCode
        ,drvVWIBenefitAmt = VWI.BcaBenAmtCalc
        ,drvVWIElimPeriod = VWI.BdmElimPeriod
        ,drvVWIBenefitDuration = VWI.BdmBenefitDuration
        ,drvVWITerminationDate = VWI.BdmBenStopDate
        --Voluntary Long-Term Disability (VLTD) policy
        ,drvVLTDPolicyNumber = VLTD.BdmPolicyNumber
        ,drvVLTDBillLocationACNumber = VLTD.BdmBillLocationACNumber
        ,drvVLTDSortGroup = VLTD.BdmSortGroup
        ,drvVLTDEffDate = VLTD.BdmBenStartDate
        ,drvVLTDPlanCode = VLTD.BdmPlanCode
        ,drvVLTDClassCode = VLTD.BdmClassCode
        ,drvVLTDBenefitAmt = VLTD.BcaBenAmtCalc
        ,drvVLTDElimPeriod = VLTD.BdmElimPeriod
        ,drvVLTDBenefitDuration = VLTD.BdmBenefitDuration
        ,drvVLTDBenefitPct = VLTD.BdmBenefitPct
        ,drvVLTDTerminationDate = VLTD.BdmBenStopDate
        --Stand-alone AD&D (STAD) policy
        ,drvSTADPolicyNumber = STAD.BdmPolicyNumber
        ,drvSTADBillLocationACNumber = STAD.BdmBillLocationACNumber
        ,drvSTADSortGroup = STAD.BdmSortGroup
        ,drvSTADEffDate = STAD.BdmBenStartDate
        ,drvSTADPlanCode = STAD.BdmPlanCode
        ,drvSTADClassCode = STAD.BdmClassCode
        ,drvSTVADCvgs = STAD.BdmCvgs
        ,drvSTVADTerminationDate = STAD.BdmBenStopDate
        ,drvSTVSADCvgs = STADSTVSAD.BdmCvgs
        ,drvSTVSADTerminationDate = STADSTVSAD.BdmBenStopDate
        ,drvSTVCADCvgs = STADSTVCAD.BdmCvgs
        ,drvSTVCADTerminationDate = STADSTVCAD.BdmBenStopDate
        --Qualifying Event Code
        ,drvReasonCode = ''
        ,drvReasonEffDate = ''
        ,drvASOIndicatorYN = ''
        ,drvMbrSmoker = EepIsSmoker
        ,drvSpouseSmoker = CASE WHEN DEP1.ConIsSpouse = 'Y' THEN DEP1.ConIsSmoker END
        ,drvSpouseDOB = CASE WHEN DEP1.ConIsSpouse = 'Y' THEN DEP1.ConDateOfBirth END
        -- Dependent # 1
        ,drvDepFirstName = DEP1.ConNameFirst
        ,drvDepLastName = DEP1.ConNameLast
        ,drvDepMI = DEP1.ConNameMiddle
        ,drvDepGender = DEP1.ConGender
        ,drvDepDOB = DEP1.ConDateOfBirth
        ,drvDepRelationshipCode = DEP1.ConRelationship
        ,drvDepStudentCode = DEP1.ConIsStudent
        ,drvDepDisabledYN = DEP1.ConIsDisabled
        ,drvDepCvgIndicator = DEP1.ConCoverage
        ,drvDepDHMOPCP = DEP1.ConDHMOPCP
        -- Dependent # 2
        ,drvDep2FirstName = DEP2.ConNameFirst
        ,drvDep2LastName = DEP2.ConNameLast
        ,drvDep2MI = DEP2.ConNameMiddle
        ,drvDep2Gender = DEP2.ConGender
        ,drvDep2DOB = DEP2.ConDateOfBirth
        ,drvDep2RelationshipCode = DEP2.ConRelationship
        ,drvDep2StudentCode = DEP2.ConIsStudent
        ,drvDep2DisabledYN = DEP2.ConIsDisabled
        ,drvDep2CvgIndicator = DEP2.ConCoverage
        ,drvDep2DHMOPCP = DEP2.ConDHMOPCP
        -- Dependent # 3
        ,drvDep3FirstName = DEP3.ConNameFirst
        ,drvDep3LastName = DEP3.ConNameLast
        ,drvDep3MI = DEP3.ConNameMiddle
        ,drvDep3Gender = DEP3.ConGender
        ,drvDep3DOB = DEP3.ConDateOfBirth
        ,drvDep3RelationshipCode = DEP3.ConRelationship
        ,drvDep3StudentCode = DEP3.ConIsStudent
        ,drvDep3DisabledYN = DEP3.ConIsDisabled
        ,drvDep3CvgIndicator = DEP3.ConCoverage
        ,drvDep3DHMOPCP = DEP3.ConDHMOPCP
        -- Dependent # 4
        ,drvDep4FirstName = DEP4.ConNameFirst
        ,drvDep4LastName = DEP4.ConNameLast
        ,drvDep4MI = DEP4.ConNameMiddle
        ,drvDep4Gender = DEP4.ConGender
        ,drvDep4DOB = DEP4.ConDateOfBirth
        ,drvDep4RelationshipCode = DEP4.ConRelationship
        ,drvDep4StudentCode = DEP4.ConIsStudent
        ,drvDep4DisabledYN = DEP4.ConIsDisabled
        ,drvDep4CvgIndicator = DEP4.ConCoverage
        ,drvDep4DHMOPCP = DEP4.ConDHMOPCP
        -- Dependent # 5
        ,drvDep5FirstName = DEP5.ConNameFirst
        ,drvDep5LastName = DEP5.ConNameLast
        ,drvDep5MI = DEP5.ConNameMiddle
        ,drvDep5Gender = DEP5.ConGender
        ,drvDep5DOB = DEP5.ConDateOfBirth
        ,drvDep5RelationshipCode = DEP5.ConRelationship
        ,drvDep5DisabledYN = DEP5.ConIsDisabled
        ,drvDep5StudentCode = DEP5.ConIsStudent
        ,drvDep5CvgIndicator = DEP5.ConCoverage
        ,drvDep5DHMOPCP = DEP5.ConDHMOPCP
        -- Dependent # 6
        ,drvDep6FirstName = DEP6.ConNameFirst
        ,drvDep6LastName = DEP6.ConNameLast
        ,drvDep6MI = DEP6.ConNameMiddle
        ,drvDep6Gender = DEP6.ConGender
        ,drvDep6DOB = DEP6.ConDateOfBirth
        ,drvDep6RelationshipCode = DEP6.ConRelationship
        ,drvDep6DisabledYN = DEP6.ConIsDisabled
        ,drvDep6StudentCode = DEP6.ConIsStudent
        ,drvDep6CvgIndicator = DEP6.ConCoverage
        ,drvDep6DHMOPCP = DEP6.ConDHMOPCP
        -- Dependent # 7
        ,drvDep7FirstName = DEP7.ConNameFirst
        ,drvDep7LastName = DEP7.ConNameLast
        ,drvDep7MI = DEP7.ConNameMiddle
        ,drvDep7Gender = DEP7.ConGender
        ,drvDep7DOB = DEP7.ConDateOfBirth
        ,drvDep7RelationshipCode = DEP7.ConRelationship
        ,drvDep7DisabledYN = DEP7.ConIsDisabled
        ,drvDep7StudentCode = DEP7.ConIsStudent
        ,drvDep7CvgIndicator = DEP7.ConCoverage
        ,drvDep7DHMOPCP = DEP7.ConDHMOPCP
        -- Dependent # 8
        ,drvDep8FirstName = DEP8.ConNameFirst
        ,drvDep8LastName = DEP8.ConNameLast
        ,drvDep8MI = DEP8.ConNameMiddle
        ,drvDep8Gender = DEP8.ConGender
        ,drvDep8DOB = DEP8.ConDateOfBirth
        ,drvDep8RelationshipCode = DEP8.ConRelationship
        ,drvDep8DisabledYN = DEP8.ConIsDisabled
        ,drvDep8StudentCode = DEP8.ConIsStudent
        ,drvDep8CvgIndicator = DEP8.ConCoverage
        ,drvDep8DHMOPCP = DEP8.ConDHMOPCP
        -- Dependent # 9
        ,drvDep9FirstName = DEP9.ConNameFirst
        ,drvDep9LastName = DEP9.ConNameLast
        ,drvDep9MI = DEP9.ConNameMiddle
        ,drvDep9Gender = DEP9.ConGender
        ,drvDep9DOB = DEP9.ConDateOfBirth
        ,drvDep9RelationshipCode = DEP9.ConRelationship
        ,drvDep9StudentCode = DEP9.ConIsStudent
        ,drvDep9DisabledYN = DEP9.ConIsDisabled
        ,drvDep9CvgIndicator = DEP9.ConCoverage
        ,drvDep9DHMOPCP = DEP9.ConDHMOPCP
        -- Dependent # 10
        ,drvDep10FirstName = DEP10.ConNameFirst
        ,drvDep10LastName = DEP10.ConNameLast
        ,drvDep10MI = DEP10.ConNameMiddle
        ,drvDep10Gender = DEP10.ConGender
        ,drvDep10DOB = DEP10.ConDateOfBirth
        ,drvDep10RelationshipCode = DEP10.ConRelationship
        ,drvDep10StudentCode = DEP10.ConIsStudent
        ,drvDep10DisabledYN = DEP10.ConIsDisabled
        ,drvDep10CvgIndicator = DEP10.ConCoverage
        ,drvDep10DHMOPCP = DEP10.ConDHMOPCP
        -- Dependent # 11
        ,drvDep11FirstName = DEP11.ConNameFirst
        ,drvDep11LastName = DEP11.ConNameLast
        ,drvDep11MI = DEP11.ConNameMiddle
        ,drvDep11Gender = DEP11.ConGender
        ,drvDep11DOB = DEP11.ConDateOfBirth
        ,drvDep11RelationshipCode = DEP11.ConRelationship
        ,drvDep11StudentCode = DEP11.ConIsStudent
        ,drvDep11DisabledYN = DEP11.ConIsDisabled
        ,drvDep11CvgIndicator = DEP11.ConCoverage
        ,drvDep11DHMOPCP = DEP11.ConDHMOPCP
        -- Dependent # 12
        ,drvDep12FirstName = DEP12.ConNameFirst
        ,drvDep12LastName = DEP12.ConNameLast
        ,drvDep12MI = DEP12.ConNameMiddle
        ,drvDep12Gender = DEP12.ConGender
        ,drvDep12DOB = DEP12.ConDateOfBirth
        ,drvDep12RelationshipCode = DEP12.ConRelationship
        ,drvDep12StudentCode = DEP12.ConIsStudent
        ,drvDep12DisabledYN = DEP12.ConIsDisabled
        ,drvDep12CvgIndicator = DEP12.ConCoverage
        ,drvDep12DHMOPCP = DEP12.ConDHMOPCP
        -- Dependent # 13
        ,drvDep13FirstName = DEP13.ConNameFirst
        ,drvDep13LastName = DEP13.ConNameLast
        ,drvDep13MI = DEP13.ConNameMiddle
        ,drvDep13Gender = DEP13.ConGender
        ,drvDep13DOB = DEP13.ConDateOfBirth
        ,drvDep13RelationshipCode = DEP13.ConRelationship
        ,drvDep13StudentCode = DEP13.ConIsStudent
        ,drvDep13DisabledYN = DEP13.ConIsDisabled
        ,drvDep13CvgIndicator = DEP13.ConCoverage
        ,drvDep13DHMOPCP = DEP13.ConDHMOPCP
        -- Dependent # 14
        ,drvDep14FirstName = DEP14.ConNameFirst
        ,drvDep14LastName = DEP14.ConNameLast
        ,drvDep14MI = DEP14.ConNameMiddle
        ,drvDep14Gender = DEP14.ConGender
        ,drvDep14DOB = DEP14.ConDateOfBirth
        ,drvDep14RelationshipCode = DEP14.ConRelationship
        ,drvDep14StudentCode = DEP14.ConIsStudent
        ,drvDep14DisabledYN = DEP14.ConIsDisabled
        ,drvDep14CvgIndicator = DEP14.ConCoverage
        ,drvDep14DHMOPCP = DEP14.ConDHMOPCP
        -- Dependent # 15
        ,drvDep15FirstName = DEP15.ConNameFirst
        ,drvDep15LastName = DEP15.ConNameLast
        ,drvDep15MI = DEP15.ConNameMiddle
        ,drvDep15Gender = DEP15.ConGender
        ,drvDep15DOB = DEP15.ConDateOfBirth
        ,drvDep15RelationshipCode = DEP15.ConRelationship
        ,drvDep15StudentCode = DEP15.ConIsStudent
        ,drvDep15DisabledYN = DEP15.ConIsDisabled
        ,drvDep15CvgIndicator = DEP15.ConCoverage
        ,drvDep15DHMOPCP = DEP15.ConDHMOPCP
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN ( --Get Salary Rate Effective Date
        SELECT EjhEEID, EjhCOID, EjhJobEffDate
            ,EjhRowNo = ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC)
        FROM dbo.EmpHJob
        WHERE EjhIsRateChange = 'Y'
    ) EmpHJob
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhRowNo = 1
    --================================================
    -- Beneficiary Information (Primary/Contingent)
    --================================================
    -- Primary Beneficiary Information
    LEFT JOIN dbo.U_@CustomFormatCode_Beneficiary P WITH (NOLOCK)
        ON P.BfpEEID = xEEID
        AND P.BfpBeneficiaryType = 'P'
        AND P.BfpRowNo = 1
    -- Contingent Beneficiary Information
    LEFT JOIN dbo.U_@CustomFormatCode_Beneficiary C WITH (NOLOCK)
        ON C.BfpEEID = xEEID
        AND C.BfpBeneficiaryType = 'C'
        AND C.BfpRowNo = 1
    --================================================
    -- Benefit Plan Information
    --================================================
    --Accident policy
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits Accident WITH (NOLOCK)
        ON Accident.BdmEEID = xEEID
        AND Accident.BdmCOID = xCOID
        AND Accident.BdmPlanType = 'Accident'
    --Accident Disability (AccidentDI) Rider
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits AccidentDI WITH (NOLOCK)
        ON AccidentDI.BdmEEID = xEEID
        AND AccidentDI.BdmCOID = xCOID
        AND AccidentDI.BdmPlanType = 'AccidentDI'
    --Accident/Sickness Disability (AccidentSickDI) Rider
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits AccidentSickDI WITH (NOLOCK)
        ON AccidentSickDI.BdmEEID = xEEID
        AND AccidentSickDI.BdmCOID = xCOID
        AND AccidentSickDI.BdmPlanType = 'AccidentSickDI'
    --Health Assessment Rider
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits HealthAssessment WITH (NOLOCK)
        ON HealthAssessment.BdmEEID = xEEID
        AND HealthAssessment.BdmCOID = xCOID
        AND HealthAssessment.BdmPlanType = 'HealthAssessment'
    --Sickness Hospital Rider
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits Hospital WITH (NOLOCK)
        ON Hospital.BdmEEID = xEEID
        AND Hospital.BdmCOID = xCOID
        AND Hospital.BdmPlanType = 'Hospital'
    --Critical Illness (CI) policy
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits CI WITH (NOLOCK)
        ON CI.BdmEEID = xEEID
        AND CI.BdmCOID = xCOID
        AND CI.BdmPlanType = 'CI'
    --Critical Illness Heart Category
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits CIHeart WITH (NOLOCK)
        ON CIHeart.BdmEEID = xEEID
        AND CIHeart.BdmCOID = xCOID
        AND CIHeart.BdmPlanType = 'CIHeart'
    --Critical Illness Cancer Category
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits CICancer WITH (NOLOCK)
        ON CICancer.BdmEEID = xEEID
        AND CICancer.BdmCOID = xCOID
        AND CICancer.BdmPlanType = 'CICancer'
    --Critical Illness Organ Category
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits CIOrgan WITH (NOLOCK)
        ON CIOrgan.BdmEEID = xEEID
        AND CIOrgan.BdmCOID = xCOID
        AND CIOrgan.BdmPlanType = 'CIOrgan'
    --Critical Illness Quality of Life Category
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits CIQualityOfLife WITH (NOLOCK)
        ON CIQualityOfLife.BdmEEID = xEEID
        AND CIQualityOfLife.BdmCOID = xCOID
        AND CIQualityOfLife.BdmPlanType = 'CIQualityOfLife'
    --Critical Illness Treatment Care Rider
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits CITreatmentCare WITH (NOLOCK)
        ON CITreatmentCare.BdmEEID = xEEID
        AND CITreatmentCare.BdmCOID = xCOID
        AND CITreatmentCare.BdmPlanType = 'CITreatmentCare'
    --Critical Illness Disability Income (DI) Rider
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits CIDI WITH (NOLOCK)
        ON CIDI.BdmEEID = xEEID
        AND CIDI.BdmCOID = xCOID
        AND CIDI.BdmPlanType = 'CIDI'
    --Critical Illness Accident Rider
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits CIAccident WITH (NOLOCK)
        ON CIAccident.BdmEEID = xEEID
        AND CIAccident.BdmCOID = xCOID
        AND CIAccident.BdmPlanType = 'CIAccident'
    --Life and AD&D (Life) policy - LI = Member Life
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits Life WITH (NOLOCK)
        ON Life.BdmEEID = xEEID
        AND Life.BdmCOID = xCOID
        AND Life.BdmPlanType = 'Life'
        AND Life.BdmCvgs LIKE 'LI%'
    --Life and AD&D (Life) policy - AD = Member AD&D
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeAD WITH (NOLOCK)
        ON LifeAD.BdmEEID = xEEID
        AND LifeAD.BdmCOID = xCOID
        AND LifeAD.BdmPlanType = 'Life'
        AND LifeAD.BdmCvgs LIKE 'AD%'
    --Life and AD&D (Life) policy - DLI = Dependent Life
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeDLI WITH (NOLOCK)
        ON LifeDLI.BdmEEID = xEEID
        AND LifeDLI.BdmCOID = xCOID
        AND LifeDLI.BdmPlanType = 'Life'
        AND LifeDLI.BdmCvgs LIKE 'DLI%'
    --Life and AD&D (Life) policy - DAD = Dependent AD&D
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeDAD WITH (NOLOCK)
        ON LifeDAD.BdmEEID = xEEID
        AND LifeDAD.BdmCOID = xCOID
        AND LifeDAD.BdmPlanType = 'Life'
        AND LifeDAD.BdmCvgs LIKE 'DAD%'
    --Life and AD&D (Life) policy - OLI = Optional Member Life
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeOLI WITH (NOLOCK)
        ON LifeOLI.BdmEEID = xEEID
        AND LifeOLI.BdmCOID = xCOID
        AND LifeOLI.BdmPlanType = 'Life'
        AND LifeOLI.BdmCvgs LIKE 'OLI%'
    --Life and AD&D (Life) policy - OAD = Optional Member AD&D
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeOAD WITH (NOLOCK)
        ON LifeOAD.BdmEEID = xEEID
        AND LifeOAD.BdmCOID = xCOID
        AND LifeOAD.BdmPlanType = 'Life'
        AND LifeOAD.BdmCvgs LIKE 'OAD%'
    --Life and AD&D (Life) policy - ODLI = Optional Dependent Life
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeODLI WITH (NOLOCK)
        ON LifeODLI.BdmEEID = xEEID
        AND LifeODLI.BdmCOID = xCOID
        AND LifeODLI.BdmPlanType = 'Life'
        AND LifeODLI.BdmCvgs LIKE 'ODLI%'
    --Life and AD&D (Life) policy - ODAD = Optional Dependent AD&D
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeODAD WITH (NOLOCK)
        ON LifeODAD.BdmEEID = xEEID
        AND LifeODAD.BdmCOID = xCOID
        AND LifeODAD.BdmPlanType = 'Life'
        AND LifeODAD.BdmCvgs LIKE 'ODAD%'
    --Life and AD&D (Life) policy - SLI = Spouse Life
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeSLI WITH (NOLOCK)
        ON LifeSLI.BdmEEID = xEEID
        AND LifeSLI.BdmCOID = xCOID
        AND LifeSLI.BdmPlanType = 'Life'
        AND LifeSLI.BdmCvgs LIKE 'SLI%'
    --Life and AD&D (Life) policy - SAD = Spouse AD&D
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeSAD WITH (NOLOCK)
        ON LifeSAD.BdmEEID = xEEID
        AND LifeSAD.BdmCOID = xCOID
        AND LifeSAD.BdmPlanType = 'Life'
        AND LifeSAD.BdmCvgs LIKE 'SAD%'
    --Life and AD&D (Life) policy - CLI = Child Life
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeCLI WITH (NOLOCK)
        ON LifeCLI.BdmEEID = xEEID
        AND LifeCLI.BdmCOID = xCOID
        AND LifeCLI.BdmPlanType = 'Life'
        AND LifeCLI.BdmCvgs LIKE 'CLI%'
    --Life and AD&D (Life) policy - OSLI = Optional Spouse Life
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeOSLI WITH (NOLOCK)
        ON LifeOSLI.BdmEEID = xEEID
        AND LifeOSLI.BdmCOID = xCOID
        AND LifeOSLI.BdmPlanType = 'Life'
        AND LifeOSLI.BdmCvgs LIKE 'OSLI%'
    --Life and AD&D (Life) policy - OSAD = Optional Spouse AD&D
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeOSAD WITH (NOLOCK)
        ON LifeOSAD.BdmEEID = xEEID
        AND LifeOSAD.BdmCOID = xCOID
        AND LifeOSAD.BdmPlanType = 'Life'
        AND LifeOSAD.BdmCvgs LIKE 'OSAD%'
    --Life and AD&D (Life) policy - OCLI = Optional Child Life
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LifeOCLI WITH (NOLOCK)
        ON LifeOCLI.BdmEEID = xEEID
        AND LifeOCLI.BdmCOID = xCOID
        AND LifeOCLI.BdmPlanType = 'Life'
        AND LifeOCLI.BdmCvgs LIKE 'OCLI%'
    --Weekly Income (STD) policy
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits WI WITH (NOLOCK)
        ON WI.BdmEEID = xEEID
        AND WI.BdmCOID = xCOID
        AND WI.BdmPlanType = 'WI'
        AND WI.BdmCvgs LIKE 'WI%'
    --Weekly Income (STD) policy - OWI = Optional Weekly Income/Short Term Disability
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits WIOWI WITH (NOLOCK)
        ON WIOWI.BdmEEID = xEEID
        AND WIOWI.BdmCOID = xCOID
        AND WIOWI.BdmPlanType = 'WI'
        AND WIOWI.BdmCvgs LIKE 'OWI%'
    --Long-Term Disability (LTD) policy - LTD = Long Term Disability
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LTD WITH (NOLOCK)
        ON LTD.BdmEEID = xEEID
        AND LTD.BdmCOID = xCOID
        AND LTD.BdmPlanType = 'LTD'
        AND LTD.BdmCvgs LIKE 'LTD%'
    --Long-Term Disability (LTD) policy - OLTD = Optional Long Term Disability
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LTDOLTD WITH (NOLOCK)
        ON LTDOLTD.BdmEEID = xEEID
        AND LTDOLTD.BdmCOID = xCOID
        AND LTDOLTD.BdmPlanType = 'LTD'
        AND LTDOLTD.BdmCvgs LIKE 'OLTD%'
    --Long-Term Disability (LTD) policy - CI = Critical Illness
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LTDCI WITH (NOLOCK)
        ON LTDCI.BdmEEID = xEEID
        AND LTDCI.BdmCOID = xCOID
        AND LTDCI.BdmPlanType = 'LTD'
        AND LTDCI.BdmCvgs LIKE 'CI%'
    --Dental (Dent) policy
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits Dent WITH (NOLOCK)
        ON Dent.BdmEEID = xEEID
        AND Dent.BdmCOID = xCOID
        AND Dent.BdmPlanType = 'Dent'
    --(Dental) DHMO policy
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits DHMO WITH (NOLOCK)
        ON DHMO.BdmEEID = xEEID
        AND DHMO.BdmCOID = xCOID
        AND DHMO.BdmPlanType = 'DHMO'
    --Lincoln Vision Connect (LVC) policy
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits LVC WITH (NOLOCK)
        ON LVC.BdmEEID = xEEID
        AND LVC.BdmCOID = xCOID
        AND LVC.BdmPlanType = 'LVC'
    --Voluntary Lincoln Vision Connect (VLVC) policy
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits VLVC WITH (NOLOCK)
        ON VLVC.BdmEEID = xEEID
        AND VLVC.BdmCOID = xCOID
        AND VLVC.BdmPlanType = 'VLVC'
    --Voluntary Dental (VDN) policy
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits VDN WITH (NOLOCK)
        ON VDN.BdmEEID = xEEID
        AND VDN.BdmCOID = xCOID
        AND VDN.BdmPlanType = 'VDN'
    --Voluntary Dental DHMO (VDHMO) 
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits VDHMO WITH (NOLOCK)
        ON VDHMO.BdmEEID = xEEID
        AND VDHMO.BdmCOID = xCOID
        AND VDHMO.BdmPlanType = 'VDHMO'
    --Voluntary Life (VLIF) policy - VLI = Voluntary Member Life
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits VLIF WITH (NOLOCK)
        ON VLIF.BdmEEID = xEEID
        AND VLIF.BdmCOID = xCOID
        AND VLIF.BdmPlanType = 'VLIF'
        AND VLIF.BdmCvgs LIKE 'VLI%'
    --Voluntary Life (VLIF) policy - VAD = Voluntary Member AD&D
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits VLIFVAD WITH (NOLOCK)
        ON VLIFVAD.BdmEEID = xEEID
        AND VLIFVAD.BdmCOID = xCOID
        AND VLIFVAD.BdmPlanType = 'VLIF'
        AND VLIFVAD.BdmCvgs LIKE 'VAD%'
    --Voluntary Life (VLIF) policy - VSLI = Voluntary Spouse Life
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits VLIFVSLI WITH (NOLOCK)
        ON VLIFVSLI.BdmEEID = xEEID
        AND VLIFVSLI.BdmCOID = xCOID
        AND VLIFVSLI.BdmPlanType = 'VLIF'
        AND VLIFVSLI.BdmCvgs LIKE 'VSLI%'
    --Voluntary Life (VLIF) policy - VSAD = Voluntary Spouse AD&D
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits VLIFVSAD WITH (NOLOCK)
        ON VLIFVSAD.BdmEEID = xEEID
        AND VLIFVSAD.BdmCOID = xCOID
        AND VLIFVSAD.BdmPlanType = 'VLIF'
        AND VLIFVSAD.BdmCvgs LIKE 'VSAD%'
    --Voluntary Life (VLIF) policy - VCLI = Voluntary Child Life
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits VLIFVCLI WITH (NOLOCK)
        ON VLIFVCLI.BdmEEID = xEEID
        AND VLIFVCLI.BdmCOID = xCOID
        AND VLIFVCLI.BdmPlanType = 'VLIF'
        AND VLIFVCLI.BdmCvgs LIKE 'VCLI%'
    --Voluntary Weekly Income/Short-Term Disability (VWI) policy
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits VWI WITH (NOLOCK)
        ON VWI.BdmEEID = xEEID
        AND VWI.BdmCOID = xCOID
        AND VWI.BdmPlanType = 'VWI'
    --Voluntary Long-Term Disability (VLTD) policy
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits VLTD WITH (NOLOCK)
        ON VLTD.BdmEEID = xEEID
        AND VLTD.BdmCOID = xCOID
        AND VLTD.BdmPlanType = 'VLTD'
    --Stand-alone AD&D (STAD) policy - STVAD = Stand Alone Voluntary Member AD&D
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits STAD WITH (NOLOCK)
        ON STAD.BdmEEID = xEEID
        AND STAD.BdmCOID = xCOID
        AND STAD.BdmPlanType = 'STAD'
        AND STAD.BdmCvgs LIKE 'STVAD%'
    --Stand-alone AD&D (STAD) policy - STVSAD = Stand Alone Voluntary Spouse AD&D
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits STADSTVSAD WITH (NOLOCK)
        ON STADSTVSAD.BdmEEID = xEEID
        AND STADSTVSAD.BdmCOID = xCOID
        AND STADSTVSAD.BdmPlanType = 'STAD'
        AND STADSTVSAD.BdmCvgs LIKE 'STVSAD%'
    --Stand-alone AD&D (STAD) policy - STVCAD = Stand Alone Voluntary Child AD&D
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits STADSTVCAD WITH (NOLOCK)
        ON STADSTVCAD.BdmEEID = xEEID
        AND STADSTVCAD.BdmCOID = xCOID
        AND STADSTVCAD.BdmPlanType = 'STAD'
        AND STADSTVCAD.BdmCvgs LIKE 'STVCAD%'
    --================================================
    -- Dependent# 1 - 15 Information
    --================================================
    -- Dependent# 1
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP1 WITH (NOLOCK)
        ON DEP1.ConEEID = xEEID
        AND DEP1.ConRowNo = 1
    -- Dependent# 2
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP2 WITH (NOLOCK)
        ON DEP2.ConEEID = xEEID
        AND DEP2.ConRowNo = 2
    -- Dependent# 3
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP3 WITH (NOLOCK)
        ON DEP3.ConEEID = xEEID
        AND DEP3.ConRowNo = 3
    -- Dependent# 4
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP4 WITH (NOLOCK)
        ON DEP4.ConEEID = xEEID
        AND DEP4.ConRowNo = 4
    -- Dependent# 5
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP5 WITH (NOLOCK)
        ON DEP5.ConEEID = xEEID
        AND DEP5.ConRowNo = 5
    -- Dependent# 6
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP6 WITH (NOLOCK)
        ON DEP6.ConEEID = xEEID
        AND DEP6.ConRowNo = 6
    -- Dependent# 7
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP7 WITH (NOLOCK)
        ON DEP7.ConEEID = xEEID
        AND DEP7.ConRowNo = 7
    -- Dependent# 8
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP8 WITH (NOLOCK)
        ON DEP8.ConEEID = xEEID
        AND DEP8.ConRowNo = 8
    -- Dependent# 9
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP9 WITH (NOLOCK)
        ON DEP9.ConEEID = xEEID
        AND DEP9.ConRowNo = 9
    -- Dependent# 10
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP10 WITH (NOLOCK)
        ON DEP10.ConEEID = xEEID
        AND DEP10.ConRowNo = 10
    -- Dependent# 11
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP11 WITH (NOLOCK)
        ON DEP11.ConEEID = xEEID
        AND DEP11.ConRowNo = 11
    -- Dependent# 12
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP12 WITH (NOLOCK)
        ON DEP12.ConEEID = xEEID
        AND DEP12.ConRowNo = 12
    -- Dependent# 13
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP13 WITH (NOLOCK)
        ON DEP13.ConEEID = xEEID
        AND DEP13.ConRowNo = 13
    -- Dependent# 14
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP14 WITH (NOLOCK)
        ON DEP14.ConEEID = xEEID
        AND DEP14.ConRowNo = 14
    -- Dependent# 15
    LEFT JOIN dbo.U_@CustomFormatCode_Contacts DEP15 WITH (NOLOCK)
        ON DEP15.ConEEID = xEEID
        AND DEP15.ConRowNo = 15
    WHERE EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Benefits WHERE BdmEEID = xEEID AND BdmCOID = xCOID);;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = '@FileNamePrefix.csv'
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201707041'
       ,expStartPerControl     = '201707041'
       ,expLastEndPerControl   = '201707119'
       ,expEndPerControl       = '201707119'
WHERE expFormatCode = '@CustomFormatCode';

-- Check Deduction/Benefit Plan Calc Rules
SELECT [Deduction Code] = DedDedCode
    ,[Benefit Plan Name] = DedLongDesc
    ,[Deduction Type] = DedDedType
    ,[Deduction EE Calc Rule] = DedEECalcRule
    ,[Deduction EE Calc Rule Description] = EECalcRule.codDesc
FROM dbo.DedCode WITH (NOLOCK)
LEFT JOIN dbo.Codes EECalcRule WITH (NOLOCK) ON EECalcRule.CodCode = DedEECalcRule AND EECalcRule.CodTable = 'DEDEECALCRULE'
WHERE DedDedType IN ('OPT','OPC','OPS','ADD','LTD','STD','DEN','VIS')
ORDER BY DedDedCode

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
GO
IF OBJECT_ID('dsi_fnGetMinMaxDates') IS NOT NULL
    DROP FUNCTION dbo.dsi_fnGetMinMaxDates
GO

CREATE FUNCTION [dbo].[dsi_fnGetMinMaxDates] 
(
@Type  VARCHAR(3), 
@Date1 DATETIME,
@Date2 DATETIME
)
RETURNS DATETIME
WITH EXECUTE AS CALLER
AS
 
/************************************************************
 
Created By: Erin Hidalgo & John Transier
Create Date: 08-25-08
 
Purpose: Returns the minimum or maximum of two input dates
 
Command: PRINT dbo.dsi_fnGetMinMaxDates('MIN', GETDATE(), GETDATE() +1 )
 
NOTE TO SUPPORT: this function is one of a standard set of USI functions. Please do not make any changes
to this function without going through the USI team. Any changes made to this function will be wiped out
if/when the standard USI code is reinstalled on this database.
 
Revision History
----------------
Update By         Date          CP Num         Descr
xxxxxxxxxxxxxxxx  xx/xx/xxxxx   CS-xxxx-xxxxx  xxxxxxxx
 
************************************************************/
 
BEGIN
 
IF @Date1 IS NULL AND @Date2 IS NULL RETURN NULL
IF @Date1 IS NULL                    RETURN @Date2
IF @Date2 IS NULL                    RETURN @Date1
IF @Date1 = @Date2                   RETURN @Date1  
 
RETURN CASE 
          WHEN @Type = 'MIN' AND @Date1 < @Date2 THEN @Date1 
          WHEN @Type = 'MIN' AND @Date1 > @Date2 THEN @Date2 
          WHEN @Type = 'MAX' AND @Date1 > @Date2 THEN @Date1 
          WHEN @Type = 'MAX' AND @Date1 < @Date2 THEN @Date2 
       END
 
RETURN NULL
 
END
GO
--1.09
IF DB_NAME() <> 'ULTIPRO_BDM' AND OBJECT_ID('U_dsi_bdm_BenCalculationAmounts') IS NOT NULL DROP TABLE dbo.U_dsi_bdm_BenCalculationAmounts;
IF DB_NAME() <> 'ULTIPRO_BDM' AND OBJECT_ID('U_dsi_BDM_BCAConfiguration') IS NOT NULL DROP TABLE dbo.U_dsi_BDM_BCAConfiguration;
IF DB_NAME() <> 'ULTIPRO_BDM' AND OBJECT_ID('U_dsi_bdm_bcaInsRate') IS NOT NULL DROP TABLE dbo.U_dsi_bdm_bcaInsRate;
IF DB_NAME() <> 'ULTIPRO_BDM' AND OBJECT_ID('U_dsi_bdm_bcaOptRate') IS NOT NULL DROP TABLE dbo.U_dsi_bdm_bcaOptRate;
IF DB_NAME() <> 'ULTIPRO_BDM' AND OBJECT_ID('dsi_bdm_sp_CalculateBenefitAmounts') IS NOT NULL DROP PROCEDURE dbo.dsi_bdm_sp_CalculateBenefitAmounts;

CREATE TABLE [dbo].[U_dsi_bdm_bcaInsRate] (
    [BcaInsFormatCode] [varchar](10) NOT NULL
    ,[BcaInsDedcode] [varchar](10) NOT NULL
    ,[BcaInsMinAge] [decimal](16, 6) NULL
    ,[BcaInsMaxAge] [decimal](16, 6) NULL
    ,[BcaInsEERateNSFemale] [money] NULL
    ,[BcaInsEERateSMFemale] [money] NULL
    ,[BcaInsEERateNSMale] [money] NULL
    ,[BcaInsEERateSMMale] [money] NULL
    ,[BcaInsERRateNSFemale] [money] NULL
    ,[BcaInsERRateSMFemale] [money] NULL
    ,[BcaInsERRateNSMale] [money] NULL
    ,[BcaInsERRateSMMale] [money] NULL
    ,[BcaInsEffDate] [datetime] NULL
    ,[BcaInsPayFreq] [char](1) NULL
    ,[BcaInsRowNum] BIGINT
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[U_dsi_bdm_bcaOptRate] (
    [BcaORFormatCode] [varchar](10) NOT NULL
    ,[BcaORDedcode] [varchar](10) NOT NULL
    ,[BcaORBenOption] [char](6) NOT NULL
    ,[BcaOREERate] [money] NULL
    ,[BcaORERRate] [money] NULL
    ,[BcaORPayFreq] [char](1) NULL
    ,[BcaORRowNum] BIGINT
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[U_dsi_bdm_BenCalculationAmounts] (
    [BcaFormatCode] [varchar](10) NOT NULL
    ,[BcaCoID] [char](5) NOT NULL
    ,[BcaEEID] [char](12) NOT NULL
    ,[BcaDepRecID] [char](12) NULL
    ,[BcaRunID] [varchar](32) NULL
    ,[BcaDedCode] [char](5) NOT NULL
    ,[BcaBenAmt] [money] NULL
    ,[BcaBenAmtCalc] [money] NULL
    ,[BcaBenAmtCalcRule] [char](2) NULL
    ,[BcaBenAmtRateOrPct] [decimal](16, 6) NULL
    ,[BcaEEBenAmt] [money] NULL
    ,[BcaBenAmtPer] [char](2) NULL
    ,[BcaBenAmtMax] [money] NULL
    ,[BcaCalcRowStatus] [char](256) NULL
    ,[BcaBenAmtRoundingRule] [char](2) NULL
    ,[BcaUseCurrentAge] [char](1) NULL
    ,[BcaAgeAsOfDate] [datetime] NULL
    ,[BcaUseBenReducSched] [char](1) NULL
    ,[BcaBenReducUseCurrentAge] [char](1) NULL
    ,[BcaBenReducAgeAsOfDate] [datetime] NULL
    ,[BcaDedEECalcRateOrPct] [decimal](16, 6) NULL
    ,[BcaDedEECalcRule] [char](2) NULL
    ,[BcaDedERCalcRateOrPct] [decimal](16, 6) NULL
    ,[BcaDedERCalcRule] [char](2) NULL
    ,[BcaEEAmt] [money] NULL
    ,[BcaERAmt] [money] NULL
    ,[BcaBenOption] [char](6) NULL
) ON [PRIMARY];
GO
CREATE TABLE [dbo].[U_dsi_BDM_BCAConfiguration](
    [FormatCode] [varchar](10) NOT NULL,
    [ParmName] [varchar](255) NOT NULL,
    [ParmValue1] [varchar](max) NULL,
    [ParmValue2] [varchar](max) NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX CDX_U_dsi_bdm_BenCalculationAmounts ON dbo.U_dsi_bdm_BenCalculationAmounts (BcaFormatCode,BcaEEID,BcaCoID);
CREATE NONCLUSTERED INDEX NCDX_U_dsi_bdm_BenCalculationAmounts_BcaDedCode ON dbo.U_dsi_bdm_BenCalculationAmounts (BcaDedCode);
CREATE NONCLUSTERED INDEX NCDX_U_dsi_bdm_BenCalculationAmounts_BcaDepRecID ON dbo.U_dsi_bdm_BenCalculationAmounts (BcaDepRecID);
GO

CREATE PROCEDURE [dbo].[dsi_bdm_sp_CalculateBenefitAmounts] @FormatCode VARCHAR(10)
AS
SET NOCOUNT ON;

/************************************************************

dsi_bdm_sp_CalculateBenefitAmounts

Created By: Vinny Kelly
Create Date: 07/18/2013

Purpose: Calculates benefit deduction amounts based on the parameters below.

NOTE TO SUPPORT: this stored procedure is one of a standard set of DSI procedures. Please do not make any changes
to this procedure without Going through the Data Services team. Any changes made to this procedure will be wiped out
if/when the standard DSI code is reinstalled on this database.

Revision History
----------------
Version   Update By         Date            Descr
1.01      VKelly            2013/08/07        Fixed Calculation Rule error for Expression Calculation Rule
1.02      VKelly            2014/04/30        Added Dependent Benefit Age Graded rate Option - to calculate off Dependents Date of Birth, instead of EE's Date of Birth
1.03      VKelly            2014/07/10        Added Employee Elected Rate or Pct - to calculate off of Employee Deduction code, versus Deduction Code setup table
1.04      VKelly            2014/12/22        Fixed Age Graded Rate to support Fixed plan date
1.05      VKelly            2015/10/09        Added Option to Skip Age Graded Rate portion of Calculation, but retain other parts of the rule
1.06      VKelly            2016/11/23        Added RunID to allow multiple sessions to execute from BDM, and retain the correct Benefit Amount if different between sessions.
1.07      TLeonce            2017/07/07        Add Insurance Rate Calculations (dbo.InsRate) / Add BcaEEAmt and BcaERAmt Fields to table
1.07b      VKelly            2017/07/10        Correct Insurance Rate Calculations (dbo.InsRate) for BcaEEAmt and BcaERAmt Fields to table
1.07c      VKelly            2017/10/02        Fixed Bug related to Date of Birth used for Insurance Rate calculation (Date as of, for calcuation purposes)
1.07d      VKelly            2017/10/03        Added feature to custom control Date for Insurance Rate calculation (Date as of, for calcuation purposes)
1.08      VKelly            2017/10/20        Added feature to skip Rounding Rules after calculation has been performed.
1.09      VKelly            2018/02/15        Expanded EE/ER Rate Calculation Rules to include (99, 30 & 20) - 99 = None, 30 = Benefit Amount * Rate, 20 = Flat Amount
1.09b      VKelly            2018/06/11        Fixed EE/ER Rate Calculation Rules for Flat Amount (20)
1.09c      VKelly            2018/06/13        Fixed EE/ER Rate Calculation Rules for Benefit Amount * Dependent Age Graded Rate Rule (32)
1.09d      VKelly            2018/06/15        Fixed InsRate Calculation Rules to ensure only current rate rules apply in calculation
1.09e      VKelly            2018/08/21        Fixed Age Calculation to correctly calculate EE/Dependents age, to get them in proper rate calc rule
1.09f      VKelly            2018/09/05        Removed Requirement for ValidForExport results in BDM to use BCA (to include Waived coverage in some instances)
************************************************************/
BEGIN

    --====================================================
    -- Declare variables
    --====================================================
    DECLARE @DependentBenefitAgeGradedRate VARCHAR(1);
    DECLARE @DependentAgeGradedDedCodes VARCHAR(8000);
    DECLARE @EmployeeElectedRateorPct VARCHAR(1);
    DECLARE @EmployeeElectedRateorPctDedCodes VARCHAR(8000);
    DECLARE @SkipAgeGradedRateCalcRule VARCHAR(1);
    DECLARE @SkipAgeGradedRateCalcRuleDedCodes VARCHAR(8000);
    DECLARE @SkipRoundingRuleDedCodes VARCHAR(8000);
    DECLARE @RateEffDate DATETIME;
    DECLARE @InsRateAsOfDateDedCodes VARCHAR(8000);
    DECLARE @InsRateAsOfDateDedCodes2 VARCHAR(8000);
    DECLARE @InsRateAsOfDateDedCodes3 VARCHAR(8000);
    DECLARE @InsRateAsOfDateDedCodes4 VARCHAR(8000);
    DECLARE @InsRateAsOfDateDedCodes5 VARCHAR(8000);
    DECLARE @InsRateAsOfDateValues TABLE(
        InsRateDedCode CHAR(5),
        InsRateAsOfDate DATETIME
    );

    SELECT @DependentAgeGradedDedCodes = CONVERT(VARCHAR(1024), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'DependentBenefitAgeGradedRate';
    SELECT @DependentBenefitAgeGradedRate = 'Y' WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'DependentBenefitAgeGradedRate');
    SELECT @EmployeeElectedRateorPctDedCodes = CONVERT(VARCHAR(1024), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'EmployeeElectedRateorPct';
    SELECT @EmployeeElectedRateorPct = 'Y' WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'EmployeeElectedRateorPct');
    SELECT @SkipAgeGradedRateCalcRuleDedCodes = CONVERT(VARCHAR(1024), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'SkipAgeGradedRateCalcRule';
    SELECT @SkipAgeGradedRateCalcRule = 'Y' WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'SkipAgeGradedRateCalcRule');
    SELECT @SkipRoundingRuleDedCodes = CONVERT(VARCHAR(1024), ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'SkipRoundingRule';
    SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate';
    SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate2';
    SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate3';
    SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate4';
    SELECT @InsRateAsOfDateDedCodes = CONVERT(VARCHAR(1024), ParmValue1) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate5';
    
    SET @RateEffDate = ISNULL((SELECT CONVERT(DATETIME,ParmValue) FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RateEffDate'),GETDATE());
    
    SET @DependentAgeGradedDedCodes = dbo.dsi_BDM_fn_Trim(@DependentAgeGradedDedCodes);
    SET @EmployeeElectedRateorPctDedCodes = dbo.dsi_BDM_fn_Trim(@EmployeeElectedRateorPctDedCodes);
    SET @SkipAgeGradedRateCalcRuleDedCodes = dbo.dsi_BDM_fn_Trim(@SkipAgeGradedRateCalcRuleDedCodes);
    INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate) 
        SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate')
        FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);
    INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate) 
        SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate2')
        FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);
    INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate) 
        SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate3')
        FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);
    INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate) 
        SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate4')
        FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);
    INSERT INTO @InsRateAsOfDateValues (InsRateDedCode, InsRateAsOfDate) 
        SELECT Item, (SELECT CONVERT(DATETIME, ParmValue2) FROM dbo.U_dsi_BDM_BCAConfiguration WHERE FormatCode = @FormatCode AND ParmName = 'InsRateAsOfDate5')
        FROM dbo.dsi_BDM_fn_ListToTable(@InsRateAsOfDateDedCodes);

    --====================================================
    -- Load Deduction Codes into BDM Deduction Tables
    --====================================================
    ---------------------------------------------------------------------------------------------------------------
    --Insert Deduction Code into BDM Deduction Tables, for exclusive use as Dependent Benefit Age Graded Rate 
    ---------------------------------------------------------------------------------------------------------------
    INSERT INTO dbo.U_dsi_BDM_DeductionCodes (UdcFormatCode,UdcDedTarget,UDcDedCode,UdcDedType,UdcIsDomPartnerDed)
    SELECT UdcFormatCode = @FormatCode
        ,UdcDedTarget = 'DAG'
        ,UDcDedCode = DedDedCode
        ,UdcDedType = DedDedType
        ,UdcIsDomPartnerDed = 'N'
    FROM dbo.Dedcode
    LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@DependentAgeGradedDedCodes) d
        ON d.item = DedDedCode
    WHERE (d.item IS NOT NULL)
    GROUP BY DedDedCode,DedDedType;

    ---------------------------------------------------------------------------------------------------------------
    --Insert Deduction Code into BDM Deduction Tables, for exclusive use as Employee Elected Rate 
    ---------------------------------------------------------------------------------------------------------------
    INSERT INTO dbo.U_dsi_BDM_DeductionCodes (UdcFormatCode,UdcDedTarget,UDcDedCode,UdcDedType,UdcIsDomPartnerDed)
    SELECT UdcFormatCode = @FormatCode
        ,UdcDedTarget = 'EER'
        ,UDcDedCode = DedDedCode
        ,UdcDedType = DedDedType
        ,UdcIsDomPartnerDed = 'N'
    FROM dbo.Dedcode
    LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@EmployeeElectedRateorPctDedCodes) d
        ON d.item = DedDedCode
    WHERE (d.item IS NOT NULL)
    GROUP BY DedDedCode,DedDedType;

    ---------------------------------------------------------------------------------------------------------------
    --Insert Deduction Code into BDM Deduction Tables, to skip Age Graded Rate Reduction Rule
    ---------------------------------------------------------------------------------------------------------------
    INSERT INTO dbo.U_dsi_BDM_DeductionCodes (UdcFormatCode,UdcDedTarget,UDcDedCode,UdcDedType,UdcIsDomPartnerDed)
    SELECT UdcFormatCode = @FormatCode
        ,UdcDedTarget = 'AGR'
        ,UDcDedCode = DedDedCode
        ,UdcDedType = DedDedType
        ,UdcIsDomPartnerDed = 'N'
    FROM dbo.Dedcode
    LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@SkipAgeGradedRateCalcRuleDedCodes) d
        ON d.item = DedDedCode
    WHERE (d.item IS NOT NULL)
    GROUP BY DedDedCode,DedDedType;
    ---------------------------------------------------------------------------------------------------------------
    --Insert Deduction Code into BDM Deduction Tables, to skip Roudning Rules
    ---------------------------------------------------------------------------------------------------------------
    INSERT INTO dbo.U_dsi_BDM_DeductionCodes (UdcFormatCode,UdcDedTarget,UDcDedCode,UdcDedType,UdcIsDomPartnerDed)
    SELECT UdcFormatCode = @FormatCode
        ,UdcDedTarget = 'SRR'
        ,UDcDedCode = DedDedCode
        ,UdcDedType = DedDedType
        ,UdcIsDomPartnerDed = 'N'
    FROM dbo.Dedcode
    LEFT JOIN dbo.dsi_BDM_fn_ListToTable(@SkipRoundingRuleDedCodes) d
        ON d.item = DedDedCode
    WHERE (d.item IS NOT NULL)
    GROUP BY DedDedCode,DedDedType;

    --========================================================
    -- Calculate Benefit Amounts based on Calculation Rules
    --========================================================

    -- Clear Calculation Amounts by Format Code
    DELETE dbo.U_dsi_bdm_BenCalculationAmounts WHERE BcaFormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_BenCalculationAmounts (BcaFormatCode,BcaCoID,BcaEEID,BcaRunID,BcaDedCode,BcaBenAmt,BcaBenOption)
    SELECT EedFormatCode
        ,EedCoid
        ,EedEEID
        ,EedRunID
        ,EedDedCode
        ,EedBenAmt
        ,EedBenOption
    FROM dbo.u_dsi_bdm_EmpDeductions
    WHERE EedFormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_BenCalculationAmounts (BcaFormatCode,BcaCoID,BcaEEID,BcaDepRecID,BcaRunID,BcaDedCode,BcaBenAmt,BcaBenOption)
    SELECT DbnFormatCode
        ,dbo.dsi_BDM_fn_GetCurrentCOID(DbnEEID)
        ,DbnEEID
        ,DbnDepRecID
        ,DbnRunID
        ,DbnDedCode
        ,DedEEBenAmt
        ,DbnBenOption
    FROM dbo.u_dsi_bdm_DepDeductions
    WHERE DbnFormatCode = @FormatCode;

    -----------------------------------------------------------------------------------
    --Update Benefit Calculations Table with Deduction Code Benefit Amount Rules:
    -----------------------------------------------------------------------------------
    UPDATE dbo.U_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalcRule = DedBenAmtCalcRule
        ,BcaBenAmtRateOrPct = DedBenAmtRateOrPct
        ,BcaEEBenAmt = DedEEBenAmt
        ,BcaBenAmtPer = DedBenAmtPer
        ,BcaBenAmtMax = DedBenAmtMax
        ,BcaBenAmtRoundingRule = DedBenAmtRoundingRule
        ,BcaUseCurrentAge = DedUseCurrentAge
        ,BcaAgeAsOfDate = DedAgeAsOfDate
        ,BcaUseBenReducSched = DedUseBenReducSched
        ,BcaBenReducUseCurrentAge = DedBenReducUseCurrentAge
        ,BcaBenReducAgeAsOfDate = DedBenReducAgeAsOfDate
        ,BcaDedEECalcRateOrPct = DedEECalcRateOrPct
        ,BcaDedEECalcRule = DedEECalcRule
        ,BcaDedERCalcRateOrPct = DedERCalcRateOrPct
        ,BcaDedERCalcRule = DedERCalcRule
        ,BcaEEAmt = CASE WHEN DedEECalcRule = '99' THEN 0.00 ELSE NULL END
        ,BcaERAmt = CASE WHEN DedERCalcRule = '99' THEN 0.00 ELSE NULL END
    FROM dbo.U_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.dedcode
        ON BcaDedCode = DeddedCode
    WHERE BcaFormatCode = @FormatCode;

    -----------------------------------------------------------------------------------
    --Update Benefit Calculations Table with Employee Elected Benefit Amount Rules:
    -----------------------------------------------------------------------------------
    UPDATE dbo.U_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtRateOrPct = eedBenAmtRateorPct
    FROM dbo.U_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.U_dsi_bdm_EmpDeductions
        ON BcaEEID = EedEEID
        AND BcaCoID = EedCoID
        AND EedFormatCode = BcaFormatCode
        AND BcaDedCode = EedDedCode
        AND EedRunID = bcaRunID
    WHERE BcaDedCode IN (SELECT Udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'EER') 
        AND BcaFormatCode = @FormatCode;

    --=================================================================================
    --Update Calculated Benefit Amount for Calc Rules: '20','30','40','41','42','43'
    --=================================================================================
    UPDATE dbo.U_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalc = CASE WHEN BcaBenAmtCalcRule = '20' THEN 0
                             WHEN BcaBenAmtCalcRule = '30' THEN
                                CASE WHEN BcaBenAmt = 0 THEN BcaEEBenAmt
                                     ELSE BcaBenAmt
                                END
                             WHEN BcaBenAmtCalcRule = '40' THEN --'Period Pay * Pct'
                                CASE WHEN EecSalaryOrHourly = 'S' THEN
                                        CASE WHEN EecPayPeriod = 'B' THEN eecAnnSalary / 26
                                             WHEN EecPayPeriod = 'S' THEN eecAnnSalary / 24
                                             WHEN EecPayPeriod = 'M' THEN eecAnnSalary / 12
                                             WHEN EecPayPeriod = 'W' THEN eecAnnSalary / 52
                                        END
                                    WHEN EecSalaryOrHourly = 'H' THEN EecHourlyPayRate * EecScheduledWorkHrs
                                END * BcaBenAmtRateOrPct
                             WHEN BcaBenAmtCalcRule = '41' THEN --'Weekly Pay * Pct'
                                CASE WHEN EecSalaryOrHourly = 'S' THEN (eecAnnSalary / 52)
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'B' THEN EecHourlyPayRate * EecScheduledWorkHrs / 2
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'W' THEN EecHourlyPayRate * EecScheduledWorkHrs
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'M' THEN EecHourlyPayRate * (EecScheduledWorkHrs * 12) / 52
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'S' THEN EecHourlyPayRate * (EecScheduledWorkHrs * 24) / 52
                                END * BcaBenAmtRateOrPct
                             WHEN BcaBenAmtCalcRule = '42' THEN --'Monthly Pay * Pct'
                                CASE WHEN EecSalaryOrHourly = 'S' THEN (eecAnnSalary / 12)
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'B' THEN (EecHourlyPayRate * EecScheduledWorkHrs * 26) / 12
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'S' THEN (EecHourlyPayRate * EecScheduledWorkHrs * 24) / 12
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'W' THEN (EecHourlyPayRate * EecScheduledWorkHrs * 52) / 12
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'M' THEN (EecHourlyPayRate * EecScheduledWorkHrs)
                                END * BcaBenAmtRateOrPct
                             WHEN BcaBenAmtCalcRule = '43' THEN --'Ann Salary * Rate'
                                CASE WHEN EecSalaryOrHourly = 'S' THEN eecAnnSalary
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'B' THEN EecHourlyPayRate * EecScheduledWorkHrs * 26
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'S' THEN EecHourlyPayRate * EecScheduledWorkHrs * 24
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'W' THEN EecHourlyPayRate * EecScheduledWorkHrs * 52
                                     WHEN EecSalaryOrHourly = 'H' AND EecPayPeriod = 'M' THEN EecHourlyPayRate * EecScheduledWorkHrs * 12
                                END * BcaBenAmtRateOrPct
                        END
        ,BcaCalcRowStatus = 'Normal Calculation Rules applied'
    FROM dbo.U_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.empcomp WITH (NOLOCK)
        ON EecEEID = bcaeeid
        AND EecCOID = bcacoid
    WHERE BcaBenAmtCalcRule IN ('20','30','40','41','42','43') 
        AND BcaFormatCode = @FormatCode;

    -----------------------------------------------------------------------------------
    --Update Calculated Amount to be no greater than DedBenAmtMax
    -----------------------------------------------------------------------------------
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalc = BcaBenAmtMax
        ,BcaCalcRowStatus = 'Elected Amount exceeds DedBenAmtMax reduction rule triggered'
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    WHERE BcaBenAmtCalc > BcaBenAmtMax 
        AND BcaFormatCode = @FormatCode
        AND BcaBenAmtMax <> 0.00;

    --=================================================================================
    -- Updates for Age Graded Rates - Benefit Reduction Table: dbo.BenReduc
    --=================================================================================
    -----------------------------------------------------------------------------------
    --Update Calculated Amount if Age Graded Rate Applies
    -----------------------------------------------------------------------------------
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalc = BcaBenAmtCalc - (BcaBenAmtCalc * RedReductionPct)
        ,BcaCalcRowStatus = 'Age Graded Rate Benefit Amount reduction rule triggered on EEs Age'
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.emppers WITH (NOLOCK)
        ON Bcaeeid = EepEEID
    INNER JOIN dbo.empcomp WITH (NOLOCK)
        ON Bcaeeid = EecEEID
        AND Bcacoid = EecCOID
    INNER JOIN dbo.BenReduc WITH (NOLOCK)
        ON reddedcode = BcaDedCode
        --AND ((FLOOR(DATEDIFF(DAY, EepDateOfBirth, ISNULL(BcaBenReducAgeAsOfDate, GETDATE())) / 365.242199) >= RedMinAge)
        --    AND (FLOOR(DATEDIFF(DAY, EepDateOfBirth, ISNULL(BcaBenReducAgeAsOfDate, GETDATE())) / 365.242199) < RedMaxAge)
        --)
        AND ((DATEDIFF(hour,EepDateOfBirth,ISNULL(BcaBenReducAgeAsOfDate,GETDATE()))/8766 >= RedMinAge)
            AND (DATEDIFF(hour,EepDateOfBirth,ISNULL(BcaBenReducAgeAsOfDate,GETDATE()))/8766 < RedMaxAge)
        )
    WHERE BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'DAG')
        AND BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'AGR')
        AND EXISTS (SELECT 1 FROM dbo.BenReduc WHERE reddedcode = BcaDedCode) 
        AND BcaFormatCode = @FormatCode;

    -----------------------------------------------------------------------------------
    --Update Calculated Amount if Age Graded Rate Applies -  Dependent Age Graded Rates
    -----------------------------------------------------------------------------------
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalc = BcaBenAmtCalc - (BcaBenAmtCalc * RedReductionPct)
        ,BcaCalcRowStatus = 'Age Graded Rate Benefit Amount reduction rule triggered on Dependents Age'
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.emppers WITH (NOLOCK)
        ON Bcaeeid = EepEEID
    INNER JOIN dbo.empcomp WITH (NOLOCK)
        ON Bcaeeid = EecEEID
        AND Bcacoid = EecCOID
    INNER JOIN dbo.Contacts WITH (NOLOCK)
        ON BcaEEID = ConEEID
        AND BcaDepRecID = ConSystemID
    INNER JOIN dbo.BenReduc WITH (NOLOCK)
        ON reddedcode = BcaDedCode
        --AND ((FLOOR(DATEDIFF(DAY, conDateOfBirth, ISNULL(BcaBenReducAgeAsOfDate, GETDATE())) / 365.242199) >= RedMinAge)
        --    AND (FLOOR(DATEDIFF(DAY, conDateOfBirth, ISNULL(BcaBenReducAgeAsOfDate, GETDATE())) / 365.242199) < RedMaxAge)
        --)
        AND ((DATEDIFF(hour,ConDateOfBirth,ISNULL(BcaBenReducAgeAsOfDate,GETDATE()))/8766 >= RedMinAge)
            AND (DATEDIFF(hour,ConDateOfBirth,ISNULL(BcaBenReducAgeAsOfDate,GETDATE()))/8766 < RedMaxAge)
        )
    WHERE BcaDedCode IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'DAG')
        AND BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'AGR')
        AND EXISTS (SELECT 1 FROM dbo.BenReduc WHERE reddedcode = BcaDedCode) 
        AND BcaFormatCode = @FormatCode;

    -----------------------------------------------------------------------------------
    --Update EE Age Graded Rate Amount, based on Spouse Life Amount Age Calculation:
    -----------------------------------------------------------------------------------
    UPDATE dbo.U_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalc = dep.BcaBenAmtCalc
        ,BcaCalcRowStatus = 'Age Graded Rate Benefit Amount reduction rule triggered on Dependents Age'
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN (
        SELECT bcaeeid eeid
            ,bcacoid coid
            ,BcaDedCode dedcode
            ,BcaBenAmtCalc
        FROM dbo.u_dsi_bdm_BenCalculationAmounts
        WHERE BcaDepRecID IS NOT NULL
        AND BcaDedCode IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'DAG')
    ) dep
        ON dep.eeid = BcaEEID
        AND dep.coid = bcacoid
        AND dep.dedcode = BcaDedCode
    WHERE BcaDepRecID IS NULL AND BcaFormatCode = @FormatCode
    AND BcaDedCode IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'DAG')
    AND BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'AGR')
    AND EXISTS (SELECT 1 FROM dbo.BenReduc WHERE reddedcode = BcaDedCode);

    --=================================================================================
    --Update Calculated Amount if Rounding Rule Applies
    --=================================================================================
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaBenAmtCalc = CASE WHEN BcaBenAmtRoundingRule = '10' THEN ROUND(BcaBenAmtCalc, 0) --'Normal to Nearest dollar'
                             WHEN BcaBenAmtRoundingRule = '11' THEN ROUND(BcaBenAmtCalc, - 1) --'Normal to Nearest Ten'
                             WHEN BcaBenAmtRoundingRule = '12' THEN ROUND(BcaBenAmtCalc, - 2) --'Normal to Nearest Hundred'
                             WHEN BcaBenAmtRoundingRule = '13' THEN ROUND(BcaBenAmtCalc, - 3) --'Normal to Nearest Thousand'
                             WHEN BcaBenAmtRoundingRule = '20' THEN CEILING(BcaBenAmtCalc) --'Up to Next dollar'
                             WHEN BcaBenAmtRoundingRule = '21' THEN CEILING(BcaBenAmtCalc / 10) * 10 --'Up to Next Ten'
                             WHEN BcaBenAmtRoundingRule = '22' THEN CEILING(BcaBenAmtCalc / 100) * 100 --'Up to Next Hundred'
                             WHEN BcaBenAmtRoundingRule = '23' THEN CEILING(BcaBenAmtCalc / 1000) * 1000 --'Up to Next Hundred'
                        END
        ,BcaCalcRowStatus = 'Benefit Amount Rounding Rule Applied'
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    WHERE BcaBenAmtRoundingRule <> 'Z' AND BcaFormatCode = @FormatCode
    AND BcaDedCode NOT IN (SELECT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode AND UdcDedTarget = 'SRR');

    --=================================================================================
    -- Updates for Employee and Employer Amounts - Insurance Rates: dbo.InsRate
    --=================================================================================

    -- Clear Calculation Amounts by Format Code
    DELETE dbo.U_dsi_bdm_bcaInsRate WHERE BcaInsFormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_bcaInsRate (BcaInsFormatCode,bcaInsDedcode,bcaInsMinAge,bcaInsMaxAge,bcaInsEERateNSFemale,bcaInsEERateSMFemale,bcaInsEERateNSMale,bcaInsEERateSMMale,bcaInsERRateNSFemale
        ,bcaInsERRateSMFemale,bcaInsERRateNSMale,bcaInsERRateSMMale,bcaInsEffDate,bcaInsPayFreq,bcaInsRowNum)
    SELECT @FormatCode
        ,Ratdedcode
        ,RatMinAge
        ,RatMaxAge
        ,RatEERateNSFemale
        ,RatEERateSMFemale
        ,RatEERateNSMale
        ,RatEERateSMMale
        ,RatERRateNSFemale
        ,RatERRateSMFemale
        ,RatERRateNSMale
        ,RatERRateSMMale
        ,RatEffDate
        ,RatPayFreq
        ,ROW_NUMBER() OVER (PARTITION BY Ratdedcode,RatMinAge,RatPayFreq ORDER BY RatEffDate DESC) --Removed ,RatMaxAge from calc order sequence, if Rate structure ages change
    FROM dbo.InsRate
    WHERE RatDedCode IN (SELECT DISTINCT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode)
    AND RatEffDate <= @RateEffDate
    GROUP BY RatDedCode
        ,RatMinAge
        ,RatMaxAge
        ,RatEERateNSFemale
        ,RatEERateSMFemale
        ,RatEERateNSMale
        ,RatEERateSMMale
        ,RatERRateNSFemale
        ,RatERRateSMFemale
        ,RatERRateNSMale
        ,RatERRateSMMale
        ,Rateffdate
        ,RatPayFreq;

    DELETE dbo.U_dsi_bdm_bcaInsRate
    FROM dbo.U_dsi_bdm_bcaInsRate
    WHERE bcaInsRowNum <> 1 AND BcaInsFormatCode = @FormatCode;

    DELETE dbo.U_dsi_bdm_bcaInsRate
    FROM dbo.U_dsi_bdm_bcaInsRate C
    INNER JOIN (SELECT bcaInsDedcode, MAX(bcaInsEffDate) Dt 
                FROM dbo.U_dsi_bdm_bcaInsRate 
                GROUP BY bcaInsDedcode) O ON O.bcaInsDedcode = C.bcaInsDedcode AND O.Dt <> C.bcaInsEffDate
    WHERE bcaInsFormatCode = @FormatCode;
        

    -----------------------------------------------------------------------------------
    --Update Calculated Amount if Age Graded Rate Applies for Insurance Rate
    -----------------------------------------------------------------------------------
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaEEAmt = (CASE WHEN EepGender = 'M' AND EepIsSmoker = 'N' THEN bcaInsEERateNSMale
                         WHEN EepGender = 'M' AND EepIsSmoker = 'Y' THEN bcaInsEERateSMMale
                         WHEN EepGender = 'F' AND EepIsSmoker = 'N' THEN bcaInsEERateNSFemale
                         WHEN EepGender = 'F' AND EepIsSmoker = 'Y' THEN bcaInsEERateSMFemale
                    END) * (BcaBenAmtCalc / 1000)
        ,BcaERAmt = (CASE WHEN EepGender = 'M' AND EepIsSmoker = 'N' THEN bcaInsERRateNSMale
                          WHEN EepGender = 'M' AND EepIsSmoker = 'Y' THEN bcaInsERRateSMMale
                          WHEN EepGender = 'F' AND EepIsSmoker = 'N' THEN bcaInsERRateNSFemale
                          WHEN EepGender = 'F' AND EepIsSmoker = 'Y' THEN bcaInsERRateSMFemale
                    END) * (BcaBenAmtCalc / 1000)
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.emppers WITH (NOLOCK)
        ON Bcaeeid = EepEEID
    INNER JOIN dbo.empcomp WITH (NOLOCK)
        ON Bcaeeid = EecEEID
        AND Bcacoid = EecCOID
    LEFT JOIN @InsRateAsOfDateValues E ON InsRateDedCode = BcaDedCode
    INNER JOIN dbo.U_dsi_bdm_bcaInsRate WITH (NOLOCK)
        ON bcaInsDedCode = BcaDedCode
        AND bcaInsPayFreq = EecPayPeriod
        --AND ((FLOOR(DATEDIFF(DAY, EepDateOfBirth, ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE()))) / 365.242199) >= bcaInsMinAge)
        --    AND (FLOOR(DATEDIFF(DAY, EepDateOfBirth, ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE()))) / 365.242199) < bcaInsMaxAge)
        --)
        AND ((DATEDIFF(hour,EepDateOfBirth,ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE())))/8766 >= bcaInsMinAge)
            AND (DATEDIFF(hour,EepDateOfBirth,ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE())))/8766 < bcaInsMaxAge)
        )
    WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_bcaInsRate WHERE bcaInsDedCode = BcaDedCode AND BcaInsFormatCode = @FormatCode)
        AND BcaDedEECalcRule <> 32
        AND bcaFormatCode = @FormatCode;

    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaEEAmt = (CASE WHEN ConGender = 'M' AND ConIsSmoker = 'N' THEN bcaInsEERateNSMale
                         WHEN ConGender = 'M' AND ConIsSmoker = 'Y' THEN bcaInsEERateSMMale
                         WHEN ConGender = 'F' AND ConIsSmoker = 'N' THEN bcaInsEERateNSFemale
                         WHEN ConGender = 'F' AND ConIsSmoker = 'Y' THEN bcaInsEERateSMFemale
                    END) * (BcaBenAmtCalc / 1000)
        ,BcaERAmt = (CASE WHEN ConGender = 'M' AND ConIsSmoker = 'N' THEN bcaInsERRateNSMale
                          WHEN ConGender = 'M' AND ConIsSmoker = 'Y' THEN bcaInsERRateSMMale
                          WHEN ConGender = 'F' AND ConIsSmoker = 'N' THEN bcaInsERRateNSFemale
                          WHEN ConGender = 'F' AND ConIsSmoker = 'Y' THEN bcaInsERRateSMFemale
                    END) * (BcaBenAmtCalc / 1000)
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.emppers WITH (NOLOCK)
        ON Bcaeeid = EepEEID
    INNER JOIN dbo.empcomp WITH (NOLOCK)
        ON Bcaeeid = EecEEID
        AND Bcacoid = EecCOID
    INNER JOIN dbo.Contacts WITH (NOLOCK)
        ON BcaEEID = ConEEID
        AND BcaDepRecID = ConSystemID
    LEFT JOIN @InsRateAsOfDateValues E ON InsRateDedCode = BcaDedCode
    INNER JOIN dbo.U_dsi_bdm_bcaInsRate WITH (NOLOCK)
        ON bcaInsDedCode = BcaDedCode
        AND bcaInsPayFreq = EecPayPeriod
        --AND ((FLOOR(DATEDIFF(DAY, ConDateOfBirth, ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE()))) / 365.242199) >= bcaInsMinAge)
        --    AND (FLOOR(DATEDIFF(DAY, ConDateOfBirth, ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE()))) / 365.242199) < bcaInsMaxAge)
        --)
        AND ((DATEDIFF(hour,ConDateOfBirth,ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE())))/8766 >= bcaInsMinAge)
            AND (DATEDIFF(hour,ConDateOfBirth,ISNULL(InsRateAsOfDate,ISNULL(BcaAgeAsOfDate, GETDATE())))/8766 < bcaInsMaxAge)
        )
    WHERE BcaDepRecID IS NOT NULL
        AND EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_bcaInsRate WHERE bcaInsDedCode = BcaDedCode AND BcaInsFormatCode = @FormatCode)
        AND BcaDedEECalcRule = 32
        AND bcaFormatCode = @FormatCode;

    --Copy Dependent Calculated Premium Up to EE record:
    UPDATE dbo.U_dsi_bdm_BenCalculationAmounts
    SET BcaEEAmt = dp.BcaEEAmt,
        BcaERAmt = dp.BcaERAmt
    FROM dbo.U_dsi_bdm_BenCalculationAmounts
    JOIN (SELECT BcaEEID eeid, BcaCOID coid, BcaDedCode dedcode, BcaEEAmt, BcaERAmt
        FROM dbo.U_dsi_bdm_BenCalculationAmounts
        WHERE BcaFormatCode = @FormatCode 
            AND BcaDepRecID IS NOT NULL
            AND BcaDedEECalcRule = 32) dp on dp.eeid = bcaeeid AND dp.coid = BcaCoID AND dp.dedcode = BcaDedCode
    WHERE BcaDepRecID IS NULL 
        AND BcaFormatCode = @FormatCode;

    --=================================================================================
    -- Updates for Employee and Employer Amounts - Insurance Rates: dbo.OptRate
    --=================================================================================

    -- Clear Calculation Amounts by Format Code
    DELETE dbo.U_dsi_bdm_bcaOptRate WHERE BcaORFormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_bcaOptRate (bcaORFormatCode,bcaORDedcode,bcaORBenOption,bcaOREERate,bcaORERRate,bcaORPayFreq,bcaORRowNum)
    SELECT @FormatCode
        ,Cordedcode
        ,Corbenoption
        ,CorEERate
        ,CorERRate
        ,CorPayFreq
        ,ROW_NUMBER() OVER (PARTITION BY cordedcode,corbenoption,corpayfreq ORDER BY CorEffDate DESC)
    FROM dbo.optrate
    WHERE CorDedCode IN (SELECT DISTINCT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode)
    AND CorEffDate <= @RateEffDate
    GROUP BY CorDedCode
        ,CorBenOption
        ,coreffdate
        ,CorEERate
        ,CorERRate
        ,CorPayFreq;

    DELETE dbo.U_dsi_bdm_bcaOptRate
    FROM dbo.U_dsi_bdm_bcaOptRate
    WHERE bcaORRowNum <> 1 AND bcaORFormatCode = @FormatCode;

    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaEEAmt = bcaOREERate
        ,BcaERAmt = bcaORERRate
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.emppers WITH (NOLOCK)
        ON Bcaeeid = EepEEID
    INNER JOIN dbo.empcomp WITH (NOLOCK)
        ON Bcaeeid = EecEEID
        AND Bcacoid = EecCOID
    INNER JOIN dbo.U_dsi_bdm_bcaOptRate WITH (NOLOCK)
        ON BcaORDedCode = BcaDedCode
        AND BcaORPayFreq = EecPayPeriod
        AND BcaORBenOption = BcaBenOption
    WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_bcaOptRate WHERE bcaORDedCode = BcaDedCode AND bcaORFormatCode = @FormatCode);
    
    --=================================================================================
    -- Updates for Employee and Employer Amounts - Calculation Rule = Benefit Amount * Rate
    --=================================================================================
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaEEAmt = ISNULL((bcaBenAmtCalc/1000) * BcaDedEECalcRateOrPct,0.00)
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    WHERE BcaDedEECalcRule = '30' AND bcaFormatCode = @FormatCode;

    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaERAmt = ISNULL((bcaBenAmtCalc/1000) * BcaDedERCalcRateOrPct,0.00)
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    WHERE BcaDedERCalcRule = '30' AND bcaFormatCode = @FormatCode;

    --=================================================================================
    -- Updates for Employee and Employer Amounts - Calculation Rule = Flat Amount
    --=================================================================================
    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaEEAmt = CASE WHEN EecPayPeriod = 'B' THEN dedEEBiWeeklyAmt
                        WHEN EecPayPeriod = 'W' THEN dedEEWeeklyAmt
                        WHEN EecPayPeriod = 'M' THEN dedEEMonthlyAmt
                        WHEN EecPayPeriod = 'S' THEN dedEESemiMonthlyAmt
                   END
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = bcaeeid
        AND EecCOID = bcacoid
    INNER JOIN dbo.DedCode WITH (NOLOCK)
        ON BcaDedCode = DedDedCode
    WHERE BcaDedEECalcRule = '20' AND bcaFormatCode = @FormatCode;

    UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
    SET BcaERAmt = CASE WHEN EecPayPeriod = 'B' THEN dedERBiWeeklyAmt
                        WHEN EecPayPeriod = 'W' THEN dedERWeeklyAmt
                        WHEN EecPayPeriod = 'M' THEN dedERMonthlyAmt
                        WHEN EecPayPeriod = 'S' THEN dedERSemiMonthlyAmt
                   END
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    INNER JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = bcaeeid
        AND EecCOID = bcacoid
    INNER JOIN dbo.DedCode WITH (NOLOCK)
        ON BcaDedCode = DedDedCode
    WHERE BcaDedERCalcRule = '20' AND bcaFormatCode = @FormatCode;

END;
GO
