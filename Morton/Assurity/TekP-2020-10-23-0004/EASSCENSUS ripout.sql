SET NOCOUNT ON;
IF OBJECT_ID('U_EASSCENSUS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EASSCENSUS_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EASSCENSUS' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEASSCENSUS_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEASSCENSUS_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EASSCENSUS') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASSCENSUS];
GO
IF OBJECT_ID('U_EASSCENSUS_File') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_File];
GO
IF OBJECT_ID('U_EASSCENSUS_EEList') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_EEList];
GO
IF OBJECT_ID('U_EASSCENSUS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_drvTbl];
GO
IF OBJECT_ID('U_EASSCENSUS_DedList') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_DedList];
GO
IF OBJECT_ID('U_EASSCENSUS_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_AuditFields];
GO
IF OBJECT_ID('U_EASSCENSUS_Audit') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EASSCENSUS') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EASSCENSUS];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EASSCENSUS';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EASSCENSUS';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EASSCENSUS';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EASSCENSUS';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EASSCENSUS';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EASSCENSUS','Assurity Census Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EASSCENSUSZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EASSCENSUS' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee SSN"','1','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','1',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relation"','2','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','2',NULL,'Relation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse and/or Child SSN"','3','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','3',NULL,'Spouse and/or Child SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','4','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','4',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','5','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','6','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','6',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','7','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','7',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','8','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','8',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire"','9','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','9',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Group Identifier"','10','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','10',NULL,'Group Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked Per Week"','11','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','11',NULL,'Hours Worked Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Annual Salary"','12','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','12',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Used tobacco prod in last 12 months"','13','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','13',NULL,'Used tobacco products in last 12 months? YES or NO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Height (FT)"','14','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','14',NULL,'Height (FT)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Height (IN)"','15','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','15',NULL,'Height (IN)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Weight"','16','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','16',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mailing Address1"','17','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','17',NULL,'Mailing Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mailing Address2"','18','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','18',NULL,'Mailing Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','19','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','19',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','20','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','20',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip "','21','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','21',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone Number"','22','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','22',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','23','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','23',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Beneficiary Relationship"','24','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','24',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Beneficiary Share Percent"','25','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','25',NULL,'Beneficiary Share Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Comprehensive State Specific Health Question"','26','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','26',NULL,'Comprehensive State Specific Health Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AE Plan Type"','27','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','27',NULL,'AE Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AE Insured Option"','28','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','28',NULL,'AE Insured Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AE Premium Amount"','29','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','29',NULL,'AE Premium Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AE Issue Date"','30','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','30',NULL,'AE Issue Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AE Signed Date"','31','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','31',NULL,'AE Signed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AE Termination Date"','32','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','32',NULL,'AE Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DI Plan Type"','33','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','33',NULL,'DI Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DI Benefit Amount"','34','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','34',NULL,'DI Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DI Premium Amount"','35','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','35',NULL,'DI Premium Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DI Issue Date"','36','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','36',NULL,'DI Issue Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DI Signed Date"','37','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','37',NULL,'DI Signed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DI Termination Date"','38','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','38',NULL,'DI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Plan Type"','39','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','39',NULL,'CI Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Insured Option"','40','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','40',NULL,'CI Insured Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Benefit Amount"','41','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','41',NULL,'CI Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Premium Amount"','42','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','42',NULL,'CI Premium Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Issue Date"','43','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','43',NULL,'CI Issue Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Signed Date"','44','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','44',NULL,'CI Signed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Date"','45','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','45',NULL,'CI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CE Plan Type"','46','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','46',NULL,'CE Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CE Insured Option"','47','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','47',NULL,'CE Insured Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CE Benefit Amount"','48','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','48',NULL,'CE Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CE Premium Amount"','49','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','49',NULL,'CE Premium Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CE Issue Date"','50','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','50',NULL,'CE Issue Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CE Signed Date"','51','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','51',NULL,'CE Signed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CE Termination Date"','52','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','52',NULL,'CE Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HI Plan Type"','53','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','53',NULL,'HI Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HI Insured Option"','54','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','54',NULL,'HI Insured Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HI Benefit Amount"','55','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','55',NULL,'HI Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HI Premium Amount"','56','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','56',NULL,'HI Premium Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HI Issue Date"','57','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','57',NULL,'HI Issue Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HI Signed Date"','58','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','58',NULL,'HI Signed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HI Termination Date"','59','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','59',NULL,'HI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan Type"','60','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','60',NULL,'Life Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Certificate Amount"','61','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','61',NULL,'Life Certificate Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Insured Option"','62','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','62',NULL,'Life Insured Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Premium Amount"','63','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','63',NULL,'Life Premium Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Issue Date"','64','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','64',NULL,'Life Issue Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Signed Date"','65','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','65',NULL,'Life Signed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Level Term Rider Y/N"','66','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','66',NULL,'Level Term Rider Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Cert. Y/N"','67','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','67',NULL,'Spouse Cert. Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Cert. Amount"','68','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','68',NULL,'Spouse Cert. Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Cert. Y/N"','69','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','69',NULL,'Child Cert. Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Cert. Amount"','70','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','70',NULL,'Child Cert. Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Childrens Term Insurance Rider Y/N"','71','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','71',NULL,'Childrens Term Insurance Rider Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Childrens Term Insurance Rider Amount"','72','(''DA''=''T,'')','EASSCENSUSZ0','50','H','01','72',NULL,'Childrens Term Insurance Rider Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Termination Date"','73','(''DA''=''T'')','EASSCENSUSZ0','50','H','01','73',NULL,'Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','1','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','1',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelation"','2','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','2',NULL,'Relation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseandorChildSSN"','3','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','3',NULL,'Spouse and/or Child SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','4','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','4',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','5','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','6','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','6',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','7','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','7',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','8','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','8',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHire"','9','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','9',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupIdentifier"','10','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','10',NULL,'Group Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedPerWeek"','11','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','11',NULL,'Hours Worked Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','12','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','12',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUsedtobaccoLast12mths"','13','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','13',NULL,'Used tobacco products in last 12 months? YES or NO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeightFT"','14','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','14',NULL,'Height (FT)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeightIN"','15','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','15',NULL,'Height (IN)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeight"','16','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','16',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailingAddress1"','17','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','17',NULL,'Mailing Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailingAddress2"','18','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','18',NULL,'Mailing Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','19','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','19',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','20','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','20',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','21','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','21',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','22','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','22',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','23','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','23',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneficiaryRelationship"','24','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','24',NULL,'Beneficiary Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneficiarySharePercent"','25','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','25',NULL,'Beneficiary Share Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompStateSpecificHlthQues"','26','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','26',NULL,'Comprehensive State Specific Health Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAEPlanType"','27','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','27',NULL,'AE Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAEInsuredOption"','28','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','28',NULL,'AE Insured Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAEPremiumAmount"','29','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','29',NULL,'AE Premium Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAEIssueDate"','30','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','30',NULL,'AE Issue Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAESignedDate"','31','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','31',NULL,'AE Signed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAETerminationDate"','32','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','32',NULL,'AE Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDIPlanType"','33','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','33',NULL,'DI Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDIBenefitAmount"','34','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','34',NULL,'DI Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDIPremiumAmount"','35','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','35',NULL,'DI Premium Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDIIssueDate"','36','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','36',NULL,'DI Issue Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDISignedDate"','37','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','37',NULL,'DI Signed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDITerminationDate"','38','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','38',NULL,'DI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCIPlanType"','39','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','39',NULL,'CI Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCIInsuredOption"','40','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','40',NULL,'CI Insured Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCIBenefitAmount"','41','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','41',NULL,'CI Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCIPremiumAmount"','42','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','42',NULL,'CI Premium Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCIIssueDate"','43','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','43',NULL,'CI Issue Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCISignedDate"','44','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','44',NULL,'CI Signed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCITerminationDate"','45','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','45',NULL,'CI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCEPlanType"','46','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','46',NULL,'CE Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCEInsuredOption"','47','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','47',NULL,'CE Insured Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCEBenefitAmount"','48','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','48',NULL,'CE Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCEPremiumAmount"','49','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','49',NULL,'CE Premium Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCEIssueDate"','50','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','50',NULL,'CE Issue Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCESignedDate"','51','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','51',NULL,'CE Signed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCETerminationDate"','52','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','52',NULL,'CE Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHIPlanType"','53','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','53',NULL,'HI Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHIInsuredOption"','54','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','54',NULL,'HI Insured Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHIBenefitAmount"','55','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','55',NULL,'HI Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHIPremiumAmount"','56','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','56',NULL,'HI Premium Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHIIssueDate"','57','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','57',NULL,'HI Issue Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHISignedDate"','58','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','58',NULL,'HI Signed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHITerminationDate"','59','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','59',NULL,'HI Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlanType"','60','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','60',NULL,'Life Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeCertificateAmount"','61','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','61',NULL,'Life Certificate Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeInsuredOption"','62','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','62',NULL,'Life Insured Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePremiumAmount"','63','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','63',NULL,'Life Premium Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeIssueDate"','64','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','64',NULL,'Life Issue Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeSignedDate"','65','(''UD101''=''T,'')','EASSCENSUSZ0','50','D','10','65',NULL,'Life Signed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLevelTermRiderYN"','66','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','66',NULL,'Level Term Rider Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseCertYN"','67','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','67',NULL,'Spouse Cert. Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseCertAmount"','68','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','68',NULL,'Spouse Cert. Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildCertYN"','69','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','69',NULL,'Child Cert. Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildCertAmount"','70','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','70',NULL,'Child Cert. Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildrensTermInsRider"','71','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','71',NULL,'Childrens Term Insurance Rider Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildrensTermInsRiderAmnt"','72','(''UA''=''T,'')','EASSCENSUSZ0','50','D','10','72',NULL,'Childrens Term Insurance Rider Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeTerminationDate"','73','(''UD101''=''T'')','EASSCENSUSZ0','50','D','10','73',NULL,'Life Termination Date',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EASSCENSUS_20210205.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202102029','EMPEXPORT','OEACTIVE',NULL,'EASSCENSUS',NULL,NULL,NULL,'202102029','Feb  2 2021  9:46AM','Feb  2 2021  9:46AM','202102021',NULL,'','','202102021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202102029','EMPEXPORT','OEPASSIVE',NULL,'EASSCENSUS',NULL,NULL,NULL,'202102029','Feb  2 2021  9:46AM','Feb  2 2021  9:46AM','202102021',NULL,'','','202102021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Assurity Census Export','202102029','EMPEXPORT','ONDEM_XOE',NULL,'EASSCENSUS',NULL,NULL,NULL,'202102029','Feb  2 2021  9:46AM','Feb  2 2021  9:46AM','202102021',NULL,'','','202102021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Assurity Census Export-Sched','202102029','EMPEXPORT','SCH_EASSCE',NULL,'EASSCENSUS',NULL,NULL,NULL,'202102029','Feb  2 2021  9:46AM','Feb  2 2021  9:46AM','202102021',NULL,'','','202102021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Assurity Census Export-Test','202102029','EMPEXPORT','TEST_XOE',NULL,'EASSCENSUS',NULL,NULL,NULL,'202102029','Feb  2 2021  9:46AM','Feb  2 2021  9:46AM','202102021',NULL,'','','202102021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASSCENSUS','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASSCENSUS','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASSCENSUS','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASSCENSUS','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASSCENSUS','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EASSCENSUS' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EASSCENSUS' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EASSCENSUS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASSCENSUS','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASSCENSUS','D10','dbo.U_EASSCENSUS_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EASSCENSUS') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EASSCENSUS] (
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
IF OBJECT_ID('U_EASSCENSUS_Audit') IS NULL
CREATE TABLE [dbo].[U_EASSCENSUS_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EASSCENSUS_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EASSCENSUS_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EASSCENSUS_DedList') IS NULL
CREATE TABLE [dbo].[U_EASSCENSUS_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EASSCENSUS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EASSCENSUS_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvRelation] char(3) NULL,
    [drvSpouseandorChildSSN] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvDOB] datetime NULL,
    [drvDateofHire] datetime NULL,
    [drvGroupIdentifier] varchar(1) NOT NULL,
    [drvHoursWorkedPerWeek] varchar(30) NULL,
    [drvAnnualSalary] varchar(30) NULL,
    [drvUsedtobaccoLast12mths] varchar(1) NOT NULL,
    [drvHeightFT] varchar(1) NOT NULL,
    [drvHeightIN] varchar(1) NOT NULL,
    [drvWeight] varchar(1) NOT NULL,
    [drvMailingAddress1] varchar(257) NULL,
    [drvMailingAddress2] varchar(257) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvBeneficiaryRelationship] char(3) NULL,
    [drvBeneficiarySharePercent] varchar(1) NOT NULL,
    [drvCompStateSpecificHlthQues] varchar(255) NULL,
    [drvAEPlanType] varchar(8) NOT NULL,
    [drvAEInsuredOption] varchar(3) NULL,
    [drvAEPremiumAmount] varchar(1) NOT NULL,
    [drvAEIssueDate] varchar(1) NOT NULL,
    [drvAESignedDate] datetime NULL,
    [drvAETerminationDate] datetime NULL,
    [drvDIPlanType] varchar(1) NOT NULL,
    [drvDIBenefitAmount] varchar(1) NOT NULL,
    [drvDIPremiumAmount] varchar(1) NOT NULL,
    [drvDIIssueDate] varchar(1) NOT NULL,
    [drvDISignedDate] varchar(1) NOT NULL,
    [drvDITerminationDate] varchar(1) NOT NULL,
    [drvCIPlanType] varchar(6) NULL,
    [drvCIInsuredOption] varchar(3) NULL,
    [drvCIBenefitAmount] varchar(5) NULL,
    [drvCIPremiumAmount] varchar(1) NOT NULL,
    [drvCIIssueDate] datetime NULL,
    [drvCISignedDate] datetime NULL,
    [drvCITerminationDate] datetime NULL,
    [drvCEPlanType] varchar(1) NOT NULL,
    [drvCEInsuredOption] varchar(1) NOT NULL,
    [drvCEBenefitAmount] varchar(1) NOT NULL,
    [drvCEPremiumAmount] varchar(1) NOT NULL,
    [drvCEIssueDate] varchar(1) NOT NULL,
    [drvCESignedDate] varchar(1) NOT NULL,
    [drvCETerminationDate] varchar(1) NOT NULL,
    [drvHIPlanType] varchar(2) NOT NULL,
    [drvHIInsuredOption] varchar(3) NULL,
    [drvHIBenefitAmount] varchar(256) NULL,
    [drvHIPremiumAmount] varchar(1) NOT NULL,
    [drvHIIssueDate] datetime NULL,
    [drvHISignedDate] datetime NULL,
    [drvHITerminationDate] datetime NULL,
    [drvLifePlanType] varchar(1) NOT NULL,
    [drvLifeCertificateAmount] varchar(1) NOT NULL,
    [drvLifeInsuredOption] varchar(1) NOT NULL,
    [drvLifePremiumAmount] varchar(1) NOT NULL,
    [drvLifeIssueDate] varchar(1) NOT NULL,
    [drvLifeSignedDate] varchar(1) NOT NULL,
    [drvLevelTermRiderYN] varchar(1) NOT NULL,
    [drvSpouseCertYN] varchar(1) NOT NULL,
    [drvSpouseCertAmount] varchar(1) NOT NULL,
    [drvChildCertYN] varchar(1) NOT NULL,
    [drvChildCertAmount] varchar(1) NOT NULL,
    [drvChildrensTermInsRider] varchar(1) NOT NULL,
    [drvChildrensTermInsRiderAmnt] varchar(1) NOT NULL,
    [drvLifeTerminationDate] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EASSCENSUS_EEList') IS NULL
CREATE TABLE [dbo].[U_EASSCENSUS_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EASSCENSUS_File') IS NULL
CREATE TABLE [dbo].[U_EASSCENSUS_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASSCENSUS]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Morton Industries LLC

Created By: Inshan Singh
Business Analyst: Richard Vars
Create Date: 02/02/2021
Service Request Number: TekP-2020-10-23-0004

Purpose: Assurity Census Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EASSCENSUS';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EASSCENSUS';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EASSCENSUS';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EASSCENSUS';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EASSCENSUS' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASSCENSUS', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASSCENSUS', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASSCENSUS', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASSCENSUS', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASSCENSUS', 'SCH_EASSCE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EASSCENSUS';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EASSCENSUS', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EASSCENSUS';

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
    DELETE FROM dbo.U_EASSCENSUS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EASSCENSUS_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EASSCENSUS_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EASSCENSUS_AuditFields;
    CREATE TABLE dbo.U_EASSCENSUS_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EASSCENSUS_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EASSCENSUS_AuditFields VALUES ('EmpDed','EedDatetimeChanged');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EASSCENSUS_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EASSCENSUS_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EASSCENSUS_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EASSCENSUS_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EASSCENSUS_Audit ON dbo.U_EASSCENSUS_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EASSCENSUS_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EASSCENSUS_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ASHOS,ASACC,ECI10,ECI20,ECI30';

    IF OBJECT_ID('U_EASSCENSUS_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EASSCENSUS_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EASSCENSUS_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'BuildConsolidatedTable', 'Standard')

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
    -- DETAIL RECORD - U_EASSCENSUS_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EASSCENSUS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EASSCENSUS_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = bdmDepRecID --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeSSN = eepSSN
        ,drvRelation =ConRelationship
        ,drvSpouseandorChildSSN = ConSSN
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvGender = EepGender
        ,drvDOB = EepDateOfBirth
        ,drvDateofHire = EecDateOfLastHire
        ,drvGroupIdentifier = '' -- leave blank
        ,drvHoursWorkedPerWeek = CONVERT(VARCHAR, CONVERT(DECIMAL(10,0), EecScheduledWorkHrs))
        ,drvAnnualSalary = CONVERT(VARCHAR, CONVERT(MONEY, EecAnnSalary))
        ,drvUsedtobaccoLast12mths = '' -- leave blank
        ,drvHeightFT = '' -- leave blank
        ,drvHeightIN = '' -- leave blank
        ,drvWeight = '' -- leave blank
        ,drvMailingAddress1 = '"' + EepAddressLine1 + '"' -- [dbo].[fn_AddDoubleQuotes](EepAddressLine1)
        ,drvMailingAddress2 = '"' + RTRIM(ISNULL(EepAddressLine2, '')) + '"' --[dbo].[fn_AddDoubleQuotes](EepAddressLine2)
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvPhoneNumber = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvBeneficiaryRelationship = ConRelationship
        ,drvBeneficiarySharePercent = ''
        ,drvCompStateSpecificHlthQues = EepAddressState
        ,drvAEPlanType = CASE WHEN bdmdedcode = 'ASACC' THEN 'Accident' ELSE '' END
        ,drvAEInsuredOption = CASE WHEN bdmdedcode = 'ASACC' THEN
                                  CASE
                                    WHEN BdmBenOption IN ('EE', 'EET', 'IND', 'SING') THEN 'EE'
                                    WHEN BdmBenOption IN ('EES', 'EEDP', 'EESTSPS2', 'SPS3') THEN 'ESP'
                                    WHEN BdmBenOption IN ('EEC', 'EECT')  THEN 'ECH'
                                    WHEN BdmBenOption IN ('EEF', 'EEDPF', 'EEFT', 'FAM')  THEN 'FAM' 
                                  END
                              END
        ,drvAEPremiumAmount = '' --leave blank
        ,drvAEIssueDate = ''
        ,drvAESignedDate = CASE WHEN bdmdedcode = 'ASACC' THEN BdmBenStartDate END
        ,drvAETerminationDate =CASE WHEN bdmdedcode = 'ASACC' THEN bdmBenStopDate END  
        ,drvDIPlanType = '' -- leave blank
        ,drvDIBenefitAmount =  '' -- leave blank
        ,drvDIPremiumAmount =  '' -- leave blank
        ,drvDIIssueDate =  '' -- leave blank
        ,drvDISignedDate =  '' -- leave blank
        ,drvDITerminationDate = '' -- leave blank
        ,drvCIPlanType = CASE 
                            WHEN Bdmdedcode = 'ECI10' THEN 'CI 10K'
                            WHEN Bdmdedcode = 'ECI20' THEN 'CI 20K'
                            WHEN Bdmdedcode = 'ECI30' THEN 'CI 30K'
                         END
        ,drvCIInsuredOption = CASE WHEN Bdmdedcode = 'ECI10' THEN
                                  CASE
                                    WHEN BdmBenOption IN ('EE', 'EET', 'IND', 'SING') THEN 'EE'
                                    WHEN BdmBenOption IN ('EES', 'EEDP', 'EESTSPS2', 'SPS3') THEN 'ESP'
                                    WHEN BdmBenOption IN ('EEC', 'EECT')  THEN 'ECH'
                                    WHEN BdmBenOption IN ('EEF', 'EEDPF', 'EEFT', 'FAM')  THEN 'FAM' 
                                  END
                              END
        ,drvCIBenefitAmount = CASE
                                WHEN BdmDedCode = 'ECI10' THEN '10000'
                                WHEN BdmDedCode = 'ECI20' THEN '20000'
                                WHEN BdmDedCode = 'ECI30' THEN '30000' 
                               END
        ,drvCIPremiumAmount = ''
        ,drvCIIssueDate = CASE WHEN Bdmdedcode = 'ECI10' THEN BdmBenStatusDate END -- TODO use the audit date (per vendor: The signed date would be the date that is was last modified)
        ,drvCISignedDate = CASE WHEN Bdmdedcode = 'ECI10' THEN bdmBenStartDate END 
        ,drvCITerminationDate =CASE WHEN Bdmdedcode = 'ECI10' THEN BdmBenStopDate END 
        ,drvCEPlanType = '' -- leave blank 
        ,drvCEInsuredOption = '' -- leave blank 
        ,drvCEBenefitAmount = '' -- leave blank 
        ,drvCEPremiumAmount = '' -- leave blank 
        ,drvCEIssueDate = '' -- leave blank 
        ,drvCESignedDate = '' -- leave blank 
        ,drvCETerminationDate = '' -- leave blank 
        ,drvHIPlanType = CASE WHEN BdmDedCode = 'ASHOS' THEN 'HI' ELSE '' END
        ,drvHIInsuredOption = CASE WHEN Bdmdedcode = 'ASHOS' THEN
                                  CASE
                                    WHEN BdmBenOption IN ('EE', 'EET', 'IND', 'SING') THEN 'EE'
                                    WHEN BdmBenOption IN ('EES', 'EEDP', 'EESTSPS2', 'SPS3') THEN 'ESP'
                                    WHEN BdmBenOption IN ('EEC', 'EECT')  THEN 'ECH'
                                    WHEN BdmBenOption IN ('EEF', 'EEDPF', 'EEFT', 'FAM')  THEN 'FAM' 
                                  END
                              END
        ,drvHIBenefitAmount = CASE WHEN Bdmdedcode = 'ASHOS' THEN  
                                        CASE WHEN BdmDedCode = 'ASHOS' and bdmRecType = 'DEP' THEN bdmUSGField1
                                             WHEN BdmDedCode = 'ASHOS' and bdmRecType = 'EMP' THEN bdmUSGField1
                                        END
                                    END
        ,drvHIPremiumAmount = '' -- leave blank
        ,drvHIIssueDate =  CASE WHEN Bdmdedcode = 'ASHOS' THEN BdmBenStatusDate END  -- TODO use the audit date (per vendor: The signed date would be the date that is was last modified)
        ,drvHISignedDate = CASE WHEN Bdmdedcode = 'ASHOS' THEN bdmBenStartDate END
        ,drvHITerminationDate = CASE WHEN Bdmdedcode = 'ASHOS' THEN bdmBenStopDate END
        ,drvLifePlanType = '' -- leave blank 
        ,drvLifeCertificateAmount = '' -- leave blank 
        ,drvLifeInsuredOption =  '' -- leave blank 
        ,drvLifePremiumAmount = '' -- leave blank
        ,drvLifeIssueDate = '' -- leave blank 
        ,drvLifeSignedDate = '' -- leave blank  
        ,drvLevelTermRiderYN = '' -- leave blank 
        ,drvSpouseCertYN = '' -- leave blank 
        ,drvSpouseCertAmount = '' -- leave blank 
        ,drvChildCertYN = '' -- leave blank 
        ,drvChildCertAmount = '' -- leave blank 
        ,drvChildrensTermInsRider = '' -- leave blank 
        ,drvChildrensTermInsRiderAmnt = '' -- leave blank 
        ,drvLifeTerminationDate = '' -- leave blank 
    INTO dbo.U_EASSCENSUS_drvTbl
    FROM dbo.U_EASSCENSUS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_DSI_BDM_EASSCENSUS WITH (NOLOCK)
    ON BdmEEID = xEEID and BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON conSystemId = BdmDepRecID
    --JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    --    ON EedEEID = xEEID 
    --    AND EedCoID = xCoID
    --    AND EedFormatCode = @FormatCode 
    --    AND EedValidForExport = 'Y'
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
ALTER VIEW dbo.dsi_vwEASSCENSUS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EASSCENSUS_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EASSCENSUS%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101261'
       ,expStartPerControl     = '202101261'
       ,expLastEndPerControl   = '202102029'
       ,expEndPerControl       = '202102029'
WHERE expFormatCode = 'EASSCENSUS';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEASSCENSUS_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EASSCENSUS_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort