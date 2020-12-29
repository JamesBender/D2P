SET NOCOUNT ON;
IF OBJECT_ID('U_EDISCFSAXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSAXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDISCFSAXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDISCFSAXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDISCFSAXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISCFSAXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISCFSAXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCFSAXP];
GO
IF OBJECT_ID('U_EDISCFSAXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSAXP_Trailer];
GO
IF OBJECT_ID('U_EDISCFSAXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSAXP_Header];
GO
IF OBJECT_ID('U_EDISCFSAXP_File') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSAXP_File];
GO
IF OBJECT_ID('U_EDISCFSAXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSAXP_EEList];
GO
IF OBJECT_ID('U_EDISCFSAXP_drvTbl_PT') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSAXP_drvTbl_PT];
GO
IF OBJECT_ID('U_EDISCFSAXP_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSAXP_drvTbl_EN];
GO
IF OBJECT_ID('U_EDISCFSAXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSAXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDISCFSAXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCFSAXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISCFSAXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISCFSAXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISCFSAXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISCFSAXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISCFSAXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCFSAXP','Discovery FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EDISCFSAXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISCFSAXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FH"','1','(''DA''=''T|'')','EDISCFSAXPZ0','50','H','01','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DBI"','2','(''DA''=''T|'')','EDISCFSAXPZ0','50','H','01','2',NULL,'Administrator Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"39171"','3','(''DA''=''T|'')','EDISCFSAXPZ0','50','H','01','3',NULL,'Employer Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','4','(''DA''=''T|'')','EDISCFSAXPZ0','50','H','01','4',NULL,'Synchronize Flag ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittedDate"','5','(''UDMDY''=''T|'')','EDISCFSAXPZ0','50','H','01','5',NULL,'Submitted Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittedTime"','6','(''UA''=''T|'')','EDISCFSAXPZ0','50','H','01','6',NULL,'Submitted Time ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"3.5"','7','(''DA''=''T'')','EDISCFSAXPZ0','50','H','01','7',NULL,'File Version ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PT"','1','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticiantFileImportID"','2','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','2',NULL,'Participant File Import ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','3',NULL,'Employer Employee ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','4','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','4',NULL,'Employee Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','5',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','6',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','7',NULL,'Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','8','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','8',NULL,'Gender ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','9','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','9',NULL,'Marital Status ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','10',NULL,'Mothers Maiden Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','11','(''UDMDY''=''T|'')','EDISCFSAXPZ0','50','D','10','11',NULL,'Date Of Birth ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','12','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','12',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','13',NULL,'Address Line 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','14',NULL,'Address Line 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','15',NULL,'Address Line 3 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','16',NULL,'Address Line 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','17','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','17',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','18','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','18',NULL,'State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','19','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','19',NULL,'Zip Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','20',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','21','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','21',NULL,'Home Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','22',NULL,'Work Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','23',NULL,'Work Phone Extension ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','24','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','24',NULL,'Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','25',NULL,'Username ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','26',NULL,'Password ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','27','(''UDMDY''=''T|'')','EDISCFSAXPZ0','50','D','10','27',NULL,'Hire Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','28','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','28',NULL,'Division ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','29',NULL,'Hours Per Week ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E"','30','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','30',NULL,'Employee Class ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFrequency"','31','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','31',NULL,'Payroll Frequency ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','32',NULL,'Payroll Frequency Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantStatus"','33','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','33',NULL,'Participant Status ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusEffectiveDate"','34','(''UDMDY''=''T|'')','EDISCFSAXPZ0','50','D','10','34',NULL,'Status Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','35',NULL,'Hold Payroll Deductions ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','36',NULL,'Hold Employer Contributions ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','37',NULL,'Incur Services ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','38',NULL,'Final Payroll Process Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','39',NULL,'Final Contribution Process Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','40',NULL,'HSA Custodian ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','41',NULL,'Medicare Beneficiary ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','42',NULL,'Medicare ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','43',NULL,'Exchange Integration ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','44',NULL,'Reporting Hierarchy Level 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','45',NULL,'Reporting Hierarchy Level 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','46',NULL,'Reporting Hierarchy Level 3 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','47',NULL,'Reporting Hierarchy Level 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','48',NULL,'CDD_Citizenship ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','49',NULL,'CDD_Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','50',NULL,'CDD_EmploymentStatus ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','51',NULL,'CDD_Employer ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','52',NULL,'CDD_JobTitle ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','53',NULL,'Class Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','54',NULL,'ID_Identification Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','55',NULL,'ID_Identification Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','56',NULL,'ID_IssuingState ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','57',NULL,'ID_Issuer ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','58',NULL,'ID_IssueDate ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','59',NULL,'ID_ExpirationDa te ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','10','60',NULL,'Mobile Carrier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMobileNumber"','61','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','10','61',NULL,'Mobile Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''T'')','EDISCFSAXPZ0','50','D','10','62',NULL,'Time Zone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EN"','1','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','20','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticiantFileImportID"','2','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','20','2',NULL,'Participant File Import Id ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','3','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','20','3',NULL,'Plan Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentEffectiveDate"','4','(''UDMDY''=''T|'')','EDISCFSAXPZ0','50','D','20','4',NULL,'Enrollment Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantElectionAmount"','5','(''UA''=''T|'')','EDISCFSAXPZ0','50','D','20','5',NULL,'Participant Election Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentTerminationDate"','6','(''UDMDY''=''T|'')','EDISCFSAXPZ0','50','D','20','6',NULL,'Enrollment Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','20','7',NULL,'Employer Contribution Level ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','20','8',NULL,'Employer Contribution Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','20','9',NULL,'Primary Reimbursement ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','20','10',NULL,'Alternate Reimbursement ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','20','11',NULL,'Enrolled In Claims Exchange ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','20','12',NULL,'Election Amount Indicator ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','20','13',NULL,'HDHP Coverage Level ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYearStartDate"','14','(''UDMDY''=''T|'')','EDISCFSAXPZ0','50','D','20','14',NULL,'Plan Year Start Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','20','15',NULL,'Terms and Conditions Accepted ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','20','16',NULL,'Date Terms Conditions Accepted ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','20','17',NULL,'Time Terms Conditions Accepted ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T|'')','EDISCFSAXPZ0','50','D','20','18',NULL,'Change Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T'')','EDISCFSAXPZ0','50','D','20','19',NULL,'Spend Down ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FF"','1','(''DA''=''T|'')','EDISCFSAXPZ0','50','T','90','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','2','(''UA''=''T|'')','EDISCFSAXPZ0','50','T','90','2',NULL,'Record Count ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DBI"','3','(''DA''=''T|'')','EDISCFSAXPZ0','50','T','90','3',NULL,'Administrator Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"39171"','4','(''DA''=''T|'')','EDISCFSAXPZ0','50','T','90','4',NULL,'Employer Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittedDate"','5','(''UDMDY''=''T|'')','EDISCFSAXPZ0','50','T','90','5',NULL,'Submitted Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittedTime"','6','(''UA''=''T'')','EDISCFSAXPZ0','50','T','90','6',NULL,'Submitted Time ',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDISCFSAXP_20201221.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202012209','EMPEXPORT','OEACTIVE',NULL,'EDISCFSAXP',NULL,NULL,NULL,'202012209','Dec 20 2020 12:14PM','Dec 20 2020 12:14PM','202012201',NULL,'','','202012201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202012209','EMPEXPORT','OEPASSIVE',NULL,'EDISCFSAXP',NULL,NULL,NULL,'202012209','Dec 20 2020 12:14PM','Dec 20 2020 12:14PM','202012201',NULL,'','','202012201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discovery FSA Export','202012209','EMPEXPORT','ONDEM_XOE',NULL,'EDISCFSAXP',NULL,NULL,NULL,'202012209','Dec 20 2020 12:14PM','Dec 20 2020 12:14PM','202012201',NULL,'','','202012201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discovery FSA Export-Sched','202012209','EMPEXPORT','SCH_EDISCF',NULL,'EDISCFSAXP',NULL,NULL,NULL,'202012209','Dec 20 2020 12:14PM','Dec 20 2020 12:14PM','202012201',NULL,'','','202012201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Discovery FSA Export-Test','202012209','EMPEXPORT','TEST_XOE',NULL,'EDISCFSAXP',NULL,NULL,NULL,'202012209','Dec 20 2020 12:14PM','Dec 20 2020 12:14PM','202012201',NULL,'','','202012201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFSAXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFSAXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFSAXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFSAXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFSAXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDISCFSAXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDISCFSAXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDISCFSAXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSAXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFSAXP','H01','dbo.U_EDISCFSAXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFSAXP','D10','dbo.U_EDISCFSAXP_drvTbl_PT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFSAXP','D20','dbo.U_EDISCFSAXP_drvTbl_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFSAXP','T90','dbo.U_EDISCFSAXP_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EDISCFSAXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISCFSAXP] (
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
IF OBJECT_ID('U_EDISCFSAXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EDISCFSAXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDISCFSAXP_drvTbl_EN') IS NULL
CREATE TABLE [dbo].[U_EDISCFSAXP_drvTbl_EN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvParticiantFileImportID] char(11) NULL,
    [drvPlanName] varchar(18) NOT NULL,
    [drvEnrollmentEffectiveDate] datetime NULL,
    [drvParticipantElectionAmount] nvarchar(4000) NULL,
    [drvEnrollmentTerminationDate] datetime NULL,
    [drvPlanYearStartDate] datetime NULL
);
IF OBJECT_ID('U_EDISCFSAXP_drvTbl_PT') IS NULL
CREATE TABLE [dbo].[U_EDISCFSAXP_drvTbl_PT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvParticiantFileImportID] char(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvHireDate] datetime NULL,
    [drvDivision] varchar(12) NULL,
    [drvPayrollFrequency] varchar(12) NULL,
    [drvParticipantStatus] varchar(10) NOT NULL,
    [drvStatusEffectiveDate] datetime NULL,
    [drvMobileNumber] varchar(50) NULL
);
IF OBJECT_ID('U_EDISCFSAXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISCFSAXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDISCFSAXP_File') IS NULL
CREATE TABLE [dbo].[U_EDISCFSAXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_EDISCFSAXP_Header') IS NULL
CREATE TABLE [dbo].[U_EDISCFSAXP_Header] (
    [drvSubmittedDate] varchar(8) NULL,
    [drvSubmittedTime] varchar(6) NULL
);
IF OBJECT_ID('U_EDISCFSAXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EDISCFSAXP_Trailer] (
    [drvRecordCount] int NULL,
    [drvSubmittedDate] varchar(8) NULL,
    [drvSubmittedTime] varchar(6) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCFSAXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: PlatePlus

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 12/20/2020
Service Request Number: TekP-2020-10-28-0003

Purpose: Discovery FSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISCFSAXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISCFSAXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISCFSAXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISCFSAXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISCFSAXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFSAXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFSAXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFSAXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFSAXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFSAXP', 'SCH_EDISCF';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISCFSAXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISCFSAXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDISCFSAXP';

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
    DELETE FROM dbo.U_EDISCFSAXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISCFSAXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EDISCFSAXP_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('T','Z')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSADC';

    IF OBJECT_ID('U_EDISCFSAXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSAXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDISCFSAXP_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDISCFSAXP_drvTbl_PT
    ---------------------------------
    IF OBJECT_ID('U_EDISCFSAXP_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSAXP_drvTbl_PT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvParticiantFileImportID = EepSSN
        ,drvEmployeeNumber = EecEmpNo
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus IN ('S','M') THEN EepMaritalStatus END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSSN = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvHireDate = EecDateOfLastHire
        ,drvDivision =    CASE EecOrgLvl4
                            WHEN 'ECHI' THEN 'East Chicago'
                            WHEN 'GCITY' THEN 'Granite City'
                            WHEN 'HOUST' THEN 'Houston'
                            WHEN 'LOUDON' THEN 'Loudon'
                            WHEN 'ADMIN' THEN 'Metals Admin'
                            WHEN 'TRDMN' THEN 'Metals Admin'
                            WHEN 'TULSA' THEN 'Tulsa'
                            WHEN 'WIND' THEN'Windsor'
                        END
        ,drvPayrollFrequency =    CASE WHEN PgrPayFrequency = 'S' THEN 'Semi-Monthly'
                                    WHEN PgrPayFrequency = 'W' THEN 'Weekly'
                                END
        ,drvParticipantStatus = CASE WHEN EecEmplStatus = 'T' THEN 'Terminated' ELSE 'Active' END
        ,drvStatusEffectiveDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination ELSE EecDateOfLastHire END
        ,drvMobileNumber = EfoPhoneNumber
    INTO dbo.U_EDISCFSAXP_drvTbl_PT
    FROM dbo.U_EDISCFSAXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCFSAXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY AuditKey DESC) AS RN
                        FROM dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL'
                        ) AS CP
                WHERE RN = 1
            ) AS Cel
        ON EfoEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCFSAXP_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_EDISCFSAXP_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSAXP_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 2'
        -- standard fields above and additional driver fields below
        ,drvParticiantFileImportID = EepSSN
        ,drvPlanName =    CASE WHEN BdmDedCode = 'FSA' THEN 'Medical FSA' ELSE 'Dependent Care FSA' END
        ,drvEnrollmentEffectiveDate =    CASE WHEN DATEPART(YEAR, BdmBenStartDate) <= 2021 THEN dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDate, '1/1/2021')
                                            ELSE dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDate, '1/1/' + FORMAT(DATEPART(YEAR, BdmBenStartDate), '0000'))                                                
                                        END
        ,drvParticipantElectionAmount = FORMAT(BdmEEGoalAmt, '#0.00')
        ,drvEnrollmentTerminationDate = CASE WHEN EecEmplStatus <> 'T' THEN BdmBenStopDate END
        ,drvPlanYearStartDate = dbo.dsi_fnGetMinMaxDates('MAX',  '1/1/' + FORMAT(DATEPART(YEAR, GETDATE()), '000'), '1/1/2021')
    INTO dbo.U_EDISCFSAXP_drvTbl_EN
    FROM dbo.U_EDISCFSAXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EDISCFSAXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    ;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------

    DECLARE @CurrentDate VARCHAR(8)
        ,@CurrentTime VARCHAR(6);

    SELECT @CurrentDate = FORMAT(GETDATE(), 'MMddyyyy');
    SELECT @CurrentTime = FORMAT(GETDATE(), 'HHmmss')


    IF OBJECT_ID('U_EDISCFSAXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSAXP_Header;
    SELECT DISTINCT
         drvSubmittedDate = @CurrentDate
        ,drvSubmittedTime = @CurrentTime
    INTO dbo.U_EDISCFSAXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISCFSAXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSAXP_Trailer;
    SELECT DISTINCT
        drvRecordCount = (SELECT COUNT(*) FROM dbo.U_EDISCFSAXP_drvTbl_PT) + (SELECT COUNT(*) FROM dbo.U_EDISCFSAXP_drvTbl_EN)
        ,drvSubmittedDate = @CurrentDate
        ,drvSubmittedTime = @CurrentTime
    INTO dbo.U_EDISCFSAXP_Trailer
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
ALTER VIEW dbo.dsi_vwEDISCFSAXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCFSAXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISCFSAXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202012131'
       ,expStartPerControl     = '202012131'
       ,expLastEndPerControl   = '202012209'
       ,expEndPerControl       = '202012209'
WHERE expFormatCode = 'EDISCFSAXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDISCFSAXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCFSAXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;