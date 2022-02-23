SET NOCOUNT ON;
IF OBJECT_ID('U_ECCCPAYEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECCCPAYEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECCCPAYEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECCCPAYEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECCCPAYEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECCCPAYEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECCCPAYEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECCCPAYEXP];
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
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee YTD Hours"','40','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','40',NULL,'Employee YTD Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Eligible for Medical Benefits"','41','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','41',NULL,'Eligible for Medical Benefits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Insurance Carrier"','42','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','42',NULL,'Medical Insurance Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Enrolled in Medical"','43','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','44',NULL,'Enrolled in Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Eligible for Dental Benefits"','44','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','44',NULL,'Employee YTD Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Insurance Carrier"','45','(''DA''=''Q|'')','ECCCPAYEXPZ0','50','H','01','45',NULL,'Dental Insurance Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Enrolled in Dental"','46','(''DA''=''Q'')','ECCCPAYEXPZ0','50','H','01','46',NULL,'Enrolled in Dental',NULL,NULL);


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
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeYTDHours"','40','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','40',NULL,'Employee YTD Hours',NULL,NULL);

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibleforMedicalBenefits"','41','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','41',NULL,'Eligible for Medical Benefits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicalInsuranceCarrier"','42','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','42',NULL,'Medical Insurance Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrolledinMedical"','43','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','44',NULL,'Enrolled in Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibleforDentalBenefits"','44','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','44',NULL,'Employee YTD Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalInsuranceCarrier"','45','(''UA''=''Q|'')','ECCCPAYEXPZ0','50','D','10','45',NULL,'Dental Insurance Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrolledinDental"','46','(''UA''=''Q'')','ECCCPAYEXPZ0','50','D','10','46',NULL,'Enrolled in Dental',NULL,NULL);

DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECCCPAYEXP_20200527.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CCC Payroll Export','202005229','EMPEXPORT','ONDEMAND',NULL,'ECCCPAYEXP',NULL,NULL,NULL,'202005229','May 22 2020  1:36PM','May 22 2020  1:36PM','202005221',NULL,'','','202005221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECCCPAYEXP_20200527.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202005229','EMPEXPORT','TEST',NULL,'ECCCPAYEXP',NULL,NULL,NULL,'202005229','May 22 2020  1:36PM','May 22 2020  1:36PM','202005221',NULL,'','','202005221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECCCPAYEXP_20200527.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202005229','EMPEXPORT','SCH_CCCP',NULL,'ECCCPAYEXP',NULL,NULL,NULL,'202005229','May 22 2020  1:36PM','May 22 2020  1:36PM','202005221',NULL,'','','202005221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ECCCPAYEXP_20200527.txt' END WHERE expFormatCode = 'ECCCPAYEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCCPAYEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCCPAYEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCCPAYEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCCPAYEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCCPAYEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECCCPAYEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ECCCPAYEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECCCPAYEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECCCPAYEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Apergy USA, Inc.

Created By: Inshan Singh
Business Analyst: Jackie Finn
Create Date: 08/13/2020
Service Request Number: 2020-00270293

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
     -- Declare variables    --==========================================    DECLARE  @FormatCode        VARCHAR(10)            ,@ExportCode        VARCHAR(10)            ,@StartDate         DATETIME            ,@EndDate           DATETIME            ,@StartPerControl   VARCHAR(9)            ,@EndPerControl     VARCHAR(9);    -- Set FormatCode    SELECT @FormatCode = 'ECCCPAYEXP';    -- Declare dates from Parameter file    SELECT         @StartPerControl = StartPerControl        ,@EndPerControl   = EndPerControl        ,@StartDate       = LEFT(StartPerControl,8)        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))        ,@ExportCode      = ExportCode    FROM dbo.U_dsi_Parameters WITH (NOLOCK)    WHERE FormatCode = @FormatCode;  --==========================================    -- Deduction Code List    --==========================================    DECLARE @DedList VARCHAR(MAX);    SET @DedList = 'MED1,DEN1,DEN2';    IF OBJECT_ID('U_ECCCPAYEXP_DedList','U') IS NOT NULL        DROP TABLE dbo.U_ECCCPAYEXP_DedList;    SELECT DedCode = DedDedCode        ,DedLongDesc        ,DedType = DedDedType    INTO dbo.U_ECCCPAYEXP_DedList    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)    JOIN dbo.DedCode WITH (NOLOCK)        ON DedDedCode = Item;    --==========================================    -- BDM Section    --==========================================    -- now set values for benefit module    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;    -- Required parms    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes',@DedList);    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption', 'AuditDate');    -- Non-required parms    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC');    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');      EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;    --==========================================    -- Clean EE List    --==========================================    --==========================================    -- Clean EE List     -- Caution: Careful of cleaning EE List if including paycheck data    --==========================================    IF OBJECT_ID('U_ECCCPAYEXP_AuditFields','U') IS NOT NULL        DROP TABLE dbo.U_ECCCPAYEXP_AuditFields;    CREATE TABLE dbo.U_ECCCPAYEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));        -- Insert tables/fields to be audited    INSERT INTO dbo.U_ECCCPAYEXP_AuditFields VALUES ('empcomp','eecemplstatus');            -- Create audit table    IF OBJECT_ID('U_ECCCPAYEXP_Audit','U') IS NOT NULL        DROP TABLE dbo.U_ECCCPAYEXP_Audit;    SELECT         audTableName = adrTableName        ,audFieldName = adfFieldName        ,audKey1Value = ISNULL(adrKey1,'')        ,audKey2Value = ISNULL(adrKey2,'')        ,audKey3Value = ISNULL(adrKey3,'')        ,audDateTime  = adrProcessedDateTime        ,audOldValue  = adfOldData        ,audNewValue  = adfNewData        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)    INTO dbo.U_ECCCPAYEXP_Audit    FROM (SELECT *          FROM dbo.AuditRecords WITH (NOLOCK)          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ECCCPAYEXP_AuditFields WITH (NOLOCK))) ADR    JOIN (SELECT *          FROM dbo.AuditFields WITH (NOLOCK)          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ECCCPAYEXP_AuditFields WITH (NOLOCK))) ADF        ON adrSystemID = adfSystemID       AND adrKey = adfKey    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed      AND adrProcessedDateTime BETWEEN @EndDate -365 AND @EndDate;        -- Create Index    CREATE CLUSTERED INDEX CDX_U_ECCCPAYEXP_Audit ON dbo.U_ECCCPAYEXP_Audit (audKey1Value, audKey2Value);    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company    DELETE FROM dbo.U_ECCCPAYEXP_EEList    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)    AND xEEID IN (SELECT xEEID FROM dbo.U_ECCCPAYEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);    --==========================================    -- Build Working Tables    --==========================================    -----------------------------    -- Working Table - PEarHist    -----------------------------    IF OBJECT_ID('U_ECCCPAYEXP_PEarHist','U') IS NOT NULL        DROP TABLE dbo.U_ECCCPAYEXP_PEarHist;    SELECT DISTINCT         PehEEID        ,PehEarnCode        ,PrgPayDate             = MAX(PrgPayDate)        -- Current Payroll Amount/Hours        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)        -- YTD Payroll Amount/Hours        ,PehCurAmtYTD           = SUM(PehCurAmt)        ,PehCurHrsYTD           = SUM(PehCurHrs)        -- Current Include Deferred Comp Amount/Hours        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)        -- YTD Include Deferred Comp Amount/Hours        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)    INTO dbo.U_ECCCPAYEXP_PEarHist    FROM dbo.PayReg WITH (NOLOCK)    JOIN dbo.PEarHist WITH (NOLOCK)        ON PehGenNumber = PrgGenNumber    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)    AND PehPerControl <= @EndPerControl    GROUP BY PehEEID,PehEarnCode    HAVING SUM(PehCurAmt) <> 0.00;    --==========================================    -- Build Driver Tables    --==========================================    ---------------------------------    -- DETAIL RECORD - U_ECCCPAYEXP_drvTbl    ---------------------------------    IF OBJECT_ID('U_ECCCPAYEXP_drvTbl','U') IS NOT NULL        DROP TABLE dbo.U_ECCCPAYEXP_drvTbl;    SELECT DISTINCT         drvEEID = xEEID        ,drvCoID = xCoID        ,drvInitialSort = eepSSN        ,drvSubSort = ''        -- standard fields above and additional driver fields below        ,drvCompanyIdentifier = '646349'        ,drvSSN = eepSSN        ,drvState = LEFT(EecStateSUI,2)        ,drvEmployeeID = EecEmpNo        ,drvSUI = ''        ,drvFEIN = CmpFedTaxID        ,drvLocation = EecLocation        ,drvFirstName = EepNameFirst        ,drvMiddleInitial = LEFT(EepNameMiddle,1)        ,drvLastName = EepNameLast        ,drvOriginalHireDate = EecDateOfOriginalHire        ,drvMostRecentHireDate = EecDateOfLastHire        ,drvStartDate = EecDateOfOriginalHire        ,drvDateofBirth = EepDateOfBirth        ,drvJobTitle = JbcDesc        ,drvEmployeeStatus = CASE WHEN  eecemplstatus = 'L' THEN 'L'                                  WHEN  eecemplstatus = 'T' THEN                                     CASE WHEN EecTermReason = '202' THEN 'R'                                         WHEN EecTermReason = '203' THEN 'Q'                                         WHEN EecTermReason = '203' THEN 'Q'                                             WHEN EecTermReason not in ('203','202') THEN 'T'                                    END                                  ELSE 'A'                             END        ,drvEmployeeType = EecFullTimeOrPartTime        ,drvRateofPay =  CASE WHEN EecSalaryOrHourly  = 'S' THEN dbo.dsi_fnpadzero((ISNULL(eecannsalary,0) *100),10,0) ELSE dbo.dsi_fnpadzero((ISNULL(EecHourlyPayRate,0) *100),10,0) END        ,drvRateofPayType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'A' ELSE 'H' END        ,drvEmployeeHomePhone = ''        ,drvEmployeeCellPhone = '' --(Select top 1 efoPhoneNumber from EmpMPhon where efoPhoneType = 'CEL' and efoeeid = xeeid)        ,drvResidenceAddress1 = EepAddressLine1        ,drvResidenceAddress2 = EepAddressLine2        ,drvResidenceCity = EepAddressCity        ,drvResidenceState = EepAddressState        ,drvResidenceZIP = eepaddresszipcode        ,drvEmployeeemail = CASE WHEN eepaddressemailalternate is not  null then eepaddressemailalternate else  EepAddressEMail END        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END        ,drvReasonCode = CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END        ,drvComments = ''        ,drvEligibleforRehire = CASE WHEN  eecemplstatus = 'T'  THEN EecOKToRehire END        ,drvPayPeriodStartDate =  @StartDate        ,drvPayPeriodEndingDate = @EndDate        ,drvCheckDate = dbo.dsi_fnGetMinMaxDates('MAX',Paydate, PrgPayDate)         ,drvHoursPaidbytype = dbo.dsi_fnpadzero((ISNULL(PehCurHrs,0) *100),10,0)         ,drvGrossWagesbytype = dbo.dsi_fnpadzero((ISNULL(PehCurAmt,0) *100),10,0)          ,drvPayFrequency = CASE WHEN EecPayPeriod   = 'W'  THEN '1'                                  WHEN EecPayPeriod   = 'B'  THEN '2'                                     WHEN EecPayPeriod   = 'S'  THEN '3'                                WHEN EecPayPeriod   = 'M'  THEN '4'                            END        ,drvPayType = (Select top 1 ernReportCategory from dbo.earncode where ernearncode = pehearncode)        ,drvEmployeeYTDEarnings =   dbo.dsi_fnpadzero((ISNULL(PehCurAmtYTD,0) *100),10,0)         ,drvEmployeeYTDHours =  dbo.dsi_fnpadzero((ISNULL(PehCurHrsYTD,0) *100),10,0)         ,drvEligibleforMedicalBenefits = CASE WHEN eecFulltimeorParttime = 'F' THEN 'Y' ELSE 'N' END        ,drvMedicalInsuranceCarrier =  CASE WHEN MED = 'Y' THEN 'BCBS or Select Health' END        ,drvEnrolledinMedical = ISNULL(MED,'N')        ,drvEligibleforDentalBenefits = CASE WHEN eecFulltimeorParttime = 'F' THEN 'Y' ELSE 'N' END        ,drvDentalInsuranceCarrier = CASE WHEN MED = 'Y' THEN 'Delta Dental' END         ,drvEnrolledinDental = ISNULL(DEN,'N')    INTO dbo.U_ECCCPAYEXP_drvTbl    FROM dbo.U_ECCCPAYEXP_EEList WITH (NOLOCK)    JOIN dbo.EmpComp WITH (NOLOCK)        ON EecEEID = xEEID         AND EecCoID = xCoID        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO'                                       and EXISTS(select 1 from dbo.U_ECCCPAYEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))    JOIN dbo.Company WITH (NOLOCK)        ON CmpCoID = xCoID    JOIN dbo.EmpPers WITH (NOLOCK)        ON EepEEID = xEEID    JOIN dbo.JobCode WITH (NOLOCK)        ON JbcJobCode = EecJobCode    JOIN dbo.U_ECCCPAYEXP_PEarHist WITH (NOLOCK)        ON PehEEID  = xEEID      LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd                    FROM dbo.PgPayPer WITH (NOLOCK)                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl                    GROUP BY PgpPayGroup) as Paydate    ON Paydate.PgpPayGroup =  eecpaygroup	LEFT JOIN (Select eedeeid,eedcoid,max(case when eeddedcode = 'MED1' and eedbenstatus = 'A' THEN 'Y' ELSE  'N' END) as MED, 				max(case when eeddedcode IN ('DEN1','DEN2') and eedbenstatus = 'A' THEN 'Y' ELSE  'N' END) as DEN   from u_dsi_bdm_empdeductions				where eedformatcode  = 'ECCCPAYEXP' and eedValidforExport = 'Y'				group by eedeeid,eedcoid) as Benefits		on eedeeid = xeeid		and eedcoid  = xcoid    ;    --==========================================    -- Set FileName    --==========================================    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')    BEGIN        UPDATE dbo.U_dsi_Parameters            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'                             END        WHERE FormatCode = @FormatCode;    
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