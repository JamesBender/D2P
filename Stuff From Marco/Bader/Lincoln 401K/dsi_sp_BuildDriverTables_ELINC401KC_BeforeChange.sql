SET NOCOUNT ON;
IF OBJECT_ID('U_ELINC401KC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINC401KC_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELINC401KC_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELINC401KC' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELINC401KC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELINC401KC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELINC401KC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINC401KC];
GO
IF OBJECT_ID('U_ELINC401KC_trl90Tbl') IS NOT NULL DROP TABLE [dbo].[U_ELINC401KC_trl90Tbl];
GO
IF OBJECT_ID('U_ELINC401KC_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ELINC401KC_PEarHist];
GO
IF OBJECT_ID('U_ELINC401KC_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ELINC401KC_PDedHist];
GO
IF OBJECT_ID('U_ELINC401KC_File') IS NOT NULL DROP TABLE [dbo].[U_ELINC401KC_File];
GO
IF OBJECT_ID('U_ELINC401KC_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELINC401KC_EEList];
GO
IF OBJECT_ID('U_ELINC401KC_drv20Tbl') IS NOT NULL DROP TABLE [dbo].[U_ELINC401KC_drv20Tbl];
GO
IF OBJECT_ID('U_ELINC401KC_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELINC401KC_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELINC401KC';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELINC401KC';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELINC401KC';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELINC401KC';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELINC401KC';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELINC401KC','Lincoln 401K Contribution Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ELINC401KCZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELINC401KC' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLIENT CODE"','1','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','1',NULL,'CLIENT CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAYROLL CHECK DATE"','2','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','2',NULL,'PAYROLL CHECK DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SOCIAL SECURITY NUMBER"','3','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','3',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE ID"','4','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','4',NULL,'EMPLOYEE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST NAME"','5','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','5',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE INITIAL"','6','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','6',NULL,'MIDDLE INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST NAME"','7','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','7',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYMENT STATUS"','8','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','8',NULL,'EMPLOYMENT STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS LINE 1"','9','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','9',NULL,'ADDRESS LINE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS LINE 2"','10','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','10',NULL,'ADDRESS LINE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CITY"','11','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','11',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STATE (CODE)"','12','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','12',NULL,'STATE (CODE)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZIP CODE"','13','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','13',NULL,'ZIP CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER CODE"','14','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','14',NULL,'GENDER CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE PHONE NUMBER"','15','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','15',NULL,'EMPLOYEE PHONE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ANNUALIZED SALARY (INCOME)"','16','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','16',NULL,'ANNUALIZED SALARY (INCOME)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE OF BIRTH"','17','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','17',NULL,'DATE OF BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MOST RECENT HIRE DATE"','18','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','18',NULL,'MOST RECENT HIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERMINATION DATE"','19','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','19',NULL,'TERMINATION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PER PAY PERIOD PLAN COMPENSATION"','20','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','20',NULL,'PER PAY PERIOD PLAN COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PER PAY PERIOD GROSS COMPENSATION"','21','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','21',NULL,'PER PAY PERIOD GROSS COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PER PAY PERIOD HOURS WORKED"','22','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','22',NULL,'PER PAY PERIOD HOURS WORKED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BRAI-001 PRE-TAX CONTRIBUTION AMOUNT"','23','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','23',NULL,'BRAI-001 PRE-TAX CONTRIBUTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BRAI-001 ROTH 401(k) CONTRIBUTION"','24','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','24',NULL,'BRAI-001 ROTH 401(k) CONTRIBUTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BRAI-001 EMPLOYER CONTRIBUTION"','25','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','25',NULL,'BRAI-001 EMPLOYER CONTRIBUTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BRAI-001 EMPLOYER MATCH CONTRIBUTION"','26','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','26',NULL,'BRAI-001 EMPLOYER MATCH CONTRIBUTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BRAI-001 LOAN REPAYMENT AMOUNT 1"','27','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','27',NULL,'BRAI-001 LOAN REPAYMENT AMOUNT 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BRAI-001 LOAN REPAYMENT AMOUNT 2"','28','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','28',NULL,'BRAI-001 LOAN REPAYMENT AMOUNT 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BRAI-001 LOAN REPAYMENT AMOUNT 3"','29','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','29',NULL,'BRAI-001 LOAN REPAYMENT AMOUNT 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BRAI-001 LOAN REPAYMENT AMOUNT 4"','30','(''DA''=''T,'')','ELINC401KCZ0','50','H','01','30',NULL,'BRAI-001 LOAN REPAYMENT AMOUNT 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BRAI-001 LOAN REPAYMENT AMOUNT 5"','31','(''DA''=''T'')','ELINC401KCZ0','50','H','01','31',NULL,'BRAI-001 LOAN REPAYMENT AMOUNT 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientCode"','1','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','1',NULL,'CLIENT CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollCheckDate"','2','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','2',NULL,'PAYROLL CHECK DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','3',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeId"','4','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','4',NULL,'EMPLOYEE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','5',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','6','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','6',NULL,'MIDDLE INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','7','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','7',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','8','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','8',NULL,'EMPLOYMENT STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','9',NULL,'ADDRESS LINE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','10',NULL,'ADDRESS LINE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','11','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','11',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','12','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','12',NULL,'STATE (CODE)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','13','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','13',NULL,'ZIP CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','14','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','14',NULL,'GENDER CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPhoneNumber"','15','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','15',NULL,'EMPLOYEE PHONE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnSalary"','16','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','16',NULL,'ANNUALIZED SALARY (INCOME)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','17','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','17',NULL,'DATE OF BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastHireDate"','18','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','18',NULL,'MOST RECENT HIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','19','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','19',NULL,'TERMINATION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPPPlanCompensation"','20','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','20',NULL,'PER PAY PERIOD PLAN COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPPGrossCompensation"','21','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','21',NULL,'PER PAY PERIOD GROSS COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPPHoursWorked"','22','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','22',NULL,'PER PAY PERIOD HOURS WORKED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreTaxContAmt"','23','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','23',NULL,'BRAI-001 PRE-TAX CONTRIBUTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRothAmt"','24','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','24',NULL,'BRAI-001 ROTH 401(k) CONTRIBUTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERContrAmt"','25','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','25',NULL,'BRAI-001 EMPLOYER CONTRIBUTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERMatchAmt"','26','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','26',NULL,'BRAI-001 EMPLOYER MATCH CONTRIBUTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmt1"','27','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','27',NULL,'BRAI-001 LOAN REPAYMENT AMOUNT 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmt2"','28','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','28',NULL,'BRAI-001 LOAN REPAYMENT AMOUNT 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmt3"','29','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','29',NULL,'BRAI-001 LOAN REPAYMENT AMOUNT 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmt4"','30','(''UA''=''T,'')','ELINC401KCZ0','50','D','20','30',NULL,'BRAI-001 LOAN REPAYMENT AMOUNT 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmt5"','31','(''UA''=''T'')','ELINC401KCZ0','50','D','20','31',NULL,'BRAI-001 LOAN REPAYMENT AMOUNT 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','1','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','1',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','2',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','3',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','4',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','5',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','6',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','7',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','8',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','9',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','10',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','11',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','12',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','13',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','14',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','15',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','16',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','17',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','18',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''T,'')','ELINC401KCZ0','50','T','90','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPPPlanCompensation"','20','(''UA''=''T,'')','ELINC401KCZ0','50','T','90','20',NULL,'drvPPPlanCompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPPGrossCompensation"','21','(''UA''=''T,'')','ELINC401KCZ0','50','T','90','21',NULL,'drvPPGrossCompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPPHoursWorked"','22','(''UA''=''T,'')','ELINC401KCZ0','50','T','90','22',NULL,'drvPPHoursWorked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreTaxContAmt"','23','(''UA''=''T,'')','ELINC401KCZ0','50','T','90','23',NULL,'drvPreTaxContAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRothAmt"','24','(''UA''=''T,'')','ELINC401KCZ0','50','T','90','24',NULL,'drvRothAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERContrAmt"','25','(''UA''=''T,'')','ELINC401KCZ0','50','T','90','25',NULL,'drvERContrAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERMatchAmt"','26','(''UA''=''T,'')','ELINC401KCZ0','50','T','90','26',NULL,'drvERMatchAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmt1"','27','(''UA''=''T,'')','ELINC401KCZ0','50','T','90','27',NULL,'drvLoanAmt1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmt2"','28','(''UA''=''T,'')','ELINC401KCZ0','50','T','90','28',NULL,'drvLoanAmt2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmt3"','29','(''UA''=''T,'')','ELINC401KCZ0','50','T','90','29',NULL,'drvLoanAmt3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmt4"','30','(''UA''=''T,'')','ELINC401KCZ0','50','T','90','30',NULL,'drvLoanAmt4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmt5"','31','(''UA''=''T'')','ELINC401KCZ0','50','T','90','31',NULL,'drvLoanAmt5',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ELINC401KC_20210302.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Lincoln 401K Cont Export','201812319','EMPEXPORT','ONDEMAND','Feb 14 2019 12:00AM','ELINC401KC',NULL,NULL,NULL,'201812319','Dec 31 2018 12:00AM','Dec 30 1899 12:00AM','201812311','255','','','201812311',dbo.fn_GetTimedKey(),NULL,'us3cViBAD1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Scheduled Session','201812319','EMPEXPORT','SCHEDULED','Jan  8 2019  2:14PM','ELINC401KC',NULL,NULL,NULL,'201812319','Dec 31 2018 12:00AM','Dec 30 1899 12:00AM','201812311','255','','','201812311',dbo.fn_GetTimedKey(),NULL,'us3cViBAD1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201902151','EMPEXPORT','TEST','Feb 14 2019  6:26PM','ELINC401KC',NULL,NULL,NULL,'201902151','Feb 15 2019 12:00AM','Feb 15 2019 12:00AM','201902151','287','','','201902151',dbo.fn_GetTimedKey(),NULL,'us3cViBAD1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINC401KC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINC401KC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINC401KC','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINC401KC','OEPath','V','');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINC401KC','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINC401KC','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINC401KC','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ELINC401KC' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ELINC401KC' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ELINC401KC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINC401KC_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINC401KC','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINC401KC','D20','dbo.U_ELINC401KC_drv20Tbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINC401KC','T90','dbo.U_ELINC401KC_trl90Tbl',NULL);
IF OBJECT_ID('U_ELINC401KC_DedList') IS NULL
CREATE TABLE [dbo].[U_ELINC401KC_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ELINC401KC_drv20Tbl') IS NULL
CREATE TABLE [dbo].[U_ELINC401KC_drv20Tbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvClientCode] varchar(8) NOT NULL,
    [drvPayrollCheckDate] varchar(10) NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvFirstName] varchar(6000) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(6000) NULL,
    [drvEmploymentStatus] char(1) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvCity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvEEPhoneNumber] varchar(50) NULL,
    [drvAnnSalary] varchar(30) NULL,
    [drvDateOfBirth] varchar(10) NULL,
    [drvLastHireDate] varchar(10) NULL,
    [drvTerminationDate] varchar(10) NULL,
    [drvPPPlanCompensation] varchar(30) NULL,
    [drvPPPlanCompensation_amt] money NULL,
    [drvPPGrossCompensation] varchar(30) NULL,
    [drvPPGrossCompensation_amt] numeric NULL,
    [drvPPHoursWorked] varchar(30) NULL,
    [drvPPHoursWorked_amt] decimal NULL,
    [drvPreTaxContAmt] varchar(30) NULL,
    [drvPreTaxContAmt_amt] numeric NULL,
    [drvRothAmt] varchar(30) NULL,
    [drvRothAmt_amt] numeric NULL,
    [drvERContrAmt] varchar(1) NOT NULL,
    [drvERMatchAmt] varchar(30) NULL,
    [drvERMatchAmt_amt] numeric NULL,
    [drvLoanAmt1] varchar(30) NULL,
    [drvLoanAmt1_amt] numeric NULL,
    [drvLoanAmt2] varchar(30) NULL,
    [drvLoanAmt2_amt] numeric NULL,
    [drvLoanAmt3] varchar(30) NULL,
    [drvLoanAmt3_amt] numeric NULL,
    [drvLoanAmt4] varchar(30) NULL,
    [drvLoanAmt4_amt] numeric NULL,
    [drvLoanAmt5] varchar(30) NULL,
    [drvLoanAmt5_amt] numeric NULL
);
IF OBJECT_ID('U_ELINC401KC_EEList') IS NULL
CREATE TABLE [dbo].[U_ELINC401KC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELINC401KC_File') IS NULL
CREATE TABLE [dbo].[U_ELINC401KC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ELINC401KC_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ELINC401KC_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhPreTaxAmt] numeric NULL,
    [PdhRothAmt] numeric NULL,
    [PdhERMatchAmt] numeric NULL,
    [PdhLoanAmt1] numeric NULL,
    [PdhLoanAmt2] numeric NULL,
    [PdhLoanAmt3] numeric NULL,
    [PdhLoanAmt4] numeric NULL,
    [PdhLoanAmt5] numeric NULL
);
IF OBJECT_ID('U_ELINC401KC_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ELINC401KC_PEarHist] (
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
IF OBJECT_ID('U_ELINC401KC_trl90Tbl') IS NULL
CREATE TABLE [dbo].[U_ELINC401KC_trl90Tbl] (
    [drvPPPlanCompensation] varchar(30) NULL,
    [drvPPGrossCompensation] varchar(30) NULL,
    [drvPPHoursWorked] varchar(30) NULL,
    [drvPreTaxContAmt] varchar(30) NULL,
    [drvRothAmt] varchar(30) NULL,
    [drvERContrAmt] varchar(1) NOT NULL,
    [drvERMatchAmt] varchar(30) NULL,
    [drvLoanAmt1] varchar(30) NULL,
    [drvLoanAmt2] varchar(30) NULL,
    [drvLoanAmt3] varchar(30) NULL,
    [drvLoanAmt4] varchar(30) NULL,
    [drvLoanAmt5] varchar(30) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINC401KC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Bader Rutter & Associates Inc

Created By: Cissie Vines
Business Analyst: Cheryl Petitti
Create Date: 01/08/2019
Service Request Number: SR-2018-00218767

Purpose: Lincoln 401K Contribution Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELINC401KC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELINC401KC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELINC401KC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELINC401KC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELINC401KC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINC401KC', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINC401KC', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINC401KC', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELINC401KC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELINC401KC';

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
    DELETE FROM dbo.U_ELINC401KC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELINC401KC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401P,401CP,RTHCP,ROTHP,MATCH,401L,401L1,401L2,401L3,401L4,401L5,401L6,401L7,401L8';

    IF OBJECT_ID('U_ELINC401KC_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELINC401KC_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELINC401KC_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ELINC401KC_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELINC401KC_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhPreTaxAmt   = SUM(CASE WHEN PdhDedCode IN ('401P','401CP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRothAmt     = SUM(CASE WHEN PdhDedCode IN ('ROTHP','RTHCP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERMatchAmt  = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhLoanAmt1    = SUM(CASE WHEN PdhDedCode IN ('401L','401L1') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLoanAmt2     = SUM(CASE WHEN PdhDedCode IN ('401L2') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLoanAmt3     = SUM(CASE WHEN PdhDedCode IN ('401L3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhLoanAmt4    = SUM(CASE WHEN PdhDedCode IN ('401L4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhLoanAmt5    = SUM(CASE WHEN PdhDedCode IN ('401L5','401L6','401L7','401L8') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        
    INTO dbo.U_ELINC401KC_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ELINC401KC_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE --LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

      -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ELINC401KC_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELINC401KC_PEarHist;
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
    INTO dbo.U_ELINC401KC_PEarHist
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
    -- DETAIL RECORD - U_ELINC401KC_drv20Tbl
    ---------------------------------
    IF OBJECT_ID('U_ELINC401KC_drv20Tbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELINC401KC_drv20Tbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvClientCode = 'BRAI-001'
        ,drvPayrollCheckDate = CONVERT(VARCHAR(10),PrgPayDate,101)
        ,drvSSN = eepSSN
        ,drvEmployeeId = EecEmpNo
        ,drvFirstName = dbo.dsi_fnRemoveChars('.,/',eepNameFirst)
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName = dbo.dsi_fnRemoveChars('.,/',eepNameLast)
        ,drvEmploymentStatus = EecEmplStatus
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/',eepaddressline1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/',eepaddressline2)
        ,drvCity = dbo.dsi_fnRemoveChars('.,/',eepaddressCity)
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvGender = EepGender
        ,drvEEPhoneNumber = EepPhoneHomeNumber
        ,drvAnnSalary = CONVERT(VARCHAR,EecAnnSalary)
        ,drvDateOfBirth = CONVERT(VARCHAR(10),EepDateOfBirth,101)
        ,drvLastHireDate = CONVERT(VARCHAR(10),EecDateOfLastHire,101)
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN CONVERT(VARCHAR(10),EecDateOfTermination,101) END
        ,drvPPPlanCompensation = CONVERT(VARCHAR,PehInclInDefComp)
        ,drvPPPlanCompensation_amt = PehInclInDefComp
        ,drvPPGrossCompensation = CONVERT(VARCHAR,PehCurAmt)
        ,drvPPGrossCompensation_amt = PehCurAmt
        ,drvPPHoursWorked = CONVERT(VARCHAR,PehCurHrs)
        ,drvPPHoursWorked_amt = PehCurHrs
        ,drvPreTaxContAmt = CONVERT(VARCHAR,PdhPreTaxAmt)
        ,drvPreTaxContAmt_amt = PdhPreTaxAmt
        ,drvRothAmt = CONVERT(VARCHAR,PdhRothAmt)
        ,drvRothAmt_amt = PdhRothAmt
        ,drvERContrAmt = ''
        ,drvERMatchAmt = CONVERT(VARCHAR,PdhERMatchAmt)
        ,drvERMatchAmt_amt = PdhERMatchAmt
        ,drvLoanAmt1 = CONVERT(VARCHAR,PdhLoanAmt1)
        ,drvLoanAmt1_amt = PdhLoanAmt1
        ,drvLoanAmt2 = CONVERT(VARCHAR,PdhLoanAmt2)
        ,drvLoanAmt2_amt = PdhLoanAmt2
        ,drvLoanAmt3 = CONVERT(VARCHAR,PdhLoanAmt3)
        ,drvLoanAmt3_amt = PdhLoanAmt3
        ,drvLoanAmt4 = CONVERT(VARCHAR,PdhLoanAmt4)
        ,drvLoanAmt4_amt = PdhLoanAmt4
        ,drvLoanAmt5 = CONVERT(VARCHAR,PdhLoanAmt5)
        ,drvLoanAmt5_amt = PdhLoanAmt5
    INTO dbo.U_ELINC401KC_drv20Tbl
    FROM dbo.U_ELINC401KC_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_ELINC401KC_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_ELINC401KC_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    WHERE EecEEType <> 'TES'
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ELINC401KC_trl90Tbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELINC401KC_trl90Tbl;
    SELECT DISTINCT
         drvPPPlanCompensation = CONVERT(VARCHAR,ppplancomp)
        ,drvPPGrossCompensation = CONVERT(VARCHAR,ppgrosscomp)
        ,drvPPHoursWorked = CONVERT(VARCHAR,pphrswrk)
        ,drvPreTaxContAmt = CONVERT(VARCHAR,pretax)
        ,drvRothAmt = CONVERT(VARCHAR,roth)
        ,drvERContrAmt = ''
        ,drvERMatchAmt = CONVERT(VARCHAR,match)
        ,drvLoanAmt1 = CONVERT(VARCHAR,loan1)
        ,drvLoanAmt2 = CONVERT(VARCHAR,loan2)
        ,drvLoanAmt3 = CONVERT(VARCHAR,loan3)
        ,drvLoanAmt4 = CONVERT(VARCHAR,loan4)
        ,drvLoanAmt5 = CONVERT(VARCHAR,loan5)

    INTO dbo.U_ELINC401KC_trl90Tbl
    FROM (SELECT SUM(drvPPPlanCompensation_amt) as ppplancomp, 
                 SUM(drvPPGrossCompensation_amt) as ppgrosscomp,
                 SUM(drvPPHoursWorked_amt) as pphrswrk,
                 SUM(drvPreTaxContAmt_amt) as pretax,
                 SUM(drvRothAmt_amt) as roth,
                 SUM(drvERMatchAmt_amt) as match,
                 SUM(drvLoanAmt1_amt) as loan1,
                 SUM(drvLoanAmt2_amt) as loan2,
                 SUM(drvLoanAmt3_amt) as loan3,
                 SUM(drvLoanAmt4_amt) as loan4,
                 SUM(drvLoanAmt5_amt) as loan5
              FROM dbo.U_ELINC401KC_drv20tbl)  a 
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_BAD_ELINC401KC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'BAD_ELINC401KC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwELINC401KC_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ELINC401KC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELINC401KC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201812311'
       ,expStartPerControl     = '201812311'
       ,expLastEndPerControl   = '201812319'
       ,expEndPerControl       = '201812319'
WHERE expFormatCode = 'ELINC401KC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELINC401KC_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELINC401KC_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort