SET NOCOUNT ON;
IF OBJECT_ID('U_ECUNPUBEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECUNPUBEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECUNPUBEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECUNPUBEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECUNPUBEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECUNPUBEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECUNPUBEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECUNPUBEXP];
GO
IF OBJECT_ID('U_ECUNPUBEXP_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_ECUNPUBEXP_PTaxHist];
GO
IF OBJECT_ID('U_ECUNPUBEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECUNPUBEXP_PEarHist];
GO
IF OBJECT_ID('U_ECUNPUBEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECUNPUBEXP_PDedHist];
GO
IF OBJECT_ID('U_ECUNPUBEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECUNPUBEXP_File];
GO
IF OBJECT_ID('U_ECUNPUBEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECUNPUBEXP_EEList];
GO
IF OBJECT_ID('U_ECUNPUBEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECUNPUBEXP_drvTbl];
GO
IF OBJECT_ID('U_ECUNPUBEXP_Deduction_Full') IS NOT NULL DROP TABLE [dbo].[U_ECUNPUBEXP_Deduction_Full];
GO
IF OBJECT_ID('U_ECUNPUBEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECUNPUBEXP_DedList];
GO
IF OBJECT_ID('U_ECUNPUBEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECUNPUBEXP_AuditFields];
GO
IF OBJECT_ID('U_ECUNPUBEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECUNPUBEXP_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECUNPUBEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECUNPUBEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECUNPUBEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECUNPUBEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECUNPUBEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECUNPUBEXP','CUNA 401 Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ECUNPUBEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name "','1','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','1',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name "','2','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','2',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN "','3','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','3',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1 "','4','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','4',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City "','5','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','5',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State "','6','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','6',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code "','7','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','7',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2 "','8','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','8',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 3 "','9','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','9',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Foreign Address "','10','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','10',NULL,'Foreign Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address "','11','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','11',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Birth Date "','12','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','12',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date "','13','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','13',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date "','14','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','14',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Status Change Date "','15','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','15',NULL,'Status Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Status Change Reason "','16','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','16',NULL,'Status Change Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Period Hours "','17','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','17',NULL,'Period Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Period Gross Comp "','18','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','18',NULL,'Period Gross Comp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union or NRA "','19','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','19',NULL,'Union or NRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Deferral "','20','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','20',NULL,'EE Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Roth "','21','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','21',NULL,'EE Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE After Tax "','22','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','22',NULL,'EE After Tax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ER Nonelective "','23','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','23',NULL,'ER Nonelective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Match "','24','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','24',NULL,'Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SH Match "','25','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','25',NULL,'SH Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QACA Match "','26','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','26',NULL,'QACA Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SH Nonelective "','27','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','27',NULL,'SH Nonelective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QNEC "','28','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','28',NULL,'QNEC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Prevailing Wage "','29','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','29',NULL,'Prevailing Wage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1st Loan No "','30','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','30',NULL,'1st Loan No',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1st Loan Pmt "','31','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','31',NULL,'1st Loan Pmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Prior ER ID "','32','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','32',NULL,'Prior ER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Entry Date "','33','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','33',NULL,'Entry Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location "','34','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','34',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Period Excluded "','35','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','35',NULL,'Period Excluded',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Hours "','37','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','37',NULL,'YTD Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Gross Comp "','38','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','38',NULL,'YTD Gross Comp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Excluded Comp "','39','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','39',NULL,'YTD Excluded Comp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Business Group "','40','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','40',NULL,'Business Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PT Seasonal Temp "','41','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','41',NULL,'PT Seasonal Temp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Excluded All Sources "','42','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','42',NULL,'Excluded All Sources',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Excluded EE "','43','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','43',NULL,'Excluded EE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Deferral "','44','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','44',NULL,'Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Excluded Match "','45','(''DA''=''Q,'')','ECUNPUBEXPZ0','50','H','01','45',NULL,'Excluded Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Excluded NonMatch "','46','(''DA''=''Q'')','ECUNPUBEXPZ0','50','H','01','46',NULL,'Excluded NonMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','1','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','1',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','2','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','2',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','3',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','4','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','4',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','5','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','5',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','6','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','6',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','7','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','7',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','8','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','8',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine3"','9','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','9',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvForeignAddress"','10','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','10',NULL,'Foreign Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','11','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','11',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','12','(''UD101''=''Q,'')','ECUNPUBEXPZ0','50','D','10','12',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','13','(''UD101''=''Q,'')','ECUNPUBEXPZ0','50','D','10','13',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','14','(''UD101''=''Q,'')','ECUNPUBEXPZ0','50','D','10','14',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusChangeDate"','15','(''UD101''=''Q,'')','ECUNPUBEXPZ0','50','D','10','15',NULL,'Status Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusChangeReason"','16','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','16',NULL,'Status Change Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodHours"','17','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','17',NULL,'Period Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodGrossComp"','18','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','18',NULL,'Period Gross Comp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionorNRA"','19','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','19',NULL,'Union or NRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDeferral"','20','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','20',NULL,'EE Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEERoth"','21','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','21',NULL,'EE Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEAfterTax"','22','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','22',NULL,'EE After Tax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERNonelective"','23','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','23',NULL,'ER Nonelective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMatch"','24','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','24',NULL,'Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSHMatch"','25','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','25',NULL,'SH Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQACAMatch"','26','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','26',NULL,'QACA Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSHNonelective"','27','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','27',NULL,'SH Nonelective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQNEC"','28','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','28',NULL,'QNEC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrevailingWage"','29','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','29',NULL,'Prevailing Wage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv1stLoanNo"','30','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','30',NULL,'1st Loan No',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv1stLoanPmt"','31','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','31',NULL,'1st Loan Pmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorERID"','32','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','32',NULL,'Prior ER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEntryDate"','33','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','33',NULL,'Entry Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','34','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','34',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodExcluded"','35','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','35',NULL,'Period Excluded',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDHours"','37','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','37',NULL,'YTD Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDGrossComp"','38','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','38',NULL,'YTD Gross Comp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDExcludedComp"','39','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','39',NULL,'YTD Excluded Comp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBusinessGroup"','40','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','40',NULL,'Business Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPTSeasonalTemp"','41','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','41',NULL,'PT Seasonal Temp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludedAllSources"','42','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','42',NULL,'Excluded All Sources',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludedEE"','43','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','43',NULL,'Excluded EE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeferral"','44','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','44',NULL,'Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludedMatch"','45','(''UA''=''Q,'')','ECUNPUBEXPZ0','50','D','10','45',NULL,'Excluded Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludedNonMatch"','46','(''UA''=''Q'')','ECUNPUBEXPZ0','50','D','10','46',NULL,'Excluded NonMatch',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECUNPUBEXP_20200604.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CUNA 401 Export','202006049','EMPEXPORT','ONDEMAND',NULL,'ECUNPUBEXP',NULL,NULL,NULL,'202006049','Jun  4 2020 11:51AM','Jun  4 2020 11:51AM','202006041',NULL,'','','202006041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECUNPUBEXP_20200604.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202006049','EMPEXPORT','SCH_CUNPB',NULL,'ECUNPUBEXP',NULL,NULL,NULL,'202006049','Jun  4 2020 11:51AM','Jun  4 2020 11:51AM','202006041',NULL,'','','202006041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECUNPUBEXP_20200604.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202006049','EMPEXPORT','TEST','Jun  4 2020 12:00AM','ECUNPUBEXP',NULL,NULL,NULL,'202006049','Jun  4 2020 12:00AM','Dec 30 1899 12:00AM','202005221',NULL,'','','202005221',dbo.fn_GetTimedKey(),NULL,'us3mLaPUB1005',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ECUNPUBEXP_20200604.txt' END WHERE expFormatCode = 'ECUNPUBEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNPUBEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNPUBEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNPUBEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNPUBEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNPUBEXP','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNPUBEXP','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNPUBEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ECUNPUBEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECUNPUBEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ECUNPUBEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECUNPUBEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUNPUBEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUNPUBEXP','D10','dbo.U_ECUNPUBEXP_drvTbl',NULL);
IF OBJECT_ID('U_ECUNPUBEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ECUNPUBEXP_Audit] (
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
IF OBJECT_ID('U_ECUNPUBEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECUNPUBEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ECUNPUBEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ECUNPUBEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECUNPUBEXP_Deduction_Full') IS NULL
CREATE TABLE [dbo].[U_ECUNPUBEXP_Deduction_Full] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmtFull] numeric NULL,
    [PdhERCurAmtFull] numeric NULL,
    [PdhEECurAmtFullYTD] numeric NULL,
    [PdhERCurAmtFullYTD] numeric NULL
);
IF OBJECT_ID('U_ECUNPUBEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECUNPUBEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvForeignAddress] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvBirthDate] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvStatusChangeDate] datetime NULL,
    [drvStatusChangeReason] varchar(1) NULL,
    [drvPeriodHours] varchar(12) NULL,
    [drvPeriodGrossComp] varchar(12) NULL,
    [drvUnionorNRA] varchar(1) NOT NULL,
    [drvEEDeferral] varchar(12) NULL,
    [drvEERoth] varchar(12) NULL,
    [drvEEAfterTax] varchar(1) NOT NULL,
    [drvERNonelective] varchar(1) NOT NULL,
    [drvMatch] varchar(12) NULL,
    [drvSHMatch] varchar(1) NOT NULL,
    [drvQACAMatch] varchar(1) NOT NULL,
    [drvSHNonelective] varchar(1) NOT NULL,
    [drvQNEC] varchar(1) NOT NULL,
    [drvPrevailingWage] varchar(1) NOT NULL,
    [drv1stLoanNo] varchar(1) NOT NULL,
    [drv1stLoanPmt] varchar(12) NULL,
    [drvPriorERID] varchar(1) NOT NULL,
    [drvEntryDate] varchar(1) NOT NULL,
    [drvLocation] char(6) NULL,
    [drvPeriodExcluded] varchar(12) NULL,
    [drvYTDHours] varchar(12) NULL,
    [drvYTDGrossComp] varchar(12) NULL,
    [drvYTDExcludedComp] varchar(12) NULL,
    [drvBusinessGroup] varchar(1) NOT NULL,
    [drvPTSeasonalTemp] varchar(1) NOT NULL,
    [drvExcludedAllSources] varchar(1) NOT NULL,
    [drvExcludedEE] varchar(1) NOT NULL,
    [drvDeferral] varchar(1) NOT NULL,
    [drvExcludedMatch] varchar(1) NOT NULL,
    [drvExcludedNonMatch] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECUNPUBEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECUNPUBEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECUNPUBEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECUNPUBEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ECUNPUBEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECUNPUBEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhEEDeferral] numeric NULL,
    [PdhEERoth] numeric NULL,
    [PdhMatch] numeric NULL,
    [PdhLoan] numeric NULL
);
IF OBJECT_ID('U_ECUNPUBEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECUNPUBEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmtExcluded] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurHrsExcluded] decimal NULL,
    [PehCurAmtYTD] numeric NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
IF OBJECT_ID('U_ECUNPUBEXP_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_ECUNPUBEXP_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthGrossWages] numeric NULL,
    [pdheecuramtfull] numeric NULL,
    [PthGrossWagesYTDBefore] money NULL,
    [PthGrossWagesYTD] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECUNPUBEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Publix Federal Credit Union

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 06/04/2020
Service Request Number: SR-2016-00012345

Purpose: CUNA 401 Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECUNPUBEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECUNPUBEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECUNPUBEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECUNPUBEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECUNPUBEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUNPUBEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUNPUBEXP', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUNPUBEXP', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECUNPUBEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECUNPUBEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECUNPUBEXP';

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
    DELETE FROM dbo.U_ECUNPUBEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECUNPUBEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401KB,401P,ROTH,BMTCH,MATCH,RMTCH,401L';

    IF OBJECT_ID('U_ECUNPUBEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNPUBEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECUNPUBEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECUNPUBEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNPUBEXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        
        ,PdhEEDeferral     = SUM(CASE WHEN PdhDedCode IN ('401KB', '401P') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEERoth     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhMatch     = SUM(CASE WHEN PdhDedCode IN ('BMTCH', 'MATCH', 'RMTCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhLoan     = SUM(CASE WHEN PdhDedCode IN ('401L') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_ECUNPUBEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECUNPUBEXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    --Deduction Full Table
    IF OBJECT_ID('U_ECUNPUBEXP_Deduction_Full','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNPUBEXP_Deduction_Full;
    SELECT DISTINCT
         PdhEEID
        ,PdhEECurAmtFull = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND PdhDedCode NOT IN ('TUIT', 'MOVE', 'AWARD', 'GFCA', 'BONUS', 'TABON', 'ADJBO') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmtFull = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND PdhDedCode NOT IN ('TUIT', 'MOVE', 'AWARD', 'GFCA', 'BONUS', 'TABON', 'ADJBO')THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhEECurAmtFullYTD = SUM(CASE WHEN PdhDedCode NOT IN ('TUIT', 'MOVE', 'AWARD', 'GFCA', 'BONUS', 'TABON', 'ADJBO') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmtFullYTD = SUM(CASE WHEN PdhDedCode NOT IN ('TUIT', 'MOVE', 'AWARD', 'GFCA', 'BONUS', 'TABON', 'ADJBO') THEN PdhERCurAmt ELSE 0.00 END)
    INTO dbo.U_ECUNPUBEXP_Deduction_Full
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00);

    --Tax Hist 
    IF OBJECT_ID('U_ECUNPUBEXP_PTaxHist') IS NOT NULL
        DROP TABLE dbo.U_ECUNPUBEXP_PTaxHist;

    SELECT DISTINCT
         PthEEID
        ,PthGrossWages    = SUM(CASE WHEN PthPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PthCurTaxableWages ELSE 0.00 END  ) + Max(ISNULL(pdheecuramtfull,0.00))
        ,pdheecuramtfull =  Max(pdheecuramtfull)
        ,PthGrossWagesYTDBefore    = SUM(PthCurTaxableWages)     
        ,PthGrossWagesYTD    = SUM(PthCurTaxableWages) + Max(ISNULL(PdhEECurAmtFullYTD,0.00))

    INTO dbo.U_ECUNPUBEXP_PTaxHist
    FROM dbo.PTaxHist WITH (NOLOCK)
    JOIN dbo.U_ECUNPUBEXP_Deduction_Full ON
        PdhEEID = ptheeid
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
    AND PthPerControl <= @EndPerControl
    AND PthTaxCode = 'USFIT'
    GROUP BY PthEEID
    HAVING SUM(PthCurGrossWages) <> 0.00;

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECUNPUBEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNPUBEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmtExcluded              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEarnCode IN ('TUIT', 'MOVE', 'AWARD', 'GFCA', 'BONUS', 'TABON', 'ADJBO') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEarnCode NOT IN ('TUIT', 'MOVE', 'AWARD', 'GFCA', 'BONUS', 'TABON', 'ADJBO') THEN PehCurHrs ELSE 0.00 END)
        ,PehCurHrsExcluded      = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEarnCode  IN ('TUIT', 'MOVE', 'AWARD', 'GFCA', 'BONUS', 'TABON', 'ADJBO') THEN PehCurHrs ELSE 0.00 END)

        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEarnCode NOT IN ('TUIT', 'MOVE', 'AWARD', 'GFCA', 'BONUS', 'TABON', 'ADJBO') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrsYTD           = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEarnCode NOT IN ('TUIT', 'MOVE', 'AWARD', 'GFCA', 'BONUS', 'TABON', 'ADJBO') THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ECUNPUBEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    IF OBJECT_ID('U_ECUNPUBEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNPUBEXP_AuditFields;
    CREATE TABLE dbo.U_ECUNPUBEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ECUNPUBEXP_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ECUNPUBEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNPUBEXP_Audit;
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
    INTO dbo.U_ECUNPUBEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ECUNPUBEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ECUNPUBEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate -30 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECUNPUBEXP_Audit ON dbo.U_ECUNPUBEXP_Audit (audKey1Value, audKey2Value);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECUNPUBEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECUNPUBEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNPUBEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvSSN = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = ''
        ,drvForeignAddress = ''
        ,drvEmailAddress = EepAddressEMail
        ,drvBirthDate = EepDateOfBirth
        ,drvHireDate = eecdateoforiginalhire
        ,drvRehireDate = CASE WHEN eecdateoforiginalhire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvStatusChangeDate = CASE WHEN eecemplstatus  = 'T' THEN eecdateoftermination
                                    WHEN eecemplstatus  = 'L' THEN EecEmplStatusStartDate
                                    WHEN eecemplstatus = 'A' and (select top 1 EshEmplStatus from EmpHStat where esheeid = xeeid order by eshdatetimechanged desc) = 'L' THEN (select top 1 EshStatusStopDate from EmpHStat where esheeid = xeeid order by eshdatetimechanged desc)
                               END
        ,drvStatusChangeReason = CASE WHEN eecEmplStatus = 'T' THEN 
                                        CASE WHEN eectermreason = '202' THEN '7'
                                             WHEN eectermreason = '203' THEN '5'
                                             WHEN eectermreason NOT IN ('203','202') THEN '1'
                                        END
                                      WHEN eecEmplStatus = 'A' and (select top 1 EshEmplStatus from EmpHStat where esheeid = xeeid order by eshdatetimechanged desc) = 'L' THEN '8'
                                      WHEN eecEmplStatus = 'L' and (select top 1 EshEmplStatusReason  from EmpHStat where esheeid = xeeid order by eshdatetimechanged desc) = '300' THEN '2'
                                      WHEN eecEmplStatus = 'L' and (select top 1 EshEmplStatusReason  from EmpHStat where esheeid = xeeid order by eshdatetimechanged desc) IN ('102', '103','104' ) THEN '3'
                                      WHEN eecEmplStatus = 'L' and (select top 1 EshEmplStatusReason  from EmpHStat where esheeid = xeeid order by eshdatetimechanged desc) NOT IN ('102', '103','104','300' ) THEN '4'
                                 END
        ,drvPeriodHours = CAST(CONVERT(DECIMAL(10,2),PehCurHrs) AS VARCHAR(12))
        ,drvPeriodGrossComp = CAST(CONVERT(DECIMAL(10,2),PthGrossWages)  as VARCHAR(12))
        ,drvUnionorNRA = ''
        ,drvEEDeferral = CAST(CONVERT(DECIMAL(10,2),PdhEEDeferral) as varchar(12))
        ,drvEERoth = CAST(CONVERT(DECIMAL(10,2),PdhEERoth) as VARCHAR(12))
        ,drvEEAfterTax = ''
        ,drvERNonelective = ''
        ,drvMatch = CAST(CONVERT(DECIMAL(10,2),PdhMatch) as VARCHAR(12))
        ,drvSHMatch = ''
        ,drvQACAMatch = ''
        ,drvSHNonelective = ''
        ,drvQNEC = ''
        ,drvPrevailingWage = ''
        ,drv1stLoanNo = '1'
        ,drv1stLoanPmt = CAST(CONVERT(DECIMAL(10,2),PdhLoan) as VARCHAR(12))
        ,drvPriorERID = ''
        ,drvEntryDate = ''
        ,drvLocation = EecLocation
        ,drvPeriodExcluded = CAST(CONVERT(DECIMAL(10,2),PehCurAmtExcluded) as VARCHAR(12))
        ,drvYTDHours = CAST(CONVERT(DECIMAL(10,2),PehCurHrsYTD) as VARCHAR(12))
        ,drvYTDGrossComp = CAST(CONVERT(DECIMAL(10,2),PthGrossWagesYTD) as VARCHAR(12))
        ,drvYTDExcludedComp = CAST(CONVERT(DECIMAL(10,2),PehCurAmtYTD) as VARCHAR(12))
        ,drvBusinessGroup = ''
        ,drvPTSeasonalTemp = ''
        ,drvExcludedAllSources = ''
        ,drvExcludedEE = ''
        ,drvDeferral = ''
        ,drvExcludedMatch = ''
        ,drvExcludedNonMatch = ''
    INTO dbo.U_ECUNPUBEXP_drvTbl
    FROM dbo.U_ECUNPUBEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ECUNPUBEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.U_ECUNPUBEXP_PEarHist
        ON PehEEID = xEEID
     JOIN dbo.U_ECUNPUBEXP_PTaxHist
        on PthEEID =  xEEID
     JOIN dbo.U_ECUNPUBEXP_PDedHist 
        ON pdheeid = xeeid
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECUNPUBEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECUNPUBEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECUNPUBEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005281'
       ,expStartPerControl     = '202005281'
       ,expLastEndPerControl   = '202006049'
       ,expEndPerControl       = '202006049'
WHERE expFormatCode = 'ECUNPUBEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECUNPUBEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECUNPUBEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2