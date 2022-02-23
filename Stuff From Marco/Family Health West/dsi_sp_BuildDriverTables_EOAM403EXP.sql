SET NOCOUNT ON;
IF OBJECT_ID('U_EOAM403EXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EOAM403EXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EOAM403EXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EOAM403EXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEOAM403EXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEOAM403EXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EOAM403EXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOAM403EXP];
GO
IF OBJECT_ID('U_EOAM403EXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EOAM403EXP_PEarHist];
GO
IF OBJECT_ID('U_EOAM403EXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EOAM403EXP_PDedHist];
GO
IF OBJECT_ID('U_EOAM403EXP_File') IS NOT NULL DROP TABLE [dbo].[U_EOAM403EXP_File];
GO
IF OBJECT_ID('U_EOAM403EXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EOAM403EXP_EEList];
GO
IF OBJECT_ID('U_EOAM403EXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EOAM403EXP_drvTbl];
GO
IF OBJECT_ID('U_EOAM403EXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EOAM403EXP_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EOAM403EXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EOAM403EXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EOAM403EXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EOAM403EXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EOAM403EXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EOAM403EXP','OneAmerica 403b Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EOAM403EXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contract number"','1','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','1',NULL,'Contract number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','2','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name (or initial)"','3','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','3',NULL,'Middle Name (or initial)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','4','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','5','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','5',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','6','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','6',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Status"','7','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','7',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 1"','8','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','8',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 2"','9','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','9',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','10','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','11','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','12','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','12',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Birth Date"','13','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','13',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date"','14','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','14',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','15','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','15',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','16','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','16',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Date"','17','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','17',NULL,'Payroll Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"415 Earnings"','18','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','18',NULL,'415 Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Earnings"','19','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','19',NULL,'Plan Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours"','20','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','20',NULL,'Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Excluded Earnings"','21','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','21',NULL,'Excluded Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Deferral"','22','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','22',NULL,'Employee Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Roth"','23','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','23',NULL,'Employee Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"457 Pre-tax Deferral"','24','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','24',NULL,'457 Pre-tax Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Safe Harbor Match"','25','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','25',NULL,'Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"457 Employer Contribution"','26','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','26',NULL,'457 Employer Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Number"','27','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','27',NULL,'Loan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment"','28','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','28',NULL,'Loan Payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Number"','29','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','29',NULL,'Loan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment"','30','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','30',NULL,'Loan Payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Number"','31','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','31',NULL,'Loan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment"','32','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','32',NULL,'Loan Payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Number"','33','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','33',NULL,'Loan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment"','34','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','34',NULL,'Loan Payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','35','(''DA''=''T,'')','EOAM403EXPZ0','50','H','01','35',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Email"','36','(''DA''=''T'')','EOAM403EXPZ0','50','H','01','36',NULL,'Work Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumnber"','1','(''UA''=''T,'')','EOAM403EXPZ0','6','D','10','1',NULL,'Contract number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','2','(''UA''=''T,'')','EOAM403EXPZ0','30','D','10','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','3','(''UA''=''T,'')','EOAM403EXPZ0','30','D','10','3',NULL,'Middle Name (or initial)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastname"','4','(''UA''=''T,'')','EOAM403EXPZ0','30','D','10','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''T,'')','EOAM403EXPZ0','11','D','10','5',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','6','(''UA''=''T,'')','EOAM403EXPZ0','1','D','10','6',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatus"','7','(''UA''=''T,'')','EOAM403EXPZ0','1','D','10','7',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','8','(''UA''=''T,'')','EOAM403EXPZ0','50','D','10','8',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','9','(''UA''=''T,'')','EOAM403EXPZ0','50','D','10','9',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','10','(''UA''=''T,'')','EOAM403EXPZ0','25','D','10','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','11','(''UA''=''T,'')','EOAM403EXPZ0','2','D','10','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','12','(''UA''=''T,'')','EOAM403EXPZ0','10','D','10','12',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','13','(''UD101''=''T,'')','EOAM403EXPZ0','10','D','10','13',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','14','(''UD101''=''T,'')','EOAM403EXPZ0','10','D','10','14',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','15','(''UD101''=''T,'')','EOAM403EXPZ0','10','D','10','15',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','16','(''UD101''=''T,'')','EOAM403EXPZ0','10','D','10','16',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDate"','17','(''UD101''=''T,'')','EOAM403EXPZ0','10','D','10','17',NULL,'Payroll Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv415Earnings"','18','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','18',NULL,'415 Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEarnings"','19','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','19',NULL,'Plan Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHours"','20','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','20',NULL,'Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludedEarnings"','21','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','21',NULL,'Excluded Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplDeferral"','22','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','22',NULL,'Employee Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpRoth"','23','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','23',NULL,'Employee Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv457PreTaxDef"','24','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','24',NULL,'457 Pre-tax Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSafeHarborMatch"','25','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','25',NULL,'Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv457EmployerContrib"','26','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','26',NULL,'457 Employer Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber1"','27','(''UA''=''T,'')','EOAM403EXPZ0','10','D','10','27',NULL,'Loan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment1"','28','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','28',NULL,'Loan Payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber2"','29','(''UA''=''T,'')','EOAM403EXPZ0','10','D','10','29',NULL,'Loan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment2"','30','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','30',NULL,'Loan Payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber3"','31','(''UA''=''T,'')','EOAM403EXPZ0','10','D','10','31',NULL,'Loan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment3"','32','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','32',NULL,'Loan Payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber4"','33','(''UA''=''T,'')','EOAM403EXPZ0','10','D','10','33',NULL,'Loan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment4"','34','(''UA''=''T,'')','EOAM403EXPZ0','13','D','10','34',NULL,'Loan Payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','35','(''UA''=''T,'')','EOAM403EXPZ0','50','D','10','35',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','36','(''UA''=''T,'')','EOAM403EXPZ0','32','D','10','36',NULL,'Work Email',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EOAM403EXP_20200102.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'OneAmerica 403b Export','201911149','EMPEXPORT','ONDEMAND',NULL,'EOAM403EXP',NULL,NULL,NULL,'201911149','Nov 14 2019  2:14PM','Nov 14 2019  2:14PM','201911141',NULL,'','','201911141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EOAM403EXP_20200102.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201911149','EMPEXPORT','SCHEDULED',NULL,'EOAM403EXP',NULL,NULL,NULL,'201911149','Nov 14 2019  2:14PM','Nov 14 2019  2:14PM','201911141',NULL,'','','201911141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EOAM403EXP_20200102.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201912209','EMPEXPORT','TEST','Dec 20 2019 11:11AM','EOAM403EXP',NULL,NULL,NULL,'201912209','Dec 20 2019 12:00AM','Dec 30 1899 12:00AM','201912201','287','','','201912201',dbo.fn_GetTimedKey(),NULL,'us3lKiFAM1007',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EOAM403EXP_20200102.txt' END WHERE expFormatCode = 'EOAM403EXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOAM403EXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOAM403EXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOAM403EXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOAM403EXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOAM403EXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EOAM403EXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EOAM403EXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EOAM403EXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EOAM403EXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOAM403EXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOAM403EXP','D10','dbo.U_EOAM403EXP_drvTbl',NULL);
IF OBJECT_ID('U_EOAM403EXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EOAM403EXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EOAM403EXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EOAM403EXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvContractNumnber] varchar(6) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvMiddleName] varchar(50) NOT NULL,
    [drvLastname] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvGender] char(1) NULL,
    [drvEmpStatus] varchar(16) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvBirthDate] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvPayrollDate] datetime NULL,
    [drv415Earnings] varchar(12) NULL,
    [drv415EarningsRaw] numeric NULL,
    [drvPlanEarnings] varchar(12) NULL,
    [drvPlanEarningsRw] numeric NULL,
    [drvHours] varchar(12) NULL,
    [drvHoursRaw] decimal NULL,
    [drvExcludedEarnings] varchar(1) NOT NULL,
    [drvEmplDeferral] varchar(12) NULL,
    [drvEmpRoth] varchar(12) NULL,
    [drv457PreTaxDef] varchar(12) NULL,
    [drvSafeHarborMatch] varchar(12) NULL,
    [drv457EmployerContrib] varchar(12) NULL,
    [drvLoanNumber1] varchar(1) NOT NULL,
    [drvLoanPayment1] varchar(12) NULL,
    [drvLoanNumber2] varchar(1) NOT NULL,
    [drvLoanPayment2] varchar(12) NULL,
    [drvLoanNumber3] varchar(1) NOT NULL,
    [drvLoanPayment3] varchar(12) NULL,
    [drvLoanNumber4] varchar(1) NOT NULL,
    [drvLoanPayment4] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvWorkEmailAddress] varchar(50) NULL
);
IF OBJECT_ID('U_EOAM403EXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EOAM403EXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EOAM403EXP_File') IS NULL
CREATE TABLE [dbo].[U_EOAM403EXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EOAM403EXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EOAM403EXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [EmployeeDeferral] numeric NULL,
    [EmpRoth] numeric NULL,
    [Emp457] numeric NULL,
    [SafeHarborMatch] numeric NULL,
    [ER457Contrib] numeric NULL,
    [Emp403L] numeric NULL,
    [Emp403L2] numeric NULL,
    [Emp403L3] numeric NULL
);
IF OBJECT_ID('U_EOAM403EXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EOAM403EXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOAM403EXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Family Health West

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 11/14/2019
Service Request Number: TekP-2019-10-14-0001

Purpose: OneAmerica 403b Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EOAM403EXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EOAM403EXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EOAM403EXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EOAM403EXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EOAM403EXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOAM403EXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOAM403EXP', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EOAM403EXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EOAM403EXP';

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
    DELETE FROM dbo.U_EOAM403EXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EOAM403EXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --Delete RETIRE employee
    DELETE from U_EOAM403EXP_EEList where xeeid in (select distinct eeceeid from empcomp (NOLOCK) where eecdedgroupcode = 'RETIR')



    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '403P, 403F, 403CP, 403CF, ROTHP, ROTHF, RTHCP, RTHCF, 457F, 457P, 403ER, 457ER, 403L, 403L2, 403L3';

    IF OBJECT_ID('U_EOAM403EXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EOAM403EXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EOAM403EXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EOAM403EXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EOAM403EXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,EmployeeDeferral     = SUM(CASE WHEN PdhDedCode IN ('403P', '403F', '403CP', '403CF') THEN PdhEECurAmt ELSE 0.00 END)
        ,EmpRoth     = SUM(CASE WHEN PdhDedCode IN ('ROTHP', 'ROTHF', 'RTHCP', 'RTHCF') THEN PdhEECurAmt ELSE 0.00 END)
        ,Emp457     = SUM(CASE WHEN PdhDedCode IN ('457F', '457P') THEN PdhEECurAmt ELSE 0.00 END)
        ,SafeHarborMatch     = SUM(CASE WHEN PdhDedCode IN ('403ER') THEN PdhERCurAmt ELSE 0.00 END)  
        ,ER457Contrib     = SUM(CASE WHEN PdhDedCode IN ('457ER') THEN PdhERCurAmt ELSE 0.00 END)        
        ,Emp403L     = SUM(CASE WHEN PdhDedCode IN ('403L') THEN PdhEECurAmt ELSE 0.00 END)
        ,Emp403L2   = SUM(CASE WHEN PdhDedCode IN ('403L2') THEN PdhEECurAmt ELSE 0.00 END)
        ,Emp403L3     = SUM(CASE WHEN PdhDedCode IN ('403L3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EOAM403EXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EOAM403EXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EOAM403EXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EOAM403EXP_PEarHist;
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
    INTO dbo.U_EOAM403EXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    AND PehEarnCode NOT IN ('SEV', 'RETIR', 'CELL', 'TRAV', 'REIMB', 'INSUR', 'MOVE', 'MILE', 'PRIDE')
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EOAM403EXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EOAM403EXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOAM403EXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvContractNumnber = 'G77021'
        ,drvNameFirst = EepNameFirst
        ,drvMiddleName = ISNULL(EepNameMiddle,'')
        ,drvLastname = EepNameLast
        ,drvSSN = eepSSN
        ,drvGender = EepGender
        ,drvEmpStatus = CASE WHEN EecEmplStatus = 'T' then 'Termed'
                             WHEN EecEmplStatus = 'T' and EecTermReason = '203' then 'Deceased'
                             WHEN EecEmplStatus = 'L' then 'Leave of Absence'
                             WHEN EecEmplStatus = 'T' and EecTermReason = '202' then 'Retired'
                             ELSE ''
                        END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = eepaddresszipcode
        ,drvBirthDate = EepDateOfBirth
        ,drvHireDate = EecDateOfOriginalHire
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvPayrollDate = PrgPayDate
        ,drv415Earnings = CAST(CONVERT(DECIMAL(10,2),PehCurAmt) as varchar(12))
        ,drv415EarningsRaw = PehCurAmt
        ,drvPlanEarnings = CAST(CONVERT(DECIMAL(10,2),PehCurAmt) as varchar(12))
        ,drvPlanEarningsRw = PehCurAmt
        ,drvHours = CAST(CONVERT(Decimal(10,2),PehCurHrs) as varchar(12))
        ,drvHoursRaw = PehCurHrs
        ,drvExcludedEarnings = ''
        ,drvEmplDeferral = CAST(CONVERT(Decimal(10,2),CASE WHEN EmployeeDeferral < 0 Then 0 END) as Varchar(12))
        ,drvEmpRoth = CAST(CONVERT(Decimal(10,2),CASE WHEN EmpRoth < 0 Then 0 END ) as Varchar(12))
        ,drv457PreTaxDef = CAST(CONVERT(Decimal(10,2),CASE WHEN Emp457 < 0 Then 0 END ) as Varchar(12))
        ,drvSafeHarborMatch = CAST(CONVERT(Decimal(10,2), CASE WHEN SafeHarborMatch < 0 Then 0 END ) as Varchar(12))
        ,drv457EmployerContrib = CAST(CONVERT(Decimal(10,2), CASE WHEN ER457Contrib < 0 Then 0 END ) as Varchar(12))
        ,drvLoanNumber1 = ''
        ,drvLoanPayment1 = CAST(CONVERT(Decimal(10,2), CASE WHEN Emp403L < 0 Then 0 END ) as Varchar(12))
        ,drvLoanNumber2 = ''
        ,drvLoanPayment2 = CAST(CONVERT(Decimal(10,2),CASE WHEN Emp403L2 < 0 Then 0 END ) as Varchar(12))
        ,drvLoanNumber3 = ''
        ,drvLoanPayment3 = CAST(CONVERT(Decimal(10,2),CASE WHEN Emp403L3 < 0 Then 0 END ) as Varchar(12))
        ,drvLoanNumber4 = ''
        ,drvLoanPayment4 = ''
        ,drvEmailAddress = eepAddressEMailAlternate
        ,drvWorkEmailAddress = EepAddressEMail
    INTO dbo.U_EOAM403EXP_drvTbl
    FROM dbo.U_EOAM403EXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EOAM403EXP_PEarHist WITH (NOLOCK)
        ON PehEEID = XEEID
    JOIN dbo.U_EOAM403EXP_PDedHist  WITH (NOLOCK)
        ON PdhEEID = XEEID

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
ALTER VIEW dbo.dsi_vwEOAM403EXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EOAM403EXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EOAM403EXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911071'
       ,expStartPerControl     = '201911071'
       ,expLastEndPerControl   = '201911149'
       ,expEndPerControl       = '201911149'
WHERE expFormatCode = 'EOAM403EXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEOAM403EXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EOAM403EXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort