SET NOCOUNT ON;
IF OBJECT_ID('U_EHLTHJOY_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHLTHJOY_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EHLTHJOY_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EHLTHJOY' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEHLTHJOY_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHLTHJOY_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHLTHJOY') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHLTHJOY];
GO
IF OBJECT_ID('U_EHLTHJOY_File') IS NOT NULL DROP TABLE [dbo].[U_EHLTHJOY_File];
GO
IF OBJECT_ID('U_EHLTHJOY_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHLTHJOY_EEList];
GO
IF OBJECT_ID('U_EHLTHJOY_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHLTHJOY_drvTbl];
GO
IF OBJECT_ID('U_EHLTHJOY_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHLTHJOY_DedList];
GO
IF OBJECT_ID('U_EHLTHJOY_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EHLTHJOY_AuditFields];
GO
IF OBJECT_ID('U_EHLTHJOY_Audit') IS NOT NULL DROP TABLE [dbo].[U_EHLTHJOY_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EHLTHJOY';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EHLTHJOY';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EHLTHJOY';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EHLTHJOY';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EHLTHJOY';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHLTHJOY','Health Joy','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EHLTHJOY00Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EHLTHJOY' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','1','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','1',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Start Date"','2','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','2',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','3','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','3',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Termination Date"','4','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','4',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COBRA Start Date"','5','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','5',NULL,'COBRA Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COBRA Termination Date"','6','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','6',NULL,'COBRA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','7','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','8','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','8',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number"','9','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','9',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship"','10','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','10',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email"','11','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','11',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mobile Number"','12','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','12',NULL,'Mobile Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','13','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','13',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','14','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','14',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','15','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','15',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','16','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','16',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','17','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','18','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','18',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','19','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','19',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Class"','20','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','20',NULL,'Benefit Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','21','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','21',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Insurance Plan Name"','22','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','22',NULL,'Medical Insurance Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Group ID"','23','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','23',NULL,'Medical Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Plan Effective Date"','24','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','24',NULL,'Medical Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Plan Termination Date"','25','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','25',NULL,'Medical Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Insurance Plan Name"','26','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','26',NULL,'Dental Insurance Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Group ID"','27','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','27',NULL,'Dental Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Plan Effective Date"','28','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','28',NULL,'Dental Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Plan Termination Date"','29','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','29',NULL,'Dental Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Insurance Plan Name"','30','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','30',NULL,'Vision Insurance Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Group ID"','31','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','31',NULL,'Vision Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Plan Effective Date"','32','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','32',NULL,'Vision Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Plan Termination Date"','33','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','33',NULL,'Vision Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Plan Name"','34','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','34',NULL,'Basic Life Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Policy Amount"','35','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','35',NULL,'Basic Life Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Effective Date"','36','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','36',NULL,'Basic Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Termination Date"','37','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','37',NULL,'Basic Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Life Plan Name"','38','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','38',NULL,'Supplemental Life Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Life Policy Amount"','39','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','39',NULL,'Supplemental Life Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Life Effective Date"','40','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','40',NULL,'Supplemental Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Life Termination Date"','41','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','41',NULL,'Supplemental Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Plan Name"','42','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','42',NULL,'LTD Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Policy Amount"','43','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','43',NULL,'LTD Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Effective Date"','44','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','44',NULL,'LTD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Termination Date"','45','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','45',NULL,'LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Plan Name"','46','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','46',NULL,'STD Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Policy Amount"','47','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','47',NULL,'STD Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Effective Date"','48','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','48',NULL,'STD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Termination Date"','49','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','49',NULL,'STD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Healthcare FSA Plan Name"','50','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','50',NULL,'Healthcare FSA Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Healthcare FSA Goal Amount"','51','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','51',NULL,'Healthcare FSA Goal Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Healthcare FSA Effective Date"','52','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','52',NULL,'Healthcare FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Healthcare FSA Termination Date"','53','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','53',NULL,'Healthcare FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Care FSA Plan Name"','54','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','54',NULL,'Dependent Care FSA Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Care FSA Goal Amount"','55','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','55',NULL,'Dependent Care FSA Goal Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Care FSA Effective Date"','56','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','56',NULL,'Dependent Care FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Care FSA Termination Date"','57','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','57',NULL,'Dependent Care FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HSA Plan Name"','58','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','58',NULL,'HSA Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HSA Goal Amount"','59','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','59',NULL,'HSA Goal Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HSA Effective Date"','60','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','60',NULL,'HSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HSA Termination Date"','61','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','61',NULL,'HSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Plan Name"','62','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','62',NULL,'Accident Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Policy Amount"','63','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','63',NULL,'Accident Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Effective Date"','64','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','64',NULL,'Accident Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Termination Date"','65','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','65',NULL,'Accident Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Plan Name"','66','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','66',NULL,'Critical Illness Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Policy Amount"','67','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','67',NULL,'Critical Illness Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Policy Effective Date"','68','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','68',NULL,'Critical Illness Policy Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Critical Illness Termination Date"','69','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','69',NULL,'Critical Illness Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Indemnity Plan Name"','70','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','70',NULL,'Hospital Indemnity Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Indemnity Policy Amount"','71','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','71',NULL,'Hospital Indemnity Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Indemnity Policy Effective Date"','72','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','72',NULL,'Hospital Indemnity Policy Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Indemnity Termination Date"','73','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','73',NULL,'Hospital Indemnity Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Plan Name 1"','74','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','74',NULL,'Custom Plan Name 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Plan Name 1 Policy Amount"','75','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','75',NULL,'Custom Plan Name 1 Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Plan Name 1 Effective Date"','76','(''DA''=''T,'')','EHLTHJOY00Z0','50','H','01','76',NULL,'Custom Plan Name 1 Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Plan Name 1 Termination Date"','77','(''DA''=''T'')','EHLTHJOY00Z0','50','H','01','77',NULL,'Custom Plan Name 1 Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','1','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','1',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','2','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','2',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplstatus"','3','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','3',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','4','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','4',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','5',NULL,'COBRA Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','6',NULL,'COBRA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','8',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','9','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','9',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','10','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','10',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEMail"','11','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','11',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMobileNumber"','12','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','12',NULL,'Mobile Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','13','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','13',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','14','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','14',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','15','(''UA''=''Q,'')','EHLTHJOY00Z0','50','D','10','15',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','16','(''UA''=''Q,'')','EHLTHJOY00Z0','50','D','10','16',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','17','(''UA''=''Q,'')','EHLTHJOY00Z0','50','D','10','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','18','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','18',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','19','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','19',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','20',NULL,'Benefit Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','21',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedPlan"','22','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','22',NULL,'Medical Insurance Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','23',NULL,'Medical Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedEffDate"','24','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','24',NULL,'Medical Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedPlanTermDate"','25','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','25',NULL,'Medical Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDenPlan"','26','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','26',NULL,'Dental Insurance Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','27',NULL,'Dental Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDenEffDate"','28','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','28',NULL,'Dental Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDenPlanTermDate"','29','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','29',NULL,'Dental Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisPlan"','30','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','30',NULL,'Vision Insurance Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','31',NULL,'Vision Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisEffDate"','32','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','32',NULL,'Vision Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisPlanTermDate"','33','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','33',NULL,'Vision Plan Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','34',NULL,'Basic Life Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','35',NULL,'Basic Life Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','36',NULL,'Basic Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','37',NULL,'Basic Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','38',NULL,'Supplemental Life Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','39',NULL,'Supplemental Life Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','40',NULL,'Supplemental Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','41',NULL,'Supplemental Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','42',NULL,'LTD Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','43',NULL,'LTD Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','44',NULL,'LTD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','45',NULL,'LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','46',NULL,'STD Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','47',NULL,'STD Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','48',NULL,'STD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','49',NULL,'STD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHFSAPlan"','50','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','50',NULL,'Healthcare FSA Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHFSAGoalAmount"','51','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','51',NULL,'Healthcare FSA Goal Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHFSAPlanDate"','52','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','52',NULL,'Healthcare FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHFSAPlanTermDate"','53','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','53',NULL,'Healthcare FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFSAPlan"','54','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','54',NULL,'Dependent Care FSA Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFSAGoalAmt"','55','(''UA''=''T,'')','EHLTHJOY00Z0','50','D','10','55',NULL,'Dependent Care FSA Goal Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFSAPlanDate"','56','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','56',NULL,'Dependent Care FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFSAPlanTermDate"','57','(''UD101''=''T,'')','EHLTHJOY00Z0','50','D','10','57',NULL,'Dependent Care FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','58',NULL,'HSA Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','59',NULL,'HSA Goal Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','60',NULL,'HSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','61',NULL,'HSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','62',NULL,'Accident Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','63',NULL,'Accident Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','64',NULL,'Accident Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','65',NULL,'Accident Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','66',NULL,'Critical Illness Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','67',NULL,'Critical Illness Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','68',NULL,'Critical Illness Policy Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','69',NULL,'Critical Illness Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','70',NULL,'Hospital Indemnity Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','71',NULL,'Hospital Indemnity Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','72',NULL,'Hospital Indemnity Policy Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','73',NULL,'Hospital Indemnity Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','74',NULL,'Custom Plan Name 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','75',NULL,'Custom Plan Name 1 Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''SS''=''T,'')','EHLTHJOY00Z0','50','D','10','76',NULL,'Custom Plan Name 1 Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''SS''=''T'')','EHLTHJOY00Z0','50','D','10','77',NULL,'Custom Plan Name 1 Termination Date',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EHLTHJOY_20210625.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202106229','EMPEXPORT','OEACTIVE',NULL,'EHLTHJOY',NULL,NULL,NULL,'202106229','Jun 22 2021  1:24PM','Jun 22 2021  1:24PM','202106221',NULL,'','','202106221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202106229','EMPEXPORT','OEPASSIVE',NULL,'EHLTHJOY',NULL,NULL,NULL,'202106229','Jun 22 2021  1:24PM','Jun 22 2021  1:24PM','202106221',NULL,'','','202106221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Health Joy','202106229','EMPEXPORT','ONDEM_XOE',NULL,'EHLTHJOY',NULL,NULL,NULL,'202106229','Jun 22 2021  1:24PM','Jun 22 2021  1:24PM','202106221',NULL,'','','202106221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Health Joy-Sched','202106229','EMPEXPORT','SCH_EHLTHJ',NULL,'EHLTHJOY',NULL,NULL,NULL,'202106229','Jun 22 2021  1:24PM','Jun 22 2021  1:24PM','202106221',NULL,'','','202106221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Health Joy-Test','202106241','EMPEXPORT','TEST_XOE','Jun 24 2021 12:00AM','EHLTHJOY',NULL,NULL,NULL,'202106241','Jun 24 2021 12:00AM','Dec 30 1899 12:00AM','202106101','24442','','','202106101',dbo.fn_GetTimedKey(),NULL,'CPETITTI20',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHJOY','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHJOY','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHJOY','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHJOY','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHJOY','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTHJOY','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EHLTHJOY' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EHLTHJOY' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EHLTHJOY_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHLTHJOY_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHLTHJOY','D10','dbo.U_EHLTHJOY_drvTbl',NULL);
IF OBJECT_ID('U_EHLTHJOY_Audit') IS NULL
CREATE TABLE [dbo].[U_EHLTHJOY_Audit] (
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
IF OBJECT_ID('U_EHLTHJOY_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EHLTHJOY_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EHLTHJOY_DedList') IS NULL
CREATE TABLE [dbo].[U_EHLTHJOY_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
); 
IF OBJECT_ID('U_EHLTHJOY_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHLTHJOY_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(21) NULL,
    [drvEmpNo] char(9) NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvEmplstatus] char(1) NULL,
    [drvDateOfTermination] datetime NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvSSN] varchar(11) NULL,
    [drvRelationship] varchar(8) NOT NULL,
    [drvAddressEMail] varchar(50) NULL,
    [drvMobileNumber] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvMedPlan] varchar(21) NULL,
    [drvMedEffDate] datetime NULL,
    [drvMedPlanTermDate] datetime NULL,
    [drvDenPlan] varchar(20) NULL,
    [drvDenEffDate] datetime NULL,
    [drvDenPlanTermDate] datetime NULL,
    [drvVisPlan] varchar(12) NULL,
    [drvVisEffDate] datetime NULL,
    [drvVisPlanTermDate] datetime NULL,
    [drvHFSAPlan] varchar(27) NULL,
    [drvHFSAGoalAmount] varchar(10) NULL,
    [drvHFSAPlanDate] datetime NULL,
    [drvHFSAPlanTermDate] datetime NULL,
    [drvDepFSAPlan] varchar(18) NULL,
    [drvDepFSAGoalAmt] varchar(10) NULL,
    [drvDepFSAPlanDate] datetime NULL,
    [drvDepFSAPlanTermDate] datetime NULL
);

IF OBJECT_ID('U_EHLTHJOY_EEList') IS NULL
CREATE TABLE [dbo].[U_EHLTHJOY_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EHLTHJOY_File') IS NULL
CREATE TABLE [dbo].[U_EHLTHJOY_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHLTHJOY]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Hosptial Housekeeping Systems

Created By: Keary McCutchen
Business Analyst: Cheryl Petitti
Create Date: 06/18/2021
Service Request Number: TekP-2021-03-30-0003 / SR-2021-00312433


Purpose: Health Joy

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHLTHJOY';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHLTHJOY';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHLTHJOY';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHLTHJOY';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHLTHJOY' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTHJOY', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTHJOY', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTHJOY', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTHJOY', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTHJOY', 'SCH_EHLTHJ';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHLTHJOY';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EHLTHJOY', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate        DATETIME;
            ;

    -- Set FormatCode
    SELECT @FormatCode = 'EHLTHJOY';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = '20210101'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EHLTHJOY_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHLTHJOY_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

     --==========================================
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_EHLTHJOY_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EHLTHJOY_AuditFields;
    CREATE TABLE dbo.U_EHLTHJOY_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_EHLTHJOY_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EHLTHJOY_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHLTHJOY_Audit;
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
    INTO dbo.U_EHLTHJOY_Audit
    FROM dbo.U_EHLTHJOY_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_EHLTHJOY_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') = 'T'
    ;

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EHLTHJOY_Audit ON dbo.U_EHLTHJOY_Audit (audCOID, audEEID);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MED1, MED2, DEN1, DEN2, VPP, FSA, DCA';

    IF OBJECT_ID('U_EHLTHJOY_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHLTHJOY_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHLTHJOY_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes', @DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
         

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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHLTHJOY_drvTbl
    -- Employee Detail
    ---------------------------------
    IF OBJECT_ID('U_EHLTHJOY_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHLTHJOY_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = EecEmpNo + CONVERT(varchar(12),'1')
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvEmplstatus = EecEmplStatus
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = REPLACE(EepNameLast,',',' ')
        ,drvSSN =  SUBSTRING(eepSSN, 1, 3) + '-' + SUBSTRING(eepSSN, 4, 2) + '-' + SUBSTRING(eepSSN, 6,4) 
        ,drvRelationship = 'Employee' 
        ,drvAddressEMail = EepAddressEMail
        ,drvMobileNumber = EfoPhoneNumber
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender =  CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'X' END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvMedPlan = EedMedPlan
        ,drvMedEffDate = EedMedEffDate
        ,drvMedPlanTermDate = EedMedPlanTermDate
        ,drvDenPlan = EedDenPlan
        ,drvDenEffDate = EedDenEffDate
        ,drvDenPlanTermDate = EedDenPlanTermDate
        ,drvVisPlan = EedVisPlan
        ,drvVisEffDate = EedVisEffDate
        ,drvVisPlanTermDate = EedVisPlanTermDate
        ,drvHFSAPlan = EedHFSAPlan
        ,drvHFSAGoalAmount = CASE WHEN EedHFSAGoalAmount = 0 THEN NULL ELSE CONVERT(VARCHAR,EedHFSAGoalAmount) END
        ,drvHFSAPlanDate = EedHFSAPlanDate
        ,drvHFSAPlanTermDate = EedHFSAPlanTermDate
        ,drvDepFSAPlan = EedDepFSAPlan
        ,drvDepFSAGoalAmt = CASE WHEN EedDepFSAGoalAmt = 0 THEN NULL ELSE CONVERT(VARCHAR,EedDepFSAGoalAmt) END
        ,drvDepFSAPlanDate = EedDepFSAPlanDate
        ,drvDepFSAPlanTermDate = EedDepFSAPlanTermDate
    INTO dbo.U_EHLTHJOY_drvTbl
    FROM dbo.U_EHLTHJOY_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
       AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT
    JOIN (SELECT EedEEID, EedCOID
                ,EedMedPlan = MAX(CASE WHEN EedDedCode = 'MED1' THEN 'UMR Choice Plus Buyup'
                                   WHEN EedDedCode = 'MED2' THEN 'UMR Choice Plus Core'
                               END)
                ,EedMedEffDate = MAX(CASE WHEN EedDedCode IN ('MED1','MED2') THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate, @FileMinCovDate) END)
                ,EedMedPlanTermDate = MAX(CASE WHEN EedDedCode IN ('MED1','MED2') THEN EedBenStopDate END)
                ,EedDenPlan = MAX(CASE WHEN EedDedCode = 'DEN1' THEN 'Gaurdian Dental Low'
                                   WHEN EedDedCode = 'DEN2' THEN 'Guardian Dental High'
                               END)
                ,EedDenEffDate = MAX(CASE WHEN EedDedCode IN ('DEN1','DEN2') THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate, @FileMinCovDate) END)
                ,EedDenPlanTermDate = MAX(CASE WHEN EedDedCode IN ('DEN1','DEN2') THEN EedBenStopDate END)
                ,EedVisPlan = MAX(CASE WHEN EedDedCode = 'VPP' THEN 'Davis Vision' END)
                ,EedVisEffDate = MAX(CASE WHEN EedDedCode = 'VPP' THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate, @FileMinCovDate) END)
                ,EedVisPlanTermDate = MAX(CASE WHEN EedDedCode = 'VPP' THEN EedBenStopDate END)
                ,EedHFSAPlan = MAX(CASE WHEN EedDedCode = 'FSA' THEN 'FSA Health Spending Account' END)
                ,EedHFSAGoalAmount = SUM(EedEEGoalAmt)
                ,EedHFSAPlanDate = MAX(CASE WHEN EedDedCode = 'FSA' THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate, @FileMinCovDate) END)
                ,EedHFSAPlanTermDate = MAX(CASE WHEN EedDedCode = 'FSA' THEN EedBenStopDate END)
                ,EedDepFSAPlan = MAX(CASE WHEN EedDedCode = 'DCA' THEN 'Dependent Care FSA' END)
                ,EedDepFSAGoalAmt = SUM(EedEEGoalAmt)
                ,EedDepFSAPlanDate = MAX(CASE WHEN EedDedCode = 'DCA' THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate, @FileMinCovDate) END)
                ,EedDepFSAPlanTermDate = MAX(CASE WHEN EedDedCode = 'DCA' THEN EedBenStopDate END)
            FROM dbo.U_dsi_bdm_EmpDeductions 
           WHERE EedFormatCode = @FormatCode 
             AND EedValidForExport = 'Y'
            GROUP BY EedEEID, EedCOID) EED
        ON EedCOID = xCOID 
       AND EedEEID = xEEID
    LEFT 
    JOIN (SELECT TOP 1 EfoEEID, EfoPhoneNumber FROM dbo.EmpMPhon WITH(NOLOCK) 
           WHERE efoPhoneType = 'CEL') AS M 
        ON M.EfoEEID = xEEID
    WHERE EecEEType = 'REG'
       AND (eecemplstatus <> 'T'
       OR (eecemplstatus = 'T' AND EXISTS(SELECT 1 FROM dbo.U_EHLTHJOY_Audit WITH (NOLOCK) WHERE audEEID = xEEID AND audCOID = xcoid ) ))

    ;
     ---------------------------------
    -- DETAIL RECORD - U_EHLTHJOY_drvTbl
    -- Contacts Detail
    ---------------------------------
    INSERT INTO dbo.U_EHLTHJOY_drvTbl
    SELECT DISTINCT
         drvEEID 
        ,drvCoID 
        ,drvDepRecID = CONVERT(varchar(12),ConsystemID) --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort 
        ,drvSubSort = drvEmpNo + CONVERT(varchar(12),ConSystemID) 
        -- standard fields above and additional driver fields below
        ,drvEmpNo 
        ,drvDateOfLastHire
        ,drvEmplstatus 
        ,drvDateOfTermination 
        ,drvNameFirst = ConNameFirst
        ,drvNameLast = REPLACE(ConNameLast,',',' ')
        ,drvSSN =  SUBSTRING(ConSSN, 1, 3) + '-' + SUBSTRING(ConSSN, 4, 2) + '-' + SUBSTRING(ConSSN, 6,4)  
        ,drvRelationship = CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                WHEN ConRelationship IN ('CHL','STC') THEN 'Child'
                                ELSE ConRelationship
                            END
        ,drvAddressEMail
        ,drvMobileNumber
        ,drvDateOfBirth = ConDateOfBirth
        ,drvGender = CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'X' END 
        ,drvAddressLine1
        ,drvAddressLine2
        ,drvAddressCity 
        ,drvAddressState
        ,drvAddressZipCode
        ,drvMedPlan = DbnMedPlan
        ,drvMedEffDate = DbnMedEffDate
        ,drvMedPlanTermDate = DbnMedPlanTermDate
        ,drvDenPlan = DbnDenPlan
        ,drvDenEffDate = DbnDenEffDate
        ,drvDenPlanTermDate = DbnDenPlanTermDate
        ,drvVisPlan = DbnVisPlan
        ,drvVisEffDate = DbnVisEffDate
        ,drvVisPlanTermDate = DbnVisPlanTermDate
        ,drvHFSAPlan = DbnHFSAPlan
        ,drvHFSAGoalAmount = CASE WHEN DbnHFSAGoalAmount = 'Y' THEN drvHFSAGoalAmount END
        ,drvHFSAPlanDate = DbnHFSAPlanDate
        ,drvHFSAPlanTermDate = DbnHFSAPlanTermDate
        ,drvDepFSAPlan = DbnDepFSAPlan
        ,drvDepFSAGoalAmt = CASE WHEN DbnDepFSAGoalAmt = 'Y' THEN drvDepFSAGoalAmt END
        ,drvDepFSAPlanDate = DbnDepFSAPlanDate
        ,drvDepFSAPlanTermDate = DbnDepFSAPlanTermDate
    FROM dbo.U_EHLTHJOY_drvTbl WITH (NOLOCK)
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = drvEEID
    LEFT
    JOIN (SELECT DbnEEID, DbnCOID, DbnDepRecID
                ,DbnMedPlan = MAX(CASE WHEN DbnDedCode = 'MED1' THEN 'UMR Choice Plus Buyup'
                                   WHEN DbnDedCode = 'MED2' THEN 'UMR Choice Plus Core'
                               END)
                ,DbnMedEffDate = MAX(CASE WHEN DbnDedCode IN ('MED1','MED2') THEN dbo.dsi_fnGetMinMaxDates('MAX',DbnBenStartDate, @FileMinCovDate) END)
                ,DbnMedPlanTermDate = MAX(CASE WHEN DbnDedCode IN ('MED1','MED2') THEN DbnBenStopDate END)
                ,DbnDenPlan = MAX(CASE WHEN DbnDedCode = 'DEN1' THEN 'Gaurdian Dental Low'
                                   WHEN DbnDedCode = 'DEN2' THEN 'Guardian Dental High'
                               END)
                ,DbnDenEffDate = MAX(CASE WHEN DbnDedCode IN ('DEN1','DEN2') THEN dbo.dsi_fnGetMinMaxDates('MAX',DbnBenStartDate, @FileMinCovDate) END)
                ,DbnDenPlanTermDate = MAX(CASE WHEN DbnDedCode IN ('DEN1','DEN2') THEN DbnBenStopDate END)
                ,DbnVisPlan = MAX(CASE WHEN DbnDedCode = 'VPP' THEN 'Davis Vision' END)
                ,DbnVisEffDate = MAX(CASE WHEN DbnDedCode = 'VPP' THEN dbo.dsi_fnGetMinMaxDates('MAX',DbnBenStartDate, @FileMinCovDate) END)
                ,DbnVisPlanTermDate = MAX(CASE WHEN DbnDedCode = 'VPP' THEN DbnBenStopDate END)
                ,DbnHFSAPlan = MAX(CASE WHEN DbnDedCode = 'FSA' THEN 'FSA Health Spending Account' END)
                ,DbnHFSAPlanDate = MAX(CASE WHEN DbnDedCode = 'FSA' THEN dbo.dsi_fnGetMinMaxDates('MAX',DbnBenStartDate, @FileMinCovDate) END)
                ,DbnHFSAGoalAmount = MAX(CASE WHEN DbnDedCode = 'FSA' THEN 'Y' END)
                ,DbnHFSAPlanTermDate = MAX(CASE WHEN DbnDedCode = 'FSA' THEN DbnBenStopDate END)
                ,DbnDepFSAPlan = MAX(CASE WHEN DbnDedCode = 'DCA' THEN 'Dependent Care FSA' END)
                ,DbnDepFSAPlanDate = MAX(CASE WHEN DbnDedCode = 'DCA' THEN dbo.dsi_fnGetMinMaxDates('MAX',DbnBenStartDate, @FileMinCovDate) END)
                ,DbnDepFSAPlanTermDate = MAX(CASE WHEN DbnDedCode = 'DCA' THEN DbnBenStopDate END)
                ,DbnDepFSAGoalAmt = MAX(CASE WHEN DbnDedCode = 'DCA' THEN 'Y' END)
            FROM dbo.U_dsi_bdm_DepDeductions 
           WHERE DbnFormatCode = @FormatCode 
             AND DbnValidForExport = 'Y'
            GROUP BY DbnEEID, DbnCOID, DbnDepRecID) Dbn
        ON DbnCOID = drvCOID 
       AND DbnEEID = drvEEID
       AND DbnDepRecID = ConSystemID
       WHERE ConIsDependent='Y'
       AND ConRelationship IN ('SPS','CHL','STC') 
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
ALTER VIEW dbo.dsi_vwEHLTHJOY_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHLTHJOY_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHLTHJOY%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106111'
       ,expStartPerControl     = '202106111'
       ,expLastEndPerControl   = '202106189'
       ,expEndPerControl       = '202106189'
WHERE expFormatCode = 'EHLTHJOY';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHLTHJOY_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHLTHJOY_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2, SubSort3