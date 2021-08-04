SET NOCOUNT ON;
IF OBJECT_ID('U_EASCCONT_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EASCCONT_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EASCCONT_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EASCCONT' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEASCCONT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEASCCONT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EASCCONT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASCCONT];
GO
IF OBJECT_ID('U_EASCCONT_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EASCCONT_Trailer];
GO
IF OBJECT_ID('U_EASCCONT_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EASCCONT_PEarHist];
GO
IF OBJECT_ID('U_EASCCONT_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EASCCONT_PDedHist];
GO
IF OBJECT_ID('U_EASCCONT_Header') IS NOT NULL DROP TABLE [dbo].[U_EASCCONT_Header];
GO
IF OBJECT_ID('U_EASCCONT_File') IS NOT NULL DROP TABLE [dbo].[U_EASCCONT_File];
GO
IF OBJECT_ID('U_EASCCONT_EEList') IS NOT NULL DROP TABLE [dbo].[U_EASCCONT_EEList];
GO
IF OBJECT_ID('U_EASCCONT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EASCCONT_drvTbl];
GO
IF OBJECT_ID('U_EASCCONT_DedList') IS NOT NULL DROP TABLE [dbo].[U_EASCCONT_DedList];
GO
IF OBJECT_ID('U_EASCCONT_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EASCCONT_AuditFields];
GO
IF OBJECT_ID('U_EASCCONT_Audit') IS NOT NULL DROP TABLE [dbo].[U_EASCCONT_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EASCCONT';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EASCCONT';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EASCCONT';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EASCCONT';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EASCCONT';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EASCCONT','Ascensus 401k Contribution','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EASCCONT0Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EASCCONT' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''F'')','EASCCONT0Z0','5','H','01','1',NULL,'HDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cont"','2','(''DA''=''F'')','EASCCONT0Z0','12','H','01','2',NULL,'Cont',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"227412"','3','(''DA''=''F'')','EASCCONT0Z0','20','H','01','3',NULL,'Client Id #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','EASCCONT0Z0','2','H','01','4',NULL,'Blank Space',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"P & L Global"','5','(''DA''=''F'')','EASCCONT0Z0','15','H','01','5',NULL,'Client Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSiteCode"','6','(''UA''=''F'')','EASCCONT0Z0','12','H','01','6',NULL,'Site Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodStartDate"','7','(''UDMDY''=''F'')','EASCCONT0Z0','12','H','01','7',NULL,'Payroll Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','8','(''UDMDY''=''F'')','EASCCONT0Z0','12','H','01','8',NULL,'Check Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayEffectiveMonth"','9','(''UA''=''F'')','EASCCONT0Z0','12','H','01','9',NULL,'Payroll Effective Month',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EASCCONT0Z0','120','H','01','10',NULL,'Blank Space',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EASCCONT0Z0','5','H','02','11',NULL,'Blank Space',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Soc. Sec #"','12','(''DA''=''F'')','EASCCONT0Z0','12','H','02','12',NULL,'Soc. Sec #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','13','(''DA''=''F'')','EASCCONT0Z0','20','H','02','13',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MI"','14','(''DA''=''F'')','EASCCONT0Z0','2','H','02','14',NULL,'MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','15','(''DA''=''F'')','EASCCONT0Z0','15','H','02','15',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Gross Compensation"','16','(''DA''=''F'')','EASCCONT0Z0','12','H','02','16',NULL,'Pay Period Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Gross Compensation"','17','(''DA''=''F'')','EASCCONT0Z0','12','H','02','17',NULL,'YTD Gross Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours"','18','(''DA''=''F'')','EASCCONT0Z0','12','H','02','18',NULL,'Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Contributions"','19','(''DA''=''F'')','EASCCONT0Z0','12','H','02','19',NULL,'EE Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ER Match"','20','(''DA''=''F'')','EASCCONT0Z0','12','H','02','20',NULL,'ER Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Profit Sharing"','21','(''DA''=''F'')','EASCCONT0Z0','12','H','02','21',NULL,'Profit Sharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Roth"','22','(''DA''=''F'')','EASCCONT0Z0','12','H','02','22',NULL,'Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Special-Contribution"','23','(''DA''=''F'')','EASCCONT0Z0','12','H','02','23',NULL,'Special-Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Special-Contribution"','24','(''DA''=''F'')','EASCCONT0Z0','12','H','02','24',NULL,'Special-Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan 1"','25','(''DA''=''F'')','EASCCONT0Z0','12','H','02','25',NULL,'Loan 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan 2"','26','(''DA''=''F'')','EASCCONT0Z0','12','H','02','26',NULL,'Loan 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan 3"','27','(''DA''=''F'')','EASCCONT0Z0','12','H','02','27',NULL,'Loan 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan 4"','28','(''DA''=''F'')','EASCCONT0Z0','12','H','02','28',NULL,'Loan 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan 5"','29','(''DA''=''F'')','EASCCONT0Z0','12','H','02','29',NULL,'Loan 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DTL"','1','(''DA''=''F'')','EASCCONT0Z0','5','D','10','1',NULL,'DTL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','EASCCONT0Z0','12','D','10','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','3','(''UA''=''F'')','EASCCONT0Z0','20','D','10','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','4','(''UA''=''F'')','EASCCONT0Z0','2','D','10','4',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''F'')','EASCCONT0Z0','15','D','10','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodComp"','6','(''UNT2''=''F'')','EASCCONT0Z0','12','D','10','6',NULL,'Pay period Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDComp"','7','(''UNT2''=''F'')','EASCCONT0Z0','12','D','10','7',NULL,'YTD Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHours"','8','(''UNT0''=''F'')','EASCCONT0Z0','12','D','10','8',NULL,'Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDef401k"','9','(''UNT2''=''F'')','EASCCONT0Z0','12','D','10','9',NULL,'Employee Deferral-401k',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMatch"','10','(''UNT2''=''F'')','EASCCONT0Z0','12','D','10','10',NULL,'Employer Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','11','(''DA''=''F'')','EASCCONT0Z0','12','D','10','11',NULL,'Employer Profit Sharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRoth"','12','(''UNT2''=''F'')','EASCCONT0Z0','12','D','10','12',NULL,'Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','13','(''DA''=''F'')','EASCCONT0Z0','12','D','10','13',NULL,'Special-Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','14','(''DA''=''F'')','EASCCONT0Z0','12','D','10','14',NULL,'Special-Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoan"','15','(''UNT2''=''F'')','EASCCONT0Z0','12','D','10','15',NULL,'Loan #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','16','(''DA''=''F'')','EASCCONT0Z0','12','D','10','16',NULL,'Loan #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','17','(''DA''=''F'')','EASCCONT0Z0','12','D','10','17',NULL,'Loan #3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','18','(''DA''=''F'')','EASCCONT0Z0','12','D','10','18',NULL,'Loan #4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','19','(''DA''=''F'')','EASCCONT0Z0','12','D','10','19',NULL,'Loan #5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TOT"','1','(''DA''=''F'')','EASCCONT0Z0','5','T','90','1',NULL,'TOT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalRecords"','2','(''UNT0''=''F'')','EASCCONT0Z0','12','T','90','2',NULL,'Total Number of Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EASCCONT0Z0','20','T','90','3',NULL,'Blank Space',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','EASCCONT0Z0','2','T','90','4',NULL,'Blank Space',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EASCCONT0Z0','15','T','90','5',NULL,'Blank Space',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalPayPeriodComp"','6','(''UNT2''=''F'')','EASCCONT0Z0','12','T','90','6',NULL,'Grand Total Pay Period Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalYTDComp"','7','(''UNT2''=''F'')','EASCCONT0Z0','12','T','90','7',NULL,'Grand Total YTD Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalHours"','8','(''UNT0''=''F'')','EASCCONT0Z0','12','T','90','8',NULL,'Grand Total Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalEmpDef401k"','9','(''UNT2''=''F'')','EASCCONT0Z0','12','T','90','9',NULL,'Grand Total Employee 401k',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalEmpMatch"','10','(''UNT2''=''F'')','EASCCONT0Z0','12','T','90','10',NULL,'Grand Total Employer Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','11','(''DA''=''F'')','EASCCONT0Z0','12','T','90','11',NULL,'Grand Total Employer Profit Share',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalRoth"','12','(''UNT2''=''F'')','EASCCONT0Z0','12','T','90','12',NULL,'Grand Total Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','13','(''DA''=''F'')','EASCCONT0Z0','12','T','90','13',NULL,'Special',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','14','(''DA''=''F'')','EASCCONT0Z0','12','T','90','14',NULL,'Special',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalLoan"','15','(''UNT2''=''F'')','EASCCONT0Z0','12','T','90','15',NULL,'Grand Total Loan #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','16','(''DA''=''F'')','EASCCONT0Z0','12','T','90','16',NULL,'Grand Total  Loan #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','17','(''DA''=''F'')','EASCCONT0Z0','12','T','90','17',NULL,'Grand Total Loan #3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','18','(''DA''=''F'')','EASCCONT0Z0','12','T','90','18',NULL,'Grand Total  Loan #4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.00"','19','(''DA''=''F'')','EASCCONT0Z0','12','T','90','19',NULL,'Grand Total  Loan #5',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EASCCONT_20210729.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ascensus 401k Cont','202106269','EMPEXPORT','ONDEM_XOE',NULL,'EASCCONT',NULL,NULL,NULL,'202106269','Jun 26 2021  1:06PM','Jun 26 2021  1:06PM','202106261',NULL,'','','202106261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ascensus 401k Cont-Sched','202106269','EMPEXPORT','SCH_EASCEN',NULL,'EASCCONT',NULL,NULL,NULL,'202106269','Jun 26 2021  1:06PM','Jun 26 2021  1:06PM','202106261',NULL,'','','202106261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','1TIHJ,1TILG',NULL,NULL,NULL,'Ascensus 401k Cont-Test','202107099','EMPEXPORT','TEST_XOE','Jul 28 2021  8:55AM','EASCCONT',NULL,NULL,NULL,'202107099','Jul  9 2021 12:00AM','Dec 30 1899 12:00AM','202107091','2062','eecPayGroup','WKNY','202107091',dbo.fn_GetTimedKey(),NULL,'us3lKiPLD1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONT','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONT','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EASCCONT' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EASCCONT' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EASCCONT_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EASCCONT_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASCCONT','H01','dbo.U_EASCCONT_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASCCONT','D10','dbo.U_EASCCONT_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASCCONT','T90','dbo.U_EASCCONT_Trailer',NULL);
IF OBJECT_ID('U_EASCCONT_Audit') IS NULL
CREATE TABLE [dbo].[U_EASCCONT_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCoID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audProcessedDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EASCCONT_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EASCCONT_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EASCCONT_DedList') IS NULL
CREATE TABLE [dbo].[U_EASCCONT_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EASCCONT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EASCCONT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvPayPeriodComp] numeric NULL,
    [drvYTDComp] numeric NULL,
    [drvHours] decimal NULL,
    [drvEmpDef401k] numeric NULL,
    [drvEmpMatch] numeric NULL,
    [drvRoth] numeric NULL,
    [drvLoan] numeric NULL
);
IF OBJECT_ID('U_EASCCONT_EEList') IS NULL
CREATE TABLE [dbo].[U_EASCCONT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EASCCONT_File') IS NULL
CREATE TABLE [dbo].[U_EASCCONT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EASCCONT_Header') IS NULL
CREATE TABLE [dbo].[U_EASCCONT_Header] (
    [drvSiteCode] varchar(1) NULL,
    [drvCheckDate] datetime NULL,
    [drvPeriodStartDate] nvarchar(4000) NULL,
    [drvPayEffectiveMonth] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EASCCONT_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EASCCONT_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPeriod401FComp] numeric NULL,
    [PdhPeriod401PComp] numeric NULL,
    [PdhPeriod401CFComp] numeric NULL,
    [PdhPeriod401CPComp] numeric NULL,
    [PdhPeriodROTHComp] numeric NULL,
    [PdhEmpDef401k] numeric NULL,
    [PdhEmpMatch] numeric NULL,
    [PdhRoth] numeric NULL,
    [PdhLoan] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhPeriod401FYTDComp] numeric NULL,
    [PdhPeriod401PYTDComp] numeric NULL,
    [PdhPeriod401CFYTDComp] numeric NULL,
    [PdhPeriod401CPYTDComp] numeric NULL,
    [PdhPeriodROTHYTDComp] numeric NULL
);
IF OBJECT_ID('U_EASCCONT_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EASCCONT_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPayRollEffMonth] nvarchar(4000) NULL,
    [PrgPayBeginDate] nvarchar(4000) NULL,
    [PehCurHrs] decimal NULL,
    [PehPeriodComp] numeric NULL,
    [PehPeriodYTDComp] numeric NULL
);
IF OBJECT_ID('U_EASCCONT_Trailer') IS NULL
CREATE TABLE [dbo].[U_EASCCONT_Trailer] (
    [drvTotalRecords] int NULL,
    [drvTotalPayPeriodComp] numeric NULL,
    [drvTotalYTDComp] numeric NULL,
    [drvTotalHours] decimal NULL,
    [drvTotalEmpDef401k] numeric NULL,
    [drvTotalEmpMatch] numeric NULL,
    [drvTotalRoth] numeric NULL,
    [drvTotalLoan] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASCCONT]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: PL Developments

Created By: Keary McCutchen
Business Analyst: Lea King
Create Date: 06/24/2021
Service Request Number: TekP-2021-05-03-0002

Purpose: Ascensus 401k Contribution

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EASCCONT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EASCCONT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EASCCONT';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EASCCONT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EASCCONT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASCCONT', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASCCONT', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASCCONT', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASCCONT', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASCCONT', 'SCH_EASCEN';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EASCCONT';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EASCCONT', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EASCCONT';

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
    DELETE FROM dbo.U_EASCCONT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EASCCONT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --DELETE TEST/BAD EMPLOYEES
    DELETE EE
    FROM dbo.U_EASCCONT_EEList EE
    JOIN dbo.EmpComp WITH (NOLOCK)
      ON EecEEID = xEEID
     AND EecCOID = xCOID
        JOIN dbo.EmpPers WITH (NOLOCK)
      ON EepEEID = xEEID
    WHERE EecEEType = 'TES';

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CF,401CP,401F,401L,401L2,401P,4MTCH,ROTH';

    IF OBJECT_ID('U_EASCCONT_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONT_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EASCCONT_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EASCCONT_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONT_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        --PehInclInDefComp = 'Y'
        ,PdhPeriod401FComp        = SUM(CASE WHEN PdhDedCode IN ('401F') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhPeriod401PComp        = SUM(CASE WHEN PdhDedCode IN ('401P') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhPeriod401CFComp        = SUM(CASE WHEN PdhDedCode IN ('401CF') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhPeriod401CPComp        = SUM(CASE WHEN PdhDedCode IN ('401CP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhPeriodROTHComp        = SUM(CASE WHEN PdhDedCode IN ('ROTH') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhDedCalcBasisAmt ELSE 0.00 END)

        ,PdhEmpDef401k        = SUM(CASE WHEN PdhDedCode IN ('401F','401P','401CF','401CP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEmpMatch        = SUM(CASE WHEN PdhDedCode IN ('401F','401P','401CF','401CP','ROTH') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhRoth            = SUM(CASE WHEN PdhDedCode IN ('ROTH') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLoan            = SUM(CASE WHEN PdhDedCode IN ('401L','401L2') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt        = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhPeriod401FYTDComp        = SUM(CASE WHEN PdhDedCode IN ('401F') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhPeriod401PYTDComp        = SUM(CASE WHEN PdhDedCode IN ('401P') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhPeriod401CFYTDComp        = SUM(CASE WHEN PdhDedCode IN ('401CF') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhPeriod401CPYTDComp        = SUM(CASE WHEN PdhDedCode IN ('401CP') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhPeriodROTHYTDComp        = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
    INTO dbo.U_EASCCONT_PDedHist
    FROM dbo.U_EASCCONT_EEList WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_EASCCONT_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EASCCONT_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONT_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgPayRollEffMonth     = MAX(FORMAT(PrgPeriodEndDate, 'MMyyyy' ))
        ,PrgPayBeginDate        = MAX(FORMAT(PrgPeriodStartDate, 'MMyyyy' ))
        -- Current Payroll Amount/Hours
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        ,PehPeriodComp            = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        -- YTD Compensation
        ,PehPeriodYTDComp        = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt ELSE 0.00 END)
    INTO dbo.U_EASCCONT_PEarHist
    FROM dbo.U_EASCCONT_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
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
    -- DETAIL RECORD - U_EASCCONT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EASCCONT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameFirst = EepNameFirst
        ,drvPayPeriodComp = CASE WHEN PdhPeriod401FComp > 0.00 THEN PdhPeriod401FComp
                                 WHEN PdhPeriod401PComp > 0.00 THEN PdhPeriod401PComp
                                 WHEN PdhPeriod401CFComp > 0.00 THEN PdhPeriod401CFComp
                                 WHEN PdhPeriod401CPComp > 0.00 THEN PdhPeriod401CPComp
                                 WHEN PdhPeriodROTHComp > 0.00 THEN PdhPeriodROTHComp
                                 ELSE PehPeriodComp 
                            END
        ,drvYTDComp = CASE WHEN PdhPeriod401FYTDComp > 0.00 THEN PdhPeriod401FYTDComp
                                 WHEN PdhPeriod401PYTDComp > 0.00 THEN PdhPeriod401PYTDComp
                                 WHEN PdhPeriod401CFYTDComp > 0.00 THEN PdhPeriod401CFYTDComp
                                 WHEN PdhPeriod401CPYTDComp > 0.00 THEN PdhPeriod401CPYTDComp
                                 WHEN PdhPeriodROTHYTDComp > 0.00 THEN PdhPeriodROTHYTDComp
                                 ELSE PehPeriodYTDComp 
                            END
        ,drvHours = PehCurHrs
        ,drvEmpDef401k = PdhEmpDef401k
        ,drvEmpMatch = PdhEmpMatch
        ,drvRoth = PdhRoth
        ,drvLoan = PdhLoan
    INTO dbo.U_EASCCONT_drvTbl
    FROM dbo.U_EASCCONT_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT
    JOIN dbo.U_EASCCONT_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID    
    LEFT
    JOIN dbo.U_EASCCONT_PEarHist WITH (NOLOCK)
        ON  PehEEID = xEEID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EASCCONT_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONT_Header;
    SELECT DISTINCT
         drvSiteCode = CASE EecPayGroup 
                           WHEN 'WKNY' THEN 'A'
                           WHEN 'WKFL2' THEN 'B'
                           WHEN 'WKCA' THEN 'F'
                           WHEN 'WKSC' THEN 'G'
                       END
        ,drvCheckDate = (SELECT MAX(PrgPayDate) FROM  dbo.U_EASCCONT_PEarHist) 
        ,drvPeriodStartDate = (SELECT MAX(PrgPayBeginDate) FROM  dbo.U_EASCCONT_PEarHist)
        ,drvPayEffectiveMonth = (SELECT MAX(PrgPayRollEffMonth) FROM  dbo.U_EASCCONT_PEarHist)
    INTO dbo.U_EASCCONT_Header
    FROM dbo.U_EASCCONT_EEList
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        ;

  ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EASCCONT_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONT_Trailer;
    SELECT DISTINCT
         drvTotalRecords = COUNT(*)
        ,drvTotalPayPeriodComp = SUM(drvPayPeriodComp)
        ,drvTotalYTDComp = SUM(drvYTDComp)
        ,drvTotalHours = SUM(drvHours)
        ,drvTotalEmpDef401k = SUM(drvEmpDef401k)
        ,drvTotalEmpMatch = SUM(drvEmpMatch)
        ,drvTotalRoth = SUM(drvRoth)
        ,drvTotalLoan = SUM(drvLoan)
    INTO dbo.U_EASCCONT_Trailer
    FROM dbo.U_EASCCONT_drvTbl WITH (NOLOCK)
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
ALTER VIEW dbo.dsi_vwEASCCONT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EASCCONT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EASCCONT%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107091'
       ,expStartPerControl     = '202107091'
       ,expLastEndPerControl   = '202107099'
       ,expEndPerControl       = '202107099'
       ,expSelectByField    =''
       ,expSelectByList        =''                                                                                                                                                                                                                                                                            
WHERE expFormatCode = 'EASCCONT' and expExportCode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEASCCONT_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EASCCONT_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort