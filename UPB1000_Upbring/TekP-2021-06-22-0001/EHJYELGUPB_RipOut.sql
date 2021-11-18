/**********************************************************************************

EHJYELGUPB: HealthJoy Eligibility Export

FormatCode:     EHJYELGUPB
Project:        HealthJoy Eligibility Export
Client ID:      UPB1000
Date/time:      2021-11-18 15:26:09.340
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB04
Database:       ULTIPRO_WPUPBG
Web Filename:   UPB1000_5EDIL_EEHISTORY_EHJYELGUPB_ExportCode_YYYYMMDD_HHMMSS.txt
ArchivePath:   
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EHJYELGUPB_SavePath') IS NOT NULL DROP TABLE dbo.U_EHJYELGUPB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EHJYELGUPB'


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
WHERE FormatCode = 'EHJYELGUPB'
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
WHERE ExpFormatCode = 'EHJYELGUPB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EHJYELGUPB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EHJYELGUPB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EHJYELGUPB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EHJYELGUPB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EHJYELGUPB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EHJYELGUPB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EHJYELGUPB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EHJYELGUPB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EHJYELGUPB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EHJYELGUPB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEHJYELGUPB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHJYELGUPB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHJYELGUPB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHJYELGUPB];
GO
IF OBJECT_ID('U_EHJYELGUPB_File') IS NOT NULL DROP TABLE [dbo].[U_EHJYELGUPB_File];
GO
IF OBJECT_ID('U_EHJYELGUPB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHJYELGUPB_EEList];
GO
IF OBJECT_ID('U_EHJYELGUPB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHJYELGUPB_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHJYELGUPB','HealthJoy Eligibility Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EHJYELGUPBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHJYELGUPBZ0','50','H','01','1',NULL,'Employer ID',NULL,NULL,'"Employer ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHJYELGUPBZ0','50','H','01','2',NULL,'Start Date',NULL,NULL,'"Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHJYELGUPBZ0','50','H','01','3',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHJYELGUPBZ0','50','H','01','4',NULL,'Employment Term Date',NULL,NULL,'"Employment Term Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHJYELGUPBZ0','50','H','01','5',NULL,'COBRA Start Date',NULL,NULL,'"COBRA Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHJYELGUPBZ0','50','H','01','6',NULL,'COBRA Termination Date',NULL,NULL,'"COBRA Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHJYELGUPBZ0','50','H','01','7',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHJYELGUPBZ0','50','H','01','8',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHJYELGUPBZ0','50','H','01','9',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHJYELGUPBZ0','50','H','01','10',NULL,'Relationship',NULL,NULL,'"Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHJYELGUPBZ0','50','H','01','11',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHJYELGUPBZ0','50','H','01','12',NULL,'Mobile Number',NULL,NULL,'"Mobile Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHJYELGUPBZ0','50','H','01','13',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHJYELGUPBZ0','50','H','01','14',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHJYELGUPBZ0','50','H','01','15',NULL,'Address Line 1',NULL,NULL,'"Address Line 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHJYELGUPBZ0','50','H','01','16',NULL,'Address Line 2',NULL,NULL,'"Address Line 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHJYELGUPBZ0','50','H','01','17',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHJYELGUPBZ0','50','H','01','18',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHJYELGUPBZ0','50','H','01','19',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHJYELGUPBZ0','50','H','01','20',NULL,'Benefit Class',NULL,NULL,'"Benefit Class"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHJYELGUPBZ0','50','H','01','21',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHJYELGUPBZ0','50','H','01','22',NULL,'Medical Insurance Plan Name',NULL,NULL,'"Medical Insurance Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHJYELGUPBZ0','50','H','01','23',NULL,'Medical Group ID',NULL,NULL,'"Medical Group ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHJYELGUPBZ0','50','H','01','24',NULL,'Medical Plan Effective Date',NULL,NULL,'"Medical Plan Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHJYELGUPBZ0','50','H','01','25',NULL,'Medical Plan Termination Date',NULL,NULL,'"Medical Plan Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHJYELGUPBZ0','50','H','01','26',NULL,'Dental Insurance Plan Name',NULL,NULL,'"Dental Insurance Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHJYELGUPBZ0','50','H','01','27',NULL,'Dental Group ID',NULL,NULL,'"Dental Group ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHJYELGUPBZ0','50','H','01','28',NULL,'Dental Plan Effective Date',NULL,NULL,'"Dental Plan Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHJYELGUPBZ0','50','H','01','29',NULL,'Dental Plan Termination Date',NULL,NULL,'"Dental Plan Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHJYELGUPBZ0','50','H','01','30',NULL,'Vision Insurance Plan Name',NULL,NULL,'"Vision Insurance Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHJYELGUPBZ0','50','H','01','31',NULL,'Vision Group ID',NULL,NULL,'"Vision Group ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHJYELGUPBZ0','50','H','01','32',NULL,'Vision Plan Effective Date',NULL,NULL,'"Vision Plan Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHJYELGUPBZ0','50','H','01','33',NULL,'Vision Plan Termination Date',NULL,NULL,'"Vision Plan Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHJYELGUPBZ0','50','H','01','34',NULL,'Basic Life Plan Name',NULL,NULL,'"Basic Life Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHJYELGUPBZ0','50','H','01','35',NULL,'Basic Life Policy Amount',NULL,NULL,'"Basic Life Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHJYELGUPBZ0','50','H','01','36',NULL,'Basic Life Effective Date',NULL,NULL,'"Basic Life Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EHJYELGUPBZ0','50','H','01','37',NULL,'Basic Life Policy Termination Date',NULL,NULL,'"Basic Life Policy Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EHJYELGUPBZ0','50','H','01','38',NULL,'Supplemental Life Plan Name',NULL,NULL,'"Supplemental Life Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EHJYELGUPBZ0','50','H','01','39',NULL,'Supplemental Life Policy Amount',NULL,NULL,'"Supplemental Life Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EHJYELGUPBZ0','50','H','01','40',NULL,'Supplemental Life Effective Date',NULL,NULL,'"Supplemental Life Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EHJYELGUPBZ0','50','H','01','41',NULL,'Supplemental Life Termination Date',NULL,NULL,'"Supplemental Life Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EHJYELGUPBZ0','50','H','01','42',NULL,'LTD Plan Name',NULL,NULL,'"LTD Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EHJYELGUPBZ0','50','H','01','43',NULL,'LTD Policy Amount',NULL,NULL,'"LTD Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EHJYELGUPBZ0','50','H','01','44',NULL,'LTD Effective Date',NULL,NULL,'"LTD Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EHJYELGUPBZ0','50','H','01','45',NULL,'LTD Termination Date',NULL,NULL,'"LTD Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EHJYELGUPBZ0','50','H','01','46',NULL,'STD Plan Name',NULL,NULL,'"STD Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EHJYELGUPBZ0','50','H','01','47',NULL,'STD Policy Amount',NULL,NULL,'"STD Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EHJYELGUPBZ0','50','H','01','48',NULL,'STD Effective Date',NULL,NULL,'"STD Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EHJYELGUPBZ0','50','H','01','49',NULL,'STD Termination Date',NULL,NULL,'"STD Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EHJYELGUPBZ0','50','H','01','50',NULL,'Healthcare FSA Plan Name',NULL,NULL,'"Healthcare FSA Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EHJYELGUPBZ0','50','H','01','51',NULL,'Healthcare FSA Goal Amount',NULL,NULL,'"Healthcare FSA Goal Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EHJYELGUPBZ0','50','H','01','52',NULL,'Healthcare FSA Effective Date',NULL,NULL,'"Healthcare FSA Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EHJYELGUPBZ0','50','H','01','53',NULL,'Healthcare FSA Termination Date',NULL,NULL,'"Healthcare FSA Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EHJYELGUPBZ0','50','H','01','54',NULL,'Dependent Care FSA Plan Name',NULL,NULL,'"Dependent Care FSA Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EHJYELGUPBZ0','50','H','01','55',NULL,'Dependent Care FSA Goal Amount',NULL,NULL,'"Dependent Care FSA Goal Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EHJYELGUPBZ0','50','H','01','56',NULL,'Dependent Care FSA Effective Date',NULL,NULL,'"Dependent Care FSA Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EHJYELGUPBZ0','50','H','01','57',NULL,'Dependent Care FSA Termination Date',NULL,NULL,'"Dependent Care FSA Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EHJYELGUPBZ0','50','H','01','58',NULL,'HSA Plan Name',NULL,NULL,'"HSA Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EHJYELGUPBZ0','50','H','01','59',NULL,'HSA Goal Amount',NULL,NULL,'"HSA Goal Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EHJYELGUPBZ0','50','H','01','60',NULL,'HSA Effective Date',NULL,NULL,'"HSA Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EHJYELGUPBZ0','50','H','01','61',NULL,'HSA Termination Date',NULL,NULL,'"HSA Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EHJYELGUPBZ0','50','H','01','62',NULL,'Accident Plan Name',NULL,NULL,'"Accident Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EHJYELGUPBZ0','50','H','01','63',NULL,'Accident Policy Amount',NULL,NULL,'"Accident Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EHJYELGUPBZ0','50','H','01','64',NULL,'Accident Effective Date',NULL,NULL,'"Accident Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EHJYELGUPBZ0','50','H','01','65',NULL,'Accident Termination Date',NULL,NULL,'"Accident Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EHJYELGUPBZ0','50','H','01','66',NULL,'Critical Illness Plan Name',NULL,NULL,'"Critical Illness Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EHJYELGUPBZ0','50','H','01','67',NULL,'Critical Illness Policy Amount',NULL,NULL,'"Critical Illness Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EHJYELGUPBZ0','50','H','01','68',NULL,'Critical Illness Policy Effective Date',NULL,NULL,'"Critical Illness Policy Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EHJYELGUPBZ0','50','H','01','69',NULL,'Critical Illness Termination Date',NULL,NULL,'"Critical Illness Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EHJYELGUPBZ0','50','H','01','70',NULL,'Hospital Indemnity Plan Name',NULL,NULL,'"Hospital Indemnity Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EHJYELGUPBZ0','50','H','01','71',NULL,'Hospital Indemnity Policy Amount',NULL,NULL,'"Hospital Indemnity Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EHJYELGUPBZ0','50','H','01','72',NULL,'Hospital Indemnity Policy Effective Date',NULL,NULL,'"Hospital Indemnity Policy Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EHJYELGUPBZ0','50','H','01','73',NULL,'Hospital Indemnity Termination Date',NULL,NULL,'"Hospital Indemnity Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EHJYELGUPBZ0','50','H','01','74',NULL,'Basic AD&D Plan Name',NULL,NULL,'"Basic AD&D Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EHJYELGUPBZ0','50','H','01','75',NULL,'Basic AD&D Policy Amount',NULL,NULL,'"Basic AD&D Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EHJYELGUPBZ0','50','H','01','76',NULL,'Basic AD&D Effective Date',NULL,NULL,'"Basic AD&D Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EHJYELGUPBZ0','50','H','01','77',NULL,'Basic AD&D Termination Date',NULL,NULL,'"Basic AD&D Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EHJYELGUPBZ0','50','H','01','78',NULL,'Voluntary AD&D Plan Name',NULL,NULL,'"Voluntary AD&D Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EHJYELGUPBZ0','50','H','01','79',NULL,'Voluntary AD&D Policy Amount',NULL,NULL,'"Voluntary AD&D Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EHJYELGUPBZ0','50','H','01','80',NULL,'Voluntary AD&D Effective Date',NULL,NULL,'"Voluntary AD&D Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EHJYELGUPBZ0','50','H','01','81',NULL,'Voluntary AD&D Termination Date',NULL,NULL,'"Voluntary AD&D Termination Date"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHJYELGUPBZ0','50','D','10','1',NULL,'Employer ID',NULL,NULL,'"drvEmployerID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHJYELGUPBZ0','50','D','10','2',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHJYELGUPBZ0','50','D','10','3',NULL,'Employment Status',NULL,NULL,'"drvEmplStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHJYELGUPBZ0','50','D','10','4',NULL,'Employment Term Date',NULL,NULL,'"drvEmplTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHJYELGUPBZ0','50','D','10','5',NULL,'COBRA Start Date',NULL,NULL,'"drvCobraStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHJYELGUPBZ0','50','D','10','6',NULL,'COBRA Termination Date',NULL,NULL,'"drvCobraTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHJYELGUPBZ0','50','D','10','7',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHJYELGUPBZ0','50','D','10','8',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHJYELGUPBZ0','50','D','10','9',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHJYELGUPBZ0','50','D','10','10',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHJYELGUPBZ0','50','D','10','11',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHJYELGUPBZ0','50','D','10','12',NULL,'Mobile Number',NULL,NULL,'"drvPhoneMobile"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHJYELGUPBZ0','50','D','10','13',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHJYELGUPBZ0','50','D','10','14',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHJYELGUPBZ0','50','D','10','15',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHJYELGUPBZ0','50','D','10','16',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHJYELGUPBZ0','50','D','10','17',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHJYELGUPBZ0','50','D','10','18',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHJYELGUPBZ0','50','D','10','19',NULL,'Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHJYELGUPBZ0','50','D','10','20',NULL,'Benefit Class',NULL,NULL,'"drvBenefitClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHJYELGUPBZ0','50','D','10','21',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHJYELGUPBZ0','50','D','10','22',NULL,'Medical Insurance Plan Name',NULL,NULL,'"drvMedPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHJYELGUPBZ0','50','D','10','23',NULL,'Medical Group ID',NULL,NULL,'"drvMedGroupID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHJYELGUPBZ0','50','D','10','24',NULL,'Medical Plan Effective Date',NULL,NULL,'"drvMedEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHJYELGUPBZ0','50','D','10','25',NULL,'Medical Plan Termination Date',NULL,NULL,'"drvMedTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHJYELGUPBZ0','50','D','10','26',NULL,'Dental Insurance Plan Name',NULL,NULL,'"drvDenPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHJYELGUPBZ0','50','D','10','27',NULL,'Dental Group ID',NULL,NULL,'"drvDenGroupID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHJYELGUPBZ0','50','D','10','28',NULL,'Dental Plan Effective Date',NULL,NULL,'"drvDenEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHJYELGUPBZ0','50','D','10','29',NULL,'Dental Plan Termination Date',NULL,NULL,'"drvDenTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHJYELGUPBZ0','50','D','10','30',NULL,'Vision Insurance Plan Name',NULL,NULL,'"drvVisPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHJYELGUPBZ0','50','D','10','31',NULL,'Vision Group ID',NULL,NULL,'"drvVisGroupID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHJYELGUPBZ0','50','D','10','32',NULL,'Vision Plan Effective Date',NULL,NULL,'"drvVisEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHJYELGUPBZ0','50','D','10','33',NULL,'Vision Plan Termination Date',NULL,NULL,'"drvVisTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHJYELGUPBZ0','50','D','10','34',NULL,'Basic Life Plan Name',NULL,NULL,'"drvBLPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHJYELGUPBZ0','50','D','10','35',NULL,'Basic Life Policy Amount',NULL,NULL,'"drvBLAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHJYELGUPBZ0','50','D','10','36',NULL,'Basic Life Effective Date',NULL,NULL,'"drvBLEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EHJYELGUPBZ0','50','D','10','37',NULL,'Basic Life Policy Termination Date',NULL,NULL,'"drvBLTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EHJYELGUPBZ0','50','D','10','38',NULL,'Supplemental Life Plan Name',NULL,NULL,'"drvOLPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EHJYELGUPBZ0','50','D','10','39',NULL,'Supplemental Life Policy Amount',NULL,NULL,'"drvOLAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EHJYELGUPBZ0','50','D','10','40',NULL,'Supplemental Life Effective Date',NULL,NULL,'"drvOLEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EHJYELGUPBZ0','50','D','10','41',NULL,'Supplemental Life Termination Date',NULL,NULL,'"drvOLTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EHJYELGUPBZ0','50','D','10','42',NULL,'LTD Plan Name',NULL,NULL,'"drvLTDPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EHJYELGUPBZ0','50','D','10','43',NULL,'LTD Policy Amount',NULL,NULL,'"drvLTDAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EHJYELGUPBZ0','50','D','10','44',NULL,'LTD Effective Date',NULL,NULL,'"drvLTDEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EHJYELGUPBZ0','50','D','10','45',NULL,'LTD Termination Date',NULL,NULL,'"drvLTDTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EHJYELGUPBZ0','50','D','10','46',NULL,'STD Plan Name',NULL,NULL,'"drvSTDPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EHJYELGUPBZ0','50','D','10','47',NULL,'STD Policy Amount',NULL,NULL,'"drvSTDAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EHJYELGUPBZ0','50','D','10','48',NULL,'STD Effective Date',NULL,NULL,'"drvSTDEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EHJYELGUPBZ0','50','D','10','49',NULL,'STD Termination Date',NULL,NULL,'"drvSTDTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EHJYELGUPBZ0','50','D','10','50',NULL,'Healthcare FSA Plan Name',NULL,NULL,'"drvFSAPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EHJYELGUPBZ0','50','D','10','51',NULL,'Healthcare FSA Goal Amount',NULL,NULL,'"drvFSAGoalAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EHJYELGUPBZ0','50','D','10','52',NULL,'Healthcare FSA Effective Date',NULL,NULL,'"drvFSAEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EHJYELGUPBZ0','50','D','10','53',NULL,'Healthcare FSA Termination Date',NULL,NULL,'"drvFSATermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EHJYELGUPBZ0','50','D','10','54',NULL,'Dependent Care FSA Plan Name',NULL,NULL,'"drvDCAPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EHJYELGUPBZ0','50','D','10','55',NULL,'Dependent Care FSA Goal Amount',NULL,NULL,'"drvDCAGoalAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EHJYELGUPBZ0','50','D','10','56',NULL,'Dependent Care FSA Effective Date',NULL,NULL,'"drvDCAEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EHJYELGUPBZ0','50','D','10','57',NULL,'Dependent Care FSA Termination Date',NULL,NULL,'"drvDCATermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EHJYELGUPBZ0','50','D','10','58',NULL,'HSA Plan Name',NULL,NULL,'"drvHSAPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EHJYELGUPBZ0','50','D','10','59',NULL,'HSA Goal Amount',NULL,NULL,'"drvHSAGoalAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EHJYELGUPBZ0','50','D','10','60',NULL,'HSA Effective Date',NULL,NULL,'"drvHSAEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EHJYELGUPBZ0','50','D','10','61',NULL,'HSA Termination Date',NULL,NULL,'"drvHSATermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EHJYELGUPBZ0','50','D','10','62',NULL,'Accident Plan Name',NULL,NULL,'"drvAccPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EHJYELGUPBZ0','50','D','10','63',NULL,'Accident Policy Amount',NULL,NULL,'"drvAccAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EHJYELGUPBZ0','50','D','10','64',NULL,'Accident Effective Date',NULL,NULL,'"drvAccEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EHJYELGUPBZ0','50','D','10','65',NULL,'Accident Termination Date',NULL,NULL,'"drvAccTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EHJYELGUPBZ0','50','D','10','66',NULL,'Critical Illness Plan Name',NULL,NULL,'"drvCritPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EHJYELGUPBZ0','50','D','10','67',NULL,'Critical Illness Policy Amount',NULL,NULL,'"drvCritAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EHJYELGUPBZ0','50','D','10','68',NULL,'Critical Illness Policy Effective Date',NULL,NULL,'"drvCritEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EHJYELGUPBZ0','50','D','10','69',NULL,'Critical Illness Termination Date',NULL,NULL,'"drvCritTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EHJYELGUPBZ0','50','D','10','70',NULL,'Hospital Indemnity Plan Name',NULL,NULL,'"drvHospPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EHJYELGUPBZ0','50','D','10','71',NULL,'Hospital Indemnity Policy Amount',NULL,NULL,'"drvHospAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EHJYELGUPBZ0','50','D','10','72',NULL,'Hospital Indemnity Policy Effective Date',NULL,NULL,'"drvHospEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EHJYELGUPBZ0','50','D','10','73',NULL,'Hospital Indemnity Termination Date',NULL,NULL,'"drvHospTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EHJYELGUPBZ0','50','D','10','74',NULL,'Basic AD&D Plan Name',NULL,NULL,'"drvBAPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EHJYELGUPBZ0','50','D','10','75',NULL,'Basic AD&D Policy Amount',NULL,NULL,'"drvBAAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EHJYELGUPBZ0','50','D','10','76',NULL,'Basic AD&D Effective Date',NULL,NULL,'"drvBAEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EHJYELGUPBZ0','50','D','10','77',NULL,'Basic AD&D Termination Date',NULL,NULL,'"drvBATermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EHJYELGUPBZ0','50','D','10','78',NULL,'Voluntary AD&D Plan Name',NULL,NULL,'"drvVADPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EHJYELGUPBZ0','50','D','10','79',NULL,'Voluntary AD&D Policy Amount',NULL,NULL,'"drvVADAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EHJYELGUPBZ0','50','D','10','80',NULL,'Voluntary AD&D Effective Date',NULL,NULL,'"drvVADEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EHJYELGUPBZ0','50','D','10','81',NULL,'Voluntary AD&D Termination Date',NULL,NULL,'"drvVADTermDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EHJYELGUPB_20211118.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202010139','EMPEXPORT','OEACTIVE',NULL,'EHJYELGUPB',NULL,NULL,NULL,'202010139','Oct 13 2020 12:44PM','Oct 13 2020 12:44PM','202010131',NULL,'','','202010131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',D5BZ5,CXX93',NULL,NULL,NULL,'Passive Open Enrollment Export','202107019','EMPEXPORT','OEPASSIVE',NULL,'EHJYELGUPB',NULL,NULL,NULL,'202107019','Oct 13 2020 12:44PM','Oct 13 2020 12:44PM','202107011',NULL,'','','202107011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthJoy Eligibility Export','202010139','EMPEXPORT','ONDEM_XOE',NULL,'EHJYELGUPB',NULL,NULL,NULL,'202010139','Oct 13 2020 12:44PM','Oct 13 2020 12:44PM','202010131',NULL,'','','202010131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',D5BZ5,CXX93',NULL,NULL,NULL,'HealthJoy Eligibility Ex-Sched','202010139','EMPEXPORT','SCH_EHJYEL',NULL,'EHJYELGUPB',NULL,NULL,NULL,'202108069','Oct 13 2020 12:44PM','Oct 13 2020 12:44PM','202107301',NULL,'','','202010131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'HealthJoy Eligibility Ex-Test','202111169','EMPEXPORT','TEST_XOE','Nov 16 2021  9:34PM','EHJYELGUPB',NULL,NULL,NULL,'202111169','Nov 16 2021 12:00AM','Dec 30 1899 12:00AM','202111021','958','','','202111021',dbo.fn_GetTimedKey(),NULL,'us3jReUPB1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELGUPB','ArchiveFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELGUPB','ArchivePath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELGUPB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELGUPB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELGUPB','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELGUPB','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELGUPB','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELGUPB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELGUPB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHJYELGUPB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHJYELGUPB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHJYELGUPB','D10','dbo.U_EHJYELGUPB_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EHJYELGUPB_drvTbl
-----------

IF OBJECT_ID('U_EHJYELGUPB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHJYELGUPB_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEmployerID] varchar(11) NULL,
    [drvStartDate] datetime NULL,
    [drvEmplStatus] char(1) NULL,
    [drvEmplTermDate] datetime NULL,
    [drvCobraStartDate] int NULL,
    [drvCobraTermDate] int NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvSSN] varchar(11) NULL,
    [drvRelationship] varchar(8) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhoneMobile] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvBenefitClass] varchar(1) NOT NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvMedPlanName] varchar(40) NULL,
    [drvMedGroupID] varchar(1) NOT NULL,
    [drvMedEffDate] datetime NULL,
    [drvMedTermDate] datetime NULL,
    [drvDenPlanName] varchar(40) NULL,
    [drvDenGroupID] varchar(1) NOT NULL,
    [drvDenEffDate] datetime NULL,
    [drvDenTermDate] datetime NULL,
    [drvVisPlanName] varchar(40) NULL,
    [drvVisGroupID] varchar(1) NOT NULL,
    [drvVisEffDate] datetime NULL,
    [drvVisTermDate] datetime NULL,
    [drvBLPlanName] varchar(40) NULL,
    [drvBLAmount] varchar(1) NOT NULL,
    [drvBLEffDate] datetime NULL,
    [drvBLTermDate] datetime NULL,
    [drvOLPlanName] varchar(40) NULL,
    [drvOLAmount] varchar(30) NULL,
    [drvOLEffDate] datetime NULL,
    [drvOLTermDate] datetime NULL,
    [drvLTDPlanName] varchar(40) NULL,
    [drvLTDAmount] varchar(30) NULL,
    [drvLTDEffDate] datetime NULL,
    [drvLTDTermDate] datetime NULL,
    [drvSTDPlanName] varchar(40) NULL,
    [drvSTDAmount] varchar(30) NULL,
    [drvSTDEffDate] datetime NULL,
    [drvSTDTermDate] datetime NULL,
    [drvFSAPlanName] varchar(40) NULL,
    [drvFSAGoalAmt] varchar(30) NULL,
    [drvFSAEffDate] datetime NULL,
    [drvFSATermDate] datetime NULL,
    [drvDCAPlanName] varchar(1) NOT NULL,
    [drvDCAGoalAmt] varchar(1) NOT NULL,
    [drvDCAEffDate] int NULL,
    [drvDCATermDate] int NULL,
    [drvHSAPlanName] varchar(1) NOT NULL,
    [drvHSAGoalAmt] varchar(1) NOT NULL,
    [drvHSAEffDate] int NULL,
    [drvHSATermDate] int NULL,
    [drvAccPlanName] varchar(40) NULL,
    [drvAccAmount] varchar(1) NOT NULL,
    [drvAccEffDate] datetime NULL,
    [drvAccTermDate] datetime NULL,
    [drvCritPlanName] varchar(40) NULL,
    [drvCritAmount] varchar(1) NOT NULL,
    [drvCritEffDate] datetime NULL,
    [drvCritTermDate] datetime NULL,
    [drvHospPlanName] varchar(1) NOT NULL,
    [drvHospAmount] varchar(1) NOT NULL,
    [drvHospEffDate] int NULL,
    [drvHospTermDate] int NULL,
    [drvBAPlanName] varchar(40) NULL,
    [drvBAAmount] varchar(30) NULL,
    [drvBAEffDate] datetime NULL,
    [drvBATermDate] datetime NULL,
    [drvVADPlanName] varchar(40) NULL,
    [drvVADAmount] varchar(30) NULL,
    [drvVADEffDate] datetime NULL,
    [drvVADTermDate] datetime NULL
);

-----------
-- Create table U_EHJYELGUPB_EEList
-----------

IF OBJECT_ID('U_EHJYELGUPB_EEList') IS NULL
CREATE TABLE [dbo].[U_EHJYELGUPB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EHJYELGUPB_File
-----------

IF OBJECT_ID('U_EHJYELGUPB_File') IS NULL
CREATE TABLE [dbo].[U_EHJYELGUPB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHJYELGUPB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Upbring

Created By: Ashley Schaeffer
Business Analyst: Michael Christopher
Create Date: 10/13/2020
Service Request Number: UPB1000-2020-00288485

Purpose: HealthJoy Eligibility Export

Revision History
----------------
08/09/2021 by AP:
        - Update to original EHJYELGUPB.
        - Modified JOINS to use the DedDedTypes required along with other updates required.

09/03/2021 by AP:
        - Updated mapping config to use DedTypes rather than DedCodes.
        - Removed the UpdDedType config. GTL types are not showing as "GTL" in DedDedType, they are showing as "UP" OR "UPA".

10/19/2021 by AP:
        - Added missing OPS and OPC.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHJYELGUPB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHJYELGUPB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHJYELGUPB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHJYELGUPB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHJYELGUPB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJYELGUPB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJYELGUPB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJYELGUPB', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJYELGUPB', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHJYELGUPB', 'SCH_EHJYEL';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHJYELGUPB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EHJYELGUPB', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@MinCovDate        DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EHJYELGUPB';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@MinCovDate      = CONCAT(LEFT(EndPerControl,4),'0101')

    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EHJYELGUPB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHJYELGUPB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --Excluded employees
    DELETE dbo.U_EHJYELGUPB_EEList
    FROM dbo.U_EHJYELGUPB_EEList
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    WHERE EecEEType IN ('PRN','INT','CTR','PTB','TES')
        OR EepNameLast = 'TestUPBG'
    ;

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
   -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','DPL,DPL2,DPH,DPH2,MPB,MPB2,MPC,MPC2,STD,LTD,VA,VP,VP2,L,J,JC,JS,FSA,UP,UPA,VAD');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedTypes','MED,DEN,VIS,OPT,STD,LTD,LTC,DRG,FSA,GTL,UP,UPA,ADD,OT1,OPC,OPS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'UpdDedType','GTL');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
   INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ExclFutureDatedStartDates','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ExclFutureDatedStopDates','Y');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    
    --Run Calculations
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --Update benefits amount to calculation
    UPDATE dbo.U_dsi_bdm_EmpDeductions
    SET EedbenAmt = BcaBenAmtCalc
    
    FROM dbo.U_dsi_bdm_EmpDeductions
    JOIN dbo.u_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
        ON EedEEID = bcaEEID
        AND EedCOID = bcaCOID
        AND EedFormatCode = bcaFormatCode 
        AND EedDedCode = bcaDedCode
    WHERE EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y';

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHJYELGUPB_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHJYELGUPB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHJYELGUPB_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        ,drvSubSort = '1'
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvEmployerID = SUBSTRING(EepSSN,1,3)+'-'+SUBSTRING(EepSSN,4,2)+'-'+SUBSTRING(EepSSN,6,4)
        ,drvStartDate = EecDateOfLastHire
        ,drvEmplStatus = EecEmplStatus
        ,drvEmplTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvCobraStartDate = NULL
        ,drvCobraTermDate = NULL
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = REPLACE(EepNameLast,',','')
        ,drvSSN = SUBSTRING(EepSSN,1,3)+'-'+SUBSTRING(EepSSN,4,2)+'-'+SUBSTRING(EepSSN,6,4)
        ,drvRelationship = 'Employee'
        ,drvEmail = EepAddressEMail
        ,drvPhoneMobile = EfoPhoneNumber
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvAddressLine1 = REPLACE(EepAddressLine1,',','')
        ,drvAddressLine2 = REPLACE(EepAddressLine2,',','')
        ,drvAddressCity = REPLACE(EepAddressCity,',','')
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvBenefitClass = ''
        ,drvDivision = ''
        ,drvMedPlanName = MED.DedLongDesc
        ,drvMedGroupID = ''
        ,drvMedEffDate = CASE WHEN MED.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, MED.EedBenStartDate) END
        ,drvMedTermDate = MED.EedBenStopDate
        ,drvDenPlanName = DEN.DedLongDesc
        ,drvDenGroupID = ''
        ,drvDenEffDate = CASE WHEN DEN.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, DEN.EedBenStartDate) END
        ,drvDenTermDate = DEN.EedBenStopDate
        ,drvVisPlanName = VIS.DedLongDesc
        ,drvVisGroupID = ''
        ,drvVisEffDate = CASE WHEN VIS.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, VIS.EedBenStartDate) END
        ,drvVisTermDate = VIS.EedBenStopDate
        ,drvBLPlanName = BL.DedLongDesc
        ,drvBLAmount = ''    --CONVERT(VARCHAR, BL.EedBenAmt)
        ,drvBLEffDate = CASE WHEN BL.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, BL.EedBenStartDate) END
        ,drvBLTermDate = BL.EedBenStopDate
        ,drvOLPlanName = OL.DedLongDesc
        ,drvOLAmount = CONVERT(VARCHAR, OL.EedBenAmt)
        ,drvOLEffDate = CASE WHEN OL.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, OL.EedBenStartDate) END
        ,drvOLTermDate = OL.EedBenStopDate
        ,drvLTDPlanName = LTD.DedLongDesc
        ,drvLTDAmount = CONVERT(VARCHAR, LTD.EedBenAmt)
        ,drvLTDEffDate = CASE WHEN LTD.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, LTD.EedBenStartDate) END
        ,drvLTDTermDate = LTD.EedBenStopDate
        ,drvSTDPlanName = STD.DedLongDesc
        ,drvSTDAmount = CONVERT(VARCHAR, STD.EedBenAmt)
        ,drvSTDEffDate = CASE WHEN STD.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, STD.EedBenStartDate) END
        ,drvSTDTermDate = STD.EedBenStopDate
        ,drvFSAPlanName = FSA.DedLongDesc
        ,drvFSAGoalAmt = CONVERT(VARCHAR, FSA.EedEEGoalAmt)
        ,drvFSAEffDate = CASE WHEN FSA.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, FSA.EedBenStartDate) END
        ,drvFSATermDate = FSA.EedBenStopDate
        ,drvDCAPlanName = ''
        ,drvDCAGoalAmt = ''
        ,drvDCAEffDate = NULL
        ,drvDCATermDate = NULL
        ,drvHSAPlanName = ''
        ,drvHSAGoalAmt = ''
        ,drvHSAEffDate = NULL
        ,drvHSATermDate = NULL
        ,drvAccPlanName = ACC.DedLongDesc
        ,drvAccAmount = ''
        ,drvAccEffDate = ACC.EedBenStartDate
        ,drvAccTermDate = ACC.EedBenStopDate
        ,drvCritPlanName = CRIT.DedLongDesc
        ,drvCritAmount = ''    --10/28/2020 Michael confirmed we are not sending critical illness amounts
                            --CONVERT(VARCHAR, CRIT.EedBenAmt)
        ,drvCritEffDate = CASE WHEN CRIT.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, CRIT.EedBenStartDate) END
        ,drvCritTermDate = CRIT.EedBenStopDate
        ,drvHospPlanName = ''
        ,drvHospAmount = ''
        ,drvHospEffDate = NULL
        ,drvHospTermDate = NULL
        ,drvBAPlanName = BA.DedLongDesc
        ,drvBAAmount = CONVERT(VARCHAR, BA.EedBenAmt)
        ,drvBAEffDate = CASE WHEN BA.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, BA.EedBenStartDate) END
        ,drvBATermDate = BA.EedBenStopDate
        ,drvVADPlanName = VAD.DedLongDesc
        ,drvVADAmount = CONVERT(VARCHAR, VAD.EedBenAmt)
        ,drvVADEffDate = CASE WHEN VAD.EedEEID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, VAD.EedBenStartDate) END
        ,drvVADTermDate = VAD.EedBenStopDate

    INTO dbo.U_EHJYELGUPB_drvTbl
    FROM dbo.U_EHJYELGUPB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions BDM WITH (NOLOCK)
        ON BDM.EedEEID = xEEID 
        AND BDM.EedCoID = xCoID
        AND BDM.EedFormatCode = @FormatCode 
        AND BDM.EedValidForExport = 'Y'
        --Only include people on file who are enrolled in medical
        --AND BDM.EedDedCode IN ('MPB','MPB2','MPC','MPC2')
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions MED WITH (NOLOCK)
        ON MED.EedEEID = xEEID 
        AND MED.EedCoID = xCoID
        AND MED.EedFormatCode = @FormatCode 
        AND MED.EedValidForExport = 'Y'
      --  AND MED.EedDedCode IN ('MPB','MPB2','MPC','MPC2')
        AND MED.DedDedType = 'MED'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions DEN WITH (NOLOCK)
        ON DEN.EedEEID = xEEID 
        AND DEN.EedCoID = xCoID
        AND DEN.EedFormatCode = @FormatCode 
        AND DEN.EedValidForExport = 'Y'
      --  AND DEN.EedDedCode IN ('DPL','DPL2','DPH','DPH2')
        AND DEN.DedDedType = 'DEN'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions VIS WITH (NOLOCK)
        ON VIS.EedEEID = xEEID 
        AND VIS.EedCoID = xCoID
        AND VIS.EedFormatCode = @FormatCode 
        AND VIS.EedValidForExport = 'Y'
        --AND VIS.EedDedCode IN ('VA','VP','VP2')
        AND VIS.DedDedType = 'VIS'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions OL WITH (NOLOCK)
        ON OL.EedEEID = xEEID 
        AND OL.EedCoID = xCoID
        AND OL.EedFormatCode = @FormatCode 
        AND OL.EedValidForExport = 'Y'
        --AND OL.EedDedCode IN ('J')
        AND OL.DedDedType = 'OPT'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions STD WITH (NOLOCK)
        ON STD.EedEEID = xEEID 
        AND STD.EedCoID = xCoID
        AND STD.EedFormatCode = @FormatCode 
        AND STD.EedValidForExport = 'Y'
       -- AND STD.EedDedCode IN ('STD')
       AND STD.DedDedType = 'STD'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions LTD WITH (NOLOCK)
        ON LTD.EedEEID = xEEID 
        AND LTD.EedCoID = xCoID
        AND LTD.EedFormatCode = @FormatCode 
        AND LTD.EedValidForExport = 'Y'
     --   AND LTD.EedDedCode IN ('LTD')
        AND LTD.DedDedType = 'LTD'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions CRIT WITH (NOLOCK)
        ON CRIT.EedEEID = xEEID 
        AND CRIT.EedCoID = xCoID
        AND CRIT.EedFormatCode = @FormatCode 
        AND CRIT.EedValidForExport = 'Y'
      --  AND CRIT.EedDedCode IN ('L')
   --     AND CRIT.DedDedType IN ('LTC', 'DRG')
        AND CRIT.DedDedType = 'LTC'
        AND CRIT.EedDedCode <> 'N' -- N dedcode not in use
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions FSA WITH (NOLOCK)
        ON FSA.EedEEID = xEEID 
        AND FSA.EedCoID = xCoID
        AND FSA.EedFormatCode = @FormatCode 
        AND FSA.EedValidForExport = 'Y'
        AND FSA.EedDedCode IN ('FSA')
        AND FSA.DedDedType = 'FSA'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions BL WITH (NOLOCK)
        ON BL.EedEEID = xEEID 
        AND BL.EedCoID = xCoID
        AND BL.EedFormatCode = @FormatCode 
        AND BL.EedValidForExport = 'Y'
        AND BL.EedDedCode IN ('UP')
        AND BL.DedDedType = 'GTL'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions BA WITH (NOLOCK)
        ON BA.EedEEID = xEEID 
        AND BA.EedCoID = xCoID
        AND BA.EedFormatCode = @FormatCode 
        AND BA.EedValidForExport = 'Y'
        AND BA.EedDedCode IN ('UPA')
        AND BA.DedDedType = 'GTL'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions VAD WITH (NOLOCK)
        ON VAD.EedEEID = xEEID 
        AND VAD.EedCoID = xCoID
        AND VAD.EedFormatCode = @FormatCode 
        AND VAD.EedValidForExport = 'Y'
       -- AND VAD.EedDedCode IN ('VAD')
        AND VAD.DedDedType = 'ADD'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions ACC WITH (NOLOCK)
        ON ACC.EedEEID = xEEID
        AND ACC.EedCOID = xCOID
        AND ACC.EedFormatCode = @FormatCode
        AND ACC.EedValidForExport = 'Y'
        AND ACC.DedDedType = 'OT1' -- Accident Plan
    LEFT JOIN (SELECT TOP 1 EfoEEID, EfoPhoneNumber FROM dbo.EmpMPhon WITH(NOLOCK) WHERE efoPhoneType = 'CEL') as M on M.EfoEEID = xEEID
    ;

--Dependent Records
    INSERT INTO dbo.U_EHJYELGUPB_drvTbl
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),ConSystemID) --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        ,drvSubSort =    CASE
                        WHEN ConRelationship IN ('SPS','DP') THEN '2'
                        ELSE '3'
                        END
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvEmployerID = SUBSTRING(EepSSN,1,3)+'-'+SUBSTRING(EepSSN,4,2)+'-'+SUBSTRING(EepSSN,6,4)
        ,drvStartDate = NULL
        ,drvEmplStatus = ''
        ,drvEmplTermDate = NULL
        ,drvCobraStartDate = NULL
        ,drvCobraTermDate = NULL
        ,drvNameFirst = ConNameFirst
        ,drvNameLast = REPLACE(ConNameLast,',','')
        ,drvSSN = SUBSTRING(ConSSN,1,3)+'-'+SUBSTRING(ConSSN,4,2)+'-'+SUBSTRING(ConSSN,6,4)
        ,drvRelationship =    CASE
                            WHEN ConRelationship IN ('SPS','DP') THEN 'Spouse'
                            ELSE 'Child'
                            END
        ,drvEmail = ConEmailAddr
        ,drvPhoneMobile = CASE WHEN ConPhoneOtherType = 'CEL' THEN ConPhoneOtherNumber END
        ,drvDateOfBirth = ConDateOfBirth
        ,drvGender = ConGender
        ,drvAddressLine1 = ConAddressLine1
        ,drvAddressLine2 = ConAddressLine2
        ,drvAddressCity = ConAddressCity
        ,drvAddressState = ConAddressState
        ,drvAddressZipCode = ConAddressZipCode
        ,drvBenefitClass = ''
        ,drvDivision = ''
        ,drvMedPlanName = MED.DedLongDesc
        ,drvMedGroupID = ''
        ,drvMedEffDate = CASE WHEN MED.DbnDepRecID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, MED.DbnBenStartDate) END
        ,drvMedTermDate = MED.DbnBenStopDate
        ,drvDenPlanName = DEN.DedLongDesc
        ,drvDenGroupID = ''
        ,drvDenEffDate = CASE WHEN DEN.DbnDepRecID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, DEN.DbnBenStartDate) END
        ,drvDenTermDate = DEN.DbnBenStopDate
        ,drvVisPlanName = VIS.DedLongDesc
        ,drvVisGroupID = ''
        ,drvVisEffDate = CASE WHEN VIS.DbnDepRecID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, VIS.DbnBenStartDate) END
        ,drvVisTermDate = VIS.DbnBenStopDate
        ,drvBLPlanName = ''
        ,drvBLAmount = ''
        ,drvBLEffDate = NULL
        ,drvBLTermDate = NULL
        ,drvOLPlanName = OL.DedLongDesc
        ,drvOLAmount = CONVERT(VARCHAR, OLAMT.EedBenAmt)
        ,drvOLEffDate = CASE WHEN OL.DbnDepRecID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, OL.DbnBenStartDate) END
        ,drvOLTermDate = OL.DbnBenStopDate
        ,drvLTDPlanName = ''
        ,drvLTDAmount = ''
        ,drvLTDEffDate = NULL
        ,drvLTDTermDate = NULL
        ,drvSTDPlanName = ''
        ,drvSTDAmount = ''
        ,drvSTDEffDate = NULL
        ,drvSTDTermDate = NULL
        ,drvFSAPlanName = ''
        ,drvFSAGoalAmt = ''
        ,drvFSAEffDate = NULL
        ,drvFSATermDate = NULL
        ,drvDCAPlanName = ''
        ,drvDCAGoalAmt = ''
        ,drvDCAEffDate = NULL
        ,drvDCATermDate = NULL
        ,drvHSAPlanName = ''
        ,drvHSAGoalAmt = ''
        ,drvHSAEffDate = NULL
        ,drvHSATermDate = NULL
        ,drvAccPlanName = ACC.DedLongDesc
        ,drvAccAmount = ''
        ,drvAccEffDate = ACC.DbnBenStartDate
        ,drvAccTermDate = ACC.DbnBenStopDate
        ,drvCritPlanName = CRIT.DedLongDesc
        ,drvCritAmount = ''    --CONVERT(VARCHAR, CRITAMT.EedBenAmt)
        ,drvCritEffDate = CASE WHEN CRIT.DbnDepRecID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, CRIT.DbnBenStartDate) END
        ,drvCritTermDate = CRIT.DbnBenStopDate
        ,drvHospPlanName = ''
        ,drvHospAmount = ''
        ,drvHospEffDate = NULL
        ,drvHospTermDate = NULL
        ,drvBAPlanName = ''
        ,drvBAAmount = ''
        ,drvBAEffDate = NULL
        ,drvBATermDate = NULL
        ,drvVADPlanName = ''
        ,drvVADAmount = ''
        ,drvVADEffDate = NULL
        ,drvVADTermDate = NULL

    FROM dbo.U_EHJYELGUPB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_DepDeductions BDM WITH (NOLOCK)
        ON BDM.DbnEEID = xEEID 
        AND BDM.DbnCoID = xCoID
        AND BDM.DbnFormatCode = @FormatCode 
        AND BDM.DbnValidForExport = 'Y'
        --Only include people on file who are enrolled in medical
        AND BDM.DbnDedCode IN ('MPB','MPB2','MPC','MPC2')
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConSystemID = BDM.DbnDepRecID
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions MED WITH (NOLOCK)
        ON MED.DbnEEID = xEEID 
        AND MED.DbnCoID = xCoID
        AND MED.DbnFormatCode = @FormatCode 
        AND MED.DbnValidForExport = 'Y'
       -- AND MED.DbnDedCode IN ('MPB','MPB2','MPC','MPC2')
        AND MED.DedDedType = 'MED'
        AND MED.DbnDepRecID = ConSystemID
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions DEN WITH (NOLOCK)
        ON DEN.DbnEEID = xEEID 
        AND DEN.DbnCoID = xCoID
        AND DEN.DbnFormatCode = @FormatCode 
        AND DEN.DbnValidForExport = 'Y'
        --AND DEN.DbnDedCode IN ('DPL','DPL2','DPH','DPH2')
        AND DEN.DedDedType = 'DEN'
        AND DEN.DbnDepRecID = ConSystemID
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions VIS WITH (NOLOCK)
        ON VIS.DbnEEID = xEEID 
        AND VIS.DbnCoID = xCoID
        AND VIS.DbnFormatCode = @FormatCode 
        AND VIS.DbnValidForExport = 'Y'
        --AND VIS.DbnDedCode IN ('VA','VP','VP2')
        AND VIS.DedDedType = 'VIS'
        AND VIS.DbnDepRecID = ConSystemID
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions OL WITH (NOLOCK)
        ON OL.DbnEEID = xEEID 
        AND OL.DbnCoID = xCoID
        AND OL.DbnFormatCode = @FormatCode 
        AND OL.DbnValidForExport = 'Y'
        --AND OL.DbnDedCode IN ('JC','JS')
        AND OL.DedDedType IN ('OPC', 'OPS')
        AND OL.DbnDepRecID = ConSystemID
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions OLAMT WITH (NOLOCK)
        ON OLAMT.EedEEID = xEEID 
        AND OLAMT.EedCoID = xCoID
        AND OLAMT.EedFormatCode = @FormatCode 
        AND OLAMT.EedValidForExport = 'Y'
        AND OLAMT.EedDedCode IN ('JC','JS')
        AND OLAMT.EedDedCode = OL.DbnDedCode
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions CRIT WITH (NOLOCK)
        ON CRIT.DbnEEID = xEEID 
        AND CRIT.DbnCoID = xCoID
        AND CRIT.DbnFormatCode = @FormatCode 
        AND CRIT.DbnValidForExport = 'Y'
        --AND CRIT.DbnDedCode IN ('L')
     --   AND CRIT.DedDedType IN ('LTC', 'DRG')
        AND CRIT.DedDedType = 'DRG'
        AND CRIT.DbnDepRecID = ConSystemID
      LEFT JOIN dbo.U_dsi_BDM_DepDeductions ACC WITH (NOLOCK)
        ON ACC.DbnEEID = xEEID
        AND ACC.DbnCoID = xCOID
        AND ACC.DbnFormatCode = @FormatCode
        AND ACC.DbnValidForExport = 'Y'
        AND ACC.DedDedType = 'OT1' -- Accident Plan
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions CRITAMT WITH (NOLOCK)
        ON CRITAMT.EedEEID = xEEID 
        AND CRITAMT.EedCoID = xCoID
        AND CRITAMT.EedFormatCode = @FormatCode 
        AND CRITAMT.EedValidForExport = 'Y'
        AND CRITAMT.EedDedCode IN ('JC','JS')
        AND CRITAMT.EedDedCode = CRIT.DbnDedCode
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
ALTER VIEW dbo.dsi_vwEHJYELGUPB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHJYELGUPB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHJYELGUPB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202010061'
       ,expStartPerControl     = '202010061'
       ,expLastEndPerControl   = '202010139'
       ,expEndPerControl       = '202010139'
WHERE expFormatCode = 'EHJYELGUPB';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHJYELGUPB_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHJYELGUPB_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EHJYELGUPB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EHJYELGUPB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EHJYELGUPB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHJYELGUPB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EHJYELGUPB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHJYELGUPB', 'UseFileName', 'V', 'Y'


-- End ripout