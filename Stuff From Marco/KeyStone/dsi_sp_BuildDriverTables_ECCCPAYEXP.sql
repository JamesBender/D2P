SET NOCOUNT ON;
IF OBJECT_ID('U_ECCCPAYEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECCCPAYEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECCCPAYEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECCCPAYEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECCCPAYEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECCCPAYEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECCCPAYEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECCCPAYEXP];
GO
IF OBJECT_ID('U_ECCCPAYEXP_PEarHist_TEST') IS NOT NULL DROP TABLE [dbo].[U_ECCCPAYEXP_PEarHist_TEST];
GO
IF OBJECT_ID('U_ECCCPAYEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECCCPAYEXP_PEarHist];
GO
IF OBJECT_ID('U_ECCCPAYEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECCCPAYEXP_File];
GO
IF OBJECT_ID('U_ECCCPAYEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECCCPAYEXP_EEList];
GO
IF OBJECT_ID('U_ECCCPAYEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECCCPAYEXP_drvTbl];
GO
IF OBJECT_ID('U_ECCCPAYEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECCCPAYEXP_AuditFields];
GO
IF OBJECT_ID('U_ECCCPAYEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECCCPAYEXP_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECCCPAYEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECCCPAYEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECCCPAYEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECCCPAYEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECCCPAYEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECCCPAYEXP','CCC Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ECCCPAYEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECCCPAYEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Company Identifier"','1','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','1',NULL,'Company Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','2','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','3','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','3',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','4','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SUI"','5','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','5',NULL,'SUI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FEIN"','6','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','6',NULL,'FEIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location"','7','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','7',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','8','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','8',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Initial"','9','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','9',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','10','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','10',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Hire Date"','11','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','11',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Most Recent Hire Date"','12','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','12',NULL,'Most Recent Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Start Date"','13','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','13',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','14','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','14',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Title"','15','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','15',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Status"','16','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','16',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Type"','17','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','17',NULL,'Employee Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rate of Pay"','18','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','18',NULL,'Rate of Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rate of Pay Type"','19','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','19',NULL,'Rate of Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Home Phone"','20','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','20',NULL,'Employee Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Cell Phone"','21','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','21',NULL,'Employee Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Residence Address 1"','22','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','22',NULL,'Residence Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Residence Address 2"','23','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','23',NULL,'Residence Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Residence City"','24','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','24',NULL,'Residence City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Residence State"','25','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','25',NULL,'Residence State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Residence ZIP"','26','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','26',NULL,'Residence ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee email"','27','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','27',NULL,'Employee email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','28','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','28',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reason Code"','29','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','29',NULL,'Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Comments"','30','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','30',NULL,'Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Eligible for Rehire"','31','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','31',NULL,'Eligible for Rehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Start Date"','32','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','32',NULL,'Pay Period Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Ending Date"','33','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','33',NULL,'Pay Period Ending Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Check Date"','34','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','34',NULL,'Check Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Paid - by type"','35','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','35',NULL,'Hours Paid - by type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gross Wages - by type"','36','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','36',NULL,'Gross Wages - by type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Frequency"','37','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','37',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Type"','38','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','38',NULL,'Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee YTD Earnings"','39','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','39',NULL,'Employee YTD Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee YTD Hours"','40','(''DA''=''Q'')','ECCCPAYEXPZ0','50','H','01','40',NULL,'Employee YTD Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyIdentifier"','1','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','1',NULL,'Company Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','3','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','3',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','4','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSUI"','5','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','5',NULL,'SUI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFEIN"','6','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','6',NULL,'FEIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','7','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','7',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','8','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','8',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','9','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','9',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','10','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','10',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalHireDate"','11','(''UD112''=''Q|'')','ECCCPAYEXPZ0','50','D','10','11',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMostRecentHireDate"','12','(''UD112''=''Q|'')','ECCCPAYEXPZ0','50','D','10','12',NULL,'Most Recent Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','13','(''UD112''=''Q|'')','ECCCPAYEXPZ0','50','D','10','13',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','14','(''UD112''=''Q|'')','ECCCPAYEXPZ0','50','D','10','14',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','15','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','15',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','16','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','16',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','17','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','17',NULL,'Employee Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRateofPay"','18','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','18',NULL,'Rate of Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRateofPayType"','19','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','19',NULL,'Rate of Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeHomePhone"','20','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','20',NULL,'Employee Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeCellPhone"','21','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','21',NULL,'Employee Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResidenceAddress1"','22','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','22',NULL,'Residence Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResidenceAddress2"','23','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','23',NULL,'Residence Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResidenceCity"','24','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','24',NULL,'Residence City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResidenceState"','25','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','25',NULL,'Residence State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResidenceZIP"','26','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','26',NULL,'Residence ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeemail"','27','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','27',NULL,'Employee email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','28','(''UD112''=''Q|'')','ECCCPAYEXPZ0','50','D','10','28',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReasonCode"','29','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','29',NULL,'Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvComments"','30','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','30',NULL,'Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibleforRehire"','31','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','31',NULL,'Eligible for Rehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodStartDate"','32','(''UD112''=''Q|'')','ECCCPAYEXPZ0','50','D','10','32',NULL,'Pay Period Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodEndingDate"','33','(''UD112''=''Q|'')','ECCCPAYEXPZ0','50','D','10','33',NULL,'Pay Period Ending Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','34','(''UD112''=''Q|'')','ECCCPAYEXPZ0','50','D','10','34',NULL,'Check Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursPaidbytype"','35','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','35',NULL,'Hours Paid - by type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrossWagesbytype"','36','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','36',NULL,'Gross Wages - by type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','37','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','37',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayType"','38','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','38',NULL,'Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeYTDEarnings"','39','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','39',NULL,'Employee YTD Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeYTDHours"','40','(''UA''=''Q'')','ECCCPAYEXPZ0','50','D','10','40',NULL,'Employee YTD Hours',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECCCPAYEXP_20210401.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'CCC Payroll Export','202005229','EMPEXPORT','ONDEMAND','Aug 18 2020 12:14PM','ECCCPAYEXP',NULL,NULL,NULL,'202005229','May 22 2020  1:36PM','May 22 2020  1:36PM','202005221','1163','','','202005221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202005229','EMPEXPORT','SCH_CCCP',NULL,'ECCCPAYEXP',NULL,NULL,NULL,'202005229','May 22 2020  1:36PM','May 22 2020  1:36PM','202005221',NULL,'','','202005221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','EXQ49',NULL,NULL,NULL,'Test Purposes Only','202008139','EMPEXPORT','TEST','Aug 18 2020 12:34PM','ECCCPAYEXP',NULL,NULL,NULL,'202008139','Aug 13 2020 12:00AM','Dec 30 1899 12:00AM','201901011','37622','','','201901011',dbo.fn_GetTimedKey(),NULL,'us3mLaKEY1004',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCCPAYEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCCPAYEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCCPAYEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCCPAYEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCCPAYEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCCPAYEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECCCPAYEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECCCPAYEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECCCPAYEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECCCPAYEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECCCPAYEXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECCCPAYEXP','D10','dbo.U_ECCCPAYEXP_drvTbl',NULL);
IF OBJECT_ID('U_ECCCPAYEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ECCCPAYEXP_Audit] (
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
IF OBJECT_ID('U_ECCCPAYEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECCCPAYEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ECCCPAYEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECCCPAYEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCompanyIdentifier] varchar(5) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvState] varchar(255) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvSUI] varchar(8) NOT NULL,
    [drvFEIN] char(9) NULL,
    [drvLocation] char(6) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvMostRecentHireDate] datetime NULL,
    [drvStartDate] datetime NULL,
    [drvDateofBirth] datetime NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvEmployeeStatus] varchar(1) NULL,
    [drvEmployeeType] char(1) NULL,
    [drvRateofPay] varchar(24) NULL,
    [drvRateofPayType] varchar(1) NOT NULL,
    [drvEmployeeHomePhone] varchar(50) NULL,
    [drvEmployeeCellPhone] varchar(50) NULL,
    [drvResidenceAddress1] varchar(255) NULL,
    [drvResidenceAddress2] varchar(255) NULL,
    [drvResidenceCity] varchar(255) NULL,
    [drvResidenceState] varchar(255) NULL,
    [drvResidenceZIP] varchar(50) NULL,
    [drvEmployeeemail] varchar(50) NULL,
    [drvTerminationDate] datetime NULL,
    [drvReasonCode] char(6) NULL,
    [drvComments] varchar(1) NOT NULL,
    [drvEligibleforRehire] char(1) NULL,
    [drvPayPeriodStartDate] datetime NULL,
    [drvPayPeriodEndingDate] datetime NULL,
    [drvCheckDate] datetime NULL,
    [drvHoursPaidbytype] varchar(24) NULL,
    [drvGrossWagesbytype] varchar(24) NULL,
    [drvPayFrequency] varchar(1) NOT NULL,
    [drvPayType] varchar(2) NOT NULL,
    [drvEmployeeYTDEarnings] varchar(24) NULL,
    [drvEmployeeYTDHours] varchar(24) NULL
);
IF OBJECT_ID('U_ECCCPAYEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECCCPAYEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECCCPAYEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECCCPAYEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ECCCPAYEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECCCPAYEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehEarnCode] varchar(6) NOT NULL,
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
IF OBJECT_ID('U_ECCCPAYEXP_PEarHist_TEST') IS NULL
CREATE TABLE [dbo].[U_ECCCPAYEXP_PEarHist_TEST] (
    [PehEEID] char(12) NOT NULL,
    [PehEarnCode] varchar(6) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPeriodStartDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECCCPAYEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Keystone Clearwater Solutions

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 05/22/2020
Service Request Number: TekP-2020-03-18-0001

Purpose: CCC Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECCCPAYEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECCCPAYEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECCCPAYEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECCCPAYEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECCCPAYEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECCCPAYEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECCCPAYEXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECCCPAYEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECCCPAYEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECCCPAYEXP';

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

    IF OBJECT_ID('U_ECCCPAYEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECCCPAYEXP_AuditFields;
    CREATE TABLE dbo.U_ECCCPAYEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ECCCPAYEXP_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ECCCPAYEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECCCPAYEXP_Audit;
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
    INTO dbo.U_ECCCPAYEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ECCCPAYEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ECCCPAYEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate -365 AND @EndDate + 14 ;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECCCPAYEXP_Audit ON dbo.U_ECCCPAYEXP_Audit (audKey1Value, audKey2Value);


    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECCCPAYEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECCCPAYEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

     DELETE FROM dbo.U_ECCCPAYEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT eeceeid FROM dbo.EmpComp where eeceetype IN('INT', 'STU', 'SUM', 'TMP' ,'Z'));



    
    --==========================================
    -- Build Working Tables
    --==========================================
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------

    IF @ExportCode LIKE '%TEST%'

    BEGIN
    IF OBJECT_ID('U_ECCCPAYEXP_PEarHist_TEST','U') IS NOT NULL
        DROP TABLE dbo.U_ECCCPAYEXP_PEarHist_TEST;
    SELECT DISTINCT
         PehEEID
        ,CASE WHEN PehEarnCode IN ('BONUS','HOLBO','RFBON','RTHBO','SGNBO','COMM' ,'SEV' ,'HOL','HOLS','WHOL','WHOLS','CR100','CRA12','CRA66','BEREV','BERVS','JURY','JURYS','PTO','PTOS','DT','OT','OTC','PD100','PD25','REG','REGOB','SALW','RETRO','SICK','VAC') THEN PehEarnCode ELSE 'OTHERS' END as PehEarnCode
        ,PrgPayDate             = PrgPayDate
        ,PrgPeriodStartDate
        ,PrgPeriodEndDate
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
    INTO dbo.U_ECCCPAYEXP_PEarHist_TEST
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4) AND 
    PehPerControl BETWEEN @StartPerControl and @EndPerControl
    and pehearncode not in ('BOOT','GLASS','HOUSE','MILE','OP401','PANTS','PD100','PD25','PDNTX','TRUCK')
    GROUP BY PehEEID,PrgPayDate,PrgPeriodStartDate, PrgPeriodEndDate , CASE WHEN PehEarnCode IN ('BONUS','HOLBO','RFBON','RTHBO','SGNBO','COMM' ,'SEV' ,'HOL','HOLS','WHOL','WHOLS','CR100','CRA12','CRA66','BEREV','BERVS','JURY','JURYS','PTO','PTOS','DT','OT','OTC','PD100','PD25','REG','REGOB','SALW','RETRO','SICK','VAC') THEN PehEarnCode ELSE 'OTHERS' END
    HAVING SUM(PehCurAmt) <> 0.00;

    END
    ELSE
    BEGIN
            IF OBJECT_ID('U_ECCCPAYEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECCCPAYEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,CASE WHEN PehEarnCode IN ('BONUS','HOLBO','RFBON','RTHBO','SGNBO','COMM' ,'SEV' ,'HOL','HOLS','WHOL','WHOLS','CR100','CRA12','CRA66','BEREV','BERVS','JURY','JURYS','PTO','PTOS','DT','OT','OTC','PD100','PD25','REG','REGOB','SALW','RETRO','SICK','VAC') THEN PehEarnCode ELSE 'OTHERS' END as PehEarnCode
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
    INTO dbo.U_ECCCPAYEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    and pehearncode not in ('BOOT','GLASS','HOUSE','MILE','OP401','PANTS','PD100','PD25','PDNTX','TRUCK')
    GROUP BY PehEEID,CASE WHEN PehEarnCode IN ('BONUS','HOLBO','RFBON','RTHBO','SGNBO','COMM' ,'SEV' ,'HOL','HOLS','WHOL','WHOLS','CR100','CRA12','CRA66','BEREV','BERVS','JURY','JURYS','PTO','PTOS','DT','OT','OTC','PD100','PD25','REG','REGOB','SALW','RETRO','SICK','VAC') THEN PehEarnCode ELSE 'OTHERS' END
    HAVING SUM(PehCurAmt) <> 0.00;
    END
    --Delete from dbo.U_ECCCPAYEXP_PEarHist where pehearncode in (select ErnEarnCode from EarnCode where Erntaxcategory = 'NTFPY')
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECCCPAYEXP_drvTbl
    ---------------------------------
    IF  @ExportCode LIKE '%TEST%'  
    BEGIN
        IF OBJECT_ID('U_ECCCPAYEXP_drvTbl','U') IS NOT NULL
            DROP TABLE dbo.U_ECCCPAYEXP_drvTbl;
        SELECT DISTINCT
             drvEEID = xEEID
            ,drvCoID = xCoID
            ,drvInitialSort = eepSSN
            ,drvSubSort = ''
            -- standard fields above and additional driver fields below
            ,drvCompanyIdentifier = '83905'
            ,drvSSN = eepSSN
            ,drvState = EepAddressState
            ,drvEmployeeID = EecEmpNo
            ,drvSUI = '73-24185'
            ,drvFEIN = CmpFedTaxID
            ,drvLocation = EecLocation
            ,drvFirstName = EepNameFirst
            ,drvMiddleInitial = LEFT(EepNameMiddle,1)
            ,drvLastName = EepNameLast
            ,drvOriginalHireDate = EecDateOfOriginalHire
            ,drvMostRecentHireDate = EecDateOfLastHire
            ,drvStartDate = EecDateOfOriginalHire
            ,drvDateofBirth = EepDateOfBirth
            ,drvJobTitle = JbcDesc
            ,drvEmployeeStatus = CASE WHEN  eecemplstatus = 'L' THEN 'L'
                                      WHEN  eecemplstatus = 'T' THEN 
                                        CASE WHEN EecTermReason = '202' THEN 'R'
                                             WHEN EecTermReason = '203' THEN 'Q'
                                             WHEN EecTermReason = '203' THEN 'Q'    
                                             WHEN EecTermReason not in ('203','202') THEN 'T'
                                        END
                                      ELSE 'A'
                                 END
            ,drvEmployeeType = EecFullTimeOrPartTime
            ,drvRateofPay =  dbo.dsi_fnpadzero((ISNULL(eecannsalary,0) *100),10,0)
            ,drvRateofPayType = 'A'
            ,drvEmployeeHomePhone = eepphonehomenumber
            ,drvEmployeeCellPhone = (Select top 1 efoPhoneNumber from EmpMPhon where efoPhoneType = 'CEL' and efoeeid = xeeid)
            ,drvResidenceAddress1 = EepAddressLine1
            ,drvResidenceAddress2 = EepAddressLine2
            ,drvResidenceCity = EepAddressCity
            ,drvResidenceState = EepAddressState
            ,drvResidenceZIP = eepaddresszipcode
            ,drvEmployeeemail = CASE WHEN eepaddressemailalternate is not  null then eepaddressemailalternate else  EepAddressEMail END
            ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
            ,drvReasonCode = CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
            ,drvComments = ''
            ,drvEligibleforRehire = CASE WHEN  eecemplstatus = 'T'  THEN EecOKToRehire END
            ,drvPayPeriodStartDate =  PrgPeriodStartDate
            ,drvPayPeriodEndingDate = PrgPeriodEndDate
            ,drvCheckDate = PrgPayDate 
            ,drvHoursPaidbytype = dbo.dsi_fnpadzero((ISNULL(PehCurHrs,0) *100),10,0) 
            ,drvGrossWagesbytype = dbo.dsi_fnpadzero((ISNULL(PehCurAmt,0) *100),10,0)  
            ,drvPayFrequency = CASE WHEN EecPayPeriod   = 'W'  THEN '1' ELSE '2' END
            ,drvPayType = CASE  WHEN PehEarnCode in ('BONUS') THEN 'B'
                                WHEN PehEarnCode in ('HOLBO') THEN 'B'
                                WHEN PehEarnCode in ('RFBON') THEN 'B'
                                WHEN PehEarnCode in ('RTHBO') THEN 'B'
                                WHEN PehEarnCode in ('SGNBO') THEN 'B'
                                WHEN PehEarnCode in ('COMM') THEN 'C'
                                WHEN PehEarnCode in ('SEV') THEN 'E'
                                WHEN PehEarnCode in ('HOL') THEN 'H'
                                WHEN PehEarnCode in ('HOLS') THEN 'H'
                                WHEN PehEarnCode in ('WHOL') THEN 'H'
                                WHEN PehEarnCode in ('WHOLS') THEN 'H'
                                WHEN PehEarnCode in ('CR100') THEN 'I'
                                WHEN PehEarnCode in ('CRA12') THEN 'I'
                                WHEN PehEarnCode in ('CRA66') THEN 'I'
                                WHEN PehEarnCode in ('BEREV') THEN 'N'
                                WHEN PehEarnCode in ('BERVS') THEN 'N'
                                WHEN PehEarnCode in ('JURY') THEN 'N'
                                WHEN PehEarnCode in ('JURYS') THEN 'N'
                                WHEN PehEarnCode in ('PTO') THEN 'N'
                                WHEN PehEarnCode in ('PTOS') THEN 'N'
                                WHEN PehEarnCode in ('DT') THEN 'O'
                                WHEN PehEarnCode in ('OT') THEN 'O'
                                WHEN PehEarnCode in ('OTC') THEN 'O'
                                WHEN PehEarnCode in ('PD100') THEN 'R'
                                WHEN PehEarnCode in ('PD25') THEN 'R'
                                WHEN PehEarnCode in ('REG') THEN 'R'
                                WHEN PehEarnCode in ('REGOB') THEN 'R'
                                WHEN PehEarnCode in ('SALW') THEN 'R'
                                WHEN PehEarnCode in ('RETRO') THEN 'RA'
                                WHEN PehEarnCode in ('SICK') THEN 'S'
                                WHEN PehEarnCode in ('VAC') THEN 'V'
                                ELSE 'M'
                                END
            ,drvEmployeeYTDEarnings =   dbo.dsi_fnpadzero((ISNULL(PehCurAmtYTD,0) *100),10,0) 
            ,drvEmployeeYTDHours =  dbo.dsi_fnpadzero((ISNULL(PehCurHrsYTD,0) *100),10,0) 
        INTO dbo.U_ECCCPAYEXP_drvTbl
        FROM dbo.U_ECCCPAYEXP_EEList WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = xEEID 
            AND EecCoID = xCoID
            and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                          and EXISTS(select 1 from dbo.U_ECCCPAYEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
        JOIN dbo.Company WITH (NOLOCK)
            ON CmpCoID = xCoID
        JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
        JOIN dbo.JobCode WITH (NOLOCK)
            ON JbcJobCode = EecJobCode
        JOIN dbo.U_ECCCPAYEXP_PEarHist_TEST WITH (NOLOCK)
            ON PehEEID  = xEEID
        /*
          LEFT JOIN (SELECT PgpPayGroup, LEFT(PgpPeriodControl,8) as PayDate, PgpPeriodStartDate as PrgPeriodStart, PgpPeriodEndDate PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl ) as Paydate
        ON Paydate.PgpPayGroup =  eecpaygroup
        ;*/
    END

    ELSE 
    BEGIN
        IF OBJECT_ID('U_ECCCPAYEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECCCPAYEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvCompanyIdentifier = '83905'
        ,drvSSN = eepSSN
        ,drvState = EepAddressState
        ,drvEmployeeID = EecEmpNo
        ,drvSUI = '73-24185'
        ,drvFEIN = CmpFedTaxID
        ,drvLocation = EecLocation
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvMostRecentHireDate = EecDateOfLastHire
        ,drvStartDate = EecDateOfOriginalHire
        ,drvDateofBirth = EepDateOfBirth
        ,drvJobTitle = JbcDesc
        ,drvEmployeeStatus = CASE WHEN  eecemplstatus = 'L' THEN 'L'
                                  WHEN  eecemplstatus = 'T' THEN 
                                    CASE WHEN EecTermReason = '202' THEN 'R'
                                         WHEN EecTermReason = '203' THEN 'Q'
                                         WHEN EecTermReason = '203' THEN 'Q'    
                                         WHEN EecTermReason not in ('203','202') THEN 'T'
                                    END
                                  ELSE 'A'
                             END
        ,drvEmployeeType = EecFullTimeOrPartTime
        ,drvRateofPay =  dbo.dsi_fnpadzero((ISNULL(eecannsalary,0) *100),10,0)
        ,drvRateofPayType = 'A'
        ,drvEmployeeHomePhone = eepphonehomenumber
        ,drvEmployeeCellPhone = (Select top 1 efoPhoneNumber from EmpMPhon where efoPhoneType = 'CEL' and efoeeid = xeeid)
        ,drvResidenceAddress1 = EepAddressLine1
        ,drvResidenceAddress2 = EepAddressLine2
        ,drvResidenceCity = EepAddressCity
        ,drvResidenceState = EepAddressState
        ,drvResidenceZIP = eepaddresszipcode
        ,drvEmployeeemail = CASE WHEN eepaddressemailalternate is not  null then eepaddressemailalternate else  EepAddressEMail END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvReasonCode = CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvComments = ''
        ,drvEligibleforRehire = CASE WHEN  eecemplstatus = 'T'  THEN EecOKToRehire END
        ,drvPayPeriodStartDate =  PrgPeriodStart
        ,drvPayPeriodEndingDate = PrgPeriodEnd
        ,drvCheckDate =  dbo.dsi_fnGetMinMaxDates('MAX',Paydate, PrgPayDate) 
        ,drvHoursPaidbytype = dbo.dsi_fnpadzero((ISNULL(PehCurHrs,0) *100),10,0) 
        ,drvGrossWagesbytype = dbo.dsi_fnpadzero((ISNULL(PehCurAmt,0) *100),10,0)  
        ,drvPayFrequency = CASE WHEN EecPayPeriod   = 'W'  THEN '1' ELSE '2' END
        ,drvPayType = CASE  WHEN PehEarnCode in ('BONUS') THEN 'B'
                            WHEN PehEarnCode in ('HOLBO') THEN 'B'
                            WHEN PehEarnCode in ('RFBON') THEN 'B'
                            WHEN PehEarnCode in ('RTHBO') THEN 'B'
                            WHEN PehEarnCode in ('SGNBO') THEN 'B'
                            WHEN PehEarnCode in ('COMM') THEN 'C'
                            WHEN PehEarnCode in ('SEV') THEN 'E'
                            WHEN PehEarnCode in ('HOL') THEN 'H'
                            WHEN PehEarnCode in ('HOLS') THEN 'H'
                            WHEN PehEarnCode in ('WHOL') THEN 'H'
                            WHEN PehEarnCode in ('WHOLS') THEN 'H'
                            WHEN PehEarnCode in ('CR100') THEN 'I'
                            WHEN PehEarnCode in ('CRA12') THEN 'I'
                            WHEN PehEarnCode in ('CRA66') THEN 'I'
                            WHEN PehEarnCode in ('BEREV') THEN 'N'
                            WHEN PehEarnCode in ('BERVS') THEN 'N'
                            WHEN PehEarnCode in ('JURY') THEN 'N'
                            WHEN PehEarnCode in ('JURYS') THEN 'N'
                            WHEN PehEarnCode in ('PTO') THEN 'N'
                            WHEN PehEarnCode in ('PTOS') THEN 'N'
                            WHEN PehEarnCode in ('DT') THEN 'O'
                            WHEN PehEarnCode in ('OT') THEN 'O'
                            WHEN PehEarnCode in ('OTC') THEN 'O'
                            WHEN PehEarnCode in ('PD100') THEN 'R'
                            WHEN PehEarnCode in ('PD25') THEN 'R'
                            WHEN PehEarnCode in ('REG') THEN 'R'
                            WHEN PehEarnCode in ('REGOB') THEN 'R'
                            WHEN PehEarnCode in ('SALW') THEN 'R'
                            WHEN PehEarnCode in ('RETRO') THEN 'RA'
                            WHEN PehEarnCode in ('SICK') THEN 'S'
                            WHEN PehEarnCode in ('VAC') THEN 'V'
                            ELSE 'M'
                            END
        ,drvEmployeeYTDEarnings =   dbo.dsi_fnpadzero((ISNULL(PehCurAmtYTD,0) *100),10,0) 
        ,drvEmployeeYTDHours =  dbo.dsi_fnpadzero((ISNULL(PehCurHrsYTD,0) *100),10,0) 
    INTO dbo.U_ECCCPAYEXP_drvTbl
    FROM dbo.U_ECCCPAYEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ECCCPAYEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_ECCCPAYEXP_PEarHist WITH (NOLOCK)
        ON PehEEID  = xEEID
      LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as Paydate
    ON Paydate.PgpPayGroup =  eecpaygroup;
    END

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
ALTER VIEW dbo.dsi_vwECCCPAYEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECCCPAYEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECCCPAYEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005151'
       ,expStartPerControl     = '202005151'
       ,expLastEndPerControl   = '202005229'
       ,expEndPerControl       = '202005229'
WHERE expFormatCode = 'ECCCPAYEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECCCPAYEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECCCPAYEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort