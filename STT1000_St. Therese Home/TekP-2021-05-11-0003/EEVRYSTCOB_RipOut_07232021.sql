SET NOCOUNT ON;
IF OBJECT_ID('U_EEVRYSTCOB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEVRYSTCOB_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EEVRYSTCOB_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EEVRYSTCOB' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEEVRYSTCOB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEVRYSTCOB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEVRYSTCOB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEVRYSTCOB];
GO
IF OBJECT_ID('U_EEVRYSTCOB_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EEVRYSTCOB_PEarHist];
GO
IF OBJECT_ID('U_EEVRYSTCOB_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EEVRYSTCOB_PDedHist];
GO
IF OBJECT_ID('U_EEVRYSTCOB_File') IS NOT NULL DROP TABLE [dbo].[U_EEVRYSTCOB_File];
GO
IF OBJECT_ID('U_EEVRYSTCOB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEVRYSTCOB_EEList];
GO
IF OBJECT_ID('U_EEVRYSTCOB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEVRYSTCOB_drvTbl];
GO
IF OBJECT_ID('U_EEVRYSTCOB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EEVRYSTCOB_DedList];
GO
IF OBJECT_ID('U_EEVRYSTCOB_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EEVRYSTCOB_AuditFields];
GO
IF OBJECT_ID('U_EEVRYSTCOB_Audit') IS NOT NULL DROP TABLE [dbo].[U_EEVRYSTCOB_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EEVRYSTCOB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EEVRYSTCOB];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEVRYSTCOB';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEVRYSTCOB';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEVRYSTCOB';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEVRYSTCOB';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEVRYSTCOB';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EEVRYSTCOB','Everything Benefits COBRA','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','7000','S','N','EEVRYSTCOBZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EEVRYSTCOB' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Record Type"','1','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship To Employee"','2','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','2',NULL,'ReltoEmployee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Organization: System Id"','3','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','3',NULL,'OrgSysId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Organization: Name"','4','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','4',NULL,'OrgName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Organization: EIN"','5','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','5',NULL,'OrgEIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: System Id"','6','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','6',NULL,'EmpSysId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Username"','7','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','7',NULL,'EmpUser',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: SSN"','8','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','8',NULL,'EmpSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Number"','9','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','9',NULL,'EmpNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: First Name"','10','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','10',NULL,'EmpFName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Last Name"','11','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','11',NULL,'EmpLName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Middle Name"','12','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','12',NULL,'EmpMName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Name Suffix"','13','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','13',NULL,'EmpSuffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Name Prefix"','14','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','14',NULL,'EmpPrefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Date Of Birth"','15','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','15',NULL,'EmpDOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Date Of Death"','16','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','16',NULL,'EmpDOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Email Address"','17','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','17',NULL,'EmpEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Address Line1"','18','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','18',NULL,'EmpAdd1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Address Line2"','19','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','19',NULL,'EmpAdd2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Address Line3"','20','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','20',NULL,'EmpAdd3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Address City"','21','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','21',NULL,'EmpCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Address County"','22','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','22',NULL,'EmpCounty',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Address State"','23','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','23',NULL,'EmpState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Address Zip"','24','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','24',NULL,'EmpZip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Home Phone"','25','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','25',NULL,'EmpHPh',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Work Phone"','26','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','26',NULL,'EmpWPh',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Gender"','27','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','27',NULL,'EmpGen',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Marital Status"','28','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','28',NULL,'EmpMaritalStat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Date Married"','29','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','29',NULL,'EmpDtMarried',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Race Or Ethnicity"','30','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','30',NULL,'EmpRace',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Citizenship Status"','31','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','31',NULL,'EmpCitizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Is Handicapped"','32','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','32',NULL,'EmpHandicap',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Is Hospitalized"','33','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','33',NULL,'EmpHospital',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Is Smoker"','34','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','34',NULL,'EmpSmoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee: Language"','35','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','35',NULL,'EmpLanguage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Date Started"','36','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','36',NULL,'EmptDtStart',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Date Terminated"','37','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','37',NULL,'EmptDtTerm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Termination Reason"','38','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','38',NULL,'EmptTermReason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Date Hired"','39','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','39',NULL,'EmptDtHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Date Original Hired"','40','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','40',NULL,'EmptDtOrigHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Date Benefit Eligible"','41','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','41',NULL,'EmptDtBenElig',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Date Retired"','42','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','42',NULL,'EmptDtRet',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Number"','43','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','43',NULL,'EmptNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Status"','44','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','44',NULL,'EmptStat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Type"','45','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','45',NULL,'EmptType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Full Time"','46','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','46',NULL,'EmptFullTime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Exempt: Status"','47','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','47',NULL,'EmptExStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Region"','48','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','48',NULL,'EmptRegion',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Division"','49','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','49',NULL,'EmptDiv',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Department"','50','(''DA''=''T,'')','EEVRYSTCOBZ0','50','H','01','50',NULL,'EmptDep',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Location"','51','(''DA''=''T,'')','EEVRYSTCOBZ0','51','H','01','51',NULL,'EmptLoc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Job Title"','52','(''DA''=''T,'')','EEVRYSTCOBZ0','52','H','01','52',NULL,'EmptJobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Job Code"','53','(''DA''=''T,'')','EEVRYSTCOBZ0','53','H','01','53',NULL,'EmptJobCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Percent Of Ownership"','54','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','54',NULL,'EmptPercOfOwner',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Is Corporate Officer"','55','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','55',NULL,'EmptIsCorpOfficer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Is Key Employee"','56','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','56',NULL,'EmptIsKeyEmp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Is Highly Compensated"','57','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','57',NULL,'EmptIsHighComp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Union"','58','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','58',NULL,'EmptUnion',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Medical Eligibility"','59','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','59',NULL,'EmptMedElig',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Compensation: Annual Amount"','60','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','60',NULL,'EmptCompAnnAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Compensation: Number Pay Periods Per Year"','61','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','61',NULL,'EmpCompNumPay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Compensation: Hourly Rate"','62','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','62',NULL,'EmpCompHrlyRate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Compensation: Effective From"','63','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','63',NULL,'EmptCompEffFrom',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment: Weekly Hours"','64','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','64',NULL,'EmptWeeklyHrs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: System Id"','65','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','65',NULL,'ConSysId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: SSN"','66','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','66',NULL,'ConSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: First Name"','67','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','67',NULL,'ConFName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Last Name"','68','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','68',NULL,'ConLName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Middle Name"','69','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','69',NULL,'ConMName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Name Suffix"','70','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','70',NULL,'ConNameSuffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Name Prefix"','71','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','71',NULL,'ConNamePrefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Date Of Birth"','72','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','72',NULL,'ConDOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Date Of Death"','73','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','73',NULL,'ConDOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Email Address"','74','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','74',NULL,'ConEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Address Line1"','75','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','75',NULL,'ConAddr1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Address Line2"','76','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','76',NULL,'ConAddr2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Address Line3"','77','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','77',NULL,'ConAddr3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Address City"','78','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','78',NULL,'ConAddCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Address County"','79','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','79',NULL,'ConAddCounty',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Address State"','80','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','80',NULL,'ConAddState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Address Zip"','81','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','81',NULL,'ConAddZip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Home Phone"','82','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','82',NULL,'ConHPh',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Work Phone"','83','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','83',NULL,'ConWPh',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Gender"','84','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','84',NULL,'ConGen',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Marital Status"','85','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','85',NULL,'ConMaritalStat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Race Or Ethnicity"','86','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','86',NULL,'ConRace',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Citizenship Status"','87','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','87',NULL,'ConCitizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Is Handicapped"','88','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','88',NULL,'ConHandicapped',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Is Hospitalized"','89','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','89',NULL,'ConHospital',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Is Smoker"','90','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','90',NULL,'ConSmoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Language"','91','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','91',NULL,'ConLanguage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: IRS Qualified Dependent"','92','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','92',NULL,'ConIRSQualDep',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contact: Full Time Student"','93','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','93',NULL,'ConFullTimeStudent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Carrier: Name"','94','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','94',NULL,'BenCarName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Carrier: EIN"','95','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','95',NULL,'BenCarEIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Type"','96','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','96',NULL,'BenType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Plan Name"','97','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','97',NULL,'BenPlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Policy Number: 1"','98','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','98',NULL,'BenPolNum1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Policy Number: 2"','99','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','99',NULL,'BenPolNum2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Policy Number: 3"','100','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','100',NULL,'BenPolNum3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Policy Number: 4"','101','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','101',NULL,'BenPolNum4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Policy Number: 5"','102','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','102',NULL,'BenPolNum5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Effective: From"','103','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','103',NULL,'BenEffFrom',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Effective: Last Date"','104','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','104',NULL,'BenEffLastDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Original Effective From"','105','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','105',NULL,'BenOrigEffFrom',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Coverage: Level"','106','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','106',NULL,'BenCovLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Is Waived"','107','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','107',NULL,'BenIsWaived',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Base Coverage Amount"','108','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','108',NULL,'BenBaseCovAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Approved Coverage Amount"','109','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','109',NULL,'BenAppCovAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Requested Coverage Amount"','110','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','110',NULL,'BenReqCovAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Employee Premium"','111','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','111',NULL,'BenEmpPremium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Employer Premium"','112','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','112',NULL,'BenEmployerPremium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Number Deductions Per Year"','113','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','113',NULL,'BenNumDedPerYear',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Salary"','114','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','114',NULL,'BenSalary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Medical Office #"','115','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','115',NULL,'BenMedOfficeNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Medical Office Provider Name"','116','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','116',NULL,'BenMedOfficeProviderName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit: Medical Office Provider Address"','117','(''DA''=''T,'')','EEVRYSTCOBZ0','54','H','01','117',NULL,'BenMedOfficeProviderAdd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Beneficiary: Percent"','118','(''DA''=''T'')','EEVRYSTCOBZ0','54','H','01','118',NULL,'BenPercent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','1','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReltoEmp"','2','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','2',NULL,'ReltoEmployee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgSysId"','3','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','3',NULL,'OrgSysId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgName"','4','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','4',NULL,'OrgName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgEIN"','5','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','5',NULL,'OrgEIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSysId"','6','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','6',NULL,'EmpSysId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpUser"','7','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','7',NULL,'EmpUser',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','8','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','8',NULL,'EmpSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNum"','9','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','9',NULL,'EmpNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFName"','10','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','10',NULL,'EmpFName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLName"','11','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','11',NULL,'EmpLName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMName"','12','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','12',NULL,'EmpMName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSuffi"','13','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','13',NULL,'EmpSuffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPrefi"','14','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','14',NULL,'EmpPrefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDOB"','15','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','15',NULL,'EmpDOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDOD"','16','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','16',NULL,'EmpDOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpEmail"','17','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','17',NULL,'EmpEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAdd1"','18','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','18',NULL,'EmpAdd1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAdd2"','19','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','19',NULL,'EmpAdd2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAdd3"','20','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','20',NULL,'EmpAdd3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCity"','21','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','21',NULL,'EmpCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCount"','22','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','22',NULL,'EmpCounty',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpState"','23','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','23',NULL,'EmpState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpZip"','24','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','24',NULL,'EmpZip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHPh"','25','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','25',NULL,'EmpHPh',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWPh"','26','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','26',NULL,'EmpWPh',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpGen"','27','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','27',NULL,'EmpGen',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMarit"','28','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','28',NULL,'EmpMaritalStat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDtMar"','29','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','29',NULL,'EmpDtMarried',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpRace"','30','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','30',NULL,'EmpRace',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCitiz"','31','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','31',NULL,'EmpCitizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHandi"','32','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','32',NULL,'EmpHandicap',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHospi"','33','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','33',NULL,'EmpHospital',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSmoke"','34','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','34',NULL,'EmpSmoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLangu"','35','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','35',NULL,'EmpLanguage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptDtSt"','36','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','36',NULL,'EmptDtStart',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptDtTerm"','37','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','37',NULL,'EmptDtTerm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptTermReason"','38','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','38',NULL,'EmptTermReason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptDtHire"','39','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','39',NULL,'EmptDtHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptDtOrigHire"','40','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','40',NULL,'EmptDtOrigHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptDtBenEligh"','41','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','41',NULL,'EmptDtBenElig',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptDtRet"','42','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','42',NULL,'EmptDtRet',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptNum"','43','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','43',NULL,'EmptNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptStat"','44','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','44',NULL,'EmptStat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptType"','45','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','45',NULL,'EmptType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptFull"','46','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','46',NULL,'EmptFullTime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptExStat"','47','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','47',NULL,'EmptExStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptRegion"','48','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','48',NULL,'EmptRegion',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptDiv"','49','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','49',NULL,'EmptDiv',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptDep"','50','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','50',NULL,'EmptDep',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptLoc"','51','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','51',NULL,'EmptLoc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptJobTitle"','52','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','52',NULL,'EmptJobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptJobCode"','53','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','53',NULL,'EmptJobCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptPerc"','54','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','54',NULL,'EmptPercOfOwner',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptIsCorpOf"','55','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','55',NULL,'EmptIsCorpOfficer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptIsKeyEmp"','56','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','56',NULL,'EmptIsKeyEmp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptIsHighComp"','57','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','57',NULL,'EmptIsHighComp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptUnion"','58','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','58',NULL,'EmptUnion',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptMedElig"','59','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','59',NULL,'EmptMedElig',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptCompAnnAmt"','60','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','60',NULL,'EmptCompAnnAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCompNumPay"','61','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','61',NULL,'EmpCompNumPay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCompHrlyRate"','62','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','62',NULL,'EmpCompHrlyRate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptCompEffFrom"','63','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','63',NULL,'EmptCompEffFrom',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmptWeeklyHrs"','64','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','64',NULL,'EmptWeeklyHrs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConSysId"','65','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','65',NULL,'ConSysId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConSSN"','66','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','66',NULL,'ConSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConFName"','67','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','67',NULL,'ConFName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConLName"','68','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','68',NULL,'ConLName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConMName"','69','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','69',NULL,'ConMName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConNameSuff"','70','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','70',NULL,'ConNameSuffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConNamePref"','71','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','71',NULL,'ConNamePrefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConDOB"','72','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','72',NULL,'ConDOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConDOD"','73','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','73',NULL,'ConDOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConEmail"','74','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','74',NULL,'ConEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAddr1"','75','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','75',NULL,'ConAddr1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAddr2"','76','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','76',NULL,'ConAddr2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAddr3"','77','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','77',NULL,'ConAddr3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAddCity"','78','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','78',NULL,'ConAddCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAddCounty"','79','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','79',NULL,'ConAddCounty',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAddState"','80','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','80',NULL,'ConAddState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAddZip"','81','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','81',NULL,'ConAddZip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConHPh"','82','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','82',NULL,'ConHPh',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConWPh"','83','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','83',NULL,'ConWPh',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConGen"','84','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','84',NULL,'ConGen',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConMaritalStat"','85','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','85',NULL,'ConMaritalStat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConRace"','86','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','86',NULL,'ConRace',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConCitiz"','87','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','87',NULL,'ConCitizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConHandi"','88','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','88',NULL,'ConHandicapped',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConHospi"','89','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','89',NULL,'ConHospital',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConSmoke"','90','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','90',NULL,'ConSmoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConLangu"','91','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','91',NULL,'ConLanguage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConIRSQual"','92','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','92',NULL,'ConIRSQualDep',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConFullTimeStuddent"','93','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','93',NULL,'ConFullTimeStudent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenCarName"','94','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','94',NULL,'BenCarName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenCarEIN"','95','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','95',NULL,'BenCarEIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenType"','96','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','96',NULL,'BenType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPlanName"','97','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','97',NULL,'BenPlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPolNum1"','98','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','98',NULL,'BenPolNum1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPolNum2"','99','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','99',NULL,'BenPolNum2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPolNum3"','100','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','100',NULL,'BenPolNum3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPolNum4"','101','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','101',NULL,'BenPolNum4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPolNum5"','102','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','102',NULL,'BenPolNum5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenEffFrom"','103','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','103',NULL,'BenEffFrom',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenEffLastDt"','104','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','104',NULL,'BenEffLastDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenOrigEffFrom"','105','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','105',NULL,'BenOrigEffFrom',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenCovLevel"','106','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','106',NULL,'BenCovLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenIsWaived"','107','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','107',NULL,'BenIsWaived',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenBaseCovAmt"','108','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','108',NULL,'BenBaseCovAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenAppCovAmt"','109','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','109',NULL,'BenAppCovAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenReqCovAmt"','110','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','110',NULL,'BenReqCovAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenEmpPrem"','111','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','111',NULL,'BenEmpPremium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenEmployerPrem"','112','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','112',NULL,'BenEmployerPremium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenNumDedPerYear"','113','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','113',NULL,'BenNumDedPerYear',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenSalary"','114','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','114',NULL,'BenSalary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenMedOfficeNum"','115','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','115',NULL,'BenMedOfficeNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenMedOfficeProvName"','116','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','116',NULL,'BenMedOfficeProviderName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenMedOfficeProvAdd"','117','(''UA''=''T,'')','EEVRYSTCOBZ0','54','D','10','117',NULL,'BenMedOfficeProviderAdd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPercent"','118','(''UA''=''T'')','EEVRYSTCOBZ0','54','D','10','118',NULL,'BenPercent',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EEVRYSTCOB_20210723.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Everything Benefits COBRA','202107159','EMPEXPORT','ONDEM_XOE',NULL,'EEVRYSTCOB',NULL,NULL,NULL,'202107159','Jul 15 2021  4:23PM','Jul 15 2021  4:23PM','202107151',NULL,'','','202107151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Everything Benefits COBR-Sched','202107159','EMPEXPORT','SCH_EEVRYS',NULL,'EEVRYSTCOB',NULL,NULL,NULL,'202107159','Jul 15 2021  4:23PM','Jul 15 2021  4:23PM','202107151',NULL,'','','202107151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Everything Benefits COBR-Test','202107221','EMPEXPORT','TEST_XOE','Jul 22 2021  1:50PM','EEVRYSTCOB',NULL,NULL,NULL,'202107221','Jul 22 2021 12:00AM','Dec 30 1899 12:00AM','202107081','446','','','202107081',dbo.fn_GetTimedKey(),NULL,'us3cPeSTT1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEVRYSTCOB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEVRYSTCOB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEVRYSTCOB','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEVRYSTCOB','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEVRYSTCOB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEVRYSTCOB','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EEVRYSTCOB' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EEVRYSTCOB' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EEVRYSTCOB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEVRYSTCOB_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEVRYSTCOB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEVRYSTCOB','D10','dbo.U_EEVRYSTCOB_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EEVRYSTCOB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EEVRYSTCOB] (
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
IF OBJECT_ID('U_EEVRYSTCOB_Audit') IS NULL
CREATE TABLE [dbo].[U_EEVRYSTCOB_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EEVRYSTCOB_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EEVRYSTCOB_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EEVRYSTCOB_DedList') IS NULL
CREATE TABLE [dbo].[U_EEVRYSTCOB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EEVRYSTCOB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEVRYSTCOB_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecType] varchar(1) NOT NULL,
    [drvReltoEmp] varchar(10) NULL,
    [drvOrgSysId] varchar(10) NULL,
    [drvOrgName] varchar(25) NULL,
    [drvOrgEIN] varchar(1) NOT NULL,
    [drvEmpSysId] char(9) NULL,
    [drvEmpUser] varchar(201) NULL,
    [drvEmpSSN] varchar(11) NULL,
    [drvEmpNum] char(9) NULL,
    [drvEmpFName] varchar(100) NULL,
    [drvEmpLName] varchar(100) NULL,
    [drvEmpMName] varchar(50) NULL,
    [drvEmpSuffi] varchar(30) NULL,
    [drvEmpPrefi] varchar(1) NOT NULL,
    [drvEmpDOB] varchar(10) NULL,
    [drvEmpDOD] varchar(10) NULL,
    [drvEmpEmail] varchar(50) NULL,
    [drvEmpAdd1] varchar(8000) NULL,
    [drvEmpAdd2] varchar(8000) NULL,
    [drvEmpAdd3] varchar(1) NOT NULL,
    [drvEmpCity] varchar(255) NULL,
    [drvEmpCount] varchar(1) NOT NULL,
    [drvEmpState] varchar(255) NULL,
    [drvEmpZip] varchar(50) NULL,
    [drvEmpHPh] varchar(12) NULL,
    [drvEmpWPh] varchar(12) NULL,
    [drvEmpGen] varchar(1) NOT NULL,
    [drvEmpMarit] varchar(8) NOT NULL,
    [drvEmpDtMar] varchar(1) NOT NULL,
    [drvEmpRace] varchar(1) NOT NULL,
    [drvEmpCitiz] varchar(1) NOT NULL,
    [drvEmpHandi] varchar(1) NOT NULL,
    [drvEmpHospi] varchar(1) NOT NULL,
    [drvEmpSmoke] varchar(3) NOT NULL,
    [drvEmpLangu] varchar(1) NOT NULL,
    [drvEmptDtSt] varchar(10) NULL,
    [drvEmptDtTerm] varchar(10) NULL,
    [drvEmptTermReason] varchar(25) NULL,
    [drvEmptDtHire] varchar(1) NOT NULL,
    [drvEmptDtOrigHire] varchar(10) NULL,
    [drvEmptDtBenEligh] varchar(1) NOT NULL,
    [drvEmptDtRet] varchar(1) NOT NULL,
    [drvEmptNum] varchar(1) NOT NULL,
    [drvEmptStat] varchar(10) NULL,
    [drvEmptType] varchar(1) NOT NULL,
    [drvEmptFull] varchar(1) NOT NULL,
    [drvEmptExStat] varchar(1) NOT NULL,
    [drvEmptRegion] varchar(1) NOT NULL,
    [drvEmptDiv] varchar(1) NOT NULL,
    [drvEmptDep] varchar(1) NOT NULL,
    [drvEmptLoc] varchar(1) NOT NULL,
    [drvEmptJobTitle] varchar(1) NOT NULL,
    [drvEmptJobCode] char(8) NULL,
    [drvEmptPerc] varchar(1) NOT NULL,
    [drvEmptIsCorpOf] varchar(1) NOT NULL,
    [drvEmptIsKeyEmp] varchar(1) NOT NULL,
    [drvEmptIsHighComp] varchar(1) NOT NULL,
    [drvEmptUnion] varchar(1) NOT NULL,
    [drvEmptMedElig] varchar(1) NOT NULL,
    [drvEmptCompAnnAmt] varchar(1) NOT NULL,
    [drvEmpCompNumPay] varchar(1) NOT NULL,
    [drvEmpCompHrlyRate] varchar(1) NOT NULL,
    [drvEmptCompEffFrom] varchar(1) NOT NULL,
    [drvEmptWeeklyHrs] varchar(1) NOT NULL,
    [drvConSysId] varchar(1) NOT NULL,
    [drvConSSN] varchar(50) NULL,
    [drvConFName] varchar(50) NULL,
    [drvConLName] varchar(50) NULL,
    [drvConMName] varchar(50) NULL,
    [drvConNameSuff] varchar(50) NULL,
    [drvConNamePref] varchar(1) NOT NULL,
    [drvConDOB] varchar(50) NULL,
    [drvConDOD] varchar(1) NOT NULL,
    [drvConEmail] varchar(1) NOT NULL,
    [drvConAddr1] varchar(1) NOT NULL,
    [drvConAddr2] varchar(1) NOT NULL,
    [drvConAddr3] varchar(1) NOT NULL,
    [drvConAddCity] varchar(1) NOT NULL,
    [drvConAddCounty] varchar(1) NOT NULL,
    [drvConAddState] varchar(1) NOT NULL,
    [drvConAddZip] varchar(1) NOT NULL,
    [drvConHPh] varchar(50) NULL,
    [drvConWPh] varchar(1) NOT NULL,
    [drvConGen] varchar(50) NULL,
    [drvConMaritalStat] varchar(1) NOT NULL,
    [drvConRace] varchar(1) NOT NULL,
    [drvConCitiz] varchar(1) NOT NULL,
    [drvConHandi] varchar(1) NOT NULL,
    [drvConHospi] varchar(1) NOT NULL,
    [drvConSmoke] varchar(1) NOT NULL,
    [drvConLangu] varchar(1) NOT NULL,
    [drvConIRSQual] varchar(1) NOT NULL,
    [drvConFullTimeStuddent] varchar(1) NOT NULL,
    [drvBenCarName] varchar(18) NULL,
    [drvBenCarEIN] varchar(1) NOT NULL,
    [drvBenType] varchar(27) NULL,
    [drvBenPlanName] varchar(8) NULL,
    [drvBenPolNum1] varchar(1) NOT NULL,
    [drvBenPolNum2] varchar(1) NOT NULL,
    [drvBenPolNum3] varchar(1) NOT NULL,
    [drvBenPolNum4] varchar(1) NOT NULL,
    [drvBenPolNum5] varchar(1) NOT NULL,
    [drvBenEffFrom] varchar(10) NULL,
    [drvBenEffLastDt] varchar(10) NULL,
    [drvBenOrigEffFrom] varchar(1) NOT NULL,
    [drvBenCovLevel] varchar(3) NULL,
    [drvBenIsWaived] varchar(1) NOT NULL,
    [drvBenBaseCovAmt] varchar(1) NOT NULL,
    [drvBenAppCovAmt] varchar(1) NOT NULL,
    [drvBenReqCovAmt] varchar(1) NOT NULL,
    [drvBenEmpPrem] varchar(1) NOT NULL,
    [drvBenEmployerPrem] varchar(1) NOT NULL,
    [drvBenNumDedPerYear] varchar(1) NOT NULL,
    [drvBenSalary] varchar(1) NOT NULL,
    [drvBenMedOfficeNum] varchar(1) NOT NULL,
    [drvBenMedOfficeProvName] varchar(1) NOT NULL,
    [drvBenMedOfficeProvAdd] varchar(1) NOT NULL,
    [drvBenPercent] varchar(1) NOT NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EEVRYSTCOB_EEList') IS NULL
CREATE TABLE [dbo].[U_EEVRYSTCOB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EEVRYSTCOB_File') IS NULL
CREATE TABLE [dbo].[U_EEVRYSTCOB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EEVRYSTCOB_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EEVRYSTCOB_PDedHist] (
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
IF OBJECT_ID('U_EEVRYSTCOB_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EEVRYSTCOB_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEVRYSTCOB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: St. Therese Home

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 07/15/2021
Service Request Number: TekP-2021-05-11-0003

Purpose: Everything Benefits COBRA

Revision History
----------------
07/21/2021 by AP:
        - Per request removed audit from use in the file.

07/23/2021 by AP:
		- Removed audit table from emp and spouse (error left from before).
		- Work Phone and Home Phone dashes showing when there is no number has been fixed.
		- Set JobCode to BLANK.
		- Fixed suffix with Z for dependents.
		- Updated plan name value and added the prior existing plan name fields to benefit policy number 1.
		- Added employment term reason to child dependent records.


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEVRYSTCOB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEVRYSTCOB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEVRYSTCOB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEVRYSTCOB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEVRYSTCOB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEVRYSTCOB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEVRYSTCOB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEVRYSTCOB', 'SCH_EEVRYS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EEVRYSTCOB';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEVRYSTCOB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EEVRYSTCOB';

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
    DELETE FROM dbo.U_EEVRYSTCOB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEVRYSTCOB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MDP1,MDP2,MDP3,PTDEN,VVIS,FCHI,FMED,BLD,BLEE,LIFEC,LIFEE,LIFES';

    IF OBJECT_ID('U_EEVRYSTCOB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EEVRYSTCOB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EEVRYSTCOB_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    --IF OBJECT_ID('U_EEVRYSTCOB_AuditFields','U') IS NOT NULL
    --    DROP TABLE dbo.U_EEVRYSTCOB_AuditFields;
    --CREATE TABLE dbo.U_EEVRYSTCOB_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecAnnSalary');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecEmplStatus');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpComp','EecTermReason');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpDed','EedBenStartDate');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpDed','EedBenStopDate');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepGender');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepNameFirst');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepNameLast');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepNameMiddle');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepNameSuffix');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepOldSSN');
    --INSERT INTO dbo.U_EEVRYSTCOB_AuditFields VALUES ('EmpPers','EepSSN');

    ---- Create audit table based on fields defined above
    --IF OBJECT_ID('U_EEVRYSTCOB_Audit','U') IS NOT NULL
    --    DROP TABLE dbo.U_EEVRYSTCOB_Audit;
    --SELECT 
    --    audEEID  = audKey1Value
    --    ,audKey2 = audKey2Value
    --    ,audKey3 = audKey3Value
    --    ,audTableName
    --    ,audFieldName
    --    ,audAction
    --    ,audDateTime
    --    ,audOldValue
    --    ,audNewValue
    --    ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    --    ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
    --    ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
    --    ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
    --    ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
    --INTO dbo.U_EEVRYSTCOB_Audit
    --FROM dbo.U_EEVRYSTCOB_EEList WITH (NOLOCK)
    --JOIN dbo.vw_AuditData WITH (NOLOCK) 
    --    ON audKey1Value = xEEID
    --JOIN dbo.U_EEVRYSTCOB_AuditFields WITH (NOLOCK) 
    --    ON audTableName = aTableName
    --    AND audFieldName = aFieldName
    --WHERE audDateTime BETWEEN @StartDate AND @EndDate
    --AND audAction <> 'DELETE'
    --AND ISNULL(audNewValue,'') <> '';
 
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEVRYSTCOB_drvTbl
    ---------------------------------
   IF OBJECT_ID('U_EEVRYSTCOB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEVRYSTCOB_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecType = 'S'
        ,drvReltoEmp = CAST('Self' AS VARCHAR(10))
        ,drvOrgSysId = EecOrgLvl1
        ,drvOrgName = OrgDesc 
        ,drvOrgEIN = ''
        ,drvEmpSysId = EecEmpNo
        ,drvEmpUser = EepNameFirst + '.' + EepNameLast
        ,drvEmpSSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                     SUBSTRING(EepSSN, 4, 2)+'-'+
                     SUBSTRING(EepSSN, 6, 4) 
        ,drvEmpNum = EecEmpNo
        ,drvEmpFName = EepNameFirst
        ,drvEmpLName = EepNameLast
        ,drvEmpMName = EepNameMiddle
        ,drvEmpSuffi = EepNameSuffix
        ,drvEmpPrefi = ''
        ,drvEmpDOB = LEFT(CONVERT(VARCHAR, EepDateOfBirth, 126), 10) -- yyyy-mm-dd format
        ,drvEmpDOD = LEFT(CONVERT(VARCHAR, EepDateDeceased, 126), 10)
        ,drvEmpEmail = EepAddressEMail
        ,drvEmpAdd1 = REPLACE(EepAddressLine1, ',', '')
        ,drvEmpAdd2 = REPLACE(EepAddressLine2, ',', '')
        ,drvEmpAdd3 = ''
        ,drvEmpCity = EepAddressCity
        ,drvEmpCount = ''
        ,drvEmpState = EepAddressState
        ,drvEmpZip = EepAddressZipCode
        ,drvEmpHPh = CASE WHEN EepPhoneHomeNumber IS NOT NULL THEN SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 7, 4) ELSE '' END
        ,drvEmpWPh = CASE WHEN EecPhoneBusinessNumber <> '' THEN SUBSTRING(EecPhoneBusinessNumber, 1, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 4, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 7, 4) ELSE '' END
        ,drvEmpGen = CASE WHEN EepGender = 'M' THEN 'M' 
                            WHEN EepGender = 'F' THEN 'F' ELSE 'U' END
        ,drvEmpMarit = CASE EepMaritalStatus
                            WHEN 'S' THEN 'Single'
                            WHEN 'D' THEN 'Divorced'
                            WHEN 'M' THEN 'Married'
                            WHEN 'W' THEN 'Widowed' ELSE '' END
        ,drvEmpDtMar = ''
        ,drvEmpRace = ''
        ,drvEmpCitiz = ''
        ,drvEmpHandi = ''
        ,drvEmpHospi = ''
        ,drvEmpSmoke = CASE WHEN EepIsSmoker = 'Y' THEN 'Yes' ELSE 'No' END
        ,drvEmpLangu = ''
        ,drvEmptDtSt = LEFT(CONVERT(VARCHAR, EecDateOfLastHire, 126), 10)
        ,drvEmptDtTerm = LEFT(ISNULL(CONVERT(VARCHAR, EecDateOfTermination, 126), ''), 10)
        ,drvEmptTermReason = TchDesc -- TscDesc WHERE TrmReasn = EecTermReason (send the description) 
        --CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvEmptDtHire = ''
        ,drvEmptDtOrigHire = LEFT(CONVERT(VARCHAR, EecDateOfOriginalHire, 126), 10)
        ,drvEmptDtBenEligh = ''
        ,drvEmptDtRet = ''
        ,drvEmptNum = ''
        ,drvEmptStat = CASE EecEmplStatus
                            WHEN 'A' THEN 'Active'
                            WHEN 'T' THEN 'Terminated'
                            WHEN 'L' THEN 'LOA' END
        ,drvEmptType = ''
        ,drvEmptFull = ''
        ,drvEmptExStat = ''
        ,drvEmptRegion = ''
        ,drvEmptDiv = ''
        ,drvEmptDep = ''
        ,drvEmptLoc = ''
        ,drvEmptJobTitle = ''
        ,drvEmptJobCode = ''
        ,drvEmptPerc = ''
        ,drvEmptIsCorpOf = ''
        ,drvEmptIsKeyEmp = ''
        ,drvEmptIsHighComp = ''
        ,drvEmptUnion = ''
        ,drvEmptMedElig = ''
        ,drvEmptCompAnnAmt = ''
        ,drvEmpCompNumPay = ''
        ,drvEmpCompHrlyRate = ''
        ,drvEmptCompEffFrom = ''
        ,drvEmptWeeklyHrs = ''
        ,drvConSysId = ''
        ,drvConSSN = CAST('' as varchar(50))
        ,drvConFName = CAST('' as varchar(50))
        ,drvConLName = CAST('' as varchar(50))
        ,drvConMName = CAST('' as varchar(50))
        ,drvConNameSuff = CAST('' as varchar(50))
        ,drvConNamePref = ''
        ,drvConDOB = CAST('' as varchar(50))
        ,drvConDOD = ''
        ,drvConEmail = ''
        ,drvConAddr1 = ''
        ,drvConAddr2 = ''
        ,drvConAddr3 = ''
        ,drvConAddCity = ''
        ,drvConAddCounty = ''
        ,drvConAddState = ''
        ,drvConAddZip = ''
        ,drvConHPh = CAST('' as varchar(50))
        ,drvConWPh = ''
        ,drvConGen = CAST('' as varchar(50))
        ,drvConMaritalStat = ''
        ,drvConRace = ''
        ,drvConCitiz = ''
        ,drvConHandi = ''
        ,drvConHospi = ''
        ,drvConSmoke = ''
        ,drvConLangu = ''
        ,drvConIRSQual = ''
        ,drvConFullTimeStuddent = ''
        ,drvBenCarName = CASE WHEN EedDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'PreferredOne'
                                WHEN EedDedCode = 'PTDEN' THEN 'HealthPartners'
                                WHEN EedDedCode = 'VVIS' THEN 'EyeMed Vision Care'
                                WHEN EedDedCode IN ('FCHI', 'FMED') THEN 'OptumHealth'
                                 WHEN EedDedCode IN ('BLD', 'BLEE') THEN 'Voya'
                                WHEN EedDedCode IN ('BLD', 'BLEE') THEN 'Vital WorkLife' 
                                WHEN EedDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN 'Voya' END
        ,drvBenCarEIN = ''
        ,drvBenType = CASE WHEN EedDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'Medical'
                                WHEN EedDedCode = 'PTDEN' THEN 'Dental'
                                WHEN EedDedCode = 'VVIS' THEN 'Vision'
                                WHEN EedDedCode IN ('FCHI', 'FMED') THEN 'Flexible Spending Account'
                                WHEN EedDedCode IN ('BLD', 'BLEE') THEN 'Employee Assistance Program' 
                                WHEN EedDedCode IN ('BLD', 'BLEE') THEN 'Basic Employee Life' 
                                WHEN EedDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN 'Voluntary Life' END
        ,drvBenPlanName = CASE WHEN EedDedCode = 'MDP1' THEN 'Medical Copay Plan 1'
								WHEN EedDedCode = 'MDP2' THEN 'Medical HSA Plan 2'
								WHEN EedDedCode = 'MDP3' THEN 'Medical HD HSA Plan 3'
								WHEN EedDedCode = 'PTDEN' THEN 'Dental Insurance PreTax'
								WHEN EedDedCode = 'VVIS' THEN 'Vision'
								WHEN EedDedCode = 'FCHI' THEN 'Flex Child Care'
								WHEN EedDedCode = 'FMED' THEN 'Flex Medical'
								WHEN EedDedcode = 'BLD' THEN 'Basic Life Directors'
								WHEN EedDedCode = 'BLEE' THEN 'Basic Life EE Only'
								WHEN EedDedCode = 'LIFEC' THEN 'Supplemental Life - Child'
								WHEN EedDedCode = 'LIFEE' THEN 'Supplemental Life - Employee'
								WHEN EedDedCode = 'LIFES' THEN 'Supplemental Life - Spouse' END
        ,drvBenPolNum1 = CASE WHEN EedDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'PKA20366'
                                WHEN EedDedCode = 'PTDEN' THEN '19096'
                                WHEN EedDedCode = 'VVIS' THEN '9894049'
                                WHEN EedDedCode IN ('FCHI', 'FMED') THEN '775992'
                                WHEN EedDedCode IN ('BLD', 'BLEE') THEN '290319' 
                                WHEN EedDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN '363707' END
        ,drvBenPolNum2 = ''
        ,drvBenPolNum3 = ''
        ,drvBenPolNum4 = ''
        ,drvBenPolNum5 = ''
        ,drvBenEffFrom = LEFT(CONVERT(VARCHAR, EedBenStartDate, 126), 10)
        ,drvBenEffLastDt = LEFT(ISNULL(CONVERT(VARCHAR, EedBenStopDate, 126), ''), 10)
        ,drvBenOrigEffFrom = ''
        ,drvBenCovLevel = CASE WHEN EedBenOption = 'EE' THEN 'EMP'
                                WHEN EedBenOption IN ('EES', 'EEDP') THEN 'ESP'
                                WHEN EedBenOption IN ('EEF', 'EEDPF') THEN 'FAM'
                                WHEN EedBenOption IN ('EEC', 'EECH') THEN 'ECH' END
        ,drvBenIsWaived = ''
        ,drvBenBaseCovAmt = ''
        ,drvBenAppCovAmt = ''
        ,drvBenReqCovAmt = ''
        ,drvBenEmpPrem = ''
        ,drvBenEmployerPrem = ''
        ,drvBenNumDedPerYear = ''
        ,drvBenSalary = ''
        ,drvBenMedOfficeNum = ''
        ,drvBenMedOfficeProvName = ''
        ,drvBenMedOfficeProvAdd = ''
        ,drvBenPercent = ''
        ,drvInitialSort = '1' + EepSSN
        ,drvSubSort = '1'
    INTO dbo.U_EEVRYSTCOB_drvTbl
    FROM dbo.U_EEVRYSTCOB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    JOIN dbo.OrgLevel WITH(NOLOCK)
        ON OrgCode = EecOrgLvl1
    --JOIN dbo.U_EEVRYSTCOB_Audit 
    --    ON audEEID = xEEID
    --    AND audKey2 = xCOID
     LEFT JOIN dbo.TrmReasn WITH (NOLOCK)  
        ON EecTermReason =   TchCode 
    WHERE --audNewHire = 'Y' OR audTerm = 'Y'
     EecEEType NOT IN ('AG', 'CON', 'INT', 'SUM', 'Z')
    
-- Spouse Record
    INSERT INTO dbo.U_EEVRYSTCOB_drvTbl
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecType = 'D'
        ,drvReltoEmp = 'Spouse'
        ,drvOrgSysId = EecOrgLvl1
        ,drvOrgName = OrgDesc 
        ,drvOrgEIN = ''
        ,drvEmpSysId = EecEmpNo
        ,drvEmpUser = EepNameFirst + '.' + EepNameLast
        ,drvEmpSSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                     SUBSTRING(EepSSN, 4, 2)+'-'+
                     SUBSTRING(EepSSN, 6, 4) 
        ,drvEmpNum = EecEmpNo
        ,drvEmpFName = EepNameFirst
        ,drvEmpLName = EepNameLast
        ,drvEmpMName = EepNameMiddle
        ,drvEmpSuffi = EepNameSuffix
        ,drvEmpPrefi = ''
        ,drvEmpDOB = LEFT(CONVERT(VARCHAR, EepDateOfBirth, 126), 10) -- yyyy-mm-dd format
        ,drvEmpDOD = LEFT(CONVERT(VARCHAR, EepDateDeceased, 126),10) 
        ,drvEmpEmail = EepAddressEMail
        ,drvEmpAdd1 = REPLACE(EepAddressLine1, ',', '')
        ,drvEmpAdd2 = REPLACE(EepAddressLine2, ',', '')
        ,drvEmpAdd3 = ''
        ,drvEmpCity = EepAddressCity
        ,drvEmpCount = ''
        ,drvEmpState = EepAddressState
        ,drvEmpZip = EepAddressZipCode
		,drvEmpHPh = CASE WHEN EepPhoneHomeNumber IS NOT NULL THEN SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 7, 4) ELSE '' END
        ,drvEmpWPh = CASE WHEN EecPhoneBusinessNumber <> '' THEN SUBSTRING(EecPhoneBusinessNumber, 1, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 4, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 7, 4) ELSE '' END
        ,drvEmpGen = CASE WHEN EepGender = 'M' THEN 'M' 
                            WHEN EepGender = 'F' THEN 'F' ELSE 'U' END
        ,drvEmpMarit = CASE EepMaritalStatus
                            WHEN 'S' THEN 'Single'
                            WHEN 'D' THEN 'Divorced'
                            WHEN 'M' THEN 'Married'
                            WHEN 'W' THEN 'Widowed' ELSE '' END
        ,drvEmpDtMar = ''
        ,drvEmpRace = ''
        ,drvEmpCitiz = ''
        ,drvEmpHandi = ''
        ,drvEmpHospi = ''
        ,drvEmpSmoke = CASE WHEN EepIsSmoker = 'Y' THEN 'Yes' ELSE 'No' END
        ,drvEmpLangu = ''
        ,drvEmptDtSt = LEFT(CONVERT(VARCHAR, EecDateOfLastHire, 126), 10)
        ,drvEmptDtTerm = LEFT(ISNULL(CONVERT(VARCHAR, EecDateOfTermination, 126), ''), 10)
        ,drvEmptTermReason = TchDesc -- TscDesc WHERE TrmReasn = EecTermReason (send the description) 
        --CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvEmptDtHire = ''
        ,drvEmptDtOrigHire = LEFT(CONVERT(VARCHAR, EecDateOfOriginalHire, 126), 10)
        ,drvEmptDtBenEligh = ''
        ,drvEmptDtRet = ''
        ,drvEmptNum = ''
        ,drvEmptStat = CASE EecEmplStatus
                            WHEN 'A' THEN 'Active'
                            WHEN 'T' THEN 'Terminated'
                            WHEN 'L' THEN 'LOA' END
        ,drvEmptType = ''
        ,drvEmptFull = ''
        ,drvEmptExStat = ''
        ,drvEmptRegion = ''
        ,drvEmptDiv = ''
        ,drvEmptDep = ''
        ,drvEmptLoc = ''
        ,drvEmptJobTitle = ''
        ,drvEmptJobCode = ''
        ,drvEmptPerc = ''
        ,drvEmptIsCorpOf = ''
        ,drvEmptIsKeyEmp = ''
        ,drvEmptIsHighComp = ''
        ,drvEmptUnion = ''
        ,drvEmptMedElig = ''
        ,drvEmptCompAnnAmt = ''
        ,drvEmpCompNumPay = ''
        ,drvEmpCompHrlyRate = ''
        ,drvEmptCompEffFrom = ''
        ,drvEmptWeeklyHrs = ''
        ,drvConSysId = ''
        ,drvConSSN = SUBSTRING(ConSSN, 1, 3)+'-'+
                     SUBSTRING(ConSSN, 4, 2)+'-'+
                     SUBSTRING(ConSSN, 6, 4) 
        ,drvConFName = ConNameFirst
        ,drvConLName = ConNameLast
        ,drvConMName = ConNameMiddle
        ,drvConNameSuff = CASE WHEN ConNameSuffix <> 'Z' THEN ConNameSuffix ELSE '' END
        ,drvConNamePref = ''
        ,drvConDOB = LEFT(CONVERT(VARCHAR, ConDateOfBirth, 126), 10)
        ,drvConDOD = ''
        ,drvConEmail = ''
        ,drvConAddr1 = ''
        ,drvConAddr2 = ''
        ,drvConAddr3 = ''
        ,drvConAddCity = ''
        ,drvConAddCounty = ''
        ,drvConAddState = ''
        ,drvConAddZip = ''
        ,drvConHPh = SUBSTRING(ConPhoneHomeNumber, 1, 3) + '-' + 
                     SUBSTRING(ConPhoneHomeNumber, 4, 3) + '-' + 
                     SUBSTRING(ConPhoneHomeNumber, 7, 4)
        ,drvConWPh = ''
        ,drvConGen = CASE WHEN ConGender = 'F' THEN 'F'
                            WHEN ConGender = 'M' THEN 'M'
                            ELSE 'U' END
        ,drvConMaritalStat = ''
        ,drvConRace = ''
        ,drvConCitiz = ''
        ,drvConHandi = ''
        ,drvConHospi = ''
        ,drvConSmoke = ''
        ,drvConLangu = ''
        ,drvConIRSQual = ''
        ,drvConFullTimeStuddent = ''
        ,drvBenCarName = CASE WHEN DbnDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'PreferredOne'
                                WHEN DbnDedCode = 'PTDEN' THEN 'HealthPartners'
                                WHEN DbnDedCode = 'VVIS' THEN 'EyeMed Vision Care'
                                WHEN DbnDedCode IN ('FCHI', 'FMED') THEN 'OptumHealth'
                                 WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Voya'
                                WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Vital WorkLife' 
                                WHEN DbnDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN 'Voya' END
        ,drvBenCarEIN = ''
        ,drvBenType = CASE WHEN DbnDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'Medical'
                                WHEN DbnDedCode = 'PTDEN' THEN 'Dental'
                                WHEN DbnDedCode = 'VVIS' THEN 'Vision'
                                WHEN DbnDedCode IN ('FCHI', 'FMED') THEN 'Flexible Spending Account'
                                WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Employee Assistance Program' 
                                WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Basic Employee Life' 
                                WHEN DbnDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN 'Voluntary Life' END
        ,drvBenPlanName = CASE WHEN DbnDedCode = 'MDP1' THEN 'Medical Copay Plan 1'
								WHEN DbnDedCode = 'MDP2' THEN 'Medical HSA Plan 2'
								WHEN DbnDedCode = 'MDP3' THEN 'Medical HD HSA Plan 3'
								WHEN DbnDedCode = 'PTDEN' THEN 'Dental Insurance PreTax'
								WHEN DbnDedCode = 'VVIS' THEN 'Vision'
								--WHEN DbnDedCode = 'FCHI' THEN 'Flex Child Care'
								--WHEN DbnDedCode = 'FMED' THEN 'Flex Medical'
								--WHEN DbnDedCode = 'BLD' THEN 'Basic Life Directors'
								--WHEN DbnDedCode = 'BLEE' THEN 'Basic Life EE Only'
								WHEN DbnDedCode = 'LIFEC' THEN 'Supplemental Life - Child'
								--WHEN DbnDedCode = 'LIFEE' THEN 'Supplemental ife - Employee'
								WHEN DbnDedCode = 'LIFES' THEN 'Supplemental Life - Spouse' END
        ,drvBenPolNum1 = CASE WHEN DbnDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'PKA20366'
                                WHEN DbnDedCode = 'PTDEN' THEN '19096'
                                WHEN DbnDedCode = 'VVIS' THEN '9894049'
                               -- WHEN DbnDedCode IN ('FCHI', 'FMED') THEN '775992'
                               -- WHEN DbnDedCode IN ('BLD', 'BLEE') THEN '290319' 
                                WHEN DbnDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN '363707' END
        ,drvBenPolNum2 = ''
        ,drvBenPolNum3 = ''
        ,drvBenPolNum4 = ''
        ,drvBenPolNum5 = ''
        ,drvBenEffFrom = LEFT(CONVERT(VARCHAR, DbnBenStartDate, 126), 10)
        ,drvBenEffLastDt = LEFT(ISNULL(CONVERT(VARCHAR, DbnBenStopDate, 126), ''), 10)
        ,drvBenOrigEffFrom = ''
        ,drvBenCovLevel = CASE WHEN DbnBenOption = 'EE' THEN 'EMP'
                                WHEN DbnBenOption IN ('EES', 'EEDP') THEN 'ESP'
                                WHEN DbnBenOption IN ('EEF', 'EEDPF') THEN 'FAM'
                                WHEN DbnBenOption IN ('EEC', 'EECH') THEN 'ECH' END
        ,drvBenIsWaived = ''
        ,drvBenBaseCovAmt = ''
        ,drvBenAppCovAmt = ''
        ,drvBenReqCovAmt = ''
        ,drvBenEmpPrem = ''
        ,drvBenEmployerPrem = ''
        ,drvBenNumDedPerYear = ''
        ,drvBenSalary = ''
        ,drvBenMedOfficeNum = ''
        ,drvBenMedOfficeProvName = ''
        ,drvBenMedOfficeProvAdd = ''
        ,drvBenPercent = ''
        ,drvInitialSort = '1' + EepSSN
        ,drvSubSort = '2'
    FROM dbo.U_EEVRYSTCOB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
        ON DbnEEID = xEEID
        AND DbnCOID = xCOID
        AND DbnFormatCode = @FormatCode
        AND DbnValidForExport = 'Y'
    JOIN dbo.Contacts WITH(NOLOCK)
        ON ConEEID = DbnEEID
        AND ConSystemID = DbnDepRecId
    JOIN dbo.OrgLevel WITH(NOLOCK)
        ON OrgCode = EecOrgLvl1
    --JOIN dbo.U_EEVRYSTCOB_Audit 
    --    ON audEEID = xEEID
    --    AND audKey2 = xCOID
     LEFT JOIN dbo.TrmReasn WITH (NOLOCK)  
        ON EecTermReason =   TchCode 
    WHERE --audNewHire = 'Y' OR audTerm = 'Y'
        DbnRelationship = 'SPS'
    AND EecEEType NOT IN ('AG', 'CON', 'INT', 'SUM', 'Z')
    ;

---- Child Record
    INSERT INTO dbo.U_EEVRYSTCOB_drvTbl
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecType = 'D'
        ,drvReltoEmp = 'Child'
        ,drvOrgSysId = EecOrgLvl1
        ,drvOrgName = OrgDesc 
        ,drvOrgEIN = ''
        ,drvEmpSysId = EecEmpNo
        ,drvEmpUser = EepNameFirst + '.' + EepNameLast
        ,drvEmpSSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                     SUBSTRING(EepSSN, 4, 2)+'-'+
                     SUBSTRING(EepSSN, 6, 4) 
        ,drvEmpNum = EecEmpNo
        ,drvEmpFName = EepNameFirst
        ,drvEmpLName = EepNameLast
        ,drvEmpMName = EepNameMiddle
        ,drvEmpSuffi = EepNameSuffix
        ,drvEmpPrefi = ''
        ,drvEmpDOB = LEFT(CONVERT(VARCHAR, EepDateOfBirth, 126), 10) -- yyyy-mm-dd format
        ,drvEmpDOD = LEFT(CONVERT(VARCHAR, EepDateDeceased, 126), 10)
        ,drvEmpEmail = EepAddressEMail
        ,drvEmpAdd1 = REPLACE(EepAddressLine1, ',', '')
        ,drvEmpAdd2 = REPLACE(EepAddressLine2, ',', '')
        ,drvEmpAdd3 = ''
        ,drvEmpCity = EepAddressCity
        ,drvEmpCount = ''
        ,drvEmpState = EepAddressState
        ,drvEmpZip = EepAddressZipCode
        ,drvEmpHPh = CASE WHEN EepPhoneHomeNumber IS NOT NULL THEN SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                     SUBSTRING(EepPhoneHomeNumber, 7, 4) ELSE '' END
        ,drvEmpWPh = CASE WHEN EecPhoneBusinessNumber <> '' THEN SUBSTRING(EecPhoneBusinessNumber, 1, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 4, 3) + '-' + 
                     SUBSTRING(EecPhoneBusinessNumber, 7, 4) ELSE '' END
        ,drvEmpGen = CASE WHEN EepGender = 'M' THEN 'M' 
                            WHEN EepGender = 'F' THEN 'F' ELSE 'U' END
        ,drvEmpMarit = CASE EepMaritalStatus
                            WHEN 'S' THEN 'Single'
                            WHEN 'D' THEN 'Divorced'
                            WHEN 'M' THEN 'Married'
                            WHEN 'W' THEN 'Widowed' ELSE '' END
        ,drvEmpDtMar = ''
        ,drvEmpRace = ''
        ,drvEmpCitiz = ''
        ,drvEmpHandi = ''
        ,drvEmpHospi = ''
        ,drvEmpSmoke = CASE WHEN EepIsSmoker = 'Y' THEN 'Yes' ELSE 'No' END
        ,drvEmpLangu = ''
        ,drvEmptDtSt = LEFT(CONVERT(VARCHAR, EecDateOfLastHire, 126), 10)
        ,drvEmptDtTerm = LEFT(ISNULL(CONVERT(VARCHAR, EecDateOfTermination, 126), ''), 10)
        ,drvEmptTermReason = TchDesc -- TscDesc WHERE TrmReasn = EecTermReason (send the description) 
        --CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvEmptDtHire = ''
        ,drvEmptDtOrigHire = LEFT(CONVERT(VARCHAR, EecDateOfOriginalHire, 126), 10)
        ,drvEmptDtBenEligh = ''
        ,drvEmptDtRet = ''
        ,drvEmptNum = ''
        ,drvEmptStat = CASE EecEmplStatus
                            WHEN 'A' THEN 'Active'
                            WHEN 'T' THEN 'Terminated'
                            WHEN 'L' THEN 'LOA' END
        ,drvEmptType = ''
        ,drvEmptFull = ''
        ,drvEmptExStat = ''
        ,drvEmptRegion = ''
        ,drvEmptDiv = ''
        ,drvEmptDep = ''
        ,drvEmptLoc = ''
        ,drvEmptJobTitle = ''
        ,drvEmptJobCode = ''
        ,drvEmptPerc = ''
        ,drvEmptIsCorpOf = ''
        ,drvEmptIsKeyEmp = ''
        ,drvEmptIsHighComp = ''
        ,drvEmptUnion = ''
        ,drvEmptMedElig = ''
        ,drvEmptCompAnnAmt = ''
        ,drvEmpCompNumPay = ''
        ,drvEmpCompHrlyRate = ''
        ,drvEmptCompEffFrom = ''
        ,drvEmptWeeklyHrs = ''
        ,drvConSysId = ''
        ,drvConSSN = SUBSTRING(ConSSN, 1, 3)+'-'+
                     SUBSTRING(ConSSN, 4, 2)+'-'+
                     SUBSTRING(ConSSN, 6, 4) 
        ,drvConFName = ConNameFirst
        ,drvConLName = ConNameLast
        ,drvConMName = ConNameMiddle
        ,drvConNameSuff = CASE WHEN ConNameSuffix <> 'Z' THEN ConNameSuffix ELSE '' END
        ,drvConNamePref = ''
        ,drvConDOB = LEFT(CONVERT(VARCHAR, ConDateOfBirth, 126), 10)
        ,drvConDOD = ''
        ,drvConEmail = ''
        ,drvConAddr1 = ''
        ,drvConAddr2 = ''
        ,drvConAddr3 = ''
        ,drvConAddCity = ''
        ,drvConAddCounty = ''
        ,drvConAddState = ''
        ,drvConAddZip = ''
        ,drvConHPh = SUBSTRING(ConPhoneHomeNumber, 1, 3) + '-' + 
                     SUBSTRING(ConPhoneHomeNumber, 4, 3) + '-' + 
                     SUBSTRING(ConPhoneHomeNumber, 7, 4)
        ,drvConWPh = ''
        ,drvConGen = CASE WHEN ConGender = 'F' THEN 'F'
                            WHEN ConGender = 'M' THEN 'M'
                            ELSE 'U' END
        ,drvConMaritalStat = ''
        ,drvConRace = ''
        ,drvConCitiz = ''
        ,drvConHandi = ''
        ,drvConHospi = ''
        ,drvConSmoke = ''
        ,drvConLangu = ''
        ,drvConIRSQual = ''
        ,drvConFullTimeStuddent = ''
        ,drvBenCarName = CASE WHEN DbnDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'PreferredOne'
                                WHEN DbnDedCode = 'PTDEN' THEN 'HealthPartners'
                                WHEN DbnDedCode = 'VVIS' THEN 'EyeMed Vision Care'
                                WHEN DbnDedCode IN ('FCHI', 'FMED') THEN 'OptumHealth'
                                 WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Voya'
                                WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Vital WorkLife' 
                                WHEN DbnDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN 'Voya' END
        ,drvBenCarEIN = ''
        ,drvBenType = CASE WHEN DbnDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'Medical'
                                WHEN DbnDedCode = 'PTDEN' THEN 'Dental'
                                WHEN DbnDedCode = 'VVIS' THEN 'Vision'
                                WHEN DbnDedCode IN ('FCHI', 'FMED') THEN 'Flexible Spending Account'
                                WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Employee Assistance Program' 
                                WHEN DbnDedCode IN ('BLD', 'BLEE') THEN 'Basic Employee Life' 
                                WHEN DbnDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN 'Voluntary Life' END
        ,drvBenPlanName = CASE WHEN DbnDedCode = 'MDP1' THEN 'Medical Copay Plan 1'
								WHEN DbnDedCode = 'MDP2' THEN 'Medical HSA Plan 2'
								WHEN DbnDedCode = 'MDP3' THEN 'Medical HD HSA Plan 3'
								WHEN DbnDedCode = 'PTDEN' THEN 'Dental Insurance PreTax'
								WHEN DbnDedCode = 'VVIS' THEN 'Vision'
								--WHEN DbnDedCode = 'FCHI' THEN 'Flex Child Care'
								--WHEN DbnDedCode = 'FMED' THEN 'Flex Medical'
								--WHEN DbnDedCode = 'BLD' THEN 'Basic Life Directors'
								--WHEN DbnDedCode = 'BLEE' THEN 'Basic Life EE Only'
								WHEN DbnDedCode = 'LIFEC' THEN 'Supplemental Life - Child'
								--WHEN DbnDedCode = 'LIFEE' THEN 'Supplemental ife - Employee'
								WHEN DbnDedCode = 'LIFES' THEN 'Supplemental Life - Spouse' END
        ,drvBenPolNum1 = CASE WHEN DbnDedCode IN ('MDP1', 'MDP2', 'MDP3') THEN 'PKA20366'
                                WHEN DbnDedCode = 'PTDEN' THEN '19096'
                                WHEN DbnDedCode = 'VVIS' THEN '9894049'
                             --   WHEN DbnDedCode IN ('FCHI', 'FMED') THEN '775992'
                             --   WHEN DbnDedCode IN ('BLD', 'BLEE') THEN '290319' 
                                WHEN DbnDedCode IN ('LIFEC', 'LIFEE', 'LIFES') THEN '363707' END
        ,drvBenPolNum2 = ''
        ,drvBenPolNum3 = ''
        ,drvBenPolNum4 = ''
        ,drvBenPolNum5 = ''
        ,drvBenEffFrom = LEFT(CONVERT(VARCHAR, DbnBenStartDate, 126), 10)
        ,drvBenEffLastDt = LEFT(ISNULL(CONVERT(VARCHAR, DbnBenStopDate, 126), ''), 10)
        ,drvBenOrigEffFrom = ''
        ,drvBenCovLevel = CASE WHEN DbnBenOption = 'EE' THEN 'EMP'
                                WHEN DbnBenOption IN ('EES', 'EEDP') THEN 'ESP'
                                WHEN DbnBenOption IN ('EEF', 'EEDPF') THEN 'FAM'
                                WHEN DbnBenOption IN ('EEC', 'EECH') THEN 'ECH' END
        ,drvBenIsWaived = ''
        ,drvBenBaseCovAmt = ''
        ,drvBenAppCovAmt = ''
        ,drvBenReqCovAmt = ''
        ,drvBenEmpPrem = ''
        ,drvBenEmployerPrem = ''
        ,drvBenNumDedPerYear = ''
        ,drvBenSalary = ''
        ,drvBenMedOfficeNum = ''
        ,drvBenMedOfficeProvName = ''
        ,drvBenMedOfficeProvAdd = ''
        ,drvBenPercent = ''
        ,drvInitialSort = '1' + EepSSN
        ,drvSubSort = '3'
    FROM dbo.U_EEVRYSTCOB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
        ON DbnEEID = xEEID
        AND DbnCOID = xCOID
        AND DbnFormatCode = @FormatCode
        AND DbnValidForExport = 'Y'
    JOIN dbo.Contacts WITH(NOLOCK)
        ON ConEEID = DbnEEID
        AND ConSystemID = DbnDepRecId
    JOIN dbo.OrgLevel WITH(NOLOCK)
        ON OrgCode = EecOrgLvl1
    --JOIN dbo.U_EEVRYSTCOB_Audit 
    --    ON audEEID = xEEID
    --    AND audKey2 = xCOID
       LEFT JOIN dbo.TrmReasn WITH (NOLOCK)  
        ON EecTermReason =   TchCode 
    WHERE --audNewHire = 'Y' OR audTerm = 'Y'
     DbnRelationship IN ('CHL', 'STC')
     AND EecEEType NOT IN ('AG', 'CON', 'INT', 'SUM', 'Z')
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
ALTER VIEW dbo.dsi_vwEEVRYSTCOB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEVRYSTCOB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEVRYSTCOB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107081'
       ,expStartPerControl     = '202107081'
       ,expLastEndPerControl   = '202107159'
       ,expEndPerControl       = '202107159'
WHERE expFormatCode = 'EEVRYSTCOB';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEVRYSTCOB_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEVRYSTCOB_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort