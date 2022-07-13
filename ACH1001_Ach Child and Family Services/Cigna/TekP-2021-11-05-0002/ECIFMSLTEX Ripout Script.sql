/**********************************************************************************

EHJOYDEMEX: HealthJoy Demographic Export

FormatCode:     EHJOYDEMEX
Project:        HealthJoy Demographic Export
Client ID:      ACH1001
Date/time:      2022-07-07 06:13:27.733
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB02
Database:       ULTIPRO_WPACHS
Web Filename:   ACH1001_XTE10_EEHISTORY_EHJOYDEMEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EHJOYDEMEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EHJOYDEMEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EHJOYDEMEX'


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
WHERE FormatCode = 'EHJOYDEMEX'
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
WHERE ExpFormatCode = 'EHJOYDEMEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EHJOYDEMEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EHJOYDEMEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EHJOYDEMEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EHJOYDEMEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EHJOYDEMEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EHJOYDEMEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EHJOYDEMEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EHJOYDEMEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EHJOYDEMEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EHJOYDEMEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEHJOYDEMEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHJOYDEMEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHJOYDEMEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHJOYDEMEX];
GO
IF OBJECT_ID('U_EHJOYDEMEX_File') IS NOT NULL DROP TABLE [dbo].[U_EHJOYDEMEX_File];
GO
IF OBJECT_ID('U_EHJOYDEMEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHJOYDEMEX_EEList];
GO
IF OBJECT_ID('U_EHJOYDEMEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHJOYDEMEX_drvTbl];
GO
IF OBJECT_ID('U_EHJOYDEMEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHJOYDEMEX_DedList];
GO
IF OBJECT_ID('U_EHJOYDEMEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EHJOYDEMEX_AuditFields];
GO
IF OBJECT_ID('U_EHJOYDEMEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EHJOYDEMEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EHJOYDEMEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EHJOYDEMEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHJOYDEMEX','HealthJoy Demographic Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','5000','S','N','EHJOYDEMEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHJOYDEMEXZ0','50','H','01','1',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHJOYDEMEXZ0','50','H','01','2',NULL,'Start Date',NULL,NULL,'"Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHJOYDEMEXZ0','50','H','01','3',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHJOYDEMEXZ0','50','H','01','4',NULL,'Employment Termination Date',NULL,NULL,'"Employment Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHJOYDEMEXZ0','50','H','01','5',NULL,'COBRA Start Date',NULL,NULL,'"COBRA Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHJOYDEMEXZ0','50','H','01','6',NULL,'COBRA Termination Date',NULL,NULL,'"COBRA Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHJOYDEMEXZ0','50','H','01','7',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHJOYDEMEXZ0','50','H','01','8',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHJOYDEMEXZ0','50','H','01','9',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHJOYDEMEXZ0','50','H','01','10',NULL,'Relationship',NULL,NULL,'"Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHJOYDEMEXZ0','50','H','01','11',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHJOYDEMEXZ0','50','H','01','12',NULL,'Mobile Number',NULL,NULL,'"Mobile Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHJOYDEMEXZ0','50','H','01','13',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHJOYDEMEXZ0','50','H','01','14',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHJOYDEMEXZ0','50','H','01','15',NULL,'Address Line 1',NULL,NULL,'"Address Line 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHJOYDEMEXZ0','50','H','01','16',NULL,'Address Line 2',NULL,NULL,'"Address Line 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHJOYDEMEXZ0','50','H','01','17',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHJOYDEMEXZ0','50','H','01','18',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHJOYDEMEXZ0','50','H','01','19',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHJOYDEMEXZ0','50','H','01','20',NULL,'Benefit Class',NULL,NULL,'"Benefit Class"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHJOYDEMEXZ0','50','H','01','21',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHJOYDEMEXZ0','50','H','01','22',NULL,'Medical Insurance Plan Name',NULL,NULL,'"Medical Insurance Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHJOYDEMEXZ0','50','H','01','23',NULL,'Medical Group ID',NULL,NULL,'"Medical Group ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHJOYDEMEXZ0','50','H','01','24',NULL,'Medical Plan Effective Date',NULL,NULL,'"Medical Plan Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHJOYDEMEXZ0','50','H','01','25',NULL,'Medical Plan Termination Date',NULL,NULL,'"Medical Plan Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHJOYDEMEXZ0','50','H','01','26',NULL,'Dental Insurance Plan Name',NULL,NULL,'"Dental Insurance Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHJOYDEMEXZ0','50','H','01','27',NULL,'Dental Group ID',NULL,NULL,'"Dental Group ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHJOYDEMEXZ0','50','H','01','28',NULL,'Dental Plan Effective Date',NULL,NULL,'"Dental Plan Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHJOYDEMEXZ0','50','H','01','29',NULL,'Dental Plan Termination Date',NULL,NULL,'"Dental Plan Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHJOYDEMEXZ0','50','H','01','30',NULL,'Vision Insurance Plan Name',NULL,NULL,'"Vision Insurance Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHJOYDEMEXZ0','50','H','01','31',NULL,'Vision Group ID',NULL,NULL,'"Vision Group ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHJOYDEMEXZ0','50','H','01','32',NULL,'Vision Plan Effective Date',NULL,NULL,'"Vision Plan Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHJOYDEMEXZ0','50','H','01','33',NULL,'Vision Plan Termination Date',NULL,NULL,'"Vision Plan Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHJOYDEMEXZ0','50','H','01','34',NULL,'Basic Life Plan Name',NULL,NULL,'"Basic Life Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHJOYDEMEXZ0','50','H','01','35',NULL,'Basic Life Policy Amount',NULL,NULL,'"Basic Life Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHJOYDEMEXZ0','50','H','01','36',NULL,'Basic Life Effective Date',NULL,NULL,'"Basic Life Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EHJOYDEMEXZ0','50','H','01','37',NULL,'Basic Life Termination Date',NULL,NULL,'"Basic Life Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EHJOYDEMEXZ0','50','H','01','38',NULL,'Supplemental Life Plan Name',NULL,NULL,'"Supplemental Life Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EHJOYDEMEXZ0','50','H','01','39',NULL,'Supplemental Life Policy Amount',NULL,NULL,'"Supplemental Life Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EHJOYDEMEXZ0','50','H','01','40',NULL,'Supplemental Life Effective Date',NULL,NULL,'"Supplemental Life Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EHJOYDEMEXZ0','50','H','01','41',NULL,'Supplemental Life Termination Date',NULL,NULL,'"Supplemental Life Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EHJOYDEMEXZ0','50','H','01','42',NULL,'LTD Plan Name',NULL,NULL,'"LTD Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EHJOYDEMEXZ0','50','H','01','43',NULL,'LTD Policy Amount',NULL,NULL,'"LTD Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EHJOYDEMEXZ0','50','H','01','44',NULL,'LTD Effective Date',NULL,NULL,'"LTD Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EHJOYDEMEXZ0','50','H','01','45',NULL,'LTD Termination Date',NULL,NULL,'"LTD Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EHJOYDEMEXZ0','50','H','01','46',NULL,'STD Plan Name',NULL,NULL,'"STD Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EHJOYDEMEXZ0','50','H','01','47',NULL,'STD Policy Amount',NULL,NULL,'"STD Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EHJOYDEMEXZ0','50','H','01','48',NULL,'STD Effective Date',NULL,NULL,'"STD Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EHJOYDEMEXZ0','50','H','01','49',NULL,'STD Termination Date',NULL,NULL,'"STD Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EHJOYDEMEXZ0','50','H','01','50',NULL,'Healthcare FSA Plan Name',NULL,NULL,'"Healthcare FSA Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EHJOYDEMEXZ0','50','H','01','51',NULL,'Healthcare FSA Goal Amount',NULL,NULL,'"Healthcare FSA Goal Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EHJOYDEMEXZ0','50','H','01','52',NULL,'Healthcare FSA Effective Date',NULL,NULL,'"Healthcare FSA Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EHJOYDEMEXZ0','50','H','01','53',NULL,'Healthcare FSA Termination Date',NULL,NULL,'"Healthcare FSA Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EHJOYDEMEXZ0','50','H','01','54',NULL,'Dependent Care FSA Plan Name',NULL,NULL,'"Dependent Care FSA Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EHJOYDEMEXZ0','50','H','01','55',NULL,'Dependent Care FSA Goal Amount',NULL,NULL,'"Dependent Care FSA Goal Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EHJOYDEMEXZ0','50','H','01','56',NULL,'Dependent Care FSA Effective Date',NULL,NULL,'"Dependent Care FSA Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EHJOYDEMEXZ0','50','H','01','57',NULL,'Dependent Care FSA Termination Date',NULL,NULL,'"Dependent Care FSA Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EHJOYDEMEXZ0','50','H','01','58',NULL,'HSA Plan Name',NULL,NULL,'"HSA Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EHJOYDEMEXZ0','50','H','01','59',NULL,'HSA Goal Amount',NULL,NULL,'"HSA Goal Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EHJOYDEMEXZ0','50','H','01','60',NULL,'HSA Effective Date',NULL,NULL,'"HSA Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EHJOYDEMEXZ0','50','H','01','61',NULL,'HSA Termination Date',NULL,NULL,'"HSA Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EHJOYDEMEXZ0','50','H','01','62',NULL,'Accident Plan Name',NULL,NULL,'"Accident Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EHJOYDEMEXZ0','50','H','01','63',NULL,'Accident Policy Amount',NULL,NULL,'"Accident Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EHJOYDEMEXZ0','50','H','01','64',NULL,'Accident Effective Date',NULL,NULL,'"Accident Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EHJOYDEMEXZ0','50','H','01','65',NULL,'Accident Termination Date',NULL,NULL,'"Accident Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EHJOYDEMEXZ0','50','H','01','66',NULL,'Critical Illness Plan Name',NULL,NULL,'"Critical Illness Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EHJOYDEMEXZ0','50','H','01','67',NULL,'Critical Illness Policy Amount',NULL,NULL,'"Critical Illness Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EHJOYDEMEXZ0','50','H','01','68',NULL,'Critical Illness Policy Effective Date',NULL,NULL,'"Critical Illness Policy Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EHJOYDEMEXZ0','50','H','01','69',NULL,'Critical Illness Termination Date',NULL,NULL,'"Critical Illness Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EHJOYDEMEXZ0','50','H','01','70',NULL,'Hospital Indemnity Plan Name',NULL,NULL,'"Hospital Indemnity Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EHJOYDEMEXZ0','50','H','01','71',NULL,'Hospital Indemnity Policy Amount',NULL,NULL,'"Hospital Indemnity Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EHJOYDEMEXZ0','50','H','01','72',NULL,'Hospital Indemnity Policy Effective Date',NULL,NULL,'"Hospital Indemnity Policy Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EHJOYDEMEXZ0','50','H','01','73',NULL,'Hospital Indemnity Termination Date',NULL,NULL,'"Hospital Indemnity Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EHJOYDEMEXZ0','50','H','01','74',NULL,'Custom Plan Name 1',NULL,NULL,'"Custom Plan Name 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EHJOYDEMEXZ0','50','H','01','75',NULL,'Custom Plan Name 1 Policy Amount',NULL,NULL,'"Custom Plan Name 1 Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EHJOYDEMEXZ0','50','H','01','76',NULL,'Custom Plan Name 1 Effective Date',NULL,NULL,'"Custom Plan Name 1 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EHJOYDEMEXZ0','50','H','01','77',NULL,'Custom Plan Name 1 Termination Date',NULL,NULL,'"Custom Plan Name 1 Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EHJOYDEMEXZ0','50','H','01','78',NULL,'Custom Plan Name 2',NULL,NULL,'"Custom Plan Name 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EHJOYDEMEXZ0','50','H','01','79',NULL,'Custom Plan Name 2 Policy Amount',NULL,NULL,'"Custom Plan Name 2 Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EHJOYDEMEXZ0','50','H','01','80',NULL,'Custom Plan Name 2 Effective Date',NULL,NULL,'"Custom Plan Name 2 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EHJOYDEMEXZ0','50','H','01','81',NULL,'Custom Plan Name 2 Termination Date',NULL,NULL,'"Custom Plan Name 2 Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EHJOYDEMEXZ0','50','H','01','82',NULL,'Custom Plan Name 3',NULL,NULL,'"Custom Plan Name 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EHJOYDEMEXZ0','50','H','01','83',NULL,'Custom Plan Name 3 Policy Amount',NULL,NULL,'"Custom Plan Name 3 Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EHJOYDEMEXZ0','50','H','01','84',NULL,'Custom Plan Name 3 Effective Date',NULL,NULL,'"Custom Plan Name 3 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EHJOYDEMEXZ0','50','H','01','85',NULL,'Custom Plan Name 3 Termination Date',NULL,NULL,'"Custom Plan Name 3 Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EHJOYDEMEXZ0','50','H','01','86',NULL,'Custom Plan Name 4',NULL,NULL,'"Custom Plan Name 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EHJOYDEMEXZ0','50','H','01','87',NULL,'Custom Plan Name 4 Policy Amount',NULL,NULL,'"Custom Plan Name 4 Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EHJOYDEMEXZ0','50','H','01','88',NULL,'Custom Plan Name 4 Effective Date',NULL,NULL,'"Custom Plan Name 4 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EHJOYDEMEXZ0','50','H','01','89',NULL,'Custom Plan Name 4 Termination Date',NULL,NULL,'"Custom Plan Name 4 Termination Date"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHJOYDEMEXZ0','50','D','10','1',NULL,'Employee ID',NULL,NULL,'"drvEmployeeId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHJOYDEMEXZ0','50','D','10','2',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHJOYDEMEXZ0','50','D','10','3',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHJOYDEMEXZ0','50','D','10','4',NULL,'Employment Termination Date',NULL,NULL,'"drvEmployeeTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHJOYDEMEXZ0','50','D','10','5',NULL,'COBRA Start Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHJOYDEMEXZ0','50','D','10','6',NULL,'COBRA Termination Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHJOYDEMEXZ0','50','D','10','7',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHJOYDEMEXZ0','50','D','10','8',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHJOYDEMEXZ0','50','D','10','9',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHJOYDEMEXZ0','50','D','10','10',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHJOYDEMEXZ0','50','D','10','11',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHJOYDEMEXZ0','50','D','10','12',NULL,'Mobile Number',NULL,NULL,'"drvMobileNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHJOYDEMEXZ0','50','D','10','13',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHJOYDEMEXZ0','50','D','10','14',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHJOYDEMEXZ0','50','D','10','15',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHJOYDEMEXZ0','50','D','10','16',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHJOYDEMEXZ0','50','D','10','17',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHJOYDEMEXZ0','50','D','10','18',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHJOYDEMEXZ0','50','D','10','19',NULL,'Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHJOYDEMEXZ0','50','D','10','20',NULL,'Benefit Class',NULL,NULL,'"drvBenefitClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHJOYDEMEXZ0','50','D','10','21',NULL,'Division',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHJOYDEMEXZ0','50','D','10','22',NULL,'Medical Insurance Plan Name',NULL,NULL,'"drvMedicalInsurancePlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHJOYDEMEXZ0','50','D','10','23',NULL,'Medical Group ID',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHJOYDEMEXZ0','50','D','10','24',NULL,'Medical Plan Effective Date',NULL,NULL,'"drvMedicalPlanEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHJOYDEMEXZ0','50','D','10','25',NULL,'Medical Plan Termination Date',NULL,NULL,'"drvMedicalPlanTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHJOYDEMEXZ0','50','D','10','26',NULL,'Dental Insurance Plan Name',NULL,NULL,'"drvDentalInsurancePlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHJOYDEMEXZ0','50','D','10','27',NULL,'Dental Group ID',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHJOYDEMEXZ0','50','D','10','28',NULL,'Dental Plan Effective Date',NULL,NULL,'"drvDentalPlanEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHJOYDEMEXZ0','50','D','10','29',NULL,'Dental Plan Termination Date',NULL,NULL,'"drvDentalPlanTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHJOYDEMEXZ0','50','D','10','30',NULL,'Vision Insurance Plan Name',NULL,NULL,'"drvVisionInsurancePlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHJOYDEMEXZ0','50','D','10','31',NULL,'Vision Group ID',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHJOYDEMEXZ0','50','D','10','32',NULL,'Vision Plan Effective Date',NULL,NULL,'"drvVisionPlanEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHJOYDEMEXZ0','50','D','10','33',NULL,'Vision Plan Termination Date',NULL,NULL,'"drvVisionPlanTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHJOYDEMEXZ0','50','D','10','34',NULL,'Basic Life Plan Name',NULL,NULL,'"drvBasicLifePlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHJOYDEMEXZ0','50','D','10','35',NULL,'Basic Life Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHJOYDEMEXZ0','50','D','10','36',NULL,'Basic Life Effective Date',NULL,NULL,'"drvBasicLifeEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EHJOYDEMEXZ0','50','D','10','37',NULL,'Basic Life Termination Date',NULL,NULL,'"drvBasicLifeTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EHJOYDEMEXZ0','50','D','10','38',NULL,'Supplemental Life Plan Name',NULL,NULL,'"drvSupplementalLifePlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EHJOYDEMEXZ0','50','D','10','39',NULL,'Supplemental Life Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EHJOYDEMEXZ0','50','D','10','40',NULL,'Supplemental Life Effective Date',NULL,NULL,'"drvSupplementalLifeEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EHJOYDEMEXZ0','50','D','10','41',NULL,'Supplemental Life Termination Date',NULL,NULL,'"drvSupplementalLifeTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EHJOYDEMEXZ0','50','D','10','42',NULL,'LTD Plan Name',NULL,NULL,'"drvLtdPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EHJOYDEMEXZ0','50','D','10','43',NULL,'LTD Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EHJOYDEMEXZ0','50','D','10','44',NULL,'LTD Effective Date',NULL,NULL,'"drvLtdEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EHJOYDEMEXZ0','50','D','10','45',NULL,'LTD Termination Date',NULL,NULL,'"drvLtdTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EHJOYDEMEXZ0','50','D','10','46',NULL,'STD Plan Name',NULL,NULL,'"drvStdPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EHJOYDEMEXZ0','50','D','10','47',NULL,'STD Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EHJOYDEMEXZ0','50','D','10','48',NULL,'STD Effective Date',NULL,NULL,'"drvStdEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EHJOYDEMEXZ0','50','D','10','49',NULL,'STD Termination Date',NULL,NULL,'"drvStdTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EHJOYDEMEXZ0','50','D','10','50',NULL,'Healthcare FSA Plan Name',NULL,NULL,'"drvHealthcareFsaPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EHJOYDEMEXZ0','50','D','10','51',NULL,'Healthcare FSA Goal Amount',NULL,NULL,'"drvHealthcareFsaGoalAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EHJOYDEMEXZ0','50','D','10','52',NULL,'Healthcare FSA Effective Date',NULL,NULL,'"drvHealthcareFsaEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EHJOYDEMEXZ0','50','D','10','53',NULL,'Healthcare FSA Termination Date',NULL,NULL,'"drvHealthcareFsaTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EHJOYDEMEXZ0','50','D','10','54',NULL,'Dependent Care FSA Plan Name',NULL,NULL,'"drvDependentCareFsaPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EHJOYDEMEXZ0','50','D','10','55',NULL,'Dependent Care FSA Goal Amount',NULL,NULL,'"drvDependentCareFsaGoalAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EHJOYDEMEXZ0','50','D','10','56',NULL,'Dependent Care FSA Effective Date',NULL,NULL,'"drvDependentCareFsaEffectDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EHJOYDEMEXZ0','50','D','10','57',NULL,'Dependent Care FSA Termination Date',NULL,NULL,'"drvDependentCareFsaTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EHJOYDEMEXZ0','50','D','10','58',NULL,'HSA Plan Name',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EHJOYDEMEXZ0','50','D','10','59',NULL,'HSA Goal Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EHJOYDEMEXZ0','50','D','10','60',NULL,'HSA Effective Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EHJOYDEMEXZ0','50','D','10','61',NULL,'HSA Termination Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EHJOYDEMEXZ0','50','D','10','62',NULL,'Accident Plan Name',NULL,NULL,'"drvAccidentPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EHJOYDEMEXZ0','50','D','10','63',NULL,'Accident Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EHJOYDEMEXZ0','50','D','10','64',NULL,'Accident Effective Date',NULL,NULL,'"drvAccidentEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EHJOYDEMEXZ0','50','D','10','65',NULL,'Accident Termination Date',NULL,NULL,'"drvAccidentTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EHJOYDEMEXZ0','50','D','10','66',NULL,'Critical Illness Plan Name',NULL,NULL,'"drvCriticalIllnessPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EHJOYDEMEXZ0','50','D','10','67',NULL,'Critical Illness Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EHJOYDEMEXZ0','50','D','10','68',NULL,'Critical Illness Policy Effective Date',NULL,NULL,'"drvCritIllnessPolicyEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EHJOYDEMEXZ0','50','D','10','69',NULL,'Critical Illness Termination Date',NULL,NULL,'"drvCritIllnessTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EHJOYDEMEXZ0','50','D','10','70',NULL,'Hospital Indemnity Plan Name',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EHJOYDEMEXZ0','50','D','10','71',NULL,'Hospital Indemnity Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EHJOYDEMEXZ0','50','D','10','72',NULL,'Hospital Indemnity Policy Effective Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EHJOYDEMEXZ0','50','D','10','73',NULL,'Hospital Indemnity Termination Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EHJOYDEMEXZ0','50','D','10','74',NULL,'Custom Plan Name 1',NULL,NULL,'"drvCustom1PlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EHJOYDEMEXZ0','50','D','10','75',NULL,'Custom Plan Name 1 Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EHJOYDEMEXZ0','50','D','10','76',NULL,'Custom Plan Name 1 Effective Date',NULL,NULL,'"drvCustom1EffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EHJOYDEMEXZ0','50','D','10','77',NULL,'Custom Plan Name 1 Termination Date',NULL,NULL,'"drvCustom1TerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EHJOYDEMEXZ0','50','D','10','78',NULL,'Custom Plan Name 2',NULL,NULL,'"drvCustom2PlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EHJOYDEMEXZ0','50','D','10','79',NULL,'Custom Plan Name 2 Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EHJOYDEMEXZ0','50','D','10','80',NULL,'Custom Plan Name 2 Effective Date',NULL,NULL,'"drvCustom2EffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EHJOYDEMEXZ0','50','D','10','81',NULL,'Custom Plan Name 2 Termination Date',NULL,NULL,'"drvCustom2TerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EHJOYDEMEXZ0','50','D','10','82',NULL,'Custom Plan Name 3',NULL,NULL,'"drvCustom3PlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EHJOYDEMEXZ0','50','D','10','83',NULL,'Custom Plan Name 3 Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EHJOYDEMEXZ0','50','D','10','84',NULL,'Custom Plan Name 3 Effective Date',NULL,NULL,'"drvCustom3EffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EHJOYDEMEXZ0','50','D','10','85',NULL,'Custom Plan Name 3 Termination Date',NULL,NULL,'"drvCustom3TerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EHJOYDEMEXZ0','50','D','10','86',NULL,'Custom Plan Name 4',NULL,NULL,'"drvCustom4PlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EHJOYDEMEXZ0','50','D','10','87',NULL,'Custom Plan Name 4 Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EHJOYDEMEXZ0','50','D','10','88',NULL,'Custom Plan Name 4 Effective Date',NULL,NULL,'"drvCustom4EffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EHJOYDEMEXZ0','50','D','10','89',NULL,'Custom Plan Name 4 Termination Date',NULL,NULL,'"drvCustom4TerminationDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EHJOYDEMEX_20220707.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202109219','EMPEXPORT','OEACTIVE',NULL,'EHJOYDEMEX',NULL,NULL,NULL,'202109219','Sep 21 2021  4:31AM','Sep 21 2021  4:31AM','202109211',NULL,'','','202109211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202109219','EMPEXPORT','OEPASSIVE',NULL,'EHJOYDEMEX',NULL,NULL,NULL,'202109219','Sep 21 2021  4:31AM','Sep 21 2021  4:31AM','202109211',NULL,'','','202109211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthJoy Demographic Export','202109219','EMPEXPORT','ONDEM_XOE',NULL,'EHJOYDEMEX',NULL,NULL,NULL,'202109219','Sep 21 2021  4:31AM','Sep 21 2021  4:31AM','202109211',NULL,'','','202109211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','NE59R',NULL,NULL,NULL,'HealthJoy Demographic Ex-Sched','202110159','EMPEXPORT','SCH_EHJOYD',NULL,'EHJOYDEMEX',NULL,NULL,NULL,'202207019','Sep 21 2021  4:31AM','Sep 21 2021  4:31AM','202206171',NULL,'','','202110151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','NE59R',NULL,NULL,NULL,'HealthJoy Demographic Ex-Test','202206109','EMPEXPORT','TEST_XOE','Apr 22 2022  8:58PM','EHJOYDEMEX',NULL,NULL,NULL,'202206109','Apr 22 2022 12:00AM','Apr 16 2022 12:00AM','202206041','1163','','','202206041',dbo.fn_GetTimedKey(),NULL,'us3cPeACH1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJOYDEMEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJOYDEMEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJOYDEMEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJOYDEMEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJOYDEMEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHJOYDEMEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHJOYDEMEX','D10','dbo.U_EHJOYDEMEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EHJOYDEMEX
-----------

IF OBJECT_ID('U_dsi_BDM_EHJOYDEMEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EHJOYDEMEX] (
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
-- Create table U_EHJOYDEMEX_Audit
-----------

IF OBJECT_ID('U_EHJOYDEMEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EHJOYDEMEX_Audit] (
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
-- Create table U_EHJOYDEMEX_AuditFields
-----------

IF OBJECT_ID('U_EHJOYDEMEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EHJOYDEMEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EHJOYDEMEX_DedList
-----------

IF OBJECT_ID('U_EHJOYDEMEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EHJOYDEMEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EHJOYDEMEX_drvTbl
-----------

IF OBJECT_ID('U_EHJOYDEMEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHJOYDEMEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvStartDate] datetime NULL,
    [drvEmploymentStatus] varchar(1) NOT NULL,
    [drvEmployeeTerminationDate] datetime NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] varchar(11) NULL,
    [drvRelationship] varchar(8) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvMobileNumber] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(257) NOT NULL,
    [drvAddressCity] varchar(257) NOT NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(5) NULL,
    [drvBenefitClass] varchar(3) NULL,
    [drvMedicalInsurancePlanName] varchar(18) NULL,
    [drvMedicalPlanEffectiveDate] datetime NULL,
    [drvMedicalPlanTerminationDate] datetime NULL,
    [drvDentalInsurancePlanName] varchar(10) NULL,
    [drvDentalPlanEffectiveDate] datetime NULL,
    [drvDentalPlanTerminationDate] datetime NULL,
    [drvVisionInsurancePlanName] varchar(12) NULL,
    [drvVisionPlanEffectiveDate] datetime NULL,
    [drvVisionPlanTerminationDate] datetime NULL,
    [drvBasicLifePlanName] varchar(10) NULL,
    [drvBasicLifeEffectiveDate] datetime NULL,
    [drvBasicLifeTerminationDate] datetime NULL,
    [drvSupplementalLifePlanName] varchar(17) NULL,
    [drvSupplementalLifeEffDate] datetime NULL,
    [drvSupplementalLifeTermDate] datetime NULL,
    [drvLtdPlanName] varchar(3) NULL,
    [drvLtdEffectiveDate] datetime NULL,
    [drvLtdTerminationDate] datetime NULL,
    [drvStdPlanName] varchar(3) NULL,
    [drvStdEffectiveDate] datetime NULL,
    [drvStdTerminationDate] datetime NULL,
    [drvHealthcareFsaPlanName] varchar(11) NULL,
    [drvHealthcareFsaGoalAmount] nvarchar(4000) NULL,
    [drvHealthcareFsaEffectiveDate] datetime NULL,
    [drvHealthcareFsaTermDate] datetime NULL,
    [drvDependentCareFsaPlanName] varchar(18) NULL,
    [drvDependentCareFsaGoalAmount] nvarchar(4000) NULL,
    [drvDependentCareFsaEffectDate] datetime NULL,
    [drvDependentCareFsaTermDate] datetime NULL,
    [drvAccidentPlanName] varchar(13) NULL,
    [drvAccidentEffectiveDate] datetime NULL,
    [drvAccidentTerminationDate] datetime NULL,
    [drvCriticalIllnessPlanName] varchar(21) NULL,
    [drvCritIllnessPolicyEffDate] datetime NULL,
    [drvCritIllnessTerminationDate] datetime NULL,
    [drvCustom1PlanName] varchar(9) NULL,
    [drvCustom1EffectiveDate] datetime NULL,
    [drvCustom1TerminationDate] datetime NULL,
    [drvCustom2PlanName] varchar(24) NULL,
    [drvCustom2EffectiveDate] datetime NULL,
    [drvCustom2TerminationDate] datetime NULL,
    [drvCustom3PlanName] varchar(16) NULL,
    [drvCustom3EffectiveDate] datetime NULL,
    [drvCustom3TerminationDate] datetime NULL,
    [drvCustom4PlanName] varchar(16) NULL,
    [drvCustom4EffectiveDate] datetime NULL,
    [drvCustom4TerminationDate] datetime NULL
);

-----------
-- Create table U_EHJOYDEMEX_EEList
-----------

IF OBJECT_ID('U_EHJOYDEMEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EHJOYDEMEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EHJOYDEMEX_File
-----------

IF OBJECT_ID('U_EHJOYDEMEX_File') IS NULL
CREATE TABLE [dbo].[U_EHJOYDEMEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHJOYDEMEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: ACH Child and Family Services

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 09/21/2021
Service Request Number: TekP-2021-08-09-0002

Purpose: HealthJoy Demographic Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHJOYDEMEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHJOYDEMEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHJOYDEMEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHJOYDEMEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHJOYDEMEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJOYDEMEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJOYDEMEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJOYDEMEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJOYDEMEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJOYDEMEX', 'SCH_EHJOYD';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHJOYDEMEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EHJOYDEMEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EHJOYDEMEX';

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
    DELETE FROM dbo.U_EHJOYDEMEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHJOYDEMEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_EHJOYDEMEX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WHERE EecEEType NOT IN ('PRN','PTR','REG')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MDPOS,MDBP,DEN,VIS,GLIFE,LIFEC,LIFEE,LIFES,LTDC,STDC,FSA,FSADC,ACCID,CRIEE,CRIEF,CRIES,CRIFS,401F,401KC,401P,IDSHD,LEGAL,LSID,LTDBU,STDBU';

    IF OBJECT_ID('U_EHJOYDEMEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHJOYDEMEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHJOYDEMEX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EHJOYDEMEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EHJOYDEMEX_AuditFields;
    CREATE TABLE dbo.U_EHJOYDEMEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    --INSERT INTO dbo.U_EHJOYDEMEX_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EHJOYDEMEX_AuditFields VALUES ('EmpComp','EecEmplStatus');
    --INSERT INTO dbo.U_EHJOYDEMEX_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EHJOYDEMEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHJOYDEMEX_Audit;
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
    INTO dbo.U_EHJOYDEMEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EHJOYDEMEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EHJOYDEMEX_Audit ON dbo.U_EHJOYDEMEX_Audit (audEEID,audKey2);


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHJOYDEMEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHJOYDEMEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHJOYDEMEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + CASE WHEN BdmRecType = 'DEP' THEN ' 2' ELSE ' 1' END
        -- standard fields above and additional driver fields below
        ,drvEmployeeId = EecEmpNo
        ,drvStartDate = EecDateOfLastHire
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus = 'T' THEN 'T' ELSE 'A' END
        ,drvEmployeeTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvNameFirst = LTRIM(CASE WHEN BdmRecType = 'DEP' THEN ConNameFirst ELSE EepNameFirst END)
        ,drvNameLast = CASE WHEN BdmRecType = 'DEP' THEN ConNameLast ELSE EepNameLast END 
        ,drvSSN =    CASE WHEN BdmRecType = 'DEP' THEN 
                        CASE WHEN ConSSN NOT IN ('000000000','111111111','888888888','999999999') AND LEFT(ConSSN,3) NOT IN ('111','000','999','888') THEN LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(REPLACE(ConSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(ConSSN, ' ', ''),4) END
                        ELSE LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(REPLACE(eepSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(eepSSN, ' ', ''),4) 
                    END 
        ,drvRelationship =    CASE WHEN BdmRecType = 'DEP' THEN
                                CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                    WHEN ConRelationship IN ('CHL','COD','DCH','STC') THEN 'Child'
                                    ELSE 'Other'
                                END
                            ELSE 'Employee'
                            END
        ,drvEmail = EepAddressEMail
        ,drvMobileNumber = EfoPhoneNumber
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'DEP' THEN ConDateOfBirth ELSE EepDateOfBirth END 
        ,drvGender = CASE WHEN BdmRecType = 'DEP' THEN ConGender ELSE EepGender END 
        ,drvAddressLine1 = '"' + EepAddressLine1 + '"'
        ,drvAddressLine2 = '"' + ISNULL(RTRIM(EepAddressLine2), '') + '"'
        ,drvAddressCity = '"' + ISNULL(EepAddressCity, '') + '"'
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = LEFT(EepAddressZipCode, 5)
        ,drvBenefitClass =    CASE WHEN EecEEType = 'PRN' THEN 'PRN' 
                                WHEN EecEEType = 'PTR' THEN 'PT'
                                WHEN EecEEType = 'REG' THEN 'FT'
                            END
        ,drvMedicalInsurancePlanName =    CASE WHEN MDPOS_DedCode IS NOT NULL THEN 'Choice POS II'
                                            WHEN MDBP_DedCode IS NOT NULL THEN 'Texas Health Aetna'
                                        END
        ,drvMedicalPlanEffectiveDate =    CASE WHEN MDPOS_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', MDPOS_StartDate, '11/1/2021')
                                            WHEN MDBP_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', MDBP_StartDate, '11/1/2021')
                                        END
        ,drvMedicalPlanTerminationDate =    CASE WHEN MDPOS_DedCode IS NOT NULL THEN MDPOS_StopDate
                                                WHEN MDBP_DedCode IS NOT NULL THEN MDBP_StopDate
                                            END
        ,drvDentalInsurancePlanName = CASE WHEN DEN_DedCode IS NOT NULL THEN 'Dental PPO' END
        ,drvDentalPlanEffectiveDate = CASE WHEN DEN_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', DEN_StartDate, '11/1/2021') END
        ,drvDentalPlanTerminationDate = CASE WHEN DEN_DedCode IS NOT NULL THEN DEN_StopDate END
        ,drvVisionInsurancePlanName = CASE WHEN VIS_DedCode IS NOT NULL THEN 'Aetna Vision' END
        ,drvVisionPlanEffectiveDate = CASE WHEN VIS_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VIS_StartDate, '11/1/2021') END
        ,drvVisionPlanTerminationDate = CASE WHEN VIS_DedCode IS NOT NULL THEN VIS_StopDate END
        ,drvBasicLifePlanName = CASE WHEN GLIFE_DedCode IS NOT NULL THEN 'Basic Life' END
        ,drvBasicLifeEffectiveDate = CASE WHEN GLIFE_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', GLIFE_StartDate, '11/1/2021') END
        ,drvBasicLifeTerminationDate = CASE WHEN GLIFE_DedCode IS NOT NULL THEN GLIFE_StopDate END
        ,drvSupplementalLifePlanName = CASE WHEN LIFEC_DedCode IS NOT NULL OR LIFEE_DedCode IS NOT NULL OR LIFES_DedCode IS NOT NULL THEN 'Supplemental Life' END
        ,drvSupplementalLifeEffDate =    CASE WHEN LIFEC_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', LIFEC_StartDate, '11/1/2021') 
                                            WHEN LIFEE_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', LIFEE_StartDate, '11/1/2021') 
                                            WHEN LIFES_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', LIFEC_StartDate, '11/1/2021') 
                                        END
        ,drvSupplementalLifeTermDate =    CASE WHEN LIFEC_DedCode IS NOT NULL THEN LIFEC_StopDate
                                            WHEN LIFEE_DedCode IS NOT NULL THEN LIFEE_StopDate
                                            WHEN LIFES_DedCode IS NOT NULL THEN LIFEC_StopDate
                                        END
        ,drvLtdPlanName = CASE WHEN LTDC_DedCode IS NOT NULL THEN 'LTD' END
        ,drvLtdEffectiveDate = CASE WHEN LTDC_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', LTDC_StartDate, '11/1/2021') END
        ,drvLtdTerminationDate = CASE WHEN LTDC_DedCode IS NOT NULL THEN LTDC_StopDate END
        ,drvStdPlanName = CASE WHEN STDC_DedCode IS NOT NULL THEN 'STD' END
        ,drvStdEffectiveDate = CASE WHEN STDC_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', STDC_StartDate, '11/1/2021') END
        ,drvStdTerminationDate = CASE WHEN STDC_DedCode IS NOT NULL THEN STDC_StopDate END
        ,drvHealthcareFsaPlanName = CASE WHEN FSA_DedCode IS NOT NULL THEN 'FSA Medical' END
        ,drvHealthcareFsaGoalAmount = CASE WHEN FSA_DedCode IS NOT NULL THEN FORMAT(FSA_EEAmt, '#0.00') END    
        ,drvHealthcareFsaEffectiveDate = CASE WHEN FSA_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', FSA_StartDate, '11/1/2021') END
        ,drvHealthcareFsaTermDate = CASE WHEN FSA_DedCode IS NOT NULL THEN FSA_StopDate END
        ,drvDependentCareFsaPlanName = CASE WHEN FSADC_DedCode IS NOT NULL THEN 'FSA Dependent Care' END
        ,drvDependentCareFsaGoalAmount = CASE WHEN FSADC_DedCode IS NOT NULL THEN FORMAT(FSADC_EEAmt, '#0.00') END    
        ,drvDependentCareFsaEffectDate = CASE WHEN FSADC_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', FSADC_StartDate, '11/1/2021') END
        ,drvDependentCareFsaTermDate = CASE WHEN FSADC_DedCode IS NOT NULL THEN FSADC_StopDate END
        ,drvAccidentPlanName = CASE WHEN ACCID_DedCode IS NOT NULL THEN 'Accident Plan' END
        ,drvAccidentEffectiveDate = CASE WHEN ACCID_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', ACCID_StartDate, '11/1/2021') END
        ,drvAccidentTerminationDate = CASE WHEN ACCID_DedCode IS NOT NULL THEN ACCID_StopDate END
        ,drvCriticalIllnessPlanName = CASE WHEN CRIEE_DedCode IS NOT NULL OR CRIEF_DedCode IS NOT NULL OR CRIES_DedCode IS NOT NULL OR CRIFS_DedCode IS NOT NULL THEN 'Critical Illness Plan' END
        ,drvCritIllnessPolicyEffDate =    CASE WHEN CRIEE_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', CRIEE_StartDate, '11/1/2021') 
                                            WHEN CRIEF_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', CRIEF_StartDate, '11/1/2021')
                                            WHEN CRIES_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', CRIES_StartDate, '11/1/2021')
                                            WHEN CRIFS_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', CRIFS_StartDate, '11/1/2021')
                                        END
        ,drvCritIllnessTerminationDate =    CASE WHEN CRIEE_DedCode IS NOT NULL THEN CRIEE_StopDate
                                                WHEN CRIEF_DedCode IS NOT NULL THEN CRIEF_StopDate
                                                WHEN CRIES_DedCode IS NOT NULL THEN CRIES_StopDate
                                                WHEN CRIFS_DedCode IS NOT NULL THEN CRIFS_StopDate
                                            END
        ,drvCustom1PlanName = CASE WHEN x401F_DedCode IS NOT NULL OR x401KC_DedCode IS NOT NULL OR x401P_DedCode IS NOT NULL THEN '401K Plan' END
        ,drvCustom1EffectiveDate =    CASE WHEN x401F_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', x401F_StartDate, '11/1/2021') 
                                        WHEN x401KC_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', x401KC_StartDate, '11/1/2021') 
                                        WHEN x401P_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', x401P_StartDate, '11/1/2021') 
                                    END
        ,drvCustom1TerminationDate =    CASE WHEN x401F_DedCode IS NOT NULL THEN x401F_StopDate
                                            WHEN x401KC_DedCode IS NOT NULL THEN x401KC_StopDate
                                            WHEN x401P_DedCode IS NOT NULL THEN x401P_StopDate
                                        END
        ,drvCustom2PlanName =    CASE WHEN IDSHD_DedCode IS NOT NULL THEN 'ID Shield'
                                    WHEN LEGAL_DedCode IS NOT NULL THEN 'Legal Shield'
                                    WHEN LSID_DedCode IS NOT NULL THEN 'Legal Shield / ID Shield'
                                END
        ,drvCustom2EffectiveDate =    CASE WHEN IDSHD_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', IDSHD_StartDate, '11/1/2021') 
                                        WHEN LEGAL_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', LEGAL_StartDate, '11/1/2021') 
                                        WHEN LSID_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', LSID_StartDate, '11/1/2021') 
                                    END
        ,drvCustom2TerminationDate =    CASE WHEN IDSHD_DedCode IS NOT NULL THEN IDSHD_StopDate
                                            WHEN LEGAL_DedCode IS NOT NULL THEN LEGAL_StopDate
                                            WHEN LSID_DedCode IS NOT NULL THEN LSID_StopDate
                                        END
        ,drvCustom3PlanName = CASE WHEN LTDBU_DedCode IS NOT NULL THEN 'Supplemental LTD' END
        ,drvCustom3EffectiveDate = CASE WHEN LTDBU_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', LTDBU_StartDate, '11/1/2021') END
        ,drvCustom3TerminationDate = CASE WHEN LTDBU_DedCode IS NOT NULL THEN LTDBU_StopDate END
        ,drvCustom4PlanName = CASE WHEN STDBU_DedCode IS NOT NULL THEN 'Supplemental STD' END
        ,drvCustom4EffectiveDate = CASE WHEN STDBU_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', STDBU_StartDate, '11/1/2021') END
        ,drvCustom4TerminationDate = CASE WHEN STDBU_DedCode IS NOT NULL THEN STDBU_StopDate END
    INTO dbo.U_EHJOYDEMEX_drvTbl
    FROM dbo.U_EHJOYDEMEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (
                SELECT BdmEEID, BdmCOID, BdmRecType, BdmDepRecId
                    ,MAX(CASE WHEN BdmDedCode = 'MDPOS' THEN BdmDedCode END) AS MDPOS_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'MDBP' THEN BdmDedCode END) AS MDBP_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmDedCode END) AS DEN_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmDedCode END) AS VIS_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmDedCode END) AS GLIFE_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmDedCode END) AS LIFEC_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmDedCode END) AS LIFEE_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmDedCode END) AS LIFES_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'LTDC' THEN BdmDedCode END) AS LTDC_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'STDC' THEN BdmDedCode END) AS STDC_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmDedCode END) AS FSA_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmDedCode END) AS FSADC_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'ACCID' THEN BdmDedCode END) AS ACCID_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'CRIEE' THEN BdmDedCode END) AS CRIEE_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'CRIEF' THEN BdmDedCode END) AS CRIEF_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'CRIFS' THEN BdmDedCode END) AS CRIFS_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'CRIES' THEN BdmDedCode END) AS CRIES_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = '401F' THEN BdmDedCode END) AS x401F_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = '401KC' THEN BdmDedCode END) AS x401KC_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = '401P' THEN BdmDedCode END) AS x401P_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'IDSHD' THEN BdmDedCode END) AS IDSHD_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'LEGAL' THEN BdmDedCode END) AS LEGAL_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'LSID' THEN BdmDedCode END) AS LSID_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'LTDBU' THEN BdmDedCode END) AS LTDBU_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'STDBU' THEN BdmDedCode END) AS STDBU_DedCode        
                    ,MAX(CASE WHEN BdmDedCode = 'MDPOS' THEN BdmBenStartDate END) AS MDPOS_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'MDBP' THEN BdmBenStartDate END) AS MDBP_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmBenStartDate END) AS DEN_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmBenStartDate END) AS VIS_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStartDate END) AS GLIFE_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStartDate END) AS LIFEC_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStartDate END) AS LIFEE_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStartDate END) AS LIFES_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTDC' THEN BdmBenStartDate END) AS LTDC_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'STDC' THEN BdmBenStartDate END) AS STDC_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmBenStartDate END) AS FSA_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmBenStartDate END) AS FSADC_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'ACCID' THEN BdmBenStartDate END) AS ACCID_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'CRIEE' THEN BdmBenStartDate END) AS CRIEE_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'CRIEF' THEN BdmBenStartDate END) AS CRIEF_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'CRIES' THEN BdmBenStartDate END) AS CRIES_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'CRIFS' THEN BdmBenStartDate END) AS CRIFS_StartDate
                    ,MAX(CASE WHEN BdmDedCode = '401F' THEN BdmBenStartDate END) AS x401F_StartDate
                    ,MAX(CASE WHEN BdmDedCode = '401KC' THEN BdmBenStartDate END) AS x401KC_StartDate
                    ,MAX(CASE WHEN BdmDedCode = '401P' THEN BdmBenStartDate END) AS x401P_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'IDSHD' THEN BdmBenStartDate END) AS IDSHD_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'LEGAL' THEN BdmBenStartDate END) AS LEGAL_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'LSID' THEN BdmBenStartDate END) AS LSID_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTDBU' THEN BdmBenStartDate END) AS LTDBU_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'STDBU' THEN BdmBenStartDate END) AS STDBU_StartDate

                    ,MAX(CASE WHEN BdmDedCode = 'MDPOS' THEN BdmBenStopDate END) AS MDPOS_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'MDBP' THEN BdmBenStopDate END) AS MDBP_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmBenStopDate END) AS DEN_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmBenStopDate END) AS VIS_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStopDate END) AS GLIFE_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStopDate END) AS LIFEC_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStopDate END) AS LIFEE_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStopDate END) AS LIFES_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTDC' THEN BdmBenStopDate END) AS LTDC_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'STDC' THEN BdmBenStopDate END) AS STDC_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmBenStopDate END) AS FSA_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmBenStopDate END) AS FSADC_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'ACCID' THEN BdmBenStopDate END) AS ACCID_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'CRIEE' THEN BdmBenStopDate END) AS CRIEE_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'CRIEF' THEN BdmBenStopDate END) AS CRIEF_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'CRIES' THEN BdmBenStopDate END) AS CRIES_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'CRIFS' THEN BdmBenStopDate END) AS CRIFS_StopDate
                    ,MAX(CASE WHEN BdmDedCode = '401F' THEN BdmBenStopDate END) AS x401F_StopDate
                    ,MAX(CASE WHEN BdmDedCode = '401KC' THEN BdmBenStopDate END) AS x401KC_StopDate
                    ,MAX(CASE WHEN BdmDedCode = '401P' THEN BdmBenStopDate END) AS x401P_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'IDSHD' THEN BdmBenStopDate END) AS IDSHD_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'LEGAL' THEN BdmBenStopDate END) AS LEGAL_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'LSID' THEN BdmBenStopDate END) AS LSID_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTDBU' THEN BdmBenStopDate END) AS LTDBU_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'STDBU' THEN BdmBenStopDate END) AS STDBU_StopDate     

                    ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmEEGoalAmt END) AS FSA_EEAmt
                    ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmEEGoalAmt END) AS FSADC_EEAmt
                FROM dbo.U_dsi_BDM_EHJOYDEMEX WITH (NOLOCK)
                GROUP BY BdmEEID, BdmCOID, BdmRecType, BdmDepRecId) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON xEEID = ConEEID
        AND BdmDepRecId = ConSystemId
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN --, ORDER BY Ef
                        FROM  dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL') AS Efo
                WHERE RN = 1 ) AS EfoPhone
        ON EfoEEID = xEEID
    LEFT JOIN dbo.U_EHJOYDEMEX_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
        AND AudKey2 = xCOID
    WHERE EecEmplStatus <> 'T' OR audOldValue = 'A'
    --(EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate)
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
ALTER VIEW dbo.dsi_vwEHJOYDEMEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHJOYDEMEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHJOYDEMEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202206041'
       ,expStartPerControl     = '202206041'
       ,expLastEndPerControl   = '202206109'
       ,expEndPerControl       = '202206109'
WHERE expFormatCode = 'EHJOYDEMEX'
    AND  expExportCode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHJOYDEMEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHJOYDEMEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EHJOYDEMEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EHJOYDEMEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EHJOYDEMEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHJOYDEMEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EHJOYDEMEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHJOYDEMEX', 'UseFileName', 'V', 'Y'


-- End ripout