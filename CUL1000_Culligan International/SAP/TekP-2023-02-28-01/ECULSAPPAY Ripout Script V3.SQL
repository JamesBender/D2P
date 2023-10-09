/**********************************************************************************

ECULSAPPAY: SAP General Journal Entry

FormatCode:     ECULSAPPAY
Project:        SAP General Journal Entry
Client ID:      CUL1000
Date/time:      2023-10-06 11:46:24.653
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N24
Server:         N2SUP4ST05
Database:       ULTIPRO_CULLIGAN
Web Filename:   CUL1000_03870_EEHISTORY_ECULSAPPAY_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECULSAPPAY_SavePath') IS NOT NULL DROP TABLE dbo.U_ECULSAPPAY_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECULSAPPAY'


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
WHERE FormatCode = 'ECULSAPPAY'
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
WHERE ExpFormatCode = 'ECULSAPPAY'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECULSAPPAY')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECULSAPPAY'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECULSAPPAY'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECULSAPPAY'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECULSAPPAY'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECULSAPPAY'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECULSAPPAY'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECULSAPPAY'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECULSAPPAY'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECULSAPPAY'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECULSAPPAY_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECULSAPPAY_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECULSAPPAY') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECULSAPPAY];
GO
IF OBJECT_ID('U_ECULSAPPAY_File') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPPAY_File];
GO
IF OBJECT_ID('U_ECULSAPPAY_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPPAY_EEList];
GO
IF OBJECT_ID('U_ECULSAPPAY_drvTbl_60') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPPAY_drvTbl_60];
GO
IF OBJECT_ID('U_ECULSAPPAY_drvTbl_55') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPPAY_drvTbl_55];
GO
IF OBJECT_ID('U_ECULSAPPAY_drvTbl_50') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPPAY_drvTbl_50];
GO
IF OBJECT_ID('U_ECULSAPPAY_drvTbl_40') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPPAY_drvTbl_40];
GO
IF OBJECT_ID('U_ECULSAPPAY_drvTbl_35') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPPAY_drvTbl_35];
GO
IF OBJECT_ID('U_ECULSAPPAY_drvTbl_30') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPPAY_drvTbl_30];
GO
IF OBJECT_ID('U_ECULSAPPAY_drvTbl_20') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPPAY_drvTbl_20];
GO
IF OBJECT_ID('U_ECULSAPPAY_drvTbl_15') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPPAY_drvTbl_15];
GO
IF OBJECT_ID('U_ECULSAPPAY_drvTbl_10') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPPAY_drvTbl_10];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECULSAPPAY','SAP General Journal Entry','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ECULSAPPAYZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPPAYZ0','50','H','01','1',NULL,'BATCH ID',NULL,NULL,'"BATCH ID"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPPAYZ0','50','H','02','1',NULL,'Filler',NULL,NULL,'"//"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPPAYZ0','50','H','03','1',NULL,'filler',NULL,NULL,'"//"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPPAYZ0','50','H','04','1',NULL,'filler',NULL,NULL,'"//"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPPAYZ0','50','H','05','1',NULL,'1,Header',NULL,NULL,'"1,Header"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPPAYZ0','50','H','06','1',NULL,'BUKRS',NULL,NULL,'",BUKRS"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECULSAPPAYZ0','50','H','06','2',NULL,'BLART',NULL,NULL,'"BLART"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECULSAPPAYZ0','50','H','06','3',NULL,'BLDAT',NULL,NULL,'"BLDAT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECULSAPPAYZ0','50','H','06','4',NULL,'BUDAT',NULL,NULL,'"BUDAT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECULSAPPAYZ0','50','H','06','5',NULL,'MONAT',NULL,NULL,'"MONAT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECULSAPPAYZ0','50','H','06','6',NULL,'BKTXT',NULL,NULL,'"BKTXT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECULSAPPAYZ0','50','H','06','7',NULL,'WAERS',NULL,NULL,'"WAERS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECULSAPPAYZ0','50','H','06','8',NULL,'LDGRP',NULL,NULL,'"LDGRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECULSAPPAYZ0','50','H','06','9',NULL,'KURSF_EXT',NULL,NULL,'"KURSF_EXT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECULSAPPAYZ0','50','H','06','10',NULL,'WWERT',NULL,NULL,'"WWERT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECULSAPPAYZ0','50','H','06','11',NULL,'XBLNR',NULL,NULL,'"XBLNR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECULSAPPAYZ0','50','H','06','12',NULL,'PARGB_HDR',NULL,NULL,'"PARGB_HDR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECULSAPPAYZ0','50','H','06','13',NULL,'FULFILLDATE',NULL,NULL,'"FULFILLDATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECULSAPPAYZ0','50','H','06','14',NULL,'XMWST',NULL,NULL,'"XMWST"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPPAYZ0','50','D','10','1',NULL,'*Company Code (4)',NULL,NULL,'"drvCompanyCode4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECULSAPPAYZ0','50','D','10','2',NULL,'*Journal Entry Type (2)',NULL,NULL,'"drvJournalEntryType2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECULSAPPAYZ0','50','D','10','3',NULL,'*Journal Entry Date',NULL,NULL,'"drvJournalEntryDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECULSAPPAYZ0','50','D','10','4',NULL,'*Posting Date',NULL,NULL,'"drvPostingDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECULSAPPAYZ0','50','D','10','5',NULL,'Fiscal period (2)',NULL,NULL,'"drvFiscalPeriod"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECULSAPPAYZ0','50','D','10','6',NULL,'Document Header Text (25)',NULL,NULL,'"drvDocumentHeaderText"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECULSAPPAYZ0','50','D','10','7',NULL,'*Transaction Currency (5)',NULL,NULL,'"drvTransactionCurrency"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECULSAPPAYZ0','50','D','10','8',NULL,'Ledger Group (4)',NULL,NULL,'"drvLedgerGroup"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECULSAPPAYZ0','50','D','10','9',NULL,'Exchange Rate (12)',NULL,NULL,'"drvExchangeRate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECULSAPPAYZ0','50','D','10','10',NULL,'Currency Translation Date',NULL,NULL,'"drvCurrencyTranslationDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECULSAPPAYZ0','50','D','10','11',NULL,'Reference Document Number (16)',NULL,NULL,'"drvReferenceDocumentNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECULSAPPAYZ0','50','D','10','12',NULL,'Partner Business Area (4)',NULL,NULL,'"drvPartnerBusinessArea"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECULSAPPAYZ0','50','D','10','13',NULL,'Tax Fulfillment Date',NULL,NULL,'"drvTaxFulfillmentDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECULSAPPAYZ0','50','D','10','14',NULL,'Calculate Tax Automatically (1)',NULL,NULL,'"drvCalculateTaxAutomatically"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPPAYZ0','50','D','20','1',NULL,'BUKRS',NULL,NULL,'",US01"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECULSAPPAYZ0','50','D','20','2',NULL,'BLART',NULL,NULL,'"SI"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECULSAPPAYZ0','50','D','20','3',NULL,'BLDAT',NULL,NULL,'"drvJournalEntryDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECULSAPPAYZ0','50','D','20','4',NULL,'BUDAT',NULL,NULL,'"drvPostingDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECULSAPPAYZ0','50','D','20','5',NULL,'MONAT',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECULSAPPAYZ0','50','D','20','6',NULL,'BKTXT',NULL,NULL,'"Payroll Checks"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECULSAPPAYZ0','50','D','20','7',NULL,'WAERS',NULL,NULL,'"USD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECULSAPPAYZ0','50','D','20','8',NULL,'LDGRP',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECULSAPPAYZ0','50','D','20','9',NULL,'KURSF_EXT',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECULSAPPAYZ0','50','D','20','10',NULL,'WWERT',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECULSAPPAYZ0','50','D','20','11',NULL,'XBLNR',NULL,NULL,'"1508"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECULSAPPAYZ0','50','D','20','12',NULL,'PARGB_HDR',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECULSAPPAYZ0','50','D','20','13',NULL,'FULFILLDATE',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECULSAPPAYZ0','50','D','20','14',NULL,'XMWST',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPPAYZ0','50','D','30','1',NULL,'Line Items',NULL,NULL,'"drvLineItems"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPPAYZ0','50','D','40','1',NULL,'BUKRS',NULL,NULL,'"drvBUKRS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECULSAPPAYZ0','50','D','40','2',NULL,'HKONT',NULL,NULL,'"drvHKONT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECULSAPPAYZ0','50','D','40','3',NULL,'SGTXT',NULL,NULL,'"drvSGTXT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECULSAPPAYZ0','50','D','40','4',NULL,'WRSOL',NULL,NULL,'"drvWRSOL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECULSAPPAYZ0','50','D','40','5',NULL,'WRHAB',NULL,NULL,'"drvWRHAB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECULSAPPAYZ0','50','D','40','6',NULL,'DMBTR',NULL,NULL,'"drvDMBTR"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECULSAPPAYZ0','50','D','40','7',NULL,'DMBE2',NULL,NULL,'"drvDMBE2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECULSAPPAYZ0','50','D','40','8',NULL,'MWSKZ',NULL,NULL,'"drvMWSKZ"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECULSAPPAYZ0','50','D','40','9',NULL,'TXJCD',NULL,NULL,'"drvTXJCD"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECULSAPPAYZ0','50','D','40','10',NULL,'KOSTL',NULL,NULL,'"drvKOSTL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECULSAPPAYZ0','50','D','40','11',NULL,'PRCTR',NULL,NULL,'"drvPRCTR"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECULSAPPAYZ0','50','D','40','12',NULL,'AUFNR',NULL,NULL,'"drvAUFNR"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECULSAPPAYZ0','50','D','40','13',NULL,'PS_POSID',NULL,NULL,'"drvPS_POSID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECULSAPPAYZ0','50','D','40','14',NULL,'VALUT',NULL,NULL,'"drvVALUT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECULSAPPAYZ0','50','D','40','15',NULL,'HBKID',NULL,NULL,'"drvHBKID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECULSAPPAYZ0','50','D','40','16',NULL,'HKTID',NULL,NULL,'"drvHKTID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECULSAPPAYZ0','50','D','40','17',NULL,'ZUONR',NULL,NULL,'"drvZUONR"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECULSAPPAYZ0','50','D','40','18',NULL,'VBUND',NULL,NULL,'"drvVBUND"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECULSAPPAYZ0','50','D','40','19',NULL,'SEGMENT',NULL,NULL,'"drvSEGMENT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECULSAPPAYZ0','50','D','40','20',NULL,'PROF_KNDNR',NULL,NULL,'"drvPROF_KNDNR"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECULSAPPAYZ0','50','D','40','21',NULL,'PROF_ARTNR',NULL,NULL,'"drvPROF_ARTNR"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECULSAPPAYZ0','50','D','40','22',NULL,'PROF_KUNRE',NULL,NULL,'"drvPROF_KUNRE"','(''uA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPPAYZ0','50','D','50','1',NULL,'Company Code (4)',NULL,NULL,'"drvCompanyCode4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECULSAPPAYZ0','50','D','50','2',NULL,'G/L Account (10)',NULL,NULL,'"drvGLAccount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECULSAPPAYZ0','50','D','50','3',NULL,'Item Text (50)',NULL,NULL,'"drvItemText"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECULSAPPAYZ0','50','D','50','4',NULL,'Debit',NULL,NULL,'"drvDebit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECULSAPPAYZ0','50','D','50','5',NULL,'Credit',NULL,NULL,'"drvcredit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECULSAPPAYZ0','50','D','50','6',NULL,'Amount in Company Code Currency',NULL,NULL,'"drvAmtCompanyCodeCurr"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECULSAPPAYZ0','50','D','50','7',NULL,'Amount in second local currency (LC2)',NULL,NULL,'"drvAmtsecondlocalcurr"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECULSAPPAYZ0','50','D','50','8',NULL,'Tax Code (2)',NULL,NULL,'"drvTaxCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECULSAPPAYZ0','50','D','50','9',NULL,'Tax Jurisdiction (15)',NULL,NULL,'"drvTaxJurisdiction"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECULSAPPAYZ0','50','D','50','10',NULL,'Cost Center (10)',NULL,NULL,'"drvCostCenter"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECULSAPPAYZ0','50','D','50','11',NULL,'Profit Center (10)',NULL,NULL,'"drvProfitCenter"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECULSAPPAYZ0','50','D','50','12',NULL,'Order Number (12))',NULL,NULL,'"drvOrderNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECULSAPPAYZ0','50','D','50','13',NULL,'WBS Element (24)',NULL,NULL,'"drvWBSElement"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECULSAPPAYZ0','50','D','50','14',NULL,'Value Date',NULL,NULL,'"drvValueDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECULSAPPAYZ0','50','D','50','15',NULL,'House Bank (5)',NULL,NULL,'"drvHouseBank"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECULSAPPAYZ0','50','D','50','16',NULL,'House Bank Account (5)',NULL,NULL,'"drvHouseBankAccount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECULSAPPAYZ0','50','D','50','17',NULL,'Assignment number (18)',NULL,NULL,'"drvAssignmentNumber"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECULSAPPAYZ0','50','D','50','18',NULL,'Trading Partner (6)',NULL,NULL,'"drvTradingPartner"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECULSAPPAYZ0','50','D','50','19',NULL,'Segment for Segmental Reporting (10)',NULL,NULL,'"drvSegmentReorting"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECULSAPPAYZ0','50','D','50','20',NULL,'Customer (10)',NULL,NULL,'"drvCustomer"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECULSAPPAYZ0','50','D','50','21',NULL,'Product number (40)',NULL,NULL,'"drvProductNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECULSAPPAYZ0','50','D','50','22',NULL,'Bill-to Party (10)',NULL,NULL,'"drvBillParty"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPPAYZ0','50','D','60','1',NULL,'BUKRS',NULL,NULL,'"drvCompanyCode4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECULSAPPAYZ0','50','D','60','2',NULL,'HKONT',NULL,NULL,'"drvGLAccount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECULSAPPAYZ0','50','D','60','3',NULL,'SGTXT',NULL,NULL,'"drvItemText"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECULSAPPAYZ0','50','D','60','4',NULL,'WRSOL',NULL,NULL,'"drvDebit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECULSAPPAYZ0','50','D','60','5',NULL,'WRHAB',NULL,NULL,'"drvcredit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECULSAPPAYZ0','50','D','60','6',NULL,'DMBTR',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECULSAPPAYZ0','50','D','60','7',NULL,'DMBE2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECULSAPPAYZ0','50','D','60','8',NULL,'MWSKZ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECULSAPPAYZ0','50','D','60','9',NULL,'TXJCD',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECULSAPPAYZ0','50','D','60','10',NULL,'KOSTL',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECULSAPPAYZ0','50','D','60','11',NULL,'PRCTR',NULL,NULL,'"drvProfitCenter"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECULSAPPAYZ0','50','D','60','12',NULL,'AUFNR',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECULSAPPAYZ0','50','D','60','13',NULL,'PS_POSID',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECULSAPPAYZ0','50','D','60','14',NULL,'VALUT',NULL,NULL,'"drvValueDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECULSAPPAYZ0','50','D','60','15',NULL,'HBKID',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECULSAPPAYZ0','50','D','60','16',NULL,'HKTID',NULL,NULL,'""','(''ss''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECULSAPPAYZ0','50','D','60','17',NULL,'ZUONR',NULL,NULL,'"drvAssignmentNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECULSAPPAYZ0','50','D','60','18',NULL,'VBUND',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECULSAPPAYZ0','50','D','60','19',NULL,'SEGMENT',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECULSAPPAYZ0','50','D','60','20',NULL,'PROF_KNDNR',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECULSAPPAYZ0','50','D','60','21',NULL,'PROF_ARTNR',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECULSAPPAYZ0','50','D','60','22',NULL,'PROF_KUNRE',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECULSAPPAY_20231006.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SAP General Journal Entry','202308099','EMPEXPORT','ONDEM_XOE',NULL,'ECULSAPPAY',NULL,NULL,NULL,'202308099','Aug  9 2023  7:54AM','Aug  9 2023  7:54AM','202308091',NULL,'','','202308091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SAP General Journal Entr-Sched','202308099','EMPEXPORT','SCH_ECULSA',NULL,'ECULSAPPAY',NULL,NULL,NULL,'202308099','Aug  9 2023  7:54AM','Aug  9 2023  7:54AM','202308091',NULL,'','','202308091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'SAP General Journal Entr-Test','202308099','EMPEXPORT','TEST_XOE',NULL,'ECULSAPPAY',NULL,NULL,NULL,'202308099','Aug  9 2023  7:54AM','Aug  9 2023  7:54AM','202308091',NULL,'','','202308091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPPAY','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPPAY','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPPAY','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPPAY','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPPAY','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPPAY','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPPAY','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPPAY','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPPAY','H02','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPPAY','H03','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPPAY','H04','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPPAY','H05','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPPAY','H06','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPPAY','D10','dbo.U_ECULSAPPAY_drvTbl_10',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPPAY','D20','dbo.U_ECULSAPPAY_drvTbl_20',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPPAY','D30','dbo.U_ECULSAPPAY_drvTbl_30',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPPAY','D40','dbo.U_ECULSAPPAY_drvTbl_40',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPPAY','D50','dbo.U_ECULSAPPAY_drvTbl_50',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPPAY','D60','dbo.U_ECULSAPPAY_drvTbl_60',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ECULSAPPAY_drvTbl_10
-----------

IF OBJECT_ID('U_ECULSAPPAY_drvTbl_10') IS NULL
CREATE TABLE [dbo].[U_ECULSAPPAY_drvTbl_10] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCompanyCode4] varchar(18) NOT NULL,
    [drvJournalEntryType2] varchar(23) NOT NULL,
    [drvJournalEntryDate] varchar(19) NOT NULL,
    [drvPostingDate] varchar(13) NOT NULL,
    [drvFiscalPeriod] varchar(17) NOT NULL,
    [drvDocumentHeaderText] varchar(25) NOT NULL,
    [drvTransactionCurrency] varchar(25) NOT NULL,
    [drvLedgerGroup] varchar(16) NOT NULL,
    [drvExchangeRate] varchar(18) NOT NULL,
    [drvCurrencyTranslationDate] varchar(25) NOT NULL,
    [drvReferenceDocumentNumber] varchar(30) NOT NULL,
    [drvPartnerBusinessArea] varchar(25) NOT NULL,
    [drvTaxFulfillmentDate] varchar(20) NOT NULL,
    [drvCalculateTaxAutomatically] varchar(31) NOT NULL
);

-----------
-- Create table U_ECULSAPPAY_drvTbl_15
-----------

IF OBJECT_ID('U_ECULSAPPAY_drvTbl_15') IS NULL
CREATE TABLE [dbo].[U_ECULSAPPAY_drvTbl_15] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDebits] varchar(1) NOT NULL,
    [drvCredits] varchar(1) NOT NULL
);

-----------
-- Create table U_ECULSAPPAY_drvTbl_20
-----------

IF OBJECT_ID('U_ECULSAPPAY_drvTbl_20') IS NULL
CREATE TABLE [dbo].[U_ECULSAPPAY_drvTbl_20] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvJournalEntryDate] varchar(30) NULL,
    [drvPostingDate] varchar(30) NULL
);

-----------
-- Create table U_ECULSAPPAY_drvTbl_30
-----------

IF OBJECT_ID('U_ECULSAPPAY_drvTbl_30') IS NULL
CREATE TABLE [dbo].[U_ECULSAPPAY_drvTbl_30] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvLineItems] varchar(11) NOT NULL
);

-----------
-- Create table U_ECULSAPPAY_drvTbl_35
-----------

IF OBJECT_ID('U_ECULSAPPAY_drvTbl_35') IS NULL
CREATE TABLE [dbo].[U_ECULSAPPAY_drvTbl_35] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvJournalEntryDate] varchar(1) NOT NULL,
    [drvPostingDate] varchar(1) NOT NULL
);

-----------
-- Create table U_ECULSAPPAY_drvTbl_40
-----------

IF OBJECT_ID('U_ECULSAPPAY_drvTbl_40') IS NULL
CREATE TABLE [dbo].[U_ECULSAPPAY_drvTbl_40] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvBUKRS] varchar(6) NOT NULL,
    [drvHKONT] varchar(5) NOT NULL,
    [drvSGTXT] varchar(5) NOT NULL,
    [drvWRSOL] varchar(5) NOT NULL,
    [drvWRHAB] varchar(5) NOT NULL,
    [drvDMBTR] varchar(5) NOT NULL,
    [drvDMBE2] varchar(5) NOT NULL,
    [drvMWSKZ] varchar(5) NOT NULL,
    [drvTXJCD] varchar(5) NOT NULL,
    [drvKOSTL] varchar(5) NOT NULL,
    [drvPRCTR] varchar(5) NOT NULL,
    [drvAUFNR] varchar(5) NOT NULL,
    [drvPS_POSID] varchar(8) NOT NULL,
    [drvVALUT] varchar(5) NOT NULL,
    [drvHBKID] varchar(5) NOT NULL,
    [drvHKTID] varchar(5) NOT NULL,
    [drvZUONR] varchar(5) NOT NULL,
    [drvVBUND] varchar(5) NOT NULL,
    [drvSEGMENT] varchar(7) NOT NULL,
    [drvPROF_KNDNR] varchar(10) NOT NULL,
    [drvPROF_ARTNR] varchar(10) NOT NULL,
    [drvPROF_KUNRE] varchar(10) NOT NULL
);

-----------
-- Create table U_ECULSAPPAY_drvTbl_50
-----------

IF OBJECT_ID('U_ECULSAPPAY_drvTbl_50') IS NULL
CREATE TABLE [dbo].[U_ECULSAPPAY_drvTbl_50] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCompanyCode4] varchar(17) NOT NULL,
    [drvGLAccount] varchar(16) NOT NULL,
    [drvItemText] varchar(14) NOT NULL,
    [drvDebit] varchar(5) NOT NULL,
    [drvcredit] varchar(6) NOT NULL,
    [drvAmtCompanyCodeCurr] varchar(31) NOT NULL,
    [drvAmtsecondlocalcurr] varchar(37) NOT NULL,
    [drvTaxCode] varchar(12) NOT NULL,
    [drvTaxJurisdiction] varchar(21) NOT NULL,
    [drvCostCenter] varchar(16) NOT NULL,
    [drvProfitCenter] varchar(18) NOT NULL,
    [drvOrdernumber] varchar(17) NOT NULL,
    [drvWBSElement] varchar(16) NOT NULL,
    [drvValueDate] varchar(10) NOT NULL,
    [drvHouseBank] varchar(14) NOT NULL,
    [drvHouseBankAccount] varchar(22) NOT NULL,
    [drvAssignmentNumber] varchar(22) NOT NULL,
    [drvTradingPartner] varchar(19) NOT NULL,
    [drvSegmentReorting] varchar(36) NOT NULL,
    [drvCustomer] varchar(13) NOT NULL,
    [drvProductnumber] varchar(19) NOT NULL,
    [drvBillParty] varchar(18) NOT NULL
);

-----------
-- Create table U_ECULSAPPAY_drvTbl_55
-----------

IF OBJECT_ID('U_ECULSAPPAY_drvTbl_55') IS NULL
CREATE TABLE [dbo].[U_ECULSAPPAY_drvTbl_55] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCompanyCode4] varchar(1) NOT NULL,
    [drvGLAccount] varchar(1) NOT NULL,
    [drvItemText] varchar(1) NOT NULL,
    [drvDebit] varchar(1) NOT NULL,
    [drvcredit] varchar(1) NOT NULL,
    [drvCostCenter] varchar(1) NOT NULL,
    [drvProfitCenter] varchar(1) NOT NULL,
    [drvValueDate] varchar(1) NOT NULL,
    [drvHouseBank] varchar(1) NOT NULL,
    [drvHouseBankAccount] varchar(1) NOT NULL,
    [drvAssignmentNumber] varchar(1) NOT NULL
);

-----------
-- Create table U_ECULSAPPAY_drvTbl_60
-----------

IF OBJECT_ID('U_ECULSAPPAY_drvTbl_60') IS NULL
CREATE TABLE [dbo].[U_ECULSAPPAY_drvTbl_60] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NULL,
    [drvSubSort] varchar(39) NULL,
    [drvCompanyCode4] varchar(5) NOT NULL,
    [drvGLAccount] varchar(8) NULL,
    [drvItemText] varchar(39) NULL,
    [drvDebit] money NULL,
    [drvCredit] money NULL,
    [drvProfitCenter] varchar(5) NOT NULL,
    [drvValueDate] varchar(30) NULL,
    [drvAssignmentNumber] varchar(24) NULL
);

-----------
-- Create table U_ECULSAPPAY_EEList
-----------

IF OBJECT_ID('U_ECULSAPPAY_EEList') IS NULL
CREATE TABLE [dbo].[U_ECULSAPPAY_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECULSAPPAY_File
-----------

IF OBJECT_ID('U_ECULSAPPAY_File') IS NULL
CREATE TABLE [dbo].[U_ECULSAPPAY_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECULSAPPAY]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Culligan International

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 08/09/2023
Service Request Number: TekP-2023-02-28-01

Purpose: SAP General Journal Entry

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECULSAPPAY';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECULSAPPAY';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECULSAPPAY';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECULSAPPAY';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECULSAPPAY' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECULSAPPAY', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECULSAPPAY', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECULSAPPAY', 'SCH_ECULSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECULSAPPAY', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECULSAPPAY';

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
    DELETE FROM dbo.U_ECULSAPPAY_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECULSAPPAY_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPPAY_drvTbl_10
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPPAY_drvTbl_10','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPPAY_drvTbl_10;
    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvCompanyCode4 = ',*Company Code (4)'
        ,drvJournalEntryType2 = '*Journal Entry Type (2)'
        ,drvJournalEntryDate = '*Journal Entry Date'
        ,drvPostingDate = '*Posting Date'
        ,drvFiscalPeriod = 'Fiscal period (2)'
        ,drvDocumentHeaderText = 'Document Header Text (25)'
        ,drvTransactionCurrency = '*Transaction Currency (5)'
        ,drvLedgerGroup = 'Ledger Group (4)'
        ,drvExchangeRate = 'Exchange Rate (12)'
        ,drvCurrencyTranslationDate = 'Currency Translation Date'
        ,drvReferenceDocumentNumber = 'Reference Document Number (16)'
        ,drvPartnerBusinessArea = 'Partner Business Area (4)'
        ,drvTaxFulfillmentDate ='Tax Fulfillment Date'
        ,drvCalculateTaxAutomatically = 'Calculate Tax Automatically (1)'
    INTO dbo.U_ECULSAPPAY_drvTbl_10
    FROM dbo.U_ECULSAPPAY_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPPAY_drvTbl_30
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPPAY_drvTbl_30','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPPAY_drvTbl_30;
    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvLineItems = ',Line Items'
    INTO dbo.U_ECULSAPPAY_drvTbl_30
    FROM dbo.U_ECULSAPPAY_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPPAY_drvTbl_20
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPPAY_drvTbl_20','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPPAY_drvTbl_20;
    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvJournalEntryDate = Convert(VARCHAR, VPaydate, 101)
        ,drvPostingDate = Convert(VARCHAR, VPaydate, 101)
    INTO dbo.U_ECULSAPPAY_drvTbl_20
     FROM dbo.vw_dsi_TmpAlloc WITH (NOLOCK)
    ;
       ---------------------------------
    -- DETAIL RECORD - U_ECULSAPPAY_drvTbl_40
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPPAY_drvTbl_40','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPPAY_drvTbl_40;
    SELECT DISTINCT
        drvEEID = ''
        ,drvCoID = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvBUKRS = ',BUKRS'
        ,drvHKONT = 'HKONT'
        ,drvSGTXT= 'SGTXT'
        ,drvWRSOL = 'WRSOL'
        ,drvWRHAB = 'WRHAB'
        ,drvDMBTR = 'DMBTR'
        ,drvDMBE2 = 'DMBE2'
        ,drvMWSKZ = 'MWSKZ'
        ,drvTXJCD = 'TXJCD'
        ,drvKOSTL= 'KOSTL'
        ,drvPRCTR = 'PRCTR'
        ,drvAUFNR = 'AUFNR'
        ,drvPS_POSID = 'PS_POSID'
        ,drvVALUT = 'VALUT'
        ,drvHBKID = 'HBKID'
        ,drvHKTID = 'HKTID'
        ,drvZUONR = 'ZUONR'
        ,drvVBUND = 'VBUND'
        ,drvSEGMENT = 'SEGMENT'
        ,drvPROF_KNDNR = 'PROF_KNDNR'
        ,drvPROF_ARTNR = 'PROF_ARTNR'
        ,drvPROF_KUNRE = 'PROF_KUNRE'
    INTO dbo.U_ECULSAPPAY_drvTbl_40
  --  FROM dbo.U_ECULSAPPAY_EEList WITH (NOLOCK)


    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPPAY_drvTbl_50
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPPAY_drvTbl_50','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPPAY_drvTbl_50;
    SELECT DISTINCT
        drvEEID = ''
        ,drvCoID = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvCompanyCode4 = ',Company Code (4)'
        ,drvGLAccount = 'G/L Account (10)'
        ,drvItemText = 'Item Text (50)'
        ,drvDebit = 'Debit'
        ,drvcredit = 'Credit'
        ,drvAmtCompanyCodeCurr = 'Amount in Company Code Currency'
        ,drvAmtsecondlocalcurr = 'Amount in second local currency (LC2)'
        ,drvTaxCode = 'Tax Code (2)'
        ,drvTaxJurisdiction = 'Tax Jurisdiction (15)'
        ,drvCostCenter = 'Cost Center (10)'
        ,drvProfitCenter = 'Profit Center (10)'
        ,drvOrdernumber = 'Order Number (12)'
        ,drvWBSElement = 'WBS Element (24)'
        ,drvValueDate = 'Value Date'
        ,drvHouseBank = 'House Bank (5)'
        ,drvHouseBankAccount = 'House Bank Account (5)'
        ,drvAssignmentNumber = 'Assignment number (18)'
        ,drvTradingPartner = 'Trading Partner (6)'
        ,drvSegmentReorting = 'Segment for Segmental Reporting (10)'
        ,drvCustomer = 'Customer (10)'
        ,drvProductnumber = 'Product number (40)'
        ,drvBillParty = 'Bill-to Party (10)'
    INTO dbo.U_ECULSAPPAY_drvTbl_50
  --  FROM dbo.U_ECULSAPPAY_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPPAY_drvTbl_60
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPPAY_drvTbl_60','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPPAY_drvTbl_60;


SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort =  CASE WHEN sum(vDebitamt) <> '0' THEN '1'
                           --   WHEN  sum(vCreditamt) <> '0' THEN '2' 
                              END
        ,drvSubSort =   MAX(CASE--Concat(vPayGroupdesc + 'Payroll Checks')
                                WHEN vPayGroup = 'PGN' THEN 'Paragon Payroll Checks'
                                WHEN vPayGroup = 'CWGB' THEN 'CWG Payroll Checks'
                                WHEN vPayGroup = 'BCC' THEN 'Culligan BCC Payroll Checks'
                                WHEN vPayGroup = 'BLT' THEN 'Culligan BLT Payroll Checks'
                                WHEN vPayGroup = 'EXWT' THEN 'EXWT Payroll Checks'
                                WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
                                WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
                                WHEN vPayGroup = '3003C' THEN '3003C Culligan Canada Payroll Checks'
                                WHEN vPayGroup = 'ACC' THEN 'ACC-Culligan Corporate Payroll Checks'
                                WHEN vPayGroup = 'APEC' THEN 'APEC Biweekly Payroll Checks'
                                WHEN vPayGroup = 'BCI' THEN 'BCI-Culligan Intl Payroll Checks'
                                WHEN vPayGroup = 'BCL' THEN 'BCL Franchise Commercial Payroll Checks'
                                WHEN vPayGroup = 'BCR' THEN 'BCR Retail Payroll Checks'
                                WHEN vPayGroup = 'BCS' THEN 'BCS-Culligan Sales Comp Payroll Checks'
                                WHEN vPayGroup = 'BIH' THEN 'BIH Intl Headquarters Payroll Checks'
                                WHEN vPayGroup = 'BIS1' THEN 'BIS-Industrial Sales Payroll Checks'
                                WHEN vPayGroup = 'BLT' THEN 'BLT-Layton Plant Payroll Checks'
                                WHEN vPayGroup = 'BRF' THEN 'BRF Corporate Transition Payroll Checks'
                                WHEN vPayGroup = 'CWC' THEN 'CWC Payroll Checks'
                                WHEN vPayGroup = 'CWG' THEN 'CWG Weekly Payroll Checks'
                                WHEN vPayGroup = 'FOAM' THEN 'FOAM Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'GTW' THEN 'GTW Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'HYDRO' THEN 'HYDRO Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'LTD' THEN ' Cull Ltd Payroll Checks'
                                WHEN vPayGroup = 'NAR' THEN 'NAR-National Acct Rest Payroll Checks'
                                WHEN vPayGroup = 'OMNI' THEN 'Omnipute Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'QCAN' THEN 'Quench Canada Payroll Checks'
                                WHEN vPayGroup = 'QNYS' THEN ' Quench NYS Weekly Payroll Checks'
                                WHEN vPayGroup = 'QPRC' THEN 'Quench Puerto Rico Payroll Checks'
                                WHEN vPayGroup = 'QUSA' THEN 'Quench USA Payroll Checks'
                                WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
                                WHEN vPayGroup = 'RDL' THEN 'RDL-Water Analysis Lab Payroll Checks'
                                WHEN vPayGroup = 'WATERB' THEN 'WaterCo Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
                                WHEN vPayGroup = 'ZERO' THEN 'Zero Payroll Checks'
                                WHEN vPayGroup = 'ZIP' THEN 'ZIP - US Payroll Checks'
                                END
                                )
                     --   WHEN  sum(vCreditamt) <> '0' THEN dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 ) --'11015050' --dbo.dsi_fnPadZeroS(vPrgDocNo,13,0 )
                           

        -- standard fields above and additional driver fields below
        ,drvCompanyCode4 = ',US01'
        ,drvGLAccount =  CASE WHEN sum(vDebitamt) <> 0.00 THEN '21501001'
                            --  WHEN  sum(vCreditamt) <> '0' THEN '11015050' 
                              END
        ,drvItemText = MAX(
                            CASE--Concat(vPayGroupdesc + 'Payroll Checks')
                                WHEN vPayGroup = 'PGN' THEN 'Paragon Payroll Checks'
                                WHEN vPayGroup = 'CWGB' THEN 'CWG Payroll Checks'
                                WHEN vPayGroup = 'BCC' THEN 'Culligan BCC Payroll Checks'
                                WHEN vPayGroup = 'BLT' THEN 'Culligan BLT Payroll Checks'
                                WHEN vPayGroup = 'EXWT' THEN 'EXWT Payroll Checks'
                                WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
                                WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
                                WHEN vPayGroup = '3003C' THEN '3003C Culligan Canada Payroll Checks'
                                WHEN vPayGroup = 'ACC' THEN 'ACC-Culligan Corporate Payroll Checks'
                                WHEN vPayGroup = 'APEC' THEN 'APEC Biweekly Payroll Checks'
                                WHEN vPayGroup = 'BCI' THEN 'BCI-Culligan Intl Payroll Checks'
                                WHEN vPayGroup = 'BCL' THEN 'BCL Franchise Commercial Payroll Checks'
                                WHEN vPayGroup = 'BCR' THEN 'BCR Retail Payroll Checks'
                                WHEN vPayGroup = 'BCS' THEN 'BCS-Culligan Sales Comp Payroll Checks'
                                WHEN vPayGroup = 'BIH' THEN 'BIH Intl Headquarters Payroll Checks'
                                WHEN vPayGroup = 'BIS1' THEN 'BIS-Industrial Sales Payroll Checks'
                                WHEN vPayGroup = 'BLT' THEN 'BLT-Layton Plant Payroll Checks'
                                WHEN vPayGroup = 'BRF' THEN 'BRF Corporate Transition Payroll Checks'
                                WHEN vPayGroup = 'CWC' THEN 'CWC Payroll Checks'
                                WHEN vPayGroup = 'CWG' THEN 'CWG Weekly Payroll Checks'
                                WHEN vPayGroup = 'FOAM' THEN 'FOAM Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'GTW' THEN 'GTW Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'HYDRO' THEN 'HYDRO Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'LTD' THEN ' Cull Ltd Payroll Checks'
                                WHEN vPayGroup = 'NAR' THEN 'NAR-National Acct Rest Payroll Checks'
                                WHEN vPayGroup = 'OMNI' THEN 'Omnipute Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'QCAN' THEN 'Quench Canada Payroll Checks'
                                WHEN vPayGroup = 'QNYS' THEN ' Quench NYS Weekly Payroll Checks'
                                WHEN vPayGroup = 'QPRC' THEN 'Quench Puerto Rico Payroll Checks'
                                WHEN vPayGroup = 'QUSA' THEN 'Quench USA Payroll Checks'
                                WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
                                WHEN vPayGroup = 'RDL' THEN 'RDL-Water Analysis Lab Payroll Checks'
                                WHEN vPayGroup = 'WATERB' THEN 'WaterCo Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
                                WHEN vPayGroup = 'ZERO' THEN 'Zero Payroll Checks'
                                WHEN vPayGroup = 'ZIP' THEN 'ZIP - US Payroll Checks'
                                END
                     --   WHEN  sum(vCreditamt) <> '0' THEN dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 )-- '11015050' --dbo.dsi_fnPadZeroS(vPrgDocNo,13,0 )
                              )

        ,drvDebit = SUM(CASE WHEN CASE--Concat(vPayGroupdesc + 'Payroll Checks')
                                WHEN vPayGroup = 'PGN' THEN 'Paragon Payroll Checks'
                                WHEN vPayGroup = 'CWGB' THEN 'CWG Payroll Checks'
                                WHEN vPayGroup = 'BCC' THEN 'Culligan BCC Payroll Checks'
                                WHEN vPayGroup = 'BLT' THEN 'Culligan BLT Payroll Checks'
                                WHEN vPayGroup = 'EXWT' THEN 'EXWT Payroll Checks'
                                WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
                                WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
                                WHEN vPayGroup = '3003C' THEN '3003C Culligan Canada Payroll Checks'
                                WHEN vPayGroup = 'ACC' THEN 'ACC-Culligan Corporate Payroll Checks'
                                WHEN vPayGroup = 'APEC' THEN 'APEC Biweekly Payroll Checks'
                                WHEN vPayGroup = 'BCI' THEN 'BCI-Culligan Intl Payroll Checks'
                                WHEN vPayGroup = 'BCL' THEN 'BCL Franchise Commercial Payroll Checks'
                                WHEN vPayGroup = 'BCR' THEN 'BCR Retail Payroll Checks'
                                WHEN vPayGroup = 'BCS' THEN 'BCS-Culligan Sales Comp Payroll Checks'
                                WHEN vPayGroup = 'BIH' THEN 'BIH Intl Headquarters Payroll Checks'
                                WHEN vPayGroup = 'BIS1' THEN 'BIS-Industrial Sales Payroll Checks'
                                WHEN vPayGroup = 'BLT' THEN 'BLT-Layton Plant Payroll Checks'
                                WHEN vPayGroup = 'BRF' THEN 'BRF Corporate Transition Payroll Checks'
                                WHEN vPayGroup = 'CWC' THEN 'CWC Payroll Checks'
                                WHEN vPayGroup = 'CWG' THEN 'CWG Weekly Payroll Checks'
                                WHEN vPayGroup = 'FOAM' THEN 'FOAM Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'GTW' THEN 'GTW Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'HYDRO' THEN 'HYDRO Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'LTD' THEN ' Cull Ltd Payroll Checks'
                                WHEN vPayGroup = 'NAR' THEN 'NAR-National Acct Rest Payroll Checks'
                                WHEN vPayGroup = 'OMNI' THEN 'Omnipute Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'QCAN' THEN 'Quench Canada Payroll Checks'
                                WHEN vPayGroup = 'QNYS' THEN ' Quench NYS Weekly Payroll Checks'
                                WHEN vPayGroup = 'QPRC' THEN 'Quench Puerto Rico Payroll Checks'
                                WHEN vPayGroup = 'QUSA' THEN 'Quench USA Payroll Checks'
                                WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
                                WHEN vPayGroup = 'RDL' THEN 'RDL-Water Analysis Lab Payroll Checks'
                                WHEN vPayGroup = 'WATERB' THEN 'WaterCo Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
                                WHEN vPayGroup = 'ZERO' THEN 'Zero Payroll Checks'
                                WHEN vPayGroup = 'ZIP' THEN 'ZIP - US Payroll Checks'
                                END is not null then vDebitAmt end)
        ,drvCredit = ''--SUM(vCreditAmt)
        ,drvProfitCenter = 'C8010'
        ,drvValueDate = Convert(VARCHAR, MAX(VPaydate), 101)
       -- ,drvHouseBank = ''
       -- ,drvHouseBankAccount = ''
        ,drvAssignmentNumber =  ''--dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 ) --dbo.dsi_fnPadZero(PrgDocNo, 13, 0)--0000000012918 - pad zeroes
        
                                
    INTO dbo.U_ECULSAPPAY_drvTbl_60
      -- FROM dbo.U_ECULSAPPAY_EEList WITH (NOLOCK)
     FROM dbo.vw_dsi_TmpAlloc WITH (NOLOCK)
    --JOIN dbo.U_EGLSAP_PayGroups WITH (NOLOCK)
    --    ON vPayGroup = PayGroup
    LEFT JOIN dbo.GLBAccts WITH (NOLOCK)
        ON GlbBaseSegment = substring(vGLAcctNumber,11,8)
   --Left Join PayReg p On   prggennumber =  vGenNumber     
   JOIN dbo.ChkHead ck WITH (NOLOCK)
        ON ckhgennumber = vGenNumber
        Where vPayGroup IN  ('PGN','CWGB','BCC','BLT','EXWT','RAYNE','WATERC','3003C','ACC','APEC','BCI','BCL','BCR','BCS',
                'BIH','BIS1','BLT','BRF','CWC','CWG','FOAM','GTW','HYDRO','LTD','NAR','OMNI','QCAN','QNYS','QPRC','QUSA','RAYNE','RDL','WATERB','WATERC','ZERO','ZIP')

    GROUP BY   vPayGroup
    Having Sum(vDebitAmt) > 0.00 

    Union

    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort =  CASE-- WHEN sum(vDebitamt) <> '0' THEN '1'
                              WHEN  sum(vCreditamt) <> '0' THEN '2' 
                              END
        ,drvSubSort = CASE
                        WHEN  sum(vCreditamt) <> '0' THEN dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 ) --'11015050' --dbo.dsi_fnPadZeroS(vPrgDocNo,13,0 )
                                END

        -- standard fields above and additional driver fields below
        ,drvCompanyCode4 = ',US01'
        ,drvGLAccount =  CASE --WHEN sum(vDebitamt) <> '0' THEN '21501001'
                              WHEN  sum(vCreditamt) <> '0' THEN '11015050' 
                              END
        ,drvItemText = CASE
                        WHEN  sum(vCreditamt) <> '0' THEN dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 )-- '11015050' --dbo.dsi_fnPadZeroS(vPrgDocNo,13,0 )
                                END

        ,drvDebit = ''--SUM(vDebitAmt)
        ,drvCredit = SUM(vCreditAmt)
        ,drvProfitCenter = 'C8010'
        ,drvValueDate = Convert(VARCHAR, MAX(VPaydate), 101)
       -- ,drvHouseBank = ''
       -- ,drvHouseBankAccount = ''
        ,drvAssignmentNumber = --dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 ) --dbo.dsi_fnPadZero(PrgDocNo, 13, 0)--0000000012918 - pad zeroes
         CASE 
                        WHEN  sum(vCreditamt) <> '0' THEN dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 ) 
                                END
    --INTO dbo.U_ECULSAPPAY_drvTbl_60
      -- FROM dbo.U_ECULSAPPAY_EEList WITH (NOLOCK)
     FROM dbo.vw_dsi_TmpAlloc WITH (NOLOCK)
    --JOIN dbo.U_EGLSAP_PayGroups WITH (NOLOCK)
    --    ON vPayGroup = PayGroup
    LEFT JOIN dbo.GLBAccts WITH (NOLOCK)
        ON GlbBaseSegment = substring(vGLAcctNumber,11,8)
   --Left Join PayReg p On   prggennumber =  vGenNumber     
   JOIN dbo.ChkHead ck WITH (NOLOCK)
        ON ckhgennumber = vGenNumber

    GROUP BY  vPayGroup, ck.ckhrecid
   -- SELECT DISTINCT
   --      drvEEID = ''
   --     ,drvCoID = ''
   --     ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
   --     ,drvInitialSort =  CASE WHEN sum(vDebitamt) <> '0' THEN '1'
   --                           WHEN  sum(vCreditamt) <> '0' THEN '2' 
   --                           END
   --     ,drvSubSort = CASE WHEN SUM(vDebitamt) <> '0' THEN
   --                         CASE--Concat(vPayGroupdesc + 'Payroll Checks')
   --                             WHEN vPayGroup = 'PGN' THEN 'Paragon Payroll Checks'
   --                             WHEN vPayGroup = 'CWGB' THEN 'CWG Payroll Checks'
   --                             WHEN vPayGroup = 'BCC' THEN 'Culligan BCC Payroll Checks'
   --                             WHEN vPayGroup = 'BLT' THEN 'Culligan BLT Payroll Checks'
   --                             WHEN vPayGroup = 'EXWT' THEN 'EXWT Payroll Checks'
   --                             WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
   --                             WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
   --                             WHEN vPayGroup = '3003C' THEN '3003C Culligan Canada Payroll Checks'
   --                             WHEN vPayGroup = 'ACC' THEN 'ACC-Culligan Corporate Payroll Checks'
   --                             WHEN vPayGroup = 'APEC' THEN 'APEC Biweekly Payroll Checks'
   --                             WHEN vPayGroup = 'BCI' THEN 'BCI-Culligan Intl Payroll Checks'
   --                             WHEN vPayGroup = 'BCL' THEN 'BCL Franchise Commercial Payroll Checks'
   --                             WHEN vPayGroup = 'BCR' THEN 'BCR Retail Payroll Checks'
   --                             WHEN vPayGroup = 'BCS' THEN 'BCS-Culligan Sales Comp Payroll Checks'
   --                             WHEN vPayGroup = 'BIH' THEN 'BIH Intl Headquarters Payroll Checks'
   --                             WHEN vPayGroup = 'BIS1' THEN 'BIS-Industrial Sales Payroll Checks'
   --                             WHEN vPayGroup = 'BLT' THEN 'BLT-Layton Plant Payroll Checks'
   --                             WHEN vPayGroup = 'BRF' THEN 'BRF Corporate Transition Payroll Checks'
   --                             WHEN vPayGroup = 'CWC' THEN 'CWC Payroll Checks'
   --                             WHEN vPayGroup = 'CWG' THEN 'CWG Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'FOAM' THEN 'FOAM Bi-Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'GTW' THEN 'GTW Bi-Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'HYDRO' THEN 'HYDRO Bi-Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'LTD' THEN ' Cull Ltd Payroll Checks'
   --                             WHEN vPayGroup = 'NAR' THEN 'NAR-National Acct Rest Payroll Checks'
   --                             WHEN vPayGroup = 'OMNI' THEN 'Omnipute Bi-Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'QCAN' THEN 'Quench Canada Payroll Checks'
   --                             WHEN vPayGroup = 'QNYS' THEN ' Quench NYS Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'QPRC' THEN 'Quench Puerto Rico Payroll Checks'
   --                             WHEN vPayGroup = 'QUSA' THEN 'Quench USA Payroll Checks'
   --                             WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
   --                             WHEN vPayGroup = 'RDL' THEN 'RDL-Water Analysis Lab Payroll Checks'
   --                             WHEN vPayGroup = 'WATERB' THEN 'WaterCo Bi-Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
   --                             WHEN vPayGroup = 'ZERO' THEN 'Zero Payroll Checks'
   --                             WHEN vPayGroup = 'ZIP' THEN 'ZIP - US Payroll Checks'
   --                             END
   --                     WHEN  sum(vCreditamt) <> '0' THEN dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 ) --'11015050' --dbo.dsi_fnPadZeroS(vPrgDocNo,13,0 )
   --                             END

   --     -- standard fields above and additional driver fields below
   --     ,drvCompanyCode4 = ',US01'
   --     ,drvGLAccount =  CASE WHEN sum(vDebitamt) <> '0' THEN '21501001'
   --                           WHEN  sum(vCreditamt) <> '0' THEN '11015050' 
   --                           END
   --     ,drvItemText = CASE WHEN SUM(vDebitamt) <> '0' THEN
   --                         CASE--Concat(vPayGroupdesc + 'Payroll Checks')
   --                             WHEN vPayGroup = 'PGN' THEN 'Paragon Payroll Checks'
   --                             WHEN vPayGroup = 'CWGB' THEN 'CWG Payroll Checks'
   --                             WHEN vPayGroup = 'BCC' THEN 'Culligan BCC Payroll Checks'
   --                             WHEN vPayGroup = 'BLT' THEN 'Culligan BLT Payroll Checks'
   --                             WHEN vPayGroup = 'EXWT' THEN 'EXWT Payroll Checks'
   --                             WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
   --                             WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
   --                             WHEN vPayGroup = '3003C' THEN '3003C Culligan Canada Payroll Checks'
   --                             WHEN vPayGroup = 'ACC' THEN 'ACC-Culligan Corporate Payroll Checks'
   --                             WHEN vPayGroup = 'APEC' THEN 'APEC Biweekly Payroll Checks'
   --                             WHEN vPayGroup = 'BCI' THEN 'BCI-Culligan Intl Payroll Checks'
   --                             WHEN vPayGroup = 'BCL' THEN 'BCL Franchise Commercial Payroll Checks'
   --                             WHEN vPayGroup = 'BCR' THEN 'BCR Retail Payroll Checks'
   --                             WHEN vPayGroup = 'BCS' THEN 'BCS-Culligan Sales Comp Payroll Checks'
   --                             WHEN vPayGroup = 'BIH' THEN 'BIH Intl Headquarters Payroll Checks'
   --                             WHEN vPayGroup = 'BIS1' THEN 'BIS-Industrial Sales Payroll Checks'
   --                             WHEN vPayGroup = 'BLT' THEN 'BLT-Layton Plant Payroll Checks'
   --                             WHEN vPayGroup = 'BRF' THEN 'BRF Corporate Transition Payroll Checks'
   --                             WHEN vPayGroup = 'CWC' THEN 'CWC Payroll Checks'
   --                             WHEN vPayGroup = 'CWG' THEN 'CWG Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'FOAM' THEN 'FOAM Bi-Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'GTW' THEN 'GTW Bi-Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'HYDRO' THEN 'HYDRO Bi-Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'LTD' THEN ' Cull Ltd Payroll Checks'
   --                             WHEN vPayGroup = 'NAR' THEN 'NAR-National Acct Rest Payroll Checks'
   --                             WHEN vPayGroup = 'OMNI' THEN 'Omnipute Bi-Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'QCAN' THEN 'Quench Canada Payroll Checks'
   --                             WHEN vPayGroup = 'QNYS' THEN ' Quench NYS Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'QPRC' THEN 'Quench Puerto Rico Payroll Checks'
   --                             WHEN vPayGroup = 'QUSA' THEN 'Quench USA Payroll Checks'
   --                             WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
   --                             WHEN vPayGroup = 'RDL' THEN 'RDL-Water Analysis Lab Payroll Checks'
   --                             WHEN vPayGroup = 'WATERB' THEN 'WaterCo Bi-Weekly Payroll Checks'
   --                             WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
   --                             WHEN vPayGroup = 'ZERO' THEN 'Zero Payroll Checks'
   --                             WHEN vPayGroup = 'ZIP' THEN 'ZIP - US Payroll Checks'
   --                             END
   --                     WHEN  sum(vCreditamt) <> '0' THEN dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 )-- '11015050' --dbo.dsi_fnPadZeroS(vPrgDocNo,13,0 )
   --                             END

   --     ,drvDebit = SUM(vDebitAmt)
   --     ,drvCredit = SUM(vCreditAmt)
   --     ,drvProfitCenter = 'C8010'
   --     ,drvValueDate = Convert(VARCHAR, MAX(VPaydate), 101)
   --    -- ,drvHouseBank = ''
   --    -- ,drvHouseBankAccount = ''
   --     ,drvAssignmentNumber = --dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 ) --dbo.dsi_fnPadZero(PrgDocNo, 13, 0)--0000000012918 - pad zeroes
   --      CASE WHEN SUM(vDebitamt) <> '0' THEN
   --                         CASE--Concat(vPayGroupdesc + 'Payroll Checks')
   --                             WHEN vPayGroup = 'PGN' THEN ''
   --                             WHEN vPayGroup = 'CWGB' THEN ''
   --                             WHEN vPayGroup = 'BCC' THEN ''
   --                             WHEN vPayGroup = 'BLT' THEN ''
   --                             WHEN vPayGroup = 'EXWT' THEN ''
   --                             WHEN vPayGroup = 'RAYNE' THEN ''
   --                             WHEN vPayGroup = 'WATERC' THEN ''
   --                             WHEN vPayGroup = '3003C' THEN ''
   --                             WHEN vPayGroup = 'ACC' THEN ''
   --                             WHEN vPayGroup = 'APEC' THEN ''
   --                             WHEN vPayGroup = 'BCI' THEN ''
   --                             WHEN vPayGroup = 'BCL' THEN ''
   --                             WHEN vPayGroup = 'BCR' THEN ''
   --                             WHEN vPayGroup = 'BCS' THEN ''
   --                             WHEN vPayGroup = 'BIH' THEN ''
   --                             WHEN vPayGroup = 'BIS1' THEN ''
   --                             WHEN vPayGroup = 'BLT' THEN ''
   --                             WHEN vPayGroup = 'BRF' THEN ''
   --                             WHEN vPayGroup = 'CWC' THEN ''
   --                             WHEN vPayGroup = 'CWG' THEN ''
   --                             WHEN vPayGroup = 'FOAM' THEN ''
   --                             WHEN vPayGroup = 'GTW' THEN ''
   --                             WHEN vPayGroup = 'HYDRO' THEN ''
   --                             WHEN vPayGroup = 'LTD' THEN ' '
   --                             WHEN vPayGroup = 'NAR' THEN ''
   --                             WHEN vPayGroup = 'OMNI' THEN ''
   --                             WHEN vPayGroup = 'QCAN' THEN ''
   --                             WHEN vPayGroup = 'QNYS' THEN ' '
   --                             WHEN vPayGroup = 'QPRC' THEN ''
   --                             WHEN vPayGroup = 'QUSA' THEN ''
   --                             WHEN vPayGroup = 'RAYNE' THEN ''
   --                             WHEN vPayGroup = 'RDL' THEN ''
   --                             WHEN vPayGroup = 'WATERB' THEN ''
   --                             WHEN vPayGroup = 'WATERC' THEN ''
   --                             WHEN vPayGroup = 'ZERO' THEN ''
   --                             WHEN vPayGroup = 'ZIP' THEN ''
   --                             END
   --                     WHEN  sum(vCreditamt) <> '0' THEN dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 ) 
   --                             END
   -- INTO dbo.U_ECULSAPPAY_drvTbl_60
   --   -- FROM dbo.U_ECULSAPPAY_EEList WITH (NOLOCK)
   --  FROM dbo.vw_dsi_TmpAlloc WITH (NOLOCK)
   -- --JOIN dbo.U_EGLSAP_PayGroups WITH (NOLOCK)
   -- --    ON vPayGroup = PayGroup
   -- LEFT JOIN dbo.GLBAccts WITH (NOLOCK)
   --     ON GlbBaseSegment = substring(vGLAcctNumber,11,8)
   ----Left Join PayReg p On   prggennumber =  vGenNumber     
   --JOIN dbo.ChkHead ck WITH (NOLOCK)
   --     ON ckhgennumber = vGenNumber

   -- GROUP BY vGLBaseSeg, vAcctDesc, vGLAcctNumber, GlbBaseSegmentDesc, vGLAcctType, vPayGroup, ck.ckhrecid

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
ALTER VIEW dbo.dsi_vwECULSAPPAY_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECULSAPPAY_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECULSAPPAY%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202308021'
       ,expStartPerControl     = '202308021'
       ,expLastEndPerControl   = '202308099'
       ,expEndPerControl       = '202308099'
WHERE expFormatCode = 'ECULSAPPAY';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECULSAPPAY_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECULSAPPAY_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort desc;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECULSAPPAY' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECULSAPPAY'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECULSAPPAY'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECULSAPPAY', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECULSAPPAY', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECULSAPPAY', 'UseFileName', 'V', 'Y'


-- End ripout