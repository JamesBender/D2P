/**********************************************************************************

ELKD365TAX: Dynamics 365 Payroll Tax

FormatCode:     ELKD365TAX
Project:        Dynamics 365 Payroll Tax
Client ID:      LAI1001
Date/time:      2023-08-03 11:04:17.947
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB03
Database:       ULTIPRO_WPLAIKA
Web Filename:   LAI1001_K8KNG_EEHISTORY_ELKD365TAX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ELKD365TAX_SavePath') IS NOT NULL DROP TABLE dbo.U_ELKD365TAX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ELKD365TAX'


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
WHERE FormatCode = 'ELKD365TAX'
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
WHERE ExpFormatCode = 'ELKD365TAX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ELKD365TAX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ELKD365TAX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ELKD365TAX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ELKD365TAX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ELKD365TAX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ELKD365TAX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ELKD365TAX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ELKD365TAX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ELKD365TAX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ELKD365TAX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwELKD365TAX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELKD365TAX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELKD365TAX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELKD365TAX];
GO
IF OBJECT_ID('U_ELKD365TAX_WorkingTbl') IS NOT NULL DROP TABLE [dbo].[U_ELKD365TAX_WorkingTbl];
GO
IF OBJECT_ID('U_ELKD365TAX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ELKD365TAX_Trailer];
GO
IF OBJECT_ID('U_ELKD365TAX_Header') IS NOT NULL DROP TABLE [dbo].[U_ELKD365TAX_Header];
GO
IF OBJECT_ID('U_ELKD365TAX_File') IS NOT NULL DROP TABLE [dbo].[U_ELKD365TAX_File];
GO
IF OBJECT_ID('U_ELKD365TAX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELKD365TAX_EEList];
GO
IF OBJECT_ID('U_ELKD365TAX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELKD365TAX_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELKD365TAX','Dynamics 365 Payroll Tax','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ELKD365TAXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELKD365TAXZ0','50','H','01','1',NULL,'JOURNALNAME',NULL,NULL,'"JOURNALNAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELKD365TAXZ0','50','H','01','2',NULL,'DESCRIPTION',NULL,NULL,'"DESCRIPTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELKD365TAXZ0','50','H','01','3',NULL,'VOUCHER',NULL,NULL,'"VOUCHER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELKD365TAXZ0','50','H','01','4',NULL,'DOCUMENTDATE',NULL,NULL,'"DOCUMENTDATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELKD365TAXZ0','50','H','01','5',NULL,'TRANSDATE',NULL,NULL,'"TRANSDATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELKD365TAXZ0','50','H','01','6',NULL,'DEBITAMOUNT',NULL,NULL,'"DEBITAMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELKD365TAXZ0','50','H','01','7',NULL,'CREDITAMOUNT',NULL,NULL,'"CREDITAMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELKD365TAXZ0','50','H','01','8',NULL,'ACCOUNTDISPLAYVALUE',NULL,NULL,'"ACCOUNTDISPLAYVALUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELKD365TAXZ0','50','H','01','9',NULL,'DEFAULTDIMENSIONDISPLAYVALUE',NULL,NULL,'"DEFAULTDIMENSIONDISPLAYVALUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELKD365TAXZ0','50','H','01','10',NULL,'TEXT',NULL,NULL,'"TEXT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELKD365TAXZ0','50','H','01','11',NULL,'REVERSEDATE',NULL,NULL,'"REVERSEDATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELKD365TAXZ0','50','H','01','12',NULL,'REVERSEENTRY',NULL,NULL,'"REVERSEENTRY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELKD365TAXZ0','50','H','01','13',NULL,'JOURNALBATCHNUMBER',NULL,NULL,'"JOURNALBATCHNUMBER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELKD365TAXZ0','50','H','01','14',NULL,'ACCOUNTTYPE',NULL,NULL,'"ACCOUNTTYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELKD365TAXZ0','50','H','01','15',NULL,'CURRENCYCODE',NULL,NULL,'"CURRENCYCODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELKD365TAXZ0','50','H','01','16',NULL,'EXCHANGERATE',NULL,NULL,'"EXCHANGERATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELKD365TAXZ0','50','H','01','17',NULL,'DCVAMCOMPANY',NULL,NULL,'"DCVAMCOMPANY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELKD365TAXZ0','50','H','01','18',NULL,'LINENUMBER',NULL,NULL,'"LINENUMBER"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELKD365TAXZ0','50','D','10','1',NULL,'JOURNALNAME',NULL,NULL,'"JECASH"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELKD365TAXZ0','50','D','10','2',NULL,'DESCRIPTION',NULL,NULL,'"drvDescription"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELKD365TAXZ0','50','D','10','3',NULL,'VOUCHER',NULL,NULL,'"1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELKD365TAXZ0','50','D','10','4',NULL,'DOCUMENTDATE',NULL,NULL,'"drvDocumentDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELKD365TAXZ0','50','D','10','5',NULL,'TRANSDATE',NULL,NULL,'"drvTransDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELKD365TAXZ0','50','D','10','6',NULL,'DEBITAMOUNT',NULL,NULL,'"drvDebitAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELKD365TAXZ0','50','D','10','7',NULL,'CREDITAMOUNT',NULL,NULL,'"drvCreditAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELKD365TAXZ0','50','D','10','8',NULL,'ACCOUNTDISPLAYVALUE',NULL,NULL,'"drvAccountDisplayValue"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELKD365TAXZ0','50','D','10','9',NULL,'DEFAULTDIMENSIONDISPLAYVALUE',NULL,NULL,'"drvDefaultDimensionDisplayVal"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELKD365TAXZ0','50','D','10','10',NULL,'TEXT',NULL,NULL,'"drvText"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELKD365TAXZ0','50','D','10','11',NULL,'REVERSEDATE',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELKD365TAXZ0','50','D','10','12',NULL,'REVERSEENTRY',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELKD365TAXZ0','50','D','10','13',NULL,'JOURNALBATCHNUMBER',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELKD365TAXZ0','50','D','10','14',NULL,'ACCOUNTTYPE',NULL,NULL,'"drvAccountType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELKD365TAXZ0','50','D','10','15',NULL,'CURRENCYCODE',NULL,NULL,'"USD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELKD365TAXZ0','50','D','10','16',NULL,'EXCHANGERATE',NULL,NULL,'"100"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELKD365TAXZ0','50','D','10','17',NULL,'DCVAMCOMPANY',NULL,NULL,'"LINC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELKD365TAXZ0','50','D','10','18',NULL,'LINENUMBER',NULL,NULL,'"drvLineNumber"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELKD365TAXZ0','50','T','90','1',NULL,'JOURNALNAME',NULL,NULL,'"JECASH"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELKD365TAXZ0','50','T','90','2',NULL,'DESCRIPTION',NULL,NULL,'"drvDescription"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELKD365TAXZ0','50','T','90','3',NULL,'VOUCHER',NULL,NULL,'"1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELKD365TAXZ0','50','T','90','4',NULL,'DOCUMENTDATE',NULL,NULL,'"drvDocumentDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELKD365TAXZ0','50','T','90','5',NULL,'TRANSDATE',NULL,NULL,'"drvTransDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELKD365TAXZ0','50','T','90','6',NULL,'DEBITAMOUNT',NULL,NULL,'"drvDebitAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELKD365TAXZ0','50','T','90','7',NULL,'CREDITAMOUNT',NULL,NULL,'"drvCreditAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELKD365TAXZ0','50','T','90','8',NULL,'ACCOUNTDISPLAYVALUE',NULL,NULL,'"drvAccountDisplayValue"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELKD365TAXZ0','50','T','90','9',NULL,'DEFAULTDIMENSIONDISPLAYVALUE',NULL,NULL,'"drvDefaultDimensionDisplayVal"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELKD365TAXZ0','50','T','90','10',NULL,'TEXT',NULL,NULL,'"drvText"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELKD365TAXZ0','50','T','90','11',NULL,'REVERSEDATE',NULL,NULL,'""','(''SS''=''T'',)');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELKD365TAXZ0','50','T','90','12',NULL,'REVERSEENTRY',NULL,NULL,'""','(''SS''=''T'',)');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELKD365TAXZ0','50','T','90','13',NULL,'JOURNALBATCHNUMBER',NULL,NULL,'""','(''SS''=''T'',)');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELKD365TAXZ0','50','T','90','14',NULL,'ACCOUNTTYPE',NULL,NULL,'"BANK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELKD365TAXZ0','50','T','90','15',NULL,'CURRENCYCODE',NULL,NULL,'"USD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELKD365TAXZ0','50','T','90','16',NULL,'EXCHANGERATE',NULL,NULL,'"100"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELKD365TAXZ0','50','T','90','17',NULL,'DCVAMCOMPANY',NULL,NULL,'"LINC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELKD365TAXZ0','50','T','90','18',NULL,'LINENUMBER',NULL,NULL,'"drvLineNumber"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ELKD365TAX_20230803.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dynamics 365 Payroll Tax','202308039','EMPEXPORT','ONDEM_XOE',NULL,'ELKD365TAX',NULL,NULL,NULL,'202308039','Aug  3 2023 10:52AM','Aug  3 2023 10:52AM','202308031',NULL,'','','202308031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dynamics 365 Payroll Tax-Sched','202308039','EMPEXPORT','SCH_ELKD36',NULL,'ELKD365TAX',NULL,NULL,NULL,'202308039','Aug  3 2023 10:52AM','Aug  3 2023 10:52AM','202308031',NULL,'','','202308031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Dynamics 365 Payroll Tax-Test','202307219','EMPEXPORT','TEST_XOE',NULL,'ELKD365TAX',NULL,NULL,NULL,'202307219','Aug  3 2023 10:52AM','Aug  3 2023 10:52AM','202307081',NULL,'','','202307081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365TAX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365TAX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365TAX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365TAX','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365TAX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365TAX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365TAX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELKD365TAX','H01','dbo.U_ELKD365TAX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELKD365TAX','D10','dbo.U_ELKD365TAX_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELKD365TAX','T90','dbo.U_ELKD365TAX_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ELKD365TAX_drvTbl
-----------

IF OBJECT_ID('U_ELKD365TAX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELKD365TAX_drvTbl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDescription] varchar(104) NOT NULL,
    [drvDocumentDate] varchar(30) NULL,
    [drvTransDate] varchar(30) NULL,
    [drvDebitAmount] money NULL,
    [drvCreditAmount] money NULL,
    [drvAccountDisplayValue] varchar(8000) NULL,
    [drvDefaultDimensionDisplayVal] varchar(8000) NULL,
    [drvText] varchar(102) NOT NULL,
    [drvAccountType] varchar(6) NOT NULL,
    [drvLineNumber] bigint IDENTITY(1,1) NOT NULL
);

-----------
-- Create table U_ELKD365TAX_EEList
-----------

IF OBJECT_ID('U_ELKD365TAX_EEList') IS NULL
CREATE TABLE [dbo].[U_ELKD365TAX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ELKD365TAX_File
-----------

IF OBJECT_ID('U_ELKD365TAX_File') IS NULL
CREATE TABLE [dbo].[U_ELKD365TAX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_ELKD365TAX_Header
-----------

IF OBJECT_ID('U_ELKD365TAX_Header') IS NULL
CREATE TABLE [dbo].[U_ELKD365TAX_Header] (
    [drvOFFSETDFLTDIMENVALUE] varchar(1) NOT NULL,
    [OFFSETTEXT] varchar(1) NOT NULL
);

-----------
-- Create table U_ELKD365TAX_Trailer
-----------

IF OBJECT_ID('U_ELKD365TAX_Trailer') IS NULL
CREATE TABLE [dbo].[U_ELKD365TAX_Trailer] (
    [drvDescription] varchar(104) NULL,
    [drvDocumentDate] varchar(30) NULL,
    [drvTransDate] varchar(30) NULL,
    [drvDebitAmount] money NULL,
    [drvCreditAmount] money NULL,
    [drvAccountDisplayValue] varchar(32) NOT NULL,
    [drvDefaultDimensionDisplayVal] varchar(32) NOT NULL,
    [drvText] varchar(1) NOT NULL,
    [drvLineNumber] int NULL
);

-----------
-- Create table U_ELKD365TAX_WorkingTbl
-----------

IF OBJECT_ID('U_ELKD365TAX_WorkingTbl') IS NULL
CREATE TABLE [dbo].[U_ELKD365TAX_WorkingTbl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDescription] varchar(104) NOT NULL,
    [drvDocumentDate] varchar(30) NULL,
    [drvTransDate] varchar(30) NULL,
    [drvDebitAmount] money NULL,
    [drvCreditAmount] money NULL,
    [drvAccountDisplayValue] varchar(8000) NULL,
    [drvDefaultDimensionDisplayVal] varchar(8000) NULL,
    [drvText] varchar(102) NOT NULL,
    [drvAccountType] varchar(6) NOT NULL,
    [drvLineNumber] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELKD365TAX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Laika 

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 08/02/2023
Service Request Number: TekP-2023-02-23-04

Purpose: Dynamics 365 Payroll Tax

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELKD365TAX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELKD365TAX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELKD365TAX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELKD365TAX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELKD365TAX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELKD365TAX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELKD365TAX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELKD365TAX', 'SCH_ELKD36';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ELKD365TAX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELKD365TAX';

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
    DELETE FROM dbo.U_ELKD365TAX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELKD365TAX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Working Table
    --==========================================

    IF OBJECT_ID('dbo.U_ELKD365TAX_WorkingTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELKD365TAX_WorkingTbl;

         SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2'
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvDescription = Concat('UKG', cast(Month(MAX(VPercontrolDate))as varchar) +'/',cast(YEAR(Max(VPercontrolDate))as varchar),'_PR-TAX_', 'PP',cast(datepart(wk,max(VPercontrolDate))/2 as varchar) )
        ,drvDocumentDate = Convert(varchar,Max(vPaydate), 101) 
        ,drvTransDate = Convert(varchar,Max(vPaydate), 101) --Convert(varchar,MAX(vPeriodEndDate), 101)
        ,drvDebitAmount = sum(vDebitAmt)
        ,drvCreditAmount = ''
        ,drvAccountDisplayValue = MAX(Concat(RTRIM(vGLBaseSeg),'.',RTRIM(vOrgLvl1Seg) ,'.',RTRIM(vOrgLvl2Seg),'.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
        ,drvDefaultDimensionDisplayVal = MAX(Concat(RTRIM(vGLBaseSeg),'.',RTRIM(vOrgLvl1Seg) ,'.',RTRIM(vOrgLvl2Seg),'.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
        ,drvText = Concat(Convert(varchar, MAX(vPeriodStartDate), 101),'-',convert(Varchar, Max(vPeriodEndDate), 101) ,'_',max(VAcctDesc))
        ,drvAccountType = 'LEDGER'
        ,drvLineNumber = ''--ROW_NUMBER() OVER(ORDER BY (count(*)) ASC)
    INTO dbo.U_ELKD365TAX_WorkingTbl
    FROM --dbo.U_ELKD365TAX_EEList WITH (NOLOCK)
      dbo.vw_Dsi_Tmpalloc With (Nolock) 
     Where vGLAcctNumber <> 'NOGL'  AND vGLCodetype IN ('TE', 'TL') --vGLCodetype IN ('DE', 'DR')
     --AND Convert(varchar,vPaydate, 112) between Convert(varchar, @StartDate,112) and Convert(varchar, @EndDate,112)
     AND Convert(varchar,vPeriodstartdate, 112) = Convert(varchar, @StartDate,112) and vPeriodEndDate = Convert(varchar, @EndDate,112) 
      Group by vEmpNo, LEFT(vGLAcctNumber,11)
     having  sum(vDebitAmt) <> 0

     Union

         SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvDescription = Concat('UKG', cast(Month(MAX(VPercontrolDate))as varchar) +'/',cast(YEAR(Max(VPercontrolDate))as varchar),'_PR-TAX_', 'PP',cast(datepart(wk,max(VPercontrolDate))/2 as varchar) )
        ,drvDocumentDate = Convert(varchar,Max(vPaydate), 101) 
        ,drvTransDate = Convert(varchar,Max(vPaydate), 101) --Convert(varchar,MAX(vPeriodEndDate), 101)
        ,drvDebitAmount = ''
        ,drvCreditAmount = Sum(vCreditAmt)
        ,drvAccountDisplayValue = MAX(Concat(RTRIM(vGLBaseSeg),'.',RTRIM(vOrgLvl1Seg) ,'.',RTRIM(vOrgLvl2Seg),'.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
        ,drvDefaultDimensionDisplayVal = MAX(Concat(RTRIM(vGLBaseSeg),'.',RTRIM(vOrgLvl1Seg) ,'.',RTRIM(vOrgLvl2Seg),'.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
        ,drvText = Concat(Convert(varchar, MAX(vPeriodStartDate), 101),'-',convert(Varchar, Max(vPeriodEndDate), 101) ,'_',max(VAcctDesc))
        ,drvAccountType = 'LEDGER'--CASE WHEN Sum(vCreditAmt) > 0  THEN 'BANK' END
        ,drvLineNumber = ''-- ROW_NUMBER() OVER(ORDER BY (count(*)) ASC)
    --INTO dbo.U_ELKD365TAX_drvTbl
    FROM --dbo.U_ELKD365TAX_EEList WITH (NOLOCK)
      dbo.vw_Dsi_Tmpalloc With (Nolock) 
     Where vGLAcctNumber <> 'NOGL'and  vGLCodetype IN ('TE', 'TL') --vGLCodetype IN ('DE', 'DR')
     --AND Convert(varchar,vPaydate, 112) between Convert(varchar, @StartDate,112) and Convert(varchar, @EndDate,112)
     AND Convert(varchar,vPeriodstartdate, 112) = Convert(varchar, @StartDate,112) and vPeriodEndDate = Convert(varchar, @EndDate,112) 
     Group by vEmpNo, LEFT(vGLAcctNumber,11)
     having  Sum(vCreditAmt) <> 0.00

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELKD365TAX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELKD365TAX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELKD365TAX_drvTbl;
   
   
   SELECT 
         drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort
        ,drvDescription 
        ,drvDocumentDate 
        ,drvTransDate 
        ,drvDebitAmount 
        ,drvCreditAmount 
        ,drvAccountDisplayValue 
        ,drvDefaultDimensionDisplayVal
        ,drvText 
        ,drvAccountType 
        ,IDENTITY(bigint, 1, 1) as drvLineNumber
     

    INTO dbo.U_ELKD365TAX_drvTbl
    FROM dbo.U_ELKD365TAX_WorkingTbl


         ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ELKD365TAX_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ELKD365TAX_Trailer;
    SELECT DISTINCT
         drvDescription = MAX(drvDescription )
        ,drvDocumentDate = MAX(drvDocumentDate)
        ,drvTransDate = MAX(drvTransDate)
        ,drvDebitAmount = SUM(drvDebitAmount)
        ,drvCreditAmount = SUm(drvCreditAmount)
        ,drvAccountDisplayValue = 'Cash - Bank of America - Payroll'
        ,drvDefaultDimensionDisplayVal = 'Cash - Bank of America - Payroll'
        ,drvText = ''
        ,drvLineNumber = (Select Count(*) from dbo.U_ELKD365TAX_WorkingTbl)
    INTO dbo.U_ELKD365TAX_Trailer
    FROm dbo.U_ELKD365TAX_WorkingTbl
      
     
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
ALTER VIEW dbo.dsi_vwELKD365TAX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELKD365TAX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ELKD365TAX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202307081'
       ,expStartPerControl     = '202307081'
       ,expLastEndPerControl   = '202307219'
       ,expEndPerControl       = '202307219'
WHERE expFormatCode = 'ELKD365TAX' and expexportcode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELKD365TAX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELKD365TAX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ELKD365TAX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ELKD365TAX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ELKD365TAX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELKD365TAX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ELKD365TAX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELKD365TAX', 'UseFileName', 'V', 'Y'


-- End ripout