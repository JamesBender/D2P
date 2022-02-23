SET NOCOUNT ON;
IF OBJECT_ID('U_ESTAUNIACC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTAUNIACC_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESTAUNIACC_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESTAUNIACC' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESTAUNIACC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESTAUNIACC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESTAUNIACC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTAUNIACC];
GO
IF OBJECT_ID('U_ESTAUNIACC_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESTAUNIACC_PEarHist];
GO
IF OBJECT_ID('U_ESTAUNIACC_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESTAUNIACC_PDedHist];
GO
IF OBJECT_ID('U_ESTAUNIACC_File') IS NOT NULL DROP TABLE [dbo].[U_ESTAUNIACC_File];
GO
IF OBJECT_ID('U_ESTAUNIACC_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESTAUNIACC_EEList];
GO
IF OBJECT_ID('U_ESTAUNIACC_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTAUNIACC_drvTbl];
GO
IF OBJECT_ID('U_ESTAUNIACC_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESTAUNIACC_DedList];
GO
IF OBJECT_ID('U_ESTAUNIACC_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESTAUNIACC_AuditFields];
GO
IF OBJECT_ID('U_ESTAUNIACC_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESTAUNIACC_Audit];
GO
IF OBJECT_ID('U_ESTAUNIACC_Accrual') IS NOT NULL DROP TABLE [dbo].[U_ESTAUNIACC_Accrual];
GO
IF OBJECT_ID('U_dsi_BDM_ESTAUNIACC') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESTAUNIACC];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESTAUNIACC';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESTAUNIACC';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESTAUNIACC';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESTAUNIACC';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESTAUNIACC';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESTAUNIACC','UniFocus Employee Accrual','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ESTAUNIACCZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESTAUNIACC' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','1','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','1',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Alternate Employee Number"','2','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','2',NULL,'Alternate Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Badge Number"','3','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','3',NULL,'Badge Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','4','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','4',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','5','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','5',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','6','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','6',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Status"','7','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','7',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Status Change Reason Code"','8','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','8',NULL,'Status Change Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Type"','9','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','9',NULL,'Employee Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date"','10','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','10',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Re-Hire Date"','11','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','11',NULL,'Re-Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Seniority Date"','12','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','12',NULL,'Seniority Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','13','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','13',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOA Date"','14','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','14',NULL,'LOA Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOA Return Date"','15','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','15',NULL,'LOA Return Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Available"','16','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','16',NULL,'Hours Available',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Class Code"','17','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','17',NULL,'Work Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Class Code"','18','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','18',NULL,'Primary Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Secondary Class Code"','19','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','19',NULL,'Secondary Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Birth Date"','20','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','20',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','21','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','21',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Tipped"','22','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','22',NULL,'Tipped',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','23','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','23',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','24','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','24',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','25','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','25',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','26','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','26',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','27','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','27',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','28','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','28',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mobile Phone"','29','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','29',NULL,'Mobile Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Other Phone"','30','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','30',NULL,'Other Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','31','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','31',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emergency Contact"','32','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','32',NULL,'Emergency Contact',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emergency Phone"','33','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','33',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','34','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','34',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Number of Dependents"','35','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','35',NULL,'Number of Dependents',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Ethnicity"','36','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','36',NULL,'Ethnicity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADA Code"','37','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','37',NULL,'ADA Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Property Code"','38','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','38',NULL,'Property Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Order"','39','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','39',NULL,'Job Order',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Code"','40','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','40',NULL,'ADA Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Date"','41','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','41',NULL,'Job Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Rank"','42','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','42',NULL,'Job Rank',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Rate Type"','43','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','43',NULL,'Job Rate Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Hourly Rate"','44','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','44',NULL,'Job Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Annual Rate"','45','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','45',NULL,'Job Annual Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Rate Date"','46','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','46',NULL,'Job Rate Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accrual PTO"','47','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','47',NULL,'Accrual PTO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accrual Sick"','48','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','48',NULL,'Accrual Sick',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accrual Vacation"','49','(''DA''=''T,'')','ESTAUNIACCZ0','50','H','01','49',NULL,'Accrual Vacation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accrual Personal"','50','(''DA''=''T'')','ESTAUNIACCZ0','50','H','01','50',NULL,'Accrual Personal',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','1','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','1',NULL,'drvEmployeeNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAlternateEmployeeNumber"','2','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','2',NULL,'drvAlternateEmployeeNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBadgeNumber"','3','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','3',NULL,'drvBadgeNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','4','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','4',NULL,'drvFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','5','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','5',NULL,'drvMiddleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','6','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','6',NULL,'drvLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','7','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','7',NULL,'drvEmployeeStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusChangeReasonCode"','8','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','8',NULL,'drvStatusChangeReasonCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','9','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','9',NULL,'drvEmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','10','(''UD101''=''T,'')','ESTAUNIACCZ0','50','D','10','10',NULL,'drvHireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReHireDate"','11','(''UD101''=''T,'')','ESTAUNIACCZ0','50','D','10','11',NULL,'drvReHireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeniorityDate"','12','(''UD101''=''T,'')','ESTAUNIACCZ0','50','D','10','12',NULL,'drvSeniorityDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','13','(''UD101''=''T,'')','ESTAUNIACCZ0','50','D','10','13',NULL,'drvTerminationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOADate"','14','(''UD101''=''T,'')','ESTAUNIACCZ0','50','D','10','14',NULL,'drvLOADate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAReturnDate"','15','(''UD101''=''T,'')','ESTAUNIACCZ0','50','D','10','15',NULL,'drvLOAReturnDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursAvailable"','16','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','16',NULL,'drvHoursAvailable',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkClassCode"','17','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','17',NULL,'drvWorkClassCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimaryClassCode"','18','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','18',NULL,'drvPrimaryClassCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSecondaryClassCode"','19','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','19',NULL,'drvSecondaryClassCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','20','(''UD101''=''T,'')','ESTAUNIACCZ0','50','D','10','20',NULL,'drvBirthDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','21','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','21',NULL,'drvGender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTipped"','22','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','22',NULL,'drvTipped',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','23','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','23',NULL,'drvAddressLine1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','24','(''UD101''=''T,'')','ESTAUNIACCZ0','50','D','10','24',NULL,'drvAddressLine2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','25','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','25',NULL,'drvCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','26','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','26',NULL,'drvState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','27','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','27',NULL,'drvZip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','28','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','28',NULL,'drvHomePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMobilePhone"','29','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','29',NULL,'drvMobilePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOtherPhone"','30','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','30',NULL,'drvOtherPhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','31','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','31',NULL,'drvEmailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmergencyContact"','32','(''UA''=''T,'')','ESTAUNIACCZ0','20','D','10','32',NULL,'drvEmergencyContact',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmergencyPhone"','33','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','33',NULL,'drvEmergencyPhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','34','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','34',NULL,'drvMaritalStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberOfDependents"','35','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','35',NULL,'drvNumberOfDependents',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEthnicity"','36','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','36',NULL,'drvEthnicity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADACode"','37','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','37',NULL,'drvADACode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPropertyCode"','38','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','38',NULL,'drvPropertyCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobOrder"','39','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','39',NULL,'drvJobOrder',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobCode"','40','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','40',NULL,'drvJobCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobDate"','41','(''UD101''=''T,'')','ESTAUNIACCZ0','50','D','10','41',NULL,'drvJobDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobRank"','42','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','42',NULL,'drvJobRank',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobRateType"','43','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','43',NULL,'drvJobRateType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobHourlyRate"','44','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','44',NULL,'drvJobHourlyRate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobAnnualRate"','45','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','45',NULL,'drvJobAnnualRate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobRateDate"','46','(''UD101''=''T,'')','ESTAUNIACCZ0','50','D','10','46',NULL,'drvJobRateDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccrualPTO"','47','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','47',NULL,'drvAccrualPTO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccrualSick"','48','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','48',NULL,'drvAccrualSick',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccrualVacation"','49','(''UA''=''T,'')','ESTAUNIACCZ0','50','D','10','49',NULL,'drvAccrualVacation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccrualPersonal"','50','(''UA''=''T'')','ESTAUNIACCZ0','50','D','10','50',NULL,'drvAccrualPersonal',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ESTAUNIACC_20210831.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,' Ondemand','202106239','EMPEXPORT','ONDEM_XOE','Jul 15 2021 12:00AM','ESTAUNIACC',NULL,NULL,NULL,'202106239','Jun 23 2021 12:00AM','Dec 30 1899 12:00AM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,' Scheduled','202106239','EMPEXPORT','SCH_ACCEX','Jul 15 2021 12:00AM','ESTAUNIACC',NULL,NULL,NULL,'202106239','Jun 23 2021 12:00AM','Dec 30 1899 12:00AM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'TEST','202108269','EMPEXPORT','TEST_XOE','Aug 26 2021  6:24PM','ESTAUNIACC',NULL,NULL,NULL,'202108269','Aug 26 2021 12:00AM','Dec 30 1899 12:00AM','202108261','1360','','','202108261',dbo.fn_GetTimedKey(),NULL,'us3jReSTA1022',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAUNIACC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAUNIACC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAUNIACC','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAUNIACC','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAUNIACC','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAUNIACC','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ESTAUNIACC' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ESTAUNIACC' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ESTAUNIACC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTAUNIACC_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAUNIACC','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAUNIACC','D10','dbo.U_ESTAUNIACC_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ESTAUNIACC') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESTAUNIACC] (
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
IF OBJECT_ID('U_ESTAUNIACC_Accrual') IS NULL
CREATE TABLE [dbo].[U_ESTAUNIACC_Accrual] (
    [Eaceeid] char(12) NOT NULL,
    [Eaccoid] char(5) NOT NULL,
    [PTO] numeric NULL,
    [SICK] numeric NULL,
    [VACATION] numeric NULL,
    [PERS] numeric NULL
);
IF OBJECT_ID('U_ESTAUNIACC_Audit') IS NULL
CREATE TABLE [dbo].[U_ESTAUNIACC_Audit] (
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
IF OBJECT_ID('U_ESTAUNIACC_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESTAUNIACC_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ESTAUNIACC_DedList') IS NULL
CREATE TABLE [dbo].[U_ESTAUNIACC_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESTAUNIACC_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTAUNIACC_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(6) NULL,
    [drvSubSort] char(9) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvAlternateEmployeeNumber] varchar(1) NOT NULL,
    [drvBadgeNumber] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvLastName] varchar(100) NULL,
    [drvEmployeeStatus] varchar(1) NULL,
    [drvStatusChangeReasonCode] varchar(1) NOT NULL,
    [drvEmployeeType] varchar(1) NULL,
    [drvHireDate] datetime NULL,
    [drvReHireDate] datetime NULL,
    [drvSeniorityDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvLOADate] datetime NULL,
    [drvLOAReturnDate] varchar(1) NOT NULL,
    [drvHoursAvailable] varchar(1) NOT NULL,
    [drvWorkClassCode] char(1) NULL,
    [drvPrimaryClassCode] varchar(1) NOT NULL,
    [drvSecondaryClassCode] varchar(1) NOT NULL,
    [drvBirthDate] varchar(1) NOT NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvTipped] char(1) NULL,
    [drvAddressLine1] nvarchar(258) NULL,
    [drvAddressLine2] nvarchar(258) NULL,
    [drvCity] nvarchar(258) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvMobilePhone] varchar(50) NULL,
    [drvOtherPhone] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvEmailAddressOld] varchar(50) NULL,
    [drvEmergencyContact] varchar(1) NOT NULL,
    [drvEmergencyPhone] varchar(1) NOT NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvNumberOfDependents] varchar(1) NOT NULL,
    [drvEthnicity] varchar(1) NOT NULL,
    [drvADACode] varchar(1) NOT NULL,
    [drvPropertyCode] char(6) NULL,
    [drvJobOrder] varchar(1) NOT NULL,
    [drvJobCode] varchar(15) NULL,
    [drvJobDate] datetime NULL,
    [drvJobRank] varchar(1) NOT NULL,
    [drvJobRateType] char(1) NULL,
    [drvJobHourlyRate] varchar(30) NULL,
    [drvJobAnnualRate] varchar(30) NULL,
    [drvJobRateDate] datetime NULL,
    [drvAccrualPTO] varchar(30) NULL,
    [drvAccrualSick] varchar(30) NULL,
    [drvAccrualVacation] varchar(30) NULL,
    [drvAccrualPersonal] varchar(30) NULL
);
IF OBJECT_ID('U_ESTAUNIACC_EEList') IS NULL
CREATE TABLE [dbo].[U_ESTAUNIACC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESTAUNIACC_File') IS NULL
CREATE TABLE [dbo].[U_ESTAUNIACC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_ESTAUNIACC_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESTAUNIACC_PDedHist] (
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
IF OBJECT_ID('U_ESTAUNIACC_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESTAUNIACC_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTAUNIACC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Standard Int Mgmt

Created By: Marco Lagrosa
Business Analyst: Julie Reardon
Create Date: 07/14/2021
Service Request Number:  TekP-2021-05-20-0002

Purpose: UniFocus Employee Accrual

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESTAUNIACC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESTAUNIACC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESTAUNIACC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESTAUNIACC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESTAUNIACC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAUNIACC', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAUNIACC', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAUNIACC', 'SCH_ACCEX';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESTAUNIACC';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESTAUNIACC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESTAUNIACC';

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
    DELETE FROM dbo.U_ESTAUNIACC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESTAUNIACC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
   /* DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CU,401F,401P,ROTD,ROTP'; 

    IF OBJECT_ID('U_ESTAUNIACC_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAUNIACC_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESTAUNIACC_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;
*/

    --==========================================
    -- BDM Section
    --==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
   /* IF OBJECT_ID('U_ESTAUNIACC_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAUNIACC_PDedHist;
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
        ,PdhLoan1     = SUM(CASE WHEN PdhDedCode IN ('KLN1') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLoan2     = SUM(CASE WHEN PdhDedCode IN ('KLN2') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhPlanComp     = SUM(CASE WHEN PdhDedCode IN ('401CU', '401F', '401P', 'ROTD' ,'ROTP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhDedCalcBasisAmt  ELSE 0.00 END)
        ,PdhPlanCompYTD     = SUM(CASE WHEN PdhDedCode IN ('401CU', '401F', '401P', 'ROTD' ,'ROTP')  THEN PdhDedCalcBasisAmt  ELSE 0.00 END)


    INTO dbo.U_ESTAUNIACC_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESTAUNIACC_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ESTAUNIACC_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAUNIACC_PEarHist;
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

    INTO dbo.U_ESTAUNIACC_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    */

    IF OBJECT_ID('U_ESTAUNIACC_Accrual','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAUNIACC_Accrual;
    SELECT DISTINCT
         Eaceeid
        ,Eaccoid
        ,PTO           = SUM(CASE WHEN EacAccrCode = 'PTO' THEN EacAccrAllowedCurBal  - EacAccrTakenCurBal END)       
        ,SICK          = SUM(CASE WHEN EacAccrCode = 'ILLNES' THEN EacAccrAllowedCurBal  - EacAccrTakenCurBal END)        
        ,VACATION      = SUM(CASE WHEN EacAccrCode = 'VACAT' THEN EacAccrAllowedCurBal  - EacAccrTakenCurBal END)    
        ,PERS      = SUM(CASE WHEN EacAccrCode = 'PERS' THEN EacAccrAllowedCurBal  - EacAccrTakenCurBal END)        
    
    INTO dbo.U_ESTAUNIACC_Accrual
    FROM dbo.EmpAccr  WITH (NOLOCK)
    GROUP BY Eaceeid,Eaccoid
    

    
    --Audit Table
    IF OBJECT_ID('U_ESTAUNIACC_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAUNIACC_AuditFields;
    CREATE TABLE dbo.U_ESTAUNIACC_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ESTAUNIACC_AuditFields VALUES ('EmpComp','EecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ESTAUNIACC_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAUNIACC_Audit;
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
    INTO dbo.U_ESTAUNIACC_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ESTAUNIACC_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ESTAUNIACC_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate - 180 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESTAUNIACC_Audit ON dbo.U_ESTAUNIACC_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESTAUNIACC_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTAUNIACC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAUNIACC_drvTbl;
    SELECT 
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eecpaygroup
        ,drvSubSort = EecEmpNo
        ,drvSubSort2 =  CASE WHEN EejIsPrimaryJob = 'Y' THEN '1' ELSE '2' END
        -- standard fields above and additional driver fields below
        ,drvEmployeeNumber = EecEmpNo
        ,drvAlternateEmployeeNumber = ''
        ,drvBadgeNumber = ''
        ,drvFirstName = eepNameFirst
        ,drvMiddleName = EepNameMiddle
        ,drvLastName = EepNameLast
        ,drvEmployeeStatus = CASE WHEN eecEmplStatus = 'A' and EecDateOfOriginalHire <> EecDateOfLastHire THEN 'R'
                                 WHEN eecEmplStatus in ('O','R','S') THEN 'L'
                                 ELSE eecEmplStatus
                            END
        ,drvStatusChangeReasonCode = ''
        ,drvEmployeeType = CASE WHEN eecSalaryOrHourly = 'H' THEN 'V' ELSE EecSalaryOrHourly END
        ,drvHireDate = EecDateOfOriginalHire
        ,drvReHireDate = CASE WHEN EecDateOfOriginalHire < EecDateOfLastHire THEN  EecDateOfLastHire END
        ,drvSeniorityDate = EecDateOfSeniority
        ,drvTerminationDate = EecDateOfTermination
        ,drvLOADate = CASE WHEN eecEmplStatus = 'L' THEN EecEmplStatusStartDate END
        ,drvLOAReturnDate = ''
        ,drvHoursAvailable = ''
        ,drvWorkClassCode = EecFullTimeorPartTime
        ,drvPrimaryClassCode = ''
        ,drvSecondaryClassCode = ''
        ,drvBirthDate = ''
        ,drvGender = ''
        ,drvTipped = CASE WHEN EejIsPrimaryJob = 'Y' THEN (Select top 1 JbcTipType from dbo.JobCode WITH (NOLOCK)  where JbcJobCode = EejJobCode) END 
 
        ,drvAddressLine1 = QuoteName(EepAddressLine1,'"')
        ,drvAddressLine2 = QuoteName(EepAddressLine2,'"')
        ,drvCity = QuoteName(EepAddressCity,'"')
        ,drvState = EepAddressState
        ,drvZip = Eepaddresszipcode
        ,drvHomePhone = CASE WHEN EepPhoneHomeIsPrivate  = 'N' THEN EepPhoneHomeNumber  END
        ,drvMobilePhone = (Select top 1 efoPhoneNumber  from dbo.EmpMPhon where efoPhoneType  = 'CEL' and efoeeid = xEEID and efoIsPrivate = 'N')
        ,drvOtherPhone = ''
        ,drvEmailAddress = EepAddressEMailAlternate
        ,drvEmailAddressOld = eepAddressEmail

        ,drvEmergencyContact = ''
        ,drvEmergencyPhone = ''
        ,drvMaritalStatus = ''
        ,drvNumberOfDependents = ''
        ,drvEthnicity = ''
        ,drvADACode = ''
        ,drvPropertyCode = eecpaygroup
        ,drvJobOrder = CASE WHEN EejIsPrimaryJob = 'Y' THEN '1' ELSE '2' END
        ,drvJobCode = RTRIM(eecpaygroup) + '-' + RTRIM(eejJobCode)
        ,drvJobDate = EejDateInJob
        ,drvJobRank =  ''
        ,drvJobRateType = EecSalaryOrHourly
        ,drvJobHourlyRate = CASE WHEN EecSalaryOrHourly= 'H' THEN CAST( CONVERT(DECIMAL(9,2),EejHourlyPayRate) as varchar)  END
        ,drvJobAnnualRate =  CASE WHEN EecSalaryOrHourly= 'S' THEN CAST( CONVERT(DECIMAL(9,2),EejAnnPayRate) as varchar)  END
        ,drvJobRateDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, GETDATE(),EecDateOfLastHire) 
        ,drvAccrualPTO =  CAST(CONVERT(DECIMAL(9,4),PTO) as varchar)
        ,drvAccrualSick =  CAST(CONVERT(DECIMAL(9,4),SICK) as varchar) 
        ,drvAccrualVacation = CAST(CONVERT(DECIMAL(9,4),VACATION) as varchar) 
        ,drvAccrualPersonal = CAST(CONVERT(DECIMAL(9,4),PERS) as varchar) 
    INTO dbo.U_ESTAUNIACC_drvTbl
    FROM dbo.U_ESTAUNIACC_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_ESTAUNIACC_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Company WITH (NOLOCK)
        on CmpCoid =  xcoid
    /*LEFT JOIN (Select * from (
Select EejIsPrimaryJob,eejeeid,eejcoid, ROW_NUMBER() OVER(PARTITION BY eejeeid, eejcoid ORDER BY eejdateInJob DESC) as RowNumber from dbo.EmpMJobs
) A where RowNumber =  1) as Jobs
    on eejeeid = xeeid 
    and eejcoid = xcoid
    */
    LEFT JOIN dbo.EmpMJobs WITH (NOLOCK)
    on eejeeid = xeeid 
    and eejcoid = xcoid
    and eejJobIsInActive = 'N'
    LEFT JOIN  dbo.U_ESTAUNIACC_Accrual
        ON eaceeid =  xeeid
        and eaccoid = xcoid
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
ALTER VIEW dbo.dsi_vwESTAUNIACC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTAUNIACC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESTAUNIACC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106161'
       ,expStartPerControl     = '202106161'
       ,expLastEndPerControl   = '202106239'
       ,expEndPerControl       = '202106239'
WHERE expFormatCode = 'ESTAUNIACC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESTAUNIACC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTAUNIACC_File (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2;