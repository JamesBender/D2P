SET NOCOUNT ON;
IF OBJECT_ID('U_EPAGENREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPAGENREXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EPAGENREXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EPAGENREXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEPAGENREXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPAGENREXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPAGENREXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPAGENREXP];
GO
IF OBJECT_ID('U_EPAGENREXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPAGENREXP_PEarHist];
GO
IF OBJECT_ID('U_EPAGENREXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPAGENREXP_PDedHist];
GO
IF OBJECT_ID('U_EPAGENREXP_File') IS NOT NULL DROP TABLE [dbo].[U_EPAGENREXP_File];
GO
IF OBJECT_ID('U_EPAGENREXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPAGENREXP_EEList];
GO
IF OBJECT_ID('U_EPAGENREXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPAGENREXP_drvTbl];
GO
IF OBJECT_ID('U_EPAGENREXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPAGENREXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EPAGENREXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPAGENREXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EPAGENREXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EPAGENREXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EPAGENREXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EPAGENREXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EPAGENREXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) VALUES ('N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','EPAGENREXP','P&G Enrollment Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','N','S','N','EPAGENREXPZ0','N','Jan  1 1900 12:00AM','C','N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"File date "','1','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','1',NULL,'File date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number "','2','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','2',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Level 1 Reporting  "','3','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','3',NULL,'Level 1 Reporting',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Level 2 Reporting "','4','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','4',NULL,'Level 2 Reporting',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Level 3 Reporting "','5','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','5',NULL,'Level 3 Reporting',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name "','6','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','6',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name "','7','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Initial "','8','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','8',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Street Address (1) "','9','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','9',NULL,'Street Address (1)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Street Address (2) "','10','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','10',NULL,'Street Address (2)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City "','11','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State "','12','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip code "','13','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','13',NULL,'Zip code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email address "','14','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','14',NULL,'Email address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth "','15','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','15',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Deduction Cycle "','16','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','16',NULL,'Payroll Deduction Cycle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID "','17','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','17',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Termination Date "','18','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','18',NULL,'Employee Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Rehire Date "','19','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','19',NULL,'Employee Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee LOA Date "','20','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','20',NULL,'Employee LOA Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Return LOA Date "','21','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','21',NULL,'Employee Return LOA Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Bank Routing Number "','22','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','22',NULL,'Bank Routing Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Bank Account Number "','23','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','23',NULL,'Bank Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Bank Account Type "','24','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','24',NULL,'Bank Account Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PPA Number "','25','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','25',NULL,'PPA Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Number "','26','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','26',NULL,'Client Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health care FSA Effective Date "','27','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','27',NULL,'Health care FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health care FSA Annual Election "','28','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','28',NULL,'Health care FSA Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health care FSA Payroll Deduction amount "','29','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','29',NULL,'Health care FSA Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health care FSA Termination date "','30','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','30',NULL,'Health care FSA Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Daycare FSA Effective Date "','31','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','31',NULL,'Dependent Daycare FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Daycare FSA Annual Election "','32','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','32',NULL,'Dependent Daycare FSA Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Daycare FSA Payroll Deduction amount "','33','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','33',NULL,'Dependent Daycare FSA Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Daycare FSA Termination Date "','34','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','34',NULL,'Dependent Daycare FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAD "','35','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','35',NULL,'PAD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Individual Premium  Reimbursement FSA Effective Date "','36','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','36',NULL,'Individual Premium  Reimbursement FSA Effective Da',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Individual Premium Reimbursement FSA  Annual "','37','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','37',NULL,'Individual Premium Reimbursement FSA  Annual',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Individual Premium  Reimbursement FSAPayroll  Deduction amount  "','38','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','38',NULL,'Individual Premium  Reimbursement FSAPayroll  Dedu',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Individual Premium  Reimbursement FSA  Termination date  "','39','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','39',NULL,'Individual Premium  Reimbursement FSA  Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Adoption Assistance FSA Effective Date "','40','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','40',NULL,'Adoption Assistance FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Adoption Assistance FSA Annual Election "','41','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','41',NULL,'Adoption Assistance FSA Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Adoption Assistance FSA Payroll Deduction amount "','42','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','42',NULL,'Adoption Assistance FSA Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Adoption Assistance FSA Termination date "','43','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','43',NULL,'Adoption Assistance FSA Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Parking Effective Date "','44','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','44',NULL,'Parking Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Parking Annual Election "','45','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','45',NULL,'Parking Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Parking Payroll Deduction amount "','46','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','46',NULL,'Parking Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Parking Termination date "','47','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','47',NULL,'Parking Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Transit Effective Date "','48','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','48',NULL,'Transit Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Transit  Annual Election "','49','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','49',NULL,'Transit  Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Transit Payroll Deduction amount "','50','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','50',NULL,'Transit Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Transit Termination date "','51','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','51',NULL,'Transit Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Limited Purpose HCFSA Effective Date "','52','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','52',NULL,'Limited Purpose HCFSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Limited Purposed HCFSA Annual Election  Payroll Deduction amount "','53','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','53',NULL,'Limited Purposed HCFSA Annual Election  Payroll De',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Limited Purpose HCFSA Payroll Deduction amount "','54','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','54',NULL,'Limited Purpose HCFSA Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Limited Purpose HCFSA Termination date "','55','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','55',NULL,'Limited Purpose HCFSA Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HRA Effective Date "','56','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','56',NULL,'HRA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HRA Annual Election "','57','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','57',NULL,'HRA Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HRA Payroll Deduction amount "','58','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','58',NULL,'HRA Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HRA  Termination date "','59','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','59',NULL,'HRA  Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HRP Effective Date "','60','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','60',NULL,'HRP Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HRP Annual Election "','61','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','61',NULL,'HRP Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HRP  Payroll Deduction amount "','62','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','62',NULL,'HRP  Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HRP  Termination date "','63','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','63',NULL,'HRP  Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Debit card "','64','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','64',NULL,'Debit card',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ER Funded Health FSA Effective  Date"','65','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','65',NULL,' ER Funded Health FSA Effective  Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ER Funded Health FSA Annual Election "','66','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','66',NULL,' ER Funded Health FSA Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ER Funded Health FSA Contribution amount "','67','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','67',NULL,' ER Funded Health FSA Contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ER Funded Health FSA Termination date "','68','(''DA''=''T,'')','EPAGENREXPZ0','50','H','01','68',NULL,' ER Funded Health FSA Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDate"','1','(''UD112''=''T,'')','EPAGENREXPZ0','50','D','10','1',NULL,'File date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','2',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLevel1"','3','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','3',NULL,'Level 1 Reporting',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLevel2"','4','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','4',NULL,'Level 2 Reporting',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLevel3"','5','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','5',NULL,'Level 3 Reporting',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','6',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','8','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','8',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','9',NULL,'Street Address (1)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','10',NULL,'Street Address (2)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','11','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','12','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCoe"','13','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','13',NULL,'Zip code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','14','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','14',NULL,'Email address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','15','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','15',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDedCycle"','16','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','16',NULL,'Payroll Deduction Cycle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpId"','17','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','17',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','18','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','18',NULL,'Employee Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','19','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','19',NULL,'Employee Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOADate"','20','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','20',NULL,'Employee LOA Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAReturnDate"','21','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','21',NULL,'Employee Return LOA Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRoutingNumber"','22','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','22',NULL,'Bank Routing Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountNumber"','23','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','23',NULL,'Bank Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountType"','24','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','24',NULL,'Bank Account Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPPANumber"','25','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','25',NULL,'PPA Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientNumber"','26','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','26',NULL,'Client Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAEffectiveDate"','27','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','27',NULL,'Health care FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAYTDElection"','28','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','28',NULL,'Health care FSA Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAPayrollDedAmt"','29','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','29',NULL,'Health care FSA Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSATerminationDate"','30','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','30',NULL,'Health care FSA Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepedentEffectiveDate"','31','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','31',NULL,'Dependent Daycare FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentYTDElection"','32','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','32',NULL,'Dependent Daycare FSA Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentPayrollDedAmt"','33','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','33',NULL,'Dependent Daycare FSA Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentTerminationDate"','34','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','34',NULL,'Dependent Daycare FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPad1"','35','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','35',NULL,'PAD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAReimDate"','36','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','36',NULL,'Individual Premium Reimbursement FSA Effective Dat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReimFSAEffectiveDate"','37','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','37',NULL,'Individual Premium Reimbursement FSA Annual  Elect',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReimFSAElection"','38','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','38',NULL,'Individual Premium Reimbursement FSAPayroll Deduct',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReimFSATermDate"','39','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','39',NULL,'Individual Premium Reimbursement FSA  Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptFSAEffectiveDate"','40','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','40',NULL,'Adoption Assistance FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptFSAYTDElect"','41','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','41',NULL,'Adoption Assistance FSA Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptFSAPayrollDed"','42','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','42',NULL,'Adoption Assistance FSA Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptFSATermDate"','43','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','43',NULL,'Adoption Assistance FSA Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptParkingEffectiveDate"','44','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','44',NULL,'Parking Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptParkingYTDElect"','45','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','45',NULL,'Parking Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptParkingPayrollDed"','46','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','46',NULL,'Parking Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptParkingTermDate"','47','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','47',NULL,'Parking Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptTransitEffectiveDate"','48','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','48',NULL,'Transit Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptTransitYTDElect"','49','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','49',NULL,'Transit  Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptTransitPayrollDed"','50','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','50',NULL,'Transit Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptTransitTermDate"','51','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','51',NULL,'Transit Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptHCFSAEffectiveDate"','52','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','52',NULL,'Limited Purpose HCFSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptHCFSAYTDElect"','53','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','53',NULL,'Limited Purposed HCFSA Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptHCFSAPayrollDed"','54','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','54',NULL,'Limited Purpose HCFSA Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptHCFSATermDate"','55','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','55',NULL,'Limited Purpose HCFSA Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptHRAEffectiveDate"','56','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','56',NULL,'HRA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptHRAYTDElect"','57','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','57',NULL,'HRA Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptHRAPayrollDed"','58','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','58',NULL,'HRA Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptHRATermDate"','59','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','59',NULL,'HRA  Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptHRPEffectiveDate"','60','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','60',NULL,'HRP Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptHRAPTDElect"','61','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','61',NULL,'HRP Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptHRPPayrollDed"','62','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','62',NULL,'HRP  Payroll Deduction amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptHRPTermDate"','63','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','63',NULL,'HRP  Termination date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDebitCard"','64','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','64',NULL,'Debit card',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptERFSAEffectiveDate"','65','(''UDMDY''=''T,'')','EPAGENREXPZ0','50','D','10','65',NULL,' ER Funded Health FSA Effective  Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptERFSATDElect"','66','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','66',NULL,' ER Funded Health FSA Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptERFSAPayrollDed"','67','(''UA''=''T,'')','EPAGENREXPZ0','50','D','10','67',NULL,' ER Funded Health FSA Contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdoptERFSAPTermDate"','68','(''UDMDY''=''T'')','EPAGENREXPZ0','50','D','10','68',NULL,' ER Funded Health FSA Termination date',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\EPAGENREXP_20191113.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'P&G Enrollment Export','201911129','EMPEXPORT','ONDEMAND',NULL,'EPAGENREXP',NULL,NULL,NULL,'201911129','Nov 12 2019  4:17PM','Nov 12 2019  4:17PM','201911121',NULL,'','','201911121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\EPAGENREXP_20191113.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201911129','EMPEXPORT','TEST',NULL,'EPAGENREXP',NULL,NULL,NULL,'201911129','Nov 12 2019  4:17PM','Nov 12 2019  4:17PM','201911121',NULL,'','','201911121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\EPAGENREXP_20191113.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201911129','EMPEXPORT','SCHEDULED',NULL,'EPAGENREXP',NULL,NULL,NULL,'201911129','Nov 12 2019  4:17PM','Nov 12 2019  4:17PM','201911121',NULL,'','','201911121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\EPAGENREXP_20191113.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201911129','EMPEXPORT','OEACTIVE',NULL,'EPAGENREXP',NULL,NULL,NULL,'201911129','Nov 12 2019  4:17PM','Nov 12 2019  4:17PM','201911121',NULL,'','','201911121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\EPAGENREXP_20191113.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201911129','EMPEXPORT','OEPASSIVE',NULL,'EPAGENREXP',NULL,NULL,NULL,'201911129','Nov 12 2019  4:17PM','Nov 12 2019  4:17PM','201911121',NULL,'','','201911121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\EPAGENREXP_20191113.txt' END WHERE expFormatCode = 'EPAGENREXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAGENREXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAGENREXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAGENREXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAGENREXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAGENREXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EPAGENREXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EPAGENREXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EPAGENREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPAGENREXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPAGENREXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPAGENREXP','D10','dbo.U_EPAGENREXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EPAGENREXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPAGENREXP] (
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
IF OBJECT_ID('U_EPAGENREXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EPAGENREXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EPAGENREXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPAGENREXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvFileDate] datetime NOT NULL,
    [drvSSN] char(11) NULL,
    [drvLevel1] varchar(1) NOT NULL,
    [drvLevel2] varchar(1) NOT NULL,
    [drvLevel3] varchar(1) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCoe] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvPayrollDedCycle] char(1) NULL,
    [drvEmpId] char(9) NULL,
    [drvTerminationDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvLOADate] datetime NULL,
    [drvLOAReturnDate] datetime NULL,
    [drvRoutingNumber] varchar(1) NOT NULL,
    [drvAccountNumber] varchar(1) NOT NULL,
    [drvAccountType] varchar(1) NOT NULL,
    [drvPPANumber] varchar(3) NOT NULL,
    [drvClientNumber] varchar(5) NOT NULL,
    [drvFSAEffectiveDate] datetime NULL,
    [drvFSAYTDElection] varchar(12) NULL,
    [drvFSAPayrollDedAmt] varchar(12) NULL,
    [drvFSATerminationDate] datetime NULL,
    [drvDepedentEffectiveDate] datetime NULL,
    [drvDependentYTDElection] varchar(12) NULL,
    [drvDependentPayrollDedAmt] varchar(12) NULL,
    [drvDependentTerminationDate] datetime NULL,
    [drvPad1] varchar(1) NOT NULL,
    [drvFSAReimDate] varchar(1) NOT NULL,
    [drvReimFSAEffectiveDate] varchar(1) NOT NULL,
    [drvReimFSAElection] varchar(1) NOT NULL,
    [drvReimFSATermDate] varchar(1) NOT NULL,
    [drvAdoptFSAEffectiveDate] varchar(1) NOT NULL,
    [drvAdoptFSAYTDElect] varchar(1) NOT NULL,
    [drvAdoptFSAPayrollDed] varchar(1) NOT NULL,
    [drvAdoptFSATermDate] varchar(1) NOT NULL,
    [drvAdoptParkingEffectiveDate] varchar(1) NOT NULL,
    [drvAdoptParkingYTDElect] varchar(1) NOT NULL,
    [drvAdoptParkingPayrollDed] varchar(1) NOT NULL,
    [drvAdoptParkingTermDate] varchar(1) NOT NULL,
    [drvAdoptTransitEffectiveDate] varchar(1) NOT NULL,
    [drvAdoptTransitYTDElect] varchar(1) NOT NULL,
    [drvAdoptTransitPayrollDed] varchar(1) NOT NULL,
    [drvAdoptTransitTermDate] varchar(1) NOT NULL,
    [drvAdoptHCFSAEffectiveDate] datetime NULL,
    [drvAdoptHCFSAYTDElect] varchar(12) NULL,
    [drvAdoptHCFSAPayrollDed] varchar(12) NULL,
    [drvAdoptHCFSATermDate] datetime NULL,
    [drvAdoptHRAEffectiveDate] varchar(1) NOT NULL,
    [drvAdoptHRAYTDElect] varchar(1) NOT NULL,
    [drvAdoptHRAPayrollDed] varchar(1) NOT NULL,
    [drvAdoptHRATermDate] varchar(1) NOT NULL,
    [drvAdoptHRPEffectiveDate] varchar(1) NOT NULL,
    [drvAdoptHRAPTDElect] varchar(1) NOT NULL,
    [drvAdoptHRPPayrollDed] varchar(1) NOT NULL,
    [drvAdoptHRPTermDate] varchar(1) NOT NULL,
    [drvDebitCard] varchar(1) NOT NULL,
    [drvAdoptERFSAEffectiveDate] varchar(1) NOT NULL,
    [drvAdoptERFSATDElect] varchar(1) NOT NULL,
    [drvAdoptERFSAPayrollDed] varchar(1) NOT NULL,
    [drvAdoptERFSAPTermDate] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EPAGENREXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EPAGENREXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EPAGENREXP_File') IS NULL
CREATE TABLE [dbo].[U_EPAGENREXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_EPAGENREXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPAGENREXP_PDedHist] (
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
IF OBJECT_ID('U_EPAGENREXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPAGENREXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [Paygroup] char(6) NOT NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPAGENREXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: UniCarriers America Corp

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 11/12/2019
Service Request Number: TekP-2019-10-10-0006

Purpose: P&G Enrollment Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPAGENREXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPAGENREXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPAGENREXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPAGENREXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPAGENREXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAGENREXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAGENREXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAGENREXP', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPAGENREXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPAGENREXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPAGENREXP';

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
    DELETE FROM dbo.U_EPAGENREXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPAGENREXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '221,220,225';

    IF OBJECT_ID('U_EPAGENREXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPAGENREXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPAGENREXP_DedList
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



    --Update EedBenAmt
    UPDATE dbo.U_dsi_bdm_EPAGENREXP
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EPAGENREXP
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;


    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EPAGENREXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPAGENREXP_PDedHist;
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
    INTO dbo.U_EPAGENREXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPAGENREXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EPAGENREXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPAGENREXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,Paygroup  = PrgPayGroup
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
    INTO dbo.U_EPAGENREXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID,PrgPayGroup
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPAGENREXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPAGENREXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPAGENREXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        -- standard fields above and additional driver fields below
        ,drvFileDate = GETDATE()
        ,drvSSN = eepSSN
        ,drvLevel1 = ''
        ,drvLevel2 = ''
        ,drvLevel3 = ''
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvMiddleInitial = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCoe = EepAddressZipCode
        ,drvEmailAddress = EepAddressEMail
        ,drvDateOfBirth = EepDateOfBirth
        ,drvPayrollDedCycle = (Select top 1 PgrPayFrequency from dbo.PayGroup (NOLOCK) where PgrPayGroup = Paygroup) 
        ,drvEmpId = EecEmpNo
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvRehireDate = CaSE WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN EecDateOfLastHire END 
        ,drvLOADate = CASE WHEN EecEmplStatus  = 'L' THEN EecEmplStatusStartDate END
        ,drvLOAReturnDate = CASE WHEN EecEmplStatus  = 'L' THEN (select  top 1 EshStatusStopDate
                             from EmpHStat (NOLOCK) where eshcoid =  xcoid and esheeid = xeeid order by eshdatetimechanged desc) END
        ,drvRoutingNumber = ''
        ,drvAccountNumber = ''
        ,drvAccountType = ''
        ,drvPPANumber = '999'
        ,drvClientNumber = '31347'
        ,drvFSAEffectiveDate = CASE WHEN FSA_DedCode is not null THEN FSA_BenStartdate END
        ,drvFSAYTDElection = CASE WHEN FSA_DedCode is not null THEN CAST(FSA_GoalAmt as varchar(12)) END
        ,drvFSAPayrollDedAmt = CASE WHEN FSA_DedCode is not null THEN CAST(FSA_DedAmt as varchar(12)) END
        ,drvFSATerminationDate = CASE WHEN FSA_DedCode is not null and FSA_BenStopDate IS NOT NULL THEN FSA_BenStopDate END

        ,drvDepedentEffectiveDate = CASE WHEN DEP_DedCode is not null  THEN DEP_BenStartdate END
        ,drvDependentYTDElection = CASE WHEN DEP_DedCode is not null  THEN CAST(DEP_GoalAmt as varchar(12)) END
        ,drvDependentPayrollDedAmt = CASE WHEN DEP_DedCode is not null  THEN CAST(DEP_DedAmt as varchar(12)) END
        ,drvDependentTerminationDate = CASE WHEN DEP_DedCode is not null and DEP_BenStopDate IS NOT NULL THEN DEP_BenStopDate END
        ,drvPad1 = ''
        ,drvFSAReimDate = ''
        ,drvReimFSAEffectiveDate = ''
        ,drvReimFSAElection = ''
        ,drvReimFSATermDate = ''
        ,drvAdoptFSAEffectiveDate = ''
        ,drvAdoptFSAYTDElect = ''
        ,drvAdoptFSAPayrollDed = ''
        ,drvAdoptFSATermDate = ''
        ,drvAdoptParkingEffectiveDate = ''
        ,drvAdoptParkingYTDElect = ''
        ,drvAdoptParkingPayrollDed = ''
        ,drvAdoptParkingTermDate = ''
        ,drvAdoptTransitEffectiveDate = ''
        ,drvAdoptTransitYTDElect = ''
        ,drvAdoptTransitPayrollDed = ''
        ,drvAdoptTransitTermDate = ''
        ,drvAdoptHCFSAEffectiveDate = CASE WHEN HCFA_DedCode is not null THEN HCFA_BenStartdate END
        ,drvAdoptHCFSAYTDElect = CASE WHEN HCFA_DedCode is not null THEN CAST(HCFA_GoalAmt as varchar(12)) END
        ,drvAdoptHCFSAPayrollDed = CASE WHEN HCFA_DedCode is not null THEN CAST(HCFA_DedAmt as varchar(12)) END
        ,drvAdoptHCFSATermDate = CASE WHEN HCFA_DedCode is not null and  HCFA_BenStopDate IS NOT NULL THEN HCFA_BenStopDate END
        ,drvAdoptHRAEffectiveDate = ''
        ,drvAdoptHRAYTDElect = ''
        ,drvAdoptHRAPayrollDed = ''
        ,drvAdoptHRATermDate = ''
        ,drvAdoptHRPEffectiveDate = ''
        ,drvAdoptHRAPTDElect = ''
        ,drvAdoptHRPPayrollDed = ''
        ,drvAdoptHRPTermDate = ''
        ,drvDebitCard = ''
        ,drvAdoptERFSAEffectiveDate = ''
        ,drvAdoptERFSATDElect = ''
        ,drvAdoptERFSAPayrollDed = ''
        ,drvAdoptERFSAPTermDate = ''
    INTO dbo.U_EPAGENREXP_drvTbl
    FROM dbo.U_EPAGENREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (Select  bdmEEID,bdmcoid
            ,FSA_DedCode = MAX((CASE WHEN BDMDedCode = '220' then BDMDedCode END))
            ,FSA_BenStartdate = MAX((CASE WHEN BDMDedCode = '220' then BdmBenStartDate END))
            ,FSA_GoalAmt = SUM((CASE WHEN BDMDedCode = '220' then BdmEEGoalAMt END))
            ,FSA_DedAmt = SUM((CASE WHEN BDMDedCode = '220' then CAST(BdmUSGField1 as Money) END))
            ,FSA_BenStopDate = MAX((CASE WHEN BDMDedCode = '220' then BdmBenStopDate END))

            ,DEP_DedCode = MAX((CASE WHEN BDMDedCode = '225' then BDMDedCode END))
            ,DEP_BenStartdate = MAX((CASE WHEN BDMDedCode = '225' then BdmBenStartDate END))
            ,DEP_GoalAmt = SUM((CASE WHEN BDMDedCode = '225' then BdmEEGoalAMt END))
            ,DEP_DedAmt = SUM((CASE WHEN BDMDedCode = '225' then CAST(BdmUSGField1 as Money)  END))
            ,DEP_BenStopDate = MAX((CASE WHEN BDMDedCode = '225' then BdmBenStopDate END))
            
            ,HCFA_DedCode = MAX((CASE WHEN BDMDedCode = '221' then BDMDedCode END))
            ,HCFA_BenStartdate = MAX((CASE WHEN BDMDedCode = '221' then BdmBenStartDate END))
            ,HCFA_GoalAmt = SUM((CASE WHEN BDMDedCode = '221' then BdmEEGoalAMt END))
            ,HCFA_DedAmt = SUM((CASE WHEN BDMDedCode = '221' then CAST(BdmUSGField1 as Money)  END))
            ,HCFA_BenStopDate = MAX((CASE WHEN BDMDedCode = '221' then BdmBenStopDate END))

            from U_dsi_BDM_EPAGENREXP  group by bdmEEID,bdmcoid)
             as BdmConsolidated
    ON BdmConsolidated.BdmEEID = xEEID
    AND BdmConsolidated.BdmCOID = xCOID
    LEFT JOIN dbo.U_EPAGENREXP_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID;

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
ALTER VIEW dbo.dsi_vwEPAGENREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPAGENREXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPAGENREXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911051'
       ,expStartPerControl     = '201911051'
       ,expLastEndPerControl   = '201911129'
       ,expEndPerControl       = '201911129'
WHERE expFormatCode = 'EPAGENREXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPAGENREXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EPAGENREXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort