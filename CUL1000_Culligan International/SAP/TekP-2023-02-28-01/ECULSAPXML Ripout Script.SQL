/**********************************************************************************

ECULSAPXML: SAP General Journal Entry XML Export

FormatCode:     ECULSAPXML
Project:        SAP General Journal Entry XML Export
Client ID:      CUL1000
Date/time:      2023-11-20 13:14:49.277
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N23
Server:         N2SUP3DB02
Database:       ULTIPRO_CULLIGAN
Web Filename:   CUL1000_03870_EEHISTORY_ECULSAPXML_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECULSAPXML_SavePath') IS NOT NULL DROP TABLE dbo.U_ECULSAPXML_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECULSAPXML'


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
WHERE FormatCode = 'ECULSAPXML'
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
WHERE ExpFormatCode = 'ECULSAPXML'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECULSAPXML')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECULSAPXML'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECULSAPXML'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECULSAPXML'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECULSAPXML'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECULSAPXML'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECULSAPXML'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECULSAPXML'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECULSAPXML'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECULSAPXML'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECULSAPXML_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECULSAPXML_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECULSAPXML') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECULSAPXML];
GO
IF OBJECT_ID('U_ECULSAPXML_WorkingTbl') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_WorkingTbl];
GO
IF OBJECT_ID('U_ECULSAPXML_Trailer5') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_Trailer5];
GO
IF OBJECT_ID('U_ECULSAPXML_Trailer4') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_Trailer4];
GO
IF OBJECT_ID('U_ECULSAPXML_Trailer3') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_Trailer3];
GO
IF OBJECT_ID('U_ECULSAPXML_Trailer2') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_Trailer2];
GO
IF OBJECT_ID('U_ECULSAPXML_Trailer1') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_Trailer1];
GO
IF OBJECT_ID('U_ECULSAPXML_File') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_File];
GO
IF OBJECT_ID('U_ECULSAPXML_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_EEList];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef9') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef9];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef8') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef8];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef7') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef7];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef6') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef6];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef5') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef5];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef4') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef4];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef3') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef3];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef2') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef2];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef11') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef11];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef10') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef10];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef1') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef1];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_Message4') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_Message4];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_Message3') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_Message3];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_Message2') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_Message2];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_Message1') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_Message1];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_Journal3') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_Journal3];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_Journal2') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_Journal2];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_Journal1') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_Journal1];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_Items') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_Items];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_DebitItems') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_DebitItems];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_Date2') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_Date2];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_Date1') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_Date1];
GO
IF OBJECT_ID('U_ECULSAPXML_drvTbl_CreditItems') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_drvTbl_CreditItems];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECULSAPXML','SAP General Journal Entry XML Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECULSAPXMLZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','100','H','01','1',NULL,'Envelope Header',NULL,NULL,'"<soapenv:Envelope xmlns:soapenv="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECULSAPXMLZ0','50','H','01','2',NULL,'Envelope Header',NULL,NULL,'"http://schemas.xmlsoap.org/soap/envelope/"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECULSAPXMLZ0','50','H','01','3',NULL,'Envelope Header',NULL,NULL,'"xmlns:sfin="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECULSAPXMLZ0','50','H','01','4',NULL,'Envelope Header',NULL,NULL,'"http://sap.com/xi/SAPSCORE/SFIN"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECULSAPXMLZ0','50','H','01','5',NULL,'Envelope Header',NULL,NULL,'">"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','H','02','1',NULL,'FileHeader',NULL,NULL,'"   <soapenv:Header/>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','H','03','1',NULL,'Body Header',NULL,NULL,'"   <soapenv:Body>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','D','10','1',NULL,'Journal entry1',NULL,NULL,'"drvJournalEntry1"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','D','15','1',NULL,'Message Header1',NULL,NULL,'"drvMessage1"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','100','D','20','1',NULL,'Date1',NULL,NULL,'"drvCreateDateTime1"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','D','21','1',NULL,'Message Header2',NULL,NULL,'"drvMessage2"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','D','22','1',NULL,'Journal entry1',NULL,NULL,'"drvJournalEntry2"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','D','25','1',NULL,'Message Header3',NULL,NULL,'"drvMessage3"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','100','D','30','1',NULL,'Date2',NULL,NULL,'"drvCreateDateTime1"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','D','35','1',NULL,'Message Header4',NULL,NULL,'"drvMessage4"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','100','D','40','1',NULL,'Journal entry3',NULL,NULL,'"drvJournalEntry3"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','150','D','41','1',NULL,'Original Ref1',NULL,NULL,'"drvOriginalReferenceDocType"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','150','D','42','1',NULL,'Original Ref2',NULL,NULL,'"drvOriginalReferenceDocument"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','200','D','43','1',NULL,'Original Ref3',NULL,NULL,'"drvOriginalReferenceDocLog"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','100','D','44','1',NULL,'Original Ref4',NULL,NULL,'"drvBusinessTransType"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','100','D','45','1',NULL,'Original Ref5',NULL,NULL,'"drvAcctDocType"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','100','D','46','1',NULL,'Original Ref6',NULL,NULL,'"drvCodHeaderText"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','100','D','47','1',NULL,'Original Ref7',NULL,NULL,'"drvCreateByUser"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','100','D','48','1',NULL,'Original Ref8',NULL,NULL,'"drvCompanyCode1"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','100','D','49','1',NULL,'Original Ref9',NULL,NULL,'"drvDocDate"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','100','D','50','1',NULL,'Original Ref10',NULL,NULL,'"dvrPostDate"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','100','D','51','1',NULL,'Original Ref11',NULL,NULL,'"drvDocRefID"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','D','55','1',NULL,'DebitItems',NULL,NULL,'"drvItem1Debit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECULSAPXMLZ0','150','D','55','2',NULL,'DebitItems',NULL,NULL,'"drvItemCompanyCodeDebit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECULSAPXMLZ0','150','D','55','3',NULL,'DebitItems',NULL,NULL,'"drvGLAcctDebit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECULSAPXMLZ0','150','D','55','4',NULL,'DebitItems',NULL,NULL,'"drvAmtTransCurrDebit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECULSAPXMLZ0','150','D','55','5',NULL,'DebitItems',NULL,NULL,'"drvAmtCompanyCurrDebit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECULSAPXMLZ0','150','D','55','6',NULL,'DebitItems',NULL,NULL,'"drvDocTeextDebit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECULSAPXMLZ0','150','D','55','7',NULL,'DebitItems',NULL,NULL,'"drvAssignRefDebit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECULSAPXMLZ0','150','D','55','8',NULL,'DebitItems',NULL,NULL,'"drvAcctAssignment1Debit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECULSAPXMLZ0','150','D','55','9',NULL,'DebitItems',NULL,NULL,'"drvProfitCenterDebit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECULSAPXMLZ0','150','D','55','10',NULL,'DebitItems',NULL,NULL,'"drvAcctAssignment2Debit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECULSAPXMLZ0','50','D','55','11',NULL,'DebitItems',NULL,NULL,'"drvItem2Debit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','D','60','1',NULL,'DebitItems',NULL,NULL,'"drvItem1Credit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECULSAPXMLZ0','150','D','60','2',NULL,'CreditItems',NULL,NULL,'"drvItemCompanyCodeCredit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECULSAPXMLZ0','150','D','60','3',NULL,'CreditItems',NULL,NULL,'"drvGLAcctCredit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECULSAPXMLZ0','150','D','60','4',NULL,'CreditItems',NULL,NULL,'"drvAmtTransCurrCredit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECULSAPXMLZ0','150','D','60','5',NULL,'CreditItems',NULL,NULL,'"drvAmtCompanyCurrCredit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECULSAPXMLZ0','150','D','60','6',NULL,'CreditItems',NULL,NULL,'"drvDocTeextCredit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECULSAPXMLZ0','150','D','60','7',NULL,'CreditItems',NULL,NULL,'"drvAssignRefCredit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECULSAPXMLZ0','150','D','60','8',NULL,'CreditItems',NULL,NULL,'"drvAcctAssignment1Credit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECULSAPXMLZ0','150','D','60','9',NULL,'CreditItems',NULL,NULL,'"drvProfitCenterCredit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECULSAPXMLZ0','150','D','60','10',NULL,'CreditItems',NULL,NULL,'"drvAcctAssignment2Credit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECULSAPXMLZ0','50','D','60','11',NULL,'CreditItems',NULL,NULL,'"drvItem2Credit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','T','90','1',NULL,'Trailer1',NULL,NULL,'"drvJournalEntry"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','T','91','1',NULL,'Trailer2',NULL,NULL,'"drvJournalCreateReq"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','50','T','92','1',NULL,'Trailer3',NULL,NULL,'"drvJournalBulkEntry"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','51','T','93','1',NULL,'Trailer4',NULL,NULL,'"drvBody"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECULSAPXMLZ0','52','T','94','1',NULL,'Trailer5',NULL,NULL,'"</soapenv:Envelope>"','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECULSAPXML_20231120.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SAP GL XML Export','202311209','EMPEXPORT','ONDEM_XOE',NULL,'ECULSAPXML',NULL,NULL,NULL,'202311209','Nov 20 2023  9:37AM','Nov 20 2023  9:37AM','202311201',NULL,'','','202311201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SAP GL XML Export-Sched','202311209','EMPEXPORT','SCH_ECULSA',NULL,'ECULSAPXML',NULL,NULL,NULL,'202311209','Nov 20 2023  9:37AM','Nov 20 2023  9:37AM','202311201',NULL,'','','202311201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'SAP GL XML Export-Test','202311209','EMPEXPORT','TEST_XOE',NULL,'ECULSAPXML',NULL,NULL,NULL,'202311209','Nov 20 2023  9:37AM','Nov 20 2023  9:37AM','202311201',NULL,'','','202311201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','H02','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','H03','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D10','dbo.U_ECULSAPXML_drvTbl_Journal1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D15','dbo.U_ECULSAPXML_drvTbl_Message1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D20','dbo.U_ECULSAPXML_drvTbl_Date1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D21','dbo.U_ECULSAPXML_drvTbl_Message2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D22','dbo.U_ECULSAPXML_drvTbl_Journal2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D25','dbo.U_ECULSAPXML_drvTbl_Message3',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D30','dbo.U_ECULSAPXML_drvTbl_Date2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D35','dbo.U_ECULSAPXML_drvTbl_Message4',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D40','dbo.U_ECULSAPXML_drvTbl_Journal3',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D41','dbo.U_ECULSAPXML_drvTbl_OrigRef1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D42','dbo.U_ECULSAPXML_drvTbl_OrigRef2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D43','dbo.U_ECULSAPXML_drvTbl_OrigRef3',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D44','dbo.U_ECULSAPXML_drvTbl_OrigRef4',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D45','dbo.U_ECULSAPXML_drvTbl_OrigRef5',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D46','dbo.U_ECULSAPXML_drvTbl_OrigRef6',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D47','dbo.U_ECULSAPXML_drvTbl_OrigRef7',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D48','dbo.U_ECULSAPXML_drvTbl_OrigRef8',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D49','dbo.U_ECULSAPXML_drvTbl_OrigRef9',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D50','dbo.U_ECULSAPXML_drvTbl_OrigRef10',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D51','dbo.U_ECULSAPXML_drvTbl_OrigRef11',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D55','dbo.U_ECULSAPXML_drvTbl_DebitItems',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','D60','dbo.U_ECULSAPXML_drvTbl_CreditItems',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','T90','dbo.U_ECULSAPXML_Trailer1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','T91','dbo.U_ECULSAPXML_Trailer2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','T92','dbo.U_ECULSAPXML_Trailer3',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','T93','dbo.U_ECULSAPXML_Trailer4',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECULSAPXML','T94','dbo.U_ECULSAPXML_Trailer5',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ECULSAPXML_drvTbl_CreditItems
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_CreditItems') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_CreditItems] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvItem1Credit] varchar(21) NULL,
    [drvItemCompanyCodeCredit] varchar(50) NULL,
    [drvGLAcctCredit] varchar(49) NULL,
    [drvAmtTransCurrCredit] nvarchar(4000) NULL,
    [drvAmtCompanyCurrCredit] nvarchar(4000) NULL,
    [drvDocTeextCredit] varchar(49) NULL,
    [drvAssignRefCredit] varchar(91) NULL,
    [drvAcctAssignment1Credit] varchar(38) NULL,
    [drvProfitCenterCredit] varchar(55) NULL,
    [drvAcctAssignment2Credit] varchar(38) NULL,
    [drvItem2Credit] varchar(22) NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_Date1
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_Date1') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_Date1] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCreateDateTime1] varchar(119) NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_Date2
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_Date2') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_Date2] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCreateDateTime1] varchar(122) NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_DebitItems
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_DebitItems') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_DebitItems] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvItem1Debit] varchar(21) NULL,
    [drvItemCompanyCodeDebit] varchar(50) NULL,
    [drvGLAcctDebit] varchar(49) NULL,
    [drvAmtTransCurrDebit] nvarchar(4000) NULL,
    [drvAmtCompanyCurrDebit] nvarchar(4000) NULL,
    [drvDocTeextDebit] varchar(49) NULL,
    [drvAssignRefDebit] varchar(91) NULL,
    [drvAcctAssignment1Debit] varchar(38) NULL,
    [drvProfitCenterDebit] varchar(55) NULL,
    [drvAcctAssignment2Debit] varchar(38) NULL,
    [drvItem2Debit] varchar(22) NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_Items
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_Items') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_Items] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvItem1Debit] varchar(21) NULL,
    [drvItemCompanyCodeDebit] varchar(50) NULL,
    [drvGLAcctDebit] varchar(49) NULL,
    [drvAmtTransCurrDebit] nvarchar(4000) NULL,
    [drvAmtCompanyCurrDebit] nvarchar(4000) NULL,
    [drvDocTeextDebit] varchar(49) NULL,
    [drvAssignRefDebit] varchar(91) NULL,
    [drvAcctAssignment1Debit] varchar(38) NULL,
    [drvProfitCenterDebit] varchar(55) NULL,
    [drvAcctAssignment2Debit] varchar(38) NULL,
    [drvItem2Debit] varchar(22) NULL,
    [drvItem1Credit] varchar(21) NULL,
    [drvItemCompanyCodeCredit] varchar(50) NULL,
    [drvGLAcctCredit] varchar(49) NULL,
    [drvAmtTransCurrCredit] nvarchar(4000) NULL,
    [drvAmtCompanyCurrCredit] nvarchar(4000) NULL,
    [drvDocTeextCredit] varchar(49) NULL,
    [drvAssignRefCredit] varchar(91) NULL,
    [drvAcctAssignment1Credit] varchar(38) NULL,
    [drvProfitCenterCredit] varchar(55) NULL,
    [drvAcctAssignment2Credit] varchar(38) NULL,
    [drvItem2Credit] varchar(22) NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_Journal1
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_Journal1') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_Journal1] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvJournalEntry1] varchar(42) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_Journal2
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_Journal2') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_Journal2] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvJournalEntry2] varchar(37) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_Journal3
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_Journal3') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_Journal3] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvJournalEntry3] varchar(26) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_Message1
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_Message1') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_Message1] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvMessage1] varchar(25) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_Message2
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_Message2') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_Message2] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvMessage2] varchar(25) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_Message3
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_Message3') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_Message3] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvMessage3] varchar(27) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_Message4
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_Message4') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_Message4] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvMessage4] varchar(27) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_OrigRef
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvOriginalReferenceDocType] varchar(83) NOT NULL,
    [drvOriginalReferenceDocument] varchar(88) NOT NULL,
    [drvOriginalReferenceDocLog] varchar(103) NOT NULL,
    [drvBusinessTransType] varchar(70) NOT NULL,
    [drvAcctDocType] varchar(66) NOT NULL,
    [drvCodHeaderText] varchar(70) NOT NULL,
    [drvCreateByUser] varchar(50) NOT NULL,
    [drvCompanyCode1] varchar(46) NOT NULL,
    [drvDocDate] varchar(74) NULL,
    [dvrPostDate] varchar(72) NULL,
    [drvDocRefID] varchar(62) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_OrigRef1
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef1') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef1] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvOriginalReferenceDocType] varchar(83) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_OrigRef10
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef10') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef10] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [dvrPostDate] varchar(52) NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_OrigRef11
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef11') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef11] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDocRefID] varchar(62) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_OrigRef2
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef2') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef2] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvOriginalReferenceDocument] varchar(88) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_OrigRef3
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef3') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef3] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvOriginalReferenceDocLog] varchar(103) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_OrigRef4
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef4') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef4] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvBusinessTransType] varchar(70) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_OrigRef5
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef5') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef5] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvAcctDocType] varchar(66) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_OrigRef6
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef6') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef6] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCodHeaderText] varchar(70) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_OrigRef7
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef7') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef7] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCreateByUser] varchar(50) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_OrigRef8
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef8') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef8] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCompanyCode1] varchar(46) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_drvTbl_OrigRef9
-----------

IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef9') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_drvTbl_OrigRef9] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDocDate] varchar(54) NULL
);

-----------
-- Create table U_ECULSAPXML_EEList
-----------

IF OBJECT_ID('U_ECULSAPXML_EEList') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECULSAPXML_File
-----------

IF OBJECT_ID('U_ECULSAPXML_File') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ECULSAPXML_Trailer1
-----------

IF OBJECT_ID('U_ECULSAPXML_Trailer1') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_Trailer1] (
    [drvJournalEntry] varchar(27) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_Trailer2
-----------

IF OBJECT_ID('U_ECULSAPXML_Trailer2') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_Trailer2] (
    [drvJournalCreateReq] varchar(37) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_Trailer3
-----------

IF OBJECT_ID('U_ECULSAPXML_Trailer3') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_Trailer3] (
    [drvJournalBulkEntry] varchar(43) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_Trailer4
-----------

IF OBJECT_ID('U_ECULSAPXML_Trailer4') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_Trailer4] (
    [drvBody] varchar(18) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_Trailer5
-----------

IF OBJECT_ID('U_ECULSAPXML_Trailer5') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_Trailer5] (
    [drvEND] varchar(19) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_WorkingTbl
-----------

IF OBJECT_ID('U_ECULSAPXML_WorkingTbl') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_WorkingTbl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(31) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvGLAccount] varchar(8) NOT NULL,
    [drvItemText] varchar(39) NULL,
    [drvDebit] decimal NULL,
    [drvCredit] numeric NULL,
    [drvValueDate] varchar(30) NULL,
    [drvAssignmentNumber] varchar(24) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECULSAPXML]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Culligan International

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 11/18/2023
Service Request Number: TekP-2023-02-28-01

Purpose: SAP General Journal Entry XML Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECULSAPXML';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECULSAPXML';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECULSAPXML';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECULSAPXML';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECULSAPXML' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECULSAPXML', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECULSAPXML', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECULSAPXML', 'SCH_ECULSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECULSAPXML', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECULSAPXML';

    -- Declare dates FROM Parameter file
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
    DELETE FROM dbo.U_ECULSAPXML_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECULSAPXML_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    ---Working Table
       IF OBJECT_ID('U_ECULSAPXML_WorkingTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_WorkingTbl;

     SELECT * INTO dbo.U_ECULSAPXML_WorkingTbl
      FROM ( 
      SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''   
        ,drvInitialSort = cast(ck.ckhrecid as varchar) + '1'
        ,drvSubSort = '1' 
        ,drvGLAccount =  '21501001'                                        
        ,drvItemText = CASE WHEN vPayGroup = 'PGN' THEN 'Paragon Payroll Checks'
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
        ,drvDebit = CAST(SUM(vDebitAmt)AS DECIMAL(18,2))
        ,drvCredit = 0.00 --SUM(vCreditAmt)
        ,drvValueDate = Convert(VARCHAR, MAX(VPaydate), 120)  
        ,drvAssignmentNumber = ''      
     FROM dbo.vw_dsi_TmpAlloc WITH (NOLOCK)
    LEFT JOIN dbo.GLBAccts WITH (NOLOCK)
        ON GlbBaseSegment = substring(vGLAcctNumber,11,8)
   JOIN dbo.ChkHead ck WITH (NOLOCK)
        ON ckhgennumber = vGenNumber
    GROUP BY   vPayGroup, ck.ckhrecid
    Having Round(SUM(vdebitAmt),2) <> 0.00 
    
    
    Union

      SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvInitialSort =  cast(ck.ckhrecid as varchar) + '2'
        ,drvSubSort = '2'
        ,drvGLAccount =   '11015050'                               
        ,drvItemText =  '11015050'                              
        ,drvDebit =  0.00 --SUM(vDebitAmt)
        ,drvCredit = CAst(SUM(vCreditAmt) AS DECIMAL(18,2))
        ,drvValueDate = Convert(VARCHAR, MAX(VPaydate), 120)
        ,drvAssignmentNumber =  dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 )
     FROM dbo.vw_dsi_TmpAlloc WITH (NOLOCK)
    LEFT JOIN dbo.GLBAccts WITH (NOLOCK)
        ON GlbBaseSegment = substring(vGLAcctNumber,11,8)
   JOIN dbo.ChkHead ck WITH (NOLOCK)
        ON ckhgennumber = vGenNumber
    GROUP BY ck.ckhrecid
    
    having Round(SUM(vCreditAmt),2) <> 0.00 ) w
    ;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_Journal1
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_Journal1','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_Journal1;
    SELECT DISTINCT
         drvEEID = ''-- xEEID
        ,drvCoID =''-- xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvJournalEntry1 = '      <sfin:JournalEntryBulkCreateRequest>'
    INTO dbo.U_ECULSAPXML_drvTbl_Journal1
    FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_Message1
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_Message1','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_Message1;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvMessage1 = '          <MessageHeader>'
    INTO dbo.U_ECULSAPXML_drvTbl_Message1
  --  FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;

        ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_Journal2
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_Journal2','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_Journal2;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvJournalEntry2 = '          <JournalEntryCreateRequest>'
    INTO dbo.U_ECULSAPXML_drvTbl_Journal2
   -- FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)

    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_Date1
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_Date1','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_Date1;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvCreateDateTime1 = '            ' + '<CreationDateTime>' + Convert(varchar, GetDate(), 23) + 'T' + convert(varchar, getdate(), 108) + '.1234567Z</CreationDateTime>'
    INTO dbo.U_ECULSAPXML_drvTbl_Date1
    --FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_Message2
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_Message2','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_Message2;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvMessage2 = '          ' + '<MessageHeader>'
    INTO dbo.U_ECULSAPXML_drvTbl_Message2
    --FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)

      ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_Journal2
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_Journal2','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_Journal2;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvJournalEntry2 = '          <JournalEntryCreateRequest>'
    INTO dbo.U_ECULSAPXML_drvTbl_Journal2
  --  FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_Message3
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_Message3','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_Message3;
    SELECT DISTINCT
         drvEEID =''-- xEEID
        ,drvCoID =''-- xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvMessage3 = '            <MessageHeader>'
    INTO dbo.U_ECULSAPXML_drvTbl_Message3
  --  FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)

    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_Date2
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_Date2','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_Date2;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvCreateDateTime1 = '               ' + '<CreationDateTime>' + Convert(varchar, GetDate(), 23) + 'T' + convert(varchar, getdate(), 108) + '.1234567Z</CreationDateTime>'
    INTO dbo.U_ECULSAPXML_drvTbl_Date2
  --  FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_Message4
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_Message4','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_Message4;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvMessage4 = '            ' + '<MessageHeader>'
    INTO dbo.U_ECULSAPXML_drvTbl_Message4
    FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_Journal3
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_Journal3','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_Journal3;
    SELECT DISTINCT
           drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvJournalEntry3 = '            ' + '<JournalEntry>'
    INTO dbo.U_ECULSAPXML_drvTbl_Journal3
    FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)



        ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_OrigRef1
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef1','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_OrigRef1;
    SELECT DISTINCT
         drvEEID =''-- xEEID
        ,drvCoID = ''--xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvOriginalReferenceDocType = '               ' + '<OriginalReferenceDocumentType>' + 'BKPFF' + '</OriginalReferenceDocumentType>'
    INTO dbo.U_ECULSAPXML_drvTbl_OrigRef1
  --  FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_OrigRef2
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef2','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_OrigRef2;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvOriginalReferenceDocument = '               ' + '<OriginalReferenceDocument>' + 'TESTOriginalRefDoc' + '</OriginalReferenceDocument>'
    INTO dbo.U_ECULSAPXML_drvTbl_OrigRef2
   -- FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_OrigRef3
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef3','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_OrigRef3;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
     --   ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvOriginalReferenceDocLog = '               ' + '<OriginalReferenceDocumentLogicalSystem>' + '0LELAAS' + '</OriginalReferenceDocumentLogicalSystem>'
    INTO dbo.U_ECULSAPXML_drvTbl_OrigRef3
   -- FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_OrigRef4
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef4','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_OrigRef4;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvBusinessTransType = Concat('               ' + '<BusinessTransactionType>' , 'RFBU' , '</BusinessTransactionType>')
    INTO dbo.U_ECULSAPXML_drvTbl_OrigRef4
 --   FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_OrigRef5
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef5','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_OrigRef5;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvAcctDocType = '               ' + '<AccountingDocumentType>' + 'SI' + '</AccountingDocumentType>'
    INTO dbo.U_ECULSAPXML_drvTbl_OrigRef5
   -- FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_OrigRef6
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef6','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_OrigRef6;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvCodHeaderText = '               ' + '<DocumentHeaderText>' + 'Payroll Checks' + '</DocumentHeaderText>'
    INTO dbo.U_ECULSAPXML_drvTbl_OrigRef6
  --  FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_OrigRef7
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef7','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_OrigRef7;
    SELECT DISTINCT
         drvEEID =''-- xEEID
        ,drvCoID = ''--xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvCreateByUser = '               ' + '<CreatedByUser>' + 'TEST' + '</CreatedByUser>'
    INTO dbo.U_ECULSAPXML_drvTbl_OrigRef7
   -- FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_OrigRef8
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef8','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_OrigRef8;
    SELECT DISTINCT
         drvEEID = ''-- xEEID
        ,drvCoID = ''--xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvCompanyCode1 = '               ' + '<CompanyCode>' + 'US01' + '</CompanyCode>'
    INTO dbo.U_ECULSAPXML_drvTbl_OrigRef8
   -- FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_OrigRef9
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef9','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_OrigRef9;
    SELECT DISTINCT
         drvEEID = ''-- xEEID
        ,drvCoID = ''--xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvDocDate = '               ' + '<DocumentDate>' + CONVERT(VARCHAR(10),drvValueDate,120) + '</DocumentDate>'
    INTO dbo.U_ECULSAPXML_drvTbl_OrigRef9
     --   --FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    FROM dbo.U_ECULSAPXML_WorkingTbl
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_OrigRef10
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef10','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_OrigRef10;
    SELECT DISTINCT
         drvEEID = ''-- xEEID
        ,drvCoID = ''--xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,dvrPostDate = '               ' + '<PostingDate>' + CONVERT(VARCHAR(10),drvValueDate,120) + '</PostingDate>'
    INTO dbo.U_ECULSAPXML_drvTbl_OrigRef10
     --   --FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    FROM dbo.U_ECULSAPXML_WorkingTbl
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_OrigRef11
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef11','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_OrigRef11;
    SELECT DISTINCT
         drvEEID = ''-- xEEID
        ,drvCoID = ''--xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvDocRefID = '               ' + '<DocumentReferenceID>' + '1508' + '</DocumentReferenceID>'
    INTO dbo.U_ECULSAPXML_drvTbl_OrigRef11
   -- FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    ;
 --   ---------------------------------
 --   -- DETAIL RECORD - U_ECULSAPXML_drvTbl_OrigRef
 --   ---------------------------------
 --   IF OBJECT_ID('U_ECULSAPXML_drvTbl_OrigRef','U') IS NOT NULL
 --       DROP TABLE dbo.U_ECULSAPXML_drvTbl_OrigRef;
 --   SELECT DISTINCT
 --        drvEEID = ''--xEEID
 --       ,drvCoID = ''--xCoID
 --       --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
 --       ,drvInitialSort = ''
 --       ,drvSubSort = ''
 --       -- standard fields above and additional driver fields below
 --       ,drvOriginalReferenceDocType = '               ' + '<OriginalReferenceDocumentType>' + 'BKPFF' + '</OriginalReferenceDocumentType>'
 --       ,drvOriginalReferenceDocument = '               ' + '<OriginalReferenceDocument>' + 'TESTOriginalRefDoc' + '</OriginalReferenceDocument>'
 --       ,drvOriginalReferenceDocLog = '               ' + '<OriginalReferenceDocumentLogicalSystem>' + '0LELAAS' + '</OriginalReferenceDocumentLogicalSystem>'
 --       ,drvBusinessTransType =  Concat('               ' + '<BusinessTransactionType>' , 'RFBU' , '</BusinessTransactionType>')
 --       ,drvAcctDocType = '               ' + '<AccountingDocumentType>' + 'SI' + '</AccountingDocumentType>'
 --       ,drvCodHeaderText = '               ' + '<DocumentHeaderText>' + 'Payroll Checks' + '</DocumentHeaderText>'
 --       ,drvCreateByUser = '               ' + '<CreatedByUser>' + 'TEST' + '</CreatedByUser>'
 --       ,drvCompanyCode1 = '               ' + '<CompanyCode>' + 'US01' + '</CompanyCode>'
 --       ,drvDocDate =  '               ' + '<DocumentDate>' + drvValueDate + '</DocumentDate>'
 --       ,dvrPostDate = '               ' + '<PostingDate>' + drvValueDate + '</PostingDate>'
 --       ,drvDocRefID = '               ' + '<DocumentReferenceID>' + '1508' + '</DocumentReferenceID>'
 --   INTO dbo.U_ECULSAPXML_drvTbl_OrigRef
 --   --FROM dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    --FROM dbo.U_ECULSAPXML_WorkingTbl
 --   ;
  
        ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_DebitItems
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_DebitItems','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_DebitItems;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvItem1Debit = CASE WHEN FORMAT(drvDebit, '#.##' )  <> '0.00' THEN '               <Item>' END
        ,drvItemCompanyCodeDebit = CASE WHEN FORMAT(drvDebit, '#.##' )  <> '0.00' THEN '                   <CompanyCode>' + 'US01' + '</CompanyCode>' END
        ,drvGLAcctDebit = CASE WHEN FORMAT(drvDebit, '#.##' )  <> '0.00' THEN '                  <GLAccount>' + '21501001' + '</GLAccount>' END
        ,drvAmtTransCurrDebit = CASE WHEN FORMAT(drvDebit, '#.##' )  <> '0.00' THEN '                  <AmountInTransactionCurrency currencyCode="USD">' +  FORMAT(drvDebit, '#.##' ) + '</AmountInTransactionCurrency currencyCode="USD">' END
        ,drvAmtCompanyCurrDebit = CASE WHEN FORMAT(drvDebit, '#.##' )  <> '0.00' THEN '                  <AmountInCompanyCodeCurrency currencyCode ="USD">' + FORMAT(drvDebit, '#.##')  + '</AmountInCompanyCodeCurrency currencyCode="USD">' END
        ,drvDocTeextDebit = CASE WHEN FORMAT(drvDebit, '#.##' )  <> '0.00' THEN '          '+  drvItemText END
        ,drvAssignRefDebit = CASE WHEN FORMAT(drvDebit, '#.##' )  <> '0.00' THEN '                  ' + '<AssignmentReference>' + LTRIM(RTRIM(cast(drvAssignmentNumber as varchar))) + '</AssignmentReference>' END
        ,drvAcctAssignment1Debit = CASE WHEN FORMAT(drvDebit, '#.##' )  <> '0.00' THEN '                   <AccountAssignment>' END
        ,drvProfitCenterDebit = CASE WHEN FORMAT(drvDebit, '#.##' )  <> '0.00' THEN '                     ' + '<ProfitCenter>' + 'C8010' + '</ProfitCenter>' END
        ,drvAcctAssignment2Debit = CASE WHEN FORMAT(drvDebit, '#.##' )  <> '0.00' THEN '                  </AccountAssignment>' END
        ,drvItem2Debit =  CASE WHEN FORMAT(drvDebit, '#.##' )  <> '0.00' THEN '               </Item>' END
    INTO dbo.U_ECULSAPXML_drvTbl_DebitItems
    FROM --dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    dbo.U_ECULSAPXML_WorkingTbl WITH (NOLOCK)
    Where drvDebit  <>  0.00
    

    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECULSAPXML_drvTbl_CreditItems
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_drvTbl_CreditItems','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_drvTbl_CreditItems;
    SELECT DISTINCT
         drvEEID = ''--xEEID
        ,drvCoID = ''--xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
         ,drvItem1Credit =  CASE WHEN FORMAT(drvCredit, '#.##' )  <> '0.00' THEN '               <Item>' END
        ,drvItemCompanyCodeCredit =  CASE WHEN FORMAT(drvCredit, '#.##' )  <> '0.00' THEN'                   <CompanyCode>' + 'US01' + '</CompanyCode>' END
        ,drvGLAcctCredit = CASE WHEN FORMAT(drvCredit, '#.##' )  <> '0.00' THEN'                  <GLAccount>' +  '11015050'  + '</GLAccount>' END
        ,drvAmtTransCurrCredit = CASE WHEN FORMAT(drvCredit, '#.##' )  <> '0.00' THEN '                  <AmountInTransactionCurrency currencyCode="USD">' + FORMAT(drvCredit, '#.##')  + '</AmountInTransactionCurrency currencyCode="USD">' END
        ,drvAmtCompanyCurrCredit = CASE WHEN FORMAT(drvCredit, '#.##' )  <> '0.00' THEN  '                  <AmountInCompanyCodeCurrency currencyCode ="USD">' +  FORMAT(drvCredit, '#.##')   + '</AmountInCompanyCodeCurrency currencyCode="USD">' END
        ,drvDocTeextCredit = CASE WHEN FORMAT(drvCredit, '#.##' )  <> '0.00' THEN  '          ' +  drvItemText END
        ,drvAssignRefCredit = CASE WHEN FORMAT(drvCredit, '#.##' )  <> '0.00' THEN '                  ' + '<AssignmentReference>' + LTRIM(RTRIM(cast(drvAssignmentNumber as varchar))) + '</AssignmentReference>' END
        ,drvAcctAssignment1Credit = CASE WHEN FORMAT(drvCredit, '#.##' )  <> '0.00' THEN '                   <AccountAssignment>' END
        ,drvProfitCenterCredit = CASE WHEN FORMAT(drvCredit, '#.##' )  <> '0.00' THEN '                     ' + '<ProfitCenter>' + 'C8010' + '</ProfitCenter>' END
        ,drvAcctAssignment2Credit = CASE WHEN FORMAT(drvCredit, '#.##' )  <> '0.00' THEN '                  </AccountAssignment>' END
        ,drvItem2Credit = CASE WHEN FORMAT(drvCredit, '#.##' )  <> '0.00' THEN '               </Item>' END
    INTO dbo.U_ECULSAPXML_drvTbl_CreditItems
    FROM --dbo.U_ECULSAPXML_EEList WITH (NOLOCK)
    dbo.U_ECULSAPXML_WorkingTbl WITH (NOLOCK)
    Where drvCredit <> 0.00
    ;

    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_Trailer1','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_Trailer1;
    SELECT DISTINCT
         drvJournalEntry = '            </JournalEntry>'
    INTO dbo.U_ECULSAPXML_Trailer1
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_Trailer2','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_Trailer2;
    SELECT DISTINCT
         drvJournalCreateReq = '         </JournalEntryCreateRequest>'
    INTO dbo.U_ECULSAPXML_Trailer2
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_Trailer3','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_Trailer3;
    SELECT DISTINCT
         drvJournalBulkEntry = '      </sfin:JournalEntryBulkCreateRequest>'
    INTO dbo.U_ECULSAPXML_Trailer3
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_Trailer4','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_Trailer4;
    SELECT DISTINCT
         drvBody = '   </soapenv:Body>'
    INTO dbo.U_ECULSAPXML_Trailer4
    ;

      ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECULSAPXML_Trailer5','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_Trailer5;
    SELECT DISTINCT
         drvEND = '</soapenv:Envelope>'
    INTO dbo.U_ECULSAPXML_Trailer5
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
ALTER VIEW dbo.dsi_vwECULSAPXML_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECULSAPXML_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECULSAPXML%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202311111'
       ,expStartPerControl     = '202311111'
       ,expLastEndPerControl   = '202311189'
       ,expEndPerControl       = '202311189'
WHERE expFormatCode = 'ECULSAPXML';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECULSAPXML_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECULSAPXML_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECULSAPXML' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECULSAPXML'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECULSAPXML'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECULSAPXML', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECULSAPXML', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECULSAPXML', 'UseFileName', 'V', 'Y'


-- End ripout