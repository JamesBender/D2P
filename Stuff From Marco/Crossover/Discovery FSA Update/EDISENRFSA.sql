SET NOCOUNT ON;
IF OBJECT_ID('U_EDISENRFS2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISENRFS2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDISENRFS2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDISENRFS2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDISENRFS2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISENRFS2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISENRFS2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISENRFS2];
GO
IF OBJECT_ID('U_EDISENRFS2_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EDISENRFS2_Trailer];
GO
IF OBJECT_ID('U_EDISENRFS2_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDISENRFS2_PDedHist];
GO
IF OBJECT_ID('U_EDISENRFS2_Header') IS NOT NULL DROP TABLE [dbo].[U_EDISENRFS2_Header];
GO
IF OBJECT_ID('U_EDISENRFS2_File') IS NOT NULL DROP TABLE [dbo].[U_EDISENRFS2_File];
GO
IF OBJECT_ID('U_EDISENRFS2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISENRFS2_EEList];
GO
IF OBJECT_ID('U_EDISENRFS2_drvTbl_PT') IS NOT NULL DROP TABLE [dbo].[U_EDISENRFS2_drvTbl_PT];
GO
IF OBJECT_ID('U_EDISENRFS2_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_EDISENRFS2_drvTbl_EN];
GO
IF OBJECT_ID('U_EDISENRFS2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDISENRFS2_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDISENRFS2') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISENRFS2];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISENRFS2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISENRFS2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISENRFS2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISENRFS2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISENRFS2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISENRFS2','Discovery FSA PT/EN File 3.5 (V2)','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EDISENRFS2Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISENRFS2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FH"','1','(''DA''=''T|'')','EDISENRFS2Z0','2','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DBI"','2','(''DA''=''T|'')','EDISENRFS2Z0','3','H','01','2',NULL,'Administrator Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerCode"','3','(''UA''=''T|'')','EDISENRFS2Z0','6','H','01','3',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','4','(''DA''=''T|'')','EDISENRFS2Z0','1','H','01','4',NULL,'Synchronize Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittedDate"','5','(''UDMDY''=''T|'')','EDISENRFS2Z0','8','H','01','5',NULL,'Submitted Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittedTime"','6','(''UA''=''T|'')','EDISENRFS2Z0','6','H','01','6',NULL,'Submitted Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileVersion"','7','(''UA''=''T'')','EDISENRFS2Z0','6','H','01','7',NULL,'File Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PT"','1','(''DA''=''T|'')','EDISENRFS2Z0','2','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantFileImportID"','2','(''UA''=''T|'')','EDISENRFS2Z0','20','D','10','2',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerEmployeeID"','3','(''UA''=''T|'')','EDISENRFS2Z0','20','D','10','3',NULL,'Employer Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','4','(''UA''=''T|'')','EDISENRFS2Z0','15','D','10','4',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','5','(''UA''=''T|'')','EDISENRFS2Z0','30','D','10','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','6','(''UA''=''T|'')','EDISENRFS2Z0','30','D','10','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','7','(''UA''=''T|'')','EDISENRFS2Z0','1','D','10','7',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','8','(''UA''=''T|'')','EDISENRFS2Z0','1','D','10','8',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','9','(''UA''=''T|'')','EDISENRFS2Z0','1','D','10','9',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''T|'')','EDISENRFS2Z0','50','D','10','10',NULL,'Mothers Maiden Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','11','(''UDMDY''=''T|'')','EDISENRFS2Z0','80','D','10','11',NULL,'Date Of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','12','(''UA''=''T|'')','EDISENRFS2Z0','9','D','10','12',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T|'')','EDISENRFS2Z0','30','D','10','13',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T|'')','EDISENRFS2Z0','30','D','10','14',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''T|'')','EDISENRFS2Z0','30','D','10','15',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''T|'')','EDISENRFS2Z0','30','D','10','16',NULL,'Address Line 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','17','(''UA''=''T|'')','EDISENRFS2Z0','30','D','10','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','18','(''UA''=''T|'')','EDISENRFS2Z0','2','D','10','18',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','19','(''UA''=''T|'')','EDISENRFS2Z0','10','D','10','19',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','20','(''UA''=''T|'')','EDISENRFS2Z0','2','D','10','20',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','21','(''UA''=''T|'')','EDISENRFS2Z0','10','D','10','21',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','22','(''UA''=''T|'')','EDISENRFS2Z0','10','D','10','22',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExtension"','23','(''UA''=''T|'')','EDISENRFS2Z0','6','D','10','23',NULL,'Work Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','24','(''UA''=''T|'')','EDISENRFS2Z0','125','D','10','24',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''T|'')','EDISENRFS2Z0','100','D','10','25',NULL,'Username',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''SS''=''T|'')','EDISENRFS2Z0','100','D','10','26',NULL,'Password',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','27','(''UDMDY''=''T|'')','EDISENRFS2Z0','8','D','10','27',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','28','(''UA''=''T|'')','EDISENRFS2Z0','100','D','10','28',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursPerWeek"','29','(''UNT0''=''T|'')','EDISENRFS2Z0','2','D','10','29',NULL,'Hours Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E"','30','(''DA''=''T|'')','EDISENRFS2Z0','100','D','10','30',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFrequency"','31','(''UA''=''T|'')','EDISENRFS2Z0','100','D','10','31',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''SS''=''T|'')','EDISENRFS2Z0','8','D','10','32',NULL,'Payroll Frequency Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantStatus"','33','(''UA''=''T|'')','EDISENRFS2Z0','20','D','10','33',NULL,'Participant Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusEffectiveDate"','34','(''UDMDY''=''T|'')','EDISENRFS2Z0','8','D','10','34',NULL,'Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoldPayrollDeductions"','35','(''UA''=''T|'')','EDISENRFS2Z0','1','D','10','35',NULL,'Hold Payroll Deductions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoldEmployerContributions"','36','(''UA''=''T|'')','EDISENRFS2Z0','1','D','10','36',NULL,'Hold Employer Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIncurServices"','37','(''UA''=''T|'')','EDISENRFS2Z0','1','D','10','37',NULL,'Incur Services',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFinalPayrollProcessDate"','38','(''UDMDY''=''T|'')','EDISENRFS2Z0','8','D','10','38',NULL,'Final Payroll Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFinalContribProcessDate"','39','(''UDMDY''=''T|'')','EDISENRFS2Z0','8','D','10','39',NULL,'Final Contribution Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''T|'')','EDISENRFS2Z0','100','D','10','40',NULL,'HSA Custodian',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''SS''=''T|'')','EDISENRFS2Z0','1','D','10','41',NULL,'Medicare Beneficiary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''SS''=''T|'')','EDISENRFS2Z0','12','D','10','42',NULL,'Medicare ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''T|'')','EDISENRFS2Z0','50','D','10','43',NULL,'Exchange Integration ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''SS''=''T|'')','EDISENRFS2Z0','100','D','10','44',NULL,'Reporting Hierarchy Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''SS''=''T|'')','EDISENRFS2Z0','100','D','10','45',NULL,'Reporting Hierarchy Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''SS''=''T|'')','EDISENRFS2Z0','100','D','10','46',NULL,'Reporting Hierarchy Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''SS''=''T|'')','EDISENRFS2Z0','100','D','10','47',NULL,'Reporting Hierarchy Level 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''SS''=''T|'')','EDISENRFS2Z0','20','D','10','48',NULL,'CDD_Citizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''SS''=''T|'')','EDISENRFS2Z0','2','D','10','49',NULL,'CDD_Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''SS''=''T|'')','EDISENRFS2Z0','20','D','10','50',NULL,'CDD_EmploymentStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''SS''=''T|'')','EDISENRFS2Z0','30','D','10','51',NULL,'CDD_Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''SS''=''T|'')','EDISENRFS2Z0','30','D','10','52',NULL,'CDD_JobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''SS''=''T|'')','EDISENRFS2Z0','8','D','10','53',NULL,'Class Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''SS''=''T|'')','EDISENRFS2Z0','20','D','10','54',NULL,'ID_IdentificationType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''SS''=''T|'')','EDISENRFS2Z0','30','D','10','55',NULL,'ID_IdentificationNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''SS''=''T|'')','EDISENRFS2Z0','2','D','10','56',NULL,'ID_IssuingState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''SS''=''T|'')','EDISENRFS2Z0','50','D','10','57',NULL,'ID_Issuer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''SS''=''T|'')','EDISENRFS2Z0','8','D','10','58',NULL,'ID_IssueDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''SS''=''T|'')','EDISENRFS2Z0','8','D','10','59',NULL,'ID_ExpirationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''SS''=''T|'')','EDISENRFS2Z0','20','D','10','60',NULL,'Mobile Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMobileNumber"','61','(''UA''=''T|'')','EDISENRFS2Z0','10','D','10','61',NULL,'Mobile Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''SS''=''T'')','EDISENRFS2Z0','15','D','10','62',NULL,'Time Zone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EN"','1','(''DA''=''T|'')','EDISENRFS2Z0','2','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantFileImportID"','2','(''UA''=''T|'')','EDISENRFS2Z0','20','D','20','2',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','3','(''UA''=''T|'')','EDISENRFS2Z0','100','D','20','3',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentEffectiveDate"','4','(''UDMDY''=''T|'')','EDISENRFS2Z0','8','D','20','4',NULL,'Enrollment Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantElectionAmount"','5','(''UNT2''=''T|'')','EDISENRFS2Z0','8','D','20','5',NULL,'Participant Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentTerminationDate"','6','(''UDMDY''=''T|'')','EDISENRFS2Z0','8','D','20','6',NULL,'Enrollment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''T|'')','EDISENRFS2Z0','10','D','20','7',NULL,'Employer Contribution Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''T|'')','EDISENRFS2Z0','8','D','20','8',NULL,'Employer Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''T|'')','EDISENRFS2Z0','30','D','20','9',NULL,'Primary Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''T|'')','EDISENRFS2Z0','30','D','20','10',NULL,'Alternate Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''T|'')','EDISENRFS2Z0','1','D','20','11',NULL,'Enrolled In Claims Exchange',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectionAmountIndicator"','12','(''UA''=''T|'')','EDISENRFS2Z0','8','D','20','12',NULL,'Election Amount Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDHPCoverageLevel"','13','(''UA''=''T|'')','EDISENRFS2Z0','6','D','20','13',NULL,'HDHP Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''T|'')','EDISENRFS2Z0','8','D','20','14',NULL,'Plan Year Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''T|'')','EDISENRFS2Z0','1','D','20','15',NULL,'Terms and Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''T|'')','EDISENRFS2Z0','8','D','20','16',NULL,'Date Terms Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''T|'')','EDISENRFS2Z0','6','D','20','17',NULL,'Time Terms Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''T|'')','EDISENRFS2Z0','8','D','20','18',NULL,'Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''T'')','EDISENRFS2Z0','1','D','20','19',NULL,'Spend Down',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CT"','1','(''DA''=''T|'')','EDISENRFS2Z0','2','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantFileImportID"','2','(''UA''=''T|'')','EDISENRFS2Z0','20','D','30','2',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','3','(''UA''=''T|'')','EDISENRFS2Z0','100','D','30','3',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionDate"','4','(''UDMDY''=''T|'')','EDISENRFS2Z0','8','D','30','4',NULL,'Contribution Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionDescription"','5','(''UA''=''T|'')','EDISENRFS2Z0','30','D','30','5',NULL,'Contribution Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','6','(''UNT2''=''T|'')','EDISENRFS2Z0','9','D','30','6',NULL,'Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Actual"','7','(''DA''=''T|'')','EDISENRFS2Z0','6','D','30','7',NULL,'Amount Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''T'')','EDISENRFS2Z0','7','D','30','8',NULL,'Tax Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BK"','1','(''DA''=''T|'')','EDISENRFS2Z0','2','D','40','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantFileImportID"','2','(''UA''=''T|'')','EDISENRFS2Z0','20','D','40','2',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNickname"','3','(''UA''=''T|'')','EDISENRFS2Z0','20','D','40','3',NULL,'Nickname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountUse"','4','(''UA''=''T|'')','EDISENRFS2Z0','30','D','40','4',NULL,'Account Use',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountType"','5','(''UA''=''T|'')','EDISENRFS2Z0','1','D','40','5',NULL,'Account Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountStatus"','6','(''UA''=''T|'')','EDISENRFS2Z0','1','D','40','6',NULL,'Account Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBankName"','7','(''UA''=''T|'')','EDISENRFS2Z0','30','D','40','7',NULL,'Bank Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRoutingNumber"','8','(''UA''=''T|'')','EDISENRFS2Z0','9','D','40','8',NULL,'Routing Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountNumber"','9','(''UA''=''T|'')','EDISENRFS2Z0','17','D','40','9',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrenote"','10','(''UA''=''T|'')','EDISENRFS2Z0','1','D','40','10',NULL,'Prenote',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBankAccountAddressLine1"','11','(''UA''=''T|'')','EDISENRFS2Z0','30','D','40','11',NULL,'Bank Account Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBankAccountAddressLine2"','12','(''UA''=''T|'')','EDISENRFS2Z0','30','D','40','12',NULL,'Bank Account Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBankCity"','13','(''UA''=''T|'')','EDISENRFS2Z0','30','D','40','13',NULL,'Bank City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBankState"','14','(''UA''=''T|'')','EDISENRFS2Z0','2','D','40','14',NULL,'Bank State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBankZipCode"','15','(''UA''=''T|'')','EDISENRFS2Z0','10','D','40','15',NULL,'Bank Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBankCountry"','16','(''UA''=''T'')','EDISENRFS2Z0','2','D','40','16',NULL,'Bank Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DP"','1','(''DA''=''T|'')','EDISENRFS2Z0','2','D','50','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantFileImportID"','2','(''UA''=''T|'')','EDISENRFS2Z0','20','D','50','2',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentFileImportId"','3','(''UA''=''T|'')','EDISENRFS2Z0','20','D','50','3',NULL,'Dependent File Import Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentNumber"','4','(''UA''=''T|'')','EDISENRFS2Z0','10','D','50','4',NULL,'Dependent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','5','(''UA''=''T|'')','EDISENRFS2Z0','9','D','50','5',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''T|'')','EDISENRFS2Z0','9','D','50','6',NULL,'Relationship Type',NULL,NULL);

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','7','(''UA''=''T|'')','EDISENRFS2Z0','30','D','50','7',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','8','(''UA''=''T|'')','EDISENRFS2Z0','30','D','50','8',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','9','(''UA''=''T|'')','EDISENRFS2Z0','1','D','50','9',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','10','(''UA''=''T|'')','EDISENRFS2Z0','1','D','50','10',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','11','(''UDMDY''=''T|'')','EDISENRFS2Z0','8','D','50','11',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','12','(''UA''=''T|'')','EDISENRFS2Z0','9','D','50','12',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T|'')','EDISENRFS2Z0','9','D','50','13',NULL,'Medicare Beneficiary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T|'')','EDISENRFS2Z0','9','D','50','14',NULL,'Medicare ID',NULL,NULL);

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','15','(''UA''=''T|'')','EDISENRFS2Z0','8','D','50','15',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStudent"','16','(''UA''=''T|'')','EDISENRFS2Z0','1','D','50','16',NULL,'Student',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIssueCard"','17','(''UA''=''T|'')','EDISENRFS2Z0','1','D','50','17',NULL,'Issue Card',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T|'')','EDISENRFS2Z0','1','D','50','18',NULL,'HRA Enrollment Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T|'')','EDISENRFS2Z0','1','D','50','19',NULL,'HRA Enrollment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExternalDependentID"','20','(''UA''=''T'')','EDISENRFS2Z0','20','D','50','20',NULL,'External Dependent ID',NULL,NULL);

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FF"','1','(''DA''=''T|'')','EDISENRFS2Z0','2','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','2','(''UA''=''T|'')','EDISENRFS2Z0','20','T','90','2',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DBI"','3','(''DA''=''T|'')','EDISENRFS2Z0','3','T','90','3',NULL,'Administrator Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerCode"','4','(''UA''=''T|'')','EDISENRFS2Z0','6','T','90','4',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittedDate"','5','(''UDMDY''=''T|'')','EDISENRFS2Z0','8','T','90','5',NULL,'Submitted Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittedTime"','6','(''UA''=''T'')','EDISENRFS2Z0','6','T','90','6',NULL,'Submitted Time',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDISENRFS2_20210330.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','SPXBO,SPXK9',NULL,NULL,NULL,'1st of Month Discovery Enroll','202006019','EMPEXPORT','1stofMonth',NULL,'EDISENRFS2',NULL,NULL,NULL,'202103019',NULL,NULL,'202102211',NULL,'','','202005251',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201811029','EMPEXPORT','OEACTIVE',NULL,'EDISENRFS2',NULL,NULL,NULL,'201811029','Nov  2 2018 12:38PM','Nov  2 2018 12:38PM','201811021',NULL,'','','201811021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201811029','EMPEXPORT','OEPASSIVE',NULL,'EDISENRFS2',NULL,NULL,NULL,'201811029','Nov  2 2018 12:38PM','Nov  2 2018 12:38PM','201811021',NULL,'','','201811021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Discovery FSA PT/EN File 3.5','201811029','EMPEXPORT','ONDEMAND',NULL,'EDISENRFS2',NULL,NULL,NULL,'201811029','Nov  2 2018 12:38PM','Nov  2 2018 12:38PM','201811021',NULL,'','','201811021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'SPXBO,SPXK9',NULL,NULL,NULL,'Discovery FSA Enrollment Week','202005129','EMPEXPORT','SCHEDULED',NULL,'EDISENRFS2',NULL,NULL,NULL,'202103269','Nov  2 2018 12:38PM','Nov  2 2018 12:38PM','202103181',NULL,'','','202005051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','SPXBO,SPXK9',NULL,NULL,NULL,'Test Purposes Only','202102221','EMPEXPORT','TEST','Mar 24 2021 11:37AM','EDISENRFS2',NULL,NULL,NULL,'202102221','Feb 22 2021 12:00AM','Feb 15 2021 12:00AM','202102221','1449','','','202102221',dbo.fn_GetTimedKey(),NULL,'us3rVaCRO1006',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISENRFS2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISENRFS2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISENRFS2','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISENRFS2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISENRFS2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISENRFS2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDISENRFS2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDISENRFS2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDISENRFS2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISENRFS2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISENRFS2','H01','dbo.U_EDISENRFS2_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISENRFS2','D10','dbo.U_EDISENRFS2_drvTbl_PT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISENRFS2','D20','dbo.U_EDISENRFS2_drvTbl_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISENRFS2','D30','dbo.U_EDISENRFS2_drvTbl_CT','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISENRFS2','D40','dbo.U_EDISENRFS2_drvTbl_BK','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISENRFS2','D50','dbo.U_EDISENRFS2_drvTbl_DP',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISENRFS2','T90','dbo.U_EDISENRFS2_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EDISENRFS2') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISENRFS2] (
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
IF OBJECT_ID('U_EDISENRFS2_DedList') IS NULL
CREATE TABLE [dbo].[U_EDISENRFS2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDISENRFS2_drvTbl_EN') IS NULL
CREATE TABLE [dbo].[U_EDISENRFS2_drvTbl_EN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvParticipantFileImportID] char(11) NULL,
    [drvPlanName] varchar(32) NULL,
    [drvEnrollmentEffectiveDate] datetime NULL,
    [drvParticipantElectionAmount] varchar(30) NULL,
    [drvEnrollmentTerminationDate] datetime NULL,
    [drvElectionAmountIndicator] varchar(8) NULL,
    [drvHDHPCoverageLevel] varchar(6) NULL
);
IF OBJECT_ID('U_EDISENRFS2_drvTbl_PT') IS NULL
CREATE TABLE [dbo].[U_EDISENRFS2_drvTbl_PT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvParticipantFileImportID] char(11) NULL,
    [drvEmployerEmployeeID] varchar(1) NOT NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NOT NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvCountry] varchar(2) NOT NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvWorkPhoneExtension] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvHireDate] datetime NULL,
    [drvDivision] varchar(4) NULL,
    [drvHoursPerWeek] varchar(1) NOT NULL,
    [drvPayrollFrequency] varchar(7) NOT NULL,
    [drvParticipantStatus] varchar(10) NULL,
    [drvStatusEffectiveDate] datetime NULL,
    [drvHoldPayrollDeductions] varchar(1) NOT NULL,
    [drvHoldEmployerContributions] varchar(1) NOT NULL,
    [drvIncurServices] varchar(1) NOT NULL,
    [drvFinalPayrollProcessDate] datetime NULL,
    [drvFinalContribProcessDate] datetime NULL,
    [drvMobileNumber] char(3) NULL
);
IF OBJECT_ID('U_EDISENRFS2_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISENRFS2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDISENRFS2_File') IS NULL
CREATE TABLE [dbo].[U_EDISENRFS2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EDISENRFS2_Header') IS NULL
CREATE TABLE [dbo].[U_EDISENRFS2_Header] (
    [drvEmployerCode] varchar(5) NOT NULL,
    [drvSubmittedDate] datetime NOT NULL,
    [drvSubmittedTime] varchar(8000) NULL,
    [drvFileVersion] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EDISENRFS2_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDISENRFS2_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPlanName] varchar(22) NULL,
    [PdhPerControl] varchar(8) NULL,
    [PdhContribDesc] varchar(17) NOT NULL,
    [PdhCurAmt] money NULL
);
IF OBJECT_ID('U_EDISENRFS2_Trailer') IS NULL
CREATE TABLE [dbo].[U_EDISENRFS2_Trailer] (
    [drvRecordCount] varchar(30) NULL,
    [drvEmployerCode] varchar(5) NOT NULL,
    [drvSubmittedDate] datetime NOT NULL,
    [drvSubmittedTime] varchar(8000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISENRFS2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Crossover Health Management Services, Inc.

Created By: John Maresca 
Business Analyst: Lauren Brown
Create Date: 1/24/2019
Service Request Number:  SR #: SR-2019- 00252869

Purpose: Discovery FSA PT/EN File 3.5

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2018     SR-2018-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISENRFS2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISENRFS2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISENRFS2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISENRFS2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISENRFS2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISENRFS2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISENRFS2', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISENRFS2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISENRFS2', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISENRFS2';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISENRFS2', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           DATETIME  
            ,@PlanYearStart     DATETIME;  
  
    -- Declare dates from Parameter file  
    SELECT  
         @StartPerControl = StartPerControl  
        ,@EndPerControl   = EndPerControl  
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)  
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))  
        ,@FormatCode      = FormatCode  
        ,@ExportCode      = ExportCode  
        ,@RunDate         = GETDATE()  
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)  
    WHERE FormatCode = 'EDISENRFS2';  
  
    -- Set FSA Plan Year Start  
    SET @PlanYearStart = CASE WHEN MONTH(@EndDate) = 12 THEN '01/01/' + CONVERT(CHAR(4),YEAR(DATEADD(YEAR,1,@EndDate)))  
                              ELSE '01/01/' + CONVERT(CHAR(4),YEAR(@EndDate))  
                         END;  

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EDISENRFS2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISENRFS2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_EDISENRFS2_EEList
    FROM dbo.U_EDISENRFS2_EEList
    JOIN Empcomp
    ON EECEEID=XEEID
    WHERE EecEEtype = 'Tes'
    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MEDFT,MEDPT,FSA,FSAPT,DEPEV,LPFFT,LFAPT,COTPR,COTPO,COPPR,COPPO');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');  
  
    -- Non-Required parameters  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP');  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'IncludeOEDrops','N');  
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
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;  

    --==========================================
    -- Build Working Tables
    --==========================================

   -----------------------------  
    -- Working Table - PDedHist  
    -----------------------------  
    IF OBJECT_ID('U_EDISENRFS2_PDedHist','U') IS NOT NULL  
        DROP TABLE dbo.U_EDISENRFS2_PDedHist;  
  
    -- Insert employee contributions (EE Amount)  
    SELECT DISTINCT  
         PdhEEID  
        ,PdhPlanName    = CASE WHEN PdhDedCode IN ('FSA','FSAPT')  THEN 'Medical FSA'  
                               WHEN PdhDedCode IN ('DEPEV')  THEN 'Dependent Care FSA'  
                               WHEN PdhDedCode IN ('LPFFT','LFAPT')  THEN 'Limited Medical FSA'  
                              -- WHEN PdhDedCode IN ('HSAIF','HSAFC','HSAPI','HSAPC','HSAFF','HSPCF','HSAPF','HSCFF')  THEN 'Health Savings Account'  
                               WHEN PdhDedCode IN ('MEDFT','MEDPT')  THEN 'Health Savings Account' 
                               WHEN PdhDedCode IN ('COTPR','COTPO') THEN 'Mass Transit'  
                               WHEN PdhDedCode IN ('COPPR','COPPO') THEN 'Parking'  
                          END  
        ,PdhPerControl  = MAX(LEFT(PdhPerControl,8))  
        ,PdhContribDesc = 'Payroll Deduction'  
        ,PdhCurAmt      = SUM(PdhEECurAmt)  
    INTO dbo.U_EDISENRFS2_PDedHist  
    FROM dbo.PDedHist WITH (NOLOCK)  
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  
    AND PdhDedCode IN ('HSAIF','HSAFC','HSAPI','HSAPC','HSAFF','HSCFF','HSAPF','HSPCF','FSA','FSAPT','DEPEV','LPFFT','LFAPT','COTPR','COTPO','COPPR','COPPO')    
    GROUP BY PdhEEID  
        ,CASE WHEN PdhDedCode IN ('FSA','FSAPT')  THEN 'Medical FSA'  
              WHEN PdhDedCode IN ('DEPEV')  THEN 'Dependent Care FSA'  
              WHEN PdhDedCode IN ('LPFFT','LFAPT')  THEN 'Limited Medical FSA'  
              --WHEN PdhDedCode IN ('HSAIF','HSAFC','HSAPI','HSAPC','HSAFF','HSPCF','HSAPF','HSCFF')  THEN 'Health Savings Account' 
              WHEN PdhDedCode IN ('MEDFT','MEDPT')  THEN 'Health Savings Account'  
              WHEN PdhDedCode IN ('COTPR','COTPO') THEN 'Mass Transit'  
              WHEN PdhDedCode IN ('COPPR','COPPO') THEN 'Parking'  
        END  
    HAVING (SUM(PdhEECurAmt) <> 0.00);  

    -- Insert employer contributions (ER Amount)  
    INSERT INTO dbo.U_EDISENRFS2_PDedHist  
    SELECT DISTINCT  
         PdhEEID  
        ,PdhPlanName    = CASE WHEN PdhDedCode IN ('FSA','FSAPT')  THEN 'Medical FSA'  
                               WHEN PdhDedCode IN ('DEPEV')  THEN 'Dependent Care FSA'  
                               WHEN PdhDedCode IN ('LPFFT','LFAPT')  THEN 'Limited Medical FSA'  
                              -- WHEN PdhDedCode IN ('HSAIF','HSAFC','HSAPI','HSAPC','HSAFF','HSPCF','HSAPF','HSCFF')  THEN 'Health Savings Account'  
                               WHEN PdhDedCode IN ('MEDFT','MEDPT')  THEN 'Health Savings Account' 
                               WHEN PdhDedCode IN ('COTPR','COTPO') THEN 'Mass Transit'  
                               WHEN PdhDedCode IN ('COPPR','COPPO') THEN 'Parking'  
                          END  
        ,PdhPerControl  = MAX(LEFT(PdhPerControl,8))  
        ,PdhContribDesc = 'Employer Contribution'  
        ,PdhCurAmt      = SUM(PdhERCurAmt)  
    FROM dbo.PDedHist WITH (NOLOCK)  
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  
    AND PdhDedCode IN ('HSAIF','HSAFC','HSAPI','HSAPC','HSAFF','HSCFF','HSAPF','HSPCF','FSA','FSAPT','DEPEV','LPFFT','LFAPT','COTPR','COTPO','COPPR','COPPO')
    GROUP BY PdhEEID  
        ,CASE WHEN PdhDedCode IN ('FSA','FSAPT')  THEN 'Medical FSA'  
              WHEN PdhDedCode IN ('DEPEV')  THEN 'Dependent Care FSA'  
              WHEN PdhDedCode IN ('LPFFT','LFAPT')  THEN 'Limited Medical FSA'  
             -- WHEN PdhDedCode IN ('HSAIF','HSAFC','HSAPI','HSAPC','HSAFF','HSPCF','HSAPF','HSCFF')  THEN 'Health Savings Account'  
              WHEN PdhDedCode IN ('MEDFT','MEDPT')  THEN 'Health Savings Account'  
              WHEN PdhDedCode IN ('COTPR','COTPO') THEN 'Mass Transit'  
              WHEN PdhDedCode IN ('COPPR','COPPO') THEN 'Parking'  
         END  
    HAVING (SUM(PdhERCurAmt) <> 0.00);  

-- Populate one time and then remove(based on Audit Date of termination)
 
DELETE U_EDISENRFS2_EEList
--  Select t.tstat,t.tdate,*                --uncomment to see which employees would be removed from EELIST
    FROM U_EDISENRFS2_EEList
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCOID
 
--Audit Date of LastDateOFTermination
LEFT JOIN (        select esheeid eeid, eshcoid coid, eshemplstatus tstat,eshstatusstartdate tdate,
ROW_NUMBER() OVER (PARTITION BY eshEEID ORDER BY eshstatusstartdate desc) tNo from emphstat
where eshemplstatus = 'T') t on t.eeid = xeeid and t.coid = xcoid and t.tNo = '1'
 
    WHERE t.tdate not between @Enddate-7 and @Enddate



    --==========================================
    -- Build Driver Tables
    --==========================================
  --==========================================  
    -- Build Employee Data and the driver tables  
    --==========================================  
  
    ----------------------------------------  
    -- Detail Record - Participant (PT)  
    ----------------------------------------  
    IF OBJECT_ID('U_EDISENRFS2_drvTbl_PT','U') IS NOT NULL  
        DROP TABLE dbo.U_EDISENRFS2_drvTbl_PT;  
    SELECT DISTINCT  
         drvEEID = xEEID  
        ,drvCoID = xCoID  
        ,drvInitialSort = RTRIM(EepSSN)  
        -- standard fields above and additional driver fields below  
        ,drvParticipantFileImportID = EepSSN  
        ,drvEmployerEmployeeID = ''  
        ,drvEmployeeNumber = EecEmpNo  
        ,drvLastName = EepNameLast  
        ,drvFirstName = EepNameFirst  
        ,drvMiddleInitial = ''--LEFT(EepNameMiddle,1)  
        ,drvGender = ''--EepGender  
        ,drvMaritalStatus = ''--eepMaritalStatus  
        ,drvDateOfBirth =  EepDateOfBirth  
        ,drvSSN = EepSSN  
        ,drvAddressLine1 = EepAddressLine1  
        ,drvAddressLine2 = EepAddressLine2  
        ,drvCity = EepAddressCity  
        ,drvState = EepAddressState  
        ,drvZipCode = EepAddressZipCode  
        ,drvCountry = 'US'--EepAddressCountry  
        ,drvHomePhone = EepPhoneHomeNumber  
        ,drvWorkPhone = ''--EecPhoneBusinessNumber  
        ,drvWorkPhoneExtension =''-- EecPhoneBusinessNumber  
        ,drvEmailAddress = EepAddressEMail  
        ,drvHireDate = EecDateOfOriginalHire  
        ,drvDivision = CASE Cmpcompanycode WHEN 'CHMG' THEN 'CHMG' WHEN 'CHMS' THEN 'CHMS' END
        ,drvHoursPerWeek = ''/* CASE EecPayPeriod  
                                WHEN 'W' THEN EecScheduledWorkHrs  
                                WHEN 'B' THEN EecScheduledWorkHrs / 2  
                                WHEN 'S' THEN (EecScheduledWorkHrs * 2) / 4  
                                WHEN 'M' THEN EecScheduledWorkHrs / 4  
                           END  */
        ,drvPayrollFrequency = 'Payroll' /* CASE EecPayPeriod
                                    WHEN 'W' THEN 'Weekly'
                                    WHEN 'B' THEN 'Bi-Weekly'
                                    WHEN 'S' THEN 'Semi-Monthly'
                                    WHEN 'M' THEN 'Monthly'
                               END*/
        ,drvParticipantStatus = CASE EecEmplStatus  
                                     WHEN 'A' THEN 'Active'  
                                     WHEN 'L' THEN 'Active'  
                                     WHEN 'T' THEN 'Terminated'  
                                END  
        ,drvStatusEffectiveDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY,1,EecDateOfTermination)  
                                  -- WHEN EecEmplStatus = 'T' THEN DATEADD(DAY,30,EecDateOfTermination)  -- not per the spec 2/20
                                   --    WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate  
                                       ELSE EecDateOfLastHire  
                                  END  
        -- For LOA Employees: Hold Payroll, Hold Employer, Incur Services  
        ,drvHoldPayrollDeductions = ''  
        ,drvHoldEmployerContributions = ''  
        ,drvIncurServices = ''  
        ,drvFinalPayrollProcessDate = CASE WHEN eecemplstatus = 't' then DATEADD(DAY,30,EecDateOfTermination)  END  
        ,drvFinalContribProcessDate = CASE WHEN eecemplstatus = 't' then DATEADD(DAY,30,EecDateOfTermination)  END  
        ,drvMobileNumber = EPh.efoPhoneType
    INTO dbo.U_EDISENRFS2_drvTbl_PT  
    FROM dbo.U_EDISENRFS2_EEList WITH (NOLOCK)  
    JOIN dbo.EmpComp WITH (NOLOCK)  
        ON EecEEID = xEEID   
        AND EecCoID = xCoID  
    JOIN dbo.EmpPers WITH (NOLOCK)  
        ON EepEEID = xEEID  
    JOIN dbo.U_dsi_BDM_EDISENRFS2 WITH (NOLOCK)  
        ON BdmEEID = xEEID   
        AND BdmCoID = xCoID

    LEFT JOIN (select top 1 * from EmpMPhon where  efoPhoneType = 'CEL' order by SystemID desc) EPh ON xEEID = EPh.efoEEID 
    LEFT JOIN dbo.Company WITH (NOLOCK) ON CmpCOID = EecCOID
        ;  

   ----------------------------------------  
    -- Detail Record - Enrollment (EN)  
    ----------------------------------------  
    IF OBJECT_ID('U_EDISENRFS2_drvTbl_EN','U') IS NOT NULL  
        DROP TABLE dbo.U_EDISENRFS2_drvTbl_EN;  
    SELECT DISTINCT  
         drvEEID = xEEID  
        ,drvCoID = xCoID  
        ,drvInitialSort = RTRIM(EepSSN)  
        -- standard fields above and additional driver fields below  
        ,drvParticipantFileImportID = EepSSN  
        ,drvPlanName = CASE WHEN BdmDedCode IN ('FSA','FSAPT')  THEN 'Medical FSA'  
                            WHEN BdmDedCode IN ('DEPEV')  THEN 'Dependent Care FSA'  
                            WHEN BdmDedCode IN ('LPFFT','LFAPT')  THEN 'Limited Medical FSA'  
                          --  WHEN BdmDedCode IN ('HSAIF','HSAFC','HSAPI','HSAPC','HSAFF','HSPCF','HSAPF','HSCFF')  THEN 'Health Savings Account'
                            WHEN BdmDedCode IN ('MEDFT','MEDPT')  THEN 'Health Savings Account'  
                            WHEN BdmDedCode IN ('COTPR','COTPO') THEN 'Mass Transit'  
                            WHEN BdmDedCode IN ('COPPR','COPPO') THEN 'Parking'  
                            WHEN BdmDedCode IN ('XOMFT','XOMPT') THEN 'Health Reimbursement Arrangement'

                       END  
        ,drvEnrollmentEffectiveDate =   dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate,@PlanYearStart)   
                                    /*     CASE WHEN BdmDedType IN ('HSA','FSA') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate,@PlanYearStart)  
                                           ELSE BdmBenStartDate  
                                           END  */
        ,drvParticipantElectionAmount = CONVERT(varchar,CASE --WHEN BdmDedType = 'FSA' THEN BdmEEGoalAmt --Annual election amounts for FSAs.  
                                             --WHEN BdmDedCode IN ('PARKING','TRANSIT') THEN BdmEEAmt --Monthly election amounts for Parking and Transit plans.  
                                             WHEN bdmdedcode IN ('FSA','FSAPT', 'DEPEV','LPFFT','LFAPT') then bdmeegoalamt 
                                             WHEN bdmdedcode IN ('COTPR','COTPO', 'COPPR','COPPO') then '270'
                                             ELSE 0.00 --0 for HSAs.  
                                        END  ) 
        ,drvEnrollmentTerminationDate = CASE WHEN BdmDedCode NOT IN ('HSAIF','HSAFC','HSAPI','HSAPC','HSAFF','HSPCF','HSAPF','HSCFF') THEN  ISNULL(BdmBenstopdate,EecDateOfTermination) END  --CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END  
        ,drvElectionAmountIndicator = 
                                       CASE WHEN BdmDedCode IN ('MEDFT','MEDPT') THEN 'PerPay'  
                                           WHEN BdmDedCode IN ('COTPR','COTPO', 'COPPR','COPPO')  THEN 'PerMonth'  
                                      END  
        ,drvHDHPCoverageLevel =CASE 
                                     WHEN NULLIF(BdmBenOption,'') = 'EE' THEN 'Ind'
                                     WHEN NULLIF(BdmBenOption,'') = 'ES' THEN 'IndSpouse'
                                     WHEN NULLIF(BdmBenOption,'') = 'EEC' THEN 'IndChild'
                                     WHEN NULLIF(BdmBenOption,'') IS NOT NULL THEN 'Family'
                                END
    INTO dbo.U_EDISENRFS2_drvTbl_EN  
    FROM dbo.U_EDISENRFS2_EEList WITH (NOLOCK)  
    JOIN dbo.EmpComp WITH (NOLOCK)  
        ON EecEEID = xEEID   
        AND EecCoID = xCoID  
    JOIN dbo.EmpPers WITH (NOLOCK)  
        ON EepEEID = xEEID  
    JOIN dbo.U_dsi_BDM_EDISENRFS2 WITH (NOLOCK)  
        ON BdmEEID = xEEID   
        AND BdmCoID = xCoID;  

    ---------------------------------
    -- DETAIL RECORD - U_EDISENRFS2_drvTbl_CT
    ---------------------------------
  --  IF OBJECT_ID('U_EDISENRFS2_drvTbl_CT','U') IS NOT NULL
  --      DROP TABLE dbo.U_EDISENRFS2_drvTbl_CT;
  --  SELECT DISTINCT
  --       drvEEID = xEEID
  --      ,drvCoID = xCoID
  --      ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
  --      ,drvInitialSort = ''
        ---- standard fields above and additional driver fields below
  --      ,drvParticipantFileImportID = ''
  --      ,drvPlanName = ''
  --      ,drvContributionDate = ''
  --      ,drvContributionDescription = ''
  --      ,drvContributionAmount = ''
  --  INTO dbo.U_EDISENRFS2_drvTbl_CT
  --  FROM dbo.U_EDISENRFS2_EEList WITH (NOLOCK)
  --  JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
  --      ON EedEEID = xEEID 
  --      AND EedCoID = xCoID
  --      AND EedFormatCode = @FormatCode 
  --      AND EedValidForExport = 'Y'
  --  ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISENRFS2_drvTbl_BK
    ---------------------------------
  --  IF OBJECT_ID('U_EDISENRFS2_drvTbl_BK','U') IS NOT NULL
  --      DROP TABLE dbo.U_EDISENRFS2_drvTbl_BK;
  --  SELECT DISTINCT
  --       drvEEID = xEEID
  --      ,drvCoID = xCoID
  --      ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
  --      ,drvInitialSort = ''
        ---- standard fields above and additional driver fields below
  --      ,drvParticipantFileImportID = ''
  --      ,drvNickname = ''
  --      ,drvAccountUse = ''
  --      ,drvAccountType = ''
  --      ,drvAccountStatus = ''
  --      ,drvBankName = ''
  --      ,drvRoutingNumber = ''
  --      ,drvAccountNumber = ''
  --      ,drvPrenote = ''
  --      ,drvBankAccountAddressLine1 = EepAddressLine1
  --      ,drvBankAccountAddressLine2 = EepAddressLine2
  --      ,drvBankCity = EepAddressCity
  --      ,drvBankState = EepAddressState
  --      ,drvBankZipCode = EepAddressZipCode
  --      ,drvBankCountry = EepAddressCountry
  --  INTO dbo.U_EDISENRFS2_drvTbl_BK
  --  FROM dbo.U_EDISENRFS2_EEList WITH (NOLOCK)
  --  JOIN dbo.EmpPers WITH (NOLOCK)
  --      ON EepEEID = xEEID
  --  JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
  --      ON EedEEID = xEEID 
  --      AND EedCoID = xCoID
  --      AND EedFormatCode = @FormatCode 
  --      AND EedValidForExport = 'Y'
  --  ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISENRFS2_drvTbl_DP
    ---------------------------------
  IF OBJECT_ID('U_EDISENRFS2_drvTbl_DP','U') IS NOT NULL
     DROP TABLE dbo.U_EDISENRFS2_drvTbl_DP;
   SELECT DISTINCT
      drvEEID = xEEID
     ,drvCoID = xCoID
    ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
     ,drvInitialSort = RTRIM(EepSSN)  
        ---- standard fields above and additional driver fields below
    ,drvParticipantFileImportID = RTRIM(EepSSN)  
    ,drvDependentFileImportId = ConSSN
    ,drvDependentNumber = ''
    ,drvRelationship = CASE WHEN BdmRelationship = 'SPS' THEN 'Spouse'
                            WHEN BdmRelationship = 'CHL' THEN 'Child'
                       END 
   ,drvLastName = ConNameLast
   ,drvFirstName = ConNameFirst
   ,drvMiddleInitial = LEFT(Isnull(ConNameMiddle,''),1)
   ,drvGender = ConGender
  ,drvDateOfBirth = ConDateOfBirth
  ,drvSSN = ConSSN
  ,drvStatus = ''
  ,drvStudent = ''
  ,drvIssueCard = ''
 ,drvExternalDependentID = ''
 INTO dbo.U_EDISENRFS2_drvTbl_DP
 FROM dbo.U_EDISENRFS2_EEList WITH (NOLOCK)    
JOIN dbo.EmpComp WITH (NOLOCK)  
    ON EecEEID = xEEID   
    AND EecCoID = xCoID  
JOIN dbo.EmpPers WITH (NOLOCK)  
    ON EepEEID = xEEID  

JOIN dbo.U_dsi_BDM_EDISENRFS2 WITH (NOLOCK)  
    ON BdmEEID = xEEID   
    AND BdmCoID = xCoID 
JOIN dbo.Contacts  WITH (NOLOCK)  
    ON Coneeid =  BdmEEID
    and conSystemId = BdmDepRecID
Where BdmDedCode IN ('XOMFT','XOMPT')
---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISENRFS2_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDISENRFS2_Header;
    SELECT DISTINCT
         drvEmployerCode = '35955'
        ,drvSubmittedDate = GETDATE()
        ,drvSubmittedTime = REPLACE(CONVERT(varchar,GETDATE(),108),':','')
        ,drvFileVersion = '3.5'
    INTO dbo.U_EDISENRFS2_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISENRFS2_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDISENRFS2_Trailer;
    SELECT DISTINCT
         drvRecordCount = convert(VARCHAR, (SELECT COUNT(1) FROM dbo.U_EDISENRFS2_drvTbl_PT) +  
                          (SELECT COUNT(1) FROM dbo.U_EDISENRFS2_drvTbl_EN))
        ,drvEmployerCode = '35955'
        ,drvSubmittedDate = GETDATE()
        ,drvSubmittedTime = REPLACE(CONVERT(varchar,GETDATE(),108),':','')
    INTO dbo.U_EDISENRFS2_Trailer
    ;

    --EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISENRFS2', 'ONDEMAND';

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_EDISENRFS2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_EDISENRFS2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'EDISENRFS2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEDISENRFS2_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EDISENRFS2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Alter the View - FH PT EN DP PT EN DP ....
 ALTER  View dbo.dsi_vwEDISENRFS2_Export as
        select top 2000000 rtrim(Data) as Data
             from dbo.U_EDISENRFS2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
                    initialsort, subsort, substring(Recordset,2,2)

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISENRFS2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201810261'
       ,expStartPerControl     = '201810261'
       ,expLastEndPerControl   = '201811029'
       ,expEndPerControl       = '201811029'
WHERE expFormatCode = 'EDISENRFS2';

**********************************************************************************/
GO
--Alter the View - FH PT EN DP PT EN DP ....
 CREATE  View dbo.dsi_vwEDISENRFS2_Export as
        select top 2000000 rtrim(Data) as Data
             from dbo.U_EDISENRFS2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
                    initialsort, subsort, substring(Recordset,2,2)