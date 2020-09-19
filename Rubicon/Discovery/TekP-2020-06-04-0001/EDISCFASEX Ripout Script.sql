SET NOCOUNT ON;
IF OBJECT_ID('U_EDISCFASEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDISCFASEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDISCFASEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDISCFASEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISCFASEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISCFASEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCFASEX];
GO
IF OBJECT_ID('U_EDISCFASEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_Trailer];
GO
IF OBJECT_ID('U_EDISCFASEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_PEarHist];
GO
IF OBJECT_ID('U_EDISCFASEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_PDedHist];
GO
IF OBJECT_ID('U_EDISCFASEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_Header];
GO
IF OBJECT_ID('U_EDISCFASEX_File') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_File];
GO
IF OBJECT_ID('U_EDISCFASEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_EEList];
GO
IF OBJECT_ID('U_EDISCFASEX_drvTbl_PT') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_drvTbl_PT];
GO
IF OBJECT_ID('U_EDISCFASEX_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_drvTbl_EN];
GO
IF OBJECT_ID('U_EDISCFASEX_drvTbl_CT') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_drvTbl_CT];
GO
IF OBJECT_ID('U_EDISCFASEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_DedList];
GO
IF OBJECT_ID('U_EDISCFASEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_AuditFields];
GO
IF OBJECT_ID('U_EDISCFASEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EDISCFASEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCFASEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISCFASEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISCFASEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISCFASEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISCFASEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISCFASEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCFASEX','Discovery FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EDISCFASEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FH"','1','(''DA''=''T|'')','EDISCFASEXZ0','50','H','01','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DBI"','2','(''DA''=''T|'')','EDISCFASEXZ0','50','H','01','2',NULL,'Administrator Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"38130"','3','(''DA''=''T|'')','EDISCFASEXZ0','50','H','01','3',NULL,'Employer Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','4','(''DA''=''T|'')','EDISCFASEXZ0','50','H','01','4',NULL,'Synchronize Flag ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittedDate"','5','(''UDMDY''=''T|'')','EDISCFASEXZ0','50','H','01','5',NULL,'Submitted Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittedTime"','6','(''UA''=''T|'')','EDISCFASEXZ0','50','H','01','6',NULL,'Submitted Time ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"3.5"','7','(''DA''=''T'')','EDISCFASEXZ0','50','H','01','7',NULL,'File Version ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PT"','1','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFileImpID"','2','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','2',NULL,'Participant File Import ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','3',NULL,'Employer Employee ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNo"','4','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','4',NULL,'Employee Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','5',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','6',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','7',NULL,'Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','8','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','8',NULL,'Gender ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','9','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','9',NULL,'Marital Status ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','10',NULL,'Mothers Maiden Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','11','(''UDMDY''=''T|'')','EDISCFASEXZ0','50','D','10','11',NULL,'Date Of Birth ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','12','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','12',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','13',NULL,'Address Line 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','14',NULL,'Address Line 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','15',NULL,'Address Line 3 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','16',NULL,'Address Line 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','17','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','17',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','18','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','18',NULL,'State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressPostalCode"','19','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','19',NULL,'Zip Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','20',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','21','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','21',NULL,'Home Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','22',NULL,'Work Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','23',NULL,'Work Phone Extension ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','24','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','24',NULL,'Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','25',NULL,'Username ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','26',NULL,'Password ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','27','(''UDMDY''=''T|'')','EDISCFASEXZ0','50','D','10','27',NULL,'Hire Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','28',NULL,'Division ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','29',NULL,'Hours Per Week ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E"','30','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','30',NULL,'Employee Class ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Bi-Weekly 26"','31','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','31',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFreqEffDate"','32','(''UDMDY''=''T|'')','EDISCFASEXZ0','50','D','10','32',NULL,'Payroll Frequency Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantStatus"','33','(''UA''=''T|'')','EDISCFASEXZ0','50','D','10','33',NULL,'Participant Status ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusEffectiveDate"','34','(''UDMDY''=''T|'')','EDISCFASEXZ0','50','D','10','34',NULL,'Status Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','35',NULL,'Hold Payroll Deductions ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','36',NULL,'Hold Employer Contributions ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','37',NULL,'Incur Services ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFinallPayProcDate"','38','(''UDMDY''=''T|'')','EDISCFASEXZ0','50','D','10','38',NULL,'Final Payroll Process Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFinalContribProcDate"','39','(''UDMDY''=''T|'')','EDISCFASEXZ0','50','D','10','39',NULL,'Final Contribution Process Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','40',NULL,'HSA Custodian ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','41',NULL,'Medicare Beneficiary ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','42',NULL,'Medicare ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','43',NULL,'Exchange Integration ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','44',NULL,'Reporting Hierarchy Level 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','45',NULL,'Reporting Hierarchy Level 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','46',NULL,'Reporting Hierarchy Level 3 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','47',NULL,'Reporting Hierarchy Level 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','48',NULL,'CDD_Citizenship ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','49',NULL,'CDD_Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','50',NULL,'CDD_Employm entStatus ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','51',NULL,'CDD_Employer ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','52',NULL,'CDD_JobTitle ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','53',NULL,'Class Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','54',NULL,'ID_Identification Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','55',NULL,'ID_Identification Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','56',NULL,'ID_IssuingState ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','57',NULL,'ID_Issuer ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','58',NULL,'ID_IssueDate ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','59',NULL,'ID_ExpirationDa te ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','60',NULL,'Mobile Carrier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''T|'')','EDISCFASEXZ0','50','D','10','61',NULL,'Mobile Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''T'')','EDISCFASEXZ0','50','D','10','62',NULL,'Time Zone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EN"','1','(''DA''=''T|'')','EDISCFASEXZ0','50','D','20','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFileImpID"','2','(''UA''=''T|'')','EDISCFASEXZ0','50','D','20','2',NULL,'Participant File Import Id ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','3','(''UA''=''T|'')','EDISCFASEXZ0','50','D','20','3',NULL,'Plan Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentEffDate"','4','(''UDMDY''=''T|'')','EDISCFASEXZ0','50','D','20','4',NULL,'Enrollment Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantEleAmt"','5','(''UA''=''T|'')','EDISCFASEXZ0','50','D','20','5',NULL,'Participant Election Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentTermDate"','6','(''UDMDY''=''T|'')','EDISCFASEXZ0','50','D','20','6',NULL,'Enrollment Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''T|'')','EDISCFASEXZ0','50','D','20','7',NULL,'Employer Contribution Level ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T|'')','EDISCFASEXZ0','50','D','20','8',NULL,'Employer Contribution Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T|'')','EDISCFASEXZ0','50','D','20','9',NULL,'Primary Reimbursement ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T|'')','EDISCFASEXZ0','50','D','20','10',NULL,'Alternate Reimbursement ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T|'')','EDISCFASEXZ0','50','D','20','11',NULL,'Enrolled In Claims Exchange ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T|'')','EDISCFASEXZ0','50','D','20','12',NULL,'Election Amount Indicator ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T|'')','EDISCFASEXZ0','50','D','20','13',NULL,'HDHP Coverage Level ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYearStartDate"','14','(''UDMDY''=''T|'')','EDISCFASEXZ0','50','D','20','14',NULL,'Plan Year Start Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T|'')','EDISCFASEXZ0','50','D','20','15',NULL,'Terms and Conditions Accepted ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T|'')','EDISCFASEXZ0','50','D','20','16',NULL,'Date Terms Conditions Accepted ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T|'')','EDISCFASEXZ0','50','D','20','17',NULL,'Time Terms Conditions Accepted ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T|'')','EDISCFASEXZ0','50','D','20','18',NULL,'Change Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T'')','EDISCFASEXZ0','50','D','20','19',NULL,'Spend Down ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CT"','1','(''DA''=''T|'')','EDISCFASEXZ0','50','D','30','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFileImpID"','2','(''UA''=''T|'')','EDISCFASEXZ0','50','D','30','2',NULL,'Participant File Import Id ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','3','(''UA''=''T|'')','EDISCFASEXZ0','50','D','30','3',NULL,'Plan Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionDate"','4','(''UDMDY''=''T|'')','EDISCFASEXZ0','50','D','30','4',NULL,'Contribution Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Deduction"','5','(''DA''=''T|'')','EDISCFASEXZ0','50','D','30','5',NULL,'Contribution Description ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','6','(''UA''=''T|'')','EDISCFASEXZ0','50','D','30','6',NULL,'Contribution Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Actual"','7','(''DA''=''T|'')','EDISCFASEXZ0','50','D','30','7',NULL,'Amount Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current"','8','(''DA''=''T'')','EDISCFASEXZ0','50','D','30','8',NULL,'Tax Year ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FF"','1','(''DA''=''T|'')','EDISCFASEXZ0','50','T','90','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','2','(''UA''=''T|'')','EDISCFASEXZ0','50','T','90','2',NULL,'Record Count ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DBI"','3','(''DA''=''T|'')','EDISCFASEXZ0','50','T','90','3',NULL,'Administrator Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"38130"','4','(''DA''=''T|'')','EDISCFASEXZ0','50','T','90','4',NULL,'Employer Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittedDate"','5','(''UDMDY''=''T|'')','EDISCFASEXZ0','50','T','90','5',NULL,'Submitted Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittedTime"','6','(''UA''=''T|'')','EDISCFASEXZ0','50','T','90','6',NULL,'Submitted Time ',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCFASEX_20200919.txt',NULL,'','',NULL,NULL,NULL,NULL,'Discovery FSA Export','202009119','EMPEXPORT','ONDEMAND',NULL,'EDISCFASEX',NULL,NULL,NULL,'202009119','Jul 15 2020  5:16PM','Jul 15 2020  5:16PM','202009111',NULL,'','','202009111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCFASEX_20200919.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202009119','EMPEXPORT','SCHEDULED',NULL,'EDISCFASEX',NULL,NULL,NULL,'202009119','Jul 15 2020  5:16PM','Jul 15 2020  5:16PM','202009111',NULL,'','','202009111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCFASEX_20200919.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202009119','EMPEXPORT','OEACTIVE',NULL,'EDISCFASEX',NULL,NULL,NULL,'202009119','Jul 15 2020  5:16PM','Jul 15 2020  5:16PM','202009111',NULL,'','','202009111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCFASEX_20200919.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202009119','EMPEXPORT','OEPASSIVE',NULL,'EDISCFASEX',NULL,NULL,NULL,'202009119','Jul 15 2020  5:16PM','Jul 15 2020  5:16PM','202009111',NULL,'','','202009111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISCFASEX_20200919.txt',NULL,'','','R8G17',NULL,NULL,NULL,'Test Purposes Only','202007249','EMPEXPORT','TEST','Sep 18 2020  7:31PM','EDISCFASEX',NULL,NULL,NULL,'202007249','Jul 24 2020 12:00AM','Dec 30 1899 12:00AM','202007011','234','','','202007011',dbo.fn_GetTimedKey(),NULL,'us3cPeTER1003',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EDISCFASEX_20200919.txt' END WHERE expFormatCode = 'EDISCFASEX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFASEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFASEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFASEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFASEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFASEX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EDISCFASEX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISCFASEX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EDISCFASEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCFASEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFASEX','H01','dbo.U_EDISCFASEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFASEX','D10','dbo.U_EDISCFASEX_drvTbl_PT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFASEX','D20','dbo.U_EDISCFASEX_drvTbl_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFASEX','D30','dbo.U_EDISCFASEX_drvTbl_CT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFASEX','T90','dbo.U_EDISCFASEX_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EDISCFASEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISCFASEX] (
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
IF OBJECT_ID('U_EDISCFASEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EDISCFASEX_Audit] (
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
IF OBJECT_ID('U_EDISCFASEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EDISCFASEX_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EDISCFASEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EDISCFASEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDISCFASEX_drvTbl_CT') IS NULL
CREATE TABLE [dbo].[U_EDISCFASEX_drvTbl_CT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPartFileImpID] char(11) NULL,
    [drvPlanName] varchar(18) NULL,
    [drvContributionDate] datetime NULL,
    [drvContributionAmount] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EDISCFASEX_drvTbl_EN') IS NULL
CREATE TABLE [dbo].[U_EDISCFASEX_drvTbl_EN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPartFileImpID] char(11) NULL,
    [drvPlanName] varchar(18) NULL,
    [drvEnrollmentEffDate] datetime NULL,
    [drvParticipantEleAmt] nvarchar(4000) NULL,
    [drvEnrollmentTermDate] datetime NULL,
    [drvPlanYearStartDate] varchar(36) NULL
);
IF OBJECT_ID('U_EDISCFASEX_drvTbl_PT') IS NULL
CREATE TABLE [dbo].[U_EDISCFASEX_drvTbl_PT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPartFileImpID] char(11) NULL,
    [drvEmployeeNo] char(9) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressPostalCode] varchar(50) NULL,
    [drvHomePhone] varchar(10) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvHireDate] datetime NULL,
    [drvPayrollFreqEffDate] varchar(1) NOT NULL,
    [drvParticipantStatus] varchar(10) NOT NULL,
    [drvStatusEffectiveDate] datetime NULL,
    [drvFinallPayProcDate] datetime NULL,
    [drvFinalContribProcDate] datetime NULL
);
IF OBJECT_ID('U_EDISCFASEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISCFASEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDISCFASEX_File') IS NULL
CREATE TABLE [dbo].[U_EDISCFASEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_EDISCFASEX_Header') IS NULL
CREATE TABLE [dbo].[U_EDISCFASEX_Header] (
    [drvSubmittedDate] datetime NULL,
    [drvSubmittedTime] varchar(6) NULL
);
IF OBJECT_ID('U_EDISCFASEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDISCFASEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhContribAmt53MFS] numeric NULL,
    [PdhContribAmt53DCF] numeric NULL
);
IF OBJECT_ID('U_EDISCFASEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDISCFASEX_PEarHist] (
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
IF OBJECT_ID('U_EDISCFASEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_EDISCFASEX_Trailer] (
    [drvRecordCount] nvarchar(4000) NULL,
    [drvSubmittedDate] datetime NULL,
    [drvSubmittedTime] varchar(6) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCFASEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Rubicon Oilfield

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 07/15/2020
Service Request Number: TekP-2020-06-04-0001

Purpose: Discovery FSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISCFASEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISCFASEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISCFASEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISCFASEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISCFASEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFASEX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFASEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFASEX', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISCFASEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISCFASEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDISCFASEX';

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
    DELETE FROM dbo.U_EDISCFASEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISCFASEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EDISCFASEX_EEList where xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    )


    DELETE FROM dbo.U_EDISCFASEX_EEList where xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecPayGroup NOT IN ('USBW')
    )



    --==========================================
    -- Create audit tables
    --==========================================
    IF OBJECT_ID('U_EDISCFASEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFASEX_AuditFields;
    CREATE TABLE dbo.U_EDISCFASEX_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EDISCFASEX_AuditFields VALUES ('EmpComp','EecPayGroup');   
    
    -- Create audit table
    IF OBJECT_ID('U_EDISCFASEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFASEX_Audit;
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
    INTO dbo.U_EDISCFASEX_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EDISCFASEX_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EDISCFASEX_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EDISCFASEX_Audit ON dbo.U_EDISCFASEX_Audit (audKey1Value, audKey2Value);



    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '53MFS,53DCF';

    IF OBJECT_ID('U_EDISCFASEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFASEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDISCFASEX_DedList
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
    IF OBJECT_ID('U_EDISCFASEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFASEX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhContribAmt53MFS     = SUM(CASE WHEN PdhDedCode IN ('53MFS') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhContribAmt53DCF     = SUM(CASE WHEN PdhDedCode IN ('53DCF') THEN PdhEECurAmt ELSE 0.00 END)
        /*,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)*/
    INTO dbo.U_EDISCFASEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EDISCFASEX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EDISCFASEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFASEX_PEarHist;
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
    INTO dbo.U_EDISCFASEX_PEarHist
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
    -- DETAIL RECORD - U_EDISCFASEX_drvTbl_PT
    ---------------------------------
    IF OBJECT_ID('U_EDISCFASEX_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFASEX_drvTbl_PT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvPartFileImpID = EepSSN
        ,drvEmployeeNo = EecEmpNo
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvGender = EepGender
        ,drvMaritalStatus =    CASE WHEN eepMaritalStatus = 'M' THEN 'M'
                                WHEN eepMaritalStatus = 'S' THEN 'S'
                            END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSSN = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressPostalCode = EepAddressZipCode
        ,drvHomePhone = ''
        ,drvAddressEmail = EepAddressEMail
        ,drvHireDate = EecDateOfOriginalHire
        ,drvPayrollFreqEffDate = '' -- pgrPayFrequency
        ,drvParticipantStatus = CASE WHEN EecEmplStatus = 'T' THEN 'Terminated' ELSE 'Active' END
        ,drvStatusEffectiveDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination ELSE EecDateOfLastHire END
        ,drvFinallPayProcDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination) END
        ,drvFinalContribProcDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination) END
    INTO dbo.U_EDISCFASEX_drvTbl_PT
    FROM dbo.U_EDISCFASEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCFASEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCFASEX_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_EDISCFASEX_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFASEX_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 2'
        -- standard fields above and additional driver fields below
        ,drvPartFileImpID = EepSSN
        ,drvPlanName =    CASE WHEN BdmDedCode IN ('53MFS') THEN 'Medical FSA'
                            WHEN BdmDedCode IN ('53DCF') THEN 'Dependent Care FSA'
                        END
        ,drvEnrollmentEffDate = CASE WHEN BdmDedCode IN ('53MFS','53DCF') THEN BdmBenStartDate END
        ,drvParticipantEleAmt = CASE WHEN BdmDedCode IN ('53MFS','53DCF') THEN FORMAT(BdmEEGoalAmt, '#0.00') END
        ,drvEnrollmentTermDate = CASE WHEN EecEmplStatus <> 'T' AND BdmDedCode IN ('53MFS','53DCF') THEN BdmBenStopDate END
        ,drvPlanYearStartDate = CASE WHEN GETDATE() < '1/1/2021' THEN '03012020' ELSE  '01/01/' + CAST(YEAR(GETDATE()) AS VARCHAR) END
    INTO dbo.U_EDISCFASEX_drvTbl_EN
    FROM dbo.U_EDISCFASEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EDISCFASEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCFASEX_drvTbl_CT
    ---------------------------------
    IF OBJECT_ID('U_EDISCFASEX_drvTbl_CT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFASEX_drvTbl_CT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 3'
        -- standard fields above and additional driver fields below
        ,drvPartFileImpID = EepSSN
        ,drvPlanName =    CASE WHEN BdmDedCode IN ('53MFS') THEN 'Medical FSA'
                            WHEN BdmDedCode IN ('53DCF') THEN 'Dependent Care FSA'
                        END
        ,drvContributionDate = PgpPayDate
        ,drvContributionAmount =    CASE WHEN BdmDedCode IN ('53MFS') THEN FORMAT(PdhContribAmt53MFS, '#0.00')
                                        WHEN BdmDedCode IN ('53DCF') THEN FORMAT(PdhContribAmt53DCF, '#0.00')
                                    END
        --FORMAT(PdhContribAmt, '#0.00')
    INTO dbo.U_EDISCFASEX_drvTbl_CT
    FROM dbo.U_EDISCFASEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EDISCFASEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    --JOIN dbo.PayGroup WITH (NOLOCK)
    --    ON  EecPayGroup = PgrPayGroup
    JOIN (
            SELECT PgpPayDate, PgpPayGroup
            FROM dbo.PgPayPer WITH (NOLOCK)
            WHERE PgpPayDate BETWEEN @StartDate AND @EndDate
                AND RIGHT(PgpPeriodControl, 1) = '1') as PayGroupInfo
        ON EecPayGroup = pgpPayGroup
    JOIN dbo.U_EDISCFASEX_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    ;

    DECLARE @RunDate DATETIME, @RunTime VARCHAR(6), @PtCount INT, @EnCount INT, @CtCount INT;
    SELECT @RunDate = GETDATE()
        ,@RunTime = REPLACE(CONVERT(VARCHAR, GETDATE(), 108),':',SPACE(0))
        ,@PtCount = (SELECT COUNT(*) FROM dbo.U_EDISCFASEX_drvTbl_PT WITH (NOLOCK))
        ,@EnCount = (SELECT COUNT(*) FROM dbo.U_EDISCFASEX_drvTbl_EN WITH (NOLOCK))
        ,@CtCount = (SELECT COUNT(*) FROM dbo.U_EDISCFASEX_drvTbl_CT WITH (NOLOCK))
        ;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISCFASEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFASEX_Header;
    SELECT DISTINCT
         drvSubmittedDate = @RunDate
        ,drvSubmittedTime = @RunTime
    INTO dbo.U_EDISCFASEX_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISCFASEX_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFASEX_Trailer;
    SELECT DISTINCT
         drvRecordCount = FORMAT(@PtCount + @EnCount + @CtCount, '#')
        ,drvSubmittedDate = @RunDate
        ,drvSubmittedTime = @RunTime
    INTO dbo.U_EDISCFASEX_Trailer
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
ALTER VIEW dbo.dsi_vwEDISCFASEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCFASEX_File (NOLOCK)
    ORDER BY /*RIGHT(RecordSet,2),*/ InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISCFASEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007171'
       ,expStartPerControl     = '202007171'
       ,expLastEndPerControl   = '202007179'
       ,expEndPerControl       = '202007179'
WHERE expFormatCode = 'EDISCFASEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDISCFASEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCFASEX_File (NOLOCK)
    ORDER BY /*RIGHT(RecordSet,2),*/ InitialSort, SubSort;