SET NOCOUNT ON;
IF OBJECT_ID('U_EASCCONTES_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EASCCONTES_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EASCCONTES_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EASCCONTES' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEASCCONTES_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEASCCONTES_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EASCCONTES') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASCCONTES];
GO
IF OBJECT_ID('U_EASCCONTES_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EASCCONTES_Trailer];
GO
IF OBJECT_ID('U_EASCCONTES_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EASCCONTES_PEarHist];
GO
IF OBJECT_ID('U_EASCCONTES_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EASCCONTES_PDedHist];
GO
IF OBJECT_ID('U_EASCCONTES_Header') IS NOT NULL DROP TABLE [dbo].[U_EASCCONTES_Header];
GO
IF OBJECT_ID('U_EASCCONTES_File') IS NOT NULL DROP TABLE [dbo].[U_EASCCONTES_File];
GO
IF OBJECT_ID('U_EASCCONTES_EEList') IS NOT NULL DROP TABLE [dbo].[U_EASCCONTES_EEList];
GO
IF OBJECT_ID('U_EASCCONTES_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EASCCONTES_drvTbl];
GO
IF OBJECT_ID('U_EASCCONTES_DedList') IS NOT NULL DROP TABLE [dbo].[U_EASCCONTES_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EASCCONTES';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EASCCONTES';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EASCCONTES';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EASCCONTES';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EASCCONTES';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EASCCONTES','Ascensus 401k Cont Export TEST','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EASCCONTESZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EASCCONTES' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','1','(''SS''=''F'')','EASCCONTESZ0','3','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','2','(''SS''=''F'')','EASCCONTESZ0','2','H','01','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Soc. Sec #"','3','(''DA''=''F'')','EASCCONTESZ0','11','H','01','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','4','(''SS''=''F'')','EASCCONTESZ0','1','H','01','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','5','(''DA''=''F'')','EASCCONTESZ0','20','H','01','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MI"','6','(''DA''=''F'')','EASCCONTESZ0','1','H','01','38',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','7','(''SS''=''F'')','EASCCONTESZ0','1','H','01','39',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','8','(''DA''=''F'')','EASCCONTESZ0','15','H','01','40',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Gross Compensation"','9','(''DA''=''F'')','EASCCONTESZ0','12','H','01','55',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Gross Compensation"','10','(''DA''=''F'')','EASCCONTESZ0','12','H','01','67',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours "','11','(''DA''=''F'')','EASCCONTESZ0','12','H','01','79',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Contribution"','12','(''DA''=''F'')','EASCCONTESZ0','12','H','01','91',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ER Match"','13','(''DA''=''F'')','EASCCONTESZ0','12','H','01','103',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Profit Sharing"','14','(''DA''=''F'')','EASCCONTESZ0','12','H','01','115',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Specific-Contribution"','15','(''DA''=''F'')','EASCCONTESZ0','12','H','01','127',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Specific-Contribution"','16','(''DA''=''F'')','EASCCONTESZ0','12','H','01','139',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Specific-Contribution"','17','(''DA''=''F'')','EASCCONTESZ0','12','H','01','151',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan 1"','18','(''DA''=''F'')','EASCCONTESZ0','12','H','01','163',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan 2"','19','(''DA''=''F'')','EASCCONTESZ0','12','H','01','175',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan 3"','20','(''DA''=''F'')','EASCCONTESZ0','12','H','01','187',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan 4"','21','(''DA''=''F'')','EASCCONTESZ0','12','H','01','199',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan 5"','22','(''DA''=''F'')','EASCCONTESZ0','12','H','01','211',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EASCCONTESZ0','5','H','02','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCont"','2','(''UA''=''F'')','EASCCONTESZ0','12','H','02','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientNo"','3','(''UA''=''F'')','EASCCONTESZ0','20','H','02','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','4','(''SS''=''F'')','EASCCONTESZ0','2','H','02','38',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','5','(''UA''=''F'')','EASCCONTESZ0','15','H','02','40',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSiteCode"','6','(''UA''=''F'')','EASCCONTESZ0','12','H','02','55',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollBeginDate"','7','(''UDMDY''=''F'')','EASCCONTESZ0','12','H','02','67',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollEndDate"','8','(''UDMDY''=''F'')','EASCCONTESZ0','12','H','02','79',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollEffectiveDate"','9','(''UDMDY''=''F'')','EASCCONTESZ0','12','H','02','91',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','10','(''SS''=''F'')','EASCCONTESZ0','120','H','02','103',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EASCCONTESZ0','3','D','10','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','2','(''SS''=''F'')','EASCCONTESZ0','2','D','10','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''F'')','EASCCONTESZ0','11','D','10','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','4','(''SS''=''F'')','EASCCONTESZ0','1','D','10','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''F'')','EASCCONTESZ0','20','D','10','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''F'')','EASCCONTESZ0','1','D','10','38',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','7','(''SS''=''F'')','EASCCONTESZ0','1','D','10','39',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','8','(''UA''=''F'')','EASCCONTESZ0','15','D','10','40',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPerGrossComp"','9','(''UA''=''F'')','EASCCONTESZ0','12','D','10','55',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrossYTDComp"','10','(''UA''=''F'')','EASCCONTESZ0','12','D','10','67',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPerHours"','11','(''UA''=''F'')','EASCCONTESZ0','12','D','10','79',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmp401Contrib"','12','(''UA''=''F'')','EASCCONTESZ0','12','D','10','91',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmprMatchContrib"','13','(''UA''=''F'')','EASCCONTESZ0','12','D','10','103',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProfitShareContrib"','14','(''UA''=''F'')','EASCCONTESZ0','12','D','10','115',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRothContrib"','15','(''UA''=''F'')','EASCCONTESZ0','12','D','10','127',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDataFld1"','16','(''UA''=''F'')','EASCCONTESZ0','12','D','10','139',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDataFld2"','17','(''UA''=''F'')','EASCCONTESZ0','12','D','10','151',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPay1"','18','(''UA''=''F'')','EASCCONTESZ0','12','D','10','163',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPay2"','19','(''UA''=''F'')','EASCCONTESZ0','12','D','10','175',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPay3"','20','(''UA''=''F'')','EASCCONTESZ0','12','D','10','187',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPay4"','21','(''UA''=''F'')','EASCCONTESZ0','12','D','10','199',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPay5"','22','(''UA''=''F'')','EASCCONTESZ0','12','D','10','211',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EASCCONTESZ0','3','T','90','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','2','(''SS''=''F'')','EASCCONTESZ0','2','T','90','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailRecCnt"','3','(''UA''=''F'')','EASCCONTESZ0','7','T','90','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','4','(''SS''=''F'')','EASCCONTESZ0','42','T','90','13',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPerGrossCompTot"','5','(''UA''=''F'')','EASCCONTESZ0','12','T','90','55',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrossYTDCompTot"','6','(''UA''=''F'')','EASCCONTESZ0','12','T','90','67',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPerHoursTot"','7','(''UA''=''F'')','EASCCONTESZ0','12','T','90','79',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmp401ContribTot"','8','(''UA''=''F'')','EASCCONTESZ0','12','T','90','91',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmprMatchContribTot"','9','(''UA''=''F'')','EASCCONTESZ0','12','T','90','103',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProfitShareContribTot"','10','(''UA''=''F'')','EASCCONTESZ0','12','T','90','115',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRothContribTot"','11','(''UA''=''F'')','EASCCONTESZ0','12','T','90','127',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDataFld1Tot"','12','(''UA''=''F'')','EASCCONTESZ0','12','T','90','139',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDataFld2Tot"','13','(''UA''=''F'')','EASCCONTESZ0','12','T','90','151',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPay1Tot"','14','(''UA''=''F'')','EASCCONTESZ0','12','T','90','163',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPay2Tot"','15','(''UA''=''F'')','EASCCONTESZ0','12','T','90','175',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPay3Tot"','16','(''UA''=''F'')','EASCCONTESZ0','12','T','90','187',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPay4Tot"','17','(''UA''=''F'')','EASCCONTESZ0','12','T','90','199',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPay5Tot"','18','(''UA''=''F'')','EASCCONTESZ0','12','T','90','211',NULL,NULL,NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EASCCONTES_20211022.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ascensus 401k Cont Export','201710269','EMPEXPORT','EASCCONTES',NULL,'EASCCONTES',NULL,NULL,NULL,'201710269','Oct 26 2017 11:07AM','Oct 26 2017 11:07AM','201710261',NULL,'','','201710261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','ZCBOZ',NULL,NULL,NULL,'Test Purposes Only','202001029','EMPEXPORT','TEST','Jan 21 2020 12:00AM','EASCCONTES',NULL,NULL,NULL,'202001029','Jan  2 2020 12:00AM','Dec 30 1899 12:00AM','202001021','180','','','202001021',dbo.fn_GetTimedKey(),NULL,'ULTI_WPMIDI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONTES','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONTES','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONTES','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONTES','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONTES','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EASCCONTES' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EASCCONTES' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EASCCONTES_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EASCCONTES_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASCCONTES','H01','None','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASCCONTES','H02','dbo.U_EASCCONTES_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASCCONTES','D10','dbo.U_EASCCONTES_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASCCONTES','T90','dbo.U_EASCCONTES_Trailer',NULL);
IF OBJECT_ID('U_EASCCONTES_DedList') IS NULL
CREATE TABLE [dbo].[U_EASCCONTES_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EASCCONTES_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EASCCONTES_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvPayPerGrossComp] varchar(24) NULL,
    [drvGrossYTDComp] varchar(24) NULL,
    [drvPayPerHours] varchar(24) NULL,
    [drvEmp401Contrib] varchar(24) NULL,
    [drvEmprMatchContrib] varchar(24) NULL,
    [drvProfitShareContrib] varchar(1) NOT NULL,
    [drvRothContrib] varchar(24) NULL,
    [drvClientDataFld1] varchar(1) NOT NULL,
    [drvClientDataFld2] varchar(1) NOT NULL,
    [drvLoanPay1] varchar(24) NULL,
    [drvLoanPay2] varchar(24) NULL,
    [drvLoanPay3] varchar(24) NULL,
    [drvLoanPay4] varchar(24) NULL,
    [drvLoanPay5] varchar(24) NULL
);
IF OBJECT_ID('U_EASCCONTES_EEList') IS NULL
CREATE TABLE [dbo].[U_EASCCONTES_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EASCCONTES_File') IS NULL
CREATE TABLE [dbo].[U_EASCCONTES_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EASCCONTES_Header') IS NULL
CREATE TABLE [dbo].[U_EASCCONTES_Header] (
    [drvRecordType] varchar(3) NOT NULL,
    [drvCont] varchar(12) NOT NULL,
    [drvClientNo] varchar(6) NULL,
    [drvClientName] varchar(15) NULL,
    [drvSiteCode] varchar(1) NOT NULL,
    [drvPayrollBeginDate] datetime NULL,
    [drvPayrollEndDate] datetime NULL,
    [drvPayrollEffectiveDate] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EASCCONTES_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EASCCONTES_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCOID] char(5) NOT NULL,
    [PdhPerControl] varchar(8) NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);
IF OBJECT_ID('U_EASCCONTES_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EASCCONTES_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
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
IF OBJECT_ID('U_EASCCONTES_Trailer') IS NULL
CREATE TABLE [dbo].[U_EASCCONTES_Trailer] (
    [drvRecordType] varchar(3) NOT NULL,
    [drvDetailRecCnt] int NULL,
    [drvPayPerGrossCompTot] varchar(24) NULL,
    [drvGrossYTDCompTot] varchar(24) NULL,
    [drvPayPerHoursTot] varchar(24) NULL,
    [drvEmp401ContribTot] varchar(24) NULL,
    [drvEmprMatchContribTot] varchar(24) NULL,
    [drvProfitShareContribTot] int NOT NULL,
    [drvRothContribTot] varchar(24) NULL,
    [drvClientDataFld1Tot] int NOT NULL,
    [drvClientDataFld2Tot] int NOT NULL,
    [drvLoanPay1Tot] varchar(24) NULL,
    [drvLoanPay2Tot] varchar(24) NULL,
    [drvLoanPay3Tot] varchar(24) NULL,
    [drvLoanPay4Tot] money NULL,
    [drvLoanPay5Tot] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASCCONTES]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name:        Midwest Industrial

Created By:             Justin Sheppard
Business Analyst:         Justin Sheppard
Create Date:             01/07/2020
Service Request Number: XXX

Purpose: Ascensus 401k Cont Export TEST

Revision History
----------------
10/22/2021 by AP:
		- Added ERPRO deduction code.


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EASCCONTES';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EASCCONTES';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EASCCONTES';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EASCCONTES';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EASCCONTES' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASCCONTES', 'EASCCONTES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASCCONTES', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EASCCONTES', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@ClientNumber        VARCHAR(6)
            ,@ClientName         VARCHAR(15);

    -- Set FormatCode
    SELECT @FormatCode = 'EASCCONTES';
    SELECT @ClientNumber = '217771';
    SELECT @ClientName = 'MIDWEST';

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
    --Exclude Contractors and Interns
    DELETE dbo.U_EASCCONTES_EEList
    FROM dbo.U_EASCCONTES_EEList
    JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = xEEID and EecCOID = xCOID
    WHERE eecEEType in ('CON')


    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    --DELETE FROM dbo.U_EASCCONTES_EEList
    --WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID);
    --AND xEEID IN (SELECT xEEID FROM dbo.U_EASCCONTES_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================

    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401KF,401KP,R401F,R401P,ER401,401L,401L2,401L3,ERPRO';

    IF OBJECT_ID('U_EASCCONTES_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONTES_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EASCCONTES_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables 
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EASCCONTES_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONTES_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCOID
        ,PdhPerControl  = LEFT(PdhPerControl,8)
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401KF','401KP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('R401F','R401P') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('ER401') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('xxx','xxx') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401L') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401L2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401L3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('XXX') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('XXX') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
     INTO dbo.U_EASCCONTES_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EASCCONTES_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl between @StartPerControl and @EndPerControl
    GROUP BY PdhEEID, PdhCOID, LEFT(PdhPerControl,8)
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EASCCONTES_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONTES_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
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
    INTO dbo.U_EASCCONTES_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    --AND PehEarnCode NOT IN ('HSAER','FLXRE','CAR')
    GROUP BY PehEEID,PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EASCCONTES_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EASCCONTES_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONTES_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'DTL'
        ,drvSSN                 = eepSSN
        ,drvNameLast             = EepNameLast
        ,drvNameMiddle             = LEFT(EepNameMiddle,1)
        ,drvNameFirst             = EepNameFirst
        ,drvPayPerGrossComp     = dbo.dsi_fnPadZero(PehCurAmt,12,2)
        ,drvGrossYTDComp         = dbo.dsi_fnPadZero(PehCurAmtYTD,12,2)
        ,drvPayPerHours         = dbo.dsi_fnPadZero(PehCurHrs,12,2)
        ,drvEmp401Contrib         = dbo.dsi_fnPadZero(PdhSource1+PdhSource4,12,2)
        ,drvEmprMatchContrib     = dbo.dsi_fnPadZero(PdhSource3,12,2)
        ,drvProfitShareContrib     = ''
        ,drvRothContrib         = dbo.dsi_fnPadZero(PdhSource2,12,2)
        ,drvClientDataFld1         = ''
        ,drvClientDataFld2         = ''
        ,drvLoanPay1             = dbo.dsi_fnPadZero(PdhSource6,12,2)
        ,drvLoanPay2             = dbo.dsi_fnPadZero(PdhSource7,12,2)
        ,drvLoanPay3             = dbo.dsi_fnPadZero(PdhSource8,12,2)
        ,drvLoanPay4             = dbo.dsi_fnPadZero(PdhSource9,12,2)
        ,drvLoanPay5             = dbo.dsi_fnPadZero(PdhSource10,12,2)
    INTO dbo.U_EASCCONTES_drvTbl
    FROM dbo.U_EASCCONTES_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID and Eeccoid = xcoid
    LEFT JOIN dbo.U_EASCCONTES_PEarHist on xeeid = Peheeid and xcoid = Pehcoid
    LEFT JOIN dbo.U_EASCCONTES_PDedHist on xeeid = Pdheeid and xcoid = Pdhcoid 
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EASCCONTES_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONTES_Header;
    SELECT DISTINCT
         drvRecordType                 = 'HDR'
        ,drvCont                     = 'Contribution'
        ,drvClientNo                 = @ClientNumber
        ,drvClientName                 = @ClientName
        ,drvSiteCode                 = 'A' 
        ,drvPayrollBeginDate         = @StartDate
        ,drvPayrollEndDate             = @EndDate
        ,drvPayrollEffectiveDate     = ''
    INTO dbo.U_EASCCONTES_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EASCCONTES_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONTES_Trailer;
    SELECT DISTINCT
         drvRecordType                = 'TOT'
        ,drvDetailRecCnt             = dtlcount
        ,drvPayPerGrossCompTot         = dbo.dsi_fnPadZero(ppsal,12,2)
        ,drvGrossYTDCompTot         = dbo.dsi_fnPadZero(ssal,12,2)
        ,drvPayPerHoursTot             = dbo.dsi_fnPadZero(thrs,12,0)
        ,drvEmp401ContribTot         = dbo.dsi_fnPadZero(fsal,12,2)
        ,drvEmprMatchContribTot     = dbo.dsi_fnPadZero(msal,12,2)
        ,drvProfitShareContribTot     = 0
        ,drvRothContribTot             = dbo.dsi_fnPadZero(rsal,12,2)
        ,drvClientDataFld1Tot         = 0
        ,drvClientDataFld2Tot         = 0
        ,drvLoanPay1Tot             = dbo.dsi_fnPadZero(l1sal,12,2)
        ,drvLoanPay2Tot             = dbo.dsi_fnPadZero(l2sal,12,2)
        ,drvLoanPay3Tot             = dbo.dsi_fnPadZero(l3sal,12,2)
        ,drvLoanPay4Tot             = l4sal
        ,drvLoanPay5Tot             = l5sal
    INTO dbo.U_EASCCONTES_Trailer
    FROM (select count(*) dtlcount,
            sum(cast(drvPayPerGrossComp as money)) ppsal, sum(cast(drvGrossYTDComp as money)) ssal,
            sum(cast(drvPayPerHours as money)) thrs, sum(cast(drvEmp401Contrib as money)) fsal,
            sum(cast(drvEmprMatchContrib as money)) msal, sum(cast(drvRothContrib as money)) rsal,
            sum(cast(drvLoanPay1 as money)) l1sal, sum(cast(drvLoanPay2 as money)) l2sal,
            sum(cast(drvLoanPay3 as money)) l3sal, sum(cast(drvLoanPay4 as money)) l4sal,
            sum(cast(drvLoanPay5 as money)) l5sal
        from dbo.U_EASCCONTES_drvTbl ) cnt;
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_AscContBridge_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_AscContBridge_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'AscContBridge_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEASCCONTES_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EASCCONTES_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EASCCONTES%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201710191'
       ,expStartPerControl     = '201710191'
       ,expLastEndPerControl   = '201710269'
       ,expEndPerControl       = '201710269'
WHERE expFormatCode = 'EASCCONTES';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEASCCONTES_Export AS
    SELECT TOP 200000000 Data FROM dbo.U_EASCCONTES_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort