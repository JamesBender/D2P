SET NOCOUNT ON;
IF OBJECT_ID('U_EALIJOH401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EALIJOH401_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EALIJOH401_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EALIJOH401' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEALIJOH401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEALIJOH401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EALIJOH401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EALIJOH401];
GO
IF OBJECT_ID('U_EALIJOH401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EALIJOH401_PEarHist];
GO
IF OBJECT_ID('U_EALIJOH401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EALIJOH401_PDedHist];
GO
IF OBJECT_ID('U_EALIJOH401_File') IS NOT NULL DROP TABLE [dbo].[U_EALIJOH401_File];
GO
IF OBJECT_ID('U_EALIJOH401_EEList') IS NOT NULL DROP TABLE [dbo].[U_EALIJOH401_EEList];
GO
IF OBJECT_ID('U_EALIJOH401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EALIJOH401_drvTbl];
GO
IF OBJECT_ID('U_EALIJOH401_DedList') IS NOT NULL DROP TABLE [dbo].[U_EALIJOH401_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EALIJOH401') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EALIJOH401];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EALIJOH401';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EALIJOH401';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EALIJOH401';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EALIJOH401';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EALIJOH401';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EALIJOH401','John Hancock_401K','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EALIJOH401Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EALIJOH401' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Alias"','1','(''DA''=''T,'')','EALIJOH401Z0','6','H','01','1',NULL,'Plan Alias',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll/Company Code"','2','(''DA''=''T,'')','EALIJOH401Z0','4','H','01','2',NULL,'Payroll/Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security #"','3','(''DA''=''T,'')','EALIJOH401Z0','9','H','01','3',NULL,'Social Security #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Name"','4','(''DA''=''T,'')','EALIJOH401Z0','30','H','01','4',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address #1"','5','(''DA''=''T,'')','EALIJOH401Z0','30','H','01','5',NULL,'Address #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address #2"','6','(''DA''=''T,'')','EALIJOH401Z0','30','H','01','6',NULL,'Address #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','7','(''DA''=''T,'')','EALIJOH401Z0','30','H','01','7',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','8','(''DA''=''T,'')','EALIJOH401Z0','2','H','01','8',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Province"','9','(''DA''=''T,'')','EALIJOH401Z0','30','H','01','9',NULL,'Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','10','(''DA''=''T,'')','EALIJOH401Z0','30','H','01','10',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code"','11','(''DA''=''T,'')','EALIJOH401Z0','15','H','01','11',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','12','(''DA''=''T,'')','EALIJOH401Z0','30','H','01','12',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Region"','13','(''DA''=''T,'')','EALIJOH401Z0','30','H','01','13',NULL,'Region',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','14','(''DA''=''T,'')','EALIJOH401Z0','8','H','01','14',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Date of Hire"','15','(''DA''=''T,'')','EALIJOH401Z0','8','H','01','15',NULL,'Original Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Termination"','16','(''DA''=''T,'')','EALIJOH401Z0','8','H','01','16',NULL,'Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Internal Transfer"','17','(''DA''=''T,'')','EALIJOH401Z0','8','H','01','17',NULL,'Date of Internal Transfer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Rehire"','18','(''DA''=''T,'')','EALIJOH401Z0','8','H','01','18',NULL,'Date of Rehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Status"','19','(''DA''=''T,'')','EALIJOH401Z0','4','H','01','19',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','20','(''DA''=''T,'')','EALIJOH401Z0','1','H','01','20',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee/File Number"','21','(''DA''=''T,'')','EALIJOH401Z0','10','H','01','21',NULL,'Employee/File Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll frequency"','22','(''DA''=''T,'')','EALIJOH401Z0','6','H','01','22',NULL,'Payroll frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Excludable Code"','23','(''DA''=''T,'')','EALIJOH401Z0','1','H','01','23',NULL,'Excludable Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Code"','24','(''DA''=''T,'')','EALIJOH401Z0','1','H','01','24',NULL,'Union Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee’s Corporate Email Address"','25','(''DA''=''T,'')','EALIJOH401Z0','60','H','01','25',NULL,'Employee’s Corporate Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee’s Corporate or Home Phone Number"','26','(''DA''=''T,'')','EALIJOH401Z0','10','H','01','26',NULL,'Employee’s Corporate or Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hourly/Salary Code"','27','(''DA''=''T,'')','EALIJOH401Z0','1','H','01','27',NULL,'Hourly/Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours, YTD"','28','(''DA''=''T,'')','EALIJOH401Z0','8','H','01','28',NULL,'Hours, YTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Match Eligibility"','29','(''DA''=''T,'')','EALIJOH401Z0','8','H','01','29',NULL,'Date of Match Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spanish Indicator"','30','(''DA''=''T,'')','EALIJOH401Z0','1','H','01','30',NULL,'Spanish Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total plan year to date plan compensation"','31','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','31',NULL,'Total plan year to date plan compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total period to date plan compensation "','32','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','32',NULL,'Total period to date plan compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total plan year to date gross compensation"','33','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','33',NULL,'Total plan year to date gross compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total period to date gross compensation"','34','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','34',NULL,'Total period to date gross compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total year to date match compensation"','35','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','35',NULL,'Total year to date match compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total period to date match compensation"','36','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','36',NULL,'Total period to date match compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total Managed Account Annualized compensation"','37','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','37',NULL,'Total Managed Account Annualized compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total plan year to date profit sharing compensation"','38','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','38',NULL,'Total plan year to date profit sharing compensatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total period to date 401(k) contributions"','39','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','39',NULL,'Total period to date 401(k) contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total period to date match contributions"','40','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','40',NULL,'Total period to date match contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total period to date profit sharing contributions"','41','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','41',NULL,'Total period to date profit sharing contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total period to date after tax contributions"','42','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','42',NULL,'Total period to date after tax contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total period to date catch-up contributions"','43','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','43',NULL,'Total period to date catch-up contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total period to date Roth 401(k) contributions"','44','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','44',NULL,'Total period to date Roth 401(k) contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total period to date Roth catch up contributions"','45','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','45',NULL,'Total period to date Roth catch up contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Total period to date loan repayments"','46','(''DA''=''T,'')','EALIJOH401Z0','20','H','01','46',NULL,'Total period to date loan repayments (if more than',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Status"','47','(''DA''=''T,'')','EALIJOH401Z0','1','H','01','47',NULL,'Work Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Pay Date"','48','(''DA''=''T,'')','EALIJOH401Z0','8','H','01','48',NULL,'Payroll Pay Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanAlias"','1','(''UA''=''T,'')','EALIJOH401Z0','6','D','10','1',NULL,'drvPlanAlias',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollCompanyCode"','2','(''UA''=''T,'')','EALIJOH401Z0','4','D','10','2',NULL,'drvPayrollCompanyCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T,'')','EALIJOH401Z0','9','D','10','3',NULL,'drvSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvName"','4','(''UA''=''T,'')','EALIJOH401Z0','30','D','10','4',NULL,'drvName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','5','(''UA''=''T,'')','EALIJOH401Z0','30','D','10','5',NULL,'drvAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','6','(''UA''=''T,'')','EALIJOH401Z0','30','D','10','6',NULL,'drvAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','7','(''UA''=''T,'')','EALIJOH401Z0','30','D','10','7',NULL,'drvCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','8','(''UA''=''T,'')','EALIJOH401Z0','2','D','10','8',NULL,'drvState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvince"','9','(''UA''=''T,'')','EALIJOH401Z0','30','D','10','9',NULL,'drvProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','10','(''UA''=''T,'')','EALIJOH401Z0','30','D','10','10',NULL,'drvCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipcode"','11','(''UA''=''T,'')','EALIJOH401Z0','15','D','10','11',NULL,'drvZipcode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','12','(''UA''=''T,'')','EALIJOH401Z0','30','D','10','12',NULL,'drvDivision',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRegion"','13','(''UA''=''T,'')','EALIJOH401Z0','30','D','10','13',NULL,'drvRegion',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','14','(''UDMDY''=''T,'')','EALIJOH401Z0','8','D','10','14',NULL,'drvDateofBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalDateofHire"','15','(''UDMDY''=''T,'')','EALIJOH401Z0','8','D','10','15',NULL,'drvOriginalDateofHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofTermination"','16','(''UDMDY''=''T,'')','EALIJOH401Z0','8','D','10','16',NULL,'drvDateofTermination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofInternalTransfer"','17','(''UDMDY''=''T,'')','EALIJOH401Z0','8','D','10','17',NULL,'drvDateofInternalTransfer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofRehire"','18','(''UDMDY''=''T,'')','EALIJOH401Z0','8','D','10','18',NULL,'drvDateofRehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','19','(''UA''=''T,'')','EALIJOH401Z0','4','D','10','19',NULL,'drvStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','20','(''UA''=''T,'')','EALIJOH401Z0','1','D','10','20',NULL,'drvGender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileNo"','21','(''UA''=''T,'')','EALIJOH401Z0','10','D','10','21',NULL,'drvFileNo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollfrequency"','22','(''UA''=''T,'')','EALIJOH401Z0','6','D','10','22',NULL,'drvPayrollfrequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludableCode"','23','(''UA''=''T,'')','EALIJOH401Z0','1','D','10','23',NULL,'drvExcludableCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionCode"','24','(''UA''=''T,'')','EALIJOH401Z0','1','D','10','24',NULL,'drvUnionCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCorporateEmailAddress"','25','(''UA''=''T,'')','EALIJOH401Z0','60','D','10','25',NULL,'drvCorporateEmailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCorporateHomePhoneNumber"','26','(''UA''=''T,'')','EALIJOH401Z0','10','D','10','26',NULL,'drvCorporateHomePhoneNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlyCode"','27','(''UA''=''T,'')','EALIJOH401Z0','1','D','10','27',NULL,'drvHourlyCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHours"','28','(''UA''=''T,'')','EALIJOH401Z0','8','D','10','28',NULL,'drvHours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofMatchEligibility"','29','(''UDMDY''=''T,'')','EALIJOH401Z0','8','D','10','29',NULL,'drvDateofMatchEligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpanishIndicator"','30','(''UA''=''T,'')','EALIJOH401Z0','1','D','10','30',NULL,'drvSpanishIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalYTDplanComp"','31','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','31',NULL,'drvTotalYTDplanComp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalPTDplanComp"','32','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','32',NULL,'drvTotalPTDplanComp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalYTDgrossComp"','33','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','33',NULL,'drvTotalYTDgrossComp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalPTDgrossComp"','34','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','34',NULL,'drvTotalPTDgrossComp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalyeartodatematchcompensation"','35','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','35',NULL,'drvTotalyeartodatematchcompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalperiodtodatematchcompensation"','36','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','36',NULL,'drvTotalperiodtodatematchcompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalManagedAccountAnnualizedcompensation"','37','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','37',NULL,'drvTotalManagedAccountAnnualizedcompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalplanyeartodateprofitsharingcompensation"','38','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','38',NULL,'drvTotalplanyeartodateprofitsharingcompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalperiodtodate401kcontributions"','39','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','39',NULL,'drvTotalperiodtodate401kcontributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalperiodtodatematchcontributions"','40','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','40',NULL,'drvTotalperiodtodatematchcontributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalperiodtodateprofitsharingcontributions"','41','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','41',NULL,'drvTotalperiodtodateprofitsharingcontributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalperiodtodateaftertaxcontributions"','42','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','42',NULL,'drvTotalperiodtodateaftertaxcontributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalperiodtodatecatchupcontributions"','43','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','43',NULL,'drvTotalperiodtodatecatchupcontributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalperiodtodateRoth401kcontributions"','44','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','44',NULL,'drvTotalperiodtodateRoth401kcontributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalperiodtodateRothcatchupcontributions"','45','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','45',NULL,'drvTotalperiodtodateRothcatchupcontributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalLoans"','46','(''UA''=''T,'')','EALIJOH401Z0','20','D','10','46',NULL,'drvTotalLoans',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStatus"','47','(''UA''=''T,'')','EALIJOH401Z0','1','D','10','47',NULL,'drvWorkStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollPayDate"','48','(''UDMDY''=''T'')','EALIJOH401Z0','8','D','10','48',NULL,'drvPayrollPayDate',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EALIJOH401_20210626.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'John Hancock_401K','202106239','EMPEXPORT','ONDEM_XOE',NULL,'EALIJOH401',NULL,NULL,NULL,'202106239','Jun 23 2021  3:02PM','Jun 23 2021  3:02PM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'John Hancock_401K-Sched','202106239','EMPEXPORT','SCH_EALIJO',NULL,'EALIJOH401',NULL,NULL,NULL,'202106239','Jun 23 2021  3:02PM','Jun 23 2021  3:02PM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','EK30E,EJZ2T',NULL,NULL,NULL,'John Hancock_401K-Test','202106159','EMPEXPORT','TEST_XOE','Jun 25 2021  9:08AM','EALIJOH401',NULL,NULL,NULL,'202106159','Jun 15 2021 12:00AM','Dec 30 1899 12:00AM','202106151','256','eecPayGroup','SEMIMO','202106151',dbo.fn_GetTimedKey(),NULL,'us3cPeALI1002',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALIJOH401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALIJOH401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALIJOH401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALIJOH401','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALIJOH401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALIJOH401','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EALIJOH401' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EALIJOH401' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EALIJOH401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EALIJOH401_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALIJOH401','H01','NONE','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALIJOH401','D10','dbo.U_EALIJOH401_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EALIJOH401') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EALIJOH401] (
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
IF OBJECT_ID('U_EALIJOH401_DedList') IS NULL
CREATE TABLE [dbo].[U_EALIJOH401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EALIJOH401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EALIJOH401_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPlanAlias] varchar(6) NOT NULL,
    [drvPayrollCompanyCode] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvName] nvarchar(258) NULL,
    [drvAddress1] varchar(6000) NULL,
    [drvAddress2] varchar(6000) NULL,
    [drvCity] nvarchar(258) NULL,
    [drvState] varchar(255) NULL,
    [drvProvince] varchar(1) NOT NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvZipcode] varchar(50) NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvRegion] varchar(1) NOT NULL,
    [drvDateofBirth] datetime NULL,
    [drvOriginalDateofHire] datetime NULL,
    [drvDateofTermination] datetime NULL,
    [drvDateofInternalTransfer] varchar(1) NOT NULL,
    [drvDateofRehire] datetime NULL,
    [drvStatus] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvFileNo] char(9) NULL,
    [drvPayrollfrequency] char(1) NULL,
    [drvExcludableCode] varchar(1) NULL,
    [drvUnionCode] varchar(1) NOT NULL,
    [drvCorporateEmailAddress] varchar(50) NULL,
    [drvCorporateHomePhoneNumber] varchar(50) NULL,
    [drvHourlyCode] varchar(1) NULL,
    [drvHours] varchar(30) NULL,
    [drvDateofMatchEligibility] varchar(1) NOT NULL,
    [drvSpanishIndicator] varchar(1) NOT NULL,
    [drvTotalYTDplanComp] varchar(30) NULL,
    [drvTotalPTDplanComp] varchar(30) NULL,
    [drvTotalYTDgrossComp] varchar(30) NULL,
    [drvTotalPTDgrossComp] varchar(30) NULL,
    [drvTotalyeartodatematchcompensation] varchar(1) NOT NULL,
    [drvTotalperiodtodatematchcompensation] varchar(1) NOT NULL,
    [drvTotalManagedAccountAnnualizedcompensation] varchar(30) NULL,
    [drvTotalplanyeartodateprofitsharingcompensation] varchar(1) NOT NULL,
    [drvTotalperiodtodate401kcontributions] varchar(30) NULL,
    [drvTotalperiodtodatematchcontributions] varchar(30) NULL,
    [drvTotalperiodtodateprofitsharingcontributions] varchar(1) NOT NULL,
    [drvTotalperiodtodateaftertaxcontributions] varchar(1) NOT NULL,
    [drvTotalperiodtodatecatchupcontributions] varchar(1) NOT NULL,
    [drvTotalperiodtodateRoth401kcontributions] varchar(30) NULL,
    [drvTotalperiodtodateRothcatchupcontributions] varchar(1) NOT NULL,
    [drvTotalLoans] varchar(30) NULL,
    [drvWorkStatus] varchar(1) NOT NULL,
    [drvPayrollPayDate] datetime NULL
);
IF OBJECT_ID('U_EALIJOH401_EEList') IS NULL
CREATE TABLE [dbo].[U_EALIJOH401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EALIJOH401_File') IS NULL
CREATE TABLE [dbo].[U_EALIJOH401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EALIJOH401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EALIJOH401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401K] numeric NULL,
    [Pdh401ER] numeric NULL,
    [PdhRoth] numeric NULL,
    [PdhLoan] numeric NULL
);
IF OBJECT_ID('U_EALIJOH401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EALIJOH401_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EALIJOH401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: A-Lign

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 06/23/2021
Service Request Number: TekP-2021-05-07-0001

Purpose: John Hancock_401K

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EALIJOH401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EALIJOH401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EALIJOH401';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EALIJOH401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EALIJOH401' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALIJOH401', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALIJOH401', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALIJOH401', 'SCH_EALIJO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EALIJOH401';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EALIJOH401', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EALIJOH401';

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
    DELETE FROM dbo.U_EALIJOH401_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EALIJOH401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401F,401P,401ER,ROTFA,ROTHP,401L, 401L2,401L3';

    IF OBJECT_ID('U_EALIJOH401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EALIJOH401_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EALIJOH401_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EALIJOH401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EALIJOH401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh401K     = SUM(CASE WHEN PdhDedCode IN ('401F','401P') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401ER     = SUM(CASE WHEN PdhDedCode IN ('401ER') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhRoth    = SUM(CASE WHEN PdhDedCode IN ('ROTFA', 'ROTHP') THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhLoan     = SUM(CASE WHEN PdhDedCode IN ('401L', '401L2', '401L3') THEN PdhEECurAmt ELSE 0.00 END)

    INTO dbo.U_EALIJOH401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EALIJOH401_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EALIJOH401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EALIJOH401_PEarHist;
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

    INTO dbo.U_EALIJOH401_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EALIJOH401_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EALIJOH401_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EALIJOH401_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvPlanAlias = 'AL3502'
        ,drvPayrollCompanyCode = ''
        ,drvSSN = eepSSN
        ,drvName = QuoteName(eepNameLast + ',' + eepNameFirst + ' ' + Left( isnull(eepnameMiddle,''),1), '"')
        ,drvAddress1 = dbo.dsi_fnRemoveChars(',', EepAddressLine1 )
        ,drvAddress2 =  dbo.dsi_fnRemoveChars(',', EepAddressLine2 )
        ,drvCity = QuoteName(EepAddressCity,'"')
        ,drvState = EepAddressState
        ,drvProvince = ''
        ,drvCountry = ''
        ,drvZipcode = EepAddressZipCode
        ,drvDivision = ''
        ,drvRegion = ''
        ,drvDateofBirth = EepDateOfBirth
        ,drvOriginalDateofHire = EecDateOfOriginalHire
        ,drvDateofTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDateofInternalTransfer = ''
        ,drvDateofRehire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvStatus = CASE WHEN EecEmplStatus = 'T' and eectermreason = '203' THEN 'D'
                           WHEN EecEmplStatus = 'T' and eectermreason <> '203' THEN 'T'    
                          WHEN EecEmplStatus = 'A' THEN 'A'
                          WHEN EecEmplStatus = 'L' THEN 'L'
                     END
        ,drvGender = EepGender
        ,drvFileNo = eecEmpNo
        ,drvPayrollfrequency = eecPayPeriod
        ,drvExcludableCode = CASE WHEN eecDedGroupcode in ('PART','NONE') THEN 'X' END
        ,drvUnionCode = ''
        ,drvCorporateEmailAddress = EepAddressEMail
        ,drvCorporateHomePhoneNumber = EepPhoneHomeNumber
        ,drvHourlyCode = CASE WHEN EecSalaryOrHourly = 'S' THEN 'S'
                             WHEN EecSalaryOrHourly = 'H' THEN 'H'
                         END
        ,drvHours = CAST(CONVERT(DECIMAL(10,0),PehInclInDefCompHrsYTD) as varchar)
        ,drvDateofMatchEligibility = ''
        ,drvSpanishIndicator = ''
        ,drvTotalYTDplanComp = CAST(CONVERT(DECIMAL(10,2),PehInclInDefCompYTD) as varchar)
        ,drvTotalPTDplanComp = CAST(CONVERT(DECIMAL(10,2),PehInclInDefComp) as varchar)
        ,drvTotalYTDgrossComp = CAST(CONVERT(DECIMAL(10,2),PehCurAmtYTD) as varchar)
        ,drvTotalPTDgrossComp = CAST(CONVERT(DECIMAL(10,2),PehCurAmt) as varchar)
        ,drvTotalyeartodatematchcompensation = ''
        ,drvTotalperiodtodatematchcompensation = ''
        ,drvTotalManagedAccountAnnualizedcompensation = CAST(CONVERT(DECIMAL(10,2),Eecannsalary) as varchar)
        ,drvTotalplanyeartodateprofitsharingcompensation = ''
        ,drvTotalperiodtodate401kcontributions = CAST(CONVERT(DECIMAL(10,2),Pdh401K) as varchar)
        ,drvTotalperiodtodatematchcontributions = CAST(CONVERT(DECIMAL(10,2),Pdh401ER) as varchar)
        ,drvTotalperiodtodateprofitsharingcontributions = ''
        ,drvTotalperiodtodateaftertaxcontributions = ''
        ,drvTotalperiodtodatecatchupcontributions = ''
        ,drvTotalperiodtodateRoth401kcontributions = CAST(CONVERT(DECIMAL(10,2),PdhRoth) as varchar)
        ,drvTotalperiodtodateRothcatchupcontributions = ''
        ,drvTotalLoans = CAST(CONVERT(DECIMAL(10,2),PdhLoan) as varchar)
        ,drvWorkStatus = CASE WHEN EecFullTimeOrPartTime  = 'F' THEN 'F' ELSE 'P' END
        ,drvPayrollPayDate = CAST(PayDate as datetime)
    INTO dbo.U_EALIJOH401_drvTbl
    FROM dbo.U_EALIJOH401_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EALIJOH401_PEarHist WITH (NOLOCK)
        ON PehEEID =  xEEID
    JOIN dbo.U_EALIJOH401_PDedHist WITH (NOLOCK)
        ON PdhEEID =  xEEID
    JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as Paydate on eecpaygroup = PgpPayGroup
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
ALTER VIEW dbo.dsi_vwEALIJOH401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EALIJOH401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EALIJOH401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106161'
       ,expStartPerControl     = '202106161'
       ,expLastEndPerControl   = '202106239'
       ,expEndPerControl       = '202106239'
WHERE expFormatCode = 'EALIJOH401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEALIJOH401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EALIJOH401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort