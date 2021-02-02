SET NOCOUNT ON;
IF OBJECT_ID('U_EPC401KELG_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPC401KELG_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EPC401KELG_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EPC401KELG' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEPC401KELG_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPC401KELG_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPC401KELG') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPC401KELG];
GO
IF OBJECT_ID('U_EPC401KELG_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPC401KELG_PEarHist];
GO
IF OBJECT_ID('U_EPC401KELG_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPC401KELG_PDedHist];
GO
IF OBJECT_ID('U_EPC401KELG_File') IS NOT NULL DROP TABLE [dbo].[U_EPC401KELG_File];
GO
IF OBJECT_ID('U_EPC401KELG_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPC401KELG_EEList];
GO
IF OBJECT_ID('U_EPC401KELG_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPC401KELG_drvTbl];
GO
IF OBJECT_ID('U_EPC401KELG_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPC401KELG_DedList];
GO
IF OBJECT_ID('U_EPC401KELG_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPC401KELG_AuditFields];
GO
IF OBJECT_ID('U_EPC401KELG_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPC401KELG_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EPC401KELG') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPC401KELG];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EPC401KELG';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EPC401KELG';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EPC401KELG';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EPC401KELG';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EPC401KELG';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPC401KELG','Epic 401k Eligibility Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EPC401KELGZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EPC401KELG' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ROSG"','1','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','1',NULL,'Plan ID or Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','2','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','3','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','3',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','4','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','5',NULL,'Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','6','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','6',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','7','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','7',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','8','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','8',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','9','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','9',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaricalStatus"','10','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','10',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayType"','11','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','11',NULL,'Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','11',NULL,'Union Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','13',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','14',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','16',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','17',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','20','(''UD101''=''T,'')','EPC401KELGZ0','50','D','10','20',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','21','(''UD101''=''T,'')','EPC401KELGZ0','50','D','10','21',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfRehire"','22','(''UD101''=''T,'')','EPC401KELGZ0','50','D','10','22',NULL,'Rehire Date',NULL,NULL);

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjustedSenorityDate"','23','(''UD101''=''T,'')','EPC401KELGZ0','50','D','10','22',NULL,'Adjusted Seniority Date',NULL,NULL);


INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','24','(''UD101''=''T,'')','EPC401KELGZ0','50','D','10','24',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLeaveOfAbsenceBeginDate"','25','(''UD101''=''T,'')','EPC401KELGZ0','50','D','10','25',NULL,'Leave of Absence Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLeaveOfAbsenceEndDate"','26','(''UD101''=''T,'')','EPC401KELGZ0','50','D','10','26',NULL,'Leave of Absence End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','27','(''UD101''=''T,'')','EPC401KELGZ0','50','D','10','27',NULL,'Check Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollBeginDate"','28','(''UD101''=''T,'')','EPC401KELGZ0','50','D','10','28',NULL,'Payroll Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollEndDate"','29','(''UD101''=''T,'')','EPC401KELGZ0','50','D','10','29',NULL,'Payroll End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFrequency"','30','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','30',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','31',NULL,'Cost Center 1 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','32',NULL,'Cost Center 2 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','33',NULL,'Cost Center 3 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrossEarning"','34','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','34',NULL,'Gross Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEarnings"','35','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','35',NULL,'Plan Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHours"','36','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','36',NULL,'Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludedEarnings"','37','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','37',NULL,'Excluded Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDeferral"','38','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','38',NULL,'Employee Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeRoth"','39','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','39',NULL,'Employee Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','41',NULL,'Employee After Tax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','41',NULL,'Employer Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSafeHaborMatch"','42','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','42',NULL,'Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','43',NULL,'Qualified Matching',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','44',NULL,'Safe Harbor Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','45',NULL,'Qualified Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','46',NULL,'Profit Sharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','47',NULL,'Money Purchase',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment2"','48','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','48',NULL,'Loan Payment 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','49',NULL,'Loan Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','50',NULL,'Loan Payment 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','51',NULL,'Loan Number 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','52',NULL,'Loan Payment 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','53',NULL,'Loan Number 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','54',NULL,'Loan Payment 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','55',NULL,'Loan Number 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','56',NULL,'Loan Payment 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','57',NULL,'Loan Number 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYTDGrossEarnings"','58','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','58',NULL,'YTD Gross Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLanYTDEarnings"','59','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','59',NULL,'Plan YTD Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYTDHours"','60','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','60',NULL,'Plan YTD Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYTDExludedEarnings"','61','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','61',NULL,'Plan YTD Excluded Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','62',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYTDEEDeferral"','63','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','63',NULL,'Plan YTD Employee Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYTDEERoth"','64','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','64',NULL,'Plan YTD Employee Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','65',NULL,'Plan YTD Employee After Tax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','66',NULL,'Plan YTD Employer Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDSafeHarborMatch"','67','(''UA''=''T,'')','EPC401KELGZ0','50','D','10','67',NULL,'Plan YTD Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','68',NULL,'Plan YTD Qualified Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','69',NULL,'Plan YTD Safe Harbor Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','70',NULL,'Plan YTD Qual Non-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','71',NULL,'Plan YTD Profit Sharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','72',NULL,'Plan YTD Money Purchase',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''T,'')','EPC401KELGZ0','50','D','10','73',NULL,'Plan YTD Rollover',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"C2N"','74','(''DA''=''T'')','EPC401KELGZ0','50','D','10','74',NULL,'Plan ID',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EPC401KELG_20201230.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Epic 401k Eligibility Export','202011069','EMPEXPORT','ONDEM_XOE','Nov 18 2020  4:16PM','EPC401KELG',NULL,NULL,NULL,'202011069','Nov 18 2020  1:21PM','Nov 18 2020  1:21PM','202011061','102','','','202011061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Epic 401k Eligibility Ex-Sched','202011069','EMPEXPORT','SCH_EPC401','Nov 18 2020  4:16PM','EPC401KELG',NULL,NULL,NULL,'202011069','Nov 18 2020  1:21PM','Nov 18 2020  1:21PM','202011061','102','','','202011061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Epic 401k Eligibility Ex-Test','202012049','EMPEXPORT','TEST_XOE','Dec 22 2020  5:25PM','EPC401KELG',NULL,NULL,NULL,'202012049','Dec  4 2020 12:00AM','Dec 30 1899 12:00AM','202012041','327','eecPayGroup','ROG11','202012041',dbo.fn_GetTimedKey(),NULL,'us3lKiROC1013',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPC401KELG','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPC401KELG','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPC401KELG','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPC401KELG','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPC401KELG','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EPC401KELG' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EPC401KELG' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EPC401KELG_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPC401KELG_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPC401KELG','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPC401KELG','D10','dbo.U_EPC401KELG_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EPC401KELG') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPC401KELG] (
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
IF OBJECT_ID('U_EPC401KELG_Audit') IS NULL
CREATE TABLE [dbo].[U_EPC401KELG_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EPC401KELG_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPC401KELG_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EPC401KELG_DedList') IS NULL
CREATE TABLE [dbo].[U_EPC401KELG_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EPC401KELG_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPC401KELG_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvSSN] varchar(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvGender] char(1) NULL,
    [drvEmployeeStatus] char(1) NULL,
    [drvMaricalStatus] char(1) NULL,
    [drvPayType] char(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfHire] datetime NULL,
    [drvDateOfRehire] datetime NULL,
    [drvAdjustedSenorityDate] DATETIME NULL,
    [drvTerminationDate] datetime NULL,
    [drvLeaveOfAbsenceBeginDate] datetime NULL,
    [drvLeaveOfAbsenceEndDate] datetime NULL,
    [drvCheckDate] datetime NULL,
    [drvPayrollBeginDate] datetime NULL,
    [drvPayrollEndDate] datetime NULL,
    [drvPayrollFrequency] char(1) NULL,
    [drvGrossEarning] nvarchar(4000) NULL,
    [drvPlanEarnings] nvarchar(4000) NULL,
    [drvHours] nvarchar(4000) NULL,
    [drvExcludedEarnings] nvarchar(4000) NULL,
    [drvEmployeeDeferral] nvarchar(4000) NULL,
    [drvEmployeeRoth] nvarchar(4000) NULL,
    [drvSafeHaborMatch] nvarchar(4000) NULL,
    [drvLoanPayment2] nvarchar(4000) NULL,
    [drvPlanYTDGrossEarnings] nvarchar(4000) NULL,
    [drvPLanYTDEarnings] nvarchar(4000) NULL,
    [drvPlanYTDHours] nvarchar(4000) NULL,
    [drvPlanYTDExludedEarnings] nvarchar(4000) NULL,
    [drvPlanYTDEEDeferral] nvarchar(4000) NULL,
    [drvPlanYTDEERoth] nvarchar(4000) NULL,
    [drvYTDSafeHarborMatch] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EPC401KELG_EEList') IS NULL
CREATE TABLE [dbo].[U_EPC401KELG_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EPC401KELG_File') IS NULL
CREATE TABLE [dbo].[U_EPC401KELG_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EPC401KELG_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPC401KELG_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhEEDeferral] numeric NULL,
    [PdhEERoth] numeric NULL,
    [PdhSafeHarborMatch] numeric NULL,
    [PdhLoandPmt2] numeric NULL,
    [PdhEEDeferralYTD] numeric NULL,
    [PdhEERothYTD] numeric NULL,
    [PdhSafeHarborMatchYTD] numeric NULL
);
IF OBJECT_ID('U_EPC401KELG_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPC401KELG_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPeriodStartDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurPlanAmt] numeric NULL,
    [PehCurExcludAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] numeric NULL,
    [PehCurPlanAmtYTD] numeric NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehCurExcludAmtYTD] numeric NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPC401KELG]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Rock Oak Services

Created By: James Bender
Business Analyst: Lea King
Create Date: 11/18/2020
Service Request Number: TekP-2020-8-31-0002

Purpose: Epic 401k Eligibility Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPC401KELG';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPC401KELG';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPC401KELG';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPC401KELG';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPC401KELG' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPC401KELG', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPC401KELG', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPC401KELG', 'SCH_EPC401';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPC401KELG', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPC401KELG';

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
    DELETE FROM dbo.U_EPC401KELG_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPC401KELG_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '4K102,4K101,4K201,4K202,4K302,4K301,4K401,4K402,4K001,4K501,4K502';

    IF OBJECT_ID('U_EPC401KELG_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPC401KELG_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPC401KELG_DedList
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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EPC401KELG_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EPC401KELG_AuditFields;
    CREATE TABLE dbo.U_EPC401KELG_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    
    
    --INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpComp','EecEmplStatus');
/*    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','eepSSN');    
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','EepAddressEMail');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpComp','EecDateOfBenefitSeniority');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpComp','EecEmpNo');*/
    INSERT INTO dbo.U_EPC401KELG_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EPC401KELG_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EPC401KELG_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EPC401KELG_Audit
    FROM dbo.U_EPC401KELG_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EPC401KELG_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(YEAR, -1, @StartDate) AND @EndDate
    AND audAction <> 'DELETE'
   --AND ISNULL(audNewValue,'') <> '';
   AND audNewValue = 'T'
   ;
    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    --DELETE FROM dbo.U_EPC401KELG_Audit WHERE audRowNo > 1;
    --==========================================
    -- Clean EE List 
    --=========================================
    -- Changes Only
--    DELETE FROM dbo.U_EPC401KELG_EEList
--    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EPC401KELG_Audit WHERE audEEID = xEEID AND audNewHire = 'Y');






--==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EPC401KELG_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPC401KELG_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhEEDeferral            = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND PdhDedCode IN ('4K102','4K101','4K201','4K202') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEERoth                = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND PdhDedCode IN ('4K302','4K301','4K401','4K402') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSafeHarborMatch     = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND PdhDedCode IN ('4K001') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhLoandPmt2            = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND PdhDedCode IN ('4K501','4K502') THEN PdhEECurAmt ELSE 0.00 END)
        --PehPerControl > = (FORMAT(DATEPART(YEAR, GETDATE()), '0000') + '01011')                AND PehPerControl <= @EndPerControl
        ,PdhEEDeferralYTD            = SUM(CASE WHEN PdhPerControl BETWEEN (FORMAT(DATEPART(YEAR, GETDATE()), '0000') + '01011') AND @EndPerControl AND PdhDedCode IN ('4K102','4K101','4K201','4K202') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEERothYTD                = SUM(CASE WHEN PdhPerControl BETWEEN (FORMAT(DATEPART(YEAR, GETDATE()), '0000') + '01011') AND @EndPerControl AND PdhDedCode IN ('4K302','4K301','4K401','4K402') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSafeHarborMatchYTD        = SUM(CASE WHEN PdhPerControl BETWEEN (FORMAT(DATEPART(YEAR, GETDATE()), '0000') + '01011') AND @EndPerControl AND PdhDedCode IN ('4K001') THEN PdhERCurAmt ELSE 0.00 END)            
    INTO dbo.U_EPC401KELG_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPC401KELG_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EPC401KELG_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPC401KELG_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgPeriodStartDate        = MAX(PrgPeriodStartDate)
        ,PrgPeriodEndDate    = MAX(PrgPeriodEndDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurPlanAmt            = SUM(CASE WHEN PehPerControl >= @StartPerControl AND ErnInclInDefComp = 'Y' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurExcludAmt        = SUM(CASE WHEN PehPerControl >= @StartPerControl AND ErnInclInDefComp = 'N' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(CASE WHEN PehPerControl > = (FORMAT(DATEPART(YEAR, GETDATE()), '0000') + '01011') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurPlanAmtYTD       = SUM(CASE WHEN PehPerControl > = (FORMAT(DATEPART(YEAR, GETDATE()), '0000') + '01011') AND ErnInclInDefComp = 'Y' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrsYTD           = SUM(CASE WHEN PehPerControl > = (FORMAT(DATEPART(YEAR, GETDATE()), '0000') + '01011') THEN PehCurHrs ELSE 0.00 END)
        ,PehCurExcludAmtYTD     = SUM(CASE WHEN PehPerControl > = (FORMAT(DATEPART(YEAR, GETDATE()), '0000') + '01011') AND ErnInclInDefComp = 'N' THEN PehCurAmt ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EPC401KELG_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;







    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPC401KELG_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPC401KELG_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPC401KELG_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = REPLACE(EepNameLast, ',', '')
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvEmployeeID = EecEmpNo
        ,drvGender = EepGender
        ,drvEmployeeStatus = EecEmplStatus
        ,drvMaricalStatus = EepMaritalStatus
        ,drvPayType = EecSalaryOrHourly
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        --,drvEmail = EepAddressEMail
        --,drvParticipantDate = EecDateOfBenefitSeniority
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvDateOfRehire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvAdjustedSenorityDate = ''
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvLeaveOfAbsenceBeginDate = CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END
        ,drvLeaveOfAbsenceEndDate = CASE WHEN EecEmplStatus = 'A' AND EshEmplStatus = 'L' THEN EshStatusStopDate END
        ,drvCheckDate = PrgPayDate
        ,drvPayrollBeginDate = PrgPeriodStartDate
        ,drvPayrollEndDate = PrgPeriodEndDate
        ,drvPayrollFrequency = PgrPayFrequency
        ,drvGrossEarning = FORMAT(PehCurAmt, '#0.00')
        ,drvPlanEarnings = FORMAT(PehCurPlanAmt, '#0.00')
        ,drvHours = FORMAT(PehCurHrs, '#0.00')
        ,drvExcludedEarnings = FORMAT(PehCurExcludAmt, '#0.00')
        ,drvEmployeeDeferral = FORMAT(PdhEEDeferral, '#0.00')
        ,drvEmployeeRoth = FORMAT(PdhEERoth, '#0.00')
        ,drvSafeHaborMatch = FORMAT(PdhSafeHarborMatch, '#0.00')
        ,drvLoanPayment2 = FORMAT(PdhLoandPmt2, '#0.00')
        ,drvPlanYTDGrossEarnings = FORMAT(PehCurAmtYTD, '#0.00')
        ,drvPLanYTDEarnings = FORMAT(PehCurPlanAmtYTD, '#0.00')
        ,drvPlanYTDHours = FORMAT(PehCurHrsYTD, '#0.00')
        ,drvPlanYTDExludedEarnings = FORMAT(PehCurExcludAmtYTD, '#0.00')
        ,drvPlanYTDEEDeferral = FORMAT(PdhEEDeferralYTD, '#0.00')
        ,drvPlanYTDEERoth = FORMAT(PdhEERothYTD, '#0.00')
        ,drvYTDSafeHarborMatch = FORMAT(PdhSafeHarborMatchYTD, '#0.00')
    INTO dbo.U_EPC401KELG_drvTbl
    FROM dbo.U_EPC401KELG_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EPC401KELG WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    JOIN dbo.U_EPC401KELG_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN  dbo.U_EPC401KELG_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID 
    LEFT JOIN dbo.U_EPC401KELG_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND (PdhEEDeferral > 0
        OR PdhEERoth > 0
        OR PdhSafeHarborMatch >0
        OR PdhLoandPmt2 > 0))
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
ALTER VIEW dbo.dsi_vwEPC401KELG_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPC401KELG_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPC401KELG%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202011061'
       ,expStartPerControl     = '202011061'
       ,expLastEndPerControl   = '202011069'
       ,expEndPerControl       = '202011069'
WHERE expFormatCode = 'EPC401KELG';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPC401KELG_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EPC401KELG_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort