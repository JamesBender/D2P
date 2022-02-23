SET NOCOUNT ON;
IF OBJECT_ID('U_EALKCBREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EALKCBREXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EALKCBREXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EALKCBREXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEALKCBREXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEALKCBREXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EALKCBREXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EALKCBREXP];
GO
IF OBJECT_ID('U_EALKCBREXP_File') IS NOT NULL DROP TABLE [dbo].[U_EALKCBREXP_File];
GO
IF OBJECT_ID('U_EALKCBREXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EALKCBREXP_EEList];
GO
IF OBJECT_ID('U_EALKCBREXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EALKCBREXP_drvTbl];
GO
IF OBJECT_ID('U_EALKCBREXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EALKCBREXP_DedList];
GO
IF OBJECT_ID('U_EALKCBREXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EALKCBREXP_AuditFields];
GO
IF OBJECT_ID('U_EALKCBREXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EALKCBREXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EALKCBREXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EALKCBREXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EALKCBREXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EALKCBREXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EALKCBREXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EALKCBREXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EALKCBREXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EALKCBREXP','TaxSaver COBRA QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','S','N','EALKCBREXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EALKCBREXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','1','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','2','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','3','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sex"','4','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','4',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','5','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','5',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','6','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','6',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Event Type"','7','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','7',NULL,'Event Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Event Date"','8','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','8',NULL,'Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Enrollment Date"','9','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','9',NULL,'Original Enrollment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AEI Eligible"','10','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','10',NULL,'AEI Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Uses HCTC"','11','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','11',NULL,'Uses HCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 1"','12','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','12',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 2"','13','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','13',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','14','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State or Province"','15','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','15',NULL,'State or Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Postal Code"','16','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','16',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','17','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','17',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Plan"','18','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','18',NULL,'Medical Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Coverage"','19','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','19',NULL,'Medical Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Plan"','20','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','20',NULL,'Dental Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Coverage"','21','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','21',NULL,'Dental Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Plan"','22','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','22',NULL,'Vision Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Coverage"','23','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','23',NULL,'Vision Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EAP Plan"','24','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','24',NULL,'EAP Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EAP Coverage"','25','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','25',NULL,'EAP Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FSA"','26','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','26',NULL,'FSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FSA Contrib"','27','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','27',NULL,'FSA Contrib',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse First"','28','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','28',NULL,'Spouse First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Last"','29','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','29',NULL,'Spouse Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse SSN"','30','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','30',NULL,'Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse DOB"','31','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','31',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH1 First"','32','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','32',NULL,'CH1 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH1 Last"','33','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','33',NULL,'CH1 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH1 SSN"','34','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','34',NULL,'CH1 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH1 DOB"','35','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','35',NULL,'CH1 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH2 First"','36','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','36',NULL,'CH2 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH2 Last"','37','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','37',NULL,'CH2 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH2 SSN"','38','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','38',NULL,'CH2 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH2 DOB"','39','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','39',NULL,'CH2 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH3 First"','40','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','40',NULL,'CH3 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH3 Last"','41','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','41',NULL,'CH3 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH3 SSN"','42','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','42',NULL,'CH3 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH3 DOB"','43','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','43',NULL,'CH3 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH4 First"','44','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','44',NULL,'CH4 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH4 Last"','45','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','45',NULL,'CH4 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH4 SSN"','46','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','46',NULL,'CH4 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH4 DOB"','47','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','47',NULL,'CH4 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH5 First"','48','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','48',NULL,'CH5 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH5 Last"','49','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','49',NULL,'CH5 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH5 SSN"','50','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','50',NULL,'CH5 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH5 DOB"','51','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','51',NULL,'CH5 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH6 First"','52','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','52',NULL,'CH6 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH6 Last"','53','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','53',NULL,'CH6 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH6 SSN"','54','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','54',NULL,'CH6 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH6 DOB"','55','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','55',NULL,'CH6 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH7 First"','56','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','56',NULL,'CH7 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH7 Last"','57','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','57',NULL,'CH7 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH7 SSN"','58','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','58',NULL,'CH7 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH7 DOB"','59','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','59',NULL,'CH7 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH8 First"','60','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','60',NULL,'CH8 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH8 Last"','61','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','61',NULL,'CH8 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH8 SSN"','62','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','62',NULL,'CH8 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH8 DOB"','63','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','63',NULL,'CH8 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH9 First"','64','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','64',NULL,'CH9 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH9 Last"','65','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','65',NULL,'CH9 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH9 SSN"','66','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','66',NULL,'CH9 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH9 DOB"','67','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','67',NULL,'CH9 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH10 First"','68','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','68',NULL,'CH10 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH10 Last"','69','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','69',NULL,'CH10 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH10 SSN"','70','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','70',NULL,'CH10 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH10 DOB"','71','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','71',NULL,'CH10 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH11 First"','72','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','72',NULL,'CH11 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH11 Last"','73','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','73',NULL,'CH11 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH11 SSN"','74','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','74',NULL,'CH11 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH11 DOB"','75','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','75',NULL,'CH11 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH12 First"','76','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','76',NULL,'CH12 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH12 Last"','77','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','77',NULL,'CH12 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH12 SSN"','78','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','78',NULL,'CH12 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH12 DOB"','79','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','79',NULL,'CH12 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','80','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','81','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','82','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sex"','83','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','84','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','85','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','86','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','87','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sex"','88','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','89','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','90','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','91','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','92','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sex"','93','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','94','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','95','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','96','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','97','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sex"','98','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','99','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','100','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','101','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','102','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sex"','103','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','104','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','105','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','106','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','107','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sex"','108','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','109','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','110','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','111','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','112','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sex"','113','(''DA''=''T,'')','EALKCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','114','(''DA''=''T'')','EALKCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','1','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFirstName"','2','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLastName"','3','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSex"','4','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','4',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDOB"','5','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','5',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDivision"','6','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','6',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','7','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','7',NULL,'Event Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','8','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','8',NULL,'Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalEnrollmentDate"','9','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','9',NULL,'Original Enrollment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAEIEligible"','10','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','10',NULL,'AEI Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUsesHCTC"','11','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','11',NULL,'Uses HCTC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','12','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','12',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','13','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','13',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','14','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateorProvince"','15','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','15',NULL,'State or Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','16','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','16',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','17','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','17',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicalPlan"','18','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','18',NULL,'Medical Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicalCoverage"','19','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','19',NULL,'Medical Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalPlan"','20','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','20',NULL,'Dental Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalCoverage"','21','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','21',NULL,'Dental Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisionPlan"','22','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','22',NULL,'Vision Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisionCoverage"','23','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','23',NULL,'Vision Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEAPPlan"','24','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','24',NULL,'EAP Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEAPCoverage"','25','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','25',NULL,'EAP Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSA"','26','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','26',NULL,'FSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAContrib"','27','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','27',NULL,'FSA Contrib',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseFirst"','28','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','28',NULL,'Spouse First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLast"','29','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','29',NULL,'Spouse Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSSN"','30','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','30',NULL,'Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDOB"','31','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','31',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH1First"','32','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','32',NULL,'CH1 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH1Last"','33','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','33',NULL,'CH1 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH1SSN"','34','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','34',NULL,'CH1 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH1DOB"','35','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','35',NULL,'CH1 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH2First"','36','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','36',NULL,'CH2 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH2Last"','37','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','37',NULL,'CH2 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH2SSN"','38','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','38',NULL,'CH2 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH2DOB"','39','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','39',NULL,'CH2 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH3First"','40','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','40',NULL,'CH3 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH3Last"','41','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','41',NULL,'CH3 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH3SSN"','42','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','42',NULL,'CH3 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH3DOB"','43','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','43',NULL,'CH3 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH4First"','44','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','44',NULL,'CH4 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH4Last"','45','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','45',NULL,'CH4 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH4SSN"','46','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','46',NULL,'CH4 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH4DOB"','47','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','47',NULL,'CH4 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH5First"','48','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','48',NULL,'CH5 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH5Last"','49','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','49',NULL,'CH5 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH5SSN"','50','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','50',NULL,'CH5 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH5DOB"','51','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','51',NULL,'CH5 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH6First"','52','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','52',NULL,'CH6 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH6Last"','53','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','53',NULL,'CH6 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH6SSN"','54','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','54',NULL,'CH6 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH6DOB"','55','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','55',NULL,'CH6 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH7First"','56','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','56',NULL,'CH7 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH7Last"','57','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','57',NULL,'CH7 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH7SSN"','58','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','58',NULL,'CH7 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH7DOB"','59','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','59',NULL,'CH7 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH8First"','60','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','60',NULL,'CH8 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH8Last"','61','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','61',NULL,'CH8 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH8SSN"','62','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','62',NULL,'CH8 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH8DOB"','63','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','63',NULL,'CH8 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH9First"','64','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','64',NULL,'CH9 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH9Last"','65','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','65',NULL,'CH9 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH9SSN"','66','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','66',NULL,'CH9 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH9DOB"','67','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','67',NULL,'CH9 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH10First"','68','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','68',NULL,'CH10 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH10Last"','69','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','69',NULL,'CH10 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH10SSN"','70','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','70',NULL,'CH10 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH10DOB"','71','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','71',NULL,'CH10 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH11First"','72','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','72',NULL,'CH11 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH11Last"','73','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','73',NULL,'CH11 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH11SSN"','74','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','74',NULL,'CH11 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH11DOB"','75','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','75',NULL,'CH11 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH12First"','76','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','76',NULL,'CH12 First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH12Last"','77','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','77',NULL,'CH12 Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH12SSN"','78','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','78',NULL,'CH12 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCH12DOB"','79','(''UD110''=''T,'')','EALKCBREXPZ0','50','D','10','79',NULL,'CH12 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSSN"','80','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBFirstName"','81','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBLastName"','82','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSex"','83','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBDOB"','84','(''UD110''=''T'')','EALKCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSSN2"','85','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBFirstName2"','86','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBLastName2"','87','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSex2"','88','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBDOB2"','89','(''UD110''=''T'')','EALKCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSSN3"','90','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBFirstName3"','91','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBLastName3"','92','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSex3"','93','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBDOB3"','94','(''UD110''=''T'')','EALKCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSSN4"','95','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBFirstName4"','96','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBLastName4"','97','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSex4"','98','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBDOB4"','99','(''UD110''=''T'')','EALKCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSSN5"','100','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBFirstName5"','101','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBLastName5"','102','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSex5"','103','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBDOB5"','104','(''UD110''=''T'')','EALKCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSSN6"','105','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBFirstName6"','106','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBLastName6"','107','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSex6"','108','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBDOB6"','109','(''UD110''=''T'')','EALKCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSSN7"','110','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBFirstName7"','111','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBLastName7"','112','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSex7"','113','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBDOB7"','114','(''UD110''=''T'')','EALKCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSSN8"','115','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBFirstName8"','116','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBLastName8"','117','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBSex8"','118','(''UA''=''T,'')','EALKCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPQBDOB8"','119','(''UD110''=''T'')','EALKCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EALKCBREXP_20210127.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TaxSaver COBRA QB Export','202005089','EMPEXPORT','ONDEMAND',NULL,'EALKCBREXP',NULL,NULL,NULL,'202005089','May  8 2020  3:58PM','May  8 2020  3:58PM','202005081',NULL,'','','202005081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','Y23F4,1KHF6,1KHLK,1KHQV,7DO7C,FB4R0',NULL,NULL,NULL,'Scheduled Session','202005199','EMPEXPORT','SCH_TCBRX',NULL,'EALKCBREXP',NULL,NULL,NULL,'202006249','May  8 2020  3:58PM','May  8 2020  3:58PM','202006171',NULL,'','','202005191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202101271','EMPEXPORT','TEST','Jan 27 2021  4:30PM','EALKCBREXP',NULL,NULL,NULL,'202101271','Jan 27 2021 12:00AM','Dec 30 1899 12:00AM','202012011','10','','','202012011',dbo.fn_GetTimedKey(),NULL,'us3mLaALK1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALKCBREXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALKCBREXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALKCBREXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALKCBREXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALKCBREXP','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALKCBREXP','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALKCBREXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EALKCBREXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EALKCBREXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EALKCBREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EALKCBREXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALKCBREXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALKCBREXP','D10','dbo.U_EALKCBREXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EALKCBREXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EALKCBREXP] (
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
IF OBJECT_ID('U_EALKCBREXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EALKCBREXP_Audit] (
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
IF OBJECT_ID('U_EALKCBREXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EALKCBREXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EALKCBREXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EALKCBREXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EALKCBREXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EALKCBREXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEmpSSN] char(11) NULL,
    [drvEmpFirstName] varchar(100) NULL,
    [drvEmpLastName] varchar(100) NULL,
    [drvEmpSex] char(1) NULL,
    [drvEmpDOB] datetime NULL,
    [drvEmpDivision] varchar(1) NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvOriginalEnrollmentDate] datetime NULL,
    [drvAEIEligible] varchar(1) NOT NULL,
    [drvUsesHCTC] varchar(1) NOT NULL,
    [drvAddress1] nvarchar(258) NULL,
    [drvAddress2] nvarchar(258) NULL,
    [drvCity] nvarchar(258) NULL,
    [drvStateorProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] char(3) NULL,
    [drvMedicalPlan] varchar(9) NOT NULL,
    [drvMedicalCoverage] varchar(11) NULL,
    [drvDentalPlan] varchar(20) NOT NULL,
    [drvDentalCoverage] varchar(11) NULL,
    [drvVisionPlan] varchar(11) NOT NULL,
    [Count_SPS] int NULL,
    [Count_CHL] int NULL,
    [Vision_BenOption] char(6) NULL,
    [drvVisionCoverage] varchar(11) NULL,
    [drvEAPPlan] varchar(4) NOT NULL,
    [drvEAPCoverage] varchar(1) NOT NULL,
    [drvFSA] varchar(1) NOT NULL,
    [drvFSAContrib] money NULL,
    [drvSpouseFirst] varchar(100) NULL,
    [drvSpouseLast] varchar(100) NULL,
    [drvSpouseSSN] char(11) NULL,
    [drvSpouseDOB] datetime NULL,
    [drvCH1First] varchar(100) NULL,
    [drvCH1Last] varchar(100) NULL,
    [drvCH1SSN] char(11) NULL,
    [drvCH1DOB] datetime NULL,
    [drvCH2First] varchar(100) NULL,
    [drvCH2Last] varchar(100) NULL,
    [drvCH2SSN] char(11) NULL,
    [drvCH2DOB] datetime NULL,
    [drvCH3First] varchar(100) NULL,
    [drvCH3Last] varchar(100) NULL,
    [drvCH3SSN] char(11) NULL,
    [drvCH3DOB] datetime NULL,
    [drvCH4First] varchar(100) NULL,
    [drvCH4Last] varchar(100) NULL,
    [drvCH4SSN] char(11) NULL,
    [drvCH4DOB] datetime NULL,
    [drvCH5First] varchar(100) NULL,
    [drvCH5Last] varchar(100) NULL,
    [drvCH5SSN] char(11) NULL,
    [drvCH5DOB] datetime NULL,
    [drvCH6First] varchar(100) NULL,
    [drvCH6Last] varchar(100) NULL,
    [drvCH6SSN] char(11) NULL,
    [drvCH6DOB] datetime NULL,
    [drvCH7First] varchar(100) NULL,
    [drvCH7Last] varchar(100) NULL,
    [drvCH7SSN] char(11) NULL,
    [drvCH7DOB] datetime NULL,
    [drvCH8First] varchar(100) NULL,
    [drvCH8Last] varchar(100) NULL,
    [drvCH8SSN] char(11) NULL,
    [drvCH8DOB] datetime NULL,
    [drvCH9First] varchar(100) NULL,
    [drvCH9Last] varchar(100) NULL,
    [drvCH9SSN] char(11) NULL,
    [drvCH9DOB] datetime NULL,
    [drvCH10First] varchar(100) NULL,
    [drvCH10Last] varchar(100) NULL,
    [drvCH10SSN] char(11) NULL,
    [drvCH10DOB] datetime NULL,
    [drvCH11First] varchar(100) NULL,
    [drvCH11Last] varchar(100) NULL,
    [drvCH11SSN] char(11) NULL,
    [drvCH11DOB] datetime NULL,
    [drvCH12First] varchar(100) NULL,
    [drvCH12Last] varchar(100) NULL,
    [drvCH12SSN] char(11) NULL,
    [drvCH12DOB] datetime NULL,
    [drvPQBSSN] char(11) NULL,
    [drvPQBFirstName] varchar(100) NULL,
    [drvPQBLastName] varchar(100) NULL,
    [drvPQBSex] char(1) NULL,
    [drvPQBDOB] datetime NULL,
    [drvPQBSSN2] char(11) NULL,
    [drvPQBFirstName2] varchar(100) NULL,
    [drvPQBLastName2] varchar(100) NULL,
    [drvPQBSex2] char(1) NULL,
    [drvPQBDOB2] datetime NULL,
    [drvPQBSSN3] char(11) NULL,
    [drvPQBFirstName3] varchar(100) NULL,
    [drvPQBLastName3] varchar(100) NULL,
    [drvPQBSex3] char(1) NULL,
    [drvPQBDOB3] datetime NULL,
    [drvPQBSSN4] char(11) NULL,
    [drvPQBFirstName4] varchar(100) NULL,
    [drvPQBLastName4] varchar(100) NULL,
    [drvPQBSex4] char(1) NULL,
    [drvPQBDOB4] datetime NULL,
    [drvPQBSSN5] char(11) NULL,
    [drvPQBFirstName5] varchar(100) NULL,
    [drvPQBLastName5] varchar(100) NULL,
    [drvPQBSex5] char(1) NULL,
    [drvPQBDOB5] datetime NULL,
    [drvPQBSSN6] char(11) NULL,
    [drvPQBFirstName6] varchar(100) NULL,
    [drvPQBLastName6] varchar(100) NULL,
    [drvPQBSex6] char(1) NULL,
    [drvPQBDOB6] datetime NULL,
    [drvPQBSSN7] char(11) NULL,
    [drvPQBFirstName7] varchar(100) NULL,
    [drvPQBLastName7] varchar(100) NULL,
    [drvPQBSex7] char(1) NULL,
    [drvPQBDOB7] datetime NULL,
    [drvPQBSSN8] char(11) NULL,
    [drvPQBFirstName8] varchar(100) NULL,
    [drvPQBLastName8] varchar(100) NULL,
    [drvPQBSex8] char(1) NULL,
    [drvPQBDOB8] datetime NULL
);
IF OBJECT_ID('U_EALKCBREXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EALKCBREXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EALKCBREXP_File') IS NULL
CREATE TABLE [dbo].[U_EALKCBREXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EALKCBREXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Alkami Technology

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 01/27/2021
Service Request Number: TekP-2020-12-04-0002

Purpose: TaxSaver COBRA QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EALKCBREXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EALKCBREXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EALKCBREXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EALKCBREXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EALKCBREXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALKCBREXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALKCBREXP', 'TEST';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'EALKCBREXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EALKCBREXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EALKCBREXP';

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
    DELETE FROM dbo.U_EALKCBREXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EALKCBREXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HDHP,PPO,DENHI,DENLO,VIS,FSA';

    


    IF OBJECT_ID('U_EALKCBREXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EALKCBREXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EALKCBREXP_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CalcBenOptionDate', '1')

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC,DCH');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'UpdDedType', 'FSA')
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


    --Audit tables --

    IF OBJECT_ID('U_EALKCBREXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EALKCBREXP_AuditFields;
    CREATE TABLE dbo.U_EALKCBREXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EALKCBREXP_AuditFields VALUES ('EmpDed','EedBenOption');    
   
    
    -- Create audit table
    IF OBJECT_ID('U_EALKCBREXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EALKCBREXP_Audit;
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
    INTO dbo.U_EALKCBREXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EALKCBREXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EALKCBREXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      --AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EALKCBREXP_Audit ON dbo.U_EALKCBREXP_Audit (audKey1Value, audKey2Value);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EALKCBREXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EALKCBREXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EALKCBREXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepssn
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvEmpSSN = eepSSN
        ,drvEmpFirstName = EepNameFirst
        ,drvEmpLastName = EepNameLast
        ,drvEmpSex = eepGender
        ,drvEmpDOB = EepDateOfBirth
        ,drvEmpDivision = ''
        ,drvEventType = CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                  WHEN EecTermReason = '203' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                  WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                  WHEN BdmCobraReason = '210' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                  WHEN BdmCobraReason IN ('203','202') THEN 'REDUCTIONINHOURSSTATUSCHANGE '
                                  WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                  WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURSENDOFLEAVE'
                                  WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                  WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                  WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                  WHEN EecEmplStatus = 'T' and eectermtype  = 'I' THEN 'INVOLUNTARYTERMINATION'
                                  ELSE 'TERMINATION'
                             END
        ,drvEventDate =  CASE WHEN EecTermReason = '202' THEN CobraEnventdate
                                  WHEN EecTermReason = '203' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('201','LEVNT3') THEN CobraEnventdate
                                  WHEN BdmCobraReason IN ('204','LEVNT4') THEN CobraEnventdate
                                  WHEN BdmCobraReason = '210' THEN CobraEnventdate
                                  WHEN BdmCobraReason IN ('202','CHGRP') THEN CobraEnventdate
                                  WHEN BdmCobraReason IN ('203','202') THEN (select top 1 EjhJobEffDate from emphjob where ejheeid = xeeid and ejhcoid =  xcoid order by ejhdatetimecreated desc)
                                  WHEN BdmCobraReason = '205' THEN CobraEnventdate
                                  WHEN BdmCobraReason = '206' THEN CobraEnventdate
                                  WHEN BdmCobraReason = '207' THEN CobraEnventdate
                                  WHEN BdmCobraReason = '208' THEN CobraEnventdate
                                  WHEN BdmCobraReason = '209' THEN CobraEnventdate
                                  WHEN EecEmplStatus = 'T' and eectermtype  = 'I' THEN CobraEnventdate
                                  WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                             END
                             
        ,drvOriginalEnrollmentDate = bdmbenstartdate
        ,drvAEIEligible = 'N'
        ,drvUsesHCTC = 'N'
        ,drvAddress1 = Quotename(EepAddressLine1,'"')
        ,drvAddress2 = Quotename(EepAddressLine2,'"')
        ,drvCity = Quotename(EepAddressCity,'"')
        ,drvStateorProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountry = EepAddressCountry
        /*
        If eeddedcode = MEDBC send BCBS PPO Plan 
        If eeddedcode = I5 send BCBS PPO Plan or Traditional Plan 
        else send NONE
        */
        ,drvMedicalPlan = CASE WHEN HDHP  is not null then 'HDHP Plan'
                               WHEN PPO  is not null then 'PPO Plan'    
                               ELSE 'NONE'
                         END
        /*
        If eeddedcode = MEDBC or I5 and eedbenoption = EE send EE
        If eedbenoption = EES or EEDP send EE+SPOUSE
        If eedbenoption = EEC send EE+CHILDREN
        If eedbenoption = EEF or EEDPF and send EE+ FAMILY
        Else leave blank
        */
        ,drvMedicalCoverage = CASE WHEN (HDHP is not null or PPO is not null)  THEN
                                        CASE WHEN (PPO_BenOption = 'EE' or HDHP_BenOption = 'EE') THEN 'EE'
                                             WHEN (PPO_BenOption IN ('EES') or HDHP_BenOption IN ('EES')) THEN 'EE+SPOUSE'
                                             WHEN (PPO_BenOption IN ('EEC') or HDHP_BenOption IN ('EEC') ) THEN 'EE+CHILDREN'
                                             WHEN (PPO_BenOption IN ('EEF') or HDHP_BenOption IN ('EEF') ) THEN 'EE+FAMILY'
                                        END
                              END
        ,drvDentalPlan = CASE WHEN DENHI  is not null THEN  'Dental High MAC Plan'
                              WHEN DENLO   is not null THEN  'Dental Low MAC Plan'
                            ELSE 'NONE' END 
        ,drvDentalCoverage = CASE WHEN (DENHI is not null or DENLO is not null)  THEN
                                        CASE WHEN (DENHI_BenOption = 'EE' or DENLO_BenOption = 'EE') THEN 'EE'
                                             WHEN (DENHI_BenOption IN ('EES') or DENLO_BenOption IN ('EES') ) THEN 'EE+SPOUSE'
                                             WHEN (DENHI_BenOption IN ('EEC') or DENLO_BenOption IN ('EEC') ) THEN 'EE+CHILDREN'
                                             WHEN (DENHI_BenOption IN ('EEF') or DENLO_BenOption IN ('EEF') ) THEN 'EE+FAMILY'
                                        END
                              END
        ,drvVisionPlan = CASE WHEN Vision is not null then 'Vision Plan' ELSE 'NONE' END
        /*
            If eeddedcode = V and eedbenoption = EE send EE
            If eedbenoption = E1 and conrelationship = SPS or DP send EE+SPOUSE
            If eedbenoption = E1 and conrelationship <> SPS or DP send EE+CHILD
            If eedbenoption = E2 and conrelationship contains SPS or DP send EE+FAMILY
            If eedbenoption = E2 and conrelationship does not contain SPS or DP send EE+CHILDREN
            Else leave blank
                */
        ,Count_SPS
        ,Count_CHL
        ,Vision_BenOption
        ,drvVisionCoverage = CASE WHEN Vision is not null  THEN
                                    CASE WHEN Vision_BenOption = 'EE' THEN 'EE'
                                         WHEN Vision_BenOption = 'EES' THEN 'EE+SPOUSE'
                                         WHEN Vision_BenOption = 'EEC'  THEN 'EE+CHILDREN'
                                         WHEN Vision_BenOption = 'EEF'  THEN 'EE+FAMILY'

                                    END 
                             END
        ,drvEAPPlan = 'NONE'
        ,drvEAPCoverage = ''
        ,drvFSA = CASE WHEN FSA is not null then 'Y' ELSE 'N' END    
        ,drvFSAContrib = CASE WHEN FSA is not null then FSA_GoalAmt END   
        ,drvSpouseFirst = SPSFirstName
        ,drvSpouseLast = SPSLastName
        ,drvSpouseSSN = SPSssn
        ,drvSpouseDOB = SPSDateOfBirth
        ,drvCH1First = DepFirstName1
        ,drvCH1Last = DepLastName1
        ,drvCH1SSN = DepSsn1
        ,drvCH1DOB = DepDateOfBirth1
        ,drvCH2First = DepFirstName2
        ,drvCH2Last = DepLastName2
        ,drvCH2SSN = DepSsn2
        ,drvCH2DOB = DepDateOfBirth2
        ,drvCH3First = DepFirstName3
        ,drvCH3Last = DepLastName3
        ,drvCH3SSN = DepSsn3
        ,drvCH3DOB = DepDateOfBirth3
        ,drvCH4First = DepFirstName4
        ,drvCH4Last = DepLastName4
        ,drvCH4SSN = DepSsn4
        ,drvCH4DOB = DepDateOfBirth4
        ,drvCH5First = DepFirstName5
        ,drvCH5Last = DepLastName5
        ,drvCH5SSN = DepSsn5
        ,drvCH5DOB = DepDateOfBirth5
        ,drvCH6First = DepFirstName6
        ,drvCH6Last = DepLastName6
        ,drvCH6SSN = DepSsn6
        ,drvCH6DOB = DepDateOfBirth6
        ,drvCH7First = DepFirstName7
        ,drvCH7Last = DepLastName7
        ,drvCH7SSN = DepSsn7
        ,drvCH7DOB = DepDateOfBirth7
        ,drvCH8First = DepFirstName8
        ,drvCH8Last = DepLastName8
        ,drvCH8SSN = DepSsn8
        ,drvCH8DOB = DepDateOfBirth8
        ,drvCH9First = DepFirstName9
        ,drvCH9Last = DepLastName9
        ,drvCH9SSN = DepSsn9
        ,drvCH9DOB = DepDateOfBirth9
        ,drvCH10First = DepFirstName10
        ,drvCH10Last = DepLastName10
        ,drvCH10SSN = DepSsn10
        ,drvCH10DOB = DepDateOfBirth10
        ,drvCH11First = DepFirstName11
        ,drvCH11Last = DepLastName11
        ,drvCH11SSN = DepSsn11
        ,drvCH11DOB = DepDateOfBirth11
        ,drvCH12First = DepFirstName12
        ,drvCH12Last = DepLastName12
        ,drvCH12SSN = DepSsn12
        ,drvCH12DOB = DepDateOfBirth12
        ,drvPQBSSN = ssn1
        ,drvPQBFirstName = firstname1
        ,drvPQBLastName = lastname1
        ,drvPQBSex = gender1
        ,drvPQBDOB = birthday1
        ,drvPQBSSN2 = ssn2
        ,drvPQBFirstName2 = firstname2
        ,drvPQBLastName2 = lastname2
        ,drvPQBSex2 = gender2
        ,drvPQBDOB2 = birthday2
        ,drvPQBSSN3 = ssn3
        ,drvPQBFirstName3 = firstname3
        ,drvPQBLastName3 = lastname3
        ,drvPQBSex3 = gender3
        ,drvPQBDOB3 = birthday3
        ,drvPQBSSN4 = ssn4
        ,drvPQBFirstName4 = firstname4
        ,drvPQBLastName4 = lastname4
        ,drvPQBSex4 = gender4
        ,drvPQBDOB4 = birthday4
        ,drvPQBSSN5 = ssn5
        ,drvPQBFirstName5 = firstname5
        ,drvPQBLastName5 = lastname5
        ,drvPQBSex5 = gender5
        ,drvPQBDOB5 = birthday5
        ,drvPQBSSN6 = ssn6
        ,drvPQBFirstName6 = firstname6
        ,drvPQBLastName6 = lastname6
        ,drvPQBSex6 = gender6
        ,drvPQBDOB6 = birthday6
        ,drvPQBSSN7 = ssn7
        ,drvPQBFirstName7 = firstname7
        ,drvPQBLastName7 = lastname7
        ,drvPQBSex7 = gender7
        ,drvPQBDOB7 = birthday7
        ,drvPQBSSN8 = ssn8
        ,drvPQBFirstName8 = firstname8
        ,drvPQBLastName8 = lastname8
        ,drvPQBSex8 = gender8
        ,drvPQBDOB8 = birthday8
    INTO dbo.U_EALKCBREXP_drvTbl
    FROM dbo.U_EALKCBREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
      JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xeeid
       AND EecCoID = xcoid
    JOIN (Select  A.bdmEEID,A.bdmcoid
            ,HDHP = MAX((CASE WHEN BDMDedCode = 'HDHP' then 'HDHP' END))
            ,PPO = MAX((CASE WHEN BDMDedCode = 'PPO' then 'PPO' END))
            ,Vision = MAX((CASE WHEN BDMDedCode = 'VIS' then 'VIS' END))
            ,DENHI  = MAX((CASE WHEN BDMDedCode = 'DENHI' then 'DENHI' END))
            ,DENLO   = MAX((CASE WHEN BDMDedCode = 'DENLO ' then 'DENLO ' END))

            ,HDHP_startDate = MAX((CASE WHEN BDMDedCode = 'HDHP' then bdmbenstartdate END))
            ,PPO_startDate = MAX((CASE WHEN BDMDedCode = 'PPO' then bdmbenstartdate END))
            ,Vision_startdate = MAX((CASE WHEN BDMDedCode = 'VIS' then bdmbenstartdate END))
            ,DENHI_startdate = MAX((CASE WHEN BDMDedCode = 'DENHI' then bdmbenstartdate END))
            ,DENLO_startdate = MAX((CASE WHEN BDMDedCode = 'DENLO' then bdmbenstartdate END))

            ,HDHP_benoption = MAX((CASE WHEN BDMDedCode = 'HDHP' then BdmBenOption END))
            ,PPO_benoption = MAX((CASE WHEN BDMDedCode = 'PPO' then BdmBenOption END))
            ,Vision_benoption = MAX((CASE WHEN BDMDedCode = 'VIS' then BdmBenOption END))
            ,DENHI_benoption = MAX((CASE WHEN BDMDedCode = 'DENHI' then BdmBenOption END))
            ,DENLO_benoption = MAX((CASE WHEN BDMDedCode = 'DENLO' then BdmBenOption END))
            ,FSA = MAX((CASE WHEN BDMDedCode = 'FSA' then 'FSA' END))

            ,FSA_GoalAmt = MAX((CASE WHEN BDMDedCode = 'FSA' then BdmEEGoalAmt END))
            ,CobraEnventdate = MAX(BdmDateOfCOBRAEvent) 
            ,CobraStatusDate = MAX(BdmBenStatusDate) 
            ,BdmCobraReason = MAX(BdmCobraReason) 
            ,bdmbenstartdate = max(bdmbenstartdate)
            ,MAX(CASE WHEN Number = 1 THEN firstname END) AS firstname1
            ,MAX(CASE WHEN Number = 1 THEN lastname END) AS lastname1
            ,MAX(CASE WHEN Number = 1 THEN ssn END) AS ssn1
            ,MAX(CASE WHEN Number = 1 THEN birthday END) AS birthday1
            ,MAX(CASE WHEN Number = 1 THEN gender END) AS gender1
            ,MAX(CASE WHEN Number = 2 THEN firstname END) AS firstname2
            ,MAX(CASE WHEN Number = 2 THEN lastname END) AS lastname2
            ,MAX(CASE WHEN Number = 2 THEN ssn END) AS ssn2
            ,MAX(CASE WHEN Number = 2 THEN birthday END) AS birthday2
            ,MAX(CASE WHEN Number = 2 THEN gender END) AS gender2
            ,MAX(CASE WHEN Number = 3 THEN firstname END) AS firstname3
            ,MAX(CASE WHEN Number = 3 THEN lastname END) AS lastname3
            ,MAX(CASE WHEN Number = 3 THEN ssn END) AS ssn3
            ,MAX(CASE WHEN Number = 3 THEN birthday END) AS birthday3
            ,MAX(CASE WHEN Number = 3 THEN gender END) AS gender3
            ,MAX(CASE WHEN Number = 4 THEN firstname END) AS firstname4
            ,MAX(CASE WHEN Number = 4 THEN lastname END) AS lastname4
            ,MAX(CASE WHEN Number = 4 THEN ssn END) AS ssn4
            ,MAX(CASE WHEN Number = 4 THEN birthday END) AS birthday4
            ,MAX(CASE WHEN Number = 4 THEN gender END) AS gender4
            ,MAX(CASE WHEN Number = 5 THEN firstname END) AS firstname5
            ,MAX(CASE WHEN Number = 5 THEN lastname END) AS lastname5
            ,MAX(CASE WHEN Number = 5 THEN ssn END) AS ssn5
            ,MAX(CASE WHEN Number = 5 THEN birthday END) AS birthday5
            ,MAX(CASE WHEN Number = 5 THEN gender END) AS gender5
            ,MAX(CASE WHEN Number = 6 THEN firstname END) AS firstname6
            ,MAX(CASE WHEN Number = 6 THEN lastname END) AS lastname6
            ,MAX(CASE WHEN Number = 6 THEN ssn END) AS ssn6
            ,MAX(CASE WHEN Number = 6 THEN birthday END) AS birthday6
            ,MAX(CASE WHEN Number = 6 THEN gender END) AS gender6
            ,MAX(CASE WHEN Number = 7 THEN firstname END) AS firstname7
            ,MAX(CASE WHEN Number = 7 THEN lastname END) AS lastname7
            ,MAX(CASE WHEN Number = 7 THEN ssn END) AS ssn7
            ,MAX(CASE WHEN Number = 7 THEN birthday END) AS birthday7
            ,MAX(CASE WHEN Number = 7 THEN gender END) AS gender7
            ,MAX(CASE WHEN Number = 8 THEN firstname END) AS firstname8
            ,MAX(CASE WHEN Number = 8 THEN lastname END) AS lastname8
            ,MAX(CASE WHEN Number = 8 THEN ssn END) AS ssn8
            ,MAX(CASE WHEN Number = 8 THEN birthday END) AS birthday8
            ,MAX(CASE WHEN Number = 8 THEN gender END) AS gender8
            ,Count(CASE WHEN BdmRelationship IN ('SPS') and BdmDedcode = 'V' then 1 END) AS  Count_SPS
            ,Count(CASE WHEN BdmRelationship IN ('CHL') and BdmDedcode = 'V' then 1 END) AS  Count_CHL

            from dbo.U_dsi_BDM_EALKCBREXP A
            JOIN  (
            Select  bdmeeid,bdmdeprecid,
        case when bdmdeprecid is null then eepSSN else conSSN end as ssn,
        case when bdmdeprecid is null then eepNameFirst else ConNamefirst end as firstName,
        case when bdmdeprecid is null then eepNameLast else ConNamelast end as lastname,
        case when bdmdeprecid is null then eepDateOfBirth else ConDateOfBirth end as birthday,
        case when bdmdeprecid is null then eepGender else conGender end as gender,
 ROW_NUMBER() OVER (PARTITION BY bdmeeid order by  bdmeeid) AS 'Number' 
    from  U_dsi_BDM_EALKCBREXP A 
        JOIN dbo.EmpPers WITH (NOLOCK) 
        ON EepEEID = bdmeeid
        LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON ConEEID = bdmeeid 
        AND ConSystemID = BdmDepRecID
       WHERE A.bdmisPQB = 'Y'
 Group By bdmeeid,bdmDepRecId,
 case when bdmdeprecid is null then eepSSN else conSSN end,
 case when bdmdeprecid is null then eepNameFirst else ConNamefirst end, 
 case when bdmdeprecid is null then eepNameLast else ConNameLast end,
 case when bdmdeprecid is null then eepDateOfBirth else ConDateOfBirth end,
 case when bdmdeprecid is null then eepGender else conGender end
            ) B
            ON B.BdmEEID = A.bdmeeID
            group by A.bdmEEID,A.bdmcoid) as ConsolidatedBDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (Select bdmeeid AS KidEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS DepLastName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS DepFirstName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS DepSsn1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS DepDateOfBirth1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS DepRelationship1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameLast END) AS DepLastName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameFirst END) AS DepFirstName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConSSN END) AS DepSsn2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConDateOfBirth END) AS DepDateOfBirth2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConRelationship END) AS DepRelationship2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameLast END) AS DepLastName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameFirst END) AS DepFirstName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConSSN END) AS DepSsn3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConDateOfBirth END) AS DepDateOfBirth3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConRelationship END) AS DepRelationship3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameLast END) AS DepLastName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameFirst END) AS DepFirstName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConSSN END) AS DepSsn4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConDateOfBirth END) AS DepDateOfBirth4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConRelationship END) AS DepRelationship4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameLast END) AS DepLastName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameFirst END) AS DepFirstName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConSSN END) AS DepSsn5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConDateOfBirth END) AS DepDateOfBirth5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConRelationship END) AS DepRelationship5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameLast END) AS DepLastName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameFirst END) AS DepFirstName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConSSN END) AS DepSsn6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConDateOfBirth END) AS DepDateOfBirth6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConRelationship END) AS DepRelationship6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameLast END) AS DepLastName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameFirst END) AS DepFirstName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConSSN END) AS DepSsn7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConDateOfBirth END) AS DepDateOfBirth7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConRelationship END) AS DepRelationship7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameLast END) AS DepLastName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameFirst END) AS DepFirstName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConSSN END) AS DepSsn8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConDateOfBirth END) AS DepDateOfBirth8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConRelationship END) AS DepRelationship8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameLast END) AS DepLastName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameFirst END) AS DepFirstName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConSSN END) AS DepSsn9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConDateOfBirth END) AS DepDateOfBirth9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConRelationship END) AS DepRelationship9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameLast END) AS DepLastName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameFirst END) AS DepFirstName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConSSN END) AS DepSsn10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConDateOfBirth END) AS DepDateOfBirth10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConRelationship END) AS DepRelationship10
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameLast END) AS DepLastName11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameFirst END) AS DepFirstName11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConSSN END) AS DepSsn11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConDateOfBirth END) AS DepDateOfBirth11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConRelationship END) AS DepRelationship11
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConNameLast END) AS DepLastName12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConNameFirst END) AS DepFirstName12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConSSN END) AS DepSsn12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConDateOfBirth END) AS DepDateOfBirth12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConRelationship END) AS DepRelationship12
            ,Count(CASE WHEN ConRelationship IN ('DAU', 'SON', 'DIS', 'STC','CHL') THEN Dep_Number END) as Child_Counts

        From (
                select bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship, ROW_NUMBER() OVER (PARTITION BY bdmeeid ORDER BY bdmeeid) AS 'Dep_Number'
                from  dbo.U_dsi_BDM_EALKCBREXP A 
                JOIN dbo.Contacts WITH (NOLOCK) 
                ON ConEEID = bdmeeid 
                AND ConSystemID = BdmDepRecID
                where bdmrelationship IN ('CHL') and bdmdedcode in ('DENHI', 'DENLO', 'HDHP', 'PPO' , 'VIS') 
                    group by bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship
                    ) AS Source Group By bdmeeid)
         AS DepList on KidEEID = xEEID
         LEFT JOIN (Select bdmeeid AS SPSEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS SPSLastName
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS SPSFirstName
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS SPSSsn
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS SPSDateOfBirth
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS SPSRelationship
            ,Count(CASE WHEN ConRelationship IN ('SPS') THEN Dep_Number END) as SPS_Counts

        From (
                select bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship, ROW_NUMBER() OVER (PARTITION BY bdmeeid ORDER BY bdmeeid) AS 'Dep_Number'
                from  dbo.U_dsi_BDM_EALKCBREXP A 
                JOIN dbo.Contacts WITH (NOLOCK) 
                ON ConEEID = bdmeeid 
                AND ConSystemID = BdmDepRecID
                where bdmrelationship IN ('SPS','DP') and bdmdedcode in ('DENHI', 'DENLO', 'HDHP', 'PPO' , 'VIS')
                    group by bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship
                    ) AS Source Group By bdmeeid) As Spouse
                on xeeid = Spouse.SPSEEID

        Update dbo.U_EALKCBREXP_drvTbl set drvEAPCoverage = '' where drvEAPPlan = 'NONE';


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
ALTER VIEW dbo.dsi_vwEALKCBREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EALKCBREXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EALKCBREXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005011'
       ,expStartPerControl     = '202005011'
       ,expLastEndPerControl   = '202005089'
       ,expEndPerControl       = '202005089'
WHERE expFormatCode = 'EALKCBREXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEALKCBREXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EALKCBREXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2