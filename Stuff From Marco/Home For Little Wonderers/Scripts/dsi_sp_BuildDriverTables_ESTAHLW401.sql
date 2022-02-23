SET NOCOUNT ON;
IF OBJECT_ID('U_ESTAHLW401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTAHLW401_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESTAHLW401_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESTAHLW401' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESTAHLW401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESTAHLW401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESTAHLW401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTAHLW401];
GO
IF OBJECT_ID('U_ESTAHLW401_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_ESTAHLW401_PTaxHist];
GO
IF OBJECT_ID('U_ESTAHLW401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESTAHLW401_PEarHist];
GO
IF OBJECT_ID('U_ESTAHLW401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESTAHLW401_PDedHist];
GO
IF OBJECT_ID('U_ESTAHLW401_File') IS NOT NULL DROP TABLE [dbo].[U_ESTAHLW401_File];
GO
IF OBJECT_ID('U_ESTAHLW401_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESTAHLW401_EEList];
GO
IF OBJECT_ID('U_ESTAHLW401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTAHLW401_drvTbl];
GO
IF OBJECT_ID('U_ESTAHLW401_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESTAHLW401_DedList];
GO
IF OBJECT_ID('U_ESTAHLW401_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESTAHLW401_AuditFields];
GO
IF OBJECT_ID('U_ESTAHLW401_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESTAHLW401_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ESTAHLW401') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESTAHLW401];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESTAHLW401';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESTAHLW401';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESTAHLW401';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESTAHLW401';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESTAHLW401';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESTAHLW401','Standard 403b Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ESTAHLW401Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN "','1','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST NAME "','2','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','2',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST NAME MI "','3','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','3',NULL,'FIRST NAME MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','4','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','4',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOH "','5','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','5',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOT "','6','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','6',NULL,'DOT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ANNUAL SALARY "','7','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','7',NULL,'ANNUAL SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOURS"','8','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','8',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TOTAL COMP"','9','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','9',NULL,'TOTAL COMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ELIGIBLE COMP"','10','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','10',NULL,'ELIGIBLE COMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NON-REGULAR COMP "','11','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','11',NULL,'NON-REGULAR COMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE PRE-TAX CONTRIBUTION "','12','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','12',NULL,'EMPLOYEE PRE-TAX CONTRIBUTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ROTH 401(K) CONTRIBUTION "','13','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','13',NULL,'ROTH 401(K) CONTRIBUTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER EMPLOYEE CONTRIBUTIONS "','14','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','14',NULL,'OTHER EMPLOYEE CONTRIBUTIONS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYER MATCH CONTRIBUTIONS "','15','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','15',NULL,'EMPLOYER MATCH CONTRIBUTIONS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAFE HARBOR CONTRIBUTIONS "','16','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','16',NULL,'SAFE HARBOR CONTRIBUTIONS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER EMPLOYER CONTRIBUTIONS "','17','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','17',NULL,'OTHER EMPLOYER CONTRIBUTIONS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOAN PAYMENT "','18','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','18',NULL,'LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAYROLL FREQUENCY "','19','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','19',NULL,'PAYROLL FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONTRIBUTION RATE PRE-TAX "','20','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','20',NULL,'CONTRIBUTION RATE PRE-TAX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONTRIBUTION FLAT DOLLAR"','21','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','21',NULL,'CONTRIBUTION FLAT DOLLAR PRE-TAX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONTRIBUTION RATE ROTH "','22','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','22',NULL,'CONTRIBUTION RATE ROTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONTRIBUTION FLAT DOLLAR"','23','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','23',NULL,'CONTRIBUTION FLAT DOLLAR ROTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LANGUAGE "','24','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','24',NULL,'LANGUAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER "','25','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','25',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EXCLUDED EMPLOYEES "','26','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','26',NULL,'EXCLUDED EMPLOYEES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION CODE "','27','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','27',NULL,'DIVISION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STREET ADDRESS 1 "','28','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','28',NULL,'STREET ADDRESS 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STREET ADDRESS 2 "','29','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','29',NULL,'STREET ADDRESS 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CITY "','30','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','30',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STATE "','31','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','31',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZIP CODE "','32','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','32',NULL,'ZIP CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMAIL ADDRESS "','33','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','33',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAY DATE "','34','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','34',NULL,'PAY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAYROLL BEGIN DATE "','35','(''DA''=''T,'')','ESTAHLW401Z0','50','H','01','35',NULL,'PAYROLL BEGIN DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAYROLL END DATE "','36','(''DA''=''T'')','ESTAHLW401Z0','50','H','01','36',NULL,'PAYROLL END DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','2','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','2',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstNameMI"','3','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','3',NULL,'FIRST NAME MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','4','(''UD101''=''T,'')','ESTAHLW401Z0','50','D','10','4',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOH"','5','(''UD101''=''T,'')','ESTAHLW401Z0','50','D','10','5',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOT"','6','(''UD101''=''T,'')','ESTAHLW401Z0','50','D','10','6',NULL,'DOT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnSalary"','7','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','7',NULL,'ANNUAL SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHours"','8','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','8',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalComp"','9','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','9',NULL,'TOTAL COMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligComp"','10','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','10',NULL,'ELIGIBLE COMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNonRegComp"','11','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','11',NULL,'NON-REGULAR COMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEPReTaxCont"','12','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','12',NULL,'EMPLOYEE PRE-TAX CONTRIBUTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRoth401K"','13','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','13',NULL,'ROTH 401(K) CONTRIBUTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOtherEmpContrib"','14','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','14',NULL,'OTHER EMPLOYEE CONTRIBUTIONS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMatchContrib"','15','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','15',NULL,'EMPLOYER MATCH CONTRIBUTIONS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSafeHarCont"','16','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','16',NULL,'SAFE HARBOR CONTRIBUTIONS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOthERContrib"','17','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','17',NULL,'OTHER EMPLOYER CONTRIBUTIONS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment"','18','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','18',NULL,'LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFreq"','19','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','19',NULL,'PAYROLL FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrRatePreTax"','20','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','20',NULL,'CONTRIBUTION RATE PRE-TAX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOnFlatDollarPreTax"','21','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','21',NULL,'CONTRIBUTION FLAT DOLLAR PRE-TAX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContRateRoth"','22','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','22',NULL,'CONTRIBUTION RATE ROTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContFlatRateRoth"','23','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','23',NULL,'CONTRIBUTION FLAT DOLLAR ROTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguage"','24','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','24',NULL,'LANGUAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','25','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','25',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludedEmp"','26','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','26',NULL,'EXCLUDED EMPLOYEES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','27','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','27',NULL,'DIVISION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','28','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','28',NULL,'STREET ADDRESS 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','29','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','29',NULL,'STREET ADDRESS 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','30','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','30',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','31','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','31',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','32','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','32',NULL,'ZIP CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','33','(''UA''=''T,'')','ESTAHLW401Z0','50','D','10','33',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayDate"','34','(''UD101''=''T,'')','ESTAHLW401Z0','50','D','10','34',NULL,'PAY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollBeginDate"','35','(''UD101''=''T,'')','ESTAHLW401Z0','50','D','10','35',NULL,'PAYROLL BEGIN DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollEndDate"','36','(''UD101''=''T'')','ESTAHLW401Z0','50','D','10','36',NULL,'PAYROLL END DATE',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTAHLW401_20200717.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202004159','EMPEXPORT','SCH_STA',NULL,'ESTAHLW401',NULL,NULL,NULL,'202004159','Apr 15 2020  4:51PM','Apr 15 2020  4:51PM','202004151',NULL,'','','202004151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTAHLW401_20200717.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Standard 401k Export','202004159','EMPEXPORT','ONDEMAND','Apr 17 2020 12:00AM','ESTAHLW401',NULL,NULL,NULL,'202004159','Apr 15 2020 12:00AM','Dec 30 1899 12:00AM','202004031',NULL,'','','202004031',dbo.fn_GetTimedKey(),NULL,'us3mLaHOM1009',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTAHLW401_20200717.txt',NULL,'','','IAGFG',NULL,NULL,NULL,'Test Purposes Only','202007171','EMPEXPORT','TEST','Jul 17 2020 10:57AM','ESTAHLW401',NULL,NULL,NULL,'202007171','Jul 17 2020 12:00AM','Jul 12 2020 12:00AM','202007171','730','eecPayGroup','BIWKLY','202007171',dbo.fn_GetTimedKey(),NULL,'us3mLaHOM1009',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ESTAHLW401_20200717.txt' END WHERE expFormatCode = 'ESTAHLW401';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAHLW401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAHLW401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAHLW401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAHLW401','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAHLW401','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAHLW401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAHLW401','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ESTAHLW401' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESTAHLW401' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ESTAHLW401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTAHLW401_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAHLW401','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAHLW401','D10','dbo.U_ESTAHLW401_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ESTAHLW401') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESTAHLW401] (
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
IF OBJECT_ID('U_ESTAHLW401_Audit') IS NULL
CREATE TABLE [dbo].[U_ESTAHLW401_Audit] (
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
IF OBJECT_ID('U_ESTAHLW401_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESTAHLW401_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ESTAHLW401_DedList') IS NULL
CREATE TABLE [dbo].[U_ESTAHLW401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESTAHLW401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTAHLW401_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstNameMI] nvarchar(258) NULL,
    [drvDOB] datetime NULL,
    [drvDOH] datetime NULL,
    [drvDOT] datetime NULL,
    [drvAnnSalary] varchar(12) NULL,
    [drvHours] varchar(12) NULL,
    [drvTotalComp] varchar(12) NULL,
    [drvEligComp] varchar(12) NULL,
    [drvNonRegComp] varchar(12) NULL,
    [drvEPReTaxCont] varchar(12) NULL,
    [drvRoth401K] varchar(12) NULL,
    [drvOtherEmpContrib] varchar(1) NOT NULL,
    [drvEmpMatchContrib] varchar(12) NULL,
    [drvSafeHarCont] varchar(1) NOT NULL,
    [drvOthERContrib] varchar(1) NOT NULL,
    [drvLoanPayment] varchar(12) NULL,
    [drvPayrollFreq] char(1) NULL,
    [drvContrRatePreTax] varchar(12) NULL,
    [drvCOnFlatDollarPreTax] varchar(1) NOT NULL,
    [drvContRateRoth] varchar(12) NULL,
    [drvContFlatRateRoth] varchar(1) NOT NULL,
    [drvLanguage] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvExcludedEmpBefore] varchar(1) NULL,
    [drvExcludedEmp] varchar(1) NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvAddressLine1] nvarchar(258) NULL,
    [drvAddressLine2] nvarchar(258) NULL,
    [drvCity] nvarchar(258) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvPayDate] datetime NULL,
    [drvPayrollBeginDate] datetime NULL,
    [drvPayrollEndDate] datetime NULL
);
IF OBJECT_ID('U_ESTAHLW401_EEList') IS NULL
CREATE TABLE [dbo].[U_ESTAHLW401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESTAHLW401_File') IS NULL
CREATE TABLE [dbo].[U_ESTAHLW401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ESTAHLW401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESTAHLW401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh403] numeric NULL,
    [PdhRoth] numeric NULL,
    [PdhMatch] numeric NULL,
    [Pdh403L] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);
IF OBJECT_ID('U_ESTAHLW401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESTAHLW401_PEarHist] (
    [PehEEID] char(12) NOT NULL,
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
IF OBJECT_ID('U_ESTAHLW401_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_ESTAHLW401_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthGrossWagesYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTAHLW401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: The Home For Little Wanderers

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 04/15/2020
Service Request Number: TekP-2019-11-7-0005

Purpose: Standard 401k Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESTAHLW401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESTAHLW401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESTAHLW401';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESTAHLW401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESTAHLW401' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAHLW401', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAHLW401', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESTAHLW401', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESTAHLW401';

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
    DELETE FROM dbo.U_ESTAHLW401_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESTAHLW401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

        -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ESTAHLW401_EEList
    WHERE  xEEID IN (SELECT eeceeid FROM dbo.EmpComp where EecPayGroup = 'HRONLY');

    

    --==========================================
    -- Create Deduction List
    --==========================================

    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '403BM,403BP,403L,403PC,403RC,403RP,LOAN2';

    IF OBJECT_ID('U_ESTAHLW401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAHLW401_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESTAHLW401_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    -- now set values for benefit module
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption', 'AuditDate');

    -- Non-required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DCH, DPC ,STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');

    --Set if OE
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE');
    END;

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_ESTAHLW401 D
    JOIN dbo.U_dsi_bdm_ESTAHLW401 E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ESTAHLW401
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ESTAHLW401
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ESTAHLW401
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ESTAHLW401
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ESTAHLW401
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ESTAHLW401
    JOIN dbo.EmpDedFull WITH (NOLOCK)
       ON EedEmpDedTVID = BdmUSGField2;
    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ESTAHLW401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAHLW401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh403     = SUM(CASE WHEN PdhDedCode IN ('403BP' , '403PC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRoth     = SUM(CASE WHEN PdhDedCode IN ('403RC' , '403RP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhMatch     = SUM(CASE WHEN PdhDedCode IN ('403BM') THEN PdhERCurAmt ELSE 0.00 END)        
        ,Pdh403L     = SUM(CASE WHEN PdhDedCode IN ('403L','LOAN2') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_ESTAHLW401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESTAHLW401_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) > 0.00
        OR SUM(PdhERCurAmt) > 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ESTAHLW401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAHLW401_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgPeriodStartDate             = MAX(PrgPeriodStartDate)
        ,PrgPeriodEndDate             = MAX(PrgPeriodEndDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl  AND  pehearnCode  in ('457P', '457T', 'CAR' ,'DPIMP', 'REIMB', 'GTL', 'LTD', 'LTDC', 'MILES', 'OTHER', 'PKDED', 'SEVER', 'WLNSA', 'WLNSB', 'WLNSC') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl  AND  pehearnCode  not in ('457P', '457T', 'CAR' ,'DPIMP', 'REIMB', 'GTL', 'LTD', 'LTDC', 'MILES', 'OTHER', 'PKDED', 'SEVER', 'WLNSA', 'WLNSB', 'WLNSC') THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ESTAHLW401_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


        IF OBJECT_ID('U_ESTAHLW401_PTaxHist') IS NOT NULL
        DROP TABLE dbo.U_ESTAHLW401_PTaxHist;
    SELECT DISTINCT
         PthEEID
        ,PthGrossWagesYTD    = SUM(PthCurTaxableWages)       
    INTO dbo.U_ESTAHLW401_PTaxHist
    FROM dbo.PTaxHist WITH (NOLOCK)
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
    AND PthPerControl <= @EndPerControl

    AND PthTaxCode like '%SIT'
    AND PthPerControl BETWEEN @StartPerControl AND @EndPerControl

    GROUP BY PthEEID

    HAVING SUM(PthCurGrossWages) <> 0.00;

    IF OBJECT_ID('U_ESTAHLW401_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAHLW401_AuditFields;
    CREATE TABLE dbo.U_ESTAHLW401_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ESTAHLW401_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ESTAHLW401_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAHLW401_Audit;
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
    INTO dbo.U_ESTAHLW401_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ESTAHLW401_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ESTAHLW401_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate -30 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESTAHLW401_Audit ON dbo.U_ESTAHLW401_Audit (audKey1Value, audKey2Value);


  

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESTAHLW401_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTAHLW401_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAHLW401_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepssn
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvLastName = EepNameLast
        ,drvFirstNameMI = Quotename(Rtrim(EepNameFirst) + ' ' + LEFT(ISNULL(eepnamemiddle,''),1),'"')
        ,drvDOB = EepDateOfBirth
        ,drvDOH = Eecdateoflasthire
        ,drvDOT = Eecdateoftermination
        ,drvAnnSalary = Cast(Convert(Decimal (10,2),EecAnnSalary) as varchar(12))
        ,drvHours = Cast(Convert(Decimal (10,2),PehCurHrs) as varchar(12)) 
        ,drvTotalComp =  Cast(Convert(Decimal (10,2),PthGrossWagesYTD) as varchar(12))  
        ,drvEligComp = Cast(Convert(Decimal (10,2),PthGrossWagesYTD - PehCurAmt) as varchar(12)) 
        ,drvNonRegComp = Cast(Convert(Decimal (10,2),PehCurAmt) as varchar(12))
        ,drvEPReTaxCont = Cast(Convert(Decimal (10,2),Pdh403) as varchar(12))
        ,drvRoth401K =  Cast(Convert(Decimal (10,2),PdhRoth) as varchar(12))
        ,drvOtherEmpContrib = ''
        ,drvEmpMatchContrib = Cast(Convert(Decimal (10,2),PdhMatch) as varchar(12))
        ,drvSafeHarCont = ''
        ,drvOthERContrib = ''
        ,drvLoanPayment = Cast(Convert(Decimal (10,2),Pdh403L) as varchar(12)) 
        ,drvPayrollFreq = EecPayPeriod
        ,drvContrRatePreTax = CASE WHEN PreTax is not null then Cast(Convert(Decimal (10,2),PreTax * 100) as varchar(12))  END 
        ,drvCOnFlatDollarPreTax = ''
        ,drvContRateRoth = CASE WHEN Roth is not null then Cast(Convert(Decimal (10,2),Roth * 100) as varchar(12))  END 
        ,drvContFlatRateRoth = ''
        ,drvLanguage = ''
        ,drvGender = EepGender
        /*
            If Eecpaygroup = HRONLY or eecemptype = STU, SUM, INT or TMP,
        or EecDedGroupCode = NONE or NONBE, 
        or eecemptype = PT and EecScheduledWorkHrs is less than 20  send 1
        else leave blank
        */
        ,drvExcludedEmpBefore = CASE WHEN (Eecpaygroup = 'HRONLY' or eeceetype in ('STU','SUM','INT','TMP','PT') or EecDedGroupCode in ('NONE','NONBE')) and EecScheduledWorkHrs < 20 THEN '1'  END
        ,drvExcludedEmp = CASE WHEN (Eecpaygroup = 'HRONLY' or eeceetype in ('STU','SUM','INT','TMP','PT') or EecDedGroupCode in ('NONE','NONBE')) and EecScheduledWorkHrs < 20 and EecDedGroupCode <> 'PD403' THEN '1'  END

        ,drvDivision = ''
        ,drvAddressLine1 = Quotename(EepAddressLine1,'"')
        ,drvAddressLine2 = Quotename(EepAddressLine2,'"') 
        ,drvCity = Quotename(EepAddressCity,'"')  
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvEmailAddress = EepAddressEMail
        ,drvPayDate = dbo.dsi_fnGetMinMaxDates('MAX',PrgPayDate, PrgPayDate1) 
        ,drvPayrollBeginDate = dbo.dsi_fnGetMinMaxDates('MAX',PrgPeriodStartDate, PrgPeriodStart)  
        ,drvPayrollEndDate = dbo.dsi_fnGetMinMaxDates('MAX',PrgPeriodEndDate, PrgPeriodEnd)  
    INTO dbo.U_ESTAHLW401_drvTbl
    FROM dbo.U_ESTAHLW401_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
          and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ESTAHLW401_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))

    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_ESTAHLW401_PDedHist WITH (NOLOCK)
        ON PdhEEID =  XEEID
    LEFT JOIN dbo.U_ESTAHLW401_PTaxHist WITH (NOLOCK)
        ON ptheeid =  XEEID
    LEFT JOIN (
    select bdmeeid,bdmcoid,
        MAX(CASE WHEN BdmDedcode in ('403BP','403PC') THEN bdmEEcalcRateOrPct END) as PreTax,
        MAX(CASE WHEN BdmDedcode in ('403RC','403RP') THEN bdmEEcalcRateOrPct END) as Roth
        from U_dsi_bdm_ESTAHLW401 WITH (NOLOCK) group by bdmeeid,bdmcoid
    ) as BdmConsolidated
    on bdmeeid =  xeeid
    and bdmcoid = xcoid
    LEFT JOIN dbo.U_ESTAHLW401_PEarHist WITH (NOLOCK)
    on  PehEEID =  xeeid
  LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PrgPayDate1, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup

        ) Prg ON EecPayGroup = PgpPayGroup;

    Delete from U_ESTAHLW401_drvTbl where drvInitialSort in ('001001234' ,'000000002')


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
ALTER VIEW dbo.dsi_vwESTAHLW401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTAHLW401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESTAHLW401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202004081'
       ,expStartPerControl     = '202004081'
       ,expLastEndPerControl   = '202004159'
       ,expEndPerControl       = '202004159'
WHERE expFormatCode = 'ESTAHLW401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESTAHLW401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESTAHLW401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2