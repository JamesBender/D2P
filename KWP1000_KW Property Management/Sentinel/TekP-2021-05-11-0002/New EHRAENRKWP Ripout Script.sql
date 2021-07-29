SET NOCOUNT ON;
IF OBJECT_ID('U_EHRAENRKWP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHRAENRKWP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EHRAENRKWP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EHRAENRKWP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEHRAENRKWP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHRAENRKWP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHRAENRKWP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHRAENRKWP];
GO
IF OBJECT_ID('U_EHRAENRKWP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EHRAENRKWP_Trailer];
GO
IF OBJECT_ID('U_EHRAENRKWP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EHRAENRKWP_PDedHist];
GO
IF OBJECT_ID('U_EHRAENRKWP_Header') IS NOT NULL DROP TABLE [dbo].[U_EHRAENRKWP_Header];
GO
IF OBJECT_ID('U_EHRAENRKWP_File') IS NOT NULL DROP TABLE [dbo].[U_EHRAENRKWP_File];
GO
IF OBJECT_ID('U_EHRAENRKWP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHRAENRKWP_EEList];
GO
IF OBJECT_ID('U_EHRAENRKWP_drvTbl_PT') IS NOT NULL DROP TABLE [dbo].[U_EHRAENRKWP_drvTbl_PT];
GO
IF OBJECT_ID('U_EHRAENRKWP_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_EHRAENRKWP_drvTbl_EN];
GO
IF OBJECT_ID('U_EHRAENRKWP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHRAENRKWP_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EHRAENRKWP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EHRAENRKWP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EHRAENRKWP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EHRAENRKWP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EHRAENRKWP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHRAENRKWP','Sentinal HRA Enrollment','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EHRAENRKWPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EHRAENRKWP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FH"','1','(''DA''=''T|'')','EHRAENRKWPZ0','50','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SEN"','2','(''DA''=''T|'')','EHRAENRKWPZ0','50','H','01','2',NULL,'Administrator Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERCode"','3','(''UA''=''T|'')','EHRAENRKWPZ0','50','H','01','3',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','4','(''DA''=''T|'')','EHRAENRKWPZ0','50','H','01','4',NULL,'Sychronize Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDate"','5','(''UA''=''T|'')','EHRAENRKWPZ0','50','H','01','5',NULL,'Submitted Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileTime"','6','(''UA''=''T|'')','EHRAENRKWPZ0','50','H','01','6',NULL,'Submitted Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"3.3"','7','(''DA''=''T'')','EHRAENRKWPZ0','50','H','01','7',NULL,'File Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PT"','1','(''DA''=''T|'')','EHRAENRKWPZ0','50','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantID"','2','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','2',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEREEID"','3','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','3',NULL,'Employer Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','4','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','4',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','5',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','6',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','7',NULL,'MiddleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','8','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','8',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','9','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','9',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''T|'')','EHRAENRKWPZ0','50','D','10','10',NULL,'Mother''s Maiden Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','11','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','11',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','12','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','12',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','13',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','14',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''T|'')','EHRAENRKWPZ0','50','D','10','15',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''T|'')','EHRAENRKWPZ0','50','D','10','16',NULL,'Address Line 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','17','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','18','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','18',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','19','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','19',NULL,'ZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddresscountry"','20','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','20',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','21','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','21',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneWorkNumber"','22','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','22',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneWorkExt"','23','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','23',NULL,'Work Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','24','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','24',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserName"','25','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','25',NULL,'UserName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPassword"','26','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','26',NULL,'Password',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofOriginalHire"','27','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','27',NULL,'HireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''SS''=''T|'')','EHRAENRKWPZ0','50','D','10','28',NULL,'Divison',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursPerWeek"','29','(''UNT0''=''T|'')','EHRAENRKWPZ0','50','D','10','29',NULL,'Hours Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeClass"','30','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','30',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFreq"','31','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','31',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFreqEffDate"','32','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','32',NULL,'Payroll Frequency Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplStatus"','33','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','33',NULL,'drvParticipantStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusEffDate"','34','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','34',NULL,'Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''T|'')','EHRAENRKWPZ0','50','D','10','35',NULL,'Hold Payroll Deductions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''T|'')','EHRAENRKWPZ0','50','D','10','36',NULL,'Hold Employer Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''T|'')','EHRAENRKWPZ0','50','D','10','37',NULL,'Incur Services',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFinalPayrollProcessDate"','38','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','38',NULL,'Final Payroll Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFinalContribProcessDate"','39','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','39',NULL,'Final Contribution Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHSACustodian"','40','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','40',NULL,'HAS Custodian',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicareBeneficiary "','41','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','41',NULL,'MedicareBeneficiary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicalID"','42','(''UA''=''T|'')','EHRAENRKWPZ0','50','D','10','42',NULL,'MedicalID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExchangeIntegrationID"','43','(''UA''=''T|'')','EHRAENRKWPZ0','51','D','10','43',NULL,'Exchange Integration ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''SS''=''T|'')','EHRAENRKWPZ0','52','D','10','44',NULL,'Reporting Hierarchy Level1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''SS''=''T|'')','EHRAENRKWPZ0','53','D','10','45',NULL,'Reporting Hierarchy Level2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''SS''=''T|'')','EHRAENRKWPZ0','54','D','10','46',NULL,'Reporting Hierarchy Level3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''SS''=''T|'')','EHRAENRKWPZ0','55','D','10','47',NULL,'Reporting Hierarchy Level4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''SS''=''T|'')','EHRAENRKWPZ0','56','D','10','48',NULL,'CDD Citizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''SS''=''T|'')','EHRAENRKWPZ0','57','D','10','49',NULL,'CDD Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''SS''=''T|'')','EHRAENRKWPZ0','58','D','10','50',NULL,'CDD Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''SS''=''T|'')','EHRAENRKWPZ0','59','D','10','51',NULL,'CDD Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''SS''=''T|'')','EHRAENRKWPZ0','60','D','10','52',NULL,'CDD Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassEffectiveDate"','53','(''UA''=''T'')','EHRAENRKWPZ0','61','D','10','53',NULL,'Class Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EN"','1','(''DA''=''T|'')','EHRAENRKWPZ0','62','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T|'')','EHRAENRKWPZ0','63','D','20','2',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','3','(''UA''=''T|'')','EHRAENRKWPZ0','64','D','20','3',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenStartDate"','4','(''UA''=''T|'')','EHRAENRKWPZ0','65','D','20','4',NULL,'Enrollment Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEGoalAmt"','5','(''UA''=''T|'')','EHRAENRKWPZ0','66','D','20','5',NULL,'Participant Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenStopDate"','6','(''UA''=''T|'')','EHRAENRKWPZ0','67','D','20','6',NULL,'Enrollment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERContLevel"','7','(''UA''=''T|'')','EHRAENRKWPZ0','68','D','20','7',NULL,'Employer Contribution Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERContAmt"','8','(''UA''=''T|'')','EHRAENRKWPZ0','69','D','20','8',NULL,'Employer Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimReimb"','9','(''UA''=''T|'')','EHRAENRKWPZ0','70','D','20','9',NULL,'Primary Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''T|'')','EHRAENRKWPZ0','71','D','20','10',NULL,'Alternate Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','11','(''DA''=''T|'')','EHRAENRKWPZ0','72','D','20','11',NULL,'Enrolled in Claims Exchange',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectionAmountIndicator"','12','(''UA''=''T|'')','EHRAENRKWPZ0','73','D','20','12',NULL,'Election Amount Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDHPCovLvl"','13','(''UA''=''T|'')','EHRAENRKWPZ0','74','D','20','13',NULL,'HDHP Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYearStartDate"','14','(''UA''=''T|'')','EHRAENRKWPZ0','75','D','20','14',NULL,'Plan Year Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''T|'')','EHRAENRKWPZ0','76','D','20','15',NULL,'Terms and Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''T|'')','EHRAENRKWPZ0','77','D','20','16',NULL,'Date Terms Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''T|'')','EHRAENRKWPZ0','74','D','20','17',NULL,'Time Terms Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''T|'')','EHRAENRKWPZ0','74','D','20','18',NULL,'ChangeDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T'')','EHRAENRKWPZ0','74','D','20','19',NULL,'Spend Down',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FF"','1','(''DA''=''T|'')','EHRAENRKWPZ0','76','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecCount"','2','(''UA''=''T|'')','EHRAENRKWPZ0','77','T','90','2',NULL,'Count Record',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SEN"','3','(''DA''=''T|'')','EHRAENRKWPZ0','78','T','90','3',NULL,'Administrator Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERCodeTrl"','4','(''UA''=''T|'')','EHRAENRKWPZ0','79','T','90','4',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDate"','5','(''UA''=''T|'')','EHRAENRKWPZ0','80','T','90','5',NULL,'Submitted Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileTime"','6','(''UA''=''T'')','EHRAENRKWPZ0','81','T','90','6',NULL,'Submitted Time',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EHRAENRKWP_20210728.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',YFGCX',NULL,NULL,NULL,'Sentinal HRA Enroll OE Active','202006189','EMPEXPORT','OEACTIVE','Aug  2 2018 12:00AM','EHRAENRKWP',NULL,NULL,NULL,'202006189','Jul 27 2017 12:00AM','Dec 30 1899 12:00AM','202006181',NULL,'','','202006181',dbo.fn_GetTimedKey(),NULL,'ULTI_WPKWP',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',YFGCX',NULL,NULL,NULL,'Sentinal HRA Enroll OE Passive','202006189','EMPEXPORT','OEPASSIVE',NULL,'EHRAENRKWP',NULL,NULL,NULL,'202006189','Jan  3 2017  5:42PM','Jan  3 2017  5:42PM','202006181',NULL,'','','202006181',dbo.fn_GetTimedKey(),NULL,'ULTI_WPKWP',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',',YFGCX',NULL,NULL,NULL,'Sentinal HRA Enroll On Demand','202006189','EMPEXPORT','ONDEMAND','Aug  3 2018  3:14AM','EHRAENRKWP',NULL,NULL,NULL,'202006189','Jul 27 2018 12:00AM','Jul 21 2018 12:00AM','202006181','564','','','202006181',dbo.fn_GetTimedKey(),NULL,'ULTI_WPKWP',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','YFGCX',NULL,NULL,NULL,'Sentinal HRA Enroll Scheduled','202006189','EMPEXPORT','SCHHRAENR','Feb 20 2018 12:00AM','EHRAENRKWP',NULL,NULL,NULL,'202007179','Feb 16 2018 12:00AM','Dec 30 1899 12:00AM','202007101','335','','','202006181',dbo.fn_GetTimedKey(),NULL,'ULTI_WPKWP',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','YFGCX',NULL,NULL,NULL,'Test Purposes Only','202107229','EMPEXPORT','TEST','Jul 22 2021 12:18PM','EHRAENRKWP',NULL,NULL,NULL,'202107229','Jul 22 2021 12:00AM','Dec 30 1899 12:00AM','202107081','474','','','202107081',dbo.fn_GetTimedKey(),NULL,'us3lKiKWP1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHRAENRKWP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHRAENRKWP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHRAENRKWP','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHRAENRKWP','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHRAENRKWP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EHRAENRKWP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EHRAENRKWP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EHRAENRKWP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHRAENRKWP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHRAENRKWP','H01','dbo.U_EHRAENRKWP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHRAENRKWP','D10','dbo.U_EHRAENRKWP_drvTbl_PT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHRAENRKWP','D20','dbo.U_EHRAENRKWP_drvTbl_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHRAENRKWP','T90','dbo.U_EHRAENRKWP_Trailer',NULL);
IF OBJECT_ID('U_EHRAENRKWP_DedList') IS NULL
CREATE TABLE [dbo].[U_EHRAENRKWP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EHRAENRKWP_drvTbl_EN') IS NULL
CREATE TABLE [dbo].[U_EHRAENRKWP_drvTbl_EN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(9) NULL,
    [drvSSN] char(11) NULL,
    [drvPlanName] varchar(19) NULL,
    [drvBenStartDate] varchar(8000) NULL,
    [drvEEGoalAmt] varchar(1) NOT NULL,
    [drvBenStopDate] varchar(8000) NULL,
    [drvERContLevel] varchar(9) NOT NULL,
    [drvERContAmt] varchar(1) NOT NULL,
    [drvPrimReimb] varchar(5) NOT NULL,
    [drvElectionAmountIndicator] varchar(8) NOT NULL,
    [drvHDHPCovLvl] varchar(6) NOT NULL,
    [drvPlanYearStartDate] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EHRAENRKWP_drvTbl_PT') IS NULL
CREATE TABLE [dbo].[U_EHRAENRKWP_drvTbl_PT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(9) NULL,
    [drvParticipantID] char(11) NULL,
    [drvEREEID] char(9) NULL,
    [drvEmpNo] varchar(1) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvDateofBirth] varchar(8000) NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddresScountry] varchar(2) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvPhoneWorkNumber] varchar(50) NULL,
    [drvPhoneWorkExt] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvUserName] varchar(1) NOT NULL,
    [drvPassword] varchar(1) NOT NULL,
    [drvDateofOriginalHire] varchar(8000) NULL,
    [drvHoursPerWeek] decimal NULL,
    [drvEmployeeClass] varchar(3) NOT NULL,
    [drvpayfreq] varchar(10) NOT NULL,
    [drvPayFreqEffDate] varchar(1) NOT NULL,
    [drvEmplStatus] varchar(10) NULL,
    [drvStatusEffDate] varchar(8000) NULL,
    [drvFinalPayrollProcessDate] varchar(8000) NULL,
    [drvFinalContribProcessDate] varchar(8000) NULL,
    [drvHSACustodian] varchar(1) NOT NULL,
    [drvMedicareBeneficiary] varchar(1) NOT NULL,
    [drvMedicalID] varchar(1) NOT NULL,
    [drvExchangeIntegrationID] varchar(1) NOT NULL,
    [drvClassEffectiveDate] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EHRAENRKWP_EEList') IS NULL
CREATE TABLE [dbo].[U_EHRAENRKWP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EHRAENRKWP_File') IS NULL
CREATE TABLE [dbo].[U_EHRAENRKWP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EHRAENRKWP_Header') IS NULL
CREATE TABLE [dbo].[U_EHRAENRKWP_Header] (
    [drvERCode] varchar(5) NOT NULL,
    [drvFileDate] varchar(8000) NULL,
    [drvFileTime] varchar(6) NULL
);
IF OBJECT_ID('U_EHRAENRKWP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EHRAENRKWP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPerControl] varchar(8) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL
);
IF OBJECT_ID('U_EHRAENRKWP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EHRAENRKWP_Trailer] (
    [drvRecCount] int NULL,
    [drvERCodeTrl] varchar(5) NOT NULL,
    [drvFileDate] varchar(8000) NULL,
    [drvFileTime] varchar(6) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHRAENRKWP]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: KW Properties

Created By: Ashley Schaeffer
Business Analyst: Michael Christopher
Create Date: 03/11/2020
Service Request Number: KWP1000-2020-00268522

Purpose: Sentinal HRA Enrollment

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2017     SR-2017-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHRAENRKWP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHRAENRKWP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHRAENRKWP';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EHRAENRKWP';
SELECT * FROM dbo.AscDeff WHERE adfHeaderSystemID LIKE '%EHRAENRKWP%'
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHRAENRKWP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHRAENRKWP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHRAENRKWP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHRAENRKWP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHRAENRKWP', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHRAENRKWP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHRAENRKWP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EHRAENRKWP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileTime          VARCHAR(6) 
            ,@PlanYearStart            DATETIME
            ;

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl  = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
        ,@PlanYearStart      = case 
                                when convert(varchar,@enddate,112) < convert(varchar(4), year(@EndDate)) + '0601' then (convert(varchar(4), year(@EndDate)-1)) + '0601'
                                else convert(varchar(4), year(@EndDate)) + '0601'
    end
        ,@FileTime          = REPLACE(CONVERT(VARCHAR,GETDATE(),108),':','')

    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EHRAENRKWP';
    
    

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    DELETE FROM dbo.U_EHRAENRKWP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHRAENRKWP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','HMHR,HMHRT,HMHR,SHMHR');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@EndDate-30);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate');
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

--Bundled Benefits: add after populate bdm table and before benefit calc
--Employees need to pass 3 EN records
    
    --HRINP (HRA Inpatient)
    INSERT INTO dbo.U_dsi_bdm_EmpDeductions (eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, eeddedcode, eedvalidforexport, deddedcode, deddedtype)
     (select eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, 'HRINP', eedvalidforexport, 'HRINP', deddedtype
    FROM dbo.U_dsi_bdm_EmpDeductions with (nolock) WHERE eedformatcode = @FormatCode and eeddedcode IN ('HMHR','HMHRT','HMHR','SHMHR') and eedValidForExport = 'Y');

    --HROTP (HRA Outpatient)
    INSERT INTO dbo.U_dsi_bdm_EmpDeductions (eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, eeddedcode, eedvalidforexport, deddedcode, deddedtype)
     (select eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, 'HROTP', eedvalidforexport, 'HROTP', deddedtype
    FROM dbo.U_dsi_bdm_EmpDeductions with (nolock) WHERE eedformatcode = @FormatCode and eeddedcode IN ('HMHR','HMHRT','HMHR','SHMHR') and eedValidForExport = 'Y');


    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EHRAENRKWP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHRAENRKWP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhPerControl = LEFT(PdhPerControl,8)
        ,PdhEECurAmt = SUM(PdhEECurAmt)
        ,PdhERCurAmt = SUM(PdhERCurAmt)
    INTO dbo.U_EHRAENRKWP_PDedHist
    FROM dbo.U_EHRAENRKWP_EEList WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_EHRAENRKWP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
            AND PdhDedCode IN ('HMHR','HMHRT')
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID, LEFT(PdhPerControl,8)
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EHRAENRKWP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EHRAENRKWP_Header;
    SELECT DISTINCT
        drvERCode = '83987'
        ,drvFileDate = replace(convert(varchar, getDate(), 101),'/','')
        ,drvFileTime = @FileTime
    INTO dbo.U_EHRAENRKWP_Header
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EHRAENRKWP_drvTbl_PT
    ---------------------------------
    IF OBJECT_ID('U_EHRAENRKWP_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_EHRAENRKWP_drvTbl_PT;
    SELECT DISTINCT
        drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EecEmpNo)
        ------------------------------------
        ,drvParticipantID = EepSSN
        ,drvEREEID = EecEmpNo
        ,drvEmpNo = ''
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvGender = EepGender
        ,drvMaritalStatus = Case eepMaritalStatus
                                WHEN 'M' THEN 'M'
                                ELSE 'S'
                                END
        ,drvDateofBirth = replace(convert(varchar, eepdateofbirth, 101),'/','')
        ,drvSSN = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddresScountry = LEFT(EepAddressCountry,2)
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneWorkNumber = EecPhoneBusinessNumber
        ,drvPhoneWorkExt = ''    --EecPhoneBusinessExt
        ,drvEmailAddress = EepAddressEMail
        ,drvUserName = ''
        ,drvPassword = ''
        ,drvDateofOriginalHire = replace(convert(varchar, EecDateOfOriginalHire, 101),'/','')
        ,drvHoursPerWeek =  (CASE EecPayPeriod
                                    WHEN 'W' THEN EecScheduledWorkHrs
                                    WHEN 'S' THEN (EecScheduledWorkHrs * 24) / 52
                                    WHEN 'B' THEN (EecScheduledWorkHrs * 26) / 52
                                    WHEN 'M' THEN (EecScheduledWorkHrs * 12) / 52
                            END)
        ,drvEmployeeClass = 'ALL'
        ,drvpayfreq = 'Weekly (W)'
        ,drvPayFreqEffDate = ''
        ,drvEmplStatus = CASE WHEN EecEmplStatus ='A' THEN 'Active'
                              WHEN EecEmplStatus = 'T' THEn 'Terminated'
                              WHEN EecEmplStatus ='L' THEN 'Active'    --'LOA' 
                              END
        ,drvStatusEffDate = replace(convert(varchar, (CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY,1,EecDateOfTermination) ELSE EecEmplStatusStartDate END), 101),'/','')
        ,drvFinalPayrollProcessDate = replace(convert(varchar, (CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY,7,EecDateOfTermination) ELSE NULL END), 101),'/','')
        ,drvFinalContribProcessDate = replace(convert(varchar, (CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY,7,EecDateOfTermination) ELSE NULL END), 101),'/','')
        ,drvHSACustodian = ''
        ,drvMedicareBeneficiary  = ''
        ,drvMedicalID = ''
        ,drvExchangeIntegrationID = ''
        ,drvClassEffectiveDate = ''    --replace(convert(varchar, EecDateOfLastHire, 101),'/','')
        
    INTO dbo.U_EHRAENRKWP_drvTbl_PT
    FROM dbo.U_EHRAENRKWP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    --5/4 updated PT records to send for enrolled employees only 
    /*WHERE eecEEType = 'REG'
    AND (eecEmplStatus <> 'T' OR (eecEmplStatus = 'T' and eecDateOfTermination >= @EndDate-30))
    */
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EHRAENRKWP_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_EHRAENRKWP_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EHRAENRKWP_drvTbl_EN;
    SELECT DISTINCT
        drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EecEmpNo)
        ------------------------
        ,drvSSN = EepSSN
        ,drvPlanName = CASE EedDedCode
                        WHEN 'HMHR' THEN 'HRA ER ' +  CAST(YEAR(@PlanYearStart) AS VARCHAR(4)) 
                        WHEN 'SHMHR' THEN 'HRA ER ' +  CAST(YEAR(@PlanYearStart) AS VARCHAR(4)) 
                        --WHEN 'HMHRT' THEN 'HRA ER ' +  CAST(YEAR(@PlanYearStart) AS VARCHAR(4)) 
                        WHEN 'HRINP' THEN 'HRA Inpatient ' +  CAST(YEAR(@PlanYearStart) AS VARCHAR(4)) 
                        WHEN 'HROTP' THEN 'HRA Outpatient ' +  CAST(YEAR(@PlanYearStart) AS VARCHAR(4)) 
                        END
        ,drvBenStartDate = REPLACE(convert(varchar, dbo.dsi_fnGetMinMaxDates('MAX', eedBenStartDate, @PlanYearStart) ,101),'/','')
        ,drvEEGoalAmt = ''
        ,drvBenStopDate = CASE WHEN EecEmplStatus <> 'T' THEN replace(convert(varchar, EedBenStopDate,101),'/','') END
        ,drvERContLevel = CASE 
                            WHEN EedBenOPtion IN ('EE','EENW','EEO') THEN 'Ind'
                            WHEN EedBenoption IN ('EES','EESNW','EESP','EEDP') THEN 'IndSpouse'
                            --WHEN EedBenOption IN ('EEC','EECH','EECNW') THEN 'IndChild'   --client has no EE+1 child options
                            WHEN EedBenOption IN ('EEC','EECH','EECNW','EEF','EEFNW','EEDPF','FAM') THEN 'Family'
                            ELSE '' 
                            END 
        ,drvERContAmt = ''    --EedERAmt -- Not being used. Update Ascdeff to ('UNT2'='T|') if needed.
        ,drvPrimReimb = 'Check'
        ,drvElectionAmountIndicator = 'PlanYear'
        ,drvHDHPCovLvl = case 
                            when eedBenOption IN ('EE','EENW','EEO') then 'Single'
                            else 'Family'
                            end
        ,drvPlanYearStartDate =  ''    --'0101' + (CASE WHEN @ExportCode LIKE 'OE%' THEN CAST(YEAR(GETDATE())+1 AS VARCHAR(4)) ELSE CAST(YEAR(@PlanYearStart) AS VARCHAR(4)) END)--CAST(YEAR(GETDATE()) AS VARCHAR(4)) END)
        
    INTO dbo.U_EHRAENRKWP_drvTbl_EN
    FROM dbo.U_EHRAENRKWP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EHRAENRKWP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EHRAENRKWP_Trailer;
    SELECT DISTINCT
        drvRecCount = (SELECT COUNT(*) FROM dbo.U_EHRAENRKWP_drvTbl_PT (NOLOCK)) + (SELECT COUNT(*) FROM dbo.U_EHRAENRKWP_drvTbl_EN (NOLOCK))
        ,drvERCodeTrl = '83987'
        ,drvFileDate = replace(convert(varchar, getDate(), 101),'/','')
        ,drvFileTime = @FileTime

    INTO dbo.U_EHRAENRKWP_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EHRAENRKWP','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('EHRAENRKWP','Testing') = 'Y' THEN '' + CONVERT(VARCHAR(8),GETDATE(),112) + ' 83987 PT EN TEST.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN '' + CONVERT(VARCHAR(8),GETDATE(),112) + ' 83987 PT EN.txt'
                                  ELSE '' + CONVERT(VARCHAR(8),GETDATE(),112) + ' 83987 PT EN.txt'
                             END
        WHERE FormatCode = 'EHRAENRKWP';
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEHRAENRKWP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHRAENRKWP_File (NOLOCK)
    ORDER BY case RecordSet when 'H01' then '1' when 'T90' then '3' else '2' end, InitialSort, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHRAENRKWP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201612271'
       ,ExpStartPerControl     = '201612271'
       ,ExpLastEndPerControl   = '201701039'
       ,ExpEndPerControl       = '201701039'
WHERE ExpFormatCode = 'EHRAENRKWP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHRAENRKWP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHRAENRKWP_File (NOLOCK)
    ORDER BY case RecordSet when 'H01' then '1' when 'T90' then '3' else '2' end, InitialSort, RecordSet;