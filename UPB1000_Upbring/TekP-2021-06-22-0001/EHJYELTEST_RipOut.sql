SET NOCOUNT ON;
IF OBJECT_ID('U_EHJYELTEST_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHJYELTEST_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EHJYELTEST_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EHJYELTEST' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEHJYELTEST_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHJYELTEST_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHJYELTEST') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHJYELTEST];
GO
IF OBJECT_ID('U_EHJYELTEST_File') IS NOT NULL DROP TABLE [dbo].[U_EHJYELTEST_File];
GO
IF OBJECT_ID('U_EHJYELTEST_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHJYELTEST_EEList];
GO
IF OBJECT_ID('U_EHJYELTEST_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHJYELTEST_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EHJYELTEST';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EHJYELTEST';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EHJYELTEST';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EHJYELTEST';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EHJYELTEST';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHJYELTEST','HealthJoy Eligibility Export V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EHJYELTESTZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EHJYELTEST' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer ID"','1','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','1',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Start Date"','2','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','2',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','3','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','3',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Term Date"','4','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','4',NULL,'Employment Term Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COBRA Start Date"','5','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','5',NULL,'COBRA Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COBRA Termination Date"','6','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','6',NULL,'COBRA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','7','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','8','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','8',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number"','9','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','9',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship"','10','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','10',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email"','11','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','11',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mobile Number"','12','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','12',NULL,'Mobile Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','13','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','13',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','14','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','14',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','15','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','15',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','16','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','16',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','17','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','18','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','18',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','19','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','19',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Class"','20','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','20',NULL,'Benefit Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','21','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','21',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Insurance Plan Name"','22','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','22',NULL,'Medical Insurance Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Group ID"','23','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','23',NULL,'Medical Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Plan Effective Date"','24','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','24',NULL,'Medical Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Plan Termination Date"','25','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','25',NULL,'Medical Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Insurance Plan Name"','26','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','26',NULL,'Dental Insurance Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Group ID"','27','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','27',NULL,'Dental Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Plan Effective Date"','28','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','28',NULL,'Dental Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Plan Termination Date"','29','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','29',NULL,'Dental Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Insurance Plan Name"','30','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','30',NULL,'Vision Insurance Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Group ID"','31','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','31',NULL,'Vision Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Plan Effective Date"','32','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','32',NULL,'Vision Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Plan Termination Date"','33','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','33',NULL,'Vision Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Plan Name"','34','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','34',NULL,'Basic Life Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Policy Amount"','35','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','35',NULL,'Basic Life Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Effective Date"','36','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','36',NULL,'Basic Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Policy Termination Date"','37','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','37',NULL,'Basic Life Policy Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Life Plan Name"','38','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','38',NULL,'Supplemental Life Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Life Policy Amount"','39','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','39',NULL,'Supplemental Life Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Life Effective Date"','40','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','40',NULL,'Supplemental Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Life Termination Date"','41','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','41',NULL,'Supplemental Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Plan Name"','42','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','42',NULL,'LTD Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Policy Amount"','43','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','43',NULL,'LTD Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Effective Date"','44','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','44',NULL,'LTD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Termination Date"','45','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','45',NULL,'LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Plan Name"','46','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','46',NULL,'STD Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Policy Amount"','47','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','47',NULL,'STD Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Effective Date"','48','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','48',NULL,'STD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Termination Date"','49','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','49',NULL,'STD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Healthcare FSA Plan Name"','50','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','50',NULL,'Healthcare FSA Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Healthcare FSA Goal Amount"','51','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','51',NULL,'Healthcare FSA Goal Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Healthcare FSA Effective Date"','52','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','52',NULL,'Healthcare FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Healthcare FSA Termination Date"','53','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','53',NULL,'Healthcare FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Care FSA Plan Name"','54','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','54',NULL,'Dependent Care FSA Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Care FSA Goal Amount"','55','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','55',NULL,'Dependent Care FSA Goal Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Care FSA Effective Date"','56','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','56',NULL,'Dependent Care FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Care FSA Termination Date"','57','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','57',NULL,'Dependent Care FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HSA Plan Name"','58','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','58',NULL,'HSA Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HSA Goal Amount"','59','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','59',NULL,'HSA Goal Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HSA Effective Date"','60','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','60',NULL,'HSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HSA Termination Date"','61','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','61',NULL,'HSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Plan Name"','62','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','62',NULL,'Accident Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Policy Amount"','63','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','63',NULL,'Accident Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Effective Date"','64','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','64',NULL,'Accident Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Termination Date"','65','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','65',NULL,'Accident Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Plan Name"','66','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','66',NULL,'Critical Illness Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Policy Amount"','67','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','67',NULL,'Critical Illness Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Policy Effective Date"','68','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','68',NULL,'Critical Illness Policy Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Termination Date"','69','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','69',NULL,'Critical Illness Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Indemnity Plan Name"','70','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','70',NULL,'Hospital Indemnity Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Indemnity Policy Amount"','71','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','71',NULL,'Hospital Indemnity Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Indemnity Policy Effective Date"','72','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','72',NULL,'Hospital Indemnity Policy Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Indemnity Termination Date"','73','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','73',NULL,'Hospital Indemnity Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D Plan Name"','74','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','74',NULL,'Basic AD&D Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D Policy Amount"','75','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','75',NULL,'Basic AD&D Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D Effective Date"','76','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','76',NULL,'Basic AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D Termination Date"','77','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','77',NULL,'Basic AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Voluntary AD&D Plan Name"','78','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','78',NULL,'Voluntary AD&D Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Voluntary AD&D Policy Amount"','79','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','79',NULL,'Voluntary AD&D Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Voluntary AD&D Effective Date"','80','(''DA''=''T,'')','EHJYELTESTZ0','50','H','01','80',NULL,'Voluntary AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Voluntary AD&D Termination Date"','81','(''DA''=''T'')','EHJYELTESTZ0','50','H','01','81',NULL,'Voluntary AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerID"','1','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','1',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','2','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','2',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplStatus"','3','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','3',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplTermDate"','4','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','4',NULL,'Employment Term Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCobraStartDate"','5','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','5',NULL,'COBRA Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCobraTermDate"','6','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','6',NULL,'COBRA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','8',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','9','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','9',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','10','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','10',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','11','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','11',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneMobile"','12','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','12',NULL,'Mobile Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','13','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','13',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','14','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','14',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','15','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','15',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','16','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','16',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','17','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','18','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','18',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','19','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','19',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitClass"','20','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','20',NULL,'Benefit Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','21','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','21',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedPlanName"','22','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','22',NULL,'Medical Insurance Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedGroupID"','23','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','23',NULL,'Medical Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedEffDate"','24','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','24',NULL,'Medical Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedTermDate"','25','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','25',NULL,'Medical Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDenPlanName"','26','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','26',NULL,'Dental Insurance Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDenGroupID"','27','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','27',NULL,'Dental Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDenEffDate"','28','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','28',NULL,'Dental Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDenTermDate"','29','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','29',NULL,'Dental Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisPlanName"','30','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','30',NULL,'Vision Insurance Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisGroupID"','31','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','31',NULL,'Vision Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisEffDate"','32','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','32',NULL,'Vision Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisTermDate"','33','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','33',NULL,'Vision Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLPlanName"','34','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','34',NULL,'Basic Life Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLAmount"','35','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','35',NULL,'Basic Life Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLEffDate"','36','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','36',NULL,'Basic Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLTermDate"','37','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','37',NULL,'Basic Life Policy Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOLPlanName"','38','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','38',NULL,'Supplemental Life Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOLAmount"','39','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','39',NULL,'Supplemental Life Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOLEffDate"','40','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','40',NULL,'Supplemental Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOLTermDate"','41','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','41',NULL,'Supplemental Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDPlanName"','42','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','42',NULL,'LTD Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDAmount"','43','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','43',NULL,'LTD Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEffDate"','44','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','44',NULL,'LTD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDTermDate"','45','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','45',NULL,'LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDPlanName"','46','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','46',NULL,'STD Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDAmount"','47','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','47',NULL,'STD Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDEffDate"','48','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','48',NULL,'STD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDTermDate"','49','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','49',NULL,'STD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAPlanName"','50','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','50',NULL,'Healthcare FSA Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAGoalAmt"','51','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','51',NULL,'Healthcare FSA Goal Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAEffDate"','52','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','52',NULL,'Healthcare FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSATermDate"','53','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','53',NULL,'Healthcare FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDCAPlanName"','54','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','54',NULL,'Dependent Care FSA Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDCAGoalAmt"','55','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','55',NULL,'Dependent Care FSA Goal Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDCAEffDate"','56','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','56',NULL,'Dependent Care FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDCATermDate"','57','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','57',NULL,'Dependent Care FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHSAPlanName"','58','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','58',NULL,'HSA Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHSAGoalAmt"','59','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','59',NULL,'HSA Goal Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHSAEffDate"','60','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','60',NULL,'HSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHSATermDate"','61','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','61',NULL,'HSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccPlanName"','62','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','62',NULL,'Accident Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccAmount"','63','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','63',NULL,'Accident Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccEffDate"','64','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','64',NULL,'Accident Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccTermDate"','65','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','65',NULL,'Accident Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritPlanName"','66','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','66',NULL,'Critical Illness Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritAmount"','67','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','67',NULL,'Critical Illness Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritEffDate"','68','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','68',NULL,'Critical Illness Policy Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCritTermDate"','69','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','69',NULL,'Critical Illness Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHospPlanName"','70','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','70',NULL,'Hospital Indemnity Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHospAmount"','71','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','71',NULL,'Hospital Indemnity Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHospEffDate"','72','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','72',NULL,'Hospital Indemnity Policy Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHospTermDate"','73','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','73',NULL,'Hospital Indemnity Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBAPlanName"','74','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','74',NULL,'Basic AD&D Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBAAmount"','75','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','75',NULL,'Basic AD&D Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBAEffDate"','76','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','76',NULL,'Basic AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATermDate"','77','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','77',NULL,'Basic AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVADPlanName"','78','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','78',NULL,'Voluntary AD&D Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVADAmount"','79','(''UA''=''T,'')','EHJYELTESTZ0','50','D','10','79',NULL,'Voluntary AD&D Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVADEffDate"','80','(''UD101''=''T,'')','EHJYELTESTZ0','50','D','10','80',NULL,'Voluntary AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVADTermDate"','81','(''UD101''=''T'')','EHJYELTESTZ0','50','D','10','81',NULL,'Voluntary AD&D Termination Date',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EHJYELTEST_20210903.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202010139','EMPEXPORT','OEACTIVE',NULL,'EHJYELTEST',NULL,NULL,NULL,'202010139','Oct 13 2020 12:44PM','Oct 13 2020 12:44PM','202010131',NULL,'','','202010131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',D5BZ5,CXX93',NULL,NULL,NULL,'Passive Open Enrollment Export','202107019','EMPEXPORT','OEPASSIVE',NULL,'EHJYELTEST',NULL,NULL,NULL,'202107019','Oct 13 2020 12:44PM','Oct 13 2020 12:44PM','202107011',NULL,'','','202107011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthJoy Eligibility Export','202010139','EMPEXPORT','ONDEM_XOE',NULL,'EHJYELTEST',NULL,NULL,NULL,'202010139','Oct 13 2020 12:44PM','Oct 13 2020 12:44PM','202010131',NULL,'','','202010131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N',',D5BZ5,CXX93',NULL,NULL,NULL,'HealthJoy Eligibility Ex-Sched','202010139','EMPEXPORT','SCH_EHJYEL',NULL,'EHJYELTEST',NULL,NULL,NULL,'202108069','Oct 13 2020 12:44PM','Oct 13 2020 12:44PM','202107301',NULL,'','','202010131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'HealthJoy Eligibility Ex-Test','202108301','EMPEXPORT','TEST_XOE','Aug 30 2021  3:58PM','EHJYELTEST',NULL,NULL,NULL,'202108301','Aug 30 2021 12:00AM','Dec 30 1899 12:00AM','202108161','999','','','202108161',dbo.fn_GetTimedKey(),NULL,'us3jReUPB1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELTEST','ArchiveFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELTEST','ArchivePath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELTEST','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELTEST','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELTEST','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELTEST','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELTEST','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELTEST','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELTEST','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EHJYELTEST' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EHJYELTEST' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EHJYELTEST_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHJYELTEST_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHJYELTEST','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHJYELTEST','D10','dbo.U_EHJYELTEST_drvTbl',NULL);
IF OBJECT_ID('U_EHJYELTEST_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHJYELTEST_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEmployerID] varchar(11) NULL,
    [drvStartDate] datetime NULL,
    [drvEmplStatus] char(1) NULL,
    [drvEmplTermDate] datetime NULL,
    [drvCobraStartDate] int NULL,
    [drvCobraTermDate] int NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvSSN] varchar(11) NULL,
    [drvRelationship] varchar(8) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhoneMobile] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvBenefitClass] varchar(1) NOT NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvMedPlanName] varchar(40) NULL,
    [drvMedGroupID] varchar(1) NOT NULL,
    [drvMedEffDate] datetime NULL,
    [drvMedTermDate] datetime NULL,
    [drvDenPlanName] varchar(40) NULL,
    [drvDenGroupID] varchar(1) NOT NULL,
    [drvDenEffDate] datetime NULL,
    [drvDenTermDate] datetime NULL,
    [drvVisPlanName] varchar(40) NULL,
    [drvVisGroupID] varchar(1) NOT NULL,
    [drvVisEffDate] datetime NULL,
    [drvVisTermDate] datetime NULL,
    [drvBLPlanName] varchar(40) NULL,
    [drvBLAmount] varchar(1) NOT NULL,
    [drvBLEffDate] datetime NULL,
    [drvBLTermDate] datetime NULL,
    [drvOLPlanName] varchar(40) NULL,
    [drvOLAmount] varchar(30) NULL,
    [drvOLEffDate] datetime NULL,
    [drvOLTermDate] datetime NULL,
    [drvLTDPlanName] varchar(40) NULL,
    [drvLTDAmount] varchar(30) NULL,
    [drvLTDEffDate] datetime NULL,
    [drvLTDTermDate] datetime NULL,
    [drvSTDPlanName] varchar(40) NULL,
    [drvSTDAmount] varchar(30) NULL,
    [drvSTDEffDate] datetime NULL,
    [drvSTDTermDate] datetime NULL,
    [drvFSAPlanName] varchar(40) NULL,
    [drvFSAGoalAmt] varchar(30) NULL,
    [drvFSAEffDate] datetime NULL,
    [drvFSATermDate] datetime NULL,
    [drvDCAPlanName] varchar(1) NOT NULL,
    [drvDCAGoalAmt] varchar(1) NOT NULL,
    [drvDCAEffDate] int NULL,
    [drvDCATermDate] int NULL,
    [drvHSAPlanName] varchar(1) NOT NULL,
    [drvHSAGoalAmt] varchar(1) NOT NULL,
    [drvHSAEffDate] int NULL,
    [drvHSATermDate] int NULL,
    [drvAccPlanName] varchar(40) NULL,
    [drvAccAmount] varchar(1) NOT NULL,
    [drvAccEffDate] datetime NULL,
    [drvAccTermDate] datetime NULL,
    [drvCritPlanName] varchar(40) NULL,
    [drvCritAmount] varchar(1) NOT NULL,
    [drvCritEffDate] datetime NULL,
    [drvCritTermDate] datetime NULL,
    [drvHospPlanName] varchar(1) NOT NULL,
    [drvHospAmount] varchar(1) NOT NULL,
    [drvHospEffDate] int NULL,
    [drvHospTermDate] int NULL,
    [drvBAPlanName] varchar(40) NULL,
    [drvBAAmount] varchar(30) NULL,
    [drvBAEffDate] datetime NULL,
    [drvBATermDate] datetime NULL,
    [drvVADPlanName] varchar(40) NULL,
    [drvVADAmount] varchar(30) NULL,
    [drvVADEffDate] datetime NULL,
    [drvVADTermDate] datetime NULL
);
IF OBJECT_ID('U_EHJYELTEST_EEList') IS NULL
CREATE TABLE [dbo].[U_EHJYELTEST_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EHJYELTEST_File') IS NULL
CREATE TABLE [dbo].[U_EHJYELTEST_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHJYELTEST]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Upbring

Created By: Ashley Schaeffer
Business Analyst: Michael Christopher
Create Date: 10/13/2020
Service Request Number: UPB1000-2020-00288485

Purpose: HealthJoy Eligibility Export

Revision History
----------------
08/09/2021 by AP:
        - Update to original EHJYELGUPB.
        - Modified JOINS to use the DedDedTypes required along with other updates required.

09/03/2021 by AP:
		- Updated mapping config to use DedTypes rather than DedCodes.
		- Removed the UpdDedType config. GTL types are not showing as "GTL" in DedDedType, they are showing as "UP" OR "UPA".

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHJYELTEST';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHJYELTEST';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHJYELTEST';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHJYELTEST';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHJYELTEST' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJYELTEST', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJYELTEST', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJYELTEST', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJYELTEST', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJYELTEST', 'SCH_EHJYEL';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHJYELTEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EHJYELTEST', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@MinCovDate        DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EHJYELTEST';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@MinCovDate      = CONCAT(LEFT(EndPerControl,4),'0101')

    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EHJYELTEST_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHJYELTEST_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --Excluded employees
    DELETE dbo.U_EHJYELTEST_EEList
    FROM dbo.U_EHJYELTEST_EEList
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    WHERE EecEEType IN ('PRN','INT','CTR','PTB','TES')
        OR EepNameLast = 'TestUPBG'
    ;

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
   -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','DPL,DPL2,DPH,DPH2,MPB,MPB2,MPC,MPC2,STD,LTD,VA,VP,VP2,L,J,JC,JS,FSA,UP,UPA,VAD');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedTypes','MED,DEN,VIS,OPT,STD,LTD,LTC,DRG,FSA,GTL,UP,UPA,ADD,OT1');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'UpdDedType','GTL');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ExclFutureDatedStartDates','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ExclFutureDatedStopDates','Y');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    
    --Run Calculations
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --Update benefits amount to calculation
    UPDATE dbo.U_dsi_bdm_EmpDeductions
    SET EedbenAmt = BcaBenAmtCalc
    
    FROM dbo.U_dsi_bdm_EmpDeductions
    JOIN dbo.u_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
        ON EedEEID = bcaEEID
        AND EedCOID = bcaCOID
        AND EedFormatCode = bcaFormatCode 
        AND EedDedCode = bcaDedCode
    WHERE EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y';

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHJYELTEST_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHJYELTEST_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHJYELTEST_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        ,drvSubSort = '1'
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvEmployerID = SUBSTRING(EepSSN,1,3)+'-'+SUBSTRING(EepSSN,4,2)+'-'+SUBSTRING(EepSSN,6,4)
        ,drvStartDate = EecDateOfLastHire
        ,drvEmplStatus = EecEmplStatus
        ,drvEmplTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvCobraStartDate = NULL
        ,drvCobraTermDate = NULL
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = REPLACE(EepNameLast,',','')
        ,drvSSN = SUBSTRING(EepSSN,1,3)+'-'+SUBSTRING(EepSSN,4,2)+'-'+SUBSTRING(EepSSN,6,4)
        ,drvRelationship = 'Employee'
        ,drvEmail = EepAddressEMail
        ,drvPhoneMobile = EfoPhoneNumber
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvAddressLine1 = REPLACE(EepAddressLine1,',','')
        ,drvAddressLine2 = REPLACE(EepAddressLine2,',','')
        ,drvAddressCity = REPLACE(EepAddressCity,',','')
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvBenefitClass = ''
        ,drvDivision = ''
        ,drvMedPlanName = MED.DedLongDesc
        ,drvMedGroupID = ''
        ,drvMedEffDate = CASE WHEN MED.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, MED.EedBenStartDate) END
        ,drvMedTermDate = MED.EedBenStopDate
        ,drvDenPlanName = DEN.DedLongDesc
        ,drvDenGroupID = ''
        ,drvDenEffDate = CASE WHEN DEN.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, DEN.EedBenStartDate) END
        ,drvDenTermDate = DEN.EedBenStopDate
        ,drvVisPlanName = VIS.DedLongDesc
        ,drvVisGroupID = ''
        ,drvVisEffDate = CASE WHEN DEN.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, VIS.EedBenStartDate) END
        ,drvVisTermDate = VIS.EedBenStopDate
        ,drvBLPlanName = BL.DedLongDesc
        ,drvBLAmount = ''    --CONVERT(VARCHAR, BL.EedBenAmt)
        ,drvBLEffDate = CASE WHEN BL.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, BL.EedBenStartDate) END
        ,drvBLTermDate = BL.EedBenStopDate
        ,drvOLPlanName = OL.DedLongDesc
        ,drvOLAmount = CONVERT(VARCHAR, OL.EedBenAmt)
        ,drvOLEffDate = CASE WHEN OL.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, OL.EedBenStartDate) END
        ,drvOLTermDate = OL.EedBenStopDate
        ,drvLTDPlanName = LTD.DedLongDesc
        ,drvLTDAmount = CONVERT(VARCHAR, LTD.EedBenAmt)
        ,drvLTDEffDate = CASE WHEN LTD.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, LTD.EedBenStartDate) END
        ,drvLTDTermDate = LTD.EedBenStopDate
        ,drvSTDPlanName = STD.DedLongDesc
        ,drvSTDAmount = CONVERT(VARCHAR, STD.EedBenAmt)
        ,drvSTDEffDate = CASE WHEN STD.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, STD.EedBenStartDate) END
        ,drvSTDTermDate = STD.EedBenStopDate
        ,drvFSAPlanName = FSA.DedLongDesc
        ,drvFSAGoalAmt = CONVERT(VARCHAR, FSA.EedEEGoalAmt)
        ,drvFSAEffDate = CASE WHEN FSA.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, FSA.EedBenStartDate) END
        ,drvFSATermDate = FSA.EedBenStopDate
        ,drvDCAPlanName = ''
        ,drvDCAGoalAmt = ''
        ,drvDCAEffDate = NULL
        ,drvDCATermDate = NULL
        ,drvHSAPlanName = ''
        ,drvHSAGoalAmt = ''
        ,drvHSAEffDate = NULL
        ,drvHSATermDate = NULL
        ,drvAccPlanName = ACC.DedLongDesc
        ,drvAccAmount = ''
        ,drvAccEffDate = ACC.EedBenStartDate
        ,drvAccTermDate = ACC.EedBenStopDate
        ,drvCritPlanName = CRIT.DedLongDesc
        ,drvCritAmount = ''    --10/28/2020 Michael confirmed we are not sending critical illness amounts
                            --CONVERT(VARCHAR, CRIT.EedBenAmt)
        ,drvCritEffDate = CASE WHEN CRIT.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, CRIT.EedBenStartDate) END
        ,drvCritTermDate = CRIT.EedBenStopDate
        ,drvHospPlanName = ''
        ,drvHospAmount = ''
        ,drvHospEffDate = NULL
        ,drvHospTermDate = NULL
        ,drvBAPlanName = BA.DedLongDesc
        ,drvBAAmount = CONVERT(VARCHAR, BA.EedBenAmt)
        ,drvBAEffDate = CASE WHEN BA.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, BA.EedBenStartDate) END
        ,drvBATermDate = BA.EedBenStopDate
        ,drvVADPlanName = VAD.DedLongDesc
        ,drvVADAmount = CONVERT(VARCHAR, VAD.EedBenAmt)
        ,drvVADEffDate = CASE WHEN VAD.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, VAD.EedBenStartDate) END
        ,drvVADTermDate = VAD.EedBenStopDate

    INTO dbo.U_EHJYELTEST_drvTbl
    FROM dbo.U_EHJYELTEST_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions BDM WITH (NOLOCK)
        ON BDM.EedEEID = xEEID 
        AND BDM.EedCoID = xCoID
        AND BDM.EedFormatCode = @FormatCode 
        AND BDM.EedValidForExport = 'Y'
        --Only include people on file who are enrolled in medical
        --AND BDM.EedDedCode IN ('MPB','MPB2','MPC','MPC2')
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions MED WITH (NOLOCK)
        ON MED.EedEEID = xEEID 
        AND MED.EedCoID = xCoID
        AND MED.EedFormatCode = @FormatCode 
        AND MED.EedValidForExport = 'Y'
      --  AND MED.EedDedCode IN ('MPB','MPB2','MPC','MPC2')
        AND MED.DedDedType = 'MED'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions DEN WITH (NOLOCK)
        ON DEN.EedEEID = xEEID 
        AND DEN.EedCoID = xCoID
        AND DEN.EedFormatCode = @FormatCode 
        AND DEN.EedValidForExport = 'Y'
      --  AND DEN.EedDedCode IN ('DPL','DPL2','DPH','DPH2')
        AND DEN.DedDedType = 'DEN'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions VIS WITH (NOLOCK)
        ON VIS.EedEEID = xEEID 
        AND VIS.EedCoID = xCoID
        AND VIS.EedFormatCode = @FormatCode 
        AND VIS.EedValidForExport = 'Y'
        --AND VIS.EedDedCode IN ('VA','VP','VP2')
        AND VIS.DedDedType = 'VIS'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions OL WITH (NOLOCK)
        ON OL.EedEEID = xEEID 
        AND OL.EedCoID = xCoID
        AND OL.EedFormatCode = @FormatCode 
        AND OL.EedValidForExport = 'Y'
        --AND OL.EedDedCode IN ('J')
        AND OL.DedDedType = 'OPT'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions STD WITH (NOLOCK)
        ON STD.EedEEID = xEEID 
        AND STD.EedCoID = xCoID
        AND STD.EedFormatCode = @FormatCode 
        AND STD.EedValidForExport = 'Y'
       -- AND STD.EedDedCode IN ('STD')
       AND STD.DedDedType = 'STD'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions LTD WITH (NOLOCK)
        ON LTD.EedEEID = xEEID 
        AND LTD.EedCoID = xCoID
        AND LTD.EedFormatCode = @FormatCode 
        AND LTD.EedValidForExport = 'Y'
     --   AND LTD.EedDedCode IN ('LTD')
        AND LTD.DedDedType = 'LTD'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions CRIT WITH (NOLOCK)
        ON CRIT.EedEEID = xEEID 
        AND CRIT.EedCoID = xCoID
        AND CRIT.EedFormatCode = @FormatCode 
        AND CRIT.EedValidForExport = 'Y'
      --  AND CRIT.EedDedCode IN ('L')
        AND CRIT.DedDedType IN ('LTC', 'DRG')
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions FSA WITH (NOLOCK)
        ON FSA.EedEEID = xEEID 
        AND FSA.EedCoID = xCoID
        AND FSA.EedFormatCode = @FormatCode 
        AND FSA.EedValidForExport = 'Y'
        AND FSA.EedDedCode IN ('FSA')
        AND FSA.DedDedType = 'FSA'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions BL WITH (NOLOCK)
        ON BL.EedEEID = xEEID 
        AND BL.EedCoID = xCoID
        AND BL.EedFormatCode = @FormatCode 
        AND BL.EedValidForExport = 'Y'
        AND BL.EedDedCode IN ('UP')
        AND BL.DedDedType = 'GTL'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions BA WITH (NOLOCK)
        ON BA.EedEEID = xEEID 
        AND BA.EedCoID = xCoID
        AND BA.EedFormatCode = @FormatCode 
        AND BA.EedValidForExport = 'Y'
        AND BA.EedDedCode IN ('UPA')
        AND BA.DedDedType = 'GTL'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions VAD WITH (NOLOCK)
        ON VAD.EedEEID = xEEID 
        AND VAD.EedCoID = xCoID
        AND VAD.EedFormatCode = @FormatCode 
        AND VAD.EedValidForExport = 'Y'
       -- AND VAD.EedDedCode IN ('VAD')
        AND VAD.DedDedType = 'ADD'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions ACC WITH (NOLOCK)
        ON ACC.EedEEID = xEEID
        AND ACC.EedCOID = xCOID
        AND ACC.EedFormatCode = @FormatCode
        AND ACC.EedValidForExport = 'Y'
        AND ACC.DedDedType = 'OT1' -- Accident Plan
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON EfoEEID = xEEID
        AND EfoPhoneType = 'CEL'
    ;

--Dependent Records
    INSERT INTO dbo.U_EHJYELTEST_drvTbl
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),ConSystemID) --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        ,drvSubSort =    CASE
                        WHEN ConRelationship IN ('SPS','DP') THEN '2'
                        ELSE '3'
                        END
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvEmployerID = SUBSTRING(EepSSN,1,3)+'-'+SUBSTRING(EepSSN,4,2)+'-'+SUBSTRING(EepSSN,6,4)
        ,drvStartDate = NULL
        ,drvEmplStatus = ''
        ,drvEmplTermDate = NULL
        ,drvCobraStartDate = NULL
        ,drvCobraTermDate = NULL
        ,drvNameFirst = ConNameFirst
        ,drvNameLast = REPLACE(ConNameLast,',','')
        ,drvSSN = SUBSTRING(ConSSN,1,3)+'-'+SUBSTRING(ConSSN,4,2)+'-'+SUBSTRING(ConSSN,6,4)
        ,drvRelationship =    CASE
                            WHEN ConRelationship IN ('SPS','DP') THEN 'Spouse'
                            ELSE 'Child'
                            END
        ,drvEmail = ConEmailAddr
        ,drvPhoneMobile = CASE WHEN ConPhoneOtherType = 'CEL' THEN ConPhoneOtherNumber END
        ,drvDateOfBirth = ConDateOfBirth
        ,drvGender = ConGender
        ,drvAddressLine1 = ConAddressLine1
        ,drvAddressLine2 = ConAddressLine2
        ,drvAddressCity = ConAddressCity
        ,drvAddressState = ConAddressState
        ,drvAddressZipCode = ConAddressZipCode
        ,drvBenefitClass = ''
        ,drvDivision = ''
        ,drvMedPlanName = MED.DedLongDesc
        ,drvMedGroupID = ''
        ,drvMedEffDate = CASE WHEN MED.DbnDepRecID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, MED.DbnBenStartDate) END
        ,drvMedTermDate = MED.DbnBenStopDate
        ,drvDenPlanName = DEN.DedLongDesc
        ,drvDenGroupID = ''
        ,drvDenEffDate = CASE WHEN DEN.DbnDepRecID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, DEN.DbnBenStartDate) END
        ,drvDenTermDate = DEN.DbnBenStopDate
        ,drvVisPlanName = VIS.DedLongDesc
        ,drvVisGroupID = ''
        ,drvVisEffDate = CASE WHEN VIS.DbnDepRecID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, VIS.DbnBenStartDate) END
        ,drvVisTermDate = VIS.DbnBenStopDate
        ,drvBLPlanName = ''
        ,drvBLAmount = ''
        ,drvBLEffDate = NULL
        ,drvBLTermDate = NULL
        ,drvOLPlanName = OL.DedLongDesc
        ,drvOLAmount = CONVERT(VARCHAR, OLAMT.EedBenAmt)
        ,drvOLEffDate = CASE WHEN OL.DbnDepRecID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, OL.DbnBenStartDate) END
        ,drvOLTermDate = OL.DbnBenStopDate
        ,drvLTDPlanName = ''
        ,drvLTDAmount = ''
        ,drvLTDEffDate = NULL
        ,drvLTDTermDate = NULL
        ,drvSTDPlanName = ''
        ,drvSTDAmount = ''
        ,drvSTDEffDate = NULL
        ,drvSTDTermDate = NULL
        ,drvFSAPlanName = ''
        ,drvFSAGoalAmt = ''
        ,drvFSAEffDate = NULL
        ,drvFSATermDate = NULL
        ,drvDCAPlanName = ''
        ,drvDCAGoalAmt = ''
        ,drvDCAEffDate = NULL
        ,drvDCATermDate = NULL
        ,drvHSAPlanName = ''
        ,drvHSAGoalAmt = ''
        ,drvHSAEffDate = NULL
        ,drvHSATermDate = NULL
        ,drvAccPlanName = ''
        ,drvAccAmount = ''
        ,drvAccEffDate = NULL
        ,drvAccTermDate = NULL
        ,drvCritPlanName = CRIT.DedLongDesc
        ,drvCritAmount = ''    --CONVERT(VARCHAR, CRITAMT.EedBenAmt)
        ,drvCritEffDate = CASE WHEN CRIT.DbnDepRecID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, CRIT.DbnBenStartDate) END
        ,drvCritTermDate = CRIT.DbnBenStopDate
        ,drvHospPlanName = ''
        ,drvHospAmount = ''
        ,drvHospEffDate = NULL
        ,drvHospTermDate = NULL
        ,drvBAPlanName = ''
        ,drvBAAmount = ''
        ,drvBAEffDate = NULL
        ,drvBATermDate = NULL
        ,drvVADPlanName = ''
        ,drvVADAmount = ''
        ,drvVADEffDate = NULL
        ,drvVADTermDate = NULL

    FROM dbo.U_EHJYELTEST_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_DepDeductions BDM WITH (NOLOCK)
        ON BDM.DbnEEID = xEEID 
        AND BDM.DbnCoID = xCoID
        AND BDM.DbnFormatCode = @FormatCode 
        AND BDM.DbnValidForExport = 'Y'
        --Only include people on file who are enrolled in medical
        AND BDM.DbnDedCode IN ('MPB','MPB2','MPC','MPC2')
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConSystemID = BDM.DbnDepRecID
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions MED WITH (NOLOCK)
        ON MED.DbnEEID = xEEID 
        AND MED.DbnCoID = xCoID
        AND MED.DbnFormatCode = @FormatCode 
        AND MED.DbnValidForExport = 'Y'
       -- AND MED.DbnDedCode IN ('MPB','MPB2','MPC','MPC2')
        AND MED.DedDedType = 'MED'
        AND MED.DbnDepRecID = ConSystemID
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions DEN WITH (NOLOCK)
        ON DEN.DbnEEID = xEEID 
        AND DEN.DbnCoID = xCoID
        AND DEN.DbnFormatCode = @FormatCode 
        AND DEN.DbnValidForExport = 'Y'
        --AND DEN.DbnDedCode IN ('DPL','DPL2','DPH','DPH2')
        AND DEN.DedDedType = 'DEN'
        AND DEN.DbnDepRecID = ConSystemID
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions VIS WITH (NOLOCK)
        ON VIS.DbnEEID = xEEID 
        AND VIS.DbnCoID = xCoID
        AND VIS.DbnFormatCode = @FormatCode 
        AND VIS.DbnValidForExport = 'Y'
        --AND VIS.DbnDedCode IN ('VA','VP','VP2')
        AND VIS.DedDedType = 'VIS'
        AND VIS.DbnDepRecID = ConSystemID
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions OL WITH (NOLOCK)
        ON OL.DbnEEID = xEEID 
        AND OL.DbnCoID = xCoID
        AND OL.DbnFormatCode = @FormatCode 
        AND OL.DbnValidForExport = 'Y'
        --AND OL.DbnDedCode IN ('JC','JS')
        AND OL.DedDedType IN ('OPC', 'OPS')
        AND OL.DbnDepRecID = ConSystemID
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions OLAMT WITH (NOLOCK)
        ON OLAMT.EedEEID = xEEID 
        AND OLAMT.EedCoID = xCoID
        AND OLAMT.EedFormatCode = @FormatCode 
        AND OLAMT.EedValidForExport = 'Y'
        AND OLAMT.EedDedCode IN ('JC','JS')
        AND OLAMT.EedDedCode = OL.DbnDedCode
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions CRIT WITH (NOLOCK)
        ON CRIT.DbnEEID = xEEID 
        AND CRIT.DbnCoID = xCoID
        AND CRIT.DbnFormatCode = @FormatCode 
        AND CRIT.DbnValidForExport = 'Y'
        --AND CRIT.DbnDedCode IN ('L')
        AND CRIT.DedDedType IN ('LTC', 'DRG')
        AND CRIT.DbnDepRecID = ConSystemID
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions CRITAMT WITH (NOLOCK)
        ON CRITAMT.EedEEID = xEEID 
        AND CRITAMT.EedCoID = xCoID
        AND CRITAMT.EedFormatCode = @FormatCode 
        AND CRITAMT.EedValidForExport = 'Y'
        AND CRITAMT.EedDedCode IN ('JC','JS')
        AND CRITAMT.EedDedCode = CRIT.DbnDedCode
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
ALTER VIEW dbo.dsi_vwEHJYELTEST_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHJYELTEST_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHJYELTEST%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202010061'
       ,expStartPerControl     = '202010061'
       ,expLastEndPerControl   = '202010139'
       ,expEndPerControl       = '202010139'
WHERE expFormatCode = 'EHJYELTEST';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHJYELTEST_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHJYELTEST_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2