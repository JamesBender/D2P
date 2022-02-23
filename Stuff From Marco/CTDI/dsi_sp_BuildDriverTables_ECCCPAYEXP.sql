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
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECCCPAYEXP','CCC Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECCCPAYEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECCCPAYEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECCCPAYEXPZ0','50','H','01','1',NULL,'Company Identifier',NULL,NULL,'"Company Identifier"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECCCPAYEXPZ0','50','H','01','2',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECCCPAYEXPZ0','50','H','01','3',NULL,'State',NULL,NULL,'"State"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECCCPAYEXPZ0','50','H','01','4',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECCCPAYEXPZ0','50','H','01','5',NULL,'SUI',NULL,NULL,'"SUI"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECCCPAYEXPZ0','50','H','01','6',NULL,'FEIN',NULL,NULL,'"FEIN"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECCCPAYEXPZ0','50','H','01','7',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECCCPAYEXPZ0','50','H','01','8',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECCCPAYEXPZ0','50','H','01','9',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECCCPAYEXPZ0','50','H','01','10',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECCCPAYEXPZ0','50','H','01','11',NULL,'Original Hire Date',NULL,NULL,'"Original Hire Date"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECCCPAYEXPZ0','50','H','01','12',NULL,'Most Recent Hire Date',NULL,NULL,'"Most Recent Hire Date"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECCCPAYEXPZ0','50','H','01','13',NULL,'Start Date',NULL,NULL,'"Start Date"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECCCPAYEXPZ0','50','H','01','14',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECCCPAYEXPZ0','50','H','01','15',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECCCPAYEXPZ0','50','H','01','16',NULL,'Employee Status',NULL,NULL,'"Employee Status"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECCCPAYEXPZ0','50','H','01','17',NULL,'Employee Type',NULL,NULL,'"Employee Type"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECCCPAYEXPZ0','50','H','01','18',NULL,'Rate of Pay',NULL,NULL,'"Rate of Pay"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECCCPAYEXPZ0','50','H','01','19',NULL,'Rate of Pay Type',NULL,NULL,'"Rate of Pay Type"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECCCPAYEXPZ0','50','H','01','20',NULL,'Employee Home Phone',NULL,NULL,'"Employee Home Phone"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECCCPAYEXPZ0','50','H','01','21',NULL,'Employee Cell Phone',NULL,NULL,'"Employee Cell Phone"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECCCPAYEXPZ0','50','H','01','22',NULL,'Residence Address 1',NULL,NULL,'"Residence Address 1"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECCCPAYEXPZ0','50','H','01','23',NULL,'Residence Address 2',NULL,NULL,'"Residence Address 2"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECCCPAYEXPZ0','50','H','01','24',NULL,'Residence City',NULL,NULL,'"Residence City"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECCCPAYEXPZ0','50','H','01','25',NULL,'Residence State',NULL,NULL,'"Residence State"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECCCPAYEXPZ0','50','H','01','26',NULL,'Residence ZIP',NULL,NULL,'"Residence ZIP"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECCCPAYEXPZ0','50','H','01','27',NULL,'Employee email',NULL,NULL,'"Employee email"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECCCPAYEXPZ0','50','H','01','28',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECCCPAYEXPZ0','50','H','01','29',NULL,'Reason Code',NULL,NULL,'"Reason Code"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECCCPAYEXPZ0','50','H','01','30',NULL,'Comments',NULL,NULL,'"Comments"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECCCPAYEXPZ0','50','H','01','31',NULL,'Eligible for Rehire',NULL,NULL,'"Eligible for Rehire"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECCCPAYEXPZ0','50','H','01','32',NULL,'Pay Period Start Date',NULL,NULL,'"Pay Period Start Date"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECCCPAYEXPZ0','50','H','01','33',NULL,'Pay Period Ending Date',NULL,NULL,'"Pay Period Ending Date"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECCCPAYEXPZ0','50','H','01','34',NULL,'Check Date',NULL,NULL,'"Check Date"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECCCPAYEXPZ0','50','H','01','35',NULL,'Hours Paid - by type',NULL,NULL,'"Hours Paid - by type"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECCCPAYEXPZ0','50','H','01','36',NULL,'Gross Wages - by type',NULL,NULL,'"Gross Wages - by type"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECCCPAYEXPZ0','50','H','01','37',NULL,'Pay Frequency',NULL,NULL,'"Pay Frequency"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECCCPAYEXPZ0','50','H','01','38',NULL,'Pay Type',NULL,NULL,'"Pay Type"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECCCPAYEXPZ0','50','H','01','39',NULL,'Employee YTD Earnings',NULL,NULL,'"Employee YTD Earnings"','(''DA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECCCPAYEXPZ0','50','H','01','40',NULL,'Employee YTD Hours',NULL,NULL,'"Employee YTD Hours"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECCCPAYEXPZ0','50','D','10','1',NULL,'Company Identifier',NULL,NULL,'"drvCompanyIdentifier"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECCCPAYEXPZ0','50','D','10','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECCCPAYEXPZ0','50','D','10','3',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECCCPAYEXPZ0','50','D','10','4',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECCCPAYEXPZ0','50','D','10','5',NULL,'SUI',NULL,NULL,'"drvSUI"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECCCPAYEXPZ0','50','D','10','6',NULL,'FEIN',NULL,NULL,'"drvFEIN"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECCCPAYEXPZ0','50','D','10','7',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECCCPAYEXPZ0','50','D','10','8',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECCCPAYEXPZ0','50','D','10','9',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECCCPAYEXPZ0','50','D','10','10',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECCCPAYEXPZ0','50','D','10','11',NULL,'Original Hire Date',NULL,NULL,'"drvOriginalHireDate"','(''UD112''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECCCPAYEXPZ0','50','D','10','12',NULL,'Most Recent Hire Date',NULL,NULL,'"drvMostRecentHireDate"','(''UD112''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECCCPAYEXPZ0','50','D','10','13',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD112''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECCCPAYEXPZ0','50','D','10','14',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD112''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECCCPAYEXPZ0','50','D','10','15',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECCCPAYEXPZ0','50','D','10','16',NULL,'Employee Status',NULL,NULL,'"drvEmployeeStatus"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECCCPAYEXPZ0','50','D','10','17',NULL,'Employee Type',NULL,NULL,'"drvEmployeeType"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECCCPAYEXPZ0','50','D','10','18',NULL,'Rate of Pay',NULL,NULL,'"drvRateofPay"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECCCPAYEXPZ0','50','D','10','19',NULL,'Rate of Pay Type',NULL,NULL,'"drvRateofPayType"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECCCPAYEXPZ0','50','D','10','20',NULL,'Employee Home Phone',NULL,NULL,'"drvEmployeeHomePhone"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECCCPAYEXPZ0','50','D','10','21',NULL,'Employee Cell Phone',NULL,NULL,'"drvEmployeeCellPhone"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECCCPAYEXPZ0','50','D','10','22',NULL,'Residence Address 1',NULL,NULL,'"drvResidenceAddress1"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECCCPAYEXPZ0','50','D','10','23',NULL,'Residence Address 2',NULL,NULL,'"drvResidenceAddress2"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECCCPAYEXPZ0','50','D','10','24',NULL,'Residence City',NULL,NULL,'"drvResidenceCity"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECCCPAYEXPZ0','50','D','10','25',NULL,'Residence State',NULL,NULL,'"drvResidenceState"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECCCPAYEXPZ0','50','D','10','26',NULL,'Residence ZIP',NULL,NULL,'"drvResidenceZIP"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECCCPAYEXPZ0','50','D','10','27',NULL,'Employee email',NULL,NULL,'"drvEmployeeemail"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECCCPAYEXPZ0','50','D','10','28',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD112''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECCCPAYEXPZ0','50','D','10','29',NULL,'Reason Code',NULL,NULL,'"drvReasonCode"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECCCPAYEXPZ0','50','D','10','30',NULL,'Comments',NULL,NULL,'"drvComments"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECCCPAYEXPZ0','50','D','10','31',NULL,'Eligible for Rehire',NULL,NULL,'"drvEligibleforRehire"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECCCPAYEXPZ0','50','D','10','32',NULL,'Pay Period Start Date',NULL,NULL,'"drvPayPeriodStartDate"','(''UD112''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECCCPAYEXPZ0','50','D','10','33',NULL,'Pay Period Ending Date',NULL,NULL,'"drvPayPeriodEndingDate"','(''UD112''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECCCPAYEXPZ0','50','D','10','34',NULL,'Check Date',NULL,NULL,'"drvCheckDate"','(''UD112''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECCCPAYEXPZ0','50','D','10','35',NULL,'Hours Paid - by type',NULL,NULL,'"drvHoursPaidbytype"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECCCPAYEXPZ0','50','D','10','36',NULL,'Gross Wages - by type',NULL,NULL,'"drvGrossWagesbytype"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECCCPAYEXPZ0','50','D','10','37',NULL,'Pay Frequency',NULL,NULL,'"drvPayFrequency"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECCCPAYEXPZ0','50','D','10','38',NULL,'Pay Type',NULL,NULL,'"drvPayType"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECCCPAYEXPZ0','50','D','10','39',NULL,'Employee YTD Earnings',NULL,NULL,'"drvEmployeeYTDEarnings"','(''UA''=''Q|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECCCPAYEXPZ0','50','D','10','40',NULL,'Employee YTD Hours',NULL,NULL,'"drvEmployeeYTDHours"','(''UA''=''Q'')');
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECCCPAYEXP_20201016.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,'CCC Payroll Export','202005229','EMPEXPORT','ONDEMAND',NULL,'ECCCPAYEXP',NULL,NULL,NULL,'202005229','May 22 2020  1:36PM','May 22 2020  1:36PM','202005221',NULL,'','','202005221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202005229','EMPEXPORT','SCH_CCCP',NULL,'ECCCPAYEXP',NULL,NULL,NULL,'202005229','May 22 2020  1:36PM','May 22 2020  1:36PM','202005221',NULL,'','','202005221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,'Test Purposes Only','202010151','EMPEXPORT','TEST','Oct 16 2020 12:00AM','ECCCPAYEXP',NULL,NULL,NULL,'202010151','Oct 15 2020 12:00AM','Oct 11 2020 12:00AM','202010151',NULL,'','','202010151',dbo.fn_GetTimedKey(),NULL,'MLAGROSA08','',NULL);
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
    [drvCompanyIdentifier] varchar(6) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvState] varchar(255) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvSUI] char(15) NULL,
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
Client Name: Communication Test Design

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 10/15/2020
Service Request Number: TekP-2020-08-17-0005

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
      AND adrProcessedDateTime BETWEEN @EndDate -365 AND @EndDate;
    
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
    IF OBJECT_ID('U_ECCCPAYEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECCCPAYEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,CASE WHEN PehEarnCode IN ('ATTND','BONUS','CBNUS','NDBON','SAFTY','COMM','SEV','FHOL','FHOLP','HOL','BROPS','GCBNS','INCEN','MIP','BERV','EMGCL','JURY','MILIT','PER','BPASO','BPDBL','BPOT','CDT','COLBK','COT','DBLT','OT','PRCDT','PRCOT','PRJDT','PRJOT','BEEP1','BEEP2','BPASR','BPREG','DRVPY','PRJLD','REG','TRAV','TRVIC','UNITS','RETRO','SALCN','SICK','VAC','VACCO','VACPO','VACWN') THEN PehEarnCode ELSE 'OTHERS' END as PehEarnCode
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
    GROUP BY PehEEID,CASE WHEN PehEarnCode IN ('ATTND','BONUS','CBNUS','NDBON','SAFTY','COMM','SEV','FHOL','FHOLP','HOL','BROPS','GCBNS','INCEN','MIP','BERV','EMGCL','JURY','MILIT','PER','BPASO','BPDBL','BPOT','CDT','COLBK','COT','DBLT','OT','PRCDT','PRCOT','PRJDT','PRJOT','BEEP1','BEEP2','BPASR','BPREG','DRVPY','PRJLD','REG','TRAV','TRVIC','UNITS','RETRO','SALCN','SICK','VAC','VACCO','VACPO','VACWN') THEN PehEarnCode ELSE 'OTHERS' END
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECCCPAYEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECCCPAYEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECCCPAYEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvCompanyIdentifier = '657073'
        ,drvSSN = eepSSN
        ,drvState = (Select top 1 LocAddressState from location where loccode = eeclocation)
        ,drvEmployeeID = EecEmpNo
        ,drvSUI = (Select top 1 CtcIDNumber from ITaxCode where CtcTaxCode in (Select top 1 EetTaxCode from EmpTax where eeteeid = xeeid and eetTaxCode like '%SIT%') and ctccoid = xcoid)
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
        ,drvPayPeriodStartDate =  @StartDate
        ,drvPayPeriodEndingDate = @EndDate
        ,drvCheckDate = dbo.dsi_fnGetMinMaxDates('MAX',Paydate, PrgPayDate) 
        ,drvHoursPaidbytype = dbo.dsi_fnpadzero((ISNULL(PehCurHrs,0) *100),10,0) 
        ,drvGrossWagesbytype = dbo.dsi_fnpadzero((ISNULL(PehCurAmt,0) *100),10,0)  
        ,drvPayFrequency = CASE WHEN EecPayPeriod   = 'W'  THEN '1' ELSE '2' END
        ,drvPayType = CASE    WHEN PehEarnCode = 'ATTND' THEN 'B'
                            WHEN PehEarnCode = 'BONUS' THEN 'B'
                            WHEN PehEarnCode = 'CBNUS' THEN 'B'
                            WHEN PehEarnCode = 'NDBON' THEN 'B'
                            WHEN PehEarnCode = 'SAFTY' THEN 'B'
                            WHEN PehEarnCode = 'COMM' THEN 'C'
                            WHEN PehEarnCode = 'SEV' THEN 'E'
                            WHEN PehEarnCode = 'FHOL' THEN 'H'
                            WHEN PehEarnCode = 'FHOLP' THEN 'H'
                            WHEN PehEarnCode = 'HOL' THEN 'H'
                            WHEN PehEarnCode = 'BROPS' THEN 'I'
                            WHEN PehEarnCode = 'GCBNS' THEN 'I'
                            WHEN PehEarnCode = 'INCEN' THEN 'I'
                            WHEN PehEarnCode = 'MIP' THEN 'I'
                            WHEN PehEarnCode = 'BERV' THEN 'N'
                            WHEN PehEarnCode = 'EMGCL' THEN 'N'
                            WHEN PehEarnCode = 'JURY' THEN 'N'
                            WHEN PehEarnCode = 'MILIT' THEN 'N'
                            WHEN PehEarnCode = 'PER' THEN 'N'
                            WHEN PehEarnCode = 'BPASO' THEN 'O'
                            WHEN PehEarnCode = 'BPDBL' THEN 'O'
                            WHEN PehEarnCode = 'BPOT' THEN 'O'
                            WHEN PehEarnCode = 'CDT' THEN 'O'
                            WHEN PehEarnCode = 'COLBK' THEN 'O'
                            WHEN PehEarnCode = 'COT' THEN 'O'
                            WHEN PehEarnCode = 'DBLT' THEN 'O'
                            WHEN PehEarnCode = 'OT' THEN 'O'
                            WHEN PehEarnCode = 'PRCDT' THEN 'O'
                            WHEN PehEarnCode = 'PRCOT' THEN 'O'
                            WHEN PehEarnCode = 'PRJDT' THEN 'O'
                            WHEN PehEarnCode = 'PRJOT' THEN 'O'
                            WHEN PehEarnCode = 'BEEP1' THEN 'R'
                            WHEN PehEarnCode = 'BEEP2' THEN 'R'
                            WHEN PehEarnCode = 'BPASR' THEN 'R'
                            WHEN PehEarnCode = 'BPREG' THEN 'R'
                            WHEN PehEarnCode = 'DRVPY' THEN 'R'
                            WHEN PehEarnCode = 'PRJLD' THEN 'R'
                            WHEN PehEarnCode = 'REG' THEN 'R'
                            WHEN PehEarnCode = 'TRAV' THEN 'R'
                            WHEN PehEarnCode = 'TRVIC' THEN 'R'
                            WHEN PehEarnCode = 'UNITS' THEN 'R'
                            WHEN PehEarnCode = 'RETRO' THEN 'RA'
                            WHEN PehEarnCode = 'SALCN' THEN 'S'
                            WHEN PehEarnCode = 'SICK' THEN 'S'
                            WHEN PehEarnCode = 'VAC' THEN 'V'
                            WHEN PehEarnCode = 'VACCO' THEN 'V'
                            WHEN PehEarnCode = 'VACPO' THEN 'V'
                            WHEN PehEarnCode = 'VACWN' THEN 'V'
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
    ON Paydate.PgpPayGroup =  eecpaygroup
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