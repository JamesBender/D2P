SET NOCOUNT ON;
IF OBJECT_ID('U_ESWELBPEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESWELBPEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESWELBPEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESWELBPEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESWELBPEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESWELBPEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESWELBPEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESWELBPEXP];
GO
IF OBJECT_ID('U_ESWELBPEXP_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_ESWELBPEXP_PTaxHist];
GO
IF OBJECT_ID('U_ESWELBPEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESWELBPEXP_PEarHist];
GO
IF OBJECT_ID('U_ESWELBPEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESWELBPEXP_PDedHist];
GO
IF OBJECT_ID('U_ESWELBPEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ESWELBPEXP_File];
GO
IF OBJECT_ID('U_ESWELBPEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESWELBPEXP_EEList];
GO
IF OBJECT_ID('U_ESWELBPEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESWELBPEXP_drvTbl];
GO
IF OBJECT_ID('U_ESWELBPEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESWELBPEXP_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESWELBPEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESWELBPEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESWELBPEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESWELBPEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESWELBPEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESWELBPEXP','Shareworks Eligibility Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ESWELBPEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','1','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','1',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','2','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','2',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','3','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','4','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','4',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Title"','5','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','5',NULL,'Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Street"','6','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','6',NULL,'Home Street',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Suite"','7','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','7',NULL,'Home Suite',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home City"','8','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','8',NULL,'Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home State/Province"','9','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','9',NULL,'Home State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Country"','10','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','10',NULL,'Home Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Postal Code"','11','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','11',NULL,'Home Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Company Managed Cell Phone"','12','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','12',NULL,'Company Managed Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Company Email"','13','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','13',NULL,'Company Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','14','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','14',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SIN"','15','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','15',NULL,'SIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GIN"','16','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','16',NULL,'GIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','17','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','17',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date"','18','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','18',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Retirement Eligibility Date"','19','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','19',NULL,'Retirement Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Status"','20','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','20',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Status Effective Date"','21','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','21',NULL,'Employee Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Status"','22','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','22',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Status Effective Date"','23','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','23',NULL,'Employee Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location"','24','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','24',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department"','25','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','25',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Insider (for blackout and reporting population)"','26','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','26',NULL,'Insider (for blackout and reporting population)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pre-Clearance"','27','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','27',NULL,'Pre-Clearance',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Withholding Exempt"','28','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','28',NULL,'Withholding Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FICA Social Security - Release"','29','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','29',NULL,'FICA Social Security - Release',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SDI - Release"','30','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','30',NULL,'SDI - Release',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Federal - Release"','31','(''DA''=''T,'')','ESWELBPEXPZ0','50','H','01','31',NULL,'Federal - Release',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Income YTD - Release"','32','(''DA''=''T'')','ESWELBPEXPZ0','50','H','01','32',NULL,'Income YTD - Release',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','1','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','1',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','2','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','2',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','3','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','4','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','4',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTitle"','5','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','5',NULL,'Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeStreetAdress"','6','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','6',NULL,'Home Street',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuite"','7','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','7',NULL,'Home Suite',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','8','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','8',NULL,'Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','9','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','9',NULL,'Home State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','10','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','10',NULL,'Home Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','11','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','11',NULL,'Home Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyCellPhone"','12','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','12',NULL,'Company Managed Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyEmail"','13','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','13',NULL,'Company Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','14','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','14',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drbSIN"','15','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','15',NULL,'SIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGIN"','16','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','16',NULL,'GIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','17','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','17',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','18','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','18',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRetirementEligDate"','19','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','19',NULL,'Retirement Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','20','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','20',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatuEffDate"','21','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','21',NULL,'Employee Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmStatus2"','22','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','22',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatusEffDate2"','23','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','23',NULL,'Employee Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','24','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','24',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartment"','25','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','25',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsiderBlackOut"','26','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','26',NULL,'Insider (for blackout and reporting population)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreClearance"','27','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','27',NULL,'Pre-Clearance',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWitholdingExempt"','28','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','28',NULL,'Withholding Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFICASSrelease"','29','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','29',NULL,'FICA Social Security - Release',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSDIRelease"','30','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','30',NULL,'SDI - Release',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFedRelease"','31','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','31',NULL,'Federal - Release',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drIncomeYTDRelease"','32','(''UA''=''T,'')','ESWELBPEXPZ0','50','D','10','32',NULL,'Income YTD - Release',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESWELBPEXP_20200221.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ShareWorks Eligibility Export','202001279','EMPEXPORT','ONDEMAND',NULL,'ESWELBPEXP',NULL,NULL,NULL,'202001279','Jan 27 2020  3:32PM','Jan 27 2020  3:32PM','202001271',NULL,'','','202001271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESWELBPEXP_20200221.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202001279','EMPEXPORT','SCHEDULED',NULL,'ESWELBPEXP',NULL,NULL,NULL,'202001279','Jan 27 2020  3:32PM','Jan 27 2020  3:32PM','202001271',NULL,'','','202001271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESWELBPEXP_20200221.txt',NULL,'','','DPIEL',NULL,NULL,NULL,'Test Purposes Only','202002211','EMPEXPORT','TEST','Feb 17 2020  5:08PM','ESWELBPEXP',NULL,NULL,NULL,'202002211','Feb 21 2020 12:00AM','Feb 14 2020 12:00AM','202002031','366','','','202002031',dbo.fn_GetTimedKey(),NULL,'us3mLaBER1020',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ESWELBPEXP_20200221.txt' END WHERE expFormatCode = 'ESWELBPEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWELBPEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWELBPEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWELBPEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWELBPEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWELBPEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWELBPEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ESWELBPEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESWELBPEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ESWELBPEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESWELBPEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESWELBPEXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESWELBPEXP','D10','dbo.U_ESWELBPEXP_drvTbl',NULL);
IF OBJECT_ID('U_ESWELBPEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ESWELBPEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESWELBPEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESWELBPEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvTitle] varchar(1) NOT NULL,
    [drvHomeStreetAdress] varchar(255) NULL,
    [drvSuite] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvCountry] varchar(2) NOT NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCompanyCellPhone] varchar(1) NOT NULL,
    [drvCompanyEmail] varchar(50) NULL,
    [drvSSN] char(11) NULL,
    [drbSIN] varchar(1) NOT NULL,
    [drvGIN] varchar(1) NOT NULL,
    [drvDateofBirth] varchar(11) NULL,
    [drvHireDate] varchar(11) NULL,
    [drvRetirementEligDate] varchar(1) NOT NULL,
    [drvEmployeeStatus] varchar(11) NULL,
    [drvEmpStatuEffDate] varchar(11) NULL,
    [drvEmStatus2] varchar(11) NULL,
    [drvEmpStatusEffDate2] varchar(11) NULL,
    [drvLocation] varchar(25) NULL,
    [drvDepartment] varchar(25) NULL,
    [drvInsiderBlackOut] varchar(1) NOT NULL,
    [drvPreClearance] varchar(1) NOT NULL,
    [drvWitholdingExempt] varchar(1) NOT NULL,
    [drvFICASSrelease] varchar(12) NULL,
    [drvSDIRelease] varchar(12) NULL,
    [drvFedRelease] varchar(12) NULL,
    [drIncomeYTDRelease] varchar(12) NULL
);
IF OBJECT_ID('U_ESWELBPEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ESWELBPEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESWELBPEXP_File') IS NULL
CREATE TABLE [dbo].[U_ESWELBPEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ESWELBPEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESWELBPEXP_PDedHist] (
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
IF OBJECT_ID('U_ESWELBPEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESWELBPEXP_PEarHist] (
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
IF OBJECT_ID('U_ESWELBPEXP_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_ESWELBPEXP_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthGrossWagesYTD] money NULL,
    [PthCurSuppTaxableWagesYTD] money NULL,
    [PthCurTaxAmtYTD] money NULL,
    [PthCurTaxAmtSDIYTD] money NULL,
    [PthCurTaxAmtFedYTD] money NULL,
    [PthCurTaxAmtMedYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESWELBPEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Berry Petroleum

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 01/27/2020
Service Request Number: SR-2019-00223916

Purpose: 

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESWELBPEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESWELBPEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESWELBPEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESWELBPEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESWELBPEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESWELBPEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESWELBPEXP', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESWELBPEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESWELBPEXP';

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
    DELETE FROM dbo.U_ESWELBPEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID not IN (Select eeceeid from empcomp where EECUDFIELD14 = 'Yes');

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_ESWELBPEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESWELBPEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESWELBPEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ESWELBPEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESWELBPEXP_PDedHist;
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
    INTO dbo.U_ESWELBPEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESWELBPEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ESWELBPEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESWELBPEXP_PEarHist;
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
    INTO dbo.U_ESWELBPEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    -- Working Table - PTaxHist
    -----------------------------
    IF OBJECT_ID('U_ESWELBPEXP_PTaxHist') IS NOT NULL
        DROP TABLE dbo.U_ESWELBPEXP_PTaxHist;
    SELECT DISTINCT
         PthEEID
        ,PthGrossWagesYTD    = SUM(PthCurGrossWages)  
        ,PthCurSuppTaxableWagesYTD        =  SUM(PthCurSuppTaxableWages)
        ,PthCurTaxAmtYTD =   SUM(CASE WHEN PthTaxCode = 'USSOCEE' THEN PthCurTaxAmt END) 
        ,PthCurTaxAmtSDIYTD =   SUM(CASE WHEN PthTaxCode like '%SDI%' THEN PthCurTaxAmt END) 
        ,PthCurTaxAmtFedYTD =   SUM(CASE WHEN PthTaxCode IN ('USFIT') THEN PthCurSuppTaxableWages END) 
        ,PthCurTaxAmtMedYTD =   SUM(CASE WHEN PthTaxCode IN ('USMEDEE') THEN PthCurTaxableWages END) 
    INTO dbo.U_ESWELBPEXP_PTaxHist
    FROM dbo.PTaxHist WITH (NOLOCK)
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
     and PthPerControl <= @EndPerControl
    GROUP BY PthEEID
    HAVING SUM(PthCurGrossWages) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESWELBPEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESWELBPEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESWELBPEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeNumber = eecEmpNo
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(Isnull(EepNameMiddle,''),1)
        ,drvTitle = ''
        ,drvHomeStreetAdress = eepAddressLine1
        ,drvSuite = eepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvCountry = 'US'
        ,drvPostalCode = EepAddressZipCode
        ,drvCompanyCellPhone = ''
        ,drvCompanyEmail = EepAddressEMail
        ,drvSSN = eepSSN
        ,drbSIN = ''
        ,drvGIN = ''
        ,drvDateofBirth = convert(varchar(11), EepDateOfBirth, 106) 
        ,drvHireDate = convert(varchar(11), EecDateOfLastHire, 106)  
        ,drvRetirementEligDate = ''
        ,drvEmployeeStatus = CASE WHEN eecEmplStatus = 'T' THEN
                                    CASE WHEN eectermReason = '202' THEN 'Retirement'
                                         WHEN eectermReason = '105' THEN 'Disability'
                                         WHEN eectermReason not in  ('105','202','203') and eecTermType = 'V' THEN 'Voluntary'
                                         WHEN eectermReason not in  ('105','202','203') and eecTermType = 'I' THEN 'Involuntary'
                                    END
                                 ELSE 'Active'
                             END
        ,drvEmpStatuEffDate = CASE WHEN  eecemplstatus = 'T' THEN convert(varchar(11), eecdateoftermination, 106) else  convert(varchar(11), eecdateoflasthire, 106)  END
        ,drvEmStatus2 = CASE WHEN eecEmplStatus = 'T' THEN
                                    CASE WHEN eectermReason = '202' THEN 'Retirement'
                                         WHEN eectermReason = '105' THEN 'Disability'
                                         WHEN eectermReason not in  ('105','202','203') and eecTermType = 'V' THEN 'Voluntary'
                                         WHEN eectermReason not in  ('105','202','203') and eecTermType = 'I' THEN 'Involuntary'
                                    END
                                 ELSE 'Active'
                             END
        ,drvEmpStatusEffDate2 = CASE WHEN  eecemplstatus = 'T' THEN convert(varchar(11), eecdateoftermination, 106) else  convert(varchar(11), eecdateoflasthire, 106)  END
        ,drvLocation = (select top 1 LocDesc  from  Location where LocCode = EecLocation)
        ,drvDepartment = (Select top 1 OrgDesc from OrgLevel where OrgCode = EecOrgLvl1)
        ,drvInsiderBlackOut = ''
        ,drvPreClearance = ''
        ,drvWitholdingExempt = ''
        ,drvFICASSrelease = CAST(CONVERT(DECIMAL(10,2),PthCurTaxAmtYTD) as varchar(12))
        ,drvSDIRelease =  CAST(Convert(DECIMAL(10,2),PthCurTaxAmtSDIYTD) as varchar(12)) 
        ,drvFedRelease =  CAST(Convert(Decimal(10,2),PthCurTaxAmtFedYTD) as varchar(12)) 
        ,drIncomeYTDRelease =  CAST(Convert(Decimal(10,2),PthCurTaxAmtMedYTD) as varchar(12)) 
    INTO dbo.U_ESWELBPEXP_drvTbl
    FROM dbo.U_ESWELBPEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN  dbo.U_ESWELBPEXP_PTaxHist WITH (NOLOCK)
      ON  PthEEID =  XEEID
    ;

    --Updat Date format to dd-MMM-yyyy
    Update  U_ESWELBPEXP_drvTbl set drvDateofBirth = replace(drvDateofBirth,' ','-'), drvHireDate = replace(drvHireDate,' ','-'),drvEmpStatuEffDate = replace(drvEmpStatuEffDate,' ','-'),drvEmpStatusEffDate2 = replace(drvEmpStatusEffDate2,' ','-')

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
ALTER VIEW dbo.dsi_vwESWELBPEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESWELBPEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESWELBPEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001201'
       ,expStartPerControl     = '202001201'
       ,expLastEndPerControl   = '202001279'
       ,expEndPerControl       = '202001279'
WHERE expFormatCode = 'ESWELBPEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESWELBPEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESWELBPEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort