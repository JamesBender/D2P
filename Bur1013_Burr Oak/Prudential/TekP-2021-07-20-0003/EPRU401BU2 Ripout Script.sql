/**********************************************************************************

EPRU401BU2: Prudential 401K V2

FormatCode:     EPRU401BU2
Project:        Prudential 401K V2
Client ID:      BUR1013
Date/time:      2021-11-09 11:57:37.307
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW1WUP5DB02
Database:       ULTIPRO_WPBUO
Web Filename:   BUR1013_GOSU2_EEHISTORY_EPRU401BU2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPRU401BU2_SavePath') IS NOT NULL DROP TABLE dbo.U_EPRU401BU2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPRU401BU2'


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
WHERE FormatCode = 'EPRU401BU2'
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
WHERE ExpFormatCode = 'EPRU401BU2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPRU401BU2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPRU401BU2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPRU401BU2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPRU401BU2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPRU401BU2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPRU401BU2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPRU401BU2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPRU401BU2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPRU401BU2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPRU401BU2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPRU401BU2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPRU401BU2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPRU401BU2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRU401BU2];
GO
IF OBJECT_ID('U_EPRU401BU2_File') IS NOT NULL DROP TABLE [dbo].[U_EPRU401BU2_File];
GO
IF OBJECT_ID('U_EPRU401BU2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPRU401BU2_EEList];
GO
IF OBJECT_ID('U_EPRU401BU2_AudFieldList') IS NOT NULL DROP TABLE [dbo].[U_EPRU401BU2_AudFieldList];
GO
IF OBJECT_ID('U_dsi_EPRU401BU2_trlTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EPRU401BU2_trlTbl];
GO
IF OBJECT_ID('U_dsi_EPRU401BU2_loanTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EPRU401BU2_loanTbl];
GO
IF OBJECT_ID('U_dsi_EPRU401BU2_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EPRU401BU2_hdrTbl];
GO
IF OBJECT_ID('U_dsi_EPRU401BU2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EPRU401BU2_drvTbl];
GO
IF OBJECT_ID('U_ds_EPRU401BU2_Gennumber') IS NOT NULL DROP TABLE [dbo].[U_ds_EPRU401BU2_Gennumber];
GO
IF OBJECT_ID('U_ds_EPRU401BU2_Earns') IS NOT NULL DROP TABLE [dbo].[U_ds_EPRU401BU2_Earns];
GO
IF OBJECT_ID('U_ds_EPRU401BU2_EarnHist') IS NOT NULL DROP TABLE [dbo].[U_ds_EPRU401BU2_EarnHist];
GO
IF OBJECT_ID('U_ds_EPRU401BU2_DefEarnHist') IS NOT NULL DROP TABLE [dbo].[U_ds_EPRU401BU2_DefEarnHist];
GO
IF OBJECT_ID('U_ds_EPRU401BU2_DefEarn') IS NOT NULL DROP TABLE [dbo].[U_ds_EPRU401BU2_DefEarn];
GO
IF OBJECT_ID('U_ds_EPRU401BU2_deds') IS NOT NULL DROP TABLE [dbo].[U_ds_EPRU401BU2_deds];
GO
IF OBJECT_ID('U_ds_EPRU401BU2_AuditInfo') IS NOT NULL DROP TABLE [dbo].[U_ds_EPRU401BU2_AuditInfo];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','EPRU401BU2','Prudential 401K V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','701','S','N','EPRU401BU2Z0','N','Apr 25 2019  9:22AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRU401BU2Z0','3','H','01','1',NULL,NULL,NULL,NULL,'"drvRecType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRU401BU2Z0','10','H','01','4',NULL,NULL,NULL,NULL,'"drvFileType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRU401BU2Z0','10','H','01','14',NULL,NULL,NULL,NULL,'"drvClientID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRU401BU2Z0','8','H','01','24',NULL,NULL,NULL,NULL,'"drvCreationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRU401BU2Z0','6','H','01','32',NULL,NULL,NULL,NULL,'"drvCreationTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRU401BU2Z0','1','H','01','38',NULL,NULL,NULL,NULL,'"drvSender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRU401BU2Z0','3','H','01','39',NULL,NULL,NULL,NULL,'"drvFileFormatType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRU401BU2Z0','660','H','01','42',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRU401BU2Z0','3','D','02','1',NULL,NULL,NULL,NULL,'"drvTransactionCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRU401BU2Z0','2','D','02','4',NULL,NULL,NULL,NULL,'"drvSequenceCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRU401BU2Z0','6','D','02','6',NULL,NULL,NULL,NULL,'"drvPlanNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRU401BU2Z0','3','D','02','12',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRU401BU2Z0','9','D','02','15',NULL,NULL,NULL,NULL,'"drvParticipantID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRU401BU2Z0','11','D','02','24',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRU401BU2Z0','1','D','02','35',NULL,NULL,NULL,NULL,'"drvFTPTInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRU401BU2Z0','2','D','02','36',NULL,NULL,NULL,NULL,'"drvInvestment1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRU401BU2Z0','1','D','02','38',NULL,NULL,NULL,NULL,'"drvSource1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRU401BU2Z0','9','D','02','39',NULL,NULL,NULL,NULL,'"drvContribAmount1"','(''UNPn''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRU401BU2Z0','2','D','02','48',NULL,NULL,NULL,NULL,'"drvInvestment2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRU401BU2Z0','1','D','02','50',NULL,NULL,NULL,NULL,'"drvSource2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRU401BU2Z0','9','D','02','51',NULL,NULL,NULL,NULL,'"drvContribAmount2"','(''UNPn''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRU401BU2Z0','2','D','02','60',NULL,NULL,NULL,NULL,'"drvInvestment3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRU401BU2Z0','1','D','02','62',NULL,NULL,NULL,NULL,'"drvSource3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRU401BU2Z0','9','D','02','63',NULL,NULL,NULL,NULL,'"drvContribAmount3"','(''UNPn''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRU401BU2Z0','2','D','02','72',NULL,NULL,NULL,NULL,'"drvInvestment4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRU401BU2Z0','1','D','02','74',NULL,NULL,NULL,NULL,'"drvSource4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRU401BU2Z0','9','D','02','75',NULL,NULL,NULL,NULL,'"drvContribAmount4"','(''UNPn''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRU401BU2Z0','2','D','02','84',NULL,NULL,NULL,NULL,'"drvInvestment5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRU401BU2Z0','1','D','02','86',NULL,NULL,NULL,NULL,'"drvSource5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRU401BU2Z0','9','D','02','87',NULL,NULL,NULL,NULL,'"drvContribAmount5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRU401BU2Z0','2','D','02','96',NULL,NULL,NULL,NULL,'"drvInvestment6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRU401BU2Z0','1','D','02','98',NULL,NULL,NULL,NULL,'"drvSource6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRU401BU2Z0','9','D','02','99',NULL,NULL,NULL,NULL,'"drvContribAmount6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRU401BU2Z0','8','D','02','108',NULL,NULL,NULL,NULL,'"drvPeriodEndDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRU401BU2Z0','1','D','02','116',NULL,NULL,NULL,NULL,'"drvInsiderTrader"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRU401BU2Z0','4','D','02','117',NULL,NULL,NULL,NULL,'"drvSubPlanNo"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRU401BU2Z0','30','D','02','121',NULL,NULL,NULL,NULL,'"drvName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPRU401BU2Z0','30','D','02','151',NULL,NULL,NULL,NULL,'"drvAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPRU401BU2Z0','30','D','02','181',NULL,NULL,NULL,NULL,'"drvAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPRU401BU2Z0','18','D','02','211',NULL,NULL,NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPRU401BU2Z0','2','D','02','229',NULL,NULL,NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPRU401BU2Z0','9','D','02','231',NULL,NULL,NULL,NULL,'"drvZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPRU401BU2Z0','8','D','02','240',NULL,NULL,NULL,NULL,'"drvDOB"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPRU401BU2Z0','8','D','02','248',NULL,NULL,NULL,NULL,'"drvOrigHireDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPRU401BU2Z0','8','D','02','256',NULL,NULL,NULL,NULL,'"drvAdjHireDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPRU401BU2Z0','1','D','02','264',NULL,NULL,NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPRU401BU2Z0','1','D','02','265',NULL,NULL,NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPRU401BU2Z0','2','D','02','266',NULL,NULL,NULL,NULL,'"drvEEStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPRU401BU2Z0','8','D','02','268',NULL,NULL,NULL,NULL,'"drvEmpStatusDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPRU401BU2Z0','1','D','02','276',NULL,NULL,NULL,NULL,'"drvPayrollFreq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPRU401BU2Z0','8','D','02','277',NULL,NULL,NULL,NULL,'"drvServiceYears"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPRU401BU2Z0','6','D','02','285',NULL,NULL,NULL,NULL,'"drvYTDHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPRU401BU2Z0','6','D','02','291',NULL,NULL,NULL,NULL,'"drvCurrPeriodHours"','(''UNPn''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPRU401BU2Z0','15','D','02','297',NULL,NULL,NULL,NULL,'"drvCurrPeriodGross"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPRU401BU2Z0','15','D','02','312',NULL,NULL,NULL,NULL,'"drvCurrEligGrossPay1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPRU401BU2Z0','11','D','02','327',NULL,NULL,NULL,NULL,'"drvCurrPeriodW2"','(''UNPn''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPRU401BU2Z0','8','D','02','338',NULL,NULL,NULL,NULL,'"drvAnnivDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPRU401BU2Z0','6','D','02','346',NULL,NULL,NULL,NULL,'"drvAnnivHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPRU401BU2Z0','8','D','02','352',NULL,NULL,NULL,NULL,'"drvCheckDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPRU401BU2Z0','13','D','02','360',NULL,NULL,NULL,NULL,'"drvEmpIDCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPRU401BU2Z0','4','D','02','373',NULL,NULL,NULL,NULL,'"drvDivSub"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EPRU401BU2Z0','10','D','02','377',NULL,NULL,NULL,NULL,'"drvEmpLocationCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EPRU401BU2Z0','8','D','02','387',NULL,NULL,NULL,NULL,'"drvLocEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EPRU401BU2Z0','1','D','02','395',NULL,NULL,NULL,NULL,'"drvGroupInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EPRU401BU2Z0','10','D','02','396',NULL,NULL,NULL,NULL,'"drvNeverElig"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EPRU401BU2Z0','5','D','02','406',NULL,NULL,NULL,NULL,'"drvEligForEE1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EPRU401BU2Z0','5','D','02','411',NULL,NULL,NULL,NULL,'"drvEligForEE2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EPRU401BU2Z0','8','D','02','416',NULL,NULL,NULL,NULL,'"drvEligDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EPRU401BU2Z0','1','D','02','424',NULL,NULL,NULL,NULL,'"drvAutoEnrollDecline"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EPRU401BU2Z0','5','D','02','425',NULL,NULL,NULL,NULL,'"drvDeferralRate1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EPRU401BU2Z0','15','D','02','430',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EPRU401BU2Z0','11','D','02','445',NULL,NULL,NULL,NULL,'"drvCashBonus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EPRU401BU2Z0','1','D','02','456',NULL,NULL,NULL,NULL,'"drvHCEInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EPRU401BU2Z0','1','D','02','457',NULL,NULL,NULL,NULL,'"drvUnionEmployee"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EPRU401BU2Z0','11','D','02','458',NULL,NULL,NULL,NULL,'"drvMarketSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EPRU401BU2Z0','8','D','02','469',NULL,NULL,NULL,NULL,'"drvRehireDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EPRU401BU2Z0','15','D','02','477',NULL,NULL,NULL,NULL,'"drvPPDGrossPay"','(''UNPn''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EPRU401BU2Z0','1','D','02','492',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EPRU401BU2Z0','15','D','02','493',NULL,NULL,NULL,NULL,'"drvDeferralPlanLimitComp"','(''UNPn''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EPRU401BU2Z0','1','D','02','508',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EPRU401BU2Z0','15','D','02','509',NULL,NULL,NULL,NULL,'"drvCurrEligGrossPay2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EPRU401BU2Z0','1','D','02','524',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EPRU401BU2Z0','15','D','02','525',NULL,NULL,NULL,NULL,'"drvADPPLanComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EPRU401BU2Z0','1','D','02','540',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EPRU401BU2Z0','15','D','02','541',NULL,NULL,NULL,NULL,'"drvCurrEligGrossPay3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EPRU401BU2Z0','1','D','02','556',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EPRU401BU2Z0','15','D','02','557',NULL,NULL,NULL,NULL,'"drvERMatchComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EPRU401BU2Z0','1','D','02','572',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EPRU401BU2Z0','11','D','02','573',NULL,NULL,NULL,NULL,'"drvACPComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EPRU401BU2Z0','1','D','02','584',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EPRU401BU2Z0','11','D','02','585',NULL,NULL,NULL,NULL,'"drvExcludedComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EPRU401BU2Z0','1','D','02','596',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EPRU401BU2Z0','11','D','02','597',NULL,NULL,NULL,NULL,'"drvTopHeavyComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EPRU401BU2Z0','1','D','02','608',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EPRU401BU2Z0','11','D','02','609',NULL,NULL,NULL,NULL,'"drvEEPostTaxComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EPRU401BU2Z0','1','D','02','620',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EPRU401BU2Z0','2','D','02','621',NULL,NULL,NULL,NULL,'"drvSubStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EPRU401BU2Z0','1','D','02','623',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EPRU401BU2Z0','8','D','02','624',NULL,NULL,NULL,NULL,'"drvSubStatusDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EPRU401BU2Z0','40','D','02','632',NULL,NULL,NULL,NULL,'"drvEmailAddr"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EPRU401BU2Z0','1','D','02','672',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EPRU401BU2Z0','17','D','02','673',NULL,NULL,NULL,NULL,'"drvBankNoEFT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EPRU401BU2Z0','1','D','02','690',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EPRU401BU2Z0','9','D','02','691',NULL,NULL,NULL,NULL,'"drvBankABANoEFT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EPRU401BU2Z0','1','D','02','700',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EPRU401BU2Z0','1','D','02','701',NULL,NULL,NULL,NULL,'"drvBankAcctType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRU401BU2Z0','3','D','03','1',NULL,NULL,NULL,NULL,'"drvTransactionCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRU401BU2Z0','2','D','03','4',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRU401BU2Z0','6','D','03','6',NULL,NULL,NULL,NULL,'"drvPlanNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRU401BU2Z0','3','D','03','12',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRU401BU2Z0','9','D','03','15',NULL,NULL,NULL,NULL,'"drvParticipantID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRU401BU2Z0','6','D','03','24',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRU401BU2Z0','1','D','03','30',NULL,NULL,NULL,NULL,'"drvDateExpectedOverride"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRU401BU2Z0','3','D','03','31',NULL,NULL,NULL,NULL,'"drvLoanNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRU401BU2Z0','1','D','03','34',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRU401BU2Z0','9','D','03','35',NULL,NULL,NULL,NULL,'"drvLoanRepaymentAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRU401BU2Z0','10','D','03','44',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRU401BU2Z0','1','D','03','54',NULL,NULL,NULL,NULL,'"drvLoanRepaymentOverride"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRU401BU2Z0','3','D','03','55',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRU401BU2Z0','4','D','03','58',NULL,NULL,NULL,NULL,'"drvLoanPayrollCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRU401BU2Z0','19','D','03','62',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRU401BU2Z0','4','D','03','81',NULL,NULL,NULL,NULL,'"drvSubPlanNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRU401BU2Z0','617','D','03','85',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRU401BU2Z0','3','D','04','1',NULL,NULL,NULL,NULL,'"drvTransactionCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRU401BU2Z0','2','D','04','4',NULL,NULL,NULL,NULL,'"drvSequenceCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRU401BU2Z0','6','D','04','6',NULL,NULL,NULL,NULL,'"drvDCPlanNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRU401BU2Z0','3','D','04','12',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRU401BU2Z0','9','D','04','15',NULL,NULL,NULL,NULL,'"drvParticipantID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRU401BU2Z0','12','D','04','24',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRU401BU2Z0','8','D','04','36',NULL,NULL,NULL,NULL,'"drvPeriodEndDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRU401BU2Z0','73','D','04','44',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRU401BU2Z0','4','D','04','117',NULL,NULL,NULL,NULL,'"drvSubPlanNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRU401BU2Z0','8','D','04','121',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRU401BU2Z0','1','D','04','129',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRU401BU2Z0','30','D','04','130',NULL,NULL,NULL,NULL,'"drvEmployerName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRU401BU2Z0','12','D','04','160',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRU401BU2Z0','11','D','04','172',NULL,NULL,NULL,NULL,'"drvMemberHoursPaid"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRU401BU2Z0','8','D','04','183',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRU401BU2Z0','8','D','04','191',NULL,NULL,NULL,NULL,'"drvWorkEndDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRU401BU2Z0','1','D','04','199',NULL,NULL,NULL,NULL,'"drvSourceCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRU401BU2Z0','4','D','04','200',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRU401BU2Z0','11','D','04','204',NULL,NULL,NULL,NULL,'"drvAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRU401BU2Z0','487','D','04','215',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRU401BU2Z0','3','D','05','1',NULL,NULL,NULL,NULL,'"drvRecType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRU401BU2Z0','10','D','05','4',NULL,NULL,NULL,NULL,'"drvFileType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRU401BU2Z0','10','D','05','14',NULL,NULL,NULL,NULL,'"drvClientID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRU401BU2Z0','8','D','05','24',NULL,NULL,NULL,NULL,'"drvFileCreateDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRU401BU2Z0','6','D','05','32',NULL,NULL,NULL,NULL,'"drvFileCreateTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRU401BU2Z0','9','D','05','38',NULL,NULL,NULL,NULL,'"drvDetailRecCount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRU401BU2Z0','1','D','05','47',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRU401BU2Z0','11','D','05','48',NULL,NULL,NULL,NULL,'"drvTotalContribAmt"','(''UNPn''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRU401BU2Z0','1','D','05','59',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRU401BU2Z0','11','D','05','60',NULL,NULL,NULL,NULL,'"drvLoanRepaymentAmt"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRU401BU2Z0','631','D','05','71',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPRU401BU2_20211109.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'L3T5V',NULL,NULL,NULL,'Prudential 401K','201908301','EMPEXPORT','EPRU401BU2','Aug 27 2019 12:00AM','EPRU401BU2',NULL,NULL,NULL,'201908301','Aug 30 2019 12:00AM','Aug 24 2019 12:00AM','201908301',NULL,'eecPayGroup','BOT','201908301',dbo.fn_GetTimedKey(),NULL,'ULTI_WPBUO',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','L3T5V,L3TU6,JOCUJ',NULL,NULL,NULL,'TEST Prudential 401K','202106251','EMPEXPORT','TEST','Sep 27 2021 10:11AM','EPRU401BU2',NULL,NULL,NULL,'202106251','Jun 25 2021 12:00AM','Jun 19 2021 12:00AM','202106251','403','eecPayGroup','BOTSAL,BOT,OPS,OTS1','202106251',dbo.fn_GetTimedKey(),NULL,'us3rVaBUR1013',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','ExportDescription','C','Prudential 401K');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','FileType','C','txt');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','InitialSort','C','drvParticipantID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','MaxFileLength','C','2000');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','SystemID','V','2A4D46F27874');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRU401BU2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRU401BU2','H01','dbo.U_dsi_EPRU401BU2_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRU401BU2','D02','dbo.U_dsi_EPRU401BU2_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRU401BU2','D03','dbo.U_dsi_EPRU401BU2_loanTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRU401BU2','D04','x','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRU401BU2','D05','dbo.U_dsi_EPRU401BU2_trlTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ds_EPRU401BU2_AuditInfo
-----------

IF OBJECT_ID('U_ds_EPRU401BU2_AuditInfo') IS NULL
CREATE TABLE [dbo].[U_ds_EPRU401BU2_AuditInfo] (
    [eeid] varchar(255) NULL,
    [coid] varchar(255) NULL,
    [auditdate] datetime NULL,
    [statusflag] varchar(1) NULL
);

-----------
-- Create table U_ds_EPRU401BU2_deds
-----------

IF OBJECT_ID('U_ds_EPRU401BU2_deds') IS NULL
CREATE TABLE [dbo].[U_ds_EPRU401BU2_deds] (
    [drvssn] char(11) NULL,
    [dssn] char(11) NULL,
    [dEEID] char(12) NOT NULL,
    [dEndDate] varchar(8) NULL,
    [ddedcode] char(5) NOT NULL,
    [damount] money NULL,
    [deeamount] money NULL,
    [deramount] money NULL
);

-----------
-- Create table U_ds_EPRU401BU2_DefEarn
-----------

IF OBJECT_ID('U_ds_EPRU401BU2_DefEarn') IS NULL
CREATE TABLE [dbo].[U_ds_EPRU401BU2_DefEarn] (
    [deeid] char(12) NULL,
    [decoid] char(5) NULL,
    [deamt] money NULL,
    [dehrs] decimal NULL
);

-----------
-- Create table U_ds_EPRU401BU2_DefEarnHist
-----------

IF OBJECT_ID('U_ds_EPRU401BU2_DefEarnHist') IS NULL
CREATE TABLE [dbo].[U_ds_EPRU401BU2_DefEarnHist] (
    [deeid] char(12) NULL,
    [decoid] char(5) NULL,
    [deamt] money NULL,
    [dehrs] decimal NULL
);

-----------
-- Create table U_ds_EPRU401BU2_EarnHist
-----------

IF OBJECT_ID('U_ds_EPRU401BU2_EarnHist') IS NULL
CREATE TABLE [dbo].[U_ds_EPRU401BU2_EarnHist] (
    [eeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [eamt] money NULL,
    [ehrs] decimal NULL
);

-----------
-- Create table U_ds_EPRU401BU2_Earns
-----------

IF OBJECT_ID('U_ds_EPRU401BU2_Earns') IS NULL
CREATE TABLE [dbo].[U_ds_EPRU401BU2_Earns] (
    [drvssn] char(11) NULL,
    [essnum] char(11) NULL,
    [eEEID] char(12) NOT NULL,
    [ehrs] decimal NULL,
    [eamt] money NULL,
    [eytdgross] decimal NULL,
    [edate] varchar(8) NULL
);

-----------
-- Create table U_ds_EPRU401BU2_Gennumber
-----------

IF OBJECT_ID('U_ds_EPRU401BU2_Gennumber') IS NULL
CREATE TABLE [dbo].[U_ds_EPRU401BU2_Gennumber] (
    [eeid] char(12) NOT NULL,
    [coid] char(5) NOT NULL,
    [gennumber] char(12) NOT NULL
);

-----------
-- Create table U_dsi_EPRU401BU2_drvTbl
-----------

IF OBJECT_ID('U_dsi_EPRU401BU2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EPRU401BU2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvTransactionCode] varchar(3) NOT NULL,
    [drvSequenceCode] varchar(1) NOT NULL,
    [drvPlanNo] varchar(6) NOT NULL,
    [drvParticipantID] char(11) NULL,
    [drvFTPTInd] varchar(1) NOT NULL,
    [drvInvestment1] varchar(2) NOT NULL,
    [drvSource1] varchar(1) NOT NULL,
    [drvContribAmount1] money NULL,
    [drvInvestment2] varchar(2) NOT NULL,
    [drvSource2] varchar(1) NOT NULL,
    [drvContribAmount2] money NULL,
    [drvInvestment3] varchar(2) NOT NULL,
    [drvSource3] varchar(1) NOT NULL,
    [drvContribAmount3] money NULL,
    [drvInvestment4] varchar(2) NOT NULL,
    [drvSource4] varchar(1) NOT NULL,
    [drvContribAmount4] varchar(1) NOT NULL,
    [drvInvestment5] varchar(1) NOT NULL,
    [drvSource5] varchar(1) NOT NULL,
    [drvContribAmount5] varchar(1) NOT NULL,
    [drvInvestment6] varchar(1) NOT NULL,
    [drvSource6] varchar(1) NOT NULL,
    [drvContribAmount6] varchar(1) NOT NULL,
    [drvPeriodEndDate] datetime NULL,
    [drvInsiderTrader] varchar(1) NOT NULL,
    [drvSubPlanNo] varchar(30) NULL,
    [drvName] varchar(204) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZIP] varchar(50) NULL,
    [drvDOB] datetime NULL,
    [drvOrigHireDate] datetime NULL,
    [drvAdjHireDate] int NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvEEStatus] varchar(2) NOT NULL,
    [drvEmpStatusDate] datetime NULL,
    [drvPayrollFreq] varchar(1) NOT NULL,
    [drvServiceYears] varchar(1) NOT NULL,
    [drvYTDHours] varchar(1) NOT NULL,
    [drvCurrPeriodHours] decimal NOT NULL,
    [drvCurrPeriodGross] varchar(1) NOT NULL,
    [drvCurrEligGrossPay1] varchar(1) NOT NULL,
    [drvCurrPeriodW2] varchar(1) NOT NULL,
    [drvAnnivDate] varchar(1) NOT NULL,
    [drvAnnivHours] varchar(1) NOT NULL,
    [drvCheckDate] datetime NULL,
    [drvEmpIDCode] char(9) NULL,
    [drvDivSub] varchar(10) NULL,
    [drvEmpLocationCode] varchar(1) NOT NULL,
    [drvLocEffDate] varchar(1) NOT NULL,
    [drvGroupInd] varchar(1) NOT NULL,
    [drvNeverElig] varchar(1) NOT NULL,
    [drvEligForEE1] varchar(1) NOT NULL,
    [drvEligForEE2] varchar(1) NOT NULL,
    [drvEligDate] varchar(1) NOT NULL,
    [drvAutoEnrollDecline] varchar(1) NOT NULL,
    [drvDeferralRate1] varchar(1) NOT NULL,
    [drvCashBonus] varchar(1) NOT NULL,
    [drvHCEInd] varchar(1) NOT NULL,
    [drvUnionEmployee] varchar(1) NOT NULL,
    [drvMarketSalary] varchar(30) NULL,
    [drvRehireDate] datetime NULL,
    [drvPPDGrossPay] money NULL,
    [drvDeferralPlanLimitComp] money NOT NULL,
    [drvCurrEligGrossPay2] varchar(1) NOT NULL,
    [drvADPPLanComp] varchar(1) NOT NULL,
    [drvCurrEligGrossPay3] varchar(1) NOT NULL,
    [drvERMatchComp] varchar(1) NOT NULL,
    [drvACPComp] varchar(1) NOT NULL,
    [drvExcludedComp] varchar(1) NOT NULL,
    [drvTopHeavyComp] varchar(1) NOT NULL,
    [drvEEPostTaxComp] varchar(1) NOT NULL,
    [drvSubStatus] varchar(2) NULL,
    [drvSubStatusDate] datetime NULL,
    [drvEmailAddr] varchar(50) NULL,
    [drvBankNoEFT] varchar(1) NOT NULL,
    [drvBankABANoEFT] varchar(1) NOT NULL,
    [drvBankAcctType] varchar(1) NOT NULL
);

-----------
-- Create table U_dsi_EPRU401BU2_hdrTbl
-----------

IF OBJECT_ID('U_dsi_EPRU401BU2_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EPRU401BU2_hdrTbl] (
    [drvRecType] varchar(3) NOT NULL,
    [drvFileType] varchar(8) NOT NULL,
    [drvClientID] varchar(6) NOT NULL,
    [drvCreationDate] datetime NOT NULL,
    [drvCreationTime] varchar(8000) NULL,
    [drvSender] varchar(1) NOT NULL,
    [drvFileFormatType] varchar(3) NOT NULL
);

-----------
-- Create table U_dsi_EPRU401BU2_loanTbl
-----------

IF OBJECT_ID('U_dsi_EPRU401BU2_loanTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EPRU401BU2_loanTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvTransactionCode] varchar(3) NOT NULL,
    [drvPlanNo] varchar(6) NOT NULL,
    [drvParticipantID] char(11) NULL,
    [drvDateExpectedOverride] varchar(1) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvLoanNo] varchar(1) NOT NULL,
    [drvLoanRepaymentAmt] varchar(9) NULL,
    [drvLoanRepaymentAmtCalc] money NULL,
    [drvLoanRepaymentOverride] varchar(1) NOT NULL,
    [drvLoanPayrollCode] varchar(1) NOT NULL,
    [drvSubPlanNo] varchar(30) NULL
);

-----------
-- Create table U_dsi_EPRU401BU2_trlTbl
-----------

IF OBJECT_ID('U_dsi_EPRU401BU2_trlTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EPRU401BU2_trlTbl] (
    [drvRecType] varchar(3) NOT NULL,
    [drvFileType] varchar(8) NOT NULL,
    [drvClientID] varchar(6) NOT NULL,
    [drvParticipantID] varchar(1) NOT NULL,
    [drvFileCreateDate] datetime NOT NULL,
    [drvFileCreateTime] varchar(8000) NULL,
    [drvDetailRecCount] varchar(9) NULL,
    [drvTotalContribAmt] money NULL,
    [drvLoanRepaymentAmt] money NULL
);

-----------
-- Create table U_EPRU401BU2_AudFieldList
-----------

IF OBJECT_ID('U_EPRU401BU2_AudFieldList') IS NULL
CREATE TABLE [dbo].[U_EPRU401BU2_AudFieldList] (
    [audfield] varchar(200) NOT NULL
);

-----------
-- Create table U_EPRU401BU2_EEList
-----------

IF OBJECT_ID('U_EPRU401BU2_EEList') IS NULL
CREATE TABLE [dbo].[U_EPRU401BU2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPRU401BU2_File
-----------

IF OBJECT_ID('U_EPRU401BU2_File') IS NULL
CREATE TABLE [dbo].[U_EPRU401BU2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(701) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRU401BU2]
 @systemid varchar(12) = ''
AS
Begin

/**********************************************************************
Client Name: Burr Oak Tool Inc.
Vendor: Prudential - TXT-FixedLen
Created By: Tony DiMaio
Business Analyst: Katie Baumanis
Create Date: 04/25/2019
Service Request Number: SF 00234165

Changes:
08/19/2019        Anthony Ramos        SF 15160682        Added logic to remove Student and Interns as states in specs.
08/29/2016        Nkowalchuk            SF 15226667   Correcting code INT is not intern STU is for intren and students 

_dsi_usp_ExportRipout 'EPRU401BU2','Y' 

select * from dbo.U_dsi_Configuration where FormatCode = 'EPRU401BU2' ORDER BY LEN(CfgName) DESC;
select * from dbo.U_dsi_SQLClauses where FormatCode = 'EPRU401BU2';
select * from dbo.U_dsi_Parameters where FormatCode = 'EPRU401BU2';

select * from AscDefH where AdhFormatCode = 'EPRU401BU2';
select * from AscExp where expFormatCode = 'EPRU401BU2';
select * from ascdeff where AdfHeaderSystemID = 'EPRU401BU2Z0' order by adfrectype, AdfSetNumber, AdfFieldNumber;

DSI_SP_TESTSWITCHBOX_V2 'EPRU401BU2', 'EPRU401BU2';
DSI_SP_TESTSWITCHBOX_V2 'EPRU401BU2', 'TEST';

To turn off/on TESTEDT header record: 
Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'EPRU401BU2' AND CfgName = 'TESTING';

**************************/

-- Collect the @Start and @End Percontrol/PayDates upfront

    /***************************
    COLLECT DATE PARAMETERS
    ****************************/
    DECLARE 
        @StartDate DATETIME,
        @EndDate DATETIME,
        @StartPerControl Char(9),
        @EndPerControl Char(9),
        @FormatCode Char(10),
        @ExportCode Char(10),
        @ExportFile char(200);
        
    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = formatcode,
        @ExportCode = Exportcode,
        @Exportfile = ExportFile
    FROM dbo.U_Dsi_Parameters 
    WHERE FormatCode = 'EPRU401BU2';


        
-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 15    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'N'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'        -- P or F indicates if this export is for a passive or full(active) oe


-- clean up EELIST if needed


-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_EPRU401BU2_EELIST
            from dbo.u_EPRU401BU2_EELIST
            join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T');

end

--Clean up list to remove Students and Interns -- AR SF 15160682
begin
            delete dbo.u_EPRU401BU2_EELIST
            from dbo.u_EPRU401BU2_EELIST
            join vw_int_EmpComp  with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where EecEEType in ('STU') -- NK 08/29/2016 SF 15226667 ('STU','INT')
end


-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_EPRU401BU2_EELIST
            from dbo.u_EPRU401BU2_EELIST
            join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid and a.eeccoid = t.eeccoid
                and a.eecemplstatus <> 'T');

            delete dbo.u_EPRU401BU2_eelist
            from dbo.u_EPRU401BU2_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_EPRU401BU2_eelist b where a.xeeid = b.xeeid
            having count(*) > 1);
end


            --delete dbo.u_EPRU401BU2_eelist
            --from dbo.u_EPRU401BU2_eelist a
            --join emppers on a.xeeid = eepeeid
            --and (eepnamelast like '%TEST%' or eepnamefirst like '%TEST%');
    
--Create Audit data

    DECLARE @FieldList varchar(6000)
    SELECT @FieldList = 'EecEmplStatus'--,eecorglvl2'

    if object_id('U_EPRU401BU2_AudFieldList') is not null
      drop table dbo.U_EPRU401BU2_AudFieldList;

    SELECT audfield = item    
    INTO dbo.U_EPRU401BU2_AudFieldList
    from dbo.fn_listtotable(@fieldlist);

--SELECT * from dbo.U_EPRU401BU2_AudFieldList


if object_id('U_ds_EPRU401BU2_auditinfo') is not null
  drop table dbo.u_ds_EPRU401BU2_auditinfo;

 SELECT  audkey1value as eeid,
    case when audtablename = 'Emppers' then eephomecoid
        else audkey2value end as coid,
    max (auddatetime) as auditdate,
        --0=Term
        --1=Rehire
        --2=Newhire
        --3=Leave begin
        --4=Return from leave
    max(case when audfieldname in('eecemplstatus') and audnewvalue = 'A' and audoldvalue = 'L' then '0' 
             when audfieldname in('eecemplstatus') and audnewvalue = 'L' and audoldvalue = 'A' then '0' end) as statusflag 
   INTO dbo.u_ds_EPRU401BU2_AuditInfo
   FROM vw_AuditeeData
   inner join u_EPRU401BU2_audfieldlist on audfield = audfieldname
   join emppers on eepeeid = audkey1value
   join vw_int_EmpComp on eeceeid = audkey1value and eeccoid = audkey2value
  WHERE   (convert(char(10),AudDateTime,112) between left(@startpercontrol,8) and left(@endpercontrol,8))
and (audtablename in ('EMPPERS','EMPCOMP'))

    group by audkey1value,    case when audtablename = 'Emppers' then eephomecoid
        else audkey2value end ;

    CREATE CLUSTERED INDEX idx_EPRU401BU2_EPRU401BU2_AuditInfo
    ON dbo.u_ds_EPRU401BU2_AuditInfo (eeid);

/****Create Table: U_ds_EPRU401BU2_Gennumber***/

if object_id('dbo.U_ds_EPRU401BU2_Gennumber') is not null
  drop table dbo.U_ds_EPRU401BU2_Gennumber;

select distinct prgeeid as eeid,prgcoid as coid,
    prggennumber as gennumber
into dbo.u_ds_EPRU401BU2_Gennumber
from ipayregkeys with(nolock)
     where prgpercontrol between @startpercontrol and @endpercontrol;

--select * from ipayregkeys



if object_id('dbo.U_ds_EPRU401BU2_EarnHist') is not null
  drop table dbo.U_ds_EPRU401BU2_EarnHist;

Select
    xEEID eeid,
    xCOID ecoid,
    SUM(ISNULL(pehCurAmt,0.00)) AS eamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ehrs

    Into    dbo.U_ds_EPRU401BU2_EarnHist
From    dbo.u_EPRU401BU2_EELIST
join    vw_int_PEarHist (nolock) on xeeid = pehEEID and xcoid = pehCOID
    and substring(pehpercontrol,1,4) = substring(@EndPerControl,1,4)
group by xEEID, xCOID;

--def comp
if object_id('dbo.U_ds_EPRU401BU2_DefEarn') is not null
  drop table dbo.U_ds_EPRU401BU2_DefEarn;

Select
    xEEID deeid,
    xCOID decoid,
    SUM(ISNULL(pehCurAmt,0.00)) AS deamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS dehrs

    Into    dbo.U_ds_EPRU401BU2_DefEarn
From    dbo.u_EPRU401BU2_EELIST
join    vw_int_PEarHist (nolock) on xeeid = pehEEID and xcoid = pehCOID
    and pehpercontrol between @StartPerControl and @EndPerControl
    and PehInclInDefComp = 'Y'
group by xEEID, xCOID;


/****Create Table: U_ds_EPRU401BU2_Earns***/
-- JCB
if object_id('dbo.U_ds_EPRU401BU2_Earns') is not null
  drop table dbo.U_ds_EPRU401BU2_Earns;

Select
    drvssn = eepssn,
    essnum = eepssn,
    eEEID = eeid,
    ehrs = sum(pehcurhrs),
    eamt = sum(pehcuramt),
    eytdgross = sum(pehytdamt),
    edate = substring(@EndPerControl,1,8)    --max(pehChargeDate)

    Into    dbo.U_ds_EPRU401BU2_Earns
From    dbo.U_ds_EPRU401BU2_Gennumber
join    ipayregkeys on prggennumber = gennumber
join    vw_int_iPearHist on pehgennumber = gennumber
join    Emppers with (nolock) 
        on    eeid = eepeeid
WHERE PehEarnCode NOT IN ('GTL','HSAER','MHSER','PHON')
group by eepssn, eeid;

--select * from vw_int_iPearHist
--select * from dbo.U_ds_EPRU401BU2_Earns

/****Create Table: U_ds_EPRU401BU2_deds***/
--for rec type 101
if object_id('dbo.U_ds_EPRU401BU2_deds') is not null
  drop table dbo.U_ds_EPRU401BU2_deds;

Select
    drvssn = eepssn,
    dssn = eepssn,
    dEEID = eeid,
    dEndDate = substring(@EndPerControl,1,8),
    ddedcode = pdhdedcode,
    damount = sum(pdheecuramt),
    deeamount = sum(pdheecuramt),    --don't multiply by 100 when using overpunch (UNPN)
    deramount = sum(pdhercuramt)

Into    dbo.U_ds_EPRU401BU2_deds
From    dbo.U_ds_EPRU401BU2_Gennumber
join    ipayregkeys on prggennumber = gennumber
join  ipdedhist 
    on pdhgennumber = gennumber and pdhdedcode in ('401P','ROTH','401KM','401L','401L2') 
join    Emppers with (nolock) 
        on    eeid = eepeeid
group by eepssn, eeid, pdhdedcode;

--select * from dbo.U_ds_EPRU401BU2_deds

--Get the last pay date
declare @LastPayDate as datetime;
SELECT @LastPayDate = max(prgpaydate)  FROM IPAYREGKEYS WHERE prgdocno <> 'ADJUSTMENT'
     and prgpercontrol between @startpercontrol and @endpercontrol;

--Get the PeriodEndDate
declare @PeriodEndDate as datetime;
SELECT @PeriodEndDate = max(pgpperiodenddate)  FROM dbo.PgPayPer 
WHERE pgppaydate = @LastPayDate and pgpperiodtype = 'R';
     

--  send terms for last 30 days
delete dbo.u_EPRU401BU2_EELIST
from dbo.u_EPRU401BU2_EELIST
join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
where t.eecemplstatus = 'T'
and eecdateoftermination + 30 < @EndDate;

-----------------------------------

delete dbo.u_EPRU401BU2_EELIST
from dbo.u_EPRU401BU2_EELIST a
    where not exists (select 1 from dbo.U_ds_EPRU401BU2_deds --include if 401K payroll deduction
                    where a.xeeid = deeid)
    and not exists (select 1 from dbo.U_ds_EPRU401BU2_DefEarn --include if payroll earnings
                    where a.xeeid = deeid);

-------------------------------------

-- Populate Source for Employees
if object_id('U_dsi_EPRU401BU2_drvTbl') is not null
  drop table dbo.U_dsi_EPRU401BU2_drvTbl;

-- EE Detail

  select 
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
--    drvdedcode = dedcode,
-- standard fields above and additional driver fields below
    drvTransactionCode = '114',
    drvSequenceCode = '',
    drvPlanNo = '767645',
    drvParticipantID = eepssn,
    drvFTPTInd = case when eecFullTimeOrPartTime = 'F' then '1' else '2' end,
    drvInvestment1 = '**',--TD 5/6/19 remove asterisks -- '**',
    drvSource1 = 'A',
    drvContribAmount1 = d.eeamt,
    drvInvestment2 = '**',--TD 5/6/19 remove asterisks -- '**',
    drvSource2 = 'J',
    drvContribAmount2 = j.eeamt,
    drvInvestment3 = '**',--TD 5/6/19 remove asterisks -- '**',
    drvSource3 = '6',
    drvContribAmount3 = m.eramt,
    drvInvestment4 = '**',--TD 5/6/19 remove asterisks -- '**',
    drvSource4 = '1',
    drvContribAmount4 = '',--er.eramt, --zero filled
    drvInvestment5 = '', --TD 5/6/19 send blank
    drvSource5 = '',--'1',
    drvContribAmount5 = '',--ps.eeamt,
    drvInvestment6 = '', --TD 5/6/19 send blank
    drvSource6 = '',
    drvContribAmount6 = '',
    drvPeriodEndDate = @PeriodEndDate,
    drvInsiderTrader = '',
    drvSubPlanNo = cast(case when cmpCompanyCode = 'BOT1' then '0001' 
                        when cmpCompanyCode = 'OPS1' then '0002' 
                   else '' end as varchar),
    drvName = UPPER(rtrim(eepnamelast) + ', ' + rtrim(eepnamefirst)+case when isnull(left(eepNameMiddle,1),'') <> '' then ' '+left(eepNameMiddle,1) else '' end ),
    drvAddress1 = UPPER(eepaddressline1),
    drvAddress2 = UPPER(eepaddressline2),
    drvCity = UPPER(eepaddresscity),
    drvState = UPPER(eepaddressstate),
    drvZIP = eepaddresszipcode,
    drvDOB = eepdateofbirth,
    drvOrigHireDate = eecdateoforiginalhire,
    drvAdjHireDate = NULL,
    drvMaritalStatus = case when eepmaritalstatus = 'M' then '2' else '1' end,
    drvGender = case when eepgender = 'M' then '1' else '2' end,
    drvEEStatus = case when eecemplstatus = 'T' and eecTermReason IN ('203') then '3D' 
                       when eecemplstatus = 'T' and eecTermReason IN ('202') then '22' 
                       when eecemplstatus = 'T' then '32' 
                  else '00' end,
    drvEmpStatusDate = case when eecemplstatus = 'T' then eecdateoftermination end,
    drvPayrollFreq = case eecpayperiod
                    when 'M' then '4'
                    when 'S' then '5'
                    when 'B' then '6'
                    when 'W' then '7'
                    else '' end,
    drvServiceYears = '',
    drvYTDHours = '',--Leave Blank --case when e.eehrs is null then replicate('0',7) else RIGHT('0000000' + RTRIM(dbo.dsi_fnRemoveChars('.,/',left(e.eehrs,charindex('.',e.eehrs,+3)+3))), 7) end,
    drvCurrPeriodHours = isnull(de.eehrs,0),--RIGHT(REPLICATE('0',6) + dbo.dsi_fnRemoveChars('.,/',convert(varchar(20),convert(numeric(12,2),isnull(de.eehrs,0)))),6),
    drvCurrPeriodGross = '',
    drvCurrEligGrossPay1 = '',
    drvCurrPeriodW2 = '',--space fill (UD SPEC) --isnull(de.eeamt,0),--RIGHT(REPLICATE('0',11) + dbo.dsi_fnRemoveChars('.,/',convert(varchar(20),convert(numeric(12,2),isnull(de.eeamt,0)))),11),
    drvAnnivDate = '',
    drvAnnivHours = '',
    drvCheckDate = @LastPayDate,
    drvEmpIDCode = eecEmpNo,
    drvDivSub = eecOrgLvl1,
    drvEmpLocationCode = '',
    drvLocEffDate = '',
    drvGroupInd = '',
    drvNeverElig = '',
    drvEligForEE1 = '',
    drvEligForEE2 = '',
    drvEligDate = '',
    drvAutoEnrollDecline = '',
    drvDeferralRate1 = '',
    drvCashBonus = '',
    drvHCEInd = case when eecishighlycomp = 'Y' then '6' else '0' end,
    drvUnionEmployee = '',
    drvMarketSalary = cast(replace(cast(eecAnnSalary as money),'.','') as varchar),
    drvRehireDate = case when eecdateoflasthire <> eecdateoforiginalhire then eecdateoflasthire end,
    -- JCB
    drvPPDGrossPay = gross.eeamt,
    drvDeferralPlanLimitComp = isnull(de.eeamt,0),--cast(replace(de.eeamt,'.','') as varchar),
    drvCurrEligGrossPay2 = '',
    drvADPPLanComp = '',
    drvCurrEligGrossPay3 = '',
    drvERMatchComp = '',--ps.eramt,
    drvACPComp = '',
    drvExcludedComp = '',
    drvTopHeavyComp = '',
    drvEEPostTaxComp = '',
    drvSubStatus = case when a.statusflag = '0' and eecemplstatusstartdate between @startdate and @endDate then 'RL'
                        when eecEmplStatus = 'L' then 'UL' end,
    drvSubStatusDate = case when a.statusflag = '0' and eecemplstatusstartdate between @startdate and @endDate  then eecemplstatusstartdate 
                            when eecEmplStatus = 'L' then eecemplstatusstartdate end,
    
    --drvSubStatus = case when a.statusflag = '0' and eecemplstatusstartdate > @endDate - @daysstopped then 'RL' 
    --                    when eecEmplStatus = 'L' then 'UL' end,
    --drvSubStatusDate = case when a.statusflag = '0' and eecemplstatusstartdate > @endDate - @daysstopped then eecemplstatusstartdate 
    --                        when eecEmplStatus = 'L' then eecemplstatusstartdate end,
    --                                                when eecEmplStatus = 'L' then eecemplstatusstartdate end,
    drvEmailAddr = eepaddressemail,
    drvBankNoEFT = '',
    drvBankABANoEFT = '',
    drvBankAcctType = ''


  into dbo.U_dsi_EPRU401BU2_drvTbl
  from dbo.u_EPRU401BU2_eelist with (nolock)
    join company with (nolock) on xCOID = cmpCOID
    join empPers with (nolock) on xEEID = eepEEID
    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
--    left join (select lchCode code
--                from loareasn where lchFMLAQualified = 'N') rsn on rsn.code = eecLeaveReason
    left join (select distinct eeid, convert(decimal(6,2),sum(ehrs)) AS eehrs, sum(eamt) AS eeamt
                from dbo.U_ds_EPRU401BU2_EarnHist
                group by eeid) e on e.eeid = xeeid

    left join (select distinct deeid, convert(decimal(6,2),sum(dehrs)) AS eehrs, sum(deamt) AS eeamt
                from dbo.U_ds_EPRU401BU2_DefEarn
                group by deeid) de on de.deeid = xeeid

    left join (select distinct eEEID, convert(decimal(6,2),sum(ehrs)) AS eehrs, sum(eamt) AS eeamt
                from dbo.U_ds_EPRU401BU2_Earns
                group by eEEID) gross on gross.eEEID = xeeid

--‘A‘ (Employee Pre-tax)
    left join (select distinct deeid, sum(deeamount) as eeamt, sum(deramount) as eramt, max(dEndDate) pdate
                from dbo.U_ds_EPRU401BU2_deds where ddedcode in ('401P')
                group by deeid) d on d.deeid = xeeid

--‘J‘ (Roth 401K) 
    left join (select distinct deeid, sum(deeamount) as eeamt, sum(deramount) as eramt, max(dEndDate) pdate
                from dbo.U_ds_EPRU401BU2_deds where ddedcode in ('ROTH') 
                group by deeid) j on j.deeid = xeeid

--‘6‘ (Match)
    left join (select distinct deeid, sum(deeamount) as eeamt, sum(deramount) as eramt, max(dEndDate) pdate
                from dbo.U_ds_EPRU401BU2_deds where ddedcode in ('401KM')
                group by deeid) m on m.deeid = xeeid

--‘1‘ (ER Non-Elective)
    left join (select distinct deeid, sum(deeamount) as eeamt, sum(deramount) as eramt, max(dEndDate) pdate
                from dbo.U_ds_EPRU401BU2_deds where ddedcode in ('401K3')
                group by deeid) er on er.deeid = xeeid

----‘B‘ (Catchup Contrib) --source not requested
--    left join (select distinct deeid, sum(deeamount) as eeamt, sum(deramount) as eramt, max(dEndDate) pdate
--                from dbo.U_ds_EPRU401BU2_deds where ddedcode in ('401CF','401CP')
--                group by deeid) b on b.deeid = xeeid

----‘G‘ (Employee After-tax) --source not requested
--    left join (select distinct deeid, sum(deeamount) as eeamt, sum(deramount) as eramt, max(dEndDate) pdate
--                from dbo.U_ds_EPRU401BU2_deds where ddedcode in ('VOLF','VOLP')
--                group by deeid) g on g.deeid = xeeid

----‘P‘ (Employer Match) --source not requested
--    left join (select distinct deeid, sum(deeamount) as eeamt, sum(deramount) as eramt, max(dEndDate) pdate
--                from dbo.U_ds_EPRU401BU2_deds where ddedcode in ('401F','401P','ROTHF','ROTHP')
--                group by deeid) p on p.deeid = xeeid

----‘1‘ (Profit Sharing) --source not requested
--    left join (select distinct deeid, sum(deeamount) as eeamt, sum(deramount) as eramt, max(dEndDate) pdate
--                from dbo.U_ds_EPRU401BU2_deds where ddedcode in ('PS','MATCH')
--                group by deeid) ps on ps.deeid = xeeid


    left join dbo.u_ds_EPRU401BU2_AuditInfo a on a.eeid = xeeid and a.coid = xcoid
;

--select * from dbo.U_ds_EPRU401BU2_deds




--Loans
if object_id('U_dsi_EPRU401BU2_loanTbl') is not null
  drop table dbo.U_dsi_EPRU401BU2_loanTbl;

  select 
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
--    drvdedcode = dedcode,
-- standard fields above and additional driver fields below
    drvTransactionCode = '385',
    drvPlanNo = '767645',
    drvParticipantID = eepssn,
    drvDateExpectedOverride = '',
    drvDedCode = l.dedcode,
    --drvLoanNo = case when l.dedcode = '401KL' then '001' 
    --                 when isnull(l.dedcode,'') <> '' then left(l.dedcode,3)
    --            end,
    drvLoanNo = '', --Space Fill (UD SPEC)
    drvLoanRepaymentAmt = RIGHT('000000000' + dbo.dsi_fnRemoveChars('.,/',convert(varchar(20),convert(numeric(12,2),isnull(l.eeamt,0)))),9),
    drvLoanRepaymentAmtCalc = l.eeamt,
    drvLoanRepaymentOverride = '',
    drvLoanPayrollCode = '',
    drvSubPlanNo = cast(case when cmpCompanyCode = 'BOT1' then '0001' 
                        when cmpCompanyCode = 'OPS1' then '0002' 
                   else '' end as varchar)

  into dbo.U_dsi_EPRU401BU2_loanTbl
  from dbo.u_EPRU401BU2_eelist with (nolock)
    join company with (nolock) on xCOID = cmpCOID
    join empPers with (nolock) on xEEID = eepEEID
    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID

    left join (select deeid, sum(deeamount) as eeamt, sum(deramount) as eramt, ddedcode dedcode, max(dEndDate) pdate
                from dbo.U_ds_EPRU401BU2_deds where ddedcode IN ('401L','401L2')
                group by deeid, ddedcode) l on l.deeid = xeeid
where l.eeamt > 0
;
--select * from dbo.U_ds_EPRU401BU2_deds;



          
-- Create Headers

if object_id('U_dsi_EPRU401BU2_hdrTbl') is not null
  drop table dbo.U_dsi_EPRU401BU2_hdrTbl;

  select

    drvRecType = '001',
    drvFileType = 'COMBINED',
    drvClientID = '767645',
    drvCreationDate = getdate(),
    drvCreationTime = replace(CONVERT(varchar(10), getdate(), 108),':',''),
    drvSender = 'P',
    drvFileFormatType = '701'


  into dbo.U_dsi_EPRU401BU2_hdrTbl
    from (select count(*) cnt from dbo.U_dsi_EPRU401BU2_drvTbl ) kcnt
    left join (select isnull(count(*),0) cnt from dbo.U_dsi_EPRU401BU2_loanTbl) lcnt on 1 = 1
    left join (select sum(isnull(drvContribAmount1,0.00) + isnull(drvContribAmount2,0.00) + isnull(drvContribAmount3,0.00) + isnull(drvContribAmount4,0.00) + isnull(drvContribAmount5,0.00) + isnull(drvContribAmount6,0.00)) amt from dbo.U_dsi_EPRU401BU2_drvTbl) contr on 1 = 1
    left join (select sum(drvLoanRepaymentAmtCalc) amt from dbo.U_dsi_EPRU401BU2_loanTbl) loan on 1 = 1
    ;


-- Create Trailers

if object_id('U_dsi_EPRU401BU2_trlTbl') is not null
  drop table dbo.U_dsi_EPRU401BU2_trlTbl;

  select

    drvRecType = '999',
    drvFileType = 'COMBINED',
    drvClientID = '767645',
    drvParticipantID = '',
    drvFileCreateDate = getdate(),
    drvFileCreateTime = drvCreationTime,--from header rec
    drvDetailRecCount = RIGHT(REPLICATE('0',9) + convert(varchar(10),(kcnt.cnt + lcnt.cnt)),9),
    drvTotalContribAmt = contr.amt,
    drvLoanRepaymentAmt = loan.amt * 100


  into dbo.U_dsi_EPRU401BU2_trlTbl
    from (select count(*) cnt from dbo.U_dsi_EPRU401BU2_drvTbl ) kcnt
    left join (select isnull(count(*),0) cnt from dbo.U_dsi_EPRU401BU2_loanTbl) lcnt on 1 = 1
    left join (select sum(isnull(drvContribAmount1,0.00) + isnull(drvContribAmount2,0.00) + isnull(drvContribAmount3,0.00) + isnull(drvContribAmount4,0.00) + isnull(drvContribAmount5,0.00) + isnull(drvContribAmount6,0.00)) amt from dbo.U_dsi_EPRU401BU2_drvTbl) contr on 1 = 1
    left join (select sum(drvLoanRepaymentAmtCalc) amt from dbo.U_dsi_EPRU401BU2_loanTbl) loan on 1 = 1
    join dbo.U_dsi_EPRU401BU2_hdrTbl on 1 = 1
;
--select * from dbo.U_dsi_EPRU401BU2_trlTbl;


-- Set FileName  
if (dbo.dsi_fnVariable('EPRU401BU2','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'BUO_PRU_401K_' + convert(char(8),getdate(),112) + '.txt'
    where FormatCode = 'EPRU401BU2';


-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwEPRU401BU2_Export as
        select top 2000000 Data from dbo.U_EPRU401BU2_File with (nolock)
         order by substring(Recordset,2,2), initialsort, subsort;


*/



--Used for testing
--dbo.dsi_sp_TestSwitchbox_v2 'EPRU401BU2','EPRU401BU2';
--dbo.dsi_sp_TestSwitchbox_v2 'EPRU401BU2','TEST';

END
GO
 CREATE  View dbo.dsi_vwEPRU401BU2_Export as
        select top 2000000 Data from dbo.U_EPRU401BU2_File with (nolock)
         order by substring(Recordset,2,2), initialsort, subsort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPRU401BU2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPRU401BU2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPRU401BU2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPRU401BU2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPRU401BU2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPRU401BU2', 'UseFileName', 'V', 'Y'


-- End ripout