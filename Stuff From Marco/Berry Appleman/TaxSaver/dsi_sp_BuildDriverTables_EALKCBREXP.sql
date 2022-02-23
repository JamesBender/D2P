/**********************************************************************************

EBERCBREXP: TaxSaver COBRA QB Export

FormatCode:     EBERCBREXP
Project:        TaxSaver COBRA QB Export
Client ID:      BER1011
Date/time:      2021-11-29 17:19:11.717
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW2WUP3DB03
Database:       ULTIPRO_WPBERRY
Web Filename:   BER1011_DB933_EEHISTORY_EBERCBREXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBERCBREXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EBERCBREXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBERCBREXP'


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
WHERE FormatCode = 'EBERCBREXP'
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
WHERE ExpFormatCode = 'EBERCBREXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBERCBREXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBERCBREXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBERCBREXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBERCBREXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBERCBREXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBERCBREXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBERCBREXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBERCBREXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBERCBREXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBERCBREXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBERCBREXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBERCBREXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBERCBREXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBERCBREXP];
GO
IF OBJECT_ID('U_EBERCBREXP_File') IS NOT NULL DROP TABLE [dbo].[U_EBERCBREXP_File];
GO
IF OBJECT_ID('U_EBERCBREXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBERCBREXP_EEList];
GO
IF OBJECT_ID('U_EBERCBREXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBERCBREXP_drvTbl];
GO
IF OBJECT_ID('U_EBERCBREXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBERCBREXP_DedList];
GO
IF OBJECT_ID('U_EBERCBREXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBERCBREXP_AuditFields];
GO
IF OBJECT_ID('U_EBERCBREXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBERCBREXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EBERCBREXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBERCBREXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBERCBREXP','TaxSaver COBRA QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','5000','S','N','EBERCBREXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBERCBREXPZ0','50','H','01','1',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBERCBREXPZ0','50','H','01','2',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBERCBREXPZ0','50','H','01','3',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBERCBREXPZ0','50','H','01','4',NULL,'Sex',NULL,NULL,'"Sex"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBERCBREXPZ0','50','H','01','5',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBERCBREXPZ0','50','H','01','6',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBERCBREXPZ0','50','H','01','7',NULL,'Event Type',NULL,NULL,'"Event Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBERCBREXPZ0','50','H','01','8',NULL,'Event Date',NULL,NULL,'"Event Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBERCBREXPZ0','50','H','01','9',NULL,'Original Enrollment Date',NULL,NULL,'"Original Enrollment Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBERCBREXPZ0','50','H','01','10',NULL,'AEI Eligible',NULL,NULL,'"AEI Eligible"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBERCBREXPZ0','50','H','01','11',NULL,'Uses HCTC',NULL,NULL,'"Uses HCTC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBERCBREXPZ0','50','H','01','12',NULL,'Address 1',NULL,NULL,'"Address 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBERCBREXPZ0','50','H','01','13',NULL,'Address 2',NULL,NULL,'"Address 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBERCBREXPZ0','50','H','01','14',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBERCBREXPZ0','50','H','01','15',NULL,'State or Province',NULL,NULL,'"State or Province"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBERCBREXPZ0','50','H','01','16',NULL,'Postal Code',NULL,NULL,'"Postal Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBERCBREXPZ0','50','H','01','17',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBERCBREXPZ0','50','H','01','18',NULL,'Medical Plan',NULL,NULL,'"Medical Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBERCBREXPZ0','50','H','01','19',NULL,'Medical Coverage',NULL,NULL,'"Medical Coverage"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBERCBREXPZ0','50','H','01','20',NULL,'Dental Plan',NULL,NULL,'"Dental Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBERCBREXPZ0','50','H','01','21',NULL,'Dental Coverage',NULL,NULL,'"Dental Coverage"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBERCBREXPZ0','50','H','01','22',NULL,'Vision Plan',NULL,NULL,'"Vision Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBERCBREXPZ0','50','H','01','23',NULL,'Vision Coverage',NULL,NULL,'"Vision Coverage"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBERCBREXPZ0','50','H','01','24',NULL,'EAP Plan',NULL,NULL,'"EAP Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBERCBREXPZ0','50','H','01','25',NULL,'EAP Coverage',NULL,NULL,'"EAP Coverage"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBERCBREXPZ0','50','H','01','26',NULL,'FSA',NULL,NULL,'"FSA"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBERCBREXPZ0','50','H','01','27',NULL,'FSA Contrib',NULL,NULL,'"FSA Contrib"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBERCBREXPZ0','50','H','01','28',NULL,'Spouse First',NULL,NULL,'"Spouse First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBERCBREXPZ0','50','H','01','29',NULL,'Spouse Last',NULL,NULL,'"Spouse Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBERCBREXPZ0','50','H','01','30',NULL,'Spouse SSN',NULL,NULL,'"Spouse SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBERCBREXPZ0','50','H','01','31',NULL,'Spouse DOB',NULL,NULL,'"Spouse DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBERCBREXPZ0','50','H','01','32',NULL,'CH1 First',NULL,NULL,'"CH1 First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBERCBREXPZ0','50','H','01','33',NULL,'CH1 Last',NULL,NULL,'"CH1 Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBERCBREXPZ0','50','H','01','34',NULL,'CH1 SSN',NULL,NULL,'"CH1 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBERCBREXPZ0','50','H','01','35',NULL,'CH1 DOB',NULL,NULL,'"CH1 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBERCBREXPZ0','50','H','01','36',NULL,'CH2 First',NULL,NULL,'"CH2 First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBERCBREXPZ0','50','H','01','37',NULL,'CH2 Last',NULL,NULL,'"CH2 Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBERCBREXPZ0','50','H','01','38',NULL,'CH2 SSN',NULL,NULL,'"CH2 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBERCBREXPZ0','50','H','01','39',NULL,'CH2 DOB',NULL,NULL,'"CH2 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBERCBREXPZ0','50','H','01','40',NULL,'CH3 First',NULL,NULL,'"CH3 First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EBERCBREXPZ0','50','H','01','41',NULL,'CH3 Last',NULL,NULL,'"CH3 Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EBERCBREXPZ0','50','H','01','42',NULL,'CH3 SSN',NULL,NULL,'"CH3 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EBERCBREXPZ0','50','H','01','43',NULL,'CH3 DOB',NULL,NULL,'"CH3 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EBERCBREXPZ0','50','H','01','44',NULL,'CH4 First',NULL,NULL,'"CH4 First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EBERCBREXPZ0','50','H','01','45',NULL,'CH4 Last',NULL,NULL,'"CH4 Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EBERCBREXPZ0','50','H','01','46',NULL,'CH4 SSN',NULL,NULL,'"CH4 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EBERCBREXPZ0','50','H','01','47',NULL,'CH4 DOB',NULL,NULL,'"CH4 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EBERCBREXPZ0','50','H','01','48',NULL,'CH5 First',NULL,NULL,'"CH5 First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EBERCBREXPZ0','50','H','01','49',NULL,'CH5 Last',NULL,NULL,'"CH5 Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EBERCBREXPZ0','50','H','01','50',NULL,'CH5 SSN',NULL,NULL,'"CH5 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EBERCBREXPZ0','50','H','01','51',NULL,'CH5 DOB',NULL,NULL,'"CH5 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EBERCBREXPZ0','50','H','01','52',NULL,'CH6 First',NULL,NULL,'"CH6 First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EBERCBREXPZ0','50','H','01','53',NULL,'CH6 Last',NULL,NULL,'"CH6 Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EBERCBREXPZ0','50','H','01','54',NULL,'CH6 SSN',NULL,NULL,'"CH6 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EBERCBREXPZ0','50','H','01','55',NULL,'CH6 DOB',NULL,NULL,'"CH6 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EBERCBREXPZ0','50','H','01','56',NULL,'CH7 First',NULL,NULL,'"CH7 First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EBERCBREXPZ0','50','H','01','57',NULL,'CH7 Last',NULL,NULL,'"CH7 Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EBERCBREXPZ0','50','H','01','58',NULL,'CH7 SSN',NULL,NULL,'"CH7 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EBERCBREXPZ0','50','H','01','59',NULL,'CH7 DOB',NULL,NULL,'"CH7 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EBERCBREXPZ0','50','H','01','60',NULL,'CH8 First',NULL,NULL,'"CH8 First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EBERCBREXPZ0','50','H','01','61',NULL,'CH8 Last',NULL,NULL,'"CH8 Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EBERCBREXPZ0','50','H','01','62',NULL,'CH8 SSN',NULL,NULL,'"CH8 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EBERCBREXPZ0','50','H','01','63',NULL,'CH8 DOB',NULL,NULL,'"CH8 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EBERCBREXPZ0','50','H','01','64',NULL,'CH9 First',NULL,NULL,'"CH9 First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EBERCBREXPZ0','50','H','01','65',NULL,'CH9 Last',NULL,NULL,'"CH9 Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EBERCBREXPZ0','50','H','01','66',NULL,'CH9 SSN',NULL,NULL,'"CH9 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EBERCBREXPZ0','50','H','01','67',NULL,'CH9 DOB',NULL,NULL,'"CH9 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EBERCBREXPZ0','50','H','01','68',NULL,'CH10 First',NULL,NULL,'"CH10 First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EBERCBREXPZ0','50','H','01','69',NULL,'CH10 Last',NULL,NULL,'"CH10 Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EBERCBREXPZ0','50','H','01','70',NULL,'CH10 SSN',NULL,NULL,'"CH10 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EBERCBREXPZ0','50','H','01','71',NULL,'CH10 DOB',NULL,NULL,'"CH10 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EBERCBREXPZ0','50','H','01','72',NULL,'CH11 First',NULL,NULL,'"CH11 First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EBERCBREXPZ0','50','H','01','73',NULL,'CH11 Last',NULL,NULL,'"CH11 Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EBERCBREXPZ0','50','H','01','74',NULL,'CH11 SSN',NULL,NULL,'"CH11 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EBERCBREXPZ0','50','H','01','75',NULL,'CH11 DOB',NULL,NULL,'"CH11 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EBERCBREXPZ0','50','H','01','76',NULL,'CH12 First',NULL,NULL,'"CH12 First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EBERCBREXPZ0','50','H','01','77',NULL,'CH12 Last',NULL,NULL,'"CH12 Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EBERCBREXPZ0','50','H','01','78',NULL,'CH12 SSN',NULL,NULL,'"CH12 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EBERCBREXPZ0','50','H','01','79',NULL,'CH12 DOB',NULL,NULL,'"CH12 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EBERCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EBERCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EBERCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EBERCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL,'"Sex"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EBERCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EBERCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EBERCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EBERCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EBERCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL,'"Sex"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EBERCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EBERCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EBERCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EBERCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EBERCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL,'"Sex"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EBERCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EBERCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EBERCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EBERCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EBERCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL,'"Sex"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EBERCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EBERCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EBERCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EBERCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EBERCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL,'"Sex"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EBERCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EBERCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EBERCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EBERCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EBERCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL,'"Sex"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EBERCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EBERCBREXPZ0','50','H','01','80',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EBERCBREXPZ0','50','H','01','81',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EBERCBREXPZ0','50','H','01','82',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EBERCBREXPZ0','50','H','01','83',NULL,'Sex',NULL,NULL,'"Sex"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EBERCBREXPZ0','50','H','01','84',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBERCBREXPZ0','50','D','10','1',NULL,'SSN',NULL,NULL,'"drvEmpSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBERCBREXPZ0','50','D','10','2',NULL,'First Name',NULL,NULL,'"drvEmpFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBERCBREXPZ0','50','D','10','3',NULL,'Last Name',NULL,NULL,'"drvEmpLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBERCBREXPZ0','50','D','10','4',NULL,'Sex',NULL,NULL,'"drvEmpSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBERCBREXPZ0','50','D','10','5',NULL,'DOB',NULL,NULL,'"drvEmpDOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBERCBREXPZ0','50','D','10','6',NULL,'Division',NULL,NULL,'"drvEmpDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBERCBREXPZ0','50','D','10','7',NULL,'Event Type',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBERCBREXPZ0','50','D','10','8',NULL,'Event Date',NULL,NULL,'"drvEventDate"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBERCBREXPZ0','50','D','10','9',NULL,'Original Enrollment Date',NULL,NULL,'"drvOriginalEnrollmentDate"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBERCBREXPZ0','50','D','10','10',NULL,'AEI Eligible',NULL,NULL,'"drvAEIEligible"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBERCBREXPZ0','50','D','10','11',NULL,'Uses HCTC',NULL,NULL,'"drvUsesHCTC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBERCBREXPZ0','50','D','10','12',NULL,'Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBERCBREXPZ0','50','D','10','13',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBERCBREXPZ0','50','D','10','14',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBERCBREXPZ0','50','D','10','15',NULL,'State or Province',NULL,NULL,'"drvStateorProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBERCBREXPZ0','50','D','10','16',NULL,'Postal Code',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBERCBREXPZ0','50','D','10','17',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBERCBREXPZ0','50','D','10','18',NULL,'Medical Plan',NULL,NULL,'"drvMedicalPlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBERCBREXPZ0','50','D','10','19',NULL,'Medical Coverage',NULL,NULL,'"drvMedicalCoverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBERCBREXPZ0','50','D','10','20',NULL,'Dental Plan',NULL,NULL,'"drvDentalPlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBERCBREXPZ0','50','D','10','21',NULL,'Dental Coverage',NULL,NULL,'"drvDentalCoverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBERCBREXPZ0','50','D','10','22',NULL,'Vision Plan',NULL,NULL,'"drvVisionPlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBERCBREXPZ0','50','D','10','23',NULL,'Vision Coverage',NULL,NULL,'"drvVisionCoverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBERCBREXPZ0','50','D','10','24',NULL,'EAP Plan',NULL,NULL,'"drvEAPPlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBERCBREXPZ0','50','D','10','25',NULL,'EAP Coverage',NULL,NULL,'"drvEAPCoverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBERCBREXPZ0','50','D','10','26',NULL,'FSA',NULL,NULL,'"drvFSA"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBERCBREXPZ0','50','D','10','27',NULL,'FSA Contrib',NULL,NULL,'"drvFSAContrib"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBERCBREXPZ0','50','D','10','28',NULL,'Spouse First',NULL,NULL,'"drvSpouseFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBERCBREXPZ0','50','D','10','29',NULL,'Spouse Last',NULL,NULL,'"drvSpouseLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBERCBREXPZ0','50','D','10','30',NULL,'Spouse SSN',NULL,NULL,'"drvSpouseSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBERCBREXPZ0','50','D','10','31',NULL,'Spouse DOB',NULL,NULL,'"drvSpouseDOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBERCBREXPZ0','50','D','10','32',NULL,'CH1 First',NULL,NULL,'"drvCH1First"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBERCBREXPZ0','50','D','10','33',NULL,'CH1 Last',NULL,NULL,'"drvCH1Last"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBERCBREXPZ0','50','D','10','34',NULL,'CH1 SSN',NULL,NULL,'"drvCH1SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBERCBREXPZ0','50','D','10','35',NULL,'CH1 DOB',NULL,NULL,'"drvCH1DOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBERCBREXPZ0','50','D','10','36',NULL,'CH2 First',NULL,NULL,'"drvCH2First"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBERCBREXPZ0','50','D','10','37',NULL,'CH2 Last',NULL,NULL,'"drvCH2Last"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBERCBREXPZ0','50','D','10','38',NULL,'CH2 SSN',NULL,NULL,'"drvCH2SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBERCBREXPZ0','50','D','10','39',NULL,'CH2 DOB',NULL,NULL,'"drvCH2DOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBERCBREXPZ0','50','D','10','40',NULL,'CH3 First',NULL,NULL,'"drvCH3First"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EBERCBREXPZ0','50','D','10','41',NULL,'CH3 Last',NULL,NULL,'"drvCH3Last"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EBERCBREXPZ0','50','D','10','42',NULL,'CH3 SSN',NULL,NULL,'"drvCH3SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EBERCBREXPZ0','50','D','10','43',NULL,'CH3 DOB',NULL,NULL,'"drvCH3DOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EBERCBREXPZ0','50','D','10','44',NULL,'CH4 First',NULL,NULL,'"drvCH4First"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EBERCBREXPZ0','50','D','10','45',NULL,'CH4 Last',NULL,NULL,'"drvCH4Last"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EBERCBREXPZ0','50','D','10','46',NULL,'CH4 SSN',NULL,NULL,'"drvCH4SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EBERCBREXPZ0','50','D','10','47',NULL,'CH4 DOB',NULL,NULL,'"drvCH4DOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EBERCBREXPZ0','50','D','10','48',NULL,'CH5 First',NULL,NULL,'"drvCH5First"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EBERCBREXPZ0','50','D','10','49',NULL,'CH5 Last',NULL,NULL,'"drvCH5Last"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EBERCBREXPZ0','50','D','10','50',NULL,'CH5 SSN',NULL,NULL,'"drvCH5SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EBERCBREXPZ0','50','D','10','51',NULL,'CH5 DOB',NULL,NULL,'"drvCH5DOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EBERCBREXPZ0','50','D','10','52',NULL,'CH6 First',NULL,NULL,'"drvCH6First"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EBERCBREXPZ0','50','D','10','53',NULL,'CH6 Last',NULL,NULL,'"drvCH6Last"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EBERCBREXPZ0','50','D','10','54',NULL,'CH6 SSN',NULL,NULL,'"drvCH6SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EBERCBREXPZ0','50','D','10','55',NULL,'CH6 DOB',NULL,NULL,'"drvCH6DOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EBERCBREXPZ0','50','D','10','56',NULL,'CH7 First',NULL,NULL,'"drvCH7First"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EBERCBREXPZ0','50','D','10','57',NULL,'CH7 Last',NULL,NULL,'"drvCH7Last"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EBERCBREXPZ0','50','D','10','58',NULL,'CH7 SSN',NULL,NULL,'"drvCH7SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EBERCBREXPZ0','50','D','10','59',NULL,'CH7 DOB',NULL,NULL,'"drvCH7DOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EBERCBREXPZ0','50','D','10','60',NULL,'CH8 First',NULL,NULL,'"drvCH8First"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EBERCBREXPZ0','50','D','10','61',NULL,'CH8 Last',NULL,NULL,'"drvCH8Last"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EBERCBREXPZ0','50','D','10','62',NULL,'CH8 SSN',NULL,NULL,'"drvCH8SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EBERCBREXPZ0','50','D','10','63',NULL,'CH8 DOB',NULL,NULL,'"drvCH8DOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EBERCBREXPZ0','50','D','10','64',NULL,'CH9 First',NULL,NULL,'"drvCH9First"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EBERCBREXPZ0','50','D','10','65',NULL,'CH9 Last',NULL,NULL,'"drvCH9Last"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EBERCBREXPZ0','50','D','10','66',NULL,'CH9 SSN',NULL,NULL,'"drvCH9SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EBERCBREXPZ0','50','D','10','67',NULL,'CH9 DOB',NULL,NULL,'"drvCH9DOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EBERCBREXPZ0','50','D','10','68',NULL,'CH10 First',NULL,NULL,'"drvCH10First"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EBERCBREXPZ0','50','D','10','69',NULL,'CH10 Last',NULL,NULL,'"drvCH10Last"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EBERCBREXPZ0','50','D','10','70',NULL,'CH10 SSN',NULL,NULL,'"drvCH10SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EBERCBREXPZ0','50','D','10','71',NULL,'CH10 DOB',NULL,NULL,'"drvCH10DOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EBERCBREXPZ0','50','D','10','72',NULL,'CH11 First',NULL,NULL,'"drvCH11First"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EBERCBREXPZ0','50','D','10','73',NULL,'CH11 Last',NULL,NULL,'"drvCH11Last"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EBERCBREXPZ0','50','D','10','74',NULL,'CH11 SSN',NULL,NULL,'"drvCH11SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EBERCBREXPZ0','50','D','10','75',NULL,'CH11 DOB',NULL,NULL,'"drvCH11DOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EBERCBREXPZ0','50','D','10','76',NULL,'CH12 First',NULL,NULL,'"drvCH12First"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EBERCBREXPZ0','50','D','10','77',NULL,'CH12 Last',NULL,NULL,'"drvCH12Last"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EBERCBREXPZ0','50','D','10','78',NULL,'CH12 SSN',NULL,NULL,'"drvCH12SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EBERCBREXPZ0','50','D','10','79',NULL,'CH12 DOB',NULL,NULL,'"drvCH12DOB"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EBERCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL,'"drvPQBSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EBERCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL,'"drvPQBFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EBERCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL,'"drvPQBLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EBERCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL,'"drvPQBSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EBERCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL,'"drvPQBDOB"','(''UD110''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EBERCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL,'"drvPQBSSN2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EBERCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL,'"drvPQBFirstName2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EBERCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL,'"drvPQBLastName2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EBERCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL,'"drvPQBSex2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EBERCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL,'"drvPQBDOB2"','(''UD110''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EBERCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL,'"drvPQBSSN3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EBERCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL,'"drvPQBFirstName3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EBERCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL,'"drvPQBLastName3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EBERCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL,'"drvPQBSex3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EBERCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL,'"drvPQBDOB3"','(''UD110''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EBERCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL,'"drvPQBSSN4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EBERCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL,'"drvPQBFirstName4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EBERCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL,'"drvPQBLastName4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EBERCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL,'"drvPQBSex4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EBERCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL,'"drvPQBDOB4"','(''UD110''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EBERCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL,'"drvPQBSSN5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EBERCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL,'"drvPQBFirstName5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EBERCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL,'"drvPQBLastName5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EBERCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL,'"drvPQBSex5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EBERCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL,'"drvPQBDOB5"','(''UD110''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EBERCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL,'"drvPQBSSN6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EBERCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL,'"drvPQBFirstName6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EBERCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL,'"drvPQBLastName6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EBERCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL,'"drvPQBSex6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EBERCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL,'"drvPQBDOB6"','(''UD110''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EBERCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL,'"drvPQBSSN7"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EBERCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL,'"drvPQBFirstName7"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EBERCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL,'"drvPQBLastName7"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EBERCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL,'"drvPQBSex7"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EBERCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL,'"drvPQBDOB7"','(''UD110''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EBERCBREXPZ0','50','D','10','80',NULL,'SSN',NULL,NULL,'"drvPQBSSN8"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EBERCBREXPZ0','50','D','10','81',NULL,'First Name',NULL,NULL,'"drvPQBFirstName8"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EBERCBREXPZ0','50','D','10','82',NULL,'Last Name',NULL,NULL,'"drvPQBLastName8"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EBERCBREXPZ0','50','D','10','83',NULL,'Sex',NULL,NULL,'"drvPQBSex8"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EBERCBREXPZ0','50','D','10','84',NULL,'DOB',NULL,NULL,'"drvPQBDOB8"','(''UD110''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBERCBREXP_20211129.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TaxSaver COBRA QB Export','202005089','EMPEXPORT','ONDEMAND',NULL,'EBERCBREXP',NULL,NULL,NULL,'202005089','May  8 2020  3:58PM','May  8 2020  3:58PM','202005081',NULL,'','','202005081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','Y23F4,1KHF6,1KHLK,1KHQV,7DO7C,FB4R0',NULL,NULL,NULL,'Scheduled Session','202005199','EMPEXPORT','SCH_TCBRX',NULL,'EBERCBREXP',NULL,NULL,NULL,'202006249','May  8 2020  3:58PM','May  8 2020  3:58PM','202006171',NULL,'','','202005191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202101271','EMPEXPORT','TEST','Jan 27 2021  4:30PM','EBERCBREXP',NULL,NULL,NULL,'202101271','Jan 27 2021 12:00AM','Dec 30 1899 12:00AM','202012011','10','','','202012011',dbo.fn_GetTimedKey(),NULL,'us3mLaALK1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBERCBREXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBERCBREXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBERCBREXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBERCBREXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBERCBREXP','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBERCBREXP','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBERCBREXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBERCBREXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBERCBREXP','D10','dbo.U_EBERCBREXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EBERCBREXP
-----------

IF OBJECT_ID('U_dsi_BDM_EBERCBREXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBERCBREXP] (
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
-- Create table U_EBERCBREXP_Audit
-----------

IF OBJECT_ID('U_EBERCBREXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EBERCBREXP_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EBERCBREXP_AuditFields
-----------

IF OBJECT_ID('U_EBERCBREXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBERCBREXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EBERCBREXP_DedList
-----------

IF OBJECT_ID('U_EBERCBREXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EBERCBREXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL,
    [DedDesc] varchar(40) NULL
);

-----------
-- Create table U_EBERCBREXP_drvTbl
-----------

IF OBJECT_ID('U_EBERCBREXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBERCBREXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEmpSSN] char(11) NULL,
    [drvEmpFirstName] varchar(100) NULL,
    [drvEmpLastName] varchar(100) NULL,
    [drvEmpSex] char(1) NULL,
    [drvEmpDOB] datetime NULL,
    [drvEmpDivision] varchar(1) NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvOriginalEnrollmentDate] datetime NULL,
    [drvAEIEligible] varchar(1) NOT NULL,
    [drvUsesHCTC] varchar(1) NOT NULL,
    [drvAddress1] nvarchar(258) NULL,
    [drvAddress2] nvarchar(258) NULL,
    [drvCity] nvarchar(258) NULL,
    [drvStateorProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvMedicalPlan] varchar(40) NULL,
    [drvMedicalCoverage] varchar(11) NULL,
    [drvDentalPlan] varchar(20) NOT NULL,
    [drvDentalCoverage] varchar(11) NULL,
    [drvVisionPlan] varchar(11) NOT NULL,
    [Count_SPS] int NULL,
    [Count_CHL] int NULL,
    [Vision_BenOption] char(6) NULL,
    [drvVisionCoverage] varchar(11) NULL,
    [drvEAPPlan] varchar(3) NULL,
    [drvEAPCoverage] varchar(2) NULL,
    [drvFSA] varchar(1) NOT NULL,
    [drvFSAContrib] money NULL,
    [drvSpouseFirst] varchar(100) NULL,
    [drvSpouseLast] varchar(100) NULL,
    [drvSpouseSSN] char(11) NULL,
    [drvSpouseDOB] datetime NULL,
    [drvCH1First] varchar(100) NULL,
    [drvCH1Last] varchar(100) NULL,
    [drvCH1SSN] char(11) NULL,
    [drvCH1DOB] datetime NULL,
    [drvCH2First] varchar(100) NULL,
    [drvCH2Last] varchar(100) NULL,
    [drvCH2SSN] char(11) NULL,
    [drvCH2DOB] datetime NULL,
    [drvCH3First] varchar(100) NULL,
    [drvCH3Last] varchar(100) NULL,
    [drvCH3SSN] char(11) NULL,
    [drvCH3DOB] datetime NULL,
    [drvCH4First] varchar(100) NULL,
    [drvCH4Last] varchar(100) NULL,
    [drvCH4SSN] char(11) NULL,
    [drvCH4DOB] datetime NULL,
    [drvCH5First] varchar(100) NULL,
    [drvCH5Last] varchar(100) NULL,
    [drvCH5SSN] char(11) NULL,
    [drvCH5DOB] datetime NULL,
    [drvCH6First] varchar(100) NULL,
    [drvCH6Last] varchar(100) NULL,
    [drvCH6SSN] char(11) NULL,
    [drvCH6DOB] datetime NULL,
    [drvCH7First] varchar(100) NULL,
    [drvCH7Last] varchar(100) NULL,
    [drvCH7SSN] char(11) NULL,
    [drvCH7DOB] datetime NULL,
    [drvCH8First] varchar(100) NULL,
    [drvCH8Last] varchar(100) NULL,
    [drvCH8SSN] char(11) NULL,
    [drvCH8DOB] datetime NULL,
    [drvCH9First] varchar(100) NULL,
    [drvCH9Last] varchar(100) NULL,
    [drvCH9SSN] char(11) NULL,
    [drvCH9DOB] datetime NULL,
    [drvCH10First] varchar(100) NULL,
    [drvCH10Last] varchar(100) NULL,
    [drvCH10SSN] char(11) NULL,
    [drvCH10DOB] datetime NULL,
    [drvCH11First] varchar(100) NULL,
    [drvCH11Last] varchar(100) NULL,
    [drvCH11SSN] char(11) NULL,
    [drvCH11DOB] datetime NULL,
    [drvCH12First] varchar(100) NULL,
    [drvCH12Last] varchar(100) NULL,
    [drvCH12SSN] char(11) NULL,
    [drvCH12DOB] datetime NULL,
    [drvPQBSSN] char(11) NULL,
    [drvPQBFirstName] varchar(100) NULL,
    [drvPQBLastName] varchar(100) NULL,
    [drvPQBSex] char(1) NULL,
    [drvPQBDOB] datetime NULL,
    [drvPQBSSN2] char(11) NULL,
    [drvPQBFirstName2] varchar(100) NULL,
    [drvPQBLastName2] varchar(100) NULL,
    [drvPQBSex2] char(1) NULL,
    [drvPQBDOB2] datetime NULL,
    [drvPQBSSN3] char(11) NULL,
    [drvPQBFirstName3] varchar(100) NULL,
    [drvPQBLastName3] varchar(100) NULL,
    [drvPQBSex3] char(1) NULL,
    [drvPQBDOB3] datetime NULL,
    [drvPQBSSN4] char(11) NULL,
    [drvPQBFirstName4] varchar(100) NULL,
    [drvPQBLastName4] varchar(100) NULL,
    [drvPQBSex4] char(1) NULL,
    [drvPQBDOB4] datetime NULL,
    [drvPQBSSN5] char(11) NULL,
    [drvPQBFirstName5] varchar(100) NULL,
    [drvPQBLastName5] varchar(100) NULL,
    [drvPQBSex5] char(1) NULL,
    [drvPQBDOB5] datetime NULL,
    [drvPQBSSN6] char(11) NULL,
    [drvPQBFirstName6] varchar(100) NULL,
    [drvPQBLastName6] varchar(100) NULL,
    [drvPQBSex6] char(1) NULL,
    [drvPQBDOB6] datetime NULL,
    [drvPQBSSN7] char(11) NULL,
    [drvPQBFirstName7] varchar(100) NULL,
    [drvPQBLastName7] varchar(100) NULL,
    [drvPQBSex7] char(1) NULL,
    [drvPQBDOB7] datetime NULL,
    [drvPQBSSN8] char(11) NULL,
    [drvPQBFirstName8] varchar(100) NULL,
    [drvPQBLastName8] varchar(100) NULL,
    [drvPQBSex8] char(1) NULL,
    [drvPQBDOB8] datetime NULL
);

-----------
-- Create table U_EBERCBREXP_EEList
-----------

IF OBJECT_ID('U_EBERCBREXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EBERCBREXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBERCBREXP_File
-----------

IF OBJECT_ID('U_EBERCBREXP_File') IS NULL
CREATE TABLE [dbo].[U_EBERCBREXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBERCBREXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Berry Appleman

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 11/29/2021
Service Request Number: TekP-2021-07-27-0001

Purpose: TaxSaver COBRA QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBERCBREXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBERCBREXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBERCBREXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBERCBREXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBERCBREXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBERCBREXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBERCBREXP', 'TEST';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBERCBREXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBERCBREXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBERCBREXP';

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
    DELETE FROM dbo.U_EBERCBREXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBERCBREXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CGOAP,EPCGO,DNPPO,EPCDN,VIS,EPVSP,GLIFE,FSAMD';

    


    IF OBJECT_ID('U_EBERCBREXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBERCBREXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
        ,DedDesc =  DedLongDesc
    INTO dbo.U_EBERCBREXP_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CalcBenOptionDate', '1')

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC,COD');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'UpdDedType', 'FSA')
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


    --Audit tables --

    IF OBJECT_ID('U_EBERCBREXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBERCBREXP_AuditFields;
    CREATE TABLE dbo.U_EBERCBREXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EBERCBREXP_AuditFields VALUES ('EmpDed','EedBenOption');    
   
    
    -- Create audit table
    IF OBJECT_ID('U_EBERCBREXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBERCBREXP_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EBERCBREXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EBERCBREXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EBERCBREXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      --AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBERCBREXP_Audit ON dbo.U_EBERCBREXP_Audit (audKey1Value, audKey2Value);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBERCBREXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBERCBREXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBERCBREXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepssn
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvEmpSSN = eepSSN
        ,drvEmpFirstName = EepNameFirst
        ,drvEmpLastName = EepNameLast
        ,drvEmpSex = eepGender
        ,drvEmpDOB = EepDateOfBirth
        ,drvEmpDivision = ''
        ,drvEventType = CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                  WHEN EecTermReason = '203' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                  WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                  WHEN BdmCobraReason = '210' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                  WHEN BdmCobraReason IN ('203','202') THEN 'REDUCTIONINHOURSSTATUSCHANGE '
                                  WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                  WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURSENDOFLEAVE'
                                  WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                  WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                  WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                  WHEN EecEmplStatus = 'T' and eectermtype  = 'I' THEN 'INVOLUNTARYTERMINATION'
                                  ELSE 'TERMINATION'
                             END
        ,drvEventDate =  CASE 
                                  WHEN BdmCobraReason IN ('204','210','LEVNT4','LEVNT3') THEN (select top 1 EjhJobEffDate from emphjob where ejheeid = xeeid and ejhcoid =  xcoid order by ejhdatetimecreated desc)
                                  ELSE CobraEnventdate
                             END
                             
        ,drvOriginalEnrollmentDate = bdmbenstartdate
        ,drvAEIEligible = 'N'
        ,drvUsesHCTC = 'N'
        ,drvAddress1 = Quotename(EepAddressLine1,'"')
        ,drvAddress2 = Quotename(EepAddressLine2,'"')
        ,drvCity = Quotename(EepAddressCity,'"')
        ,drvStateorProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountry = ''

        ,drvMedicalPlan = CASE WHEN HDHP  is not null then (Select DedDesc from  dbo.U_EBERCBREXP_DedList where dedcode =  hdhp)
                               
                               ELSE 'NONE'
                         END
        ,drvMedicalCoverage = CASE WHEN (HDHP is not null )  THEN
                                        CASE WHEN ( HDHP_BenOption = 'EE') THEN 'EE'
                                             WHEN (HDHP_BenOption IN ('EES')) THEN 'EE+SPOUSE'
                                             WHEN ( HDHP_BenOption IN ('EEC') ) THEN 'EE+CHILDREN'
                                             WHEN ( HDHP_BenOption IN ('EEF') ) THEN 'EE+FAMILY'
                                        END
                              END
        ,drvDentalPlan = CASE WHEN DENHI  is not null THEN  'Dental High MAC Plan'
                              WHEN DENLO   is not null THEN  'Dental Low MAC Plan'
                            ELSE 'NONE' END 
        ,drvDentalCoverage = CASE WHEN (DENHI is not null or DENLO is not null)  THEN
                                        CASE WHEN (DENHI_BenOption = 'EE' or DENLO_BenOption = 'EE') THEN 'EE'
                                             WHEN (DENHI_BenOption IN ('EES') or DENLO_BenOption IN ('EES') ) THEN 'EE+SPOUSE'
                                             WHEN (DENHI_BenOption IN ('EEC') or DENLO_BenOption IN ('EEC') ) THEN 'EE+CHILDREN'
                                             WHEN (DENHI_BenOption IN ('EEF') or DENLO_BenOption IN ('EEF') ) THEN 'EE+FAMILY'
                                        END
                              END
        ,drvVisionPlan = CASE WHEN Vision is not null then 'Vision Plan' ELSE 'NONE' END
        ,Count_SPS
        ,Count_CHL
        ,Vision_BenOption
        ,drvVisionCoverage = CASE WHEN Vision is not null  THEN
                                    CASE WHEN Vision_BenOption = 'EE' THEN 'EE'
                                         WHEN Vision_BenOption = 'EES' THEN 'EE+SPOUSE'
                                         WHEN Vision_BenOption = 'EEC'  THEN 'EE+CHILDREN'
                                         WHEN Vision_BenOption = 'EEF'  THEN 'EE+FAMILY'

                                    END 
                             END
        ,drvEAPPlan = CASE WHEN GLIFE is not null then  'EAP' END
        ,drvEAPCoverage = CASE WHEN GLIFE is not null then  'EE' END
        ,drvFSA = CASE WHEN FSA is not null then 'Y' ELSE 'N' END    
        ,drvFSAContrib = CASE WHEN FSA is not null then FSA_GoalAmt END   
        ,drvSpouseFirst = SPSFirstName
        ,drvSpouseLast = SPSLastName
        ,drvSpouseSSN = SPSssn
        ,drvSpouseDOB = SPSDateOfBirth
        ,drvCH1First = DepFirstName1
        ,drvCH1Last = DepLastName1
        ,drvCH1SSN = DepSsn1
        ,drvCH1DOB = DepDateOfBirth1
        ,drvCH2First = DepFirstName2
        ,drvCH2Last = DepLastName2
        ,drvCH2SSN = DepSsn2
        ,drvCH2DOB = DepDateOfBirth2
        ,drvCH3First = DepFirstName3
        ,drvCH3Last = DepLastName3
        ,drvCH3SSN = DepSsn3
        ,drvCH3DOB = DepDateOfBirth3
        ,drvCH4First = DepFirstName4
        ,drvCH4Last = DepLastName4
        ,drvCH4SSN = DepSsn4
        ,drvCH4DOB = DepDateOfBirth4
        ,drvCH5First = DepFirstName5
        ,drvCH5Last = DepLastName5
        ,drvCH5SSN = DepSsn5
        ,drvCH5DOB = DepDateOfBirth5
        ,drvCH6First = DepFirstName6
        ,drvCH6Last = DepLastName6
        ,drvCH6SSN = DepSsn6
        ,drvCH6DOB = DepDateOfBirth6
        ,drvCH7First = DepFirstName7
        ,drvCH7Last = DepLastName7
        ,drvCH7SSN = DepSsn7
        ,drvCH7DOB = DepDateOfBirth7
        ,drvCH8First = DepFirstName8
        ,drvCH8Last = DepLastName8
        ,drvCH8SSN = DepSsn8
        ,drvCH8DOB = DepDateOfBirth8
        ,drvCH9First = DepFirstName9
        ,drvCH9Last = DepLastName9
        ,drvCH9SSN = DepSsn9
        ,drvCH9DOB = DepDateOfBirth9
        ,drvCH10First = DepFirstName10
        ,drvCH10Last = DepLastName10
        ,drvCH10SSN = DepSsn10
        ,drvCH10DOB = DepDateOfBirth10
        ,drvCH11First = DepFirstName11
        ,drvCH11Last = DepLastName11
        ,drvCH11SSN = DepSsn11
        ,drvCH11DOB = DepDateOfBirth11
        ,drvCH12First = DepFirstName12
        ,drvCH12Last = DepLastName12
        ,drvCH12SSN = DepSsn12
        ,drvCH12DOB = DepDateOfBirth12
        ,drvPQBSSN = ssn1
        ,drvPQBFirstName = firstname1
        ,drvPQBLastName = lastname1
        ,drvPQBSex = gender1
        ,drvPQBDOB = birthday1
        ,drvPQBSSN2 = ssn2
        ,drvPQBFirstName2 = firstname2
        ,drvPQBLastName2 = lastname2
        ,drvPQBSex2 = gender2
        ,drvPQBDOB2 = birthday2
        ,drvPQBSSN3 = ssn3
        ,drvPQBFirstName3 = firstname3
        ,drvPQBLastName3 = lastname3
        ,drvPQBSex3 = gender3
        ,drvPQBDOB3 = birthday3
        ,drvPQBSSN4 = ssn4
        ,drvPQBFirstName4 = firstname4
        ,drvPQBLastName4 = lastname4
        ,drvPQBSex4 = gender4
        ,drvPQBDOB4 = birthday4
        ,drvPQBSSN5 = ssn5
        ,drvPQBFirstName5 = firstname5
        ,drvPQBLastName5 = lastname5
        ,drvPQBSex5 = gender5
        ,drvPQBDOB5 = birthday5
        ,drvPQBSSN6 = ssn6
        ,drvPQBFirstName6 = firstname6
        ,drvPQBLastName6 = lastname6
        ,drvPQBSex6 = gender6
        ,drvPQBDOB6 = birthday6
        ,drvPQBSSN7 = ssn7
        ,drvPQBFirstName7 = firstname7
        ,drvPQBLastName7 = lastname7
        ,drvPQBSex7 = gender7
        ,drvPQBDOB7 = birthday7
        ,drvPQBSSN8 = ssn8
        ,drvPQBFirstName8 = firstname8
        ,drvPQBLastName8 = lastname8
        ,drvPQBSex8 = gender8
        ,drvPQBDOB8 = birthday8
    INTO dbo.U_EBERCBREXP_drvTbl
    FROM dbo.U_EBERCBREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
      JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xeeid
       AND EecCoID = xcoid
    JOIN (Select  A.bdmEEID,A.bdmcoid,
            GLIFE  = MAX((CASE WHEN BDMDedCode In ('GLIFE') then BDMDedCode END))
            ,HDHP = MAX((CASE WHEN BDMDedCode In ('CGOAP','EPCGO') then BDMDedCode END))
            ,Vision = MAX((CASE WHEN BDMDedCode IN ('VIS','EPVSP') then BDMDedCode END))
            ,DENHI  = MAX((CASE WHEN BDMDedCode = 'DNPPO' then 'DNPPO' END))
            ,DENLO   = MAX((CASE WHEN BDMDedCode = 'EPCDN ' then 'EPCDN ' END))

            ,Vision_startdate = MAX((CASE WHEN BDMDedCode IN ('VIS','EPVSP')then bdmbenstartdate END))
            ,DENHI_startdate = MAX((CASE WHEN BDMDedCode = 'DNPPO' then bdmbenstartdate END))
            ,DENLO_startdate = MAX((CASE WHEN BDMDedCode = 'EPCDN' then bdmbenstartdate END))

            ,HDHP_benoption = MAX((CASE WHEN BDMDedCode In ('CGOAP','EPCGO') then BdmBenOption END))
            ,Vision_benoption = MAX((CASE WHEN BDMDedCode IN ('VIS','EPVSP')then BdmBenOption END))
            ,DENHI_benoption = MAX((CASE WHEN BDMDedCode = 'DNPPO' then BdmBenOption END))
            ,DENLO_benoption = MAX((CASE WHEN BDMDedCode = 'EPCDN' then BdmBenOption END))
            ,FSA = MAX((CASE WHEN BDMDedCode = 'FSAMD ' then 'FSAMD' END))

            ,FSA_GoalAmt = MAX((CASE WHEN BDMDedCode = 'FSAMD' then BdmEEGoalAmt END))
            ,CobraEnventdate = MAX(BdmDateOfCOBRAEvent) 
            ,CobraStatusDate = MAX(BdmBenStatusDate) 
            ,BdmCobraReason = MAX(BdmCobraReason) 
            ,bdmbenstartdate = max(bdmbenstartdate)
            ,MAX(CASE WHEN Number = 1 THEN firstname END) AS firstname1
            ,MAX(CASE WHEN Number = 1 THEN lastname END) AS lastname1
            ,MAX(CASE WHEN Number = 1 THEN ssn END) AS ssn1
            ,MAX(CASE WHEN Number = 1 THEN birthday END) AS birthday1
            ,MAX(CASE WHEN Number = 1 THEN gender END) AS gender1
            ,MAX(CASE WHEN Number = 2 THEN firstname END) AS firstname2
            ,MAX(CASE WHEN Number = 2 THEN lastname END) AS lastname2
            ,MAX(CASE WHEN Number = 2 THEN ssn END) AS ssn2
            ,MAX(CASE WHEN Number = 2 THEN birthday END) AS birthday2
            ,MAX(CASE WHEN Number = 2 THEN gender END) AS gender2
            ,MAX(CASE WHEN Number = 3 THEN firstname END) AS firstname3
            ,MAX(CASE WHEN Number = 3 THEN lastname END) AS lastname3
            ,MAX(CASE WHEN Number = 3 THEN ssn END) AS ssn3
            ,MAX(CASE WHEN Number = 3 THEN birthday END) AS birthday3
            ,MAX(CASE WHEN Number = 3 THEN gender END) AS gender3
            ,MAX(CASE WHEN Number = 4 THEN firstname END) AS firstname4
            ,MAX(CASE WHEN Number = 4 THEN lastname END) AS lastname4
            ,MAX(CASE WHEN Number = 4 THEN ssn END) AS ssn4
            ,MAX(CASE WHEN Number = 4 THEN birthday END) AS birthday4
            ,MAX(CASE WHEN Number = 4 THEN gender END) AS gender4
            ,MAX(CASE WHEN Number = 5 THEN firstname END) AS firstname5
            ,MAX(CASE WHEN Number = 5 THEN lastname END) AS lastname5
            ,MAX(CASE WHEN Number = 5 THEN ssn END) AS ssn5
            ,MAX(CASE WHEN Number = 5 THEN birthday END) AS birthday5
            ,MAX(CASE WHEN Number = 5 THEN gender END) AS gender5
            ,MAX(CASE WHEN Number = 6 THEN firstname END) AS firstname6
            ,MAX(CASE WHEN Number = 6 THEN lastname END) AS lastname6
            ,MAX(CASE WHEN Number = 6 THEN ssn END) AS ssn6
            ,MAX(CASE WHEN Number = 6 THEN birthday END) AS birthday6
            ,MAX(CASE WHEN Number = 6 THEN gender END) AS gender6
            ,MAX(CASE WHEN Number = 7 THEN firstname END) AS firstname7
            ,MAX(CASE WHEN Number = 7 THEN lastname END) AS lastname7
            ,MAX(CASE WHEN Number = 7 THEN ssn END) AS ssn7
            ,MAX(CASE WHEN Number = 7 THEN birthday END) AS birthday7
            ,MAX(CASE WHEN Number = 7 THEN gender END) AS gender7
            ,MAX(CASE WHEN Number = 8 THEN firstname END) AS firstname8
            ,MAX(CASE WHEN Number = 8 THEN lastname END) AS lastname8
            ,MAX(CASE WHEN Number = 8 THEN ssn END) AS ssn8
            ,MAX(CASE WHEN Number = 8 THEN birthday END) AS birthday8
            ,MAX(CASE WHEN Number = 8 THEN gender END) AS gender8
            ,Count(CASE WHEN BdmRelationship IN ('SPS') and BdmDedcode = 'V' then 1 END) AS  Count_SPS
            ,Count(CASE WHEN BdmRelationship IN ('CHL') and BdmDedcode = 'V' then 1 END) AS  Count_CHL

            from dbo.U_dsi_BDM_EBERCBREXP A
            JOIN  (
            Select  bdmeeid,bdmdeprecid,
        case when bdmdeprecid is null then eepSSN else conSSN end as ssn,
        case when bdmdeprecid is null then eepNameFirst else ConNamefirst end as firstName,
        case when bdmdeprecid is null then eepNameLast else ConNamelast end as lastname,
        case when bdmdeprecid is null then eepDateOfBirth else ConDateOfBirth end as birthday,
        case when bdmdeprecid is null then eepGender else conGender end as gender,
 ROW_NUMBER() OVER (PARTITION BY bdmeeid order by  bdmeeid) AS 'Number' 
    from  U_dsi_BDM_EBERCBREXP A 
        JOIN dbo.EmpPers WITH (NOLOCK) 
        ON EepEEID = bdmeeid
        LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON ConEEID = bdmeeid 
        AND ConSystemID = BdmDepRecID
       WHERE A.bdmisPQB = 'Y'
 Group By bdmeeid,bdmDepRecId,
 case when bdmdeprecid is null then eepSSN else conSSN end,
 case when bdmdeprecid is null then eepNameFirst else ConNamefirst end, 
 case when bdmdeprecid is null then eepNameLast else ConNameLast end,
 case when bdmdeprecid is null then eepDateOfBirth else ConDateOfBirth end,
 case when bdmdeprecid is null then eepGender else conGender end
            ) B
            ON B.BdmEEID = A.bdmeeID
            group by A.bdmEEID,A.bdmcoid) as ConsolidatedBDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (Select bdmeeid AS KidEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS DepLastName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS DepFirstName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS DepSsn1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS DepDateOfBirth1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS DepRelationship1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameLast END) AS DepLastName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameFirst END) AS DepFirstName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConSSN END) AS DepSsn2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConDateOfBirth END) AS DepDateOfBirth2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConRelationship END) AS DepRelationship2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameLast END) AS DepLastName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameFirst END) AS DepFirstName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConSSN END) AS DepSsn3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConDateOfBirth END) AS DepDateOfBirth3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConRelationship END) AS DepRelationship3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameLast END) AS DepLastName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameFirst END) AS DepFirstName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConSSN END) AS DepSsn4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConDateOfBirth END) AS DepDateOfBirth4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConRelationship END) AS DepRelationship4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameLast END) AS DepLastName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameFirst END) AS DepFirstName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConSSN END) AS DepSsn5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConDateOfBirth END) AS DepDateOfBirth5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConRelationship END) AS DepRelationship5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameLast END) AS DepLastName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameFirst END) AS DepFirstName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConSSN END) AS DepSsn6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConDateOfBirth END) AS DepDateOfBirth6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConRelationship END) AS DepRelationship6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameLast END) AS DepLastName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameFirst END) AS DepFirstName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConSSN END) AS DepSsn7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConDateOfBirth END) AS DepDateOfBirth7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConRelationship END) AS DepRelationship7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameLast END) AS DepLastName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameFirst END) AS DepFirstName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConSSN END) AS DepSsn8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConDateOfBirth END) AS DepDateOfBirth8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConRelationship END) AS DepRelationship8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameLast END) AS DepLastName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameFirst END) AS DepFirstName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConSSN END) AS DepSsn9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConDateOfBirth END) AS DepDateOfBirth9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConRelationship END) AS DepRelationship9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameLast END) AS DepLastName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameFirst END) AS DepFirstName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConSSN END) AS DepSsn10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConDateOfBirth END) AS DepDateOfBirth10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConRelationship END) AS DepRelationship10
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameLast END) AS DepLastName11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameFirst END) AS DepFirstName11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConSSN END) AS DepSsn11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConDateOfBirth END) AS DepDateOfBirth11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConRelationship END) AS DepRelationship11
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConNameLast END) AS DepLastName12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConNameFirst END) AS DepFirstName12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConSSN END) AS DepSsn12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConDateOfBirth END) AS DepDateOfBirth12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConRelationship END) AS DepRelationship12
            ,Count(CASE WHEN ConRelationship IN ('DAU', 'SON', 'DIS', 'STC','CHL') THEN Dep_Number END) as Child_Counts

        From (
                select bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship, ROW_NUMBER() OVER (PARTITION BY bdmeeid ORDER BY bdmeeid) AS 'Dep_Number'
                from  dbo.U_dsi_BDM_EBERCBREXP A 
                JOIN dbo.Contacts WITH (NOLOCK) 
                ON ConEEID = bdmeeid 
                AND ConSystemID = BdmDepRecID
                where bdmrelationship IN ('CHL') and bdmdedcode in ('CGOAP', 'EPCGO', 'DNPPO', 'EPCDN', 'VIS' , 'EPVSP'  ) 
                    group by bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship
                    ) AS Source Group By bdmeeid)
         AS DepList on KidEEID = xEEID
         LEFT JOIN (Select bdmeeid AS SPSEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS SPSLastName
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS SPSFirstName
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS SPSSsn
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS SPSDateOfBirth
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS SPSRelationship
            ,Count(CASE WHEN ConRelationship IN ('SPS') THEN Dep_Number END) as SPS_Counts

        From (
                select bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship, ROW_NUMBER() OVER (PARTITION BY bdmeeid ORDER BY bdmeeid) AS 'Dep_Number'
                from  dbo.U_dsi_BDM_EBERCBREXP A 
                JOIN dbo.Contacts WITH (NOLOCK) 
                ON ConEEID = bdmeeid 
                AND ConSystemID = BdmDepRecID
                where bdmrelationship IN ('SPS','DP') and bdmdedcode in ('CGOAP', 'EPCGO', 'DNPPO', 'EPCDN', 'VIS' , 'EPVSP')
                    group by bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship
                    ) AS Source Group By bdmeeid) As Spouse
                on xeeid = Spouse.SPSEEID

        Update dbo.U_EBERCBREXP_drvTbl set drvEAPCoverage = '' where drvEAPPlan = 'NONE';


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
ALTER VIEW dbo.dsi_vwEBERCBREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBERCBREXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBERCBREXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005011'
       ,expStartPerControl     = '202005011'
       ,expLastEndPerControl   = '202005089'
       ,expEndPerControl       = '202005089'
WHERE expFormatCode = 'EBERCBREXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBERCBREXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBERCBREXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBERCBREXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBERCBREXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBERCBREXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBERCBREXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBERCBREXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBERCBREXP', 'UseFileName', 'V', 'Y'


-- End ripout