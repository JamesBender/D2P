/**********************************************************************************

ECRSAPAEXP: APA Cobra Export

FormatCode:     ECRSAPAEXP
Project:        APA Cobra Export
Client ID:      CRO1008
Date/time:      2021-12-29 20:37:57.210
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB01
Database:       ULTIPRO_WPCROS
Web Filename:   CRO1008_7QAC2_EEHISTORY_ECRSAPAEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECRSAPAEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ECRSAPAEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECRSAPAEXP'


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
WHERE FormatCode = 'ECRSAPAEXP'
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
WHERE ExpFormatCode = 'ECRSAPAEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECRSAPAEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECRSAPAEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECRSAPAEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECRSAPAEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECRSAPAEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECRSAPAEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECRSAPAEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECRSAPAEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECRSAPAEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECRSAPAEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECRSAPAEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECRSAPAEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECRSAPAEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRSAPAEXP];
GO
IF OBJECT_ID('U_ECRSAPAEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECRSAPAEXP_File];
GO
IF OBJECT_ID('U_ECRSAPAEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECRSAPAEXP_EEList];
GO
IF OBJECT_ID('U_ECRSAPAEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECRSAPAEXP_drvTbl];
GO
IF OBJECT_ID('U_ECRSAPAEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECRSAPAEXP_DedList];
GO
IF OBJECT_ID('U_ECRSAPAEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECRSAPAEXP_AuditFields];
GO
IF OBJECT_ID('U_ECRSAPAEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECRSAPAEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECRSAPAEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECRSAPAEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECRSAPAEXP','APA Cobra Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','5000','S','N','ECRSAPAEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECRSAPAEXPZ0','50','H','01','1',NULL,'Business Unit Name',NULL,NULL,'"Business Unit Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECRSAPAEXPZ0','50','H','01','1',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECRSAPAEXPZ0','50','H','01','2',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECRSAPAEXPZ0','50','H','01','3',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECRSAPAEXPZ0','50','H','01','3',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECRSAPAEXPZ0','50','H','01','4',NULL,'Sex',NULL,NULL,'"Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECRSAPAEXPZ0','50','H','01','5',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECRSAPAEXPZ0','50','H','01','12',NULL,'Address',NULL,NULL,'"Address"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECRSAPAEXPZ0','50','H','01','14',NULL,'City',NULL,NULL,'"City"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECRSAPAEXPZ0','50','H','01','15',NULL,'State',NULL,NULL,'"State"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECRSAPAEXPZ0','50','H','01','16',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECRSAPAEXPZ0','50','H','01','16',NULL,'Date of Hire',NULL,NULL,'"Date of Hire"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECRSAPAEXPZ0','50','H','01','18',NULL,'Medical Plan',NULL,NULL,'"Medical Plan"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECRSAPAEXPZ0','50','H','01','19',NULL,'Medical Tier',NULL,NULL,'"Medical Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECRSAPAEXPZ0','50','H','01','19',NULL,'Medical Effective Date',NULL,NULL,'"Medical Effective Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECRSAPAEXPZ0','50','H','01','18',NULL,'Dental Plan',NULL,NULL,'"Dental Plan"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECRSAPAEXPZ0','50','H','01','19',NULL,'Dental Tier',NULL,NULL,'"Dental Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECRSAPAEXPZ0','50','H','01','19',NULL,'Dental Effective Date',NULL,NULL,'"Dental Effective Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECRSAPAEXPZ0','50','H','01','18',NULL,'Vision Plan',NULL,NULL,'"Vision Plan"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECRSAPAEXPZ0','50','H','01','19',NULL,'Vision Tier',NULL,NULL,'"Vision Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECRSAPAEXPZ0','50','H','01','19',NULL,'MedicVisional Effective Date',NULL,NULL,'"Vision Effective Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECRSAPAEXPZ0','50','H','01','8',NULL,'Active or COBRA',NULL,NULL,'"Active or COBRA"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECRSAPAEXPZ0','50','H','01','7',NULL,'Event Type',NULL,NULL,'"Type of Qualifying Event (Event Type i.e Termination)"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECRSAPAEXPZ0','50','H','01','7',NULL,'Event Type',NULL,NULL,'"Date of Qualifying Event if on COBRA"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECRSAPAEXPZ0','50','H','01','30',NULL,'Month of Last COBRA Payment Made',NULL,NULL,'"Month of Last COBRA Payment Made"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECRSAPAEXPZ0','50','H','01','30',NULL,'Spouse SSN',NULL,NULL,'"Spouse SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECRSAPAEXPZ0','50','H','01','29',NULL,'Spouse Last',NULL,NULL,'"Spouse Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECRSAPAEXPZ0','50','H','01','28',NULL,'Spouse First',NULL,NULL,'"Spouse First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECRSAPAEXPZ0','50','H','01','31',NULL,'Spouse DOB',NULL,NULL,'"Spouse DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECRSAPAEXPZ0','50','H','01','31',NULL,'Spouse DOB',NULL,NULL,'"Spouse Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECRSAPAEXPZ0','50','H','01','34',NULL,'CH1 SSN',NULL,NULL,'"Dep 1 SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECRSAPAEXPZ0','50','H','01','32',NULL,'Dep 1 Last Name',NULL,NULL,'"Dep 1 Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECRSAPAEXPZ0','50','H','01','33',NULL,'Dep 1 First Name',NULL,NULL,'"Dep 1 First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 1 DOB"',NULL,NULL,'"Dep 1 DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 1 Gender"',NULL,NULL,'"Dep 1 Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECRSAPAEXPZ0','50','H','01','34',NULL,'CH2 SSN',NULL,NULL,'"Dep 2 SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECRSAPAEXPZ0','50','H','01','32',NULL,'Dep 2 Last Name',NULL,NULL,'"Dep 2 Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECRSAPAEXPZ0','50','H','01','33',NULL,'Dep 2 First Name',NULL,NULL,'"Dep 2 First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 2 DOB"',NULL,NULL,'"Dep 2 DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 1 Gender"',NULL,NULL,'"Dep 2 Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECRSAPAEXPZ0','50','H','01','34',NULL,'CH3 SSN',NULL,NULL,'"Dep 3 SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECRSAPAEXPZ0','50','H','01','32',NULL,'Dep 3 Last Name',NULL,NULL,'"Dep 3 Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECRSAPAEXPZ0','50','H','01','33',NULL,'Dep 3 First Name',NULL,NULL,'"Dep 3 First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 23 DOB"',NULL,NULL,'"Dep 3 DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 1 Gender"',NULL,NULL,'"Dep 3 Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECRSAPAEXPZ0','50','H','01','34',NULL,'CH4 SSN',NULL,NULL,'"Dep 4 SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECRSAPAEXPZ0','50','H','01','32',NULL,'Dep 4 Last Name',NULL,NULL,'"Dep 4 Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECRSAPAEXPZ0','50','H','01','33',NULL,'Dep 4 First Name',NULL,NULL,'"Dep 4 First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 4 DOB"',NULL,NULL,'"Dep 4 DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 1 Gender"',NULL,NULL,'"Dep 4 Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECRSAPAEXPZ0','50','H','01','34',NULL,'CH5 SSN',NULL,NULL,'"Dep 5 SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECRSAPAEXPZ0','50','H','01','32',NULL,'Dep 5 Last Name',NULL,NULL,'"Dep 5 Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECRSAPAEXPZ0','50','H','01','33',NULL,'Dep 5 First Name',NULL,NULL,'"Dep 5 First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 5 DOB"',NULL,NULL,'"Dep 5 DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 1 Gender"',NULL,NULL,'"Dep 5 Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECRSAPAEXPZ0','50','H','01','34',NULL,'CH6 SSN',NULL,NULL,'"Dep 6 SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ECRSAPAEXPZ0','50','H','01','32',NULL,'Dep 26 Last Name',NULL,NULL,'"Dep 6 Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ECRSAPAEXPZ0','50','H','01','33',NULL,'Dep 6 First Name',NULL,NULL,'"Dep 6 First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 6 DOB"',NULL,NULL,'"Dep 6 DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 1 Gender"',NULL,NULL,'"Dep 6 Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ECRSAPAEXPZ0','50','H','01','34',NULL,'CH7 SSN',NULL,NULL,'"Dep 7 SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ECRSAPAEXPZ0','50','H','01','32',NULL,'Dep 7 Last Name',NULL,NULL,'"Dep 7 Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ECRSAPAEXPZ0','50','H','01','33',NULL,'Dep 27 First Name',NULL,NULL,'"Dep 7 First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 7 DOB"',NULL,NULL,'"Dep 7 DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 1 Gender"',NULL,NULL,'"Dep 7 Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ECRSAPAEXPZ0','50','H','01','34',NULL,'CH28 SSN',NULL,NULL,'"Dep 8 SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ECRSAPAEXPZ0','50','H','01','32',NULL,'Dep 8 Last Name',NULL,NULL,'"Dep 8 Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ECRSAPAEXPZ0','50','H','01','33',NULL,'Dep 8 First Name',NULL,NULL,'"Dep 8 First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 8 DOB"',NULL,NULL,'"Dep 8 DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ECRSAPAEXPZ0','50','H','01','35',NULL,'Dep 1 Gender"',NULL,NULL,'"Dep 8 Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECRSAPAEXPZ0','50','D','10','1',NULL,'SSN',NULL,NULL,'"drvBusinessUnitName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECRSAPAEXPZ0','50','D','10','1',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECRSAPAEXPZ0','50','D','10','2',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECRSAPAEXPZ0','50','D','10','3',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECRSAPAEXPZ0','50','D','10','3',NULL,'MiddleName',NULL,NULL,'"drvMiddleName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECRSAPAEXPZ0','50','D','10','4',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECRSAPAEXPZ0','50','D','10','5',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECRSAPAEXPZ0','50','D','10','12',NULL,'Address',NULL,NULL,'"drvAddress"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECRSAPAEXPZ0','50','D','10','14',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECRSAPAEXPZ0','50','D','10','15',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECRSAPAEXPZ0','50','D','10','16',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECRSAPAEXPZ0','50','D','10','16',NULL,'Zip',NULL,NULL,'"drvDateofHire"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECRSAPAEXPZ0','50','D','10','18',NULL,'MedicalPlan',NULL,NULL,'"drvMedicalPlan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECRSAPAEXPZ0','50','D','10','19',NULL,'MedicalTier',NULL,NULL,'"drvMedicalTier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECRSAPAEXPZ0','50','D','10','19',NULL,'MedicalEffectiveUAte',NULL,NULL,'"drvMedicalEffectiveDate"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECRSAPAEXPZ0','50','D','10','18',NULL,'DentalPlan',NULL,NULL,'"drvDentalPlan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECRSAPAEXPZ0','50','D','10','19',NULL,'DentalTier',NULL,NULL,'"drvDentalTier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECRSAPAEXPZ0','50','D','10','19',NULL,'DentalEffectiveUAte',NULL,NULL,'"drvDentalEffectivedate"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECRSAPAEXPZ0','50','D','10','18',NULL,'VisionPlan',NULL,NULL,'"drvVisionPlan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECRSAPAEXPZ0','50','D','10','19',NULL,'VisionTier',NULL,NULL,'"drvVisionTier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECRSAPAEXPZ0','50','D','10','19',NULL,'MedicVisionalEffectiveUAte',NULL,NULL,'"drvVisionEffectivedate"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECRSAPAEXPZ0','50','D','10','8',NULL,'ActiveorCOBRA',NULL,NULL,'"drvActiveorCOBRA"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECRSAPAEXPZ0','50','D','10','7',NULL,'EventType',NULL,NULL,'"drvQualifyingEvent"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECRSAPAEXPZ0','50','D','10','7',NULL,'EventType',NULL,NULL,'"drvQaualifyingEventDate"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECRSAPAEXPZ0','50','D','10','7',NULL,'EventType',NULL,NULL,'"drvLastMonth"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECRSAPAEXPZ0','50','D','10','30',NULL,'SpouseSSN',NULL,NULL,'"drvSpouseSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECRSAPAEXPZ0','50','D','10','29',NULL,'SpouseLast',NULL,NULL,'"drvSpouseLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECRSAPAEXPZ0','50','D','10','28',NULL,'SpouseFirst',NULL,NULL,'"drvSpouseFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECRSAPAEXPZ0','50','D','10','31',NULL,'SpouseDOB',NULL,NULL,'"drvSpouseDOB"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECRSAPAEXPZ0','50','D','10','31',NULL,'SpouseDOB',NULL,NULL,'"drvSpouseGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECRSAPAEXPZ0','50','D','10','34',NULL,'CH1SSN',NULL,NULL,'"drvDep1SSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECRSAPAEXPZ0','50','D','10','32',NULL,'Dep1LastName',NULL,NULL,'"drvDep1LastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECRSAPAEXPZ0','50','D','10','33',NULL,'Dep1FirstName',NULL,NULL,'"drvDep1FirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep1DOB"',NULL,NULL,'"drvDep1DOB"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep1Gender"',NULL,NULL,'"drvDep1Gender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECRSAPAEXPZ0','50','D','10','34',NULL,'CH2SSN',NULL,NULL,'"drvDep2SSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECRSAPAEXPZ0','50','D','10','32',NULL,'Dep2LastName',NULL,NULL,'"drvDep2LastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECRSAPAEXPZ0','50','D','10','33',NULL,'Dep2FirstName',NULL,NULL,'"drvDep2FirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep2DOB"',NULL,NULL,'"drvDep2DOB"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep1Gender"',NULL,NULL,'"drvDep2Gender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECRSAPAEXPZ0','50','D','10','34',NULL,'CH3SSN',NULL,NULL,'"drvDep3SSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECRSAPAEXPZ0','50','D','10','32',NULL,'Dep3LastName',NULL,NULL,'"drvDep3LastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECRSAPAEXPZ0','50','D','10','33',NULL,'Dep3FirstName',NULL,NULL,'"drvDep3FirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep23DOB"',NULL,NULL,'"drvDep3DOB"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep1Gender"',NULL,NULL,'"drvDep3Gender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECRSAPAEXPZ0','50','D','10','34',NULL,'CH4SSN',NULL,NULL,'"drvDep4SSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECRSAPAEXPZ0','50','D','10','32',NULL,'Dep4LastName',NULL,NULL,'"drvDep4LastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECRSAPAEXPZ0','50','D','10','33',NULL,'Dep4FirstName',NULL,NULL,'"drvDep4FirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep4DOB"',NULL,NULL,'"drvDep4DOB"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep1Gender"',NULL,NULL,'"drvDep4Gender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECRSAPAEXPZ0','50','D','10','34',NULL,'CH5SSN',NULL,NULL,'"drvDep5SSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECRSAPAEXPZ0','50','D','10','32',NULL,'Dep5LastName',NULL,NULL,'"drvDep5LastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECRSAPAEXPZ0','50','D','10','33',NULL,'Dep5FirstName',NULL,NULL,'"drvDep5FirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep4DOB"',NULL,NULL,'"drvDep5DOB"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep1Gender"',NULL,NULL,'"drvDep5Gender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECRSAPAEXPZ0','50','D','10','34',NULL,'CH6SSN',NULL,NULL,'"drvDep6SSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ECRSAPAEXPZ0','50','D','10','33',NULL,'Dep6FirstName',NULL,NULL,'"drvDep6LastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ECRSAPAEXPZ0','50','D','10','33',NULL,'Dep6FirstName',NULL,NULL,'"drvDep6FirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep6DOB"',NULL,NULL,'"drvDep6DOB"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep1Gender"',NULL,NULL,'"drvDep6Gender"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ECRSAPAEXPZ0','50','D','10','34',NULL,'CH7SSN',NULL,NULL,'"drvDep7SSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ECRSAPAEXPZ0','50','D','10','32',NULL,'Dep7LastName',NULL,NULL,'"drvDep7LastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ECRSAPAEXPZ0','50','D','10','33',NULL,'Dep27FirstName',NULL,NULL,'"drvDep7FirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep7DOB"',NULL,NULL,'"drvDep7DOB"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep1Gender"',NULL,NULL,'"drvDep7Gender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ECRSAPAEXPZ0','50','D','10','34',NULL,'CH8SSN',NULL,NULL,'"drvDep8SSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ECRSAPAEXPZ0','50','D','10','32',NULL,'Dep8LastName',NULL,NULL,'"drvDep8LastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ECRSAPAEXPZ0','50','D','10','33',NULL,'Dep8FirstName',NULL,NULL,'"drvDep8FirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep8DOB"',NULL,NULL,'"drvDep8DOB"','(''UD110''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ECRSAPAEXPZ0','50','D','10','35',NULL,'Dep1Gender"',NULL,NULL,'"drvDep8Gender"','(''UD110''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECRSAPAEXP_20211229.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'APA Cobra Export','202005089','EMPEXPORT','ONDEMAND',NULL,'ECRSAPAEXP',NULL,NULL,NULL,'202005089','May  8 2020  3:58PM','May  8 2020  3:58PM','202005081',NULL,'','','202005081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',M8C6I,JE6DL,EV7Z8,EDV92,CJC4Y,EV2EI,JG341',NULL,NULL,NULL,'Scheduled Session','202102189','EMPEXPORT','SCH_TCBRX',NULL,'ECRSAPAEXP',NULL,NULL,NULL,'202112249','May  8 2020  3:58PM','May  8 2020  3:58PM','202112171',NULL,'','','202102181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202108061','EMPEXPORT','TEST','Aug  6 2021  2:51PM','ECRSAPAEXP',NULL,NULL,NULL,'202108061','Aug  6 2021 12:00AM','Jul 31 2021 12:00AM','202102191','235','','','202102191',dbo.fn_GetTimedKey(),NULL,'us3cPeCRO1008',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRSAPAEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRSAPAEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRSAPAEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRSAPAEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRSAPAEXP','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRSAPAEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRSAPAEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECRSAPAEXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECRSAPAEXP','D10','dbo.U_ECRSAPAEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECRSAPAEXP
-----------

IF OBJECT_ID('U_dsi_BDM_ECRSAPAEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECRSAPAEXP] (
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
-- Create table U_ECRSAPAEXP_Audit
-----------

IF OBJECT_ID('U_ECRSAPAEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ECRSAPAEXP_Audit] (
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
-- Create table U_ECRSAPAEXP_AuditFields
-----------

IF OBJECT_ID('U_ECRSAPAEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECRSAPAEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_ECRSAPAEXP_DedList
-----------

IF OBJECT_ID('U_ECRSAPAEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ECRSAPAEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECRSAPAEXP_drvTbl
-----------

IF OBJECT_ID('U_ECRSAPAEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECRSAPAEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvBusinessUnitName] varchar(6) NULL,
    [drvSSN] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDOB] datetime NULL,
    [drvAddress] varchar(511) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvDateofHire] datetime NULL,
    [drvMedicalPlan] varchar(30) NULL,
    [drvMedicalTier] varchar(13) NULL,
    [drvMedicalEffectiveDate] datetime NULL,
    [drvDentalPlan] varchar(24) NULL,
    [drvDentalTier] varchar(13) NULL,
    [drvDentalEffectiveDate] datetime NULL,
    [drvVisionPlan] varchar(11) NULL,
    [drvVisionTier] varchar(13) NULL,
    [drvVisionEffectivedate] datetime NULL,
    [drvActiveorCOBRA] varchar(6) NOT NULL,
    [drvQualifyingEvent] varchar(2) NULL,
    [drvQaualifyingEventDate] datetime NULL,
    [drvSpouseFirst] varchar(100) NULL,
    [drvSpouseLast] varchar(100) NULL,
    [drvSpouseSSN] char(11) NULL,
    [drvSpouseDOB] datetime NULL,
    [drvSpouseGender] char(1) NULL,
    [drvDep1SSN] char(11) NULL,
    [drvDep1LastName] varchar(100) NULL,
    [drvDep1FirstName] varchar(100) NULL,
    [drvDep1DOB] datetime NULL,
    [drvDep2SSN] char(11) NULL,
    [drvDep2LastName] varchar(100) NULL,
    [drvDep2FirstName] varchar(100) NULL,
    [drvDep2DOB] datetime NULL,
    [drvDep3SSN] char(11) NULL,
    [drvDep3LastName] varchar(100) NULL,
    [drvDep3FirstName] varchar(100) NULL,
    [drvDep3DOB] datetime NULL,
    [drvDep4SSN] char(11) NULL,
    [drvDep4LastName] varchar(100) NULL,
    [drvDep4FirstName] varchar(100) NULL,
    [drvDep4DOB] datetime NULL,
    [drvDep5SSN] char(11) NULL,
    [drvDep5LastName] varchar(100) NULL,
    [drvDep5FirstName] varchar(100) NULL,
    [drvDep5DOB] datetime NULL,
    [drvDep6SSN] char(11) NULL,
    [drvDep6LastName] varchar(100) NULL,
    [drvDep6FirstName] varchar(100) NULL,
    [drvDep6DOB] datetime NULL,
    [drvDep7SSN] char(11) NULL,
    [drvDep7LastName] varchar(100) NULL,
    [drvDep7FirstName] varchar(100) NULL,
    [drvDep7DOB] datetime NULL,
    [drvDep8SSN] char(11) NULL,
    [drvDep8LastName] varchar(100) NULL,
    [drvDep8FirstName] varchar(100) NULL,
    [drvDep8DOB] datetime NULL,
    [drvLastMonth] varchar(1) NOT NULL,
    [drvDep1Gender] char(1) NULL,
    [drvDep2Gender] char(1) NULL,
    [drvDep3Gender] char(1) NULL,
    [drvDep4Gender] char(1) NULL,
    [drvDep5Gender] char(1) NULL,
    [drvDep6Gender] char(1) NULL,
    [drvDep7Gender] char(1) NULL,
    [drvDep8Gender] char(1) NULL
);

-----------
-- Create table U_ECRSAPAEXP_EEList
-----------

IF OBJECT_ID('U_ECRSAPAEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECRSAPAEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECRSAPAEXP_File
-----------

IF OBJECT_ID('U_ECRSAPAEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECRSAPAEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRSAPAEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: CrossCountry Freight

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 02/01/2021
Service Request Number: TekP-2020-12-08-0001

Purpose: APA Cobra Export

Revision History
----------------
Update By           Date           Request Num        Desc
Darren Collard      12/26/2021     TekP-2021-10-12-0007  Add new company names to export

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECRSAPAEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECRSAPAEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECRSAPAEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECRSAPAEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECRSAPAEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRSAPAEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRSAPAEXP', 'TEST';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECRSAPAEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECRSAPAEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECRSAPAEXP';

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
    DELETE FROM dbo.U_ECRSAPAEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECRSAPAEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MED0, MED, M1,M20, M2700, M2,M30, M6350, M3,DEN, DEN0,DENNO, DENOR,VIS, VISO';

    


    IF OBJECT_ID('U_ECRSAPAEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECRSAPAEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECRSAPAEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================

    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists

    -- Run BDM for NPM
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CalcBenOptionDate', '1')

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC,DCH');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


    --Audit tables --

    IF OBJECT_ID('U_ECRSAPAEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECRSAPAEXP_AuditFields;
    CREATE TABLE dbo.U_ECRSAPAEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ECRSAPAEXP_AuditFields VALUES ('EmpDed','EedBenOption');    
   
    
    -- Create audit table
    IF OBJECT_ID('U_ECRSAPAEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECRSAPAEXP_Audit;
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
    INTO dbo.U_ECRSAPAEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ECRSAPAEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ECRSAPAEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      --AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECRSAPAEXP_Audit ON dbo.U_ECRSAPAEXP_Audit (audKey1Value, audKey2Value);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECRSAPAEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECRSAPAEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECRSAPAEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepssn
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvBusinessUnitName = CASE cmpCompanyCode
                               WHEN 'NAS'    THEN  'NAS'  
                               WHEN 'NAL'    THEN  'NAL'  
                               WHEN 'CCFS'   THEN  'CCFS' 
                               WHEN 'PRIC'   THEN  'PRIC' 
                               WHEN 'DATS'   THEN  'DATS' 
                               WHEN 'DTT'    THEN  'DTT'  
                               WHEN 'CCKCY'  THEN  'CCKCY'
                               WHEN 'CCMSP'  THEN  'CCMSP'
                               WHEN 'CCABQ'  THEN  'CCABQ'
                               WHEN 'MTS'    THEN  'MTS'  
                               WHEN 'RACP'   THEN  'RACP' 
                               END
        ,drvSSN = eepSSN
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvMiddleName =  eepNameMiddle
        ,drvGender = eepGender
        ,drvDOB = EepDateOfBirth
                    
        ,drvAddress = Concat( isnull(EepAddressLine1,''), ' ' ,isnull(EepAddressLine2,''))
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvDateofHire = EecDateOfOriginalHire

        ,drvMedicalPlan = CASE WHEN Tranditional2021  is not null then Tranditional2021
                               WHEN HSA2000  is not null then HSA2000    
                               WHEN HSA6750 is not null then HSA6750
                         END
        ,drvMedicalTier = CASE WHEN (Tranditional2021 is not null or HSA2000  is not null or HSA6750 is not null)  THEN
                                        CASE WHEN (Tranditional2021_BenOption = 'EE' or HSA2000_BenOption = 'EE'  or HSA6750_BenOption = 'EE' ) THEN 'Employee Only'
                                             WHEN (Tranditional2021_BenOption IN ('EES', 'EEDP') or HSA2000_BenOption IN ('EES', 'EEDP')  or HSA6750_BenOption IN ('EES', 'EEDP') ) THEN 'EE+SPOUSE'
                                             WHEN (Tranditional2021_BenOption IN ('EEC', 'DCH') or HSA2000_BenOption IN ('EEC', 'DCH') or HSA6750_BenOption IN ('EEC', 'DCH')) THEN 'EE+CHILDREN'
                                             WHEN (Tranditional2021_BenOption IN ('EEF','EEDPF') or HSA2000_BenOption IN ('EEF','EEDPF') or HSA6750_BenOption IN ('EEF','EEDPF')) THEN 'EE+FAMILY'
                                        END
                              END
        ,drvMedicalEffectiveDate = CASE WHEN Tranditional2021 is not null then Tranditional2021_BenStartDate
                                        WHEN HSA2000 is not null then HSA2000_BenStartDate
                                        WHEN HSA6750 is not null then HSA6750_BenStartDate
                                    END
        ,drvDentalPlan = CASE WHEN DEN_ORTHO  is not null THEN  DEN_ORTHO
                              WHEN DEN_WOUTORTHO   is not null THEN  DEN_WOUTORTHO
                         END 
        ,drvDentalTier = CASE WHEN (DEN_ORTHO is not null or DEN_WOUTORTHO is not null)  THEN
                                        CASE WHEN (DEN_ORTHO_BenOption = 'EE' or DEN_WOUTORTHO_BenOption = 'EE') THEN 'Employee Only'
                                             WHEN (DEN_ORTHO_BenOption IN ('EES', 'EEDP') or DEN_WOUTORTHO_BenOption IN ('EES', 'EEDP') ) THEN 'EE+SPOUSE'
                                             WHEN (DEN_ORTHO_BenOption IN ('EEC', 'DCH') or DEN_WOUTORTHO_BenOption IN ('EEC', 'DCH') ) THEN 'EE+CHILDREN'
                                             WHEN (DEN_ORTHO_BenOption IN ('EEF','EEDPF') or DEN_WOUTORTHO_BenOption IN ('EEF','EEDPF') ) THEN 'EE+FAMILY'
                                        END
                              END
        ,drvDentalEffectiveDate = CASE WHEN DEN_ORTHO  is not null THEN  DEN_ORTHO_BenStartDate
                              WHEN DEN_WOUTORTHO   is not null THEN  DEN_WOUTORTHO_BenStartDate
                         END           
        ,drvVisionPlan = CASE WHEN VISION is not null then VISION END
        ,drvVisionTier = CASE WHEN VISION is not null  THEN
                                    CASE WHEN VISION_BenOption = 'EE' THEN 'Employee Only'
                                         WHEN VISION_BenOption IN ('EES', 'EEDP') THEN 'EE+SPOUSE'
                                         WHEN VISION_BenOption IN ('EEC', 'DCH') THEN 'EE+CHILDREN'
                                         WHEN VISION_BenOption IN ('EEF','EEDPF')  THEN 'EE+FAMILY'
                                         WHEN VISION_BenOption in ('EE1') and VISION_Relationship in ('SPS','DP') THEN 'EE+SPOUSE'
                                         WHEN VISION_BenOption in ('EE1') and VISION_Relationship not in ('SPS','DP') THEN 'EE+CHILDREN'

                                    END 
                             END

        ,drvVisionEffectivedate = CASE WHEN VISION is not null then VISION_BenStartDate END
        ,drvActiveorCOBRA = CASE WHEN EecEmplStatus = 'T' or CobraEventDate is not null THEN 'COBRA' ELSE 'Active' END
        ,drvQualifyingEvent = 
                            CASE WHEN EecEmplStatus = 'T' THEN 
                            CASE WHEN EecEmplStatus = 'T' and EecTermReason <> '203' THEN 'T'
                                  WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN 'D'
                                  WHEN BdmCobraReason IN ('203','202') THEN 'RH'
                                  WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DV'
                                  ELSE 'T'             
                             END
                            END
        ,drvQaualifyingEventDate =  CASE WHEN EecEmplStatus = 'T' THEN 
        
                                            CASE WHEN EecEmplStatus = 'T' and EecTermReason <> '203' THEN EecDateOfTermination
                                                  WHEN EecEmplStatus = 'T' and EecTermReason = '203' and CobraEventdate is not null THEN EecDateOfTermination
                                                  WHEN BdmCobraReason IN ('204','LEVNT4','203','202') THEN CobraEventdate
                                                  ELSE CobraEventdate         
                                             END
                                    END
        ,drvSpouseFirst = SPSFirstName
        ,drvSpouseLast = SPSLastName
        ,drvSpouseSSN = SPSssn
        ,drvSpouseDOB = SPSDateOfBirth
        ,drvSpouseGender = SPSGender
        ,drvDep1SSN = DepSsn1
        ,drvDep1LastName = DepLastName1
        ,drvDep1FirstName = DepFirstName1
        ,drvDep1DOB =  DepDateOfBirth1
        ,drvDep2SSN = DepSsn2
        ,drvDep2LastName = DepLastName2
        ,drvDep2FirstName = DepFirstName2
        ,drvDep2DOB =  DepDateOfBirth2
        ,drvDep3SSN = DepSsn3
        ,drvDep3LastName = DepLastName3
        ,drvDep3FirstName = DepFirstName3
        ,drvDep3DOB =  DepDateOfBirth3
        ,drvDep4SSN = DepSsn4
        ,drvDep4LastName = DepLastName4
        ,drvDep4FirstName = DepFirstName4
        ,drvDep4DOB =  DepDateOfBirth4
        ,drvDep5SSN = DepSsn5
        ,drvDep5LastName = DepLastName5
        ,drvDep5FirstName = DepFirstName5
        ,drvDep5DOB =  DepDateOfBirth5
        ,drvDep6SSN = DepSsn6
        ,drvDep6LastName = DepLastName6
        ,drvDep6FirstName = DepFirstName6
        ,drvDep6DOB =  DepDateOfBirth6  
        ,drvDep7SSN = DepSsn7
        ,drvDep7LastName = DepLastName7
        ,drvDep7FirstName = DepFirstName7
        ,drvDep7DOB =  DepDateOfBirth7
        ,drvDep8SSN = DepSsn8
        ,drvDep8LastName = DepLastName8
        ,drvDep8FirstName = DepFirstName8
        ,drvDep8DOB =  DepDateOfBirth8
        ,drvLastMonth = ''
        ,drvDep1Gender =  DepGender1
        ,drvDep2Gender =  DepGender2
        ,drvDep3Gender =  DepGender3
        ,drvDep4Gender =  DepGender4
        ,drvDep5Gender =  DepGender5
        ,drvDep6Gender =  DepGender6
        ,drvDep7Gender =  DepGender7
        ,drvDep8Gender =  DepGender8

    INTO dbo.U_ECRSAPAEXP_drvTbl
    FROM dbo.U_ECRSAPAEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
      JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xeeid
       AND EecCoID = xcoid
    JOIN dbo.Company WITH (NOLOCK)
        ON cmpCoID = xcoid   
    JOIN (Select  A.bdmEEID,A.bdmcoid
            ,Tranditional2021 = MAX((CASE WHEN BDMDedCode IN ( 'MED0', 'MED', 'M1') then 'Plan 1 - 1000 Traditional 2021' END))
            ,HSA2000 = MAX((CASE WHEN BDMDedCode IN ( 'M20', 'M2700', 'M2')  then 'Plan 2 - 2000 HSA 2021' END))
            ,HSA6750 = MAX((CASE WHEN BDMDedCode IN ( 'M30', 'M6350', 'M3')  then 'Plan 3 - 6750 HSA 2021' END))
            ,Tranditional2021_BenOption = MAX((CASE WHEN BDMDedCode IN ( 'MED0', 'MED', 'M1') then BdmBenOption END))
            ,HSA2000_BenOption = MAX((CASE WHEN BDMDedCode IN ( 'M20', 'M2700', 'M2')  then BdmBenOption END))
            ,HSA6750_BenOption = MAX((CASE WHEN BDMDedCode IN ( 'M30', 'M6350', 'M3')  then BdmBenOption END))
            ,Tranditional2021_BenStartDate = MAX((CASE WHEN BDMDedCode IN ( 'MED0', 'MED', 'M1') then BdmBenStartDate END))
            ,HSA2000_BenStartDate = MAX((CASE WHEN BDMDedCode IN ( 'M20', 'M2700', 'M2')  then BdmBenStartDate END))
            ,HSA6750_BenStartDate = MAX((CASE WHEN BDMDedCode IN ( 'M30', 'M6350', 'M3')  then BdmBenStartDate END))

            ,DEN_ORTHO = MAX((CASE WHEN BDMDedCode IN ( 'DEN', 'DEN0') then '2021 Dental (No Ortho)' END))
            ,DEN_WOUTORTHO = MAX((CASE WHEN BDMDedCode IN ('DENNO', 'DENOR')  then '2021 Dental (with Ortho)' END))
            ,DEN_ORTHO_BenOption = MAX((CASE WHEN BDMDedCode IN ( 'DEN', 'DEN0') then BdmBenOption END))
            ,DEN_WOUTORTHO_BenOption = MAX((CASE WHEN BDMDedCode IN ('DENNO', 'DENOR')  then BdmBenOption END))
            ,DEN_ORTHO_BenStartDate = MAX((CASE WHEN BDMDedCode IN ( 'DEN', 'DEN0') then BdmBenStartDate END))
            ,DEN_WOUTORTHO_BenStartDate = MAX((CASE WHEN BDMDedCode IN ('DENNO', 'DENOR')  then BdmBenStartDate END))
            
            ,VISION = MAX((CASE WHEN BDMDedCode IN ('VIS', 'VISO') then '2021 Vision' END))
            ,VISION_BenOption = MAX((CASE WHEN BDMDedCode IN ('VIS', 'VISO') then BdmBenOption END))
            ,VISION_BenStartDate  = MAX((CASE WHEN BDMDedCode IN ('VIS', 'VISO') then BdmBenStartDate END))
            ,VISION_Relationship  = MAX((CASE WHEN BDMDedCode IN ('VIS', 'VISO') then bdmRelationship END))

            ,CobraEventdate = MAX(BdmDateOfCOBRAEvent) 
            ,CobraStatusDate = MAX(BdmBenStatusDate) 
            ,BdmCobraReason = MAX(BdmCobraReason) 
            ,bdmbenstartdate = max(bdmbenstartdate)
            from dbo.U_dsi_BDM_ECRSAPAEXP A
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
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConGender END) AS DepGender1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConGender END) AS DepGender2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConGender END) AS DepGender3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConGender END) AS DepGender4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConGender END) AS DepGender5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConGender END) AS DepGender6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConGender END) AS DepGender7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConGender END) AS DepGender8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConGender END) AS DepGender9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConGender END) AS DepGender10
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConGender END) AS DepGender11
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConGender END) AS DepGender12

            ,Count(CASE WHEN ConRelationship IN ('DAU', 'SON', 'DIS', 'STC','CHL') THEN Dep_Number END) as Child_Counts

        From (
                select bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship,ConGender, ROW_NUMBER() OVER (PARTITION BY bdmeeid ORDER BY bdmeeid) AS 'Dep_Number'
                from  dbo.U_dsi_BDM_ECRSAPAEXP A 
                JOIN dbo.Contacts WITH (NOLOCK) 
                ON ConEEID = bdmeeid 
                AND ConSystemID = BdmDepRecID
                where bdmrelationship IN ('CHL') and bdmdedcode in ('MED0', 'MED', 'M1','M20', 'M2700', 'M2','M30', 'M6350', 'M3','DEN', 'DEN0','DENNO', 'DENOR','VIS', 'VISO') 
                    group by bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship, ConGender
                    ) AS Source Group By bdmeeid)
         AS DepList on KidEEID = xEEID
         LEFT JOIN (Select bdmeeid AS SPSEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS SPSLastName
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS SPSFirstName
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS SPSSsn
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS SPSDateOfBirth
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConGender END) AS SPSGender

            ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS SPSRelationship
            ,Count(CASE WHEN ConRelationship IN ('SPS') THEN Dep_Number END) as SPS_Counts

        From (
                select bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship,ConGender, ROW_NUMBER() OVER (PARTITION BY bdmeeid ORDER BY bdmeeid) AS 'Dep_Number'
                from  dbo.U_dsi_BDM_ECRSAPAEXP A 
                JOIN dbo.Contacts WITH (NOLOCK) 
                ON ConEEID = bdmeeid 
                AND ConSystemID = BdmDepRecID
                where bdmrelationship IN ('SPS','DP') and bdmdedcode in ('MED0', 'MED', 'M1','M20', 'M2700', 'M2','M30', 'M6350', 'M3','DEN', 'DEN0','DENNO', 'DENOR','VIS', 'VISO')
                    group by bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship, ConGender
                    ) AS Source Group By bdmeeid) As Spouse
                on xeeid = Spouse.SPSEEID



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
ALTER VIEW dbo.dsi_vwECRSAPAEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECRSAPAEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECRSAPAEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005011'
       ,expStartPerControl     = '202005011'
       ,expLastEndPerControl   = '202005089'
       ,expEndPerControl       = '202005089'
WHERE expFormatCode = 'ECRSAPAEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECRSAPAEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECRSAPAEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECRSAPAEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECRSAPAEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECRSAPAEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECRSAPAEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECRSAPAEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECRSAPAEXP', 'UseFileName', 'V', 'Y'


-- End ripout