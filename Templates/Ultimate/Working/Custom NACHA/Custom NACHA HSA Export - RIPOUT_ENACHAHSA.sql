/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "@DeveloperName" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

-- Integration parameters
@CustomerName - Replace with customer name
@DeveloperName - Replace with TC name
@IntegrationAnalystName - Replace with BA/IC name
@CreateDate - Replace with date of creation
@SRNumber - Replace with SR number
@CustomFormatCode - Replace with Format Code (i.e., ENACHAHSA)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Custom NACHA HSA Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Client Specific parameters
@ReceivingDFIId - Replace with the Receiving DFI Identification (i.e., EecUDField04)
@DFIAccountNumber - Replace with the DFI Account Number (i.e., EecUDField03)

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\NACHA\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\NACHA\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_Trailer2') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Trailer2];
GO
IF OBJECT_ID('U_@CustomFormatCode_Trailer1') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Trailer1];
GO
IF OBJECT_ID('U_@CustomFormatCode_T9') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_T9];
GO
IF OBJECT_ID('U_@CustomFormatCode_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PDedHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_Nines') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Nines];
GO
IF OBJECT_ID('U_@CustomFormatCode_Header2') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Header2];
GO
IF OBJECT_ID('U_@CustomFormatCode_Header1') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Header1];
GO
IF OBJECT_ID('U_@CustomFormatCode_H1') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_H1];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl1') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl1];
GO
IF OBJECT_ID('U_@CustomFormatCode_D8') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_D8];
GO
IF OBJECT_ID('U_@CustomFormatCode_D6') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_D6];
GO
IF OBJECT_ID('U_@CustomFormatCode_D5') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_D5];
GO
IF OBJECT_ID('U_@CustomFormatCode_Bank') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Bank];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) SELECT 'N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','SDF','@CustomFormatCode',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','94','N','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"1"','1','(''DA''=''F'')',@AdhSystemID,'1','H','01','1',NULL,'Record Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"01"','2','(''DA''=''F'')',@AdhSystemID,'2','H','01','2',NULL,'Priority Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvImmediateDestination"','3','(''UA''=''F'')',@AdhSystemID,'10','H','01','4',NULL,'Immediate Destination',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvImmediateOriginCode"','4','(''UA''=''F'')',@AdhSystemID,'10','H','01','14',NULL,'Immediate Origin Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFileCreationDate"','5','(''UA''=''F'')',@AdhSystemID,'6','H','01','24',NULL,'File Creation Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFileCreationTime"','6','(''UA''=''F'')',@AdhSystemID,'4','H','01','30',NULL,'File Creation Time',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"H"','7','(''DA''=''F'')',@AdhSystemID,'1','H','01','34',NULL,'File ID Modifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"094"','8','(''DA''=''F'')',@AdhSystemID,'3','H','01','35',NULL,'Record Size',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"10"','9','(''DA''=''F'')',@AdhSystemID,'2','H','01','38',NULL,'Blocking Factor',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"1"','10','(''DA''=''F'')',@AdhSystemID,'1','H','01','40',NULL,'Format Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvImmediateDestinationName"','11','(''UA''=''F'')',@AdhSystemID,'23','H','01','41',NULL,'Immediate Destination Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvImmediateOriginName"','12','(''UA''=''F'')',@AdhSystemID,'23','H','01','64',NULL,'Immediate Origin Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'8','H','01','87',NULL,'Referrence Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"5"','1','(''DA''=''F'')',@AdhSystemID,'1','D','10','1',NULL,'Record Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"220"','2','(''DA''=''F'')',@AdhSystemID,'3','D','10','2',NULL,'Service Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCompanyName"','3','(''UA''=''F'')',@AdhSystemID,'16','D','10','5',NULL,'Company Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCompanyDiscretionaryData"','4','(''UA''=''F'')',@AdhSystemID,'20','D','10','21',NULL,'Company Discretionary Data',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCompanyIdentification"','5','(''UA''=''F'')',@AdhSystemID,'10','D','10','41',NULL,'Company Identification',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PPD"','6','(''DA''=''F'')',@AdhSystemID,'3','D','10','51',NULL,'Standard Entry Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"HSA"','7','(''DA''=''F'')',@AdhSystemID,'10','D','10','54',NULL,'Company Entry Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCompanyDescriptiveDate"','8','(''UA''=''F'')',@AdhSystemID,'6','D','10','64',NULL,'Company Descriptive Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEffectiveEntryDate"','9','(''UA''=''F'')',@AdhSystemID,'6','D','10','70',NULL,'Effective Entry Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'3','D','10','76',NULL,'Settlement Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"1"','11','(''DA''=''F'')',@AdhSystemID,'1','D','10','79',NULL,'Originator Status code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOriginatingDFIIdentifictin"','12','(''UA''=''F'')',@AdhSystemID,'8','D','10','80',NULL,'Originating DFI Identificaiton',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"0000001"','13','(''DA''=''F'')',@AdhSystemID,'7','D','10','88',NULL,'Batch Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"6"','1','(''DA''=''F'')',@AdhSystemID,'1','D','20','1',NULL,'Record Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTransactionCode"','2','(''UA''=''F'')',@AdhSystemID,'2','D','20','2',NULL,'Transaction Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReceivingDFIIdentification"','3','(''UA''=''F'')',@AdhSystemID,'8','D','20','4',NULL,'Receiving DFI Identification',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCheckDigit"','4','(''UA''=''F'')',@AdhSystemID,'1','D','20','12',NULL,'Check Digit',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDFIAccountNumber"','5','(''UA''=''F'')',@AdhSystemID,'17','D','20','13',NULL,'DFI Account Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAmount"','6','(''UN0''=''F'')',@AdhSystemID,'10','D','20','30',NULL,'Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvIdentificationNumber"','7','(''UA''=''F'')',@AdhSystemID,'15','D','20','40',NULL,'Identification Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReceivingCompanyName"','8','(''UA''=''F'')',@AdhSystemID,'22','D','20','55',NULL,'Receiving Company Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDiscretionaryData"','9','(''UA''=''F'')',@AdhSystemID,'2','D','20','77',NULL,'Discretionary Data',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"0"','10','(''DA''=''F'')',@AdhSystemID,'1','D','20','79',NULL,'Addenda Record Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTraceNumber"','11','(''UA''=''F'')',@AdhSystemID,'15','D','20','80',NULL,'Trace Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"8"','1','(''UA''=''F'')',@AdhSystemID,'1','D','30','1',NULL,'Record Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"220"','2','(''UA''=''F'')',@AdhSystemID,'3','D','30','2',NULL,'Service Class Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEntryAddendaCount"','3','(''UN0''=''F'')',@AdhSystemID,'6','D','30','5',NULL,'Entry / Addenda Count',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEntryHash"','4','(''UN0''=''F'')',@AdhSystemID,'10','D','30','11',NULL,'Entry Hash',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTotalDebitEntryDollarAmt"','5','(''UN0''=''F'')',@AdhSystemID,'12','D','30','21',NULL,'Total Debit Entry Dollar Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTotalCreditEntryDollarAmt"','6','(''UN0''=''F'')',@AdhSystemID,'12','D','30','33',NULL,'Total Credit Entry Dollar Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCompanyIdentification"','7','(''UA''=''F'')',@AdhSystemID,'10','D','30','45',NULL,'Company Identification',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'19','D','30','55',NULL,'Message Authentication Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'6','D','30','74',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOriginatingDFIIdentifictin"','10','(''UA''=''F'')',@AdhSystemID,'8','D','30','80',NULL,'Originating DFI Identification',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"0000001"','11','(''DA''=''F'')',@AdhSystemID,'7','D','30','88',NULL,'Batch Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"9"','1','(''DA''=''F'')',@AdhSystemID,'1','T','90','1',NULL,'Record Type Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"000001"','2','(''DA''=''F'')',@AdhSystemID,'6','T','90','2',NULL,'Batch Count',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBlockCount"','3','(''UN0''=''F'')',@AdhSystemID,'6','T','90','8',NULL,'Block Count',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEntryAddendaCount"','4','(''UN0''=''F'')',@AdhSystemID,'8','T','90','14',NULL,'Entry / Addenda Count',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEntryHash"','5','(''UN0''=''F'')',@AdhSystemID,'10','T','90','22',NULL,'Entry Hash',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTotalDebitEntryDollarAmt"','6','(''UN0''=''F'')',@AdhSystemID,'12','T','90','32',NULL,'Total Debit Entry Dollar Amount in File',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTotalCreditEntryDollarAmt"','7','(''UN0''=''F'')',@AdhSystemID,'12','T','90','44',NULL,'Total Credit Entry Dollar Amount in File',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'39','T','90','56',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"9"','1','(''DR''=''F'')',@AdhSystemID,'94','T','91','1',NULL,'Nine Records for Block Count',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,'Custom NACHA HSA Export','201707019','EMPEXPORT','ONDEMAND','Jul 01 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201707019','Jul 01 2017 12:00AM','Dec 30 1899 12:00AM','201707011',NULL,'','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,'Testing Purposes Only','201707019','EMPEXPORT','TEST','Jul 01 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201707019','Jul 01 2017 12:00AM','Dec 30 1899 12:00AM','201707011',NULL,'','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H01','dbo.U_@CustomFormatCode_H1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_D5',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_D6',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','dbo.U_@CustomFormatCode_D8',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T90','dbo.U_@CustomFormatCode_T9',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T91','dbo.U_@CustomFormatCode_Nines',NULL);
GO
IF ('@IsWebFlag' = 'Y')
BEGIN
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = '@CustomFormatCode' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = '@CustomFormatCode.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
UPDATE dbo.AscExp SET expAscFileName = @FILEPATH + @FILENAME WHERE expFormatCode = '@CustomFormatCode';

/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'ExportPath' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
/*03*/ DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'TestPath'; /* Remove Test Path for Web Exports */

END
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_@CustomFormatCode_File') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] char(94) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: @CustomFormatName

Revision History
----------------
Update By            Date            Request Num                Desc
XXXX                 XX/XX/XX        SR-20XX-000XXXXX           Added 1234

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut '@CustomFormatCode', 'Y'
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
    WHERE FormatCode = '@CustomFormatCode';

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
    IF OBJECT_ID('U_@CustomFormatCode_Bank','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Bank;
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
    INTO dbo.U_@CustomFormatCode_Bank
    FROM dbo.Bank WITH (NOLOCK)
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrBankId = BnkCoBankID;

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_@CustomFormatCode_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCoID
        ,PrgCoBankID
        ,EepNameFirst
        ,EepNameLast
        ,EecEmpNo
        ,EecUDField03
        ,EecUDField04
        ,PdhEECurAmt = SUM(CASE WHEN PdhDedCode IN ('HSAEE') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt = SUM(CASE WHEN PdhDedCode IN ('HSAER') THEN PdhEECurAmt ELSE 0.00 END)
        ,RecordType = CASE WHEN PdhDedCode IN ('HSAEE') THEN 'EE'
                           WHEN PdhDedCode IN ('HSAER') THEN 'ER'
                      END
        ,PrhAcctType = PrhAccttype
    INTO dbo.U_@CustomFormatCode_PDedHist
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
        AND PrgCoID = xCoID
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhGenNumber = PrgGenNumber
        AND PdhDedCode IN ('HSAEE','HSAER')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCOID
    JOIN dbo.PDirHist WITH (NOLOCK)
        ON PrhGenNumber = PrgGenNumber
    WHERE PrgPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND ISNULL(EecUDField03,'') <> '' AND ISNULL(EecUDField04,'') <> ''
    GROUP BY PdhEEID, PdhCoID, PrgCoBankID, EepNameFirst, EepNameLast, EecEmpNo, EecUDField03, EecUDField04, PrhAcctType
        ,CASE WHEN PdhDedCode IN ('HSAEE') THEN 'EE'
              WHEN PdhDedCode IN ('HSAER') THEN 'ER'
         END
    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00);

    ----------------------------------
    -- File Header Record — Type 1
    ----------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_H1','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_H1;
    SELECT DISTINCT
        drvImmediateDestination = SPACE(1) + BnkAchBankRoutingNo
        ,drvImmediateOriginCode = BnkDDRecord1Pos14To23
        ,drvFileCreationDate = CONVERT(CHAR(6),@RunDate,12)
        ,drvFileCreationTime = REPLACE(CONVERT(VARCHAR(6),@RunDate,108),':',SPACE(0))
        ,drvImmediateDestinationName = BnkBankName
        ,drvImmediateOriginName = BnkDDRecord5Pos05To20
    INTO dbo.U_@CustomFormatCode_H1
    FROM dbo.U_@CustomFormatCode_Bank WITH (NOLOCK);

    -------------------------------------------
    -- Company/Batch Header Record  - Type 5
    -------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_D5','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_D5;
    SELECT DISTINCT
        drvCompanyName = BnkDDRecord5Pos05To20
        ,drvCompanyDiscretionaryData = BnkDDRecord5Pos21To40
        ,drvCompanyIdentification = BnkDDRecord5Pos41To50
        ,drvCompanyDescriptiveDate = CONVERT(CHAR(6),@RunDate,12)
        ,drvEffectiveEntryDate = CONVERT(CHAR(6),@PrgPayDate,12)
        ,drvOriginatingDFIIdentifictin = BnkDDRecord5Pos80To87
        ,drvInitialSort = '1'
    INTO dbo.U_@CustomFormatCode_D5
    FROM dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
    JOIN dbo.U_@CustomFormatCode_Bank WITH (NOLOCK)
        ON BnkCoBankID = PrgCoBankID;

    ----------------------------------
    -- Entry Detail Record - Type 6
    ----------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_D6','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_D6;
    SELECT DISTINCT
         drvTransactionCode = CASE --22 DDA credit | 23 DDA Prenote credit | 27 DDA debit | 28 DDA Prenote debit | 32 SAV credit | 33 SAV Prenote credit | 37 SAV debit | 38 SAV Prenote debit
                                  WHEN PrhAccttype = 'C' THEN
                                    CASE WHEN (PdhEECurAmt + PdhERCurAmt) > 0.00 THEN '22' --22 DDA credit
                                         WHEN (PdhEECurAmt + PdhERCurAmt) < 0.00 THEN '28' --28 DDA Prenote debit
                                    END
                                  WHEN PrhAccttype = 'S' THEN
                                    CASE WHEN (PdhEECurAmt + PdhERCurAmt) > 0.00 THEN '32' --32 SAV credit
                                         WHEN (PdhEECurAmt + PdhERCurAmt) < 0.00 THEN '38' --38 SAV Prenote debit
                                    END
                               END
        ,drvReceivingDFIIdentification = LEFT(@ReceivingDFIId,8)
        ,drvCheckDigit = SUBSTRING(@ReceivingDFIId,9,1)
        ,drvDFIAccountNumber = @DFIAccountNumber
        ,drvAmount = CONVERT(DECIMAL(10,0),
                     CASE WHEN RecordType = 'EE' THEN ISNULL(PdhEECurAmt,0.00) * 100
                          WHEN RecordType = 'ER' THEN ISNULL(PdhERCurAmt,0.00) * 100
                     END)
        ,drvIdentificationNumber = EecEmpNo
        ,drvReceivingCompanyName = RTRIM(EepNameLast) + SPACE(1) + EepNameFirst
        ,drvDiscretionaryData = RecordType
        ,drvTraceNumber = BnkDDRecord6Pos80To87 + dbo.dsi_fnPadZero(ROW_NUMBER() OVER (ORDER BY RTRIM(EecEmpNo), RecordType),7,0)
        ,drvUDField03 = EecUDField03
        ,drvInitialSort = '2' + RTRIM(EecEmpNo) + RecordType
    INTO dbo.U_@CustomFormatCode_D6
    FROM dbo.U_@CustomFormatCode_Bank WITH (NOLOCK)
    JOIN dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
        ON BnkCoBankID = PrgCoBankID;

    -------------------------------------------------
    -- Entry Detail Record - Type 6 (Batch Offset)
    -------------------------------------------------
    INSERT INTO dbo.U_@CustomFormatCode_D6 (drvTransactionCode,drvReceivingDFIIdentification,drvCheckDigit,drvDFIAccountNumber,drvAmount,drvIdentificationNumber
        ,drvReceivingCompanyName,drvTraceNumber,drvUDField03,drvInitialSort)
    SELECT DISTINCT
         drvTransactionCode = '27' --27 DDA debit
        ,drvReceivingDFIIdentification = LEFT(@ReceivingDFIId,8)
        ,drvCheckDigit = SUBSTRING(@ReceivingDFIId,9,1)
        ,drvDFIAccountNumber = @DFIAccountNumber
        ,drvAmount = SUM(CONVERT(DECIMAL(10,0),
                     CASE WHEN RecordType = 'EE' THEN ISNULL(PdhEECurAmt,0.00) * 100
                          WHEN RecordType = 'ER' THEN ISNULL(PdhERCurAmt,0.00) * 100
                     END))
        ,drvIdentificationNumber = 'BATCH OFFSET'
        ,drvReceivingCompanyName = 'OFFSET'
        ,drvTraceNumber = BnkDDRecord6Pos80To87
                        + dbo.dsi_fnPadZero((SELECT MAX(drvTraceNumber) FROM dbo.U_@CustomFormatCode_D6) + 1,7,0)
        ,drvInitialSort = '2' + 'ZZZZZZZZZ'
    INTO dbo.U_@CustomFormatCode_D6
    FROM dbo.U_@CustomFormatCode_Bank WITH (NOLOCK)
    JOIN dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
        ON BnkCoBankID = PrgCoBankID
    WHERE @IncludeOffset = 'Y';

    --------------------------------------------
    -- Company/Batch Control Record - Type 8
    --------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_D8','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_D8;
    SELECT DISTINCT
        drvEntryAddendaCount = CONVERT(DECIMAL(10,0),ISNULL((SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_D6 WITH (NOLOCK)),0))
        ,drvEntryHash = (SELECT SUM(CONVERT(DECIMAL(10,0),drvReceivingDFIIdentification)) FROM dbo.U_@CustomFormatCode_D6 WITH (NOLOCK))
        ,drvTotalDebitEntryDollarAmt = CONVERT(DECIMAL(10,0),0)
        ,drvTotalCreditEntryDollarAmt = SUM(CONVERT(DECIMAL(10,0),(ISNULL(PdhEECurAmt * 100,0.00) + ISNULL(PdhERCurAmt * 100,0.00))))
        ,drvCompanyIdentification = BnkDDRecord8Pos45To54
        ,drvOriginatingDFIIdentifictin = BnkDDRecord8Pos80To87
        ,drvInitialSort = '3'
    INTO dbo.U_@CustomFormatCode_D8
    FROM dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
    JOIN dbo.U_@CustomFormatCode_Bank WITH (NOLOCK)
        ON BnkCoBankID = PrgCoBankID
    GROUP BY BnkDDRecord8Pos45To54, BnkDDRecord8Pos80To87;

    ------------------------------------
    -- File Control Record - Record 9
    ------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_T9','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_T9;
    SELECT DISTINCT
        drvBlockCount = (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_D5) + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_D6) + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_D8) + 2
        ,drvEntryAddendaCount = SUM(CONVERT(DECIMAL(10,0),drvEntryAddendaCount))
        ,drvEntryHash = SUM(CONVERT(DECIMAL(10,0),drvEntryHash))
        ,drvTotalDebitEntryDollarAmt = CONVERT(DECIMAL(10,0),0)
        ,drvTotalCreditEntryDollarAmt = SUM(CONVERT(DECIMAL(10,0),drvTotalCreditEntryDollarAmt))
        ,drvBlockCountNines = (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_D5) + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_D6) + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_D8) + 2
    INTO dbo.U_@CustomFormatCode_T9
    FROM dbo.U_@CustomFormatCode_D8 WITH (NOLOCK);

    ------------------------------------
    -- Update Block Count
    ------------------------------------
    UPDATE dbo.U_@CustomFormatCode_T9
        SET drvBlockCount = CASE WHEN drvBlockCount % 10 = 0 THEN drvBlockCount/10
                                 ELSE drvBlockCount/10 + 1
                            END;

    ---------------------------------------
    -- Create 9 Records to Complete File
    --------------------------------------
    DECLARE @Nines INT
    SET @Nines = (10 - (SELECT CASE WHEN (drvBlockCountNines % 10) = 0 THEN 10 ELSE (drvBlockCountNines % 10) END FROM dbo.U_@CustomFormatCode_T9));

    IF object_id('U_@CustomFormatCode_Nines','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Nines
    CREATE TABLE dbo.U_@CustomFormatCode_Nines (
        drvNines VARCHAR(94)
    );

    WHILE @Nines > 0
    BEGIN
        INSERT INTO dbo.U_@CustomFormatCode_Nines (drvNines) VALUES ('9');
        SET @Nines -= 1;
        PRINT @Nines;
    END;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = '@CustomFormatCode_' + CONVERT(CHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = '@CustomFormatCode';
    END;

END
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID IN (SELECT AdhSystemID FROM dbo.AscDefH WHERE AdhFormatCode = '@CustomFormatCode')
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201810011'
       ,ExpStartPerControl     = '201810011'
       ,ExpLastEndPerControl   = '201810019'
       ,ExpEndPerControl       = '201810019'
WHERE ExpFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;