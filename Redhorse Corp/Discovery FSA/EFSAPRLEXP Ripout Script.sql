SET NOCOUNT ON;
IF OBJECT_ID('U_EFSAPRLEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFSAPRLEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFSAPRLEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFSAPRLEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFSAPRLEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFSAPRLEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFSAPRLEXP];
GO
IF OBJECT_ID('U_EFSAPRLEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_Trailer];
GO
IF OBJECT_ID('U_EFSAPRLEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_PEarHist];
GO
IF OBJECT_ID('U_EFSAPRLEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_PDedHist];
GO
IF OBJECT_ID('U_EFSAPRLEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_Header];
GO
IF OBJECT_ID('U_EFSAPRLEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_File];
GO
IF OBJECT_ID('U_EFSAPRLEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_EEList];
GO
IF OBJECT_ID('U_EFSAPRLEXP_drvTbl_PT') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_drvTbl_PT];
GO
IF OBJECT_ID('U_EFSAPRLEXP_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_drvTbl_EN];
GO
IF OBJECT_ID('U_EFSAPRLEXP_drvTbl_CT') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_drvTbl_CT];
GO
IF OBJECT_ID('U_EFSAPRLEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EFSAPRLEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFSAPRLEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFSAPRLEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFSAPRLEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFSAPRLEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFSAPRLEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFSAPRLEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFSAPRLEXP','Discovery FSA Elig and Payroll','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EFSAPRLEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FH"','1','(''DA''=''T|'')','EFSAPRLEXPZ0','50','H','01','1',NULL,'Record Type  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DBI"','2','(''DA''=''T|'')','EFSAPRLEXPZ0','50','H','01','2',NULL,'Administrator Code  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"36093"','3','(''DA''=''T|'')','EFSAPRLEXPZ0','50','H','01','3',NULL,'Employer Code  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','4','(''DA''=''T|'')','EFSAPRLEXPZ0','50','H','01','4',NULL,'Synchronize Flag  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentDate"','5','(''UA''=''T|'')','EFSAPRLEXPZ0','50','H','01','5',NULL,'Submitted Date  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentTime"','6','(''UA''=''T|'')','EFSAPRLEXPZ0','50','H','01','6',NULL,'Submitted Time  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"3.5"','7','(''DA''=''T'')','EFSAPRLEXPZ0','50','H','01','7',NULL,'File Version  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CT"','1','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','10','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFileImportID"','2','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','10','2',NULL,'Participant File Import Id ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','3','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','10','3',NULL,'Plan Name  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribDate"','4','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','10','4',NULL,'Contribution Date  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Deduction"','5','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','10','5',NULL,'Contribution Description  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribAmt"','6','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','10','6',NULL,'Contribution Amount  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmtType"','7','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','10','7',NULL,'Amount Type  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxYear"','8','(''UA''=''T'')','EFSAPRLEXPZ0','50','D','10','8',NULL,'Tax Year  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PT"','1','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSsn"','2','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','2',NULL,'Participant File Import ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','3','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','3',NULL,'Employer Employee ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','4','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','4',NULL,'Employee Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','5',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','6',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMIddleInit"','7','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','7',NULL,'Middle Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','8','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','8',NULL,'Gender ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','9',NULL,'Marital Status ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','10',NULL,'Mothers Maiden Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','11','(''UDMDY''=''T|'')','EFSAPRLEXPZ0','50','D','20','11',NULL,'Date Of Birth ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSsn"','12','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','12',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','13',NULL,'Address Line 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','14',NULL,'Address Line 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','15',NULL,'Address Line 3 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','16',NULL,'Address Line 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','17','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','17',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','18','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','18',NULL,'State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','19','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','19',NULL,'Zip Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"US"','20','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','20',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','21',NULL,'Home Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','22',NULL,'Work Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','23',NULL,'Work Phone Extension ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','24','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','24',NULL,'Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','25',NULL,'Username ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','26',NULL,'Password ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHireDate"','27','(''UDMDY''=''T|'')','EFSAPRLEXPZ0','50','D','20','27',NULL,'Hire Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','28',NULL,'Division ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','29',NULL,'Hours Per Week ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E"','30','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','30',NULL,'Employee Class ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll"','31','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','31',NULL,'Payroll Frequency ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','32',NULL,'Payroll Frequency Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantStatus"','33','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','20','33',NULL,'Participant Status ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusEffDate"','34','(''UDMDY''=''T|'')','EFSAPRLEXPZ0','50','D','20','34',NULL,'Status Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','35',NULL,'Hold Payroll Deductions ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','36',NULL,'Hold Employer Contributions ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','37',NULL,'Incur Services ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFinalPayProcDate"','38','(''UDMDY''=''T|'')','EFSAPRLEXPZ0','50','D','20','38',NULL,'Final Payroll Process Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFinalContProcDate"','39','(''UDMDY''=''T|'')','EFSAPRLEXPZ0','50','D','20','39',NULL,'Final Contribution Process Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','40',NULL,'HSA Custodian ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','41',NULL,'Medicare Beneficiary ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','42',NULL,'Medicare ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','43',NULL,'Exchange ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','44',NULL,'Integration ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','45',NULL,'Reporting Hierarchy Level 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','46',NULL,'Reporting Hierarchy Level 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','47',NULL,'Reporting Hierarchy Level 3 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','48',NULL,'Reporting Hierarchy Level 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','49',NULL,'CDD_Citizenship ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','50',NULL,'CDD_Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','51',NULL,'CDD_Employm entStatus ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','52',NULL,'CDD_Employer ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','53',NULL,'CDD_JobTitle ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','54',NULL,'Class Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','55',NULL,'ID_Identification Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','56',NULL,'ID_Identification Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','57',NULL,'ID_IssuingState ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','58',NULL,'ID_Issuer ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','59',NULL,'ID_IssueDate ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','60',NULL,'ID_ExpirationDa te ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','20','61',NULL,'Mobile Carrier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''T'')','EFSAPRLEXPZ0','50','D','20','62',NULL,'Mobile Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''T'')','EFSAPRLEXPZ0','50','D','20','63',NULL,'Time Zone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EN"','1','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','30','1',NULL,'Record Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSsn"','2','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','30','2',NULL,'Participant File Import Id ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','3','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','30','3',NULL,'Plan Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollEffDate"','4','(''UDMDY''=''T|'')','EFSAPRLEXPZ0','50','D','30','4',NULL,'Enrollment Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartElectAmt"','5','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','30','5',NULL,'Participant Election Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollTermDate"','6','(''UDMDY''=''T|'')','EFSAPRLEXPZ0','50','D','30','6',NULL,'Enrollment Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplContribLvl"','7','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','30','7',NULL,'Employer Contribution Level ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','8','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','30','8',NULL,'Employer Contribution Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','30','9',NULL,'Primary Reimbursement ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','30','10',NULL,'Alternate Reimbursement ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','30','11',NULL,'Enrolled In Claims Exchange ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectAmtInd"','12','(''UA''=''T|'')','EFSAPRLEXPZ0','50','D','30','12',NULL,'Election Amount Indicator ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','30','13',NULL,'HDHP Coverage Level ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYearStartDate"','14','(''UDMDY''=''T|'')','EFSAPRLEXPZ0','50','D','30','14',NULL,'Plan Year Start Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','30','15',NULL,'Terms and Conditions Accepted ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','30','16',NULL,'Date Terms Conditions Accepted ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','30','17',NULL,'Time Terms Conditions Accepted ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T|'')','EFSAPRLEXPZ0','50','D','30','18',NULL,'Change Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T'')','EFSAPRLEXPZ0','50','D','30','19',NULL,'Spend Down ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FF"','1','(''DA''=''T|'')','EFSAPRLEXPZ0','50','T','90','1',NULL,'Record Type  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','2','(''UA''=''T|'')','EFSAPRLEXPZ0','50','T','90','2',NULL,'Record Count ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DBI"','3','(''DA''=''T|'')','EFSAPRLEXPZ0','50','T','90','3',NULL,'Administrator Code  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"36093"','4','(''DA''=''T|'')','EFSAPRLEXPZ0','50','T','90','4',NULL,'Employer Code  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmitDate"','5','(''UDMDY''=''T|'')','EFSAPRLEXPZ0','50','T','90','5',NULL,'Submitted Date  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmitTime"','6','(''UA''=''T'')','EFSAPRLEXPZ0','50','T','90','6',NULL,'Submitted Time  ',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSAPRLEXP_20200519.txt',NULL,'','',NULL,NULL,NULL,NULL,'FSA Payroll Export','202005089','EMPEXPORT','ONDEMAND',NULL,'EFSAPRLEXP',NULL,NULL,NULL,'202005089','Jan  2 2020  8:48AM','Jan  2 2020  8:48AM','202005081',NULL,'','','202005081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSAPRLEXP_20200519.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202005089','EMPEXPORT','SCHEDULED',NULL,'EFSAPRLEXP',NULL,NULL,NULL,'202005089','Jan  2 2020  8:48AM','Jan  2 2020  8:48AM','202005081',NULL,'','','202005081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSAPRLEXP_20200519.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202005089','EMPEXPORT','OEACTIVE',NULL,'EFSAPRLEXP',NULL,NULL,NULL,'202005089','Jan  2 2020  8:48AM','Jan  2 2020  8:48AM','202005081',NULL,'','','202005081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSAPRLEXP_20200519.txt',NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202005089','EMPEXPORT','OEPASSIVE',NULL,'EFSAPRLEXP',NULL,NULL,NULL,'202005089','Jan  2 2020  8:48AM','Jan  2 2020  8:48AM','202005081',NULL,'','','202005081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSAPRLEXP_20200519.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202005089','EMPEXPORT','TEST','Apr 22 2020  5:05PM','EFSAPRLEXP',NULL,NULL,NULL,'202005089','Apr 24 2020 12:00AM','Dec 30 1899 12:00AM','202005081','439','','','202005081',dbo.fn_GetTimedKey(),NULL,'us3lKiRED1015',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EFSAPRLEXP_20200519.txt' END WHERE expFormatCode = 'EFSAPRLEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSAPRLEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSAPRLEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSAPRLEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSAPRLEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSAPRLEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSAPRLEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EFSAPRLEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFSAPRLEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EFSAPRLEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFSAPRLEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFSAPRLEXP','H01','dbo.U_EFSAPRLEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFSAPRLEXP','D10','dbo.U_EFSAPRLEXP_drvTbl_CT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFSAPRLEXP','D20','dbo.U_EFSAPRLEXP_drvTbl_PT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFSAPRLEXP','D30','dbo.U_EFSAPRLEXP_drvTbl_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFSAPRLEXP','T90','dbo.U_EFSAPRLEXP_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EFSAPRLEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFSAPRLEXP] (
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
IF OBJECT_ID('U_EFSAPRLEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_drvTbl_CT') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_drvTbl_CT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPartFileImportID] char(11) NULL,
    [drvPlanName] varchar(19) NULL,
    [drvContribDate] nvarchar(4000) NULL,
    [drvContribAmt] nvarchar(4000) NULL,
    [drvAmtType] varchar(6) NOT NULL,
    [drvTaxYear] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_drvTbl_EN') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_drvTbl_EN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmpSsn] char(11) NULL,
    [drvPlanName] varchar(19) NULL,
    [drvEnrollEffDate] datetime NULL,
    [drvPartElectAmt] nvarchar(4000) NULL,
    [drvEnrollTermDate] varchar(1) NOT NULL,
    [drvEmplContribLvl] varchar(1) NOT NULL,
    [drvElectAmtInd] varchar(8) NULL,
    [drvPlanYearStartDate] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_drvTbl_PT') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_drvTbl_PT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmpSsn] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMIddleInit] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSsn] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvEmpHireDate] datetime NULL,
    [drvParticipantStatus] varchar(10) NOT NULL,
    [drvStatusEffDate] datetime NULL,
    [drvFinalPayProcDate] datetime NULL,
    [drvFinalContProcDate] datetime NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_File') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_Header] (
    [drvCurrentDate] varchar(8) NULL,
    [drvCurrentTime] varchar(6) NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhFsaAmount] numeric NULL,
    [PdhFsaDAmount] numeric NULL,
    [PdhLfsaAmount] numeric NULL,
    [PdhCtranAmount] numeric NULL,
    [PdhCparkAmount] numeric NULL
);
IF OBJECT_ID('U_EFSAPRLEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_PEarHist] (
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
IF OBJECT_ID('U_EFSAPRLEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EFSAPRLEXP_Trailer] (
    [drvRecordCount] int NULL,
    [drvSubmitDate] varchar(8) NULL,
    [drvSubmitTime] varchar(6) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFSAPRLEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Redhorse Corp

Created By: James Bender
Business Analyst: Lea King
Create Date: 01/02/2020
Service Request Number: TekP-2019-10-18-0002

Purpose: FSA Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFSAPRLEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFSAPRLEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFSAPRLEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFSAPRLEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFSAPRLEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFSAPRLEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFSAPRLEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFSAPRLEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFSAPRLEXP', 'TEST';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFSAPRLEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFSAPRLEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFSAPRLEXP';

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
    DELETE FROM dbo.U_EFSAPRLEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFSAPRLEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EFSAPRLEXP_EEList where xEEID IN (
        select distinct eeceeid from empcomp where eecEEType IN('TES')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSAD,LFSA,CTRAN,CPARK';

    IF OBJECT_ID('U_EFSAPRLEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFSAPRLEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',DATEADD(DAY, -30, @EndDate));
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
    IF OBJECT_ID('U_EFSAPRLEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhFsaAmount     = SUM(CASE WHEN PdhDedCode IN ('FSA') THEN PdhEECurAmt ELSE 0.00 END) -- JCB
        ,PdhFsaDAmount     = SUM(CASE WHEN PdhDedCode IN ('FSAD') THEN PdhEECurAmt ELSE 0.00 END) -- JCB
        ,PdhLfsaAmount     = SUM(CASE WHEN PdhDedCode IN ('LFSA') THEN PdhEECurAmt ELSE 0.00 END) -- JCB
        ,PdhCtranAmount     = SUM(CASE WHEN PdhDedCode IN ('CTRAN') THEN PdhEECurAmt ELSE 0.00 END) -- JCB
        ,PdhCparkAmount     = SUM(CASE WHEN PdhDedCode IN ('CPARK') THEN PdhEECurAmt ELSE 0.00 END) -- JCB
    INTO dbo.U_EFSAPRLEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFSAPRLEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EFSAPRLEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_PEarHist;
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
    INTO dbo.U_EFSAPRLEXP_PEarHist
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
    -- DETAIL RECORD - U_EFSAPRLEXP_drvTbl_CT
    ---------------------------------
    IF OBJECT_ID('U_EFSAPRLEXP_drvTbl_CT','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_drvTbl_CT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvPartFileImportID = EepSSN
        ,drvPlanName = CASE BdmDedCode
                            WHEN 'FSA' THEN 'Medical FSA'
                            WHEN 'FSAD' THEN 'Dependent Care FSA'
                            WHEN 'LFSA' THEN 'Limited Medical FSA'
                            WHEN 'CTRAN' THEN 'Mass Transit'
                            WHEN 'CPARK' THEN 'Parking'
                        END
        ,drvContribDate = FORMAT(PrgPayDate, 'MMddyyyy')
        ,drvContribAmt =    CASE BdmDedCode
                                WHEN 'FSA' THEN FORMAT(PdhFsaAmount, '#0.00')
                                WHEN 'FSAD' THEN FORMAT(PdhFsadAmount, '#0.00')
                                WHEN 'LFSA' THEN FORMAT(PdhLfsaAmount, '#0.00')
                                WHEN 'CTRAN' THEN FORMAT(PdhCtranAmount, '#0.00')
                                WHEN 'CPARK' THEN FORMAT(PdhCparkAmount, '#0.00')
                            END
        ,drvAmtType = 'Actual'
        ,drvTaxYear = '' -- FORMAT(GETDATE(), 'yyyy')
    INTO dbo.U_EFSAPRLEXP_drvTbl_CT
    FROM dbo.U_EFSAPRLEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EFSAPRLEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EFSAPRLEXP_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.U_EFSAPRLEXP_PDedHist WITH (NOLOCK) -- JCB
        ON PdhEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFSAPRLEXP_drvTbl_PT
    ---------------------------------
    IF OBJECT_ID('U_EFSAPRLEXP_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_drvTbl_PT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmpSsn = eepSSN
        ,drvEmpNo = EecEmpNo
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMIddleInit = LEFT(EepNameMiddle,1)
        ,drvGender = EepGender
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSsn = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressEmail = EepAddressEMail
        ,drvEmpHireDate = EecDateOfLastHire
        ,drvParticipantStatus = CASE WHEN EecEmplStatus = 'T' THEN 'Terminated' ELSE 'Active' END
        ,drvStatusEffDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination ELSE EecDateOfLastHire END
        ,drvFinalPayProcDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(day, 30, EecDateOfTermination) END
        ,drvFinalContProcDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(day, 30, EecDateOfTermination) END
    INTO dbo.U_EFSAPRLEXP_drvTbl_PT
    FROM dbo.U_EFSAPRLEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFSAPRLEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFSAPRLEXP_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_EFSAPRLEXP_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmpSsn = eepSSN
        ,drvPlanName =    CASE BdmDedCode
                            WHEN 'FSA' THEN 'Medical FSA'
                            WHEN 'FSAD' THEN 'Dependent Care FSA'
                            WHEN 'LFSA' THEN 'Limited Medical FSA'
                            WHEN 'CTRAN' THEN 'Mass Transit'
                            WHEN 'CPARK' THEN 'Parking'
                        END
        ,drvEnrollEffDate = CASE WHEN BdmDedCode in ('FSA', 'FSAD', 'LFSA', 'CTRAN', 'CPARK') THEN BdmBenStartDate END
        ,drvPartElectAmt =    CASE WHEN BdmDedCode in ('FSA', 'FSAD', 'LFSA') THEN FORMAT(BdmEEGoalAmt, '#0.00')
                                WHEN BdmDedCode IN ('CTRAN', 'CPARK') THEN FORMAT(BdmEEAmt*2, '#0.00')
                            END
        ,drvEnrollTermDate = '' --CASE WHEN EecEmplStatus <> 'T' AND BdmDedCode IN ('FSA', 'FSAD', 'LFSA', 'CTRAN', 'CPARK') THEN BdmBenStartDate END
        ,drvEmplContribLvl = ''
        ,drvElectAmtInd = CASE WHEN BdmDedCode IN ('CTRAN', 'CPARK') THEN 'PerMonth' END
        ,drvPlanYearStartDate = '' --'0101' + CAST(YEAR(GETDATE()) AS VARCHAR) 
    INTO dbo.U_EFSAPRLEXP_drvTbl_EN
    FROM dbo.U_EFSAPRLEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFSAPRLEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    DECLARE @CurrentDate VARCHAR(8)
        ,@CurrentTime VARCHAR(6);

    SELECT @CurrentDate = FORMAT(GETDATE(), 'MMddyyyy');
    SELECT @CurrentTime = FORMAT(GETDATE(), 'hhmmss')
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EFSAPRLEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_Header;
    SELECT DISTINCT
         drvCurrentDate = @CurrentDate
        ,drvCurrentTime = @CurrentTime
    INTO dbo.U_EFSAPRLEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EFSAPRLEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EFSAPRLEXP_Trailer;
    SELECT DISTINCT -- ABC
         drvRecordCount = (SELECT COUNT(*) FROM dbo.U_EFSAPRLEXP_drvTbl_EN) + (SELECT COUNT(*) FROM dbo.U_EFSAPRLEXP_drvTbl_PT) + (SELECT COUNT(*) FROM dbo.U_EFSAPRLEXP_drvTbl_CT)
        ,drvSubmitDate = @CurrentDate
        ,drvSubmitTime = @CurrentTime
    INTO dbo.U_EFSAPRLEXP_Trailer
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
ALTER VIEW dbo.dsi_vwEFSAPRLEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFSAPRLEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFSAPRLEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005081'
       ,expStartPerControl     = '202005081'
       ,expLastEndPerControl   = '202005089'
       ,expEndPerControl       = '202005089'
WHERE expFormatCode = 'EFSAPRLEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFSAPRLEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFSAPRLEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort 