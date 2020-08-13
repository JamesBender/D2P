SET NOCOUNT ON;
IF OBJECT_ID('U_EHSAENREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHSAENREXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EHSAENREXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EHSAENREXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEHSAENREXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHSAENREXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHSAENREXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHSAENREXP];
GO
IF OBJECT_ID('U_EHSAENREXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EHSAENREXP_PEarHist];
GO
IF OBJECT_ID('U_EHSAENREXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EHSAENREXP_PDedHist];
GO
IF OBJECT_ID('U_EHSAENREXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EHSAENREXP_Header];
GO
IF OBJECT_ID('U_EHSAENREXP_File') IS NOT NULL DROP TABLE [dbo].[U_EHSAENREXP_File];
GO
IF OBJECT_ID('U_EHSAENREXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHSAENREXP_EEList];
GO
IF OBJECT_ID('U_EHSAENREXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHSAENREXP_drvTbl];
GO
IF OBJECT_ID('U_EHSAENREXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHSAENREXP_DedList];
GO
IF OBJECT_ID('U_EHSAENREXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EHSAENREXP_AuditFields];
GO
IF OBJECT_ID('U_EHSAENREXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EHSAENREXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EHSAENREXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EHSAENREXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EHSAENREXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EHSAENREXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EHSAENREXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EHSAENREXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EHSAENREXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHSAENREXP','HSA Enrollment Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EHSAENREXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FH"','1','(''DA''=''T,'')','EHSAENREXPZ0','50','H','01','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''T,'')','EHSAENREXPZ0','50','H','01','2',NULL,'Filler ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"099UAC"','3','(''DA''=''T,'')','EHSAENREXPZ0','50','H','01','3',NULL,'Employer or Partner Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hquebbeman@unicarriersamericas.com"','4','(''DA''=''T,'')','EHSAENREXPZ0','50','H','01','4',NULL,'Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentDate"','5','(''UDMDY''=''T,'')','EHSAENREXPZ0','50','H','01','5',NULL,'Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordTotal"','6','(''UA''=''T,'')','EHSAENREXPZ0','50','H','01','6',NULL,'Number of Records ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"2.2.0"','7','(''DA''=''T,'')','EHSAENREXPZ0','50','H','01','7',NULL,'File Version Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T'')','EHSAENREXPZ0','50','H','01','8',NULL,'Filler ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PT"','1','(''DA''=''T,'')','EHSAENREXPZ0','50','D','10','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','2','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','2',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','3','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','3',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','4','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','4',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInit"','5','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','5',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','6','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','6',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','7','(''UDMDY''=''T,'')','EHSAENREXPZ0','50','D','10','7',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','8','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','8',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','9','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','9',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EHSAENREXPZ0','50','D','10','10',NULL,'Filler ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailingMethod"','11','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','11',NULL,'Mailing method',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStrAddress1"','12','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','12',NULL,'Street Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStrAddress2"','13','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','13',NULL,'Street Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStrCity"','14','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','14',NULL,'Street City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStrState"','15','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','15',NULL,'Street State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStrZipCode"','16','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','16',NULL,'Street Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStrCountry"','17','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','17',NULL,'Street Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailAddress1"','18','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','18',NULL,'Mailing Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailAddress2"','19','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','19',NULL,'Mailing Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailCity"','20','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','20',NULL,'Mailing City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailState"','21','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','21',NULL,'Mailing State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailZipCode"','22','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','22',NULL,'Mailing Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailCountry"','23','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','23',NULL,'Mailing Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','24','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','24',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBussPhone"','25','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','25',NULL,'Business Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBussPhoneExt"','26','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','26',NULL,'Business Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','27','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','27',NULL,'Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmpStatus"','28','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','28',NULL,'Participant Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusEffDate"','29','(''UDMDY''=''T,'')','EHSAENREXPZ0','50','D','10','29',NULL,'Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCitizenStatus"','30','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','30',NULL,'Citizenship Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryOfCitizen"','31','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','31',NULL,'Country of Citizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatus"','32','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','32',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerName"','33','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','33',NULL,'Employer Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','34','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','34',NULL,'Job Title/Profession',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','35','(''UDMDY''=''T,'')','EHSAENREXPZ0','50','D','10','35',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','36','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','36',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursPerWeek"','37','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','37',NULL,'Hour Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeClass"','38','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','38',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFreq"','39','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','39',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFreqEffDate"','40','(''UDMDY''=''T,'')','EHSAENREXPZ0','50','D','10','40',NULL,'Payroll Frequency Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFinalPayProcDate"','41','(''UDMDY''=''T,'')','EHSAENREXPZ0','50','D','10','41',NULL,'Final Payroll Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribProcDate"','42','(''UDMDY''=''T,'')','EHSAENREXPZ0','50','D','10','42',NULL,'Final Contirbution Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','43','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','43',NULL,'FedID/Employer Identification Number (EIN)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanPref"','44','(''UA''=''T,'')','EHSAENREXPZ0','50','D','10','44',NULL,'Plan Preference',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T,'')','EHSAENREXPZ0','50','D','10','45',NULL,'Filler 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T,'')','EHSAENREXPZ0','50','D','10','46',NULL,'Filler 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T,'')','EHSAENREXPZ0','50','D','10','47',NULL,'Filler 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T,'')','EHSAENREXPZ0','50','D','10','48',NULL,'Filler 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T,'')','EHSAENREXPZ0','50','D','10','49',NULL,'Filler 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T,'')','EHSAENREXPZ0','50','D','10','50',NULL,'Filler 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T,'')','EHSAENREXPZ0','50','D','10','51',NULL,'Filler 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T,'')','EHSAENREXPZ0','50','D','10','52',NULL,'Filler 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T,'')','EHSAENREXPZ0','50','D','10','53',NULL,'Filler 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T,'')','EHSAENREXPZ0','50','D','10','54',NULL,'Filler 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T'')','EHSAENREXPZ0','50','D','10','55',NULL,'Filler 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EN"','1','(''DA''=''T,'')','EHSAENREXPZ0','50','D','20','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','2','(''UA''=''T,'')','EHSAENREXPZ0','50','D','20','2',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanType"','3','(''UA''=''T,'')','EHSAENREXPZ0','50','D','20','3',NULL,'Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','4','(''UA''=''T,'')','EHSAENREXPZ0','50','D','20','4',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollEffDate"','5','(''UDMDY''=''T,'')','EHSAENREXPZ0','50','D','20','5',NULL,'Enrollment Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartElectAmt"','6','(''UA''=''T,'')','EHSAENREXPZ0','50','D','20','6',NULL,'Participant Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContLvl"','7','(''UA''=''T,'')','EHSAENREXPZ0','50','D','20','7',NULL,'Employer Contribution Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContAmt"','8','(''UA''=''T,'')','EHSAENREXPZ0','50','D','20','8',NULL,'Employer Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimaryReimburse"','9','(''UA''=''T,'')','EHSAENREXPZ0','50','D','20','9',NULL,'Primary Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAltReimburse"','10','(''UA''=''T,'')','EHSAENREXPZ0','50','D','20','10',NULL,'Alternate Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollClaimsExchng"','11','(''UA''=''T,'')','EHSAENREXPZ0','50','D','20','11',NULL,'Enrolled in Claims Exchange',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drcElecAmountInd"','12','(''UA''=''T,'')','EHSAENREXPZ0','50','D','20','12',NULL,'Election Amount Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDHPCovLevel"','13','(''UA''=''T,'')','EHSAENREXPZ0','50','D','20','13',NULL,'HDHP Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYearStartDate"','14','(''UDMDY''=''T,'')','EHSAENREXPZ0','50','D','20','14',NULL,'Plan Year Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollTermDate"','15','(''UDMDY''=''T,'')','EHSAENREXPZ0','50','D','20','15',NULL,'Enrollment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T,'')','EHSAENREXPZ0','50','D','20','16',NULL,'Filler 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T,'')','EHSAENREXPZ0','50','D','20','17',NULL,'Filler 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T,'')','EHSAENREXPZ0','50','D','20','18',NULL,'Filler 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T,'')','EHSAENREXPZ0','50','D','20','19',NULL,'Filler 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T,'')','EHSAENREXPZ0','50','D','20','20',NULL,'Filler 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T,'')','EHSAENREXPZ0','50','D','20','21',NULL,'Filler 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T,'')','EHSAENREXPZ0','50','D','20','22',NULL,'Filler 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T,'')','EHSAENREXPZ0','50','D','20','23',NULL,'Filler 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T,'')','EHSAENREXPZ0','50','D','20','24',NULL,'Filler 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T'')','EHSAENREXPZ0','50','D','20','25',NULL,'Filler 10',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHSAENREXP_20191220.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202001011','EMPEXPORT','OEACTIVE','Nov 26 2019  6:49AM','EHSAENREXP',NULL,NULL,NULL,'202001011','Jan  1 2020 12:00AM','Dec 30 1899 12:00AM','201901011','265','','','201901011',dbo.fn_GetTimedKey(),NULL,'us3jBeNIS1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHSAENREXP_20191220.txt',NULL,'','','',NULL,NULL,NULL,'HSA Enrollment Export','202001019','EMPEXPORT','ONDEMAND','Nov 26 2019  6:50AM','EHSAENREXP',NULL,NULL,NULL,'202001019','Jan  1 2020 12:00AM','Dec 30 1899 12:00AM','201901011','443','','','201901011',dbo.fn_GetTimedKey(),NULL,'us3jBeNIS1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHSAENREXP_20191220.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202001011','EMPEXPORT','SCHEDULED','Nov 26 2019  6:51AM','EHSAENREXP',NULL,NULL,NULL,'202001011','Jan  1 2020 12:00AM','Dec 30 1899 12:00AM','201901011','443','','','201901011',dbo.fn_GetTimedKey(),NULL,'us3jBeNIS1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHSAENREXP_20191220.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202001319','EMPEXPORT','OEPASSIVE','Dec 13 2019 11:07AM','EHSAENREXP',NULL,NULL,NULL,'202001319','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','202001011','399','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3lKiNIS1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHSAENREXP_20191220.txt',NULL,'','','EKBYF,WXL0D,WCO05,IAGFG,IW55O',NULL,NULL,NULL,'Test Purposes Only','201912139','EMPEXPORT','TEST','Dec 13 2019  7:16PM','EHSAENREXP',NULL,NULL,NULL,'201912139','Dec 13 2019 12:00AM','Dec 30 1899 12:00AM','201912011','387','','','201912011',dbo.fn_GetTimedKey(),NULL,'us3lKiNIS1000',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EHSAENREXP_20191220.txt' END WHERE expFormatCode = 'EHSAENREXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHSAENREXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHSAENREXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHSAENREXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHSAENREXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHSAENREXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHSAENREXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EHSAENREXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EHSAENREXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EHSAENREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHSAENREXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHSAENREXP','H01','dbo.U_EHSAENREXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHSAENREXP','D10','dbo.U_EHSAENREXPParticipant_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHSAENREXP','D20','dbo.U_EHSAENREXPEnrollment_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EHSAENREXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EHSAENREXP] (
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
IF OBJECT_ID('U_EHSAENREXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EHSAENREXP_Audit] (
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
IF OBJECT_ID('U_EHSAENREXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EHSAENREXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EHSAENREXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EHSAENREXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EHSAENREXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHSAENREXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInit] varchar(1) NULL,
    [drvSSN] char(11) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvMailingMethod] varchar(1) NOT NULL,
    [drvStrAddress1] varchar(255) NULL,
    [drvStrAddress2] varchar(255) NULL,
    [drvStrCity] varchar(255) NULL,
    [drvStrState] varchar(255) NULL,
    [drvStrZipCode] varchar(50) NULL,
    [drvStrCountry] char(3) NULL,
    [drvMailAddress1] varchar(255) NULL,
    [drvMailAddress2] varchar(255) NULL,
    [drvMailCity] varchar(255) NULL,
    [drvMailState] varchar(255) NULL,
    [drvMailZipCode] varchar(50) NULL,
    [drvMailCountry] char(3) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvBussPhone] varchar(1) NOT NULL,
    [drvBussPhoneExt] char(5) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvPartEmpStatus] varchar(1) NOT NULL,
    [drvStatusEffDate] varchar(1) NOT NULL,
    [drvCitizenStatus] varchar(1) NOT NULL,
    [drvCountryOfCitizen] char(3) NULL,
    [drvEmpStatus] varchar(1) NOT NULL,
    [drvEmployerName] varchar(1) NOT NULL,
    [drvJobTitle] varchar(1) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvHoursPerWeek] varchar(1) NOT NULL,
    [drvEmployeeClass] varchar(1) NOT NULL,
    [drvPayFreq] varchar(1) NOT NULL,
    [drvPayFreqEffDate] varchar(1) NOT NULL,
    [drvFinalPayProcDate] varchar(1) NOT NULL,
    [drvContribProcDate] varchar(1) NOT NULL,
    [drvEIN] varchar(1) NOT NULL,
    [drvPlanPref] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EHSAENREXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EHSAENREXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EHSAENREXP_File') IS NULL
CREATE TABLE [dbo].[U_EHSAENREXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EHSAENREXP_Header') IS NULL
CREATE TABLE [dbo].[U_EHSAENREXP_Header] (
    [drvCurrentDate] datetime NOT NULL,
    [drvRecordTotal] int NULL
);
IF OBJECT_ID('U_EHSAENREXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EHSAENREXP_PDedHist] (
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
IF OBJECT_ID('U_EHSAENREXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EHSAENREXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHSAENREXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: UniCarriers America Corp.

Created By: James Bender
Business Analyst: Lea King
Create Date: 11/25/2019
Service Request Number: TekP-2019-10-18-0005

Purpose: HSA Enrollment Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHSAENREXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHSAENREXP';
SELECT * FROM dbo.U_dsdi_Parameters WHERE FormatCode = 'EHSAENREXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHSAENREXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHSAENREXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHSAENREXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHSAENREXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHSAENREXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHSAENREXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHSAENREXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EHSAENREXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@CmmFedTaxId        CHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EHSAENREXP';
    SELECT TOP 1 @CmmFedTaxId = CmmFedTaxId from CompMast -- XX

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
    --DELETE FROM dbo.U_EHSAENREXP_EEList
    --WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    --AND xEEID IN (SELECT xEEID FROM dbo.U_EHSAENREXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EHSAENREXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EHSAENREXP_AuditFields;
    CREATE TABLE dbo.U_EHSAENREXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EHSAENREXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHSAENREXP_Audit;
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
    INTO dbo.U_EHSAENREXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EHSAENREXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EHSAENREXP_Audit ON dbo.U_EHSAENREXP_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
   /* DELETE FROM dbo.U_EHSAENREXP_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EHSAENREXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    */

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '275,278,274,276,279,277,211,210,HSFCU,HSAF,HSACU,211';

    IF OBJECT_ID('U_EHSAENREXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHSAENREXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHSAENREXP_DedList
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

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EHSAENREXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHSAENREXP_PDedHist;
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
    INTO dbo.U_EHSAENREXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EHSAENREXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EHSAENREXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHSAENREXP_PEarHist;
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
    INTO dbo.U_EHSAENREXP_PEarHist
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
    -- DETAIL RECORD - U_EHSAENREXPParticipant_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHSAENREXPParticipant_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHSAENREXPParticipant_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '6' + EEPSSN
        ,drvSubSort = 4
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInit = LEFT(EepNameMiddle,1)
        ,drvSSN = eepSSN
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus = 'S' THEN 'S'
                                WHEN eepMaritalStatus = 'M' THEN 'M'
                                ELSE 'U'
                            END
        ,drvMailingMethod = CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR --THEN 'PO' 
                                    CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN 'PO' 
                                ELSE 'ST' 
                            END
        ,drvStrAddress1 =    CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR
                                    CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN '' 
                                ELSE EepAddressLine1
                            END
        ,drvStrAddress2 =    CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR
                                CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN ''
                                ELSE EepAddressLine2 
                            END
        ,drvStrCity =    CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR
                                CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN ''
                                ELSE EepAddressCity 
                            END
        ,drvStrState =    CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR
                            CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN ''
                            ELSE EepAddressState
                        END
        ,drvStrZipCode =    CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR
                                CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN ''
                                ELSE EepAddressZipCode
                            END
        ,drvStrCountry =    CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR
                                CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN ''
                                ELSE 'US'
                            END
        ,drvMailAddress1 = CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR
                                CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN EepAddressLine1
                                ELSE ''
                            END
        ,drvMailAddress2 = CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR
                                CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN EepAddressLine2
                            END
        ,drvMailCity = CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR
                            CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN EepAddressCity
                        END
        ,drvMailState = CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR
                            CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN EepAddressState
                        END
        ,drvMailZipCode = CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR
                            CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN EepAddressZipCode
                        END
        ,drvMailCountry = CASE WHEN CHARINDEX('PO BOX', UPPER(EepAddressLine1)) > 0 OR
                            CHARINDEX('P.O. BOX', UPPER(EepAddressLine1)) > 0 THEN 'US'
                        END
        ,drvHomePhone = '' --EepPhoneHomeNumber
        ,drvBussPhone = ''
        ,drvBussPhoneExt = '' --EecPhoneBusinessExt
        ,drvEmailAddress = '' --EepAddressEMail
        ,drvPartEmpStatus = CASE EecEmplStatus
                                WHEN 'T' THEN 'T'
                                WHEN 'L' THEN 'L'
                                ELSE 'A'
                            END
        ,drvStatusEffDate = CASE EecEmplStatus
                                WHEN 'T' THEN EecDateOfTermination
                                WHEN 'L' THEN EecEmplStatusStartDate
                                ELSE EecDateOfLastHire
                            END
        ,drvCitizenStatus = 'US'
        ,drvCountryOfCitizen = '' --EepAddressCountry
        ,drvEmpStatus = 'E'
        ,drvEmployerName = 'Mitsubishi Logisnext Americas Inc'
        ,drvJobTitle = REPLACE(JbcDesc, ',', '')
        ,drvHireDate = EecDateOfLastHire
        ,drvDivision = ''
        ,drvHoursPerWeek = ''
        ,drvEmployeeClass = 'CL'
        ,drvPayFreq = 'O' --PgrPayFrequency
        ,drvPayFreqEffDate = ''
        ,drvFinalPayProcDate = ''
        ,drvContribProcDate = ''
        ,drvEIN = @CmmFedTaxId 
        ,drvPlanPref = ''
    INTO dbo.U_EHSAENREXPParticipant_drvTbl
    FROM dbo.U_EHSAENREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID        
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup    
    WHERE EecEEType NOT IN ('TES')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EHSAENREXPEnrollment_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHSAENREXPEnrollment_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHSAENREXPEnrollment_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '6' + EepSSN
        ,drvSubSort = 6
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvPlanType = 'HSA'
        ,drvPlanName = 'Health Savings Account'
        ,drvEnrollEffDate = EedBenStartDate
        ,drvPartElectAmt = ''
        ,drvEmployerContLvl = ''
        ,drvEmployerContAmt = ''
        ,drvPrimaryReimburse = ''
        ,drvAltReimburse = ''
        ,drvEnrollClaimsExchng = ''
        ,drcElecAmountInd = 'PY'
        ,drvHDHPCovLevel =    CASE WHEN EedDedCode in ('274', '277', '210', 'HSACU') THEN 'S'
                                WHEN EedDedCode in ('275', '278', '276', '279', '211', 'HSFCU', 'HSAF', '212') THEN 'F'
                            END
        ,drvPlanYearStartDate = ''
        ,drvEnrollTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
    INTO dbo.U_EHSAENREXPEnrollment_drvTbl
    FROM dbo.U_EHSAENREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EHSAENREXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EHSAENREXP_Header;
    SELECT DISTINCT
         drvCurrentDate = GETDATE()
        ,drvRecordTotal = ((SELECT COUNT(*) from dbo.U_EHSAENREXPParticipant_drvTbl WITH (NOLOCK)) + (SELECT COUNT(*) from dbo.U_EHSAENREXPEnrollment_drvTbl WITH (NOLOCK)))
    INTO dbo.U_EHSAENREXP_Header
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
ALTER VIEW dbo.dsi_vwEHSAENREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHSAENREXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHSAENREXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911181'
       ,expStartPerControl     = '201911181'
       ,expLastEndPerControl   = '201911259'
       ,expEndPerControl       = '201911259'
WHERE expFormatCode = 'EHSAENREXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHSAENREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHSAENREXP_File (NOLOCK)
    ORDER BY InitialSort, SubSort;