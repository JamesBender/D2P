SET NOCOUNT ON;
IF OBJECT_ID('U_E457TR401K_SavePath') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_E457TR401K_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'E457TR401K' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwE457TR401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwE457TR401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_E457TR401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_E457TR401K];
GO
IF OBJECT_ID('U_E457TR401K_PlanRecTbl2') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_PlanRecTbl2];
GO
IF OBJECT_ID('U_E457TR401K_PlanRecTbl1') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_PlanRecTbl1];
GO
IF OBJECT_ID('U_E457TR401K_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_PEarHist];
GO
IF OBJECT_ID('U_E457TR401K_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_PDedHist];
GO
IF OBJECT_ID('U_E457TR401K_LoanRecTbl2') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_LoanRecTbl2];
GO
IF OBJECT_ID('U_E457TR401K_LoanRecTbl1') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_LoanRecTbl1];
GO
IF OBJECT_ID('U_E457TR401K_File') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_File];
GO
IF OBJECT_ID('U_E457TR401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_EEList];
GO
IF OBJECT_ID('U_E457TR401K_DedList') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_DedList];
GO
IF OBJECT_ID('U_E457TR401K_ContRecTbl2') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_ContRecTbl2];
GO
IF OBJECT_ID('U_E457TR401K_ContRecTbl1') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_ContRecTbl1];
GO
IF OBJECT_ID('U_dsi_BDM_E457TR401K') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_E457TR401K];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'E457TR401K';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'E457TR401K';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'E457TR401K';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'E457TR401K';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'E457TR401K';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','E457TR401K','Mission Square 457 Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','E457TR401KZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'E457TR401K' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICMA"','1','(''UA''=''F'')','E457TR401KZ0','6','D','10','1',NULL,'ICMA-RC Plan Num',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','2','(''UA''=''F'')','E457TR401KZ0','2','D','10','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecSeq"','3','(''UA''=''F'')','E457TR401KZ0','4','D','10','3',NULL,'Record Sequence',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller1"','4','(''UA''=''F'')','E457TR401KZ0','4','D','10','4',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIRSNum"','5','(''UA''=''F'')','E457TR401KZ0','9','D','10','5',NULL,'IRS Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','6','(''UA''=''F'')','E457TR401KZ0','30','D','10','6',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller2"','7','(''UA''=''F'')','E457TR401KZ0','24','D','10','7',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFormatId"','8','(''UA''=''F'')','E457TR401KZ0','1','D','10','8',NULL,'Format ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICMA"','1','(''UA''=''F'')','E457TR401KZ0','6','D','20','1',NULL,'ICMA-RC Plan Num',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','2','(''UA''=''F'')','E457TR401KZ0','2','D','20','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecSeq"','3','(''UA''=''F'')','E457TR401KZ0','4','D','20','3',NULL,'Record Sequence',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller1"','4','(''UA''=''F'')','E457TR401KZ0','4','D','20','4',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIRSNum"','5','(''UA''=''F'')','E457TR401KZ0','9','D','20','5',NULL,'IRS Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotRemit"','6','(''UA''=''F'')','E457TR401KZ0','10','D','20','6',NULL,'Total Remittance',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller2"','7','(''UA''=''F'')','E457TR401KZ0','25','D','20','7',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFormatCode"','8','(''UA''=''F'')','E457TR401KZ0','2','D','20','8',NULL,'Format Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller3"','9','(''UA''=''F'')','E457TR401KZ0','6','D','20','9',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayDate"','10','(''UD112''=''F'')','E457TR401KZ0','8','D','20','10',NULL,'Payroll Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxYear"','11','(''UA''=''F'')','E457TR401KZ0','1','D','20','11',NULL,'Tax Year Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller4"','12','(''UA''=''F'')','E457TR401KZ0','2','D','20','12',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFormatId"','13','(''UA''=''F'')','E457TR401KZ0','1','D','20','13',NULL,'Format ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICMA"','1','(''UA''=''F'')','E457TR401KZ0','6','D','30','1',NULL,'ICMA-RC Plan Num',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','2','(''UA''=''F'')','E457TR401KZ0','2','D','30','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecSeq"','3','(''UA''=''F'')','E457TR401KZ0','4','D','30','3',NULL,'Record Sequence',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller1"','4','(''UA''=''F'')','E457TR401KZ0','4','D','30','4',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','5','(''UA''=''F'')','E457TR401KZ0','9','D','30','5',NULL,'Participant SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartName"','6','(''UA''=''F'')','E457TR401KZ0','30','D','30','6',NULL,'Participant Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller2"','7','(''UA''=''F'')','E457TR401KZ0','24','D','30','7',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFormatId"','8','(''UA''=''F'')','E457TR401KZ0','1','D','30','8',NULL,'Format ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICMA"','1','(''UA''=''F'')','E457TR401KZ0','6','D','40','1',NULL,'ICMA-RC Plan Num',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','2','(''UA''=''F'')','E457TR401KZ0','2','D','40','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecSeq"','3','(''UA''=''F'')','E457TR401KZ0','4','D','40','3',NULL,'Record Sequence',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsProvider"','4','(''UA''=''F'')','E457TR401KZ0','2','D','40','4',NULL,'Insurance Provider',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceCode"','5','(''UA''=''F'')','E457TR401KZ0','2','D','40','5',NULL,'Source Code for Cont Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','6','(''UA''=''F'')','E457TR401KZ0','9','D','40','6',NULL,'Participant SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContAmt"','7','(''UA''=''F'')','E457TR401KZ0','10','D','40','7',NULL,'Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxYear"','8','(''UA''=''F'')','E457TR401KZ0','1','D','40','8',NULL,'Tax Year Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFundId"','9','(''UA''=''F'')','E457TR401KZ0','4','D','40','9',NULL,'Fund ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller1"','10','(''UA''=''F'')','E457TR401KZ0','35','D','40','10',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocId"','11','(''UA''=''F'')','E457TR401KZ0','4','D','40','11',NULL,'Location ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFormatId"','12','(''UA''=''F'')','E457TR401KZ0','1','D','40','12',NULL,'Format ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICMA"','1','(''UA''=''F'')','E457TR401KZ0','6','D','50','1',NULL,'ICMA-RC Plan Num',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','2','(''UA''=''F'')','E457TR401KZ0','2','D','50','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecSeq"','3','(''UA''=''F'')','E457TR401KZ0','4','D','50','3',NULL,'Record Sequence',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller1"','4','(''UA''=''F'')','E457TR401KZ0','4','D','50','4',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','5','(''UA''=''F'')','E457TR401KZ0','9','D','50','5',NULL,'Participant SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartName"','6','(''UA''=''F'')','E457TR401KZ0','30','D','50','6',NULL,'Participant Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller2"','7','(''UA''=''F'')','E457TR401KZ0','24','D','50','7',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFormatId"','8','(''UA''=''F'')','E457TR401KZ0','1','D','50','8',NULL,'Format ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICMA"','1','(''UA''=''F'')','E457TR401KZ0','6','D','60','1',NULL,'ICMA-RC Plan Num',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','2','(''UA''=''F'')','E457TR401KZ0','2','D','60','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecSeq"','3','(''UA''=''F'')','E457TR401KZ0','4','D','60','3',NULL,'Record Sequence',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller1"','4','(''UA''=''F'')','E457TR401KZ0','1','D','60','4',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNum"','5','(''UA''=''F'')','E457TR401KZ0','3','D','60','5',NULL,'Loan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','6','(''UA''=''F'')','E457TR401KZ0','9','D','60','6',NULL,'Participant SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRepAmt"','7','(''UA''=''F'')','E457TR401KZ0','10','D','60','7',NULL,'Loan Repayment Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller2"','8','(''UA''=''F'')','E457TR401KZ0','40','D','60','8',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayIndic"','9','(''UA''=''F'')','E457TR401KZ0','4','D','60','9',NULL,'Loan Payoff Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFormatId"','10','(''UA''=''F'')','E457TR401KZ0','1','D','60','10',NULL,'Format ID',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'E457TR401K_20210901.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mission Square 457 Payroll Exp','202108189','EMPEXPORT','ONDEM_XOE',NULL,'E457TR401K',NULL,NULL,NULL,'202108189','Aug 18 2021  3:53PM','Aug 18 2021  3:53PM','202108181',NULL,'','','202108181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mission Square 457 Payro-Sched','202108189','EMPEXPORT','SCH_E457TR',NULL,'E457TR401K',NULL,NULL,NULL,'202108189','Aug 18 2021  3:53PM','Aug 18 2021  3:53PM','202108181',NULL,'','','202108181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Mission Square 457 Payro-Test','202108199','EMPEXPORT','TEST_XOE','Aug 30 2021 12:19PM','E457TR401K',NULL,NULL,NULL,'202108199','Aug 19 2021 12:00AM','Dec 30 1899 12:00AM','202108191','523','','','202108191',dbo.fn_GetTimedKey(),NULL,'us3lKiTRI1018',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'E457TR401K' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'E457TR401K' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_E457TR401K_SavePath') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D10','dbo.U_E457TR401K_PlanRecTbl1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D20','dbo.U_E457TR401K_PlanRecTbl2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D30','dbo.U_E457TR401K_ContRecTbl1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D40','dbo.U_E457TR401K_ContRecTbl2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D50','dbo.U_E457TR401K_LoanRecTbl1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D60','dbo.U_E457TR401K_LoanRecTbl2',NULL);
IF OBJECT_ID('U_dsi_BDM_E457TR401K') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_E457TR401K] (
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
IF OBJECT_ID('U_E457TR401K_ContRecTbl1') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_ContRecTbl1] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvPartName] varchar(202) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(1) NOT NULL
);
IF OBJECT_ID('U_E457TR401K_ContRecTbl2') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_ContRecTbl2] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvInsProvider] varchar(1) NOT NULL,
    [drvSourceCode] varchar(2) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvContAmt] varchar(30) NULL,
    [drvTaxYear] varchar(1) NOT NULL,
    [drvFundId] varchar(1) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvLocId] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(1) NOT NULL
);
IF OBJECT_ID('U_E457TR401K_DedList') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_E457TR401K_EEList') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_E457TR401K_File') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_E457TR401K_LoanRecTbl1') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_LoanRecTbl1] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvPartName] varchar(202) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(1) NOT NULL
);
IF OBJECT_ID('U_E457TR401K_LoanRecTbl2') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_LoanRecTbl2] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvLoanNum] varchar(1) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvLoanRepAmt] varchar(10) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvLoanPayIndic] varchar(4) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(1) NOT NULL
);
IF OBJECT_ID('U_E457TR401K_PDedHist') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCOID] char(5) NOT NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);
IF OBJECT_ID('U_E457TR401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_PEarHist] (
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
IF OBJECT_ID('U_E457TR401K_PlanRecTbl1') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_PlanRecTbl1] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvIRSNum] char(9) NULL,
    [drvPlanName] varchar(8) NOT NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);
IF OBJECT_ID('U_E457TR401K_PlanRecTbl2') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_PlanRecTbl2] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvIRSNum] char(9) NULL,
    [drvTotRemit] varchar(10) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvFormatCode] varchar(2) NOT NULL,
    [drvFiller3] varchar(1) NOT NULL,
    [drvPayDate] datetime NULL,
    [drvTaxYear] varchar(1) NOT NULL,
    [drvFiller4] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_E457TR401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Trinity River Authority of Texas

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 08/18/2021
Service Request Number: TekP-2021-07-27-0006

Purpose: Mission Square 457 Payroll Export

Revision History
----------------
08/27/2021 by AP:
        - Updated layout for plan record set.
        - Total remittance now shows TOTAL of all records.
        - Changed format of payroll date.
        - Fixed deduction codes for loan repayment amount and dataset.

09/01/2021 by AP:
		- Updated logic to update loan repayment amount.
		- Contribution lines fixed to show 1 record per employee.
        

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'E457TR401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'E457TR401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'E457TR401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'E457TR401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'E457TR401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E457TR401K', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E457TR401K', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E457TR401K', 'SCH_E457TR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'E457TR401K';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'E457TR401K', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'E457TR401K';

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
    DELETE FROM dbo.U_E457TR401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_E457TR401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BEDA, BEDAC, BEDP, BEDPC, BEDPR, BDC1, BDC2, BDC3, BDC4, BDC5, BDC6, BDC7, BDC8, BDC9, BDC10, BDC11, BDC12, BDC13, BDC14, BDC15, BDC16,
                        BDC17, BDC18, BDC19, BDC20, BDC21, BDC22, BDC23, BDC24, BDC25, BDC26, BDC27, BDC28, BDC29, BDC30';

    IF OBJECT_ID('U_E457TR401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_E457TR401K_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_E457TR401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCOID
        ,PdhDedCode
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('BEDA', 'BEDAC', 'DEDP', 'BEDPC', 'BEDPR') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_E457TR401K_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_E457TR401K_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhCOID, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_E457TR401K_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_PEarHist;
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
    INTO dbo.U_E457TR401K_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_PlanRecTbl1
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_PlanRecTbl1','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_PlanRecTbl1;
    SELECT DISTINCT
         drvEEID = '1'
        ,drvCoID = '1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '01'
        ,drvRecSeq = '0001'
        ,drvFiller1 = ''
        ,drvIRSNum = (SELECT CmmFedTaxId FROM dbo.CompMast WITH(NOLOCK))
        ,drvPlanName = '457 Plan'
        ,drvFiller2 = ''
        ,drvFormatId = '3'
        ,drvInitialSort = '0'
        ,drvSubSort = '0'
    INTO dbo.U_E457TR401K_PlanRecTbl1
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_PlanRecTbl2
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_PlanRecTbl2','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_PlanRecTbl2;
    SELECT DISTINCT
         drvEEID = '1'
        ,drvCoID = '1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '01'
        ,drvRecSeq = '0002'
        ,drvFiller1 = ''
        ,drvIRSNum = (SELECT CmmFedTaxId FROM dbo.CompMast WITH(NOLOCK))
        ,drvTotRemit = RIGHT('0000000000' + REPLACE(CAST(SUM(PdhSource1) AS VARCHAR), '.', ''), 10)
        ,drvFiller2 = ''
        ,drvFormatCode = '03'
        ,drvFiller3 = ''
        ,drvPayDate = MAX(PrgPayDate)
        ,drvTaxYear = ''
        ,drvFiller4 = ''
        ,drvFormatId = '3'
        ,drvInitialSort = '0'
        ,drvSubSort = '0'
    INTO dbo.U_E457TR401K_PlanRecTbl2
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
    ON PdhEEID = xEEID AND PdhCOID = xCOID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_ContRecTbl1
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_ContRecTbl1','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_ContRecTbl1;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '02'
        ,drvRecSeq = '0001'
        ,drvFiller1 = ''
        ,drvPartSSN = EepSSN
        ,drvPartName = EepNameLast + ', ' + EepNameFirst
        ,drvFiller2 = ''
        ,drvFormatId = '3'
        ,drvInitialSort = RTRIM(LTRIM(EepSSN))
        ,drvSubSort = '3'
    INTO dbo.U_E457TR401K_ContRecTbl1
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
    ON PdhEEID = xEEID AND PdhCOID = xCOID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_ContRecTbl2
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_ContRecTbl2','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_ContRecTbl2;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '02'
        ,drvRecSeq = '0002'
        ,drvInsProvider = ''
        ,drvSourceCode = 'EE'
        ,drvPartSSN = EepSSN
        ,drvContAmt = RIGHT('0000000000' + REPLACE(CAST(CAST(PdhSource1 AS DECIMAL(10,2)) AS VARCHAR), '.', ''), 10)
        ,drvTaxYear = ''
        ,drvFundId = ''
        ,drvFiller1 = ''
        ,drvLocId = ''
        ,drvFormatId = '3'
        ,drvInitialSort = RTRIM(LTRIM(EepSSN))
        ,drvSubSort = '4'
    INTO dbo.U_E457TR401K_ContRecTbl2
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
	JOIN (SELECT PdhEEID, PdhCOID, SUM(PdhSource1) PdhSource1
                FROM dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
                WHERE PdhDedCode IN ('BEDA', 'BEDAC', 'BEDP', 'BEDPC', 'BEDPR', 'BDC1', 'BDC2', 'BDC3', 'BDC4', 'BDC5', 'BDC6', 'BDC7', 'BDC8', 'BDC9', 'BDC10', 'BDC11', 'BDC12', 'BDC13', 'BDC14', 'BDC15', 'BDC16',
                        'BDC17', 'BDC18', 'BDC19', 'BDC20', 'BDC21', 'BDC22', 'BDC23', 'BDC24', 'BDC25', 'BDC26', 'BDC27', 'BDC28', 'BDC29', 'BDC30')
                GROUP BY PdhEEID, PdhCOID) Pdh ON Pdh.PdhEEID = xEEID AND Pdh.PdhCOID = xCOID
    --JOIN dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
    --ON PdhEEID = xEEID AND PdhCOID = xCOID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_LoanRecTbl1
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_LoanRecTbl1','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_LoanRecTbl1;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '03'
        ,drvRecSeq = '0001'
        ,drvFiller1 = ''
        ,drvPartSSN = EepSSN
        ,drvPartName = EepNameLast + ', ' + EepNameFirst
        ,drvFiller2 = ''
        ,drvFormatId = '3'
        ,drvInitialSort = RTRIM(LTRIM(EepSSN))
        ,drvSubSort = '5'
    INTO dbo.U_E457TR401K_LoanRecTbl1
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
    ON PdhEEID = xEEID AND PdhCOID = xCOID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_LoanRecTbl2
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_LoanRecTbl2','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_LoanRecTbl2;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '03'
        ,drvRecSeq = '0002'
        ,drvFiller1 = ''
        ,drvLoanNum = '' -- Client to determine field to use (as per spec)
        ,drvPartSSN = EepSSN
        ,drvLoanRepAmt = RIGHT('0000000000' + REPLACE(CAST(PdhEECurAmt AS VARCHAR), '.', ''), 10) 
        ,drvFiller2 = ''
        ,drvLoanPayIndic = 'POFF'
        ,drvFormatId = '3'
        ,drvInitialSort = RTRIM(LTRIM(EepSSN))
        ,drvSubSort = '6'
    INTO dbo.U_E457TR401K_LoanRecTbl2
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID
    LEFT JOIN (SELECT PdhEEID, PdhCOID, SUM(PdhEECurAmt) PdhEECurAmt
                FROM dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
                WHERE PdhDedCode IN ('BDC1', 'BDC2', 'BDC3', 'BDC4',
                                    'BDC5', 'BDC6', 'BDC7', 'BDC8', 'BDC9', 'BDC10', 'BDC11',
                                    'BDC12', 'BDC13', 'BDC14', 'BDC15', 'BDC16', 'BDC17', 'BDC18',
                                    'BDC19', 'BDC20', 'BDC21', 'BDC22', 'BDC23', 'BDC24', 'BDC25',
                                    'BDC26', 'BDC27', 'BDC28', 'BDC29', 'BDC30')
                GROUP BY PdhEEID, PdhCOID) Pdh ON Pdh.PdhEEID = xEEID AND Pdh.PdhCOID = xCOID
    --WHERE PdhDedCode IN ('BDC1', 'BDC2', 'BDC3', 'BDC4',
    --                                'BDC5', 'BDC6', 'BDC7', 'BDC8', 'BDC9', 'BDC10', 'BDC11',
    --                                'BDC12', 'BDC13', 'BDC14', 'BDC15', 'BDC16', 'BDC17', 'BDC18',
    --                                'BDC19', 'BDC20', 'BDC21', 'BDC22', 'BDC23', 'BDC24', 'BDC25',
    --                                'BDC26', 'BDC27', 'BDC28', 'BDC29', 'BDC30')
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
ALTER VIEW dbo.dsi_vwE457TR401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_E457TR401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'E457TR401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108111'
       ,expStartPerControl     = '202108111'
       ,expLastEndPerControl   = '202108189'
       ,expEndPerControl       = '202108189'
WHERE expFormatCode = 'E457TR401K';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwE457TR401K_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_E457TR401K_File WITH (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;