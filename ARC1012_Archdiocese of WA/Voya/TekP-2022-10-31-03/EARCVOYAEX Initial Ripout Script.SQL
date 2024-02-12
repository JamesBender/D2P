/**********************************************************************************

EARCVOYAEX: Voya Hospital Indemnity Critical Illness Accident

FormatCode:     EARCVOYAEX
Project:        Voya Hospital Indemnity Critical Illness Accident
Client ID:      USG1000
Date/time:      2023-02-21 12:54:54.600
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_EARCVOYAEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EARCVOYAEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EARCVOYAEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EARCVOYAEX'


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
WHERE FormatCode = 'EARCVOYAEX'
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
WHERE ExpFormatCode = 'EARCVOYAEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EARCVOYAEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EARCVOYAEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EARCVOYAEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EARCVOYAEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EARCVOYAEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EARCVOYAEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EARCVOYAEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EARCVOYAEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EARCVOYAEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EARCVOYAEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEARCVOYAEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEARCVOYAEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EARCVOYAEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EARCVOYAEX];
GO
IF OBJECT_ID('U_EARCVOYAEX_File') IS NOT NULL DROP TABLE [dbo].[U_EARCVOYAEX_File];
GO
IF OBJECT_ID('U_EARCVOYAEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EARCVOYAEX_EEList];
GO
IF OBJECT_ID('U_EARCVOYAEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EARCVOYAEX_drvTbl];
GO
IF OBJECT_ID('U_EARCVOYAEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EARCVOYAEX_DedList];
GO
IF OBJECT_ID('U_EARCVOYAEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EARCVOYAEX_AuditFields];
GO
IF OBJECT_ID('U_EARCVOYAEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EARCVOYAEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EARCVOYAEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EARCVOYAEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EARCVOYAEX','Voya Hospital Indemnity Critical Illness Accident','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EARCVOYAEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EARCVOYAEXZ0','50','H','01','1',NULL,'GBPID',NULL,NULL,'"GBPID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EARCVOYAEXZ0','50','H','01','2',NULL,'ACCT',NULL,NULL,'"ACCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EARCVOYAEXZ0','50','H','01','3',NULL,'EEID',NULL,NULL,'"EEID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EARCVOYAEXZ0','50','H','01','4',NULL,'REL',NULL,NULL,'"REL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EARCVOYAEXZ0','50','H','01','5',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EARCVOYAEXZ0','50','H','01','6',NULL,'LASTNM',NULL,NULL,'"LASTNM"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EARCVOYAEXZ0','50','H','01','7',NULL,'FIRSTNM',NULL,NULL,'"FIRSTNM"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EARCVOYAEXZ0','50','H','01','8',NULL,'MIDDLE',NULL,NULL,'"MIDDLE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EARCVOYAEXZ0','50','H','01','9',NULL,'NMSUFFIX',NULL,NULL,'"NMSUFFIX"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EARCVOYAEXZ0','50','H','01','10',NULL,'ADD1',NULL,NULL,'"ADD1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EARCVOYAEXZ0','50','H','01','11',NULL,'ADD2',NULL,NULL,'"ADD2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EARCVOYAEXZ0','50','H','01','12',NULL,'CITY',NULL,NULL,'"CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EARCVOYAEXZ0','50','H','01','13',NULL,'ST',NULL,NULL,'"ST"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EARCVOYAEXZ0','50','H','01','14',NULL,'ZIP',NULL,NULL,'"ZIP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EARCVOYAEXZ0','50','H','01','15',NULL,'COUNTRY',NULL,NULL,'"COUNTRY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EARCVOYAEXZ0','50','H','01','16',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EARCVOYAEXZ0','50','H','01','17',NULL,'GENDER',NULL,NULL,'"GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EARCVOYAEXZ0','50','H','01','18',NULL,'PHONE',NULL,NULL,'"PHONE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EARCVOYAEXZ0','50','H','01','19',NULL,'EMAIL',NULL,NULL,'"EMAIL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EARCVOYAEXZ0','50','H','01','20',NULL,'TOB',NULL,NULL,'"TOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EARCVOYAEXZ0','50','H','01','21',NULL,'DISABILITY',NULL,NULL,'"DISABILITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EARCVOYAEXZ0','50','H','01','22',NULL,'EEJT',NULL,NULL,'"EEJT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EARCVOYAEXZ0','50','H','01','23',NULL,'SALARY',NULL,NULL,'"SALARY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EARCVOYAEXZ0','50','H','01','24',NULL,'DEDFREQ',NULL,NULL,'"DEDFREQ"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EARCVOYAEXZ0','50','H','01','25',NULL,'EEST',NULL,NULL,'"EEST"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EARCVOYAEXZ0','50','H','01','26',NULL,'EEDOH',NULL,NULL,'"EEDOH"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EARCVOYAEXZ0','50','H','01','27',NULL,'ETD',NULL,NULL,'"ETD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EARCVOYAEXZ0','50','H','01','28',NULL,'TKVR',NULL,NULL,'"TKVR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EARCVOYAEXZ0','50','H','01','29',NULL,'WRKL',NULL,NULL,'"WRKL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EARCVOYAEXZ0','50','H','01','30',NULL,'CHSSN',NULL,NULL,'"CHSSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EARCVOYAEXZ0','50','H','01','31',NULL,'PLTP',NULL,NULL,'"PLTP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EARCVOYAEXZ0','50','H','01','32',NULL,'BFCLS',NULL,NULL,'"BFCLS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EARCVOYAEXZ0','50','H','01','33',NULL,'VOYAED',NULL,NULL,'"VOYAED"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EARCVOYAEXZ0','50','H','01','34',NULL,'ERPD',NULL,NULL,'"ERPD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EARCVOYAEXZ0','50','H','01','35',NULL,'EEPD',NULL,NULL,'"EEPD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EARCVOYAEXZ0','50','H','01','36',NULL,'BTD',NULL,NULL,'"BTD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EARCVOYAEXZ0','50','H','01','37',NULL,'OCED',NULL,NULL,'"OCED"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EARCVOYAEXZ0','50','H','01','38',NULL,'TIER',NULL,NULL,'"TIER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EARCVOYAEXZ0','50','H','01','39',NULL,'TERMINATION CODES',NULL,NULL,'"TERMINATION CODES"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EARCVOYAEXZ0','50','H','01','40',NULL,'PAYTYPE',NULL,NULL,'"PAYTYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EARCVOYAEXZ0','50','H','01','41',NULL,'HRLYWAGE',NULL,NULL,'"HRLYWAGE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EARCVOYAEXZ0','50','H','01','42',NULL,'HRSWEEK',NULL,NULL,'"HRSWEEK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EARCVOYAEXZ0','50','H','01','43',NULL,'SINFO',NULL,NULL,'"SINFO"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EARCVOYAEXZ0','50','H','01','44',NULL,'REMARKS',NULL,NULL,'"REMARKS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EARCVOYAEXZ0','50','H','01','45',NULL,'MCI',NULL,NULL,'"MCI"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EARCVOYAEXZ0','8','D','10','1',NULL,'GBPID',NULL,NULL,'"drvGBPID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EARCVOYAEXZ0','4','D','10','2',NULL,'ACCT',NULL,NULL,'"drvACCT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EARCVOYAEXZ0','15','D','10','3',NULL,'EEID',NULL,NULL,'"drvEEIDEE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EARCVOYAEXZ0','2','D','10','4',NULL,'REL',NULL,NULL,'"drvREL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EARCVOYAEXZ0','9','D','10','5',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EARCVOYAEXZ0','30','D','10','6',NULL,'LASTNM',NULL,NULL,'"drvLASTNM"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EARCVOYAEXZ0','20','D','10','7',NULL,'FIRSTNM',NULL,NULL,'"drvFIRSTNM"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EARCVOYAEXZ0','10','D','10','8',NULL,'MIDDLE',NULL,NULL,'"drvMIDDLE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EARCVOYAEXZ0','10','D','10','9',NULL,'NMSUFFIX',NULL,NULL,'"drvNMSUFFIX"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EARCVOYAEXZ0','30','D','10','10',NULL,'ADD1',NULL,NULL,'"drvADD1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EARCVOYAEXZ0','30','D','10','11',NULL,'ADD2',NULL,NULL,'"drvADD2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EARCVOYAEXZ0','30','D','10','12',NULL,'CITY',NULL,NULL,'"drvCITY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EARCVOYAEXZ0','3','D','10','13',NULL,'ST',NULL,NULL,'"drvST"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EARCVOYAEXZ0','9','D','10','14',NULL,'ZIP',NULL,NULL,'"drvZIP"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EARCVOYAEXZ0','31','D','10','15',NULL,'COUNTRY',NULL,NULL,'"drvCOUNTRY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EARCVOYAEXZ0','8','D','10','16',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EARCVOYAEXZ0','1','D','10','17',NULL,'GENDER',NULL,NULL,'"drvGENDER"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EARCVOYAEXZ0','13','D','10','18',NULL,'PHONE',NULL,NULL,'"drvPHONE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EARCVOYAEXZ0','65','D','10','19',NULL,'EMAIL',NULL,NULL,'"drvEMAIL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EARCVOYAEXZ0','3','D','10','20',NULL,'TOB',NULL,NULL,'"drvTOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EARCVOYAEXZ0','50','D','10','21',NULL,'DISABILITY',NULL,NULL,'"drvDISABILITY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EARCVOYAEXZ0','30','D','10','22',NULL,'EEJT',NULL,NULL,'"drvEEJT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EARCVOYAEXZ0','11','D','10','23',NULL,'SALARY',NULL,NULL,'"drvSALARY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EARCVOYAEXZ0','5','D','10','24',NULL,'DEDFREQ',NULL,NULL,'"drvDEDFREQ"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EARCVOYAEXZ0','30','D','10','25',NULL,'EEST',NULL,NULL,'"drvEEST"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EARCVOYAEXZ0','8','D','10','26',NULL,'EEDOH',NULL,NULL,'"drvEEDOH"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EARCVOYAEXZ0','8','D','10','27',NULL,'ETD',NULL,NULL,'"drvETD"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EARCVOYAEXZ0','1','D','10','28',NULL,'TKVR',NULL,NULL,'"drvTKVR"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EARCVOYAEXZ0','10','D','10','29',NULL,'WRKL',NULL,NULL,'"drvWRKL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EARCVOYAEXZ0','1','D','10','30',NULL,'CHSSN',NULL,NULL,'"drvCHSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EARCVOYAEXZ0','4','D','10','31',NULL,'PLTP',NULL,NULL,'"drvPLTP"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EARCVOYAEXZ0','30','D','10','32',NULL,'BFCLS',NULL,NULL,'"drvBFCLS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EARCVOYAEXZ0','8','D','10','33',NULL,'VOYAED',NULL,NULL,'"drvVOYAED"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EARCVOYAEXZ0','6','D','10','34',NULL,'ERPD',NULL,NULL,'"drvERPD"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EARCVOYAEXZ0','6','D','10','35',NULL,'EEPD',NULL,NULL,'"drvEEPD"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EARCVOYAEXZ0','8','D','10','36',NULL,'BTD',NULL,NULL,'"drvBTD"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EARCVOYAEXZ0','8','D','10','37',NULL,'OCED',NULL,NULL,'"drvOCED"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EARCVOYAEXZ0','3','D','10','38',NULL,'TIER',NULL,NULL,'"drvTIER"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EARCVOYAEXZ0','8','D','10','39',NULL,'TERMINATION CODES',NULL,NULL,'"drvTERMINATIONCODES"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EARCVOYAEXZ0','1','D','10','40',NULL,'PAYTYPE',NULL,NULL,'"drvPAYTYPE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EARCVOYAEXZ0','6','D','10','41',NULL,'HRLYWAGE',NULL,NULL,'"drvHRLYWAGE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EARCVOYAEXZ0','6','D','10','42',NULL,'HRSWEEK',NULL,NULL,'"drvHRSWEEK"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EARCVOYAEXZ0','50','D','10','43',NULL,'SINFO',NULL,NULL,'"drvSINFO"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EARCVOYAEXZ0','30','D','10','44',NULL,'REMARKS',NULL,NULL,'"drvREMARKS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EARCVOYAEXZ0','7','D','10','45',NULL,'MCI',NULL,NULL,'"drvMCI"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EARCVOYAEX_20230221.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Voya Hospital Indemnity Critic','202302219','EMPEXPORT','ONDEM_XOE',NULL,'EARCVOYAEX',NULL,NULL,NULL,'202302219','Feb 21 2023 12:11PM','Feb 21 2023 12:11PM','202302211',NULL,'','','202302211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Voya Hospital Indemnity -Sched','202302219','EMPEXPORT','SCH_EARCVO',NULL,'EARCVOYAEX',NULL,NULL,NULL,'202302219','Feb 21 2023 12:11PM','Feb 21 2023 12:11PM','202302211',NULL,'','','202302211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Voya Hospital Indemnity -Test','202302219','EMPEXPORT','TEST_XOE',NULL,'EARCVOYAEX',NULL,NULL,NULL,'202302219','Feb 21 2023 12:11PM','Feb 21 2023 12:11PM','202302211',NULL,'','','202302211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCVOYAEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCVOYAEX','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCVOYAEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCVOYAEX','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCVOYAEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCVOYAEX','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EARCVOYAEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EARCVOYAEX','D10','dbo.U_EARCVOYAEX_drvTbl',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_EARCVOYAEX
-----------

IF OBJECT_ID('U_dsi_BDM_EARCVOYAEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EARCVOYAEX] (
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

-----------
-- Create table U_EARCVOYAEX_Audit
-----------

IF OBJECT_ID('U_EARCVOYAEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EARCVOYAEX_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EARCVOYAEX_AuditFields
-----------

IF OBJECT_ID('U_EARCVOYAEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EARCVOYAEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EARCVOYAEX_DedList
-----------

IF OBJECT_ID('U_EARCVOYAEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EARCVOYAEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EARCVOYAEX_drvTbl
-----------

IF OBJECT_ID('U_EARCVOYAEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EARCVOYAEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvGBPID] varchar(8) NOT NULL,
    [drvACCT] varchar(4) NOT NULL,
    [drvEEIDEE] char(9) NULL,
    [drvREL] varchar(2) NULL,
    [drvSSN] char(11) NULL,
    [drvLASTNM] varchar(100) NULL,
    [drvFIRSTNM] varchar(100) NULL,
    [drvMIDDLE] varchar(50) NULL,
    [drvNMSUFFIX] varchar(1) NOT NULL,
    [drvADD1] varchar(255) NULL,
    [drvADD2] varchar(255) NULL,
    [drvCITY] varchar(255) NULL,
    [drvST] varchar(255) NULL,
    [drvZIP] varchar(50) NULL,
    [drvCOUNTRY] char(3) NULL,
    [drvDOB] varchar(8000) NULL,
    [drvGENDER] char(1) NULL,
    [drvPHONE] varchar(50) NULL,
    [drvEMAIL] varchar(50) NULL,
    [drvTOB] varchar(3) NOT NULL,
    [drvDISABILITY] varchar(8) NULL,
    [drvEEJT] varchar(8000) NULL,
    [drvSALARY] nvarchar(4000) NULL,
    [drvDEDFREQ] char(1) NULL,
    [drvEEST] char(1) NULL,
    [drvEEDOH] varchar(8000) NULL,
    [drvETD] varchar(8000) NULL,
    [drvTKVR] varchar(1) NOT NULL,
    [drvWRKL] varchar(255) NULL,
    [drvCHSSN] varchar(1) NOT NULL,
    [drvPLTP] varchar(2) NULL,
    [drvBFCLS] varchar(4) NULL,
    [drvVOYAED] varchar(8000) NULL,
    [drvERPD] varchar(1) NOT NULL,
    [drvEEPD] nvarchar(4000) NULL,
    [drvBTD] varchar(8000) NULL,
    [drvOCED] varchar(1) NOT NULL,
    [drvTIER] varchar(2) NULL,
    [drvTERMINATIONCODES] varchar(1) NOT NULL,
    [drvPAYTYPE] char(1) NULL,
    [drvHRLYWAGE] varchar(1) NOT NULL,
    [drvHRSWEEK] varchar(1) NOT NULL,
    [drvSINFO] varchar(1) NOT NULL,
    [drvREMARKS] varchar(1) NOT NULL,
    [drvMCI] varchar(1) NOT NULL
);

-----------
-- Create table U_EARCVOYAEX_EEList
-----------

IF OBJECT_ID('U_EARCVOYAEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EARCVOYAEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EARCVOYAEX_File
-----------

IF OBJECT_ID('U_EARCVOYAEX_File') IS NULL
CREATE TABLE [dbo].[U_EARCVOYAEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EARCVOYAEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Archdiocese of WA

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 02/21/2023
Service Request Number: TekP-2022-10-31-03 

Purpose: Voya Hospital Indemnity Critical Illness Accident

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EARCVOYAEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EARCVOYAEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EARCVOYAEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EARCVOYAEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EARCVOYAEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARCVOYAEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARCVOYAEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARCVOYAEX', 'SCH_EARCVO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EARCVOYAEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EARCVOYAEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EARCVOYAEX';

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
    DELETE FROM dbo.U_EARCVOYAEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EARCVOYAEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EARCVOYAEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EARCVOYAEX_AuditFields;
    CREATE TABLE dbo.U_EARCVOYAEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EARCVOYAEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EARCVOYAEX_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EARCVOYAEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EARCVOYAEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EARCVOYAEX_Audit ON dbo.U_EARCVOYAEX_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EARCVOYAEX_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EARCVOYAEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'AC,AI,CI,CIE10,CIE20,CIS10,CIS20,HI';

    IF OBJECT_ID('U_EARCVOYAEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EARCVOYAEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EARCVOYAEX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EARCVOYAEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EARCVOYAEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EARCVOYAEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvGBPID = '00732303'
        ,drvACCT = '0001'
        ,drvEEIDEE = EecEmpNo
        ,drvREL =  CASE WHEN BdmRecType = 'EMP' THEN 'EE'
                        WHEN BdmRecType = 'DEP'and ConRelationship= 'SPS' THEN 'SP'
                        WHEN BdmRecType = 'DEP'and ConRelationship in ('CHL', 'STC', 'DIS') THEN 'CH'
                    END
        ,drvSSN = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                       WHEN BdmRecType = 'DEP' THEN ConSSN 
                    END
        ,drvLASTNM = CASE WHEN BdmRecType = 'EMP' THEN eepNameLast
                       WHEN BdmRecType = 'DEP' THEN ConNameLast
                    END
        ,drvFIRSTNM = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                       WHEN BdmRecType = 'DEP' THEN ConNameFirst
                    END
        ,drvMIDDLE = CASE WHEN BdmRecType = 'EMP' THEN EepNameMiddle
                       WHEN BdmRecType = 'DEP' THEN ConNameMiddle
                    END
        ,drvNMSUFFIX = ''
        ,drvADD1 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1
                       WHEN BdmRecType = 'DEP' and ConAddressIsDifferent= 'Y' THEN ConAddressLine1 ELSE EepAddressLine1
                     END
        ,drvADD2 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2
                       WHEN BdmRecType = 'DEP' and ConAddressIsDifferent= 'Y' THEN ConAddressLine2 ELSE EepAddressLine2
                     END
        ,drvCITY = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity
                       WHEN BdmRecType = 'DEP' and ConAddressIsDifferent= 'Y' THEN ConAddressCity ELSE EepAddressCity
                     END
        ,drvST = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState
                       WHEN BdmRecType = 'DEP' and ConAddressIsDifferent= 'Y' THEN ConAddressState ELSE EepAddressState
                     END
        ,drvZIP = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode
                       WHEN BdmRecType = 'DEP' and ConAddressIsDifferent= 'Y' THEN ConAddressZipCode ELSE EepAddressZipCode
                     END
        ,drvCOUNTRY = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCountry
                       WHEN BdmRecType = 'DEP' and ConAddressIsDifferent= 'Y' THEN ConAddressCountry ELSE EepAddressCountry
                     END
        
        ,drvDOB = REPLACE(CONVERT (CHAR(10),CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth
                       WHEN BdmRecType = 'DEP' THEN ConDateOfBirth
                    END, 101),'/','')
        ,drvGENDER = CASE WHEN BdmRecType = 'EMP' THEN EepGender
                       WHEN BdmRecType = 'DEP' THEN ConGender
                    END
        ,drvPHONE = CASE WHEN BdmRecType = 'EMP' THEN EepPhoneHomeNumber
                       WHEN BdmRecType = 'DEP' THEN ConPhoneHomeNumber
                    END
        ,drvEMAIL = CASE WHEN BdmRecType = 'EMP' THEN EepAddressEMail
                       WHEN BdmRecType = 'DEP' THEN ConEmailAddr
                    END
        
        ,drvTOB = 'N/A'
        ,drvDISABILITY = CASE WHEN BdmRecType = 'DEP'and ConRelationship in ('CHL', 'STC', 'DIS') and ConIsDisabled= 'Y' THEN 'Disabled' END
        ,drvEEJT =  REPLACE(CASE WHEN BdmRecType = 'EMP' THEN JbcDesc END, ',', '')
        ,drvSALARY = CASE WHEN BdmRecType = 'EMP' THEN Format(EecAnnSalary, '00.00') END
        ,drvDEDFREQ = CASE WHEN BdmRecType = 'EMP' THEN PgrPayFrequency  END
        ,drvEEST = CASE WHEN BdmRecType = 'EMP' THEN EecEmplStatus END
        ,drvEEDOH = CASE WHEN BdmRecType = 'EMP' THEN REPLACE(CONVERT (CHAR(10),EecDateOfLastHire, 101),'/','') END
        ,drvETD = CASE WHEN BdmRecType = 'EMP' THEN REPLACE(CONVERT (CHAR(10),EecDateOfTermination, 101),'/','') END
        ,drvTKVR = 'N'
        ,drvWRKL = CASE WHEN BdmRecType = 'EMP' THEN LocAddressState END
        ,drvCHSSN = ''
        ,drvPLTP = CASE WHEN BdmDedCode in ('CI','CIE10','CIE20','CIS10','CIS20') then 'CI'
                        WHEN BdmDedCode in ('AC', 'AI') then 'AC'
                        WHEN BdmDedCode in ('HI') then 'HI'
                    END
        ,drvBFCLS = CASE WHEN BdmDedCode in ('AC') THEN 'Low'
                         WHEN BdmDedCode in ('HI') then 'High'
                        END
        ,drvVOYAED =REPLACE(CONVERT (CHAR(10), BdmBenStartDate, 101),'/','')
        ,drvERPD =  ''
        ,drvEEPD = CASE WHEN BdmDedCode in ('CI','CIE10','CIE20','CIS10','CIS20') and BdmRelationship IN ('Emp', 'SP' ) THEN  Format(BdmEEAmt, '00.00')
                         WHEN BdmDedCode in ('CI','CIE10','CIE20','CIS10','CIS20') and BdmRelationship IN ('CH' ) then Format((BdmEEAmt*.5), '00.00')
                         WHEN BdmDedCode = 'HI' then '200' 
                        END
        ,drvBTD = REPLACE(CONVERT (CHAR(10), BdmBenStopDate, 101),'/','')
        ,drvOCED = ''
        ,drvTIER = CASE WHEN BdmDedCode in ('CIE10','CIE20') then 'EE'
                        WHEN BdmDedCode in ('CIS10','CIS20') then 'SP'
                    END
        ,drvTERMINATIONCODES = ''
        ,drvPAYTYPE = CASE WHEN BdmRecType = 'EMP' THEN EecSalaryOrHourly END
        ,drvHRLYWAGE = ''
        ,drvHRSWEEK = ''
        ,drvSINFO = ''
        ,drvREMARKS = ''
        ,drvMCI = ''
    INTO dbo.U_EARCVOYAEX_drvTbl
    FROM dbo.U_EARCVOYAEX_EEList WITH (NOLOCK)
   JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    LEFT JOIN dbo.location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_BDM_EARCVOYAEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
        where eecEEtype <> 'TES'
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
ALTER VIEW dbo.dsi_vwEARCVOYAEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EARCVOYAEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EARCVOYAEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202302141'
       ,expStartPerControl     = '202302141'
       ,expLastEndPerControl   = '202302219'
       ,expEndPerControl       = '202302219'
WHERE expFormatCode = 'EARCVOYAEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEARCVOYAEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EARCVOYAEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EARCVOYAEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EARCVOYAEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EARCVOYAEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EARCVOYAEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EARCVOYAEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EARCVOYAEX', 'UseFileName', 'V', 'Y'


-- End ripout