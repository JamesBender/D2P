SET NOCOUNT ON;
IF OBJECT_ID('U_ECITAQNACH_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECITAQNACH_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECITAQNACH' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECITAQNACH_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECITAQNACH_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECITAQNACH') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECITAQNACH];
GO
IF OBJECT_ID('U_ECITAQNACH_T9') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_T9];
GO
IF OBJECT_ID('U_ECITAQNACH_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_SavePath];
GO
IF OBJECT_ID('U_ECITAQNACH_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_PDedHist];
GO
IF OBJECT_ID('U_ECITAQNACH_Nines') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_Nines];
GO
IF OBJECT_ID('U_ECITAQNACH_H1') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_H1];
GO
IF OBJECT_ID('U_ECITAQNACH_File') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_File];
GO
IF OBJECT_ID('U_ECITAQNACH_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_EEList];
GO
IF OBJECT_ID('U_ECITAQNACH_D8') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_D8];
GO
IF OBJECT_ID('U_ECITAQNACH_D6') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_D6];
GO
IF OBJECT_ID('U_ECITAQNACH_D5') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_D5];
GO
IF OBJECT_ID('U_ECITAQNACH_Bank') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_Bank];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECITAQNACH';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECITAQNACH';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECITAQNACH';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECITAQNACH';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECITAQNACH';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ECITAQNACH','Citi NACHA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','94','S','N','ECITAQNACHZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECITAQNACH' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','1','(''DA''=''F'')','ECITAQNACHZ0','1','H','01','1',NULL,'Record Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','2','(''DA''=''F'')','ECITAQNACHZ0','2','H','01','2',NULL,'Priority Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvImmediateDestination"','3','(''UA''=''F'')','ECITAQNACHZ0','10','H','01','4',NULL,'Immediate Destination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvImmediateOriginCode"','4','(''UA''=''F'')','ECITAQNACHZ0','10','H','01','14',NULL,'Immediate Origin Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreationDate"','5','(''UA''=''F'')','ECITAQNACHZ0','6','H','01','24',NULL,'File Creation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreationTime"','6','(''UA''=''F'')','ECITAQNACHZ0','4','H','01','30',NULL,'File Creation Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','7','(''DA''=''F'')','ECITAQNACHZ0','1','H','01','34',NULL,'File ID Modifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"094"','8','(''DA''=''F'')','ECITAQNACHZ0','3','H','01','35',NULL,'Record Size',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"10"','9','(''DA''=''F'')','ECITAQNACHZ0','2','H','01','38',NULL,'Blocking Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','10','(''DA''=''F'')','ECITAQNACHZ0','1','H','01','40',NULL,'Format Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvImmediateDestinationName"','11','(''UA''=''F'')','ECITAQNACHZ0','23','H','01','41',NULL,'Immediate Destination Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvImmediateOriginName"','12','(''UA''=''F'')','ECITAQNACHZ0','23','H','01','64',NULL,'Immediate Origin Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','ECITAQNACHZ0','8','H','01','87',NULL,'Referrence Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"5"','1','(''DA''=''F'')','ECITAQNACHZ0','1','D','10','1',NULL,'Record Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"200"','2','(''DA''=''F'')','ECITAQNACHZ0','3','D','10','2',NULL,'Service Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyName"','3','(''UA''=''F'')','ECITAQNACHZ0','16','D','10','5',NULL,'Company Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyDiscretionaryData"','4','(''UA''=''F'')','ECITAQNACHZ0','20','D','10','21',NULL,'Company Discretionary Data',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyIdentification"','5','(''UA''=''F'')','ECITAQNACHZ0','10','D','10','41',NULL,'Company Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CCD"','6','(''DA''=''F'')','ECITAQNACHZ0','3','D','10','51',NULL,'Standard Entry Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CREDITS"','7','(''DA''=''F'')','ECITAQNACHZ0','10','D','10','54',NULL,'Company Entry Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyDescriptiveDate"','8','(''UA''=''F'')','ECITAQNACHZ0','6','D','10','64',NULL,'Company Descriptive Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveEntryDate"','9','(''UA''=''F'')','ECITAQNACHZ0','6','D','10','70',NULL,'Effective Entry Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','ECITAQNACHZ0','3','D','10','76',NULL,'Settlement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','11','(''DA''=''F'')','ECITAQNACHZ0','1','D','10','79',NULL,'Originator Status code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginatingDFIIdentifictin"','12','(''UA''=''F'')','ECITAQNACHZ0','8','D','10','80',NULL,'Originating DFI Identificaiton',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000001"','13','(''DA''=''F'')','ECITAQNACHZ0','7','D','10','88',NULL,'Batch Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"6"','1','(''DA''=''F'')','ECITAQNACHZ0','1','D','20','1',NULL,'Record Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransactionCode"','2','(''UA''=''F'')','ECITAQNACHZ0','2','D','20','2',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReceivingDFIIdentification"','3','(''UA''=''F'')','ECITAQNACHZ0','8','D','20','4',NULL,'Receiving DFI Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDigit"','4','(''UA''=''F'')','ECITAQNACHZ0','1','D','20','12',NULL,'Check Digit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDFIAccountNumber"','5','(''UA''=''F'')','ECITAQNACHZ0','17','D','20','13',NULL,'DFI Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmount"','6','(''UN0''=''F'')','ECITAQNACHZ0','10','D','20','30',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIdentificationNumber"','7','(''UA''=''F'')','ECITAQNACHZ0','15','D','20','40',NULL,'Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReceivingCompanyName"','8','(''UA''=''F'')','ECITAQNACHZ0','22','D','20','55',NULL,'Receiving Company Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDiscretionaryData"','9','(''UA''=''F'')','ECITAQNACHZ0','2','D','20','77',NULL,'Discretionary Data',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','10','(''DA''=''F'')','ECITAQNACHZ0','1','D','20','79',NULL,'Addenda Record Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTraceNumber"','11','(''UA''=''F'')','ECITAQNACHZ0','15','D','20','80',NULL,'Trace Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"8"','1','(''UA''=''F'')','ECITAQNACHZ0','1','D','30','1',NULL,'Record Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"200"','2','(''UA''=''F'')','ECITAQNACHZ0','3','D','30','2',NULL,'Service Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEntryAddendaCount"','3','(''UN0''=''F'')','ECITAQNACHZ0','6','D','30','5',NULL,'Entry / Addenda Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEntryHash"','4','(''UN0''=''F'')','ECITAQNACHZ0','10','D','30','11',NULL,'Entry Hash',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalDebitEntryDollarAmt"','5','(''UN0''=''F'')','ECITAQNACHZ0','12','D','30','21',NULL,'Total Debit Entry Dollar Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalCreditEntryDollarAmt"','6','(''UN0''=''F'')','ECITAQNACHZ0','12','D','30','33',NULL,'Total Credit Entry Dollar Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyIdentification"','7','(''UA''=''F'')','ECITAQNACHZ0','10','D','30','45',NULL,'Company Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','ECITAQNACHZ0','19','D','30','55',NULL,'Message Authentication Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','ECITAQNACHZ0','6','D','30','74',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginatingDFIIdentifictin"','10','(''UA''=''F'')','ECITAQNACHZ0','8','D','30','80',NULL,'Originating DFI Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000001"','11','(''DA''=''F'')','ECITAQNACHZ0','7','D','30','88',NULL,'Batch Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"9"','1','(''DA''=''F'')','ECITAQNACHZ0','1','T','90','1',NULL,'Record Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000001"','2','(''DA''=''F'')','ECITAQNACHZ0','6','T','90','2',NULL,'Batch Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBlockCount"','3','(''UN0''=''F'')','ECITAQNACHZ0','6','T','90','8',NULL,'Block Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEntryAddendaCount"','4','(''UN0''=''F'')','ECITAQNACHZ0','8','T','90','14',NULL,'Entry / Addenda Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEntryHash"','5','(''UN0''=''F'')','ECITAQNACHZ0','10','T','90','22',NULL,'Entry Hash',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalDebitEntryDollarAmt"','6','(''UN0''=''F'')','ECITAQNACHZ0','12','T','90','32',NULL,'Total Debit Entry Dollar Amount in File',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalCreditEntryDollarAmt"','7','(''UN0''=''F'')','ECITAQNACHZ0','12','T','90','44',NULL,'Total Credit Entry Dollar Amount in File',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','ECITAQNACHZ0','39','T','90','56',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"9"','1','(''DR''=''F'')','ECITAQNACHZ0','94','T','91','1',NULL,'Nine Records for Block Count',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECITAQNACH_20210811.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Custom NACHA HSA Export','201707019','EMPEXPORT','ONDEMAND','Jul  1 2017 12:00AM','ECITAQNACH',NULL,NULL,NULL,'201707019','Jul  1 2017 12:00AM','Dec 30 1899 12:00AM','201707011',NULL,'','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Testing Purposes Only','202106251','EMPEXPORT','TEST','Jul 27 2021  4:18PM','ECITAQNACH',NULL,NULL,NULL,'202106251','Jun 25 2021 12:00AM','Jun 20 2021 12:00AM','202106251','50','','','202106251',dbo.fn_GetTimedKey(),NULL,'us3rVaBAY1005',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECITAQNACH','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECITAQNACH','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECITAQNACH','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECITAQNACH','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECITAQNACH','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECITAQNACH' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECITAQNACH' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECITAQNACH_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECITAQNACH_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECITAQNACH','H01','dbo.U_ECITAQNACH_H1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECITAQNACH','D10','dbo.U_ECITAQNACH_D5',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECITAQNACH','D20','dbo.U_ECITAQNACH_D6',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECITAQNACH','D30','dbo.U_ECITAQNACH_D8',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECITAQNACH','T90','dbo.U_ECITAQNACH_T9',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECITAQNACH','T91','dbo.U_ECITAQNACH_Nines',NULL);
IF OBJECT_ID('U_ECITAQNACH_Bank') IS NULL
CREATE TABLE [dbo].[U_ECITAQNACH_Bank] (
    [BnkCoBankID] char(4) NOT NULL,
    [BnkBankName] varchar(40) NULL,
    [BnkAchBankRoutingNo] char(9) NULL,
    [BnkDDRecord1Pos14To23] char(10) NULL,
    [BnkDDRecord5Pos05To20] char(16) NULL,
    [BnkDDRecord5Pos21To40] char(20) NULL,
    [BnkDDRecord5Pos41To50] char(10) NULL,
    [BnkDDRecord5Pos80To87] char(8) NULL,
    [BnkDDRecord6Pos80To87] char(8) NULL,
    [BnkDDRecord8Pos45To54] char(10) NULL,
    [BnkDDRecord8Pos80To87] char(8) NULL
);
IF OBJECT_ID('U_ECITAQNACH_D5') IS NULL
CREATE TABLE [dbo].[U_ECITAQNACH_D5] (
    [drvCompanyName] char(16) NULL,
    [drvCompanyDiscretionaryData] char(20) NULL,
    [drvCompanyIdentification] char(10) NULL,
    [drvCompanyDescriptiveDate] char(6) NULL,
    [drvEffectiveEntryDate] char(6) NULL,
    [drvOriginatingDFIIdentifictin] varchar(8) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECITAQNACH_D6') IS NULL
CREATE TABLE [dbo].[U_ECITAQNACH_D6] (
    [drvTransactionCode] varchar(2) NULL,
    [drvReceivingDFIIdentification] varchar(8) NULL,
    [drvCheckDigit] varchar(1) NULL,
    [drvDFIAccountNumber] char(22) NOT NULL,
    [drvAmount] decimal NULL,
    [drvIdentificationNumber] char(11) NULL,
    [drvReceivingCompanyName] varchar(201) NULL,
    [drvDiscretionaryData] varchar(2) NULL,
    [drvTraceNumber] varchar(32) NULL,
    [drvUDField03] char(10) NULL,
    [drvInitialSort] varchar(12) NULL
);
IF OBJECT_ID('U_ECITAQNACH_D8') IS NULL
CREATE TABLE [dbo].[U_ECITAQNACH_D8] (
    [drvEntryAddendaCount] decimal NULL,
    [drvEntryHash] decimal NULL,
    [drvTotalDebitEntryDollarAmt] decimal NULL,
    [drvTotalCreditEntryDollarAmt] decimal NULL,
    [drvCompanyIdentification] char(10) NULL,
    [drvOriginatingDFIIdentifictin] char(8) NULL,
    [drvInitialSort] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECITAQNACH_EEList') IS NULL
CREATE TABLE [dbo].[U_ECITAQNACH_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECITAQNACH_File') IS NULL
CREATE TABLE [dbo].[U_ECITAQNACH_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(94) NULL
);
IF OBJECT_ID('U_ECITAQNACH_H1') IS NULL
CREATE TABLE [dbo].[U_ECITAQNACH_H1] (
    [drvImmediateDestination] varchar(10) NULL,
    [drvImmediateOriginCode] char(10) NULL,
    [drvFileCreationDate] char(6) NULL,
    [drvFileCreationTime] varchar(8000) NULL,
    [drvImmediateDestinationName] varchar(18) NOT NULL,
    [drvImmediateOriginName] char(16) NULL
);
IF OBJECT_ID('U_ECITAQNACH_Nines') IS NULL
CREATE TABLE [dbo].[U_ECITAQNACH_Nines] (
    [drvNines] varchar(94) NULL
);
IF OBJECT_ID('U_ECITAQNACH_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECITAQNACH_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCoID] char(5) NOT NULL,
    [PrgCoBankID] char(4) NOT NULL,
    [EepNameFirst] varchar(100) NULL,
    [EepNameLast] varchar(100) NULL,
    [EepSSN] char(11) NULL,
    [EecEmpNo] char(9) NULL,
    [EecUDField03] char(10) NULL,
    [EecUDField04] varchar(25) NULL,
    [EddEEBankRoute] char(9) NOT NULL,
    [EddAcct] char(22) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [RecordType] varchar(2) NULL,
    [PrhAcctType] char(1) NULL
);
IF OBJECT_ID('U_ECITAQNACH_SavePath') IS NULL
CREATE TABLE [dbo].[U_ECITAQNACH_SavePath] (
    [svFormatCode] char(10) NOT NULL,
    [svCfgName] varchar(32) NOT NULL,
    [svCfgValue] varchar(150) NULL
);
IF OBJECT_ID('U_ECITAQNACH_T9') IS NULL
CREATE TABLE [dbo].[U_ECITAQNACH_T9] (
    [drvBlockCount] int NULL,
    [drvEntryAddendaCount] decimal NULL,
    [drvEntryHash] decimal NULL,
    [drvTotalDebitEntryDollarAmt] decimal NULL,
    [drvTotalCreditEntryDollarAmt] decimal NULL,
    [drvBlockCountNines] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECITAQNACH]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Aquarium of the Bay

Created By: Andy Pineda
Business Analyst: Richard Vars
Create Date: 06/08/2021
Service Request Number: TekP-2021-03-04-0002

Purpose: Citi NACHA Export

Revision History
----------------
07/09/2021 by AP:
        - Updated immediate destination field in header.
        - Updated immediate destination name field in header.
        - Updated Origin DFI ID in batch header (record 5).

08/11/2021 by AP:
		- Changed CompanyID on record 5 and 8 to '5433018877'.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECITAQNACH';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECITAQNACH';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECITAQNACH';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'ECITAQNACH';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECITAQNACH' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECITAQNACH', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECITAQNACH', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut 'ECITAQNACH', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare Variables
    --==========================================
    DECLARE  @FormatCode         VARCHAR(12)
            ,@ExportCode         VARCHAR(12)
            ,@StartDate          DATETIME
            ,@EndDate            DATETIME
            ,@StartPerControl    VARCHAR(9)
            ,@EndPerControl      VARCHAR(9)
            ,@RunDate            DATETIME
            ,@PrgPayDate         DATETIME
            ,@IncludeOffset      CHAR(1)

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
        ,@RunDate         = GETDATE()
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'ECITAQNACH';

    -- Set @PrgPayDate to MAX Pay Date for File Header
    SET @PrgPayDate = (SELECT MAX(PrgPayDate) FROM dbo.PayReg WITH (NOLOCK) WHERE PrgPerControl BETWEEN @StartPerControl AND @EndPerControl);

    --==========================================
    -- Set @IncludeOffset Flag when including Batch Offset with Transaction Code '27' in Record Type '6' for a Balance NACHA File.
    -- Please Note: The most common method is Unbalance NACHA Files, but for a Balance NACHA File, then set the Flag to 'Y' (Yes)
    --==========================================
    SET @IncludeOffset = 'N'; -- 'N' (Unbalanace - Most Common) / 'Y' (Balanced - Rare)

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    -----------------------------
    -- Working Table - Bank
    -----------------------------
    IF OBJECT_ID('U_ECITAQNACH_Bank','U') IS NOT NULL
        DROP TABLE dbo.U_ECITAQNACH_Bank;
    SELECT DISTINCT BnkCoBankID
        ,BnkBankName
        ,BnkAchBankRoutingNo
        ,BnkDDRecord1Pos14To23
        ,BnkDDRecord5Pos05To20
        ,BnkDDRecord5Pos21To40
        ,BnkDDRecord5Pos41To50
        ,BnkDDRecord5Pos80To87
        ,BnkDDRecord6Pos80To87
        ,BnkDDRecord8Pos45To54
        ,BnkDDRecord8Pos80To87
    INTO dbo.U_ECITAQNACH_Bank
    FROM dbo.Bank WITH (NOLOCK)
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrBankId = BnkCoBankID;

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECITAQNACH_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECITAQNACH_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCoID
        ,PrgCoBankID
        ,EepNameFirst
        ,EepNameLast
        ,EepSSN
        ,EecEmpNo
        ,EecUDField03
        ,EecUDField04
        ,EddEEBankRoute
        ,EddAcct
        ,PdhEECurAmt = SUM(CASE WHEN PdhDedCode IN ('HSAEE') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt = SUM(CASE WHEN PdhDedCode IN ('HSAER') THEN PdhEECurAmt ELSE 0.00 END)
        ,RecordType = CASE WHEN PdhDedCode IN ('HSAEE') THEN 'EE'
                           WHEN PdhDedCode IN ('HSAER') THEN 'ER'
                      END
        ,PrhAcctType = PrhAccttype
    INTO dbo.U_ECITAQNACH_PDedHist
    FROM dbo.U_ECITAQNACH_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
        AND PrgCoID = xCoID
        AND PrgPerControl BETWEEN @StartPerControl AND @EndPerControl
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = PrgEEID
        AND PdhCoID = PrgCoID
        AND PdhGenNumber = PrgGenNumber
        AND PdhDedCode IN ('HSAEE','HSAER')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCOID
    JOIN dbo.PDirHist WITH (NOLOCK)
        ON PrhEeId = xEEID
        AND PrhCoId = xCOID
        AND PrhGenNumber = PrgGenNumber
    JOIN dbo.empdirdp WITH(NOLOCK) 
        ON EddEEID = xEEID
        AND EddCOID = xCOID
--    WHERE ISNULL(EecUDField03,'') <> '' AND ISNULL(EecUDField04,'') <> ''
    GROUP BY PdhEEID, PdhCoID, PrgCoBankID, EepNameFirst, EepNameLast, EepSSN, EecEmpNo, EecUDField03, EecUDField04, EddEEBankRoute, EddAcct, PrhAcctType
        ,CASE WHEN PdhDedCode IN ('HSAEE') THEN 'EE'
              WHEN PdhDedCode IN ('HSAER') THEN 'ER'
         END
    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00);

    ----------------------------------
    -- File Header Record ? Type 1
    ----------------------------------
    IF OBJECT_ID('U_ECITAQNACH_H1','U') IS NOT NULL
        DROP TABLE dbo.U_ECITAQNACH_H1;
    SELECT DISTINCT
        drvImmediateDestination = SPACE(1) + '122016066' --BnkAchBankRoutingNo
        ,drvImmediateOriginCode = BnkDDRecord1Pos14To23
        ,drvFileCreationDate = CONVERT(CHAR(6),@RunDate,12)
        ,drvFileCreationTime = REPLACE(CONVERT(VARCHAR(6),@RunDate,108),':',SPACE(0))
        ,drvImmediateDestinationName = 'CITY NATIONAL BANK' --BnkBankName
        ,drvImmediateOriginName = BnkDDRecord5Pos05To20
    INTO dbo.U_ECITAQNACH_H1
    FROM dbo.U_ECITAQNACH_Bank WITH (NOLOCK);

    -------------------------------------------
    -- Company/Batch Header Record  - Type 5
    -------------------------------------------
    IF OBJECT_ID('U_ECITAQNACH_D5','U') IS NOT NULL
        DROP TABLE dbo.U_ECITAQNACH_D5;
    SELECT DISTINCT
        drvCompanyName = BnkDDRecord5Pos05To20
        ,drvCompanyDiscretionaryData = BnkDDRecord5Pos21To40
        ,drvCompanyIdentification = '5433018877'
		--BnkDDRecord5Pos41To50
        ,drvCompanyDescriptiveDate = CONVERT(CHAR(6),@RunDate,12)
        ,drvEffectiveEntryDate = CONVERT(CHAR(6),@PrgPayDate,12)
        ,drvOriginatingDFIIdentifictin = '12201606' --BnkDDRecord5Pos80To87
        ,drvInitialSort = '1'
    INTO dbo.U_ECITAQNACH_D5
    FROM dbo.U_ECITAQNACH_PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECITAQNACH_Bank WITH (NOLOCK)
        ON BnkCoBankID = PrgCoBankID;

    ----------------------------------
    -- Entry Detail Record - Type 6
    ----------------------------------
    IF OBJECT_ID('U_ECITAQNACH_D6','U') IS NOT NULL
        DROP TABLE dbo.U_ECITAQNACH_D6;
    SELECT DISTINCT
         drvTransactionCode = CASE --22 DDA credit | 23 DDA Prenote credit | 27 DDA debit | 28 DDA Prenote debit | 32 SAV credit | 33 SAV Prenote credit | 37 SAV debit | 38 SAV Prenote debit
                                  WHEN PrhAccttype = 'C' THEN
                                    CASE WHEN (PdhEECurAmt + PdhERCurAmt) > 0.00 THEN '22' --22 DDA credit
                                         WHEN (PdhEECurAmt + PdhERCurAmt) < 0.00 THEN '27' --28 DDA Prenote debit
                                    END
                                  WHEN PrhAccttype = 'S' THEN
                                    CASE WHEN (PdhEECurAmt + PdhERCurAmt) > 0.00 THEN '32' --32 SAV credit
                                         WHEN (PdhEECurAmt + PdhERCurAmt) < 0.00 THEN '37' --38 SAV Prenote debit
                                    END
                               END
        ,drvReceivingDFIIdentification = LEFT(EddEEBankRoute,8)
        ,drvCheckDigit = SUBSTRING(EddEEBankRoute,9,1)
        ,drvDFIAccountNumber = EddAcct
        ,drvAmount = CONVERT(DECIMAL(10,0),
                     CASE WHEN RecordType = 'EE' THEN ISNULL(PdhEECurAmt,0.00) * 100
                          WHEN RecordType = 'ER' THEN ISNULL(PdhERCurAmt,0.00) * 100
                     END)
        ,drvIdentificationNumber = EepSSN
        ,drvReceivingCompanyName = RTRIM(EepNameLast) + SPACE(1) + EepNameFirst
        ,drvDiscretionaryData = RecordType
        ,drvTraceNumber = BnkDDRecord6Pos80To87 + dbo.dsi_fnPadZero(ROW_NUMBER() OVER (ORDER BY RTRIM(EecEmpNo), RecordType),7,0)
        ,drvUDField03 = EecUDField03
        ,drvInitialSort = '2' + RTRIM(EecEmpNo) + RecordType
    INTO dbo.U_ECITAQNACH_D6
    FROM dbo.U_ECITAQNACH_Bank WITH (NOLOCK)
    JOIN dbo.U_ECITAQNACH_PDedHist WITH (NOLOCK)
        ON BnkCoBankID = PrgCoBankID
    --JOIN dbo.empdirdp WITH(NOLOCK) 
    --    ON EddEEID = PdhEEID
    --    AND EddCOID = PdhCOID
    ;

    -------------------------------------------------
    -- Entry Detail Record - Type 6 (Batch Offset)
    -------------------------------------------------
 --   INSERT INTO dbo.U_ECITAQNACH_D6 (drvTransactionCode,drvReceivingDFIIdentification,drvCheckDigit,drvDFIAccountNumber,drvAmount,drvIdentificationNumber
 --       ,drvReceivingCompanyName,drvTraceNumber/*,drvUDField03*/,drvInitialSort)
 --   SELECT DISTINCT
 --        drvTransactionCode = '27' --27 DDA debit
 --       ,drvReceivingDFIIdentification = LEFT(EddEEBankRoute,8)
 --       ,drvCheckDigit = SUBSTRING(EddEEBankRoute,9,1)
 --       ,drvDFIAccountNumber = EddAcct
 --       ,drvAmount = SUM(CONVERT(DECIMAL(10,0),
 --                    CASE WHEN RecordType = 'EE' THEN ISNULL(PdhEECurAmt,0.00) * 100
 --                         WHEN RecordType = 'ER' THEN ISNULL(PdhERCurAmt,0.00) * 100
 --                    END))
 --       ,drvIdentificationNumber = 'BATCH OFFSET'
 --       ,drvReceivingCompanyName = 'OFFSET'
 --       ,drvTraceNumber = BnkDDRecord6Pos80To87
 --                       + dbo.dsi_fnPadZero((SELECT MAX(drvTraceNumber) FROM dbo.U_ECITAQNACH_D6) + 1,7,0)
 --       ,drvInitialSort = '2' + 'ZZZZZZZZZ'
 --  -- INTO dbo.U_ECITAQNACH_D6
 --   FROM dbo.U_ECITAQNACH_Bank WITH (NOLOCK)
 --   JOIN dbo.U_ECITAQNACH_PDedHist WITH (NOLOCK)
 --       ON BnkCoBankID = PrgCoBankID
    ----JOIN dbo.empdirdp WITH(NOLOCK) 
    ----    ON EddEEID = PdhEEID
    ----    AND EddCOID = PdhCOID 
 --   WHERE @IncludeOffset = 'Y';

    --------------------------------------------
    -- Company/Batch Control Record - Type 8
    --------------------------------------------
    IF OBJECT_ID('U_ECITAQNACH_D8','U') IS NOT NULL
        DROP TABLE dbo.U_ECITAQNACH_D8;
    SELECT DISTINCT
        drvEntryAddendaCount = CONVERT(DECIMAL(10,0),ISNULL((SELECT COUNT(*) FROM dbo.U_ECITAQNACH_D6 WITH (NOLOCK)),0))
        ,drvEntryHash = (SELECT SUM(CONVERT(DECIMAL(10,0),drvReceivingDFIIdentification)) FROM dbo.U_ECITAQNACH_D6 WITH (NOLOCK))
        ,drvTotalDebitEntryDollarAmt = CONVERT(DECIMAL(10,0),0)
        ,drvTotalCreditEntryDollarAmt = SUM(CONVERT(DECIMAL(10,0),(ISNULL(PdhEECurAmt * 100,0.00) + ISNULL(PdhERCurAmt * 100,0.00))))
        ,drvCompanyIdentification = '5433018877'
		--BnkDDRecord8Pos45To54
        ,drvOriginatingDFIIdentifictin = BnkDDRecord8Pos80To87
        ,drvInitialSort = '3'
    INTO dbo.U_ECITAQNACH_D8
    FROM dbo.U_ECITAQNACH_PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECITAQNACH_Bank WITH (NOLOCK)
        ON BnkCoBankID = PrgCoBankID
    GROUP BY BnkDDRecord8Pos45To54, BnkDDRecord8Pos80To87;

    ------------------------------------
    -- File Control Record - Record 9
    ------------------------------------
    IF OBJECT_ID('U_ECITAQNACH_T9','U') IS NOT NULL
        DROP TABLE dbo.U_ECITAQNACH_T9;
    SELECT DISTINCT
        drvBlockCount = (SELECT COUNT(*) FROM dbo.U_ECITAQNACH_D5) + (SELECT COUNT(*) FROM dbo.U_ECITAQNACH_D6) + (SELECT COUNT(*) FROM dbo.U_ECITAQNACH_D8) + 2
        ,drvEntryAddendaCount = SUM(CONVERT(DECIMAL(10,0),drvEntryAddendaCount))
        ,drvEntryHash = SUM(CONVERT(DECIMAL(10,0),drvEntryHash))
        ,drvTotalDebitEntryDollarAmt = CONVERT(DECIMAL(10,0),0)
        ,drvTotalCreditEntryDollarAmt = SUM(CONVERT(DECIMAL(10,0),drvTotalCreditEntryDollarAmt))
        ,drvBlockCountNines = (SELECT COUNT(*) FROM dbo.U_ECITAQNACH_D5) + (SELECT COUNT(*) FROM dbo.U_ECITAQNACH_D6) + (SELECT COUNT(*) FROM dbo.U_ECITAQNACH_D8) + 2
    INTO dbo.U_ECITAQNACH_T9
    FROM dbo.U_ECITAQNACH_D8 WITH (NOLOCK);

    ------------------------------------
    -- Update Block Count
    ------------------------------------
    UPDATE dbo.U_ECITAQNACH_T9
        SET drvBlockCount = CASE WHEN drvBlockCount % 10 = 0 THEN drvBlockCount/10
                                 ELSE drvBlockCount/10 + 1
                            END;

    ---------------------------------------
    -- Create 9 Records to Complete File
    --------------------------------------
    DECLARE @Nines INT
    SET @Nines = (10 - (SELECT CASE WHEN (drvBlockCountNines % 10) = 0 THEN 10 ELSE (drvBlockCountNines % 10) END FROM dbo.U_ECITAQNACH_T9));

    IF object_id('U_ECITAQNACH_Nines','U') IS NOT NULL
        DROP TABLE dbo.U_ECITAQNACH_Nines
    CREATE TABLE dbo.U_ECITAQNACH_Nines (
        drvNines VARCHAR(94)
    );

    WHILE @Nines > 0
    BEGIN
        INSERT INTO dbo.U_ECITAQNACH_Nines (drvNines) VALUES ('9');
        SET @Nines -= 1;
        PRINT @Nines;
    END;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('ECITAQNACH','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'ECITAQNACH_' + CONVERT(CHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'ECITAQNACH';
    END;

END
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECITAQNACH_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECITAQNACH_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID IN (SELECT AdhSystemID FROM dbo.AscDefH WHERE AdhFormatCode = 'ECITAQNACH')
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201810011'
       ,ExpStartPerControl     = '201810011'
       ,ExpLastEndPerControl   = '201810019'
       ,ExpEndPerControl       = '201810019'
WHERE ExpFormatCode = 'ECITAQNACH';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECITAQNACH_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECITAQNACH_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;