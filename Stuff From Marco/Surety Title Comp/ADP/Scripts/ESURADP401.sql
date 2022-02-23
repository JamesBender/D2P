SET NOCOUNT ON;
IF OBJECT_ID('U_ESURADP401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESURADP401_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESURADP401_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESURADP401' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESURADP401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESURADP401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESURADP401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESURADP401];
GO
IF OBJECT_ID('U_ESURADP401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESURADP401_PEarHist];
GO
IF OBJECT_ID('U_ESURADP401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESURADP401_PDedHist];
GO
IF OBJECT_ID('U_ESURADP401_File') IS NOT NULL DROP TABLE [dbo].[U_ESURADP401_File];
GO
IF OBJECT_ID('U_ESURADP401_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESURADP401_EEList];
GO
IF OBJECT_ID('U_ESURADP401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESURADP401_drvTbl];
GO
IF OBJECT_ID('U_ESURADP401_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESURADP401_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ESURADP401') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESURADP401];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESURADP401';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESURADP401';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESURADP401';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESURADP401';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESURADP401';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESURADP401','ADP 401k Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ESURADP401Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESURADP401' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Check Date"','1','(''DA''=''T,'')','ESURADP401Z0','50','H','01','1',NULL,'Check Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','2','(''DA''=''T,'')','ESURADP401Z0','50','H','01','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Name"','3','(''DA''=''T,'')','ESURADP401Z0','50','H','01','3',NULL,'Employee Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','4','(''DA''=''T,'')','ESURADP401Z0','50','H','01','4',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','5','(''DA''=''T,'')','ESURADP401Z0','50','H','01','5',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','6','(''DA''=''T,'')','ESURADP401Z0','50','H','01','6',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','7','(''DA''=''T,'')','ESURADP401Z0','50','H','01','7',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZIP Code"','8','(''DA''=''T,'')','ESURADP401Z0','50','H','01','8',NULL,'ZIP Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','9','(''DA''=''T,'')','ESURADP401Z0','50','H','01','9',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire"','10','(''DA''=''T,'')','ESURADP401Z0','50','H','01','10',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Termination"','11','(''DA''=''T,'')','ESURADP401Z0','50','H','01','11',NULL,'Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Rehire"','12','(''DA''=''T,'')','ESURADP401Z0','50','H','01','12',NULL,'Date of Rehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HCE Code"','13','(''DA''=''T,'')','ESURADP401Z0','50','H','01','13',NULL,'HCE Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Key Employee"','14','(''DA''=''T,'')','ESURADP401Z0','50','H','01','14',NULL,'Key Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Status"','15','(''DA''=''T,'')','ESURADP401Z0','50','H','01','15',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Gross Compensation"','16','(''DA''=''T,'')','ESURADP401Z0','50','H','01','16',NULL,'YTD Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pretax Elective Deferral"','17','(''DA''=''T,'')','ESURADP401Z0','50','H','01','17',NULL,'Pretax Elective Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Roth Elective Deferrals"','18','(''DA''=''T,'')','ESURADP401Z0','50','H','01','18',NULL,'Roth Elective Deferrals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Plan Eligibility"','19','(''DA''=''T,'')','ESURADP401Z0','50','H','01','19',NULL,'Date of Plan Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Compensation PTD"','20','(''DA''=''T,'')','ESURADP401Z0','50','H','01','20',NULL,'Plan Compensation PTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gross Compensation PTD"','21','(''DA''=''T,'')','ESURADP401Z0','50','H','01','21',NULL,'Gross Compensation PTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Defined YTD"','22','(''DA''=''T,'')','ESURADP401Z0','50','H','01','22',NULL,'Plan Defined YTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Eligible Gross Compensation YTD"','23','(''DA''=''T,'')','ESURADP401Z0','50','H','01','23',NULL,'Eligible Gross Compensation YTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Match Eligibility"','24','(''DA''=''T,'')','ESURADP401Z0','50','H','01','24',NULL,'Date of Match Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Alt Eligibility Date"','25','(''DA''=''T,'')','ESURADP401Z0','50','H','01','25',NULL,'Alt Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked PTD"','26','(''DA''=''T,'')','ESURADP401Z0','50','H','01','26',NULL,'Hours Worked PTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked YTD"','27','(''DA''=''T,'')','ESURADP401Z0','50','H','01','27',NULL,'Hours Worked YTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Company Code"','28','(''DA''=''T,'')','ESURADP401Z0','50','H','01','28',NULL,'Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Number"','29','(''DA''=''T,'')','ESURADP401Z0','50','H','01','29',NULL,'Loan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Repayment Amount"','30','(''DA''=''T,'')','ESURADP401Z0','50','H','01','30',NULL,'Loan Repayment Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Number2"','31','(''DA''=''T,'')','ESURADP401Z0','50','H','01','31',NULL,'Loan Number2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Repayment Amount2"','32','(''DA''=''T,'')','ESURADP401Z0','50','H','01','32',NULL,'Loan Repayment Amount2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Indicator"','33','(''DA''=''T,'')','ESURADP401Z0','50','H','01','33',NULL,'Union Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Match"','34','(''DA''=''T,'')','ESURADP401Z0','50','H','01','34',NULL,'Employer Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Non-Elective Contribution"','35','(''DA''=''T,'')','ESURADP401Z0','50','H','01','35',NULL,'Non-Elective Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Frequency"','36','(''DA''=''T'')','ESURADP401Z0','50','H','01','36',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','1','(''UD101''=''T,'')','ESURADP401Z0','50','D','10','1',NULL,'drvCheckDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','ESURADP401Z0','50','D','10','2',NULL,'drvSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeName"','3','(''UA''=''T,'')','ESURADP401Z0','50','D','10','3',NULL,'drvEmployeeName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','4','(''UA''=''T,'')','ESURADP401Z0','50','D','10','4',NULL,'drvAddressLine1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','5','(''UA''=''T,'')','ESURADP401Z0','50','D','10','5',NULL,'drvAddressLine2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','6','(''UA''=''T,'')','ESURADP401Z0','50','D','10','6',NULL,'drvZCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','7','(''UA''=''T,'')','ESURADP401Z0','50','D','10','7',NULL,'drvState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZIPCode"','8','(''UA''=''T,'')','ESURADP401Z0','50','D','10','8',NULL,'drvZIPCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','9','(''UD101''=''T,'')','ESURADP401Z0','50','D','10','9',NULL,'drvDateOfBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','10','(''UD101''=''T,'')','ESURADP401Z0','50','D','10','10',NULL,'drvDateOfHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','11','(''UD101''=''T,'')','ESURADP401Z0','50','D','10','11',NULL,'drvDateOfTermination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfRehire"','12','(''UD101''=''T,'')','ESURADP401Z0','50','D','10','12',NULL,'drvDateOfRehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHCECode"','13','(''UA''=''T,'')','ESURADP401Z0','50','D','10','13',NULL,'drvHCECode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmployee"','14','(''UA''=''T,'')','ESURADP401Z0','50','D','10','14',NULL,'drvKeyEmployee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','15','(''UA''=''T,'')','ESURADP401Z0','50','D','10','15',NULL,'drvEmployeeStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDGrossCompensation"','16','(''UA''=''T,'')','ESURADP401Z0','50','D','10','16',NULL,'drvYTDGrossCompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPretaxElectiveDeferral"','17','(''UA''=''T,'')','ESURADP401Z0','50','D','10','17',NULL,'drvPretaxElectiveDeferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRothElectiveDeferrals"','18','(''UA''=''T,'')','ESURADP401Z0','50','D','10','18',NULL,'drvRothElectiveDeferrals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofPlanEligibility"','19','(''UD101''=''T,'')','ESURADP401Z0','50','D','10','19',NULL,'drvDateofPlanEligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCompensationPTD"','20','(''UA''=''T,'')','ESURADP401Z0','50','D','10','20',NULL,'drvPlanCompensationPTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrossCompensationPTD"','21','(''UA''=''T,'')','ESURADP401Z0','50','D','10','21',NULL,'drvGrossCompensationPTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCompensationYTD"','22','(''UA''=''T,'')','ESURADP401Z0','50','D','10','22',NULL,'drvPlanCompensationYTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibleGrossCompensationYTD"','23','(''UA''=''T,'')','ESURADP401Z0','50','D','10','23',NULL,'drvEligibleGrossCompensationYTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofMatchEligibility"','24','(''UD101''=''T,'')','ESURADP401Z0','50','D','10','24',NULL,'drvDateofMatchEligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAltEligibilityDate"','25','(''UD101''=''T,'')','ESURADP401Z0','50','D','10','25',NULL,'drvAltEligibilityDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourszWorkedPTD"','26','(''UA''=''T,'')','ESURADP401Z0','50','D','10','26',NULL,'drvHourszWorkedPTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourszWorkedYTD"','27','(''UA''=''T,'')','ESURADP401Z0','50','D','10','27',NULL,'drvHourszWorkedYTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyCode"','28','(''UA''=''T,'')','ESURADP401Z0','50','D','10','28',NULL,'drvHours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber"','29','(''UA''=''T,'')','ESURADP401Z0','50','D','10','29',NULL,'drvLoanNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRepaymentAmount"','30','(''UA''=''T,'')','ESURADP401Z0','50','D','10','30',NULL,'drvLoanRepaymentAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber2"','31','(''UA''=''T,'')','ESURADP401Z0','50','D','10','31',NULL,'drvLoanNumber2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRepaymentAmount2"','32','(''UA''=''T,'')','ESURADP401Z0','20','D','10','32',NULL,'drvLoanRepaymentAmount2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionIndicator"','33','(''UA''=''T,'')','ESURADP401Z0','50','D','10','33',NULL,'drvUnionIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerMatch"','34','(''UA''=''T,'')','ESURADP401Z0','50','D','10','34',NULL,'drvEmployerMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNonElectiveContribution"','35','(''UA''=''T,'')','ESURADP401Z0','50','D','10','35',NULL,'drvNonElectiveContribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','36','(''UA''=''T'')','ESURADP401Z0','50','D','10','36',NULL,'drvPayFrequency',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ESURADP401_20210810.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ADP 401K Ondemand','202106239','EMPEXPORT','ONDEM_XOE',NULL,'ESURADP401',NULL,NULL,NULL,'202106239','Jun 23 2021  3:02PM','Jun 23 2021  3:02PM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ADP 401K Scheduled','202106239','EMPEXPORT','SCH_ADPEX',NULL,'ESURADP401',NULL,NULL,NULL,'202106239','Jun 23 2021  3:02PM','Jun 23 2021  3:02PM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','B56WE,B57MZ,B58LU,B58FV,B58P4,JDRC4,B588L,B58R5,B57X1,B57S8,B58HU,B58AR,B58CW,B584H,B585U,B580B',NULL,NULL,NULL,'ADP 401K Test','202107029','EMPEXPORT','TEST_XOE','Aug  9 2021  9:18AM','ESURADP401',NULL,NULL,NULL,'202107029','Jul  2 2021 12:00AM','Dec 30 1899 12:00AM','202107021','575','','','202107021',dbo.fn_GetTimedKey(),NULL,'us3lKiSUR1007',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESURADP401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESURADP401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESURADP401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESURADP401','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESURADP401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESURADP401','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ESURADP401' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ESURADP401' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ESURADP401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESURADP401_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESURADP401','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESURADP401','D10','dbo.U_ESURADP401_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ESURADP401') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESURADP401] (
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
IF OBJECT_ID('U_ESURADP401_DedList') IS NULL
CREATE TABLE [dbo].[U_ESURADP401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESURADP401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESURADP401_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCheckDate] varchar(8) NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NULL,
    [drvAddressLine1] nvarchar(258) NULL,
    [drvAddressLine2] nvarchar(258) NULL,
    [drvCity] nvarchar(258) NULL,
    [drvState] varchar(255) NULL,
    [drvZIPCode] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvDateOfRehire] datetime NULL,
    [drvHCECode] varchar(1) NULL,
    [drvKeyEmployee] varchar(1) NULL,
    [drvEmployeeStatus] varchar(10) NULL,
    [drvYTDGrossCompensation] varchar(30) NULL,
    [drvPretaxElectiveDeferral] varchar(30) NULL,
    [drvRothElectiveDeferrals] varchar(30) NULL,
    [drvDateofPlanEligibility] varchar(1) NOT NULL,
    [drvPlanCompensationPTD] varchar(30) NULL,
    [drvGrossCompensationPTD] varchar(30) NULL,
    [drvPlanCompensationYTD] varchar(30) NULL,
    [drvEligibleGrossCompensationYTD] varchar(30) NULL,
    [drvDateofMatchEligibility] varchar(1) NOT NULL,
    [drvAltEligibilityDate] varchar(1) NOT NULL,
    [drvHourszWorkedPTD] varchar(30) NULL,
    [drvHourszWorkedYTD] varchar(30) NULL,
    [drvCompanyCode] char(5) NULL,
    [drvLoanNumber] varchar(1) NULL,
    [drvLoanRepaymentAmount] varchar(30) NULL,
    [drvLoanNumber2] varchar(1) NULL,
    [drvLoanRepaymentAmount2] varchar(30) NULL,
    [drvUnionIndicator] varchar(1) NOT NULL,
    [drvEmployerMatch] varchar(30) NULL,
    [drvNonElectiveContribution] varchar(1) NOT NULL,
    [drvPayFrequency] char(1) NULL
);
IF OBJECT_ID('U_ESURADP401_EEList') IS NULL
CREATE TABLE [dbo].[U_ESURADP401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESURADP401_File') IS NULL
CREATE TABLE [dbo].[U_ESURADP401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_ESURADP401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESURADP401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhPreTax] numeric NULL,
    [Pdh401M] numeric NULL,
    [PdhRoth] numeric NULL,
    [PdhLoan1] numeric NULL,
    [PdhLoan2] numeric NULL,
    [PdhPlanComp] numeric NULL,
    [PdhPlanCompYTD] numeric NULL
);
IF OBJECT_ID('U_ESURADP401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESURADP401_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESURADP401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Surety Title Company

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 07/08/2021
Service Request Number: TekP-2021-04-13-0002

Purpose: ADP_401K

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESURADP401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESURADP401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESURADP401';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESURADP401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESURADP401' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESURADP401', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESURADP401', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESURADP401', 'SCH_ADPEX';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESURADP401';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESURADP401', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESURADP401';

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
    DELETE FROM dbo.U_ESURADP401_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESURADP401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_ESURADP401_EEList
    WHERE xEEID IN (SELECT Eepeeid from dbo.EmpPers WITH (NOLOCK) where eepssn in ('999999902','123541234') ) ;
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CU,401F,401P,ROTD,ROTP,401M,KL1,KL2';

    IF OBJECT_ID('U_ESURADP401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESURADP401_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESURADP401_DedList
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
    IF OBJECT_ID('U_ESURADP401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESURADP401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhPreTax     = SUM(CASE WHEN PdhDedCode IN ('401CU','401F','401P') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401M    = SUM(CASE WHEN PdhDedCode IN ('401M') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhRoth    = SUM(CASE WHEN PdhDedCode IN ('ROTP', 'ROTD') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhLoan1     = SUM(CASE WHEN PdhDedCode IN ('KL1') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLoan2     = SUM(CASE WHEN PdhDedCode IN ('KL2') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhPlanComp     = SUM(CASE WHEN PdhDedCode IN ('401CU', '401F', '401P', 'ROTD' ,'ROTP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhDedCalcBasisAmt  ELSE 0.00 END)
        ,PdhPlanCompYTD     = SUM(CASE WHEN PdhDedCode IN ('401CU', '401F', '401P', 'ROTD' ,'ROTP')  THEN PdhDedCalcBasisAmt  ELSE 0.00 END)


    INTO dbo.U_ESURADP401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESURADP401_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ESURADP401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESURADP401_PEarHist;
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

    INTO dbo.U_ESURADP401_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    
    --Audit Table
    IF OBJECT_ID('U_ESURADP401AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESURADP401AuditFields;
    CREATE TABLE dbo.U_ESURADP401AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ESURADP401AuditFields VALUES ('EmpComp','EecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ESURADP401Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESURADP401Audit;
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
    INTO dbo.U_ESURADP401Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ESURADP401AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ESURADP401AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND CAST('12/31/' + CAST( YEAR(@EndDate) as varchar) as datetime);
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESURADP401Audit ON dbo.U_ESURADP401Audit (audKey1Value, audKey2Value);
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESURADP401_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESURADP401_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESURADP401_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvCheckDate = PayDate
        ,drvSSN = eepSSN
        ,drvEmployeeName = eepNameFirst + ' ' + eepnamelast
        ,drvAddressLine1 = QuoteName(EepAddressLine1,'"')
        ,drvAddressLine2 = QuoteName(EepAddressLine2,'"')
        ,drvCity = QuoteName(EepAddressCity,'"')
        ,drvState = EepAddressState
        ,drvZIPCode = Eepaddresszipcode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvDateOfTermination = EecDateOfTermination
        ,drvDateOfRehire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvHCECode = CASE WHEN ISNULL(EEPUDFIELD02,'') in ('Yes','Y') THEN 'Y' END
        ,drvKeyEmployee = CASE WHEN ISNULL(EEPUDFIELD14 ,'') in ('Yes','Y')  THEN 'Y' END
        ,drvEmployeeStatus = CASE WHEN EecEmplStatus = 'L' THEN 'LOA'
                             WHEN EecEmplStatus = 'T' THEN 'Terminated'    
                             END
        ,drvYTDGrossCompensation = CAST( CONVERT(DECIMAL(10,2),PehCurAmtYTD) as varchar) 
        ,drvPretaxElectiveDeferral = CAST( CONVERT(DECIMAL(10,2),PdhPreTax) as varchar)
        ,drvRothElectiveDeferrals = CAST(CONVERT(DECIMAL(10,2),PdhRoth) as varchar)
        ,drvDateofPlanEligibility = ''
        ,drvPlanCompensationPTD = CAST( CONVERT(DECIMAL(10,2),PdhPlanComp) as varchar)  
        ,drvGrossCompensationPTD = CAST( CONVERT(DECIMAL(10,2),PehCurAmt) as varchar) 
        ,drvPlanCompensationYTD = CAST( CONVERT(DECIMAL(10,2),PdhPlanCompytd) as varchar) 
        ,drvEligibleGrossCompensationYTD = CAST( CONVERT(DECIMAL(10,2),CASE WHEN PdhPlanCompytd > 0.00 then PdhPlanCompytd ELSE PehCurAmtYTD END) as varchar)
        ,drvDateofMatchEligibility = ''
        ,drvAltEligibilityDate = ''
        ,drvHourszWorkedPTD = CAST(CONVERT(DECIMAL(10,2),PehCurHrs) as varchar) 
        ,drvHourszWorkedYTD = CAST(CONVERT(DECIMAL(10,2),PehCurHrsYTD) as varchar) 
        ,drvCompanyCode = cmpcompanycode
        ,drvLoanNumber = Case When PdhLoan1 > 0 Then '1' END
        ,drvLoanRepaymentAmount = Case When PdhLoan1 > 0 Then CAST(CONVERT(DECIMAL(10,2),pdhLoan1) as varchar) END 
        ,drvLoanNumber2 = Case When PdhLoan2 > 0 Then '2' END
        ,drvLoanRepaymentAmount2 =Case When PdhLoan2 > 0 Then CAST(CONVERT(DECIMAL(10,2),PdhLoan2) as varchar) END 
        ,drvUnionIndicator = ''
        ,drvEmployerMatch = Cast(CONVERT(DECIMAL(10,2),Pdh401M) as varchar)
        ,drvNonElectiveContribution = ''
        ,drvPayFrequency = eecPayPeriod

    INTO dbo.U_ESURADP401_drvTbl
    FROM dbo.U_ESURADP401_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_ESURADP401Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_ESURADP401_PEarHist WITH (NOLOCK)
        ON PehEEID =  xEEID
    LEFT JOIN dbo.U_ESURADP401_PDedHist WITH (NOLOCK)
        ON PdhEEID =  xEEID
    JOIN dbo.Company WITH (NOLOCK)
        on CmpCoid =  xcoid
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
ALTER VIEW dbo.dsi_vwESURADP401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESURADP401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESURADP401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106161'
       ,expStartPerControl     = '202106161'
       ,expLastEndPerControl   = '202106239'
       ,expEndPerControl       = '202106239'
WHERE expFormatCode = 'ESURADP401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESURADP401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESURADP401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort