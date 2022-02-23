SET NOCOUNT ON;
IF OBJECT_ID('U_EVMAKCS401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVMAKCS401_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EVMAKCS401_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EVMAKCS401' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEVMAKCS401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEVMAKCS401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EVMAKCS401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVMAKCS401];
GO
IF OBJECT_ID('U_EVMAKCS401_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EVMAKCS401_Trailer];
GO
IF OBJECT_ID('U_EVMAKCS401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EVMAKCS401_PEarHist];
GO
IF OBJECT_ID('U_EVMAKCS401_PDedHist_YTD') IS NOT NULL DROP TABLE [dbo].[U_EVMAKCS401_PDedHist_YTD];
GO
IF OBJECT_ID('U_EVMAKCS401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EVMAKCS401_PDedHist];
GO
IF OBJECT_ID('U_EVMAKCS401_File') IS NOT NULL DROP TABLE [dbo].[U_EVMAKCS401_File];
GO
IF OBJECT_ID('U_EVMAKCS401_EEList') IS NOT NULL DROP TABLE [dbo].[U_EVMAKCS401_EEList];
GO
IF OBJECT_ID('U_EVMAKCS401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVMAKCS401_drvTbl];
GO
IF OBJECT_ID('U_EVMAKCS401_DedList') IS NOT NULL DROP TABLE [dbo].[U_EVMAKCS401_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EVMAKCS401';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EVMAKCS401';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EVMAKCS401';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EVMAKCS401';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EVMAKCS401';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EVMAKCS401','Charles Schwab 401(k) Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','S','N','EVMAKCS401Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Record ID"','1','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','1',NULL,'Record ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan ID"','2','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','2',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number"','3','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','3',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Name"','4','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','4',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution Source 1"','5','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','5',NULL,'Contribution Source 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution Source 2"','6','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','6',NULL,'Contribution Source 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution Source 3"','7','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','7',NULL,'Contribution Source 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution Source 4"','8','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','8',NULL,'Contribution Source 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution Source 5"','9','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','9',NULL,'Contribution Source 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution Source 6"','10','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','10',NULL,'Contribution Source 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution Source 7"','11','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','11',NULL,'Contribution Source 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution Source 8"','12','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','12',NULL,'Contribution Source 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution Source 9"','13','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','13',NULL,'Contribution Source 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution Source 10"','14','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','14',NULL,'Contribution Source 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment #1"','15','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','15',NULL,'Loan Payment #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment #2"','16','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','16',NULL,'Loan Payment #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment #3"','17','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','17',NULL,'Loan Payment #3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment #4"','18','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','18',NULL,'Loan Payment #4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Payment #5"','19','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','19',NULL,'Loan Payment #5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Deferral / Allocation Compensation"','20','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','20',NULL,'Pay Period Deferral / Allocation Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Plan Testing Compensation"','21','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','21',NULL,'Pay Period Plan Testing Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Total Compensation"','22','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','22',NULL,'Pay Period Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Additional Compensation"','23','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','23',NULL,'Pay Period Additional Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Hours Paid"','24','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','24',NULL,'Pay Period Hours Paid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Contribution Source 1"','25','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','25',NULL,'Plan YTD Contribution Source 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Contribution Source 2"','26','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','26',NULL,'Plan YTD Contribution Source 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Contribution Source 3"','27','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','27',NULL,'Plan YTD Contribution Source 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Contribution Source 4"','28','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','28',NULL,'Plan YTD Contribution Source 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Contribution Source 5"','29','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','29',NULL,'Plan YTD Contribution Source 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Contribution Source 6"','30','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','30',NULL,'Plan YTD Contribution Source 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Contribution Source 7"','31','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','31',NULL,'Plan YTD Contribution Source 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Contribution Source 8"','32','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','32',NULL,'Plan YTD Contribution Source 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Contribution Source 9"','33','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','33',NULL,'Plan YTD Contribution Source 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Contribution Source 10"','34','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','34',NULL,'Plan YTD Contribution Source 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Deferral / Allocation Compensation"','35','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','35',NULL,'Plan YTD Deferral / Allocation Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Plan Testing Compensation"','36','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','36',NULL,'YTD Plan Testing Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Total Compensation"','37','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','37',NULL,'Plan YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Additional Compensation"','38','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','38',NULL,'YTD Additional Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary"','39','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','39',NULL,'Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan YTD Hours Paid"','40','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','40',NULL,'Plan YTD Hours Paid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Frequency"','41','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','41',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Address Line #1"','42','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','42',NULL,'Primary Address Line #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Address Line #2"','43','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','43',NULL,'Primary Address Line #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary City"','44','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','44',NULL,'Primary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary State"','45','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','45',NULL,'Primary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Zip Code"','46','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','46',NULL,'Primary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Country"','47','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','47',NULL,'Primary Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Foreign Address Indicator"','48','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','48',NULL,'Foreign Address Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Birth Date"','49','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','49',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date (original)"','50','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','50',NULL,'Hire Date (original)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Entry Date"','51','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','51',NULL,'Plan Entry Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Entry Date    (for another source with different eligibility)"','52','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','52',NULL,'Plan Entry Date    (for another source with differ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Entry Date    (for another source with different eligibility)"','53','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','53',NULL,'Plan Entry Date    (for another source with differ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Entry Date    (for another source with different eligibility)"','54','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','54',NULL,'Plan Entry Date    (for another source with differ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date (if applicable)"','55','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','55',NULL,'Termination Date (if applicable)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date (date of most recent rehire)"','56','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','56',NULL,'Rehire Date (date of most recent rehire)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Alternate Vesting Date"','57','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','57',NULL,'Alternate Vesting Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Restricted Status (officer status field)"','58','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','58',NULL,'Restricted Status (officer status field)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan Restriction"','59','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','59',NULL,'Loan Restriction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Collective Bargaining Indicator"','60','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','60',NULL,'Collective Bargaining Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Status"','61','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','61',NULL,'Payroll Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Highly Compensated Status (HCE)"','62','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','62',NULL,'Highly Compensated Status (HCE)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Ineligible Status"','63','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','63',NULL,'Ineligible Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Location"','64','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','64',NULL,'Pay Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Division"','65','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','65',NULL,'Reporting Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Alternate Key #1"','66','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','66',NULL,'Alternate Key #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Alternate Key #2"','67','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','67',NULL,'Alternate Key #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Transfer Indicator"','68','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','68',NULL,'Transfer Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work/Home Telephone Number"','69','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','69',NULL,'Work/Home Telephone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Corporate e-mail Address"','70','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','70',NULL,'Corporate e-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Language Preference Code"','71','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','71',NULL,'Language Preference Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender Code"','72','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','72',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status – Taxable"','73','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','73',NULL,'Marital Status – Taxable',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Federal Exemptions"','74','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','74',NULL,'Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Code Indicator"','75','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','75',NULL,'Job Code Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Leave of Absence – Start Date"','76','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','76',NULL,'Leave of Absence – Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Leave of Absence – End Date"','77','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','77',NULL,'Leave of Absence – End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Leave of Absence Indicator"','78','(''DA''=''T,'')','EVMAKCS401Z0','50','H','01','78',NULL,'Leave of Absence Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Retirement Date"','79','(''DA''=''T'')','EVMAKCS401Z0','50','H','01','79',NULL,'Retirement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Death Date"','80','(''DA''=''T'')','EVMAKCS401Z0','50','H','01','80',NULL,'Death Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Filler"','81','(''DA''=''T'')','EVMAKCS401Z0','50','H','01','81',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"100"','1','(''DA''=''T,'')','EVMAKCS401Z0','50','D','10','1',NULL,'Record ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VFG"','2','(''DA''=''T,'')','EVMAKCS401Z0','50','D','10','2',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','3',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','4','(''UA''=''T,'')','EVMAKCS401Z0','100','D','10','4',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv401K"','5','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','5',NULL,'Contribution Source 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRoth"','6','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','6',NULL,'Contribution Source 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource3"','7','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','7',NULL,'Contribution Source 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource4"','8','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','8',NULL,'Contribution Source 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource5"','9','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','9',NULL,'Contribution Source 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource6"','10','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','10',NULL,'Contribution Source 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource7"','11','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','11',NULL,'Contribution Source 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource8"','12','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','12',NULL,'Contribution Source 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource9"','13','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','13',NULL,'Contribution Source 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource10"','14','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','14',NULL,'Contribution Source 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment1"','15','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','15',NULL,'Loan Payment #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment2"','16','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','16',NULL,'Loan Payment #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment3"','17','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','17',NULL,'Loan Payment #3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment4"','18','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','18',NULL,'Loan Payment #4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment5"','19','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','19',NULL,'Loan Payment #5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodDefererral"','20','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','20',NULL,'Pay Period Deferral / Allocation Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodPlanTesting"','21','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','21',NULL,'Pay Period Plan Testing Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodTotalCompensation"','22','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','22',NULL,'Pay Period Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodAdditionalComp"','23','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','23',NULL,'Pay Period Additional Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodHours"','24','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','24',NULL,'Pay Period Hours Paid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv401KYtd"','25','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','25',NULL,'Plan YTD Contribution Source 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRothYtd"','26','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','26',NULL,'Plan YTD Contribution Source 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceYTD3"','27','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','27',NULL,'Plan YTD Contribution Source 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceYTD4"','28','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','28',NULL,'Plan YTD Contribution Source 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceYTD5"','29','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','29',NULL,'Plan YTD Contribution Source 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceYTD6"','30','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','30',NULL,'Plan YTD Contribution Source 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceYTD7"','31','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','31',NULL,'Plan YTD Contribution Source 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceYTD8"','32','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','32',NULL,'Plan YTD Contribution Source 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceYTD9"','33','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','33',NULL,'Plan YTD Contribution Source 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceYTD10"','34','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','34',NULL,'Plan YTD Contribution Source 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDDeferralComp"','35','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','35',NULL,'Plan YTD Deferral / Allocation Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPlanTestingComp"','36','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','36',NULL,'YTD Plan Testing Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTotalCompensation"','37','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','37',NULL,'Plan YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDAddtionalComp"','38','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','38',NULL,'YTD Additional Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','39','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','39',NULL,'Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDHoursPaid"','40','(''UNPN''=''T,'')','EVMAKCS401Z0','12','D','10','40',NULL,'Plan YTD Hours Paid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','41','(''UA''=''T,'')','EVMAKCS401Z0','12','D','10','41',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','42','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','42',NULL,'Primary Address Line #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','43','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','43',NULL,'Primary Address Line #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','44','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','44',NULL,'Primary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','45','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','45',NULL,'Primary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','46','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','46',NULL,'Primary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','47','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','47',NULL,'Primary Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvForeignIndicator"','48','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','48',NULL,'Foreign Address Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','49','(''UD101''=''T,'')','EVMAKCS401Z0','50','D','10','49',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','50','(''UD101''=''T,'')','EVMAKCS401Z0','50','D','10','50',NULL,'Hire Date (original)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDatePlanEntry"','51','(''UD101''=''T,'')','EVMAKCS401Z0','50','D','10','51',NULL,'Plan Entry Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDatePlanEntry2"','52','(''UD101''=''T,'')','EVMAKCS401Z0','50','D','10','52',NULL,'Plan Entry Date    (for another source with differ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDatePlanEntry3"','53','(''UD101''=''T,'')','EVMAKCS401Z0','50','D','10','53',NULL,'Plan Entry Date    (for another source with differ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDatePlanEntry4"','54','(''UD101''=''T,'')','EVMAKCS401Z0','50','D','10','54',NULL,'Plan Entry Date    (for another source with differ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvdateOfTermination"','55','(''UD101''=''T,'')','EVMAKCS401Z0','50','D','10','55',NULL,'Termination Date (if applicable)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','56','(''UD101''=''T,'')','EVMAKCS401Z0','50','D','10','56',NULL,'Rehire Date (date of most recent rehire)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateVesting"','57','(''UD101''=''T,'')','EVMAKCS401Z0','50','D','10','57',NULL,'Alternate Vesting Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRestrictedStatus"','58','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','58',NULL,'Restricted Status (officer status field)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRestriction"','59','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','59',NULL,'Loan Restriction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBargainingIndicator"','60','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','60',NULL,'Collective Bargaining Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollStatus"','61','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','61',NULL,'Payroll Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHighlyCompensated"','62','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','62',NULL,'Highly Compensated Status (HCE)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIneligibleStatus"','63','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','63',NULL,'Ineligible Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollAllocation"','64','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','64',NULL,'Pay Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportingDivision"','65','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','65',NULL,'Reporting Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAltKey1"','66','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','66',NULL,'Alternate Key #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAltKey2"','67','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','67',NULL,'Alternate Key #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransferIndicator"','68','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','68',NULL,'Transfer Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"330-576-1234 "','69','(''DA''=''T,'')','EVMAKCS401Z0','50','D','10','69',NULL,'Work/Home Telephone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','70','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','70',NULL,'Corporate e-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguagePrefCode"','71','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','71',NULL,'Language Preference Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','72','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','72',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','73','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','73',NULL,'Marital Status – Taxable',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFedExemption"','74','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','74',NULL,'Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobCodeIndicator"','75','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','75',NULL,'Job Code Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateStartLOA"','76','(''UD101''=''T,'')','EVMAKCS401Z0','50','D','10','76',NULL,'Leave of Absence – Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateEndLOA"','77','(''UD101''=''T,'')','EVMAKCS401Z0','50','D','10','77',NULL,'Leave of Absence – End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAIndicator"','78','(''UA''=''T,'')','EVMAKCS401Z0','50','D','10','78',NULL,'Leave of Absence Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateRetirement"','79','(''UD101''=''T,'')','EVMAKCS401Z0','50','D','10','79',NULL,'Retirement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateDeathDate"','80','(''UD101''=''T'')','EVMAKCS401Z0','50','D','10','80',NULL,'Death Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller"','81','(''UA''=''T'')','EVMAKCS401Z0','50','D','10','81',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"101"','1','(''DA''=''T,'')','EVMAKCS401Z0','50','T','90','1',NULL,'Record ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VFG"','2','(''DA''=''T,'')','EVMAKCS401Z0','50','T','90','2',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDatePayPeriod"','3','(''UD101''=''T,'')','EVMAKCS401Z0','50','T','90','3',NULL,'Pay Period Ending Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv401kTotal"','4','(''UNPN''=''T,'')','EVMAKCS401Z0','12','T','90','4',NULL,'Contribution Source 1 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRothTotal"','5','(''UNPN''=''T,'')','EVMAKCS401Z0','12','T','90','5',NULL,'Contribution Source 2 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrubtion3"','6','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','6',NULL,'Contribution Source 3 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrubtion4"','7','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','7',NULL,'Contribution Source 4 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrubtion5"','8','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','8',NULL,'Contribution Source 5 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrubtion6"','9','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','9',NULL,'Contribution Source 6 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrubtion7"','10','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','10',NULL,'Contribution Source 7 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrubtion8"','11','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','11',NULL,'Contribution Source 8 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrubtion9"','12','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','12',NULL,'Contribution Source 9 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrubtion10"','13','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','13',NULL,'Contribution Source 10 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentTotal"','14','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','14',NULL,'Loan Payment #1 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentTotal2"','15','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','15',NULL,'Loan Payment #2 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentTotal3"','16','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','16',NULL,'Loan Payment #3 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentTotal4"','17','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','17',NULL,'Loan Payment #4 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentTotal5"','18','(''UNPN''=''T'')','EVMAKCS401Z0','12','T','90','18',NULL,'Loan Payment #5 Total',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVMAKCS401_20190827.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','201907319','EMPEXPORT','SCHEDULED','Aug  6 2019 11:09AM','EVMAKCS401',NULL,NULL,NULL,'201907319','Jul 31 2019  2:45PM','Jul 31 2019  2:45PM','201907311','120','','','201907311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVMAKCS401_20190827.txt',NULL,'','','V4D2R',NULL,NULL,NULL,'Charles Schwab 401(k) Export','201907319','EMPEXPORT','ONDEMAND','Aug 15 2019 12:31PM','EVMAKCS401',NULL,NULL,NULL,'201907319','Jul 31 2019 12:00AM','Dec 30 1899 12:00AM','201907311','178','','','201907311',dbo.fn_GetTimedKey(),NULL,'us3mLaVAL1007',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVMAKCS401_20190827.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201907319','EMPEXPORT','TEST','Aug 19 2019  9:51AM','EVMAKCS401',NULL,NULL,NULL,'201907319','Jul 31 2019 12:00AM','Dec 30 1899 12:00AM','201907311','178','','','201907311',dbo.fn_GetTimedKey(),NULL,'us3lKiVAL1007',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EVMAKCS401_20190827.txt' END WHERE expFormatCode = 'EVMAKCS401';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVMAKCS401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVMAKCS401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVMAKCS401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVMAKCS401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVMAKCS401','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EVMAKCS401' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EVMAKCS401' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EVMAKCS401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVMAKCS401_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVMAKCS401','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVMAKCS401','D10','dbo.U_EVMAKCS401_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVMAKCS401','T90','dbo.U_EVMAKCS401_Trailer',NULL);
IF OBJECT_ID('U_EVMAKCS401_DedList') IS NULL
CREATE TABLE [dbo].[U_EVMAKCS401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EVMAKCS401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVMAKCS401_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSSN] varchar(13) NULL,
    [drvLastName] varchar(32) NULL,
    [drv401K] numeric NULL,
    [drvRoth] numeric NULL,
    [drvSource3] numeric NULL,
    [drvSource4] varchar(1) NOT NULL,
    [drvSource5] varchar(1) NOT NULL,
    [drvSource6] varchar(1) NOT NULL,
    [drvSource7] varchar(1) NOT NULL,
    [drvSource8] varchar(1) NOT NULL,
    [drvSource9] varchar(1) NOT NULL,
    [drvSource10] varchar(1) NOT NULL,
    [drvLoanPayment1] numeric NULL,
    [drvLoanPayment2] varchar(1) NOT NULL,
    [drvLoanPayment3] varchar(1) NOT NULL,
    [drvLoanPayment4] varchar(1) NOT NULL,
    [drvLoanPayment5] varchar(1) NOT NULL,
    [drvPayPeriodDefererral] money NULL,
    [drvPayPeriodPlanTesting] money NULL,
    [drvPayPeriodTotalCompensation] money NULL,
    [drvPayPeriodAdditionalComp] varchar(1) NOT NULL,
    [drvPayPeriodHours] varchar(1) NOT NULL,
    [drv401KYtd] numeric NULL,
    [drvRothYtd] numeric NULL,
    [drvSourceYTD3] numeric NULL,
    [drvSourceYTD4] varchar(1) NOT NULL,
    [drvSourceYTD5] varchar(1) NOT NULL,
    [drvSourceYTD6] varchar(1) NOT NULL,
    [drvSourceYTD7] varchar(1) NOT NULL,
    [drvSourceYTD8] varchar(1) NOT NULL,
    [drvSourceYTD9] varchar(1) NOT NULL,
    [drvSourceYTD10] varchar(1) NOT NULL,
    [drvYTDDeferralComp] money NULL,
    [drvYTDPlanTestingComp] money NULL,
    [drvYTDTotalCompensation] money NULL,
    [drvYTDAddtionalComp] varchar(1) NOT NULL,
    [drvAnnualSalary] money NULL,
    [drvYTDHoursPaid] decimal NULL,
    [drvPayFrequency] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressCity] varchar(6000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvForeignIndicator] varchar(1) NOT NULL,
    [drvDateofBirth] datetime NULL,
    [drvDateOfHire] datetime NULL,
    [drvDatePlanEntry] varchar(1) NOT NULL,
    [drvDatePlanEntry2] varchar(1) NOT NULL,
    [drvDatePlanEntry3] varchar(1) NOT NULL,
    [drvDatePlanEntry4] varchar(1) NOT NULL,
    [drvdateOfTermination] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvDateVesting] varchar(1) NOT NULL,
    [drvRestrictedStatus] varchar(1) NOT NULL,
    [drvLoanRestriction] varchar(1) NOT NULL,
    [drvBargainingIndicator] varchar(1) NOT NULL,
    [drvPayrollStatus] varchar(1) NULL,
    [drvHighlyCompensated] varchar(1) NOT NULL,
    [drvIneligibleStatus] varchar(1) NOT NULL,
    [drvPayrollAllocation] varchar(1) NOT NULL,
    [drvReportingDivision] varchar(1) NOT NULL,
    [drvAltKey1] varchar(1) NOT NULL,
    [drvAltKey2] char(9) NULL,
    [drvTransferIndicator] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvLanguagePrefCode] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvFedExemption] varchar(1) NOT NULL,
    [drvJobCodeIndicator] varchar(1) NULL,
    [drvDateStartLOA] datetime NULL,
    [drvDateEndLOA] datetime NULL,
    [drvLOAIndicator] varchar(1) NOT NULL,
    [drvDateRetirement] datetime NULL,
    [drvDateDeathDate] datetime NULL,
    [drvFiller] varchar(1) NOT NULL,
    [PayDate] datetime NULL
);
IF OBJECT_ID('U_EVMAKCS401_EEList') IS NULL
CREATE TABLE [dbo].[U_EVMAKCS401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EVMAKCS401_File') IS NULL
CREATE TABLE [dbo].[U_EVMAKCS401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EVMAKCS401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EVMAKCS401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Source401k] numeric NULL,
    [SourceRoth] numeric NULL,
    [SourceMatch] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [SourceLoan1] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);
IF OBJECT_ID('U_EVMAKCS401_PDedHist_YTD') IS NULL
CREATE TABLE [dbo].[U_EVMAKCS401_PDedHist_YTD] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmtYTD] numeric NULL,
    [PdhERCurAmtYTD] numeric NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL,
    [Source401kYTD] numeric NULL,
    [SourceRothYTD] numeric NULL,
    [SourceMatchYTD] numeric NULL,
    [PdhSource4YTD] numeric NULL,
    [PdhSource5YTD] numeric NULL,
    [SourceLoan1YTD] numeric NULL,
    [PdhSource7YTD] numeric NULL,
    [PdhSource8YTD] numeric NULL,
    [PdhSource9YTD] numeric NULL,
    [PdhSource10YTD] numeric NULL
);
IF OBJECT_ID('U_EVMAKCS401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EVMAKCS401_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [Peh415TestingComp] money NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL,
    [Peh415TestingCompYTD] money NULL
);
IF OBJECT_ID('U_EVMAKCS401_Trailer') IS NULL
CREATE TABLE [dbo].[U_EVMAKCS401_Trailer] (
    [drvDatePayPeriod] datetime NULL,
    [drv401kTotal] numeric NULL,
    [drvRothTotal] numeric NULL,
    [drvContrubtion3] varchar(1) NOT NULL,
    [drvContrubtion4] varchar(1) NOT NULL,
    [drvContrubtion5] varchar(1) NOT NULL,
    [drvContrubtion6] varchar(1) NOT NULL,
    [drvContrubtion7] varchar(1) NOT NULL,
    [drvContrubtion8] varchar(1) NOT NULL,
    [drvContrubtion9] varchar(1) NOT NULL,
    [drvContrubtion10] varchar(1) NOT NULL,
    [drvLoanPaymentTotal] numeric NULL,
    [drvLoanPaymentTotal2] varchar(1) NOT NULL,
    [drvLoanPaymentTotal3] varchar(1) NOT NULL,
    [drvLoanPaymentTotal4] varchar(1) NOT NULL,
    [drvLoanPaymentTotal5] varchar(1) NOT NULL
);
GO
        CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVMAKCS401]
            @SystemID char(12)
        AS
        SET NOCOUNT ON;
        /**********************************************************************************
        Client Name: ValMark Financial Group, LLC

        Created By: Marco Lagrosa
        Business Analyst: Lea King
        Create Date: 07/31/2019
        Service Request Number: SR-2019-00242053

        Purpose: Charles Schwab 401(k) Export

        Revision History
        ----------------
        Update By           Date           Request Num        Desc
        XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

        SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EVMAKCS401';
        SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EVMAKCS401';
        SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EVMAKCS401';
        SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EVMAKCS401';
        SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EVMAKCS401' ORDER BY RunID DESC;

        Execute Export
        --------------
        EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVMAKCS401', 'ONDEMAND';

        EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EVMAKCS401', @AllObjects = 'Y', @IsWeb = 'Y'
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
            SELECT @FormatCode = 'EVMAKCS401';

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
            DELETE FROM dbo.U_EVMAKCS401_EEList
            WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
            AND xEEID IN (SELECT xEEID FROM dbo.U_EVMAKCS401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

            --==========================================
            -- Create Deduction List
            --==========================================
            DECLARE @DedList VARCHAR(MAX)
            SET @DedList = '401BF,401BP,401CF,401CP,401F,401P,ROTHF,ROTHP,RTHBF,RTHBP,RTHCF,RTHCP,MATCH,401L,401L2';

            IF OBJECT_ID('U_EVMAKCS401_DedList','U') IS NOT NULL
                DROP TABLE dbo.U_EVMAKCS401_DedList;
            SELECT DISTINCT
                 DedCode = DedDedCode
                ,DedType = DedDedType
            INTO dbo.U_EVMAKCS401_DedList
            FROM dbo.fn_ListToTable(@DedList)
            JOIN dbo.DedCode WITH (NOLOCK)
                ON DedDedCode = Item;

            --==========================================
            -- Build Working Tables
            --==========================================

            -----------------------------
            -- Working Table - PDedHist
            -----------------------------
            IF OBJECT_ID('U_EVMAKCS401_PDedHist','U') IS NOT NULL
                DROP TABLE dbo.U_EVMAKCS401_PDedHist;
            SELECT DISTINCT
                 PdhEEID
                -- Current Payroll Amounts
                ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
                ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
                -- YTD Payroll Amounts
                ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
                ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
                -- Categorize Payroll Amounts
                ,Source401k     = SUM(CASE WHEN PdhDedCode IN ('401BF', '401BP', '401CF', '401CP', '401F', '401P') THEN PdhEECurAmt ELSE 0.00 END)
                ,SourceRoth     = SUM(CASE WHEN PdhDedCode IN ('ROTHF', 'ROTHP', 'RTHBF', 'RTHBP', 'RTHCF', 'RTHCP') THEN PdhEECurAmt ELSE 0.00 END)
                ,SourceMatch     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
                ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
                ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
                ,SourceLoan1     = SUM(CASE WHEN PdhDedCode IN ('401L','401L2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
                ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
                ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
                ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
                ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
            INTO dbo.U_EVMAKCS401_PDedHist
            FROM dbo.PDedHist WITH (NOLOCK)
            JOIN dbo.U_EVMAKCS401_DedList WITH (NOLOCK)
                ON DedCode = PdhDedCode
            WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
            AND PdhPerControl <= @EndPerControl
            AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
            GROUP BY PdhEEID
            HAVING (SUM(PdhEECurAmt) <> 0.00
                OR SUM(PdhERCurAmt) <> 0.00
            );

    
              IF OBJECT_ID('U_EVMAKCS401_PDedHist_YTD','U') IS NOT NULL
                DROP TABLE dbo.U_EVMAKCS401_PDedHist_YTD;
            SELECT DISTINCT
                 PdhEEID
                -- Current Payroll Amounts
                ,PdhEECurAmtYTD    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
                ,PdhERCurAmtYTD    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
                -- YTD Payroll Amounts
                ,PdhEECurAmt = SUM(PdhEECurAmt)
                ,PdhERCurAmt = SUM(PdhERCurAmt)
                -- Categorize Payroll Amounts
                ,Source401kYTD     = SUM(CASE WHEN PdhDedCode IN ('401BF', '401BP', '401CF', '401CP', '401F', '401P') THEN PdhEECurAmt ELSE 0.00 END)
                ,SourceRothYTD     = SUM(CASE WHEN PdhDedCode IN ('ROTHF', 'ROTHP', 'RTHBF', 'RTHBP', 'RTHCF', 'RTHCP') THEN PdhEECurAmt ELSE 0.00 END)
                ,SourceMatchYTD     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
                ,PdhSource4YTD     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
                ,PdhSource5YTD     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
                ,SourceLoan1YTD     = SUM(CASE WHEN PdhDedCode IN ('401L','401L2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
                ,PdhSource7YTD     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
                ,PdhSource8YTD     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
                ,PdhSource9YTD     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
                ,PdhSource10YTD    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
            INTO dbo.U_EVMAKCS401_PDedHist_YTD
            FROM dbo.PDedHist WITH (NOLOCK)
            JOIN dbo.U_EVMAKCS401_DedList WITH (NOLOCK)
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
            IF OBJECT_ID('U_EVMAKCS401_PEarHist','U') IS NOT NULL
                DROP TABLE dbo.U_EVMAKCS401_PEarHist;
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
                ,Peh415TestingComp   = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
                -- YTD Include Deferred Comp Amount/Hours
                ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
                ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
                ,Peh415TestingCompYTD   = SUM(CASE WHEN PehInclInDefComp = 'Y'  THEN PehCurAmt END)

            INTO dbo.U_EVMAKCS401_PEarHist
            FROM dbo.PayReg WITH (NOLOCK)
            JOIN dbo.PEarHist WITH (NOLOCK)
                ON PehGenNumber = PrgGenNumber
            INNER JOIN dbo.EarnCode WITH (NOLOCK)
            ON PehEarnCode = ErnEarnCode
            WHERE LEFT(PehPerControl,4) = LEFT(@StartPerControl,4)
            AND PehPerControl <= @EndPerControl
            GROUP BY PehEEID
            HAVING SUM(PehCurAmt) <> 0.00;
            --==========================================
            -- Build Driver Tables
            --==========================================
            ---------------------------------
            -- DETAIL RECORD - U_EVMAKCS401_drvTbl
            ---------------------------------
            IF OBJECT_ID('U_EVMAKCS401_drvTbl','U') IS NOT NULL
                DROP TABLE dbo.U_EVMAKCS401_drvTbl;
            SELECT DISTINCT
                 drvEEID = xEEID
                ,drvCoID = xCoID
                ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
                ,drvInitialSort = ''
                -- standard fields above and additional driver fields below
                ,drvSSN = Stuff(Stuff(eepSSN, 6, 0, '-'), 4, 0, '-')
                ,drvLastName = LEFT(UPPER(EepNameLast + ' ' + EepNameFirst + ' '  + LEFT(ISNULL(EepNameMiddle,' '),1) ),32)
                ,drv401K = Source401k
                ,drvRoth = SourceRoth
                ,drvSource3 = SourceMatch
                ,drvSource4 = '0'
                ,drvSource5 = '0'
                ,drvSource6 = '0'
                ,drvSource7 = '0'
                ,drvSource8 = '0'
                ,drvSource9 = '0'
                ,drvSource10 = '0'
                ,drvLoanPayment1 = SourceLoan1
                ,drvLoanPayment2 = '0'
                ,drvLoanPayment3 = '0'
                ,drvLoanPayment4 = '0'
                ,drvLoanPayment5 = '0'
                ,drvPayPeriodDefererral = PehInclInDefComp
                ,drvPayPeriodPlanTesting = Peh415TestingComp
                ,drvPayPeriodTotalCompensation = PehInclInDefComp
                ,drvPayPeriodAdditionalComp = ''
                ,drvPayPeriodHours = ''
                ,drv401KYtd = Source401kYTD
                ,drvRothYtd = SourceRothYTD
                ,drvSourceYTD3 = SourceMatchYTD
                ,drvSourceYTD4 = '0'
                ,drvSourceYTD5 = '0'
                ,drvSourceYTD6 = '0'
                ,drvSourceYTD7 = '0'
                ,drvSourceYTD8 = '0'
                ,drvSourceYTD9 = '0'
                ,drvSourceYTD10 = '0'
                ,drvYTDDeferralComp = PehInclInDefCompYTD
                ,drvYTDPlanTestingComp = Peh415TestingCompYTD
                ,drvYTDTotalCompensation = PehInclInDefCompYTD
                ,drvYTDAddtionalComp = ''
                ,drvAnnualSalary = eecannsalary
                ,drvYTDHoursPaid = PehInclInDefCompHrsYTD
                ,drvPayFrequency = 'S'
                ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
                ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
                ,drvAddressCity =  dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
                ,drvAddressState = EepAddressState
                ,drvAddressZipCode = EepAddressZipCode
                ,drvCountry = ''
                ,drvForeignIndicator = ''
                ,drvDateofBirth = EepDateOfBirth
                ,drvDateOfHire = EecDateOfOriginalHire
                ,drvDatePlanEntry = ''
                ,drvDatePlanEntry2 = ''
                ,drvDatePlanEntry3 = ''
                ,drvDatePlanEntry4 = ''
                ,drvdateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
                ,drvRehireDate = CASE  WHEN EecEmplStatus IN ('A','S') AND EecDateOfOriginalHire <> EecDateOfLastHire AND (EecHireSource = 'REHIRE' OR EecJobChangeReason = '101') THEN EecDateOfLastHire
                                                   ELSE NULL 
                                               END
                ,drvDateVesting = ''
                ,drvRestrictedStatus = ''
                ,drvLoanRestriction = ''
                ,drvBargainingIndicator = ''
                ,drvPayrollStatus = CASE WHEN EecEmplStatus = 'T' THEN
                                                    CASE WHEN EecTermReason = '203' THEN 'D'
                                                         WHEN EecTermReason IN ('202','213') THEN 'R'
                                                         ELSE 'T'
                                                    END
                                                    ELSE EecEmplStatus
                                              END
                ,drvHighlyCompensated = ''
                ,drvIneligibleStatus = CASE WHEN EecJobCode = 'INTERN' OR EecEEType IN  ('INT', 'TES', 'SUM', 'STU', 'TMP') 
                                        THEN  'N' ELSE '' END
                ,drvPayrollAllocation = '' --Leave Blank as Specs
                ,drvReportingDivision = '' --Leave Blank as Specs
                ,drvAltKey1 = '' --Leave Blank as Specs            
                ,drvAltKey2 = EecEmpNo
                ,drvTransferIndicator = ''
                ,drvEmailAddress = EepAddressEMail
                ,drvLanguagePrefCode = ''
                ,drvGender = EepGender
                ,drvMaritalStatus = CASE WHEN eepMaritalStatus = 'M' THEN 'M' ELSE 'S' END
                ,drvFedExemption = ''
                --
        --if emptype is 'SUM', 'STU', send S
        --if emptype is 'TMP', send T
        --if jobcode of INTERN or emptype is INT, send I
        --else if EecFullTimeOrPartTime is F, send F
        --else if EecFullTimeOrPartTime is P, send P

                ,drvJobCodeIndicator = CASE WHEN EecEEType in ('SUM', 'STU') THEN 'S' 
                                            WHEN EecEEType in ('TEMP') THEN 'T'
                                            WHEN EecEEType in ('INT') OR EecJobCode in ('INTERN') THEN 'I'
                                            ELSE EecFullTimeOrPartTime
                                        END
                ,drvDateStartLOA =CASE WHEN EecEmplStatus = 'L' THEN EecPlannedStatusEndDate ELSE null END
                ,drvDateEndLOA = CASE  WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate ELSE null END
                ,drvLOAIndicator = CASE  WHEN EecEmplStatus = 'L' THEN 'L' ELSE  '' END
                ,drvDateRetirement = CASE WHEN EecEmplStatus = 'T' THEN 
                                         CASE WHEN EecTermReason in('202','213') THEN EecDateOfTermination ELSE  NULL END
                                     END
                ,drvDateDeathDate = CASE WHEN EecEmplStatus = 'T' THEN 
                                         CASE WHEN EecTermReason in('203') THEN EecDateOfTermination ELSE  NULL END
                                     END
                ,drvFiller = ''
                ,PayDate  = PrgPayDate
            INTO dbo.U_EVMAKCS401_drvTbl
            FROM dbo.U_EVMAKCS401_EEList WITH (NOLOCK)
            JOIN dbo.EmpComp WITH (NOLOCK)
                ON EecEEID = xEEID 
                AND EecCoID = xCoID
            JOIN dbo.EmpPers WITH (NOLOCK)
                ON EepEEID = xEEID
            JOIN dbo.JobCode WITH (NOLOCK)
                ON JbcJobCode = EecJobCode
            LEFT JOIN dbo.U_EVMAKCS401_PEarHist WITH (NOLOCK)
                ON PehEEID = xEEID
            LEFT JOIN U_EVMAKCS401_PDedHist WITH (NOLOCK)
                ON  PdhEEID = xEEID
            LEFT JOIN U_EVMAKCS401_PDedHist_YTD AS  PDedHistYTD WITH (NOLOCK)
                ON  PDedHistYTD.PdhEEID = xEEID
            ;


                --Exclude Employees whose Term Date is not in last 12 months And Doesn't have any YTD compensation or Contribution 
              DELETE from  dbo.U_EVMAKCS401_drvTbl
            WHERE drvPayrollStatus IN ('T','D','R') AND drvDateOfTermination < DATEADD(MM, - 12, @EndDate)
            AND NOT EXISTS (SELECT 1 FROM dbo.U_EVMAKCS401_PEarHist WITH (NOLOCK) WHERE PehEEID = drvEEID)
            AND NOT EXISTS (SELECT 1 FROM dbo.U_EVMAKCS401_PDedHist WITH (NOLOCK) WHERE PdhEEID = drvEEID);
            -- TRAILER RECORD
            ---------------------------------
            IF OBJECT_ID('U_EVMAKCS401_Trailer','U') IS NOT NULL
                DROP TABLE dbo.U_EVMAKCS401_Trailer;
            SELECT DISTINCT
                 drvDatePayPeriod = MAX(PayDate)
                ,drv401kTotal = sum(drv401K)
                ,drvRothTotal = sum(drvRoth)
                ,drvContrubtion3 = '0'
                ,drvContrubtion4 = '0'
                ,drvContrubtion5 = '0'
                ,drvContrubtion6 = '0'
                ,drvContrubtion7 = '0'
                ,drvContrubtion8 = '0'
                ,drvContrubtion9 = '0'
                ,drvContrubtion10 = '0'
                ,drvLoanPaymentTotal = sum(drvLoanPayment1)
                ,drvLoanPaymentTotal2 = '0'
                ,drvLoanPaymentTotal3 = '0'
                ,drvLoanPaymentTotal4 = '0'
                ,drvLoanPaymentTotal5 = '0'
            INTO dbo.U_EVMAKCS401_Trailer
            FROM U_EVMAKCS401_drvTbl
            ;

            --==========================================
            -- Set FileName
            --==========================================
            IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
            BEGIN
                UPDATE dbo.U_dsi_Parameters
                    SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'EVMACS401_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                          WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                          ELSE 'ETEST12345_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                     END
                WHERE FormatCode = @FormatCode;
            END

        END;
        /**********************************************************************************

        --Alter the View
        ALTER VIEW dbo.dsi_vwEVMAKCS401_Export AS
            SELECT TOP 20000000 Data FROM dbo.U_EVMAKCS401_File (NOLOCK)
            ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

        --Check out AscDefF
        SELECT * FROM dbo.AscDefF
        WHERE AdfHeaderSystemID LIKE 'EVMAKCS401%'
        ORDER BY AdfSetNumber, AdfFieldNumber;

        --Update Dates
        UPDATE dbo.AscExp
            SET expLastStartPerControl = '201907241'
               ,expStartPerControl     = '201907241'
               ,expLastEndPerControl   = '201907319'
               ,expEndPerControl       = '201907319'
        WHERE expFormatCode = 'EVMAKCS401';

        **********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEVMAKCS401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EVMAKCS401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort