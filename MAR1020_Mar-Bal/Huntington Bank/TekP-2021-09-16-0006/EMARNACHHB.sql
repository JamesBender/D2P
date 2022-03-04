/**********************************************************************************

EMARNACHHB: Huntington Bank NACHA

FormatCode:     EMARNACHHB
Project:        Huntington Bank NACHA
Client ID:      MAR1020
Date/time:      2022-03-03 11:53:31.670
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW1WUP4DB02
Database:       ULTIPRO_WPMARBA
Web Filename:   MAR1020_4C0B1_EEHISTORY_EMARNACHHB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMARNACHHB_SavePath') IS NOT NULL DROP TABLE dbo.U_EMARNACHHB_SavePath


-----------
-- Create U_dsi_RipoutParms if it doesn't exist
-----------

IF OBJECT_ID('U_dsi_RipoutParms') IS NULL BEGIN

   CREATE TABLE dbo.U_dsi_RipoutParms (
   rpoFormatCode  VARCHAR(10)   NOT NULL,
   rpoParmType    VARCHAR(64)   NOT NULL,
   rpoParmValue01 VARCHAR(1024) NULL,
   rpoParmValue02 VARCHAR(1024) NULL,
   rpoParmValue03 VARCHAR(1024) NULL,
   rpoParmValue04 VARCHAR(1024) NULL,
   rpoParmValue05 VARCHAR(1024) NULL
)
END


-----------
-- Clear U_dsi_RipoutParms
-----------

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMARNACHHB'


-----------
-- Add paths to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02)
SELECT

FormatCode,
'Path',
CfgName,
CfgValue

FROM dbo.U_Dsi_Configuration
WHERE FormatCode = 'EMARNACHHB'
AND CfgName LIKE '%path%'


-----------
-- Add AscExp expSystemIDs to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02) 
SELECT

ExpFormatCode,
'expSystemID',
ExpExportCode,
ExpSystemID

FROM dbo.AscExp
WHERE ExpFormatCode = 'EMARNACHHB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMARNACHHB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMARNACHHB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMARNACHHB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMARNACHHB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMARNACHHB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMARNACHHB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMARNACHHB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMARNACHHB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMARNACHHB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMARNACHHB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMARNACHHB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMARNACHHB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMARNACHHB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMARNACHHB];
GO
IF OBJECT_ID('U_EMARNACHHB_T9') IS NOT NULL DROP TABLE [dbo].[U_EMARNACHHB_T9];
GO
IF OBJECT_ID('U_EMARNACHHB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMARNACHHB_SavePath];
GO
IF OBJECT_ID('U_EMARNACHHB_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMARNACHHB_PDedHist];
GO
IF OBJECT_ID('U_EMARNACHHB_Nines') IS NOT NULL DROP TABLE [dbo].[U_EMARNACHHB_Nines];
GO
IF OBJECT_ID('U_EMARNACHHB_H1') IS NOT NULL DROP TABLE [dbo].[U_EMARNACHHB_H1];
GO
IF OBJECT_ID('U_EMARNACHHB_File') IS NOT NULL DROP TABLE [dbo].[U_EMARNACHHB_File];
GO
IF OBJECT_ID('U_EMARNACHHB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMARNACHHB_EEList];
GO
IF OBJECT_ID('U_EMARNACHHB_D8') IS NOT NULL DROP TABLE [dbo].[U_EMARNACHHB_D8];
GO
IF OBJECT_ID('U_EMARNACHHB_D6') IS NOT NULL DROP TABLE [dbo].[U_EMARNACHHB_D6];
GO
IF OBJECT_ID('U_EMARNACHHB_D5') IS NOT NULL DROP TABLE [dbo].[U_EMARNACHHB_D5];
GO
IF OBJECT_ID('U_EMARNACHHB_Bank') IS NOT NULL DROP TABLE [dbo].[U_EMARNACHHB_Bank];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMARNACHHB','Huntington Bank NACHA','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','94','S','N','EMARNACHHBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMARNACHHBZ0','1','H','01','1',NULL,'Record Type Code',NULL,NULL,'"1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMARNACHHBZ0','2','H','01','2',NULL,'Priority Code',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMARNACHHBZ0','10','H','01','4',NULL,'Immediate Destination',NULL,NULL,'"drvImmediateDestination"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMARNACHHBZ0','10','H','01','14',NULL,'Immediate Origin Code',NULL,NULL,'"drvImmediateOriginCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMARNACHHBZ0','6','H','01','24',NULL,'File Creation Date',NULL,NULL,'"drvFileCreationDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMARNACHHBZ0','4','H','01','30',NULL,'File Creation Time',NULL,NULL,'"drvFileCreationTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMARNACHHBZ0','1','H','01','34',NULL,'File ID Modifier',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMARNACHHBZ0','3','H','01','35',NULL,'Record Size',NULL,NULL,'"094"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMARNACHHBZ0','2','H','01','38',NULL,'Blocking Factor',NULL,NULL,'"10"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMARNACHHBZ0','1','H','01','40',NULL,'Format Code',NULL,NULL,'"1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMARNACHHBZ0','23','H','01','41',NULL,'Immediate Destination Name',NULL,NULL,'"drvImmediateDestinationName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMARNACHHBZ0','23','H','01','64',NULL,'Immediate Origin Name',NULL,NULL,'"drvImmediateOriginName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMARNACHHBZ0','8','H','01','87',NULL,'Referrence Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMARNACHHBZ0','1','D','10','1',NULL,'Record Type Code',NULL,NULL,'"5"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMARNACHHBZ0','3','D','10','2',NULL,'Service Class Code',NULL,NULL,'"200"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMARNACHHBZ0','16','D','10','5',NULL,'Company Name',NULL,NULL,'"drvCompanyName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMARNACHHBZ0','20','D','10','21',NULL,'Company Discretionary Data',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMARNACHHBZ0','10','D','10','41',NULL,'Company Identification',NULL,NULL,'"drvCompanyIdentification"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMARNACHHBZ0','3','D','10','51',NULL,'Standard Entry Class Code',NULL,NULL,'"PPD"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMARNACHHBZ0','10','D','10','54',NULL,'Company Entry Description',NULL,NULL,'"PAYROLL"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMARNACHHBZ0','6','D','10','64',NULL,'Company Descriptive Date',NULL,NULL,'"drvCompDescDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMARNACHHBZ0','6','D','10','70',NULL,'Effective Entry Date',NULL,NULL,'"drvEffectiveEntryDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMARNACHHBZ0','3','D','10','76',NULL,'Settlement Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMARNACHHBZ0','1','D','10','79',NULL,'Originator Status code',NULL,NULL,'"1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMARNACHHBZ0','8','D','10','80',NULL,'Originating DFI Identificaiton',NULL,NULL,'"drvOriginatingDFIIdentifictin"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMARNACHHBZ0','7','D','10','88',NULL,'Batch Number',NULL,NULL,'"0000001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMARNACHHBZ0','1','D','20','1',NULL,'Record Type Code',NULL,NULL,'"6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMARNACHHBZ0','2','D','20','2',NULL,'Transaction Code',NULL,NULL,'"drvTransactionCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMARNACHHBZ0','9','D','20','4',NULL,'Receiving DFI Identification',NULL,NULL,'"drvReceivingDFIIdentification"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMARNACHHBZ0','17','D','20','13',NULL,'DFI Account Number',NULL,NULL,'"drvDFIAccountNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMARNACHHBZ0','10','D','20','30',NULL,'Amount',NULL,NULL,'"drvAmount"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMARNACHHBZ0','15','D','20','40',NULL,'Identification Number',NULL,NULL,'"drvIdentificationNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMARNACHHBZ0','22','D','20','55',NULL,'Receiving Company Name',NULL,NULL,'"drvReceivingCompanyName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMARNACHHBZ0','2','D','20','77',NULL,'Discretionary Data',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMARNACHHBZ0','1','D','20','49',NULL,'Addenda Record Indicator',NULL,NULL,'"0"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMARNACHHBZ0','15','D','20','80',NULL,'Trace Number',NULL,NULL,'"drvTraceNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMARNACHHBZ0','1','D','30','1',NULL,'Record Type Code',NULL,NULL,'"8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMARNACHHBZ0','3','D','30','2',NULL,'Service Class Code',NULL,NULL,'"200"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMARNACHHBZ0','6','D','30','5',NULL,'Entry / Addenda Count',NULL,NULL,'"drvEntryAddendaCount"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMARNACHHBZ0','10','D','30','11',NULL,'Entry Hash',NULL,NULL,'"drvEntryHash"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMARNACHHBZ0','12','D','30','21',NULL,'Total Debit Entry Dollar Amount',NULL,NULL,'"drvTotalDebitEntryDollarAmt"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMARNACHHBZ0','12','D','30','33',NULL,'Total Credit Entry Dollar Amount',NULL,NULL,'"drvTotalCreditEntryDollarAmt"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMARNACHHBZ0','10','D','30','45',NULL,'Company Identification',NULL,NULL,'"drvCompanyIdentification"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMARNACHHBZ0','19','D','30','55',NULL,'Message Authentication Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMARNACHHBZ0','6','D','30','74',NULL,'Reserved',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMARNACHHBZ0','8','D','30','80',NULL,'Originating DFI Identification',NULL,NULL,'"drvOriginatingDFIIdentifictin"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMARNACHHBZ0','7','D','30','88',NULL,'Batch Number',NULL,NULL,'"0000001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMARNACHHBZ0','1','T','90','1',NULL,'Record Type Code',NULL,NULL,'"9"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMARNACHHBZ0','6','T','90','2',NULL,'Batch Count',NULL,NULL,'"000001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMARNACHHBZ0','6','T','90','8',NULL,'Block Count',NULL,NULL,'"drvBlockCount"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMARNACHHBZ0','8','T','90','14',NULL,'Entry / Addenda Count',NULL,NULL,'"drvEntryAddendaCount"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMARNACHHBZ0','10','T','90','22',NULL,'Entry Hash',NULL,NULL,'"drvEntryHash"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMARNACHHBZ0','12','T','90','32',NULL,'Total Debit Entry Dollar Amount in File',NULL,NULL,'"drvTotalDebitEntryDollarAmt"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMARNACHHBZ0','12','T','90','44',NULL,'Total Credit Entry Dollar Amount in File',NULL,NULL,'"drvTotalCreditEntryDollarAmt"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMARNACHHBZ0','39','T','90','56',NULL,'Reserved',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMARNACHHBZ0','94','T','91','1',NULL,'Nine Records for Block Count',NULL,NULL,'"9"','(''DR''=''F'')');

-----------
-- Build web filename
-----------

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME, 2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME, 3) ELSE LEFT(@@SERVERNAME, 2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME, 2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME, 3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FileName varchar(1000) = 'EMARNACHHB_20220303.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','IAGFG',NULL,NULL,NULL,'Huntington Bank NACHA','202201211','EMPEXPORT','ONDEMAND','Jan 28 2022 12:00AM','EMARNACHHB',NULL,NULL,NULL,'202201211','Jan 21 2022 12:00AM','Jan 15 2022 12:00AM','202201211','220','eecPayGroup','CORPBW','202201211',dbo.fn_GetTimedKey(),NULL,'us3cPeMAR1020',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','IAGFG',NULL,NULL,NULL,'Huntington Bank NACHA Sched','202202049','EMPEXPORT','SCHEDULED','Feb  9 2022 12:00AM','EMARNACHHB',NULL,NULL,NULL,'202202049','Feb  4 2022 12:00AM','Dec 30 1899 12:00AM','202202041','9','eecPayGroup','CORPBW','202202041',dbo.fn_GetTimedKey(),NULL,'us3cPeMAR1020',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','IAGFG',NULL,NULL,NULL,'Huntington Bank NACHA TEST','202202181','EMPEXPORT','TEST','Feb 22 2022  6:44PM','EMARNACHHB',NULL,NULL,NULL,'202202181','Feb 18 2022 12:00AM','Feb 12 2022 12:00AM','202202181','140','eecPayGroup','CORPBW','202202181',dbo.fn_GetTimedKey(),NULL,'us3cPeMAR1020',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMARNACHHB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMARNACHHB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMARNACHHB','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMARNACHHB','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMARNACHHB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMARNACHHB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMARNACHHB','H01','dbo.U_EMARNACHHB_H1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMARNACHHB','D10','dbo.U_EMARNACHHB_D5',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMARNACHHB','D20','dbo.U_EMARNACHHB_D6',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMARNACHHB','D30','dbo.U_EMARNACHHB_D8',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMARNACHHB','T90','dbo.U_EMARNACHHB_T9',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMARNACHHB','T91','dbo.U_EMARNACHHB_Nines',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EMARNACHHB_Bank
-----------

IF OBJECT_ID('U_EMARNACHHB_Bank') IS NULL
CREATE TABLE [dbo].[U_EMARNACHHB_Bank] (
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

-----------
-- Create table U_EMARNACHHB_D5
-----------

IF OBJECT_ID('U_EMARNACHHB_D5') IS NULL
CREATE TABLE [dbo].[U_EMARNACHHB_D5] (
    [drvCompanyName] varchar(7) NOT NULL,
    [drvCompanyIdentification] varchar(10) NOT NULL,
    [drvCompDescDate] char(6) NULL,
    [drvEffectiveEntryDate] char(6) NULL,
    [drvOriginatingDFIIdentifictin] varchar(8) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL
);

-----------
-- Create table U_EMARNACHHB_D6
-----------

IF OBJECT_ID('U_EMARNACHHB_D6') IS NULL
CREATE TABLE [dbo].[U_EMARNACHHB_D6] (
    [drvTransactionCode] varchar(2) NULL,
    [drvReceivingDFIIdentification] varchar(9) NULL,
    [drvDFIAccountNumber] varchar(22) NULL,
    [drvAmount] money NULL,
    [drvIdentificationNumber] char(11) NULL,
    [drvReceivingCompanyName] varchar(201) NULL,
    [drvTraceNumber] varchar(32) NULL,
    [drvInitialSort] varchar(25) NULL
);

-----------
-- Create table U_EMARNACHHB_D8
-----------

IF OBJECT_ID('U_EMARNACHHB_D8') IS NULL
CREATE TABLE [dbo].[U_EMARNACHHB_D8] (
    [drvEntryAddendaCount] decimal NULL,
    [drvEntryHash] decimal NULL,
    [drvTotalDebitEntryDollarAmt] decimal NULL,
    [drvTotalCreditEntryDollarAmt] decimal NULL,
    [drvCompanyIdentification] varchar(10) NOT NULL,
    [drvOriginatingDFIIdentifictin] varchar(8) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL
);

-----------
-- Create table U_EMARNACHHB_EEList
-----------

IF OBJECT_ID('U_EMARNACHHB_EEList') IS NULL
CREATE TABLE [dbo].[U_EMARNACHHB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMARNACHHB_File
-----------

IF OBJECT_ID('U_EMARNACHHB_File') IS NULL
CREATE TABLE [dbo].[U_EMARNACHHB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(94) NULL
);

-----------
-- Create table U_EMARNACHHB_H1
-----------

IF OBJECT_ID('U_EMARNACHHB_H1') IS NULL
CREATE TABLE [dbo].[U_EMARNACHHB_H1] (
    [drvImmediateDestination] varchar(10) NULL,
    [drvImmediateOriginCode] varchar(10) NULL,
    [drvFileCreationDate] char(6) NULL,
    [drvFileCreationTime] varchar(8000) NULL,
    [drvImmediateDestinationName] varchar(23) NOT NULL,
    [drvImmediateOriginName] varchar(7) NOT NULL
);

-----------
-- Create table U_EMARNACHHB_Nines
-----------

IF OBJECT_ID('U_EMARNACHHB_Nines') IS NULL
CREATE TABLE [dbo].[U_EMARNACHHB_Nines] (
    [drvNines] varchar(95) NULL
);

-----------
-- Create table U_EMARNACHHB_PDedHist
-----------

IF OBJECT_ID('U_EMARNACHHB_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMARNACHHB_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCoID] char(5) NOT NULL,
    [PrgCoBankID] char(4) NOT NULL,
    [EepNameFirst] varchar(100) NULL,
    [EepNameLast] varchar(100) NULL,
    [EepSSN] char(11) NULL,
    [EecEmpNo] char(9) NULL,
    [PrhEEBankRoute] char(9) NULL,
    [PrhAcct] varchar(22) NULL,
    [PrhAccttype] char(1) NULL,
    [PrhGenNumber] char(12) NOT NULL,
    [PdhEECurAmt] money NULL
);

-----------
-- Create table U_EMARNACHHB_SavePath
-----------

IF OBJECT_ID('U_EMARNACHHB_SavePath') IS NULL
CREATE TABLE [dbo].[U_EMARNACHHB_SavePath] (
    [svFormatCode] char(10) NOT NULL,
    [svCfgName] varchar(32) NOT NULL,
    [svCfgValue] varchar(150) NULL
);

-----------
-- Create table U_EMARNACHHB_T9
-----------

IF OBJECT_ID('U_EMARNACHHB_T9') IS NULL
CREATE TABLE [dbo].[U_EMARNACHHB_T9] (
    [drvBlockCount] int NULL,
    [drvEntryAddendaCount] decimal NULL,
    [drvEntryHash] decimal NULL,
    [drvTotalDebitEntryDollarAmt] decimal NULL,
    [drvTotalCreditEntryDollarAmt] decimal NULL,
    [drvBlockCountNines] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMARNACHHB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Mar-Bal, Inc.

Created By: Marie Thomerson
Business Analyst: Cheryl Petitti
Create Date: 2022-01-20
Service Request Number: TekP-2021-09-16-0006

Purpose: Huntington Bank NACHA

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMARNACHHB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMARNACHHB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMARNACHHB';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'EMARNACHHB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMARNACHHB' ORDER BY RunID DESC;
[dbo].[AscDefH]

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMARNACHHB', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMARNACHHB', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMARNACHHB', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut_v7_4  'EMARNACHHB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    WHERE FormatCode = 'EMARNACHHB';

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
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMARNACHHB_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMARNACHHB_PDedHist;
    SELECT 
         PdhEEID = PrgEEID
        ,PdhCoID = PrgCoID
        ,PrgCoBankID
        ,EepNameFirst
        ,EepNameLast
        ,EepSSN
        ,EecEmpNo = PrgEmpNo
        ,PrhEEBankRoute
        ,PrhAcct
        ,PrhAccttype
        ,PrhGenNumber
        ,PdhEECurAmt = prhDepositAmt
    INTO dbo.U_EMARNACHHB_PDedHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = PrgEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = PrgEEID
        AND EecCoID = PrgCoID
        AND EecPayGroup = 'CORPBW'
    JOIN dbo.iPDirHist WITH (NOLOCK)
        ON PrhGenNumber = PrgGenNumber
        AND PrgPayDate BETWEEN @StartDate AND @EndDate
        AND PrgCoID = 'IAGFG'

    -----------------------------
    -- Working Table - Bank
    -----------------------------
    IF OBJECT_ID('U_EMARNACHHB_Bank','U') IS NOT NULL
        DROP TABLE dbo.U_EMARNACHHB_Bank;
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
    INTO dbo.U_EMARNACHHB_Bank
    FROM dbo.Bank WITH (NOLOCK)
        JOIN dbo.U_EMARNACHHB_PDedHist WITH (NOLOCK)
        on prgCoBankID = BnkCoBankID
         JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrBankId = BnkCoBankID
        ;

    ----------------------------------
    -- File Header Record ? Type 1
    ----------------------------------
    IF OBJECT_ID('U_EMARNACHHB_H1','U') IS NOT NULL
        DROP TABLE dbo.U_EMARNACHHB_H1;
    SELECT DISTINCT
        drvImmediateDestination = SPACE(1) + '044000024' --BnkAchBankRoutingNo
        ,drvImmediateOriginCode = SPACE(1) + '341059601'
        --BnkDDRecord1Pos14To23
        ,drvFileCreationDate = CONVERT(CHAR(6),@RunDate,12)
        ,drvFileCreationTime = REPLACE(CONVERT(VARCHAR(6),@RunDate,108),':',SPACE(0))
        ,drvImmediateDestinationName = 'HUNTINGTON NATIONAL BKS' --BnkBankName
        ,drvImmediateOriginName = 'MAR-BAL'
    INTO dbo.U_EMARNACHHB_H1
    FROM dbo.U_EMARNACHHB_Bank WITH (NOLOCK);

    -------------------------------------------
    -- Company/Batch Header Record  - Type 5
    -------------------------------------------
    IF OBJECT_ID('U_EMARNACHHB_D5','U') IS NOT NULL
        DROP TABLE dbo.U_EMARNACHHB_D5;
    SELECT DISTINCT
        drvCompanyName = 'MAR-BAL'
        --,drvCompanyDiscretionaryData = BnkDDRecord5Pos21To40
        ,drvCompanyIdentification = '1341059601'
        ,drvCompDescDate = CONVERT(CHAR(6),GETDATE(),12)
        ,drvEffectiveEntryDate = CONVERT(CHAR(6),@PrgPayDate,12)
        ,drvOriginatingDFIIdentifictin = '04400002' --BnkDDRecord5Pos80To87
        ,drvInitialSort = '1'
    INTO dbo.U_EMARNACHHB_D5
    FROM dbo.U_EMARNACHHB_PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMARNACHHB_Bank WITH (NOLOCK)
        ON BnkCoBankID = PrgCoBankID;

    ----------------------------------
    -- Entry Detail Record - Type 6
    ----------------------------------
    IF OBJECT_ID('U_EMARNACHHB_D6','U') IS NOT NULL
        DROP TABLE dbo.U_EMARNACHHB_D6;
    SELECT DISTINCT
        drvTransactionCode = CASE WHEN PrhAccttype = 'C' THEN '22'
                                  WHEN PrhAccttype = 'S' THEN '32'
                                  END
        ,drvReceivingDFIIdentification = SUBSTRING(PrhEEBankRoute,1,9)
        --,drvCheckDigit = SUBSTRING(EddEeBankRoute,10,1)
        ---May not need check digit
        ,drvDFIAccountNumber = PrhAcct
        ,drvAmount = ISNULL(PdhEECurAmt,0.00) * 100 
        --PrgDDAmt For Percontrols posted in the date range of the file
        ,drvIdentificationNumber = EepSSN
        ,drvReceivingCompanyName = UPPER(RTRIM(EepNameLast)) + SPACE(1) + UPPER(EepNameFirst)
        ,drvTraceNumber = '04400002'+ dbo.dsi_fnPadZero(ROW_NUMBER() OVER (ORDER BY RTRIM(EecEmpNo)),7,0)
        ,drvInitialSort = '2' + dbo.dsi_fnPadZero(ROW_NUMBER() OVER (ORDER BY RTRIM(EecEmpNo)),7,0)
    INTO dbo.U_EMARNACHHB_D6
    FROM dbo.U_EMARNACHHB_Bank WITH (NOLOCK)
    JOIN dbo.U_EMARNACHHB_PDedHist WITH (NOLOCK)
        ON BnkCoBankID = PrgCoBankID
  --  JOIN dbo.empdirdp WITH(NOLOCK) 
  --      ON EddEEID = PdhEEID
  --      AND EddCOID = PdhCoID
        --AND rtrim(EddEeBankRoute) = PrhEEBankRoute
        --AND rtrim(EddAcct) = PrhAcct
        --AND EddAccountIsInactive = 'N'
;
           -- ON PdhEEID = PrgEEID
        --AND PdhCoID = PrgCoID
    --------------------------------------------
    -- Company/Batch Control Record - Type 8
    --------------------------------------------
    IF OBJECT_ID('U_EMARNACHHB_D8','U') IS NOT NULL
        DROP TABLE dbo.U_EMARNACHHB_D8;
    SELECT DISTINCT
        drvEntryAddendaCount = CONVERT(DECIMAL(10,0),ISNULL((SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D6 WITH (NOLOCK)),0))
        ,drvEntryHash = (SELECT SUM(CONVERT(DECIMAL(10,0),LEFT(drvReceivingDFIIdentification,8))) FROM dbo.U_EMARNACHHB_D6 WITH (NOLOCK))
        ---check that 8 digits
    --        If the first 8 digits in the Receiving DFI ID field are 24107041
        --If there are 2 record type 6 entries on the file with the same number the value in this field is
        --24107041 x 2 = 48214082
        ,drvTotalDebitEntryDollarAmt = CONVERT(DECIMAL(10,0),0)
        ,drvTotalCreditEntryDollarAmt = (select SUM(CONVERT(DECIMAL(10,0),(ISNULL(drvAmount,0.00) ))) from dbo.U_EMARNACHHB_D6 WITH (NOLOCK))
        --SUM(CONVERT(DECIMAL(10,0),(ISNULL(PdhEECurAmt,0.00)* 100 )))
        --SUM PrgDDAmt of all Record Type 6
        --This is the total amount sent for all Record Type 6 records
        ,drvCompanyIdentification = '1341059601'
        --BnkDDRecord8Pos45To54
        --,drvOriginatingDFIIdentifictin = BnkDDRecord8Pos80To87
        ,drvOriginatingDFIIdentifictin = '04400002'
        ,drvInitialSort = '3'
    INTO dbo.U_EMARNACHHB_D8
    FROM dbo.U_EMARNACHHB_PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMARNACHHB_Bank WITH (NOLOCK)
        ON BnkCoBankID = PrgCoBankID
    --GROUP BY BnkDDRecord8Pos45To54, BnkDDRecord8Pos80To87;

    ------------------------------------
    -- File Control Record - Record 9
    ------------------------------------
    IF OBJECT_ID('U_EMARNACHHB_T9','U') IS NOT NULL
        DROP TABLE dbo.U_EMARNACHHB_T9;
    SELECT DISTINCT
        --drvBlockCount = (SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D5) + (SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D6) + (SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D8) + 2
         drvBlockCount = (SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D5 WITH (NOLOCK)) + (SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D6 WITH (NOLOCK)) + (SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D8 WITH (NOLOCK)) + 2
        ,drvEntryAddendaCount = SUM(CONVERT(DECIMAL(10,0),drvEntryAddendaCount))
        ,drvEntryHash = (SELECT SUM(CONVERT(DECIMAL(10,0),LEFT(drvReceivingDFIIdentification,8))) FROM dbo.U_EMARNACHHB_D6 WITH (NOLOCK))
        --SUM(CONVERT(DECIMAL(10,0),drvReceivingDFIIdentification)) FROM dbo.U_EMARNACHHB_D6 WITH (NOLOCK)
        --SUM(CONVERT(DECIMAL(10,0),drvEntryHash))
        ,drvTotalDebitEntryDollarAmt = CONVERT(DECIMAL(10,0),0)
        ,drvTotalCreditEntryDollarAmt = (select SUM(CONVERT(DECIMAL(10,0),(ISNULL(drvAmount,0.00) ))) from dbo.U_EMARNACHHB_D6 WITH (NOLOCK))
        --,drvBlockCountNines = (SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D5) + (SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D6) + (SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D8) + 2
        ,drvBlockCountNines = (SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D5 WITH (NOLOCK)) + (SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D6 WITH (NOLOCK)) + (SELECT COUNT(*) FROM dbo.U_EMARNACHHB_D8 WITH (NOLOCK)) + 2
    INTO dbo.U_EMARNACHHB_T9
    FROM dbo.U_EMARNACHHB_D8 WITH (NOLOCK);

    ------------------------------------
    -- Update Block Count
    ------------------------------------
    --UPDATE dbo.U_EMARNACHHB_T9
    --    SET drvBlockCount = CASE WHEN drvBlockCount % 10 = 0 THEN drvBlockCount/10
    --                             ELSE drvBlockCount/10 + 1
    --                        END;
    UPDATE dbo.U_EMARNACHHB_T9
        SET drvBlockCount = CASE WHEN drvBlockCount % 10 = 0 THEN drvBlockCount/10
                                 ELSE drvBlockCount/10 + 1
                            END;
    ---------------------------------------
    -- Create 9 Records to Complete File
    ----------------------------------------
    --DECLARE @Nines INT
    --SET @Nines = (10 - (SELECT CASE WHEN (drvBlockCountNines % 10) = 0 THEN 10 ELSE (drvBlockCountNines % 10) END FROM dbo.U_EMARNACHHB_T9));

    --IF object_id('U_EMARNACHHB_Nines','U') IS NOT NULL
    --    DROP TABLE dbo.U_EMARNACHHB_Nines
    --CREATE TABLE dbo.U_EMARNACHHB_Nines (
    --    drvNines VARCHAR(94)
    --);

    --WHILE @Nines > 0
    --BEGIN
    --    INSERT INTO dbo.U_EMARNACHHB_Nines (drvNines) VALUES ('9');
    --    SET @Nines -= 1;
    --    PRINT @Nines;
    --END;

        DECLARE @Nines INT
    SET @Nines = (10 - (SELECT (drvBlockCountNines % 10) FROM dbo.U_EMARNACHHB_T9 WITH (NOLOCK)))

    IF object_id('U_EMARNACHHB_Nines','U') IS NOT NULL
        DROP TABLE dbo.U_EMARNACHHB_Nines
    CREATE TABLE dbo.U_EMARNACHHB_Nines (
        drvNines VARCHAR(95)
    );

    WHILE @Nines > 0
    BEGIN
        INSERT INTO dbo.U_EMARNACHHB_Nines (drvNines) VALUES ('9');
        SET @Nines -= 1;
        PRINT @Nines;
    END;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EMARNACHHB','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'EMARNACHHB_' + CONVERT(CHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'EMARNACHHB';
    END;

END
/**********************************************************************************
--Alter the View
ALTER VIEW dbo.dsi_vwEMARNACHHB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMARNACHHB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;
GO
--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID IN (SELECT AdhSystemID FROM dbo.AscDefH WHERE AdhFormatCode = 'EMARNACHHB')
ORDER BY AdfSetNumber, AdfFieldNumber;
--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202112011'
       ,ExpStartPerControl     = '202112011'
       ,ExpLastEndPerControl   = '202112109'
       ,ExpEndPerControl       = '202112109'
WHERE ExpFormatCode = 'EMARNACHHB';
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMARNACHHB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMARNACHHB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMARNACHHB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMARNACHHB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMARNACHHB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMARNACHHB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMARNACHHB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMARNACHHB', 'UseFileName', 'V', 'Y'


-- End ripout