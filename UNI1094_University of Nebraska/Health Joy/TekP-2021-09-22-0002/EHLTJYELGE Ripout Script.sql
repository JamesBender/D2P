/**********************************************************************************

EHLTJYELGE: Health Joy Eligibiity Export

FormatCode:     EHLTJYELGE
Project:        Health Joy Eligibiity Export
Client ID:      UNI1094
Date/time:      2021-11-11 05:37:32.537
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB03
Database:       ULTIPRO_WPUNOF
Web Filename:   UNI1094_IZF0B_EEHISTORY_EHLTJYELGE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EHLTJYELGE_SavePath') IS NOT NULL DROP TABLE dbo.U_EHLTJYELGE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EHLTJYELGE'


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
WHERE FormatCode = 'EHLTJYELGE'
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
WHERE ExpFormatCode = 'EHLTJYELGE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EHLTJYELGE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EHLTJYELGE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EHLTJYELGE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EHLTJYELGE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EHLTJYELGE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EHLTJYELGE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EHLTJYELGE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EHLTJYELGE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EHLTJYELGE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EHLTJYELGE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEHLTJYELGE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHLTJYELGE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHLTJYELGE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHLTJYELGE];
GO
IF OBJECT_ID('U_EHLTJYELGE_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EHLTJYELGE_PEarHist];
GO
IF OBJECT_ID('U_EHLTJYELGE_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EHLTJYELGE_PDedHist];
GO
IF OBJECT_ID('U_EHLTJYELGE_File') IS NOT NULL DROP TABLE [dbo].[U_EHLTJYELGE_File];
GO
IF OBJECT_ID('U_EHLTJYELGE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHLTJYELGE_EEList];
GO
IF OBJECT_ID('U_EHLTJYELGE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHLTJYELGE_drvTbl];
GO
IF OBJECT_ID('U_EHLTJYELGE_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHLTJYELGE_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EHLTJYELGE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EHLTJYELGE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHLTJYELGE','Health Joy Eligibiity Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','5000','S','N','EHLTJYELGEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHLTJYELGEZ0','50','H','01','1',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHLTJYELGEZ0','50','H','01','2',NULL,'Start Date',NULL,NULL,'"Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHLTJYELGEZ0','50','H','01','3',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHLTJYELGEZ0','50','H','01','4',NULL,'Employment Termination Date',NULL,NULL,'"Employment Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHLTJYELGEZ0','50','H','01','5',NULL,'COBRA Start Date',NULL,NULL,'"COBRA Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHLTJYELGEZ0','50','H','01','6',NULL,'COBRA Termination Date',NULL,NULL,'"COBRA Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHLTJYELGEZ0','50','H','01','7',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHLTJYELGEZ0','50','H','01','8',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHLTJYELGEZ0','50','H','01','9',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHLTJYELGEZ0','50','H','01','10',NULL,'Relationship',NULL,NULL,'"Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHLTJYELGEZ0','50','H','01','11',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHLTJYELGEZ0','50','H','01','12',NULL,'Mobile Number',NULL,NULL,'"Mobile Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHLTJYELGEZ0','50','H','01','13',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHLTJYELGEZ0','50','H','01','14',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHLTJYELGEZ0','50','H','01','15',NULL,'Address Line 1',NULL,NULL,'"Address Line 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHLTJYELGEZ0','50','H','01','16',NULL,'Address Line 2',NULL,NULL,'"Address Line 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHLTJYELGEZ0','50','H','01','17',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHLTJYELGEZ0','50','H','01','18',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHLTJYELGEZ0','50','H','01','19',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHLTJYELGEZ0','50','H','01','20',NULL,'Benefit Class',NULL,NULL,'"Benefit Class"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHLTJYELGEZ0','50','H','01','21',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHLTJYELGEZ0','50','H','01','22',NULL,'Medical Insurance Plan Name',NULL,NULL,'"Medical Insurance Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHLTJYELGEZ0','50','H','01','23',NULL,'Medical Group ID',NULL,NULL,'"Medical Group ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHLTJYELGEZ0','50','H','01','24',NULL,'Medical Plan Effective Date',NULL,NULL,'"Medical Plan Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHLTJYELGEZ0','50','H','01','25',NULL,'Medical Plan Termination Date',NULL,NULL,'"Medical Plan Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHLTJYELGEZ0','50','H','01','26',NULL,'Dental Insurance Plan Name',NULL,NULL,'"Dental Insurance Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHLTJYELGEZ0','50','H','01','27',NULL,'Dental Group ID',NULL,NULL,'"Dental Group ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHLTJYELGEZ0','50','H','01','28',NULL,'Dental Plan Effective Date',NULL,NULL,'"Dental Plan Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHLTJYELGEZ0','50','H','01','29',NULL,'Dental Plan Termination Date',NULL,NULL,'"Dental Plan Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHLTJYELGEZ0','50','H','01','30',NULL,'Vision Insurance Plan Name',NULL,NULL,'"Vision Insurance Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHLTJYELGEZ0','50','H','01','31',NULL,'Vision Group ID',NULL,NULL,'"Vision Group ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHLTJYELGEZ0','50','H','01','32',NULL,'Vision Plan Effective Date',NULL,NULL,'"Vision Plan Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHLTJYELGEZ0','50','H','01','33',NULL,'Vision Plan Termination Date',NULL,NULL,'"Vision Plan Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHLTJYELGEZ0','50','H','01','34',NULL,'Basic Life Plan Name',NULL,NULL,'"Basic Life Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHLTJYELGEZ0','50','H','01','35',NULL,'Basic Life Policy Amount',NULL,NULL,'"Basic Life Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHLTJYELGEZ0','50','H','01','36',NULL,'Basic Life Effective Date',NULL,NULL,'"Basic Life Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EHLTJYELGEZ0','50','H','01','37',NULL,'Basic Life Termination Date',NULL,NULL,'"Basic Life Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EHLTJYELGEZ0','50','H','01','38',NULL,'Supplemental Life Plan Name',NULL,NULL,'"Supplemental Life Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EHLTJYELGEZ0','50','H','01','39',NULL,'Supplemental Life Policy Amount',NULL,NULL,'"Supplemental Life Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EHLTJYELGEZ0','50','H','01','40',NULL,'Supplemental Life Effective Date',NULL,NULL,'"Supplemental Life Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EHLTJYELGEZ0','50','H','01','41',NULL,'Supplemental Life Termination Date',NULL,NULL,'"Supplemental Life Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EHLTJYELGEZ0','50','H','01','42',NULL,'LTD Plan Name',NULL,NULL,'"LTD Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EHLTJYELGEZ0','50','H','01','43',NULL,'LTD Policy Amount',NULL,NULL,'"LTD Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EHLTJYELGEZ0','50','H','01','44',NULL,'LTD Effective Date',NULL,NULL,'"LTD Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EHLTJYELGEZ0','50','H','01','45',NULL,'LTD Termination Date',NULL,NULL,'"LTD Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EHLTJYELGEZ0','50','H','01','46',NULL,'STD Plan Name',NULL,NULL,'"STD Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EHLTJYELGEZ0','50','H','01','47',NULL,'STD Policy Amount',NULL,NULL,'"STD Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EHLTJYELGEZ0','50','H','01','48',NULL,'STD Effective Date',NULL,NULL,'"STD Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EHLTJYELGEZ0','50','H','01','49',NULL,'STD Termination Date',NULL,NULL,'"STD Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EHLTJYELGEZ0','50','H','01','50',NULL,'Healthcare FSA Plan Name',NULL,NULL,'"Healthcare FSA Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EHLTJYELGEZ0','50','H','01','51',NULL,'Healthcare FSA Goal Amount',NULL,NULL,'"Healthcare FSA Goal Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EHLTJYELGEZ0','50','H','01','52',NULL,'Healthcare FSA Effective Date',NULL,NULL,'"Healthcare FSA Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EHLTJYELGEZ0','50','H','01','53',NULL,'Healthcare FSA Termination Date',NULL,NULL,'"Healthcare FSA Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EHLTJYELGEZ0','50','H','01','54',NULL,'Dependent Care FSA Plan Name',NULL,NULL,'"Dependent Care FSA Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EHLTJYELGEZ0','50','H','01','55',NULL,'Dependent Care FSA Goal Amount',NULL,NULL,'"Dependent Care FSA Goal Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EHLTJYELGEZ0','50','H','01','56',NULL,'Dependent Care FSA Effective Date',NULL,NULL,'"Dependent Care FSA Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EHLTJYELGEZ0','50','H','01','57',NULL,'Dependent Care FSA Termination Date',NULL,NULL,'"Dependent Care FSA Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EHLTJYELGEZ0','50','H','01','58',NULL,'HSA Plan Name',NULL,NULL,'"HSA Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EHLTJYELGEZ0','50','H','01','59',NULL,'HSA Goal Amount',NULL,NULL,'"HSA Goal Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EHLTJYELGEZ0','50','H','01','60',NULL,'HSA Effective Date',NULL,NULL,'"HSA Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EHLTJYELGEZ0','50','H','01','61',NULL,'HSA Termination Date',NULL,NULL,'"HSA Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EHLTJYELGEZ0','50','H','01','62',NULL,'Accident Plan Name',NULL,NULL,'"Accident Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EHLTJYELGEZ0','50','H','01','63',NULL,'Accident Policy Amount',NULL,NULL,'"Accident Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EHLTJYELGEZ0','50','H','01','64',NULL,'Accident Effective Date',NULL,NULL,'"Accident Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EHLTJYELGEZ0','50','H','01','65',NULL,'Accident Termination Date',NULL,NULL,'"Accident Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EHLTJYELGEZ0','50','H','01','66',NULL,'Critical Illness Plan Name',NULL,NULL,'"Critical Illness Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EHLTJYELGEZ0','50','H','01','67',NULL,'Critical Illness Policy Amount',NULL,NULL,'"Critical Illness Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EHLTJYELGEZ0','50','H','01','68',NULL,'Critical Illness Policy Effective Date',NULL,NULL,'"Critical Illness Policy Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EHLTJYELGEZ0','50','H','01','69',NULL,'Critical Illness Termination Date',NULL,NULL,'"Critical Illness Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EHLTJYELGEZ0','50','H','01','70',NULL,'Hospital Indemnity Plan Name',NULL,NULL,'"Hospital Indemnity Plan Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EHLTJYELGEZ0','50','H','01','71',NULL,'Hospital Indemnity Policy Amount',NULL,NULL,'"Hospital Indemnity Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EHLTJYELGEZ0','50','H','01','72',NULL,'Hospital Indemnity Policy Effective Date',NULL,NULL,'"Hospital Indemnity Policy Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EHLTJYELGEZ0','50','H','01','73',NULL,'Hospital Indemnity Termination Date',NULL,NULL,'"Hospital Indemnity Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EHLTJYELGEZ0','50','H','01','74',NULL,'Custom Plan Name 1',NULL,NULL,'"Custom Plan Name 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EHLTJYELGEZ0','50','H','01','75',NULL,'Custom Plan Name 1 Policy Amount',NULL,NULL,'"Custom Plan Name 1 Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EHLTJYELGEZ0','50','H','01','76',NULL,'Custom Plan Name 1 Effective Date',NULL,NULL,'"Custom Plan Name 1 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EHLTJYELGEZ0','50','H','01','77',NULL,'Custom Plan Name 1 Termination Date',NULL,NULL,'"Custom Plan Name 1 Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EHLTJYELGEZ0','50','H','01','78',NULL,'Custom Plan Name 2',NULL,NULL,'"Custom Plan Name 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EHLTJYELGEZ0','50','H','01','79',NULL,'Custom Plan Name 2 Policy Amount',NULL,NULL,'"Custom Plan Name 2 Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EHLTJYELGEZ0','50','H','01','80',NULL,'Custom Plan Name 2 Effective Date',NULL,NULL,'"Custom Plan Name 2 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EHLTJYELGEZ0','50','H','01','81',NULL,'Custom Plan Name 2 Termination Date',NULL,NULL,'"Custom Plan Name 2 Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EHLTJYELGEZ0','50','H','01','82',NULL,'Custom Plan Name 3',NULL,NULL,'"Custom Plan Name 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EHLTJYELGEZ0','50','H','01','83',NULL,'Custom Plan Name 3 Policy Amount',NULL,NULL,'"Custom Plan Name 3 Policy Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EHLTJYELGEZ0','50','H','01','84',NULL,'Custom Plan Name 3 Effective Date',NULL,NULL,'"Custom Plan Name 3 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EHLTJYELGEZ0','50','H','01','85',NULL,'Custom Plan Name 3 Termination Date',NULL,NULL,'"Custom Plan Name 3 Termination Date"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHLTJYELGEZ0','50','D','10','1',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHLTJYELGEZ0','50','D','10','2',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHLTJYELGEZ0','50','D','10','3',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHLTJYELGEZ0','50','D','10','4',NULL,'Employment Termination Date',NULL,NULL,'"drvEmploymentTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHLTJYELGEZ0','50','D','10','5',NULL,'COBRA Start Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHLTJYELGEZ0','50','D','10','6',NULL,'COBRA Termination Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHLTJYELGEZ0','50','D','10','7',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHLTJYELGEZ0','50','D','10','8',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHLTJYELGEZ0','50','D','10','9',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHLTJYELGEZ0','50','D','10','10',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHLTJYELGEZ0','50','D','10','11',NULL,'Email',NULL,NULL,'"drvEmal"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHLTJYELGEZ0','50','D','10','12',NULL,'Mobile Number',NULL,NULL,'"drvMobileNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHLTJYELGEZ0','50','D','10','13',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHLTJYELGEZ0','50','D','10','14',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHLTJYELGEZ0','50','D','10','15',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHLTJYELGEZ0','50','D','10','16',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHLTJYELGEZ0','50','D','10','17',NULL,'City',NULL,NULL,'"drvAddressLineCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHLTJYELGEZ0','50','D','10','18',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHLTJYELGEZ0','50','D','10','19',NULL,'Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHLTJYELGEZ0','50','D','10','20',NULL,'Benefit Class',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHLTJYELGEZ0','50','D','10','21',NULL,'Division',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHLTJYELGEZ0','50','D','10','22',NULL,'Medical Insurance Plan Name',NULL,NULL,'"drvMedicalInsurPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHLTJYELGEZ0','50','D','10','23',NULL,'Medical Group ID',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHLTJYELGEZ0','50','D','10','24',NULL,'Medical Plan Effective Date',NULL,NULL,'"drvMedicalPlanEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHLTJYELGEZ0','50','D','10','25',NULL,'Medical Plan Termination Date',NULL,NULL,'"drvMedicalPlanTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHLTJYELGEZ0','50','D','10','26',NULL,'Dental Insurance Plan Name',NULL,NULL,'"drvDentalInsurancePlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHLTJYELGEZ0','50','D','10','27',NULL,'Dental Group ID',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHLTJYELGEZ0','50','D','10','28',NULL,'Dental Plan Effective Date',NULL,NULL,'"drvDentalPlanEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHLTJYELGEZ0','50','D','10','29',NULL,'Dental Plan Termination Date',NULL,NULL,'"drvDentalPlanTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHLTJYELGEZ0','50','D','10','30',NULL,'Vision Insurance Plan Name',NULL,NULL,'"drvVisionInsurancePlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHLTJYELGEZ0','50','D','10','31',NULL,'Vision Group ID',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHLTJYELGEZ0','50','D','10','32',NULL,'Vision Plan Effective Date',NULL,NULL,'"drvVisionPlanEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHLTJYELGEZ0','50','D','10','33',NULL,'Vision Plan Termination Date',NULL,NULL,'"drvVisionPlanTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHLTJYELGEZ0','50','D','10','34',NULL,'Basic Life Plan Name',NULL,NULL,'"drvBasicLifePlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHLTJYELGEZ0','50','D','10','35',NULL,'Basic Life Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHLTJYELGEZ0','50','D','10','36',NULL,'Basic Life Effective Date',NULL,NULL,'"drvBasicLifeEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EHLTJYELGEZ0','50','D','10','37',NULL,'Basic Life Termination Date',NULL,NULL,'"drvBasicLifeTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EHLTJYELGEZ0','50','D','10','38',NULL,'Supplemental Life Plan Name',NULL,NULL,'"drvSupplementalLifePlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EHLTJYELGEZ0','50','D','10','39',NULL,'Supplemental Life Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EHLTJYELGEZ0','50','D','10','40',NULL,'Supplemental Life Effective Date',NULL,NULL,'"drvSupplementalLifeEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EHLTJYELGEZ0','50','D','10','41',NULL,'Supplemental Life Termination Date',NULL,NULL,'"drvSupplementalLifeTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EHLTJYELGEZ0','50','D','10','42',NULL,'LTD Plan Name',NULL,NULL,'"drvLTDPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EHLTJYELGEZ0','50','D','10','43',NULL,'LTD Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EHLTJYELGEZ0','50','D','10','44',NULL,'LTD Effective Date',NULL,NULL,'"drvLTDEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EHLTJYELGEZ0','50','D','10','45',NULL,'LTD Termination Date',NULL,NULL,'"drvLTDTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EHLTJYELGEZ0','50','D','10','46',NULL,'STD Plan Name',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EHLTJYELGEZ0','50','D','10','47',NULL,'STD Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EHLTJYELGEZ0','50','D','10','48',NULL,'STD Effective Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EHLTJYELGEZ0','50','D','10','49',NULL,'STD Termination Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EHLTJYELGEZ0','50','D','10','50',NULL,'Healthcare FSA Plan Name',NULL,NULL,'"drvHealthcareFSAPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EHLTJYELGEZ0','50','D','10','51',NULL,'Healthcare FSA Goal Amount',NULL,NULL,'"drvHealthcareFSAGoalAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EHLTJYELGEZ0','50','D','10','52',NULL,'Healthcare FSA Effective Date',NULL,NULL,'"drvHealthcareFSAEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EHLTJYELGEZ0','50','D','10','53',NULL,'Healthcare FSA Termination Date',NULL,NULL,'"drvHealthcareTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EHLTJYELGEZ0','50','D','10','54',NULL,'Dependent Care FSA Plan Name',NULL,NULL,'"drvDependentCareFSAPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EHLTJYELGEZ0','50','D','10','55',NULL,'Dependent Care FSA Goal Amount',NULL,NULL,'"drvDependentCareFSAGoalAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EHLTJYELGEZ0','50','D','10','56',NULL,'Dependent Care FSA Effective Date',NULL,NULL,'"drvDependentCareFSAEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EHLTJYELGEZ0','50','D','10','57',NULL,'Dependent Care FSA Termination Date',NULL,NULL,'"drvDependentCareFSATermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EHLTJYELGEZ0','50','D','10','58',NULL,'HSA Plan Name',NULL,NULL,'"drvHSAPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EHLTJYELGEZ0','50','D','10','59',NULL,'HSA Goal Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EHLTJYELGEZ0','50','D','10','60',NULL,'HSA Effective Date',NULL,NULL,'"drvHSAEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EHLTJYELGEZ0','50','D','10','61',NULL,'HSA Termination Date',NULL,NULL,'"drvHSATerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EHLTJYELGEZ0','50','D','10','62',NULL,'Accident Plan Name',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EHLTJYELGEZ0','50','D','10','63',NULL,'Accident Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EHLTJYELGEZ0','50','D','10','64',NULL,'Accident Effective Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EHLTJYELGEZ0','50','D','10','65',NULL,'Accident Termination Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EHLTJYELGEZ0','50','D','10','66',NULL,'Critical Illness Plan Name',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EHLTJYELGEZ0','50','D','10','67',NULL,'Critical Illness Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EHLTJYELGEZ0','50','D','10','68',NULL,'Critical Illness Policy Effective Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EHLTJYELGEZ0','50','D','10','69',NULL,'Critical Illness Termination Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EHLTJYELGEZ0','50','D','10','70',NULL,'Hospital Indemnity Plan Name',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EHLTJYELGEZ0','50','D','10','71',NULL,'Hospital Indemnity Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EHLTJYELGEZ0','50','D','10','72',NULL,'Hospital Indemnity Policy Effective Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EHLTJYELGEZ0','50','D','10','73',NULL,'Hospital Indemnity Termination Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EHLTJYELGEZ0','50','D','10','74',NULL,'Custom Plan Name 1',NULL,NULL,'"drCustomPlanName1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EHLTJYELGEZ0','50','D','10','75',NULL,'Custom Plan Name 1 Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EHLTJYELGEZ0','50','D','10','76',NULL,'Custom Plan Name 1 Effective Date',NULL,NULL,'"drvCustomPlanName1EffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EHLTJYELGEZ0','50','D','10','77',NULL,'Custom Plan Name 1 Termination Date',NULL,NULL,'"drvCustomPlanName1TermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EHLTJYELGEZ0','50','D','10','78',NULL,'Custom Plan Name 2',NULL,NULL,'"drvCustomPlanName2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EHLTJYELGEZ0','50','D','10','79',NULL,'Custom Plan Name 2 Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EHLTJYELGEZ0','50','D','10','80',NULL,'Custom Plan Name 2 Effective Date',NULL,NULL,'"drvCustomPlanName2EffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EHLTJYELGEZ0','50','D','10','81',NULL,'Custom Plan Name 2 Termination Date',NULL,NULL,'"drvCustomPlanName2TermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EHLTJYELGEZ0','50','D','10','82',NULL,'Custom Plan Name 3',NULL,NULL,'"drvCustomPlanName3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EHLTJYELGEZ0','50','D','10','83',NULL,'Custom Plan Name 3 Policy Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EHLTJYELGEZ0','50','D','10','84',NULL,'Custom Plan Name 3 Effective Date',NULL,NULL,'"drvCustomPlanName3EffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EHLTJYELGEZ0','50','D','10','85',NULL,'Custom Plan Name 3 Termination Date',NULL,NULL,'"drvCustomPlanName3TermDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EHLTJYELGE_20211111.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202110289','EMPEXPORT','OEACTIVE',NULL,'EHLTJYELGE',NULL,NULL,NULL,'202110289','Oct 20 2021  8:49AM','Oct 20 2021  8:49AM','202110011',NULL,'','','202110011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202110289','EMPEXPORT','OEPASSIVE',NULL,'EHLTJYELGE',NULL,NULL,NULL,'202110289','Oct 20 2021  8:49AM','Oct 20 2021  8:49AM','202110011',NULL,'','','202110011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Health Joy Eligibiity Export','202110289','EMPEXPORT','ONDEM_XOE',NULL,'EHLTJYELGE',NULL,NULL,NULL,'202110289','Oct 20 2021  8:49AM','Oct 20 2021  8:49AM','202110011',NULL,'','','202110011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Health Joy Eligibiity Ex-Sched','202110289','EMPEXPORT','SCH_EHLTJY',NULL,'EHLTJYELGE',NULL,NULL,NULL,'202110289','Oct 20 2021  8:49AM','Oct 20 2021  8:49AM','202110011',NULL,'','','202110011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Health Joy Eligibiity Ex-Test','202110289','EMPEXPORT','TEST_XOE','Oct 28 2021  6:32PM','EHLTJYELGE',NULL,NULL,NULL,'202110289','Oct  8 2021 12:00AM','Oct  1 2021 12:00AM','202110011','513','','','202110011',dbo.fn_GetTimedKey(),NULL,'us3cPeUNI1094',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTJYELGE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTJYELGE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTJYELGE','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTJYELGE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLTJYELGE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHLTJYELGE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHLTJYELGE','D10','dbo.U_EHLTJYELGE_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EHLTJYELGE
-----------

IF OBJECT_ID('U_dsi_BDM_EHLTJYELGE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EHLTJYELGE] (
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
-- Create table U_EHLTJYELGE_DedList
-----------

IF OBJECT_ID('U_EHLTJYELGE_DedList') IS NULL
CREATE TABLE [dbo].[U_EHLTJYELGE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EHLTJYELGE_drvTbl
-----------

IF OBJECT_ID('U_EHLTJYELGE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHLTJYELGE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(15) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvStartDate] datetime NULL,
    [drvEmploymentStatus] varchar(1) NOT NULL,
    [drvEmploymentTerminationDate] datetime NULL,
    [drvNameFirst] varchar(102) NOT NULL,
    [drvNameLast] varchar(102) NOT NULL,
    [drvSSN] nvarchar(4000) NULL,
    [drvRelationship] varchar(8) NULL,
    [drvEmal] varchar(50) NULL,
    [drvMobileNumber] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvAddressLine1] varchar(257) NOT NULL,
    [drvAddressLine2] varchar(257) NOT NULL,
    [drvAddressLineCity] varchar(257) NOT NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(5) NULL,
    [drvMedicalInsurPlanName] varchar(23) NULL,
    [drvMedicalPlanEffectiveDate] datetime NULL,
    [drvMedicalPlanTerminationDate] datetime NULL,
    [drvDentalInsurancePlan] varchar(6) NULL,
    [drvDentalPlanEffectiveDate] datetime NULL,
    [drvDentalPlanTerminationDate] datetime NULL,
    [drvVisionInsurancePlanName] varchar(6) NULL,
    [drvVisionPlanEffectiveDate] datetime NULL,
    [drvVisionPlanTerminationDate] datetime NULL,
    [drvBasicLifePlanName] varchar(15) NULL,
    [drvBasicLifeEffectiveDate] datetime NULL,
    [drvBasicLifeTerminationDate] datetime NULL,
    [drvSupplementalLifePlanName] varchar(17) NULL,
    [drvSupplementalLifeEffDate] datetime NULL,
    [drvSupplementalLifeTermDate] datetime NULL,
    [drvLTDPlanName] varchar(3) NULL,
    [drvLTDEffectiveDate] datetime NULL,
    [drvLTDTerminationDate] datetime NULL,
    [drvHealthcareFSAPlanName] varchar(11) NULL,
    [drvHealthcareFSAGoalAmount] nvarchar(4000) NULL,
    [drvHealthcareFSAEffectiveDate] datetime NULL,
    [drvHealthcareTerminationDate] datetime NULL,
    [drvDependentCareFSAPlanName] varchar(18) NULL,
    [drvDependentCareFSAGoalAmount] nvarchar(4000) NULL,
    [drvDependentCareFSAEffDate] datetime NULL,
    [drvDependentCareFSATermDate] datetime NULL,
    [drvHSAPlanName] varchar(3) NULL,
    [drvHSAEffectiveDate] datetime NULL,
    [drvHSATerminationDate] datetime NULL,
    [drCustomPlanName1] varchar(20) NULL,
    [drvCustomPlanName1EffDate] datetime NULL,
    [drvCustomPlanName1TermDate] datetime NULL,
    [drvCustomPlanName2] varchar(10) NULL,
    [drvCustomPlanName2EffDate] datetime NULL,
    [drvCustomPlanName2TermDate] datetime NULL,
    [drvCustomPlanName3] varchar(17) NULL,
    [drvCustomPlanName3EffDate] datetime NULL,
    [drvCustomPlanName3TermDate] datetime NULL
);

-----------
-- Create table U_EHLTJYELGE_EEList
-----------

IF OBJECT_ID('U_EHLTJYELGE_EEList') IS NULL
CREATE TABLE [dbo].[U_EHLTJYELGE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EHLTJYELGE_File
-----------

IF OBJECT_ID('U_EHLTJYELGE_File') IS NULL
CREATE TABLE [dbo].[U_EHLTJYELGE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EHLTJYELGE_PDedHist
-----------

IF OBJECT_ID('U_EHLTJYELGE_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EHLTJYELGE_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);

-----------
-- Create table U_EHLTJYELGE_PEarHist
-----------

IF OBJECT_ID('U_EHLTJYELGE_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EHLTJYELGE_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHLTJYELGE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: University of Nebraska

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 10/20/2021
Service Request Number: TekP-2021-09-22-0002

Purpose: Health Joy Eligibiity Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHLTJYELGE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHLTJYELGE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHLTJYELGE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHLTJYELGE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHLTJYELGE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTJYELGE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTJYELGE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTJYELGE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTJYELGE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLTJYELGE', 'SCH_EHLTJY';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHLTJYELGE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EHLTJYELGE', @AllObjects = 'Y', @IsWeb = 'Y'

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EHLTJYELGE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EHLTJYELGE';

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
    DELETE FROM dbo.U_EHLTJYELGE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHLTJYELGE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'MDB50,MDB75,MEDB1,MDH50,MDH75,MDHD1';
    SET @DedList = 'MDB50,MDB75,MEDB1,MDH50,MDH75,MDHD1,DEN1,DEN50,DEN75,VIS,GLIFE,LIFEC,LLIFEE,LIFES,LTD,FSA,FSAL,FSADC,HSAF,HSACF,HSACI,HSAI,403CF,403GF,403P3,403P5,403PS,403RP,ADD,ADDCH,ADDE,ADDSP'

    IF OBJECT_ID('U_EHLTJYELGE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHLTJYELGE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHLTJYELGE_DedList
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
    -- Build Working Tables
    --==========================================

/*    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EHLTJYELGE_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHLTJYELGE_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EHLTJYELGE_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EHLTJYELGE_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EHLTJYELGE_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHLTJYELGE_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EHLTJYELGE_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;*/
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHLTJYELGE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHLTJYELGE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHLTJYELGE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' ' +    CASE WHEN BdmRecType = 'EMP' THEN ' 1' ELSE CASE WHEN ConRelationship IN ('SPS','DP') THEN ' 2' ELSE ' 3' END END
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvStartDate = EecDateOfLastHire
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus = 'T' THEN 'T' ELSE 'A' END
        ,drvEmploymentTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvNameFirst = '"' + ISNULL(CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END, '') + '"'
        ,drvNameLast = '"' + ISNULL(CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END, '') + '"'
        ,drvSSN =    FORMAT(CAST(CASE WHEN BdmRecType = 'EMP' THEN EepSSN 
                        ELSE CASE WHEN NOT (ConSSN IN ('000000000','999999999', '123456789') OR RIGHT(ConSSN, 3) IN ('999','998')) THEN ConSSN END
                    END AS INT), '000-00-0000')
        ,drvRelationship =    CASE WHEN BdmRecType = 'EMP' THEN 'Employee'
                                WHEN ConRelationship IN ('SPS','DP') THEN 'Spouse'
                                WHEN ConRelationship IN ('CHL','DPC','STC') THEN 'Child'
                            END
        ,drvEmal = EepAddressEmail
        ,drvMobileNumber = EfoPhoneNumber
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvGender =    CASE WHEN BdmRecType = 'EMP' THEN 
                            CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'X' END
                        ELSE 
                            CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'X' END
                        END
        ,drvAddressLine1 = '"' + ISNULL(EepAddressLine1, '') + '"'
        ,drvAddressLine2 = '"' + ISNULL(RTRIM(EepAddressLine2), '') + '"'
        ,drvAddressLineCity = '"' + ISNULL(EepAddressCity, '') + '"'
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = LEFT(EepAddressZipCode, 5)
        ,drvMedicalInsurPlanName =    CASE WHEN TraditonalMedical_DedCode IS NOT NULL THEN 'Traditional Medical'
                                        WHEN HighDeductableMedical_DedCode IS NOT NULL THEN 'High Deductible Medical'
                                    END
        ,drvMedicalPlanEffectiveDate =    CASE WHEN TraditonalMedical_DedCode IS NOT NULL THEN TraditonalMedical_BenStartDate
                                            WHEN HighDeductableMedical_DedCode IS NOT NULL THEN HighDeductableMedical_BenStartDate
                                        END
        ,drvMedicalPlanTerminationDate =    CASE WHEN TraditonalMedical_DedCode IS NOT NULL THEN TraditonalMedical_BenStopDate
                                                WHEN HighDeductableMedical_DedCode IS NOT NULL THEN HighDeductableMedical_BenStopDate
                                            END
        ,drvDentalInsurancePlan = CASE WHEN DEN_DedCode IS NOT NULL THEN 'Dental' END
        ,drvDentalPlanEffectiveDate = CASE WHEN DEN_DedCode IS NOT NULL THEN DEN_BenStartDate END
        ,drvDentalPlanTerminationDate = CASE WHEN DEN_DedCode IS NOT NULL THEN DEN_BenStopDate END
        ,drvVisionInsurancePlanName = CASE WHEN VIS_DedCode IS NOT NULL THEN 'Vision' END
        ,drvVisionPlanEffectiveDate = CASE WHEN VIS_DedCode IS NOT NULL THEN VIS_BenStartDate END
        ,drvVisionPlanTerminationDate = CASE WHEN VIS_DedCode IS NOT NULL THEN VIS_BenStopDate END
        ,drvBasicLifePlanName = CASE WHEN GLIFE_DedCode IS NOT NULL AND BdmRecType = 'EMP' THEN 'Group Term Life' END
        ,drvBasicLifeEffectiveDate = CASE WHEN GLIFE_DedCode IS NOT NULL AND BdmRecType = 'EMP' THEN GLIFE_BenStartDate END
        ,drvBasicLifeTerminationDate = CASE WHEN GLIFE_DedCode IS NOT NULL AND BdmRecType = 'EMP' THEN GLIFE_BenStopDate END
        ,drvSupplementalLifePlanName = CASE WHEN LIFEX_DedCode IS NOT NULL THEN 'Supplemental Life' END
        ,drvSupplementalLifeEffDate = CASE WHEN LIFEX_DedCode IS NOT NULL THEN LIFEX_BenStartDate END
        ,drvSupplementalLifeTermDate = CASE WHEN LIFEX_DedCode IS NOT NULL THEN LIFEX_BenStopDate END
        ,drvLTDPlanName = CASE WHEN LTD_DedCode IS NOT NULL AND BdmRecType = 'EMP' THEN 'LTD' END
        ,drvLTDEffectiveDate = CASE WHEN LTD_DedCode IS NOT NULL AND BdmRecType = 'EMP' THEN LTD_BenStartDate END
        ,drvLTDTerminationDate = CASE WHEN LTD_DedCode IS NOT NULL AND BdmRecType = 'EMP' THEN LTD_BenStopDate END
        ,drvHealthcareFSAPlanName = CASE WHEN FSAX_DedCode IS NOT NULL THEN 'FSA Medical' END
        ,drvHealthcareFSAGoalAmount = CASE WHEN FSAX_DedCode IS NOT NULL THEN FORMAT(FSAX_GoalAmt, '#0.00') END
        ,drvHealthcareFSAEffectiveDate = CASE WHEN FSAX_DedCode IS NOT NULL THEN FSAX_BenStartDate END
        ,drvHealthcareTerminationDate = CASE WHEN FSAX_DedCode IS NOT NULL THEN FSAX_BenStopDate END
        ,drvDependentCareFSAPlanName = CASE WHEN FSADC_DedCode IS NOT NULL THEN 'FSA Dependent Care' END
        ,drvDependentCareFSAGoalAmount = CASE WHEN FSADC_DedCode IS NOT NULL THEN FORMAT(FSADC_GoalAmt, '#0.00') END
        ,drvDependentCareFSAEffDate = CASE WHEN FSADC_DedCode IS NOT NULL THEN FSADC_BenStartDate END
        ,drvDependentCareFSATermDate = CASE WHEN FSADC_DedCode IS NOT NULL THEN FSADC_BenStopDate END
        ,drvHSAPlanName = CASE WHEN HSAX_DedCode IS NOT NULL THEN 'HSA' END
        ,drvHSAEffectiveDate = CASE WHEN HSAX_DedCode IS NOT NULL THEN HSAX_BenStartDate END
        ,drvHSATerminationDate = CASE WHEN HSAX_DedCode IS NOT NULL THEN HSAX_BenStopDate END
        ,drCustomPlanName1 = CASE WHEN X403_DedCode IS NOT NULL THEN '403b Retirement Plan' END
        ,drvCustomPlanName1EffDate = CASE WHEN X403_DedCode IS NOT NULL THEN X403_BenStartDate END
        ,drvCustomPlanName1TermDate = CASE WHEN X403_DedCode IS NOT NULL THEN X403_BenStopDate END
        ,drvCustomPlanName2 = CASE WHEN ADD_DedCode IS NOT NULL THEN 'Basic AD&D' END
        ,drvCustomPlanName2EffDate = CASE WHEN ADD_DedCode IS NOT NULL THEN ADD_BenStartDate END
        ,drvCustomPlanName2TermDate = CASE WHEN ADD_DedCode IS NOT NULL THEN ADD_BenStopDate END
        ,drvCustomPlanName3 = CASE WHEN ADDX_DedCode IS NOT NULL THEN 'Supplemental AD&D' END
        ,drvCustomPlanName3EffDate = CASE WHEN ADDX_DedCode IS NOT NULL THEN  ADDX_BenStartDate END
        ,drvCustomPlanName3TermDate = CASE WHEN ADDX_DedCode IS NOT NULL THEN  ADDX_BenStopDate END
    INTO dbo.U_EHLTJYELGE_drvTbl
    FROM dbo.U_EHLTJYELGE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    /*JOIN dbo.U_dsi_BDM_EHLTJYELGE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID*/
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup    
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY AuditKey DESC) AS RN
                        FROM dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL'
                            AND EfoPhoneNumber <> '0000000000'
                        ) AS CP
                WHERE RN = 1
            ) AS Cel
        ON EfoEEID = xEEID
    /*JOIN (
            SELECT BdmEEID AS TotEeid , BdmCOID AS TotCOID
                ,MAX(CASE WHEN BdmDedCode IN ('MDB50','MDB75','MEDB1') THEN BdmDedCode END) AS TraditonalMedical_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('MDH50','MDH75','MDHD1') THEN BdmDedCode END) AS HighDeductableMedical_DedCode

                ,MAX(CASE WHEN BdmDedCode IN ('MDB50','MDB75','MEDB1') THEN BdmBenStartDate END) AS TraditonalMedical_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('MDH50','MDH75','MDHD1') THEN BdmBenStartDate END) AS HighDeductableMedical_BenStartDate
                
                ,MAX(CASE WHEN BdmDedCode IN ('MDB50','MDB75','MEDB1') THEN BdmBenStopDate END) AS TraditonalMedical_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('MDH50','MDH75','MDHD1') THEN BdmBenStopDate END) AS HighDeductableMedical_BenStopDate
            FROM dbo.U_dsi_BDM_EHLTJYELGE WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID) AS Bdm_Tot
        ON Bdm_Tot.TotEEID = xEEID
        AND Bdm_Tot.TotCoid = xCOID*/
    JOIN (
                SELECT BdmEEID, BdmCOID, BdmRecType, BdmDepRecID
                ,MAX(CASE WHEN BdmDedCode IN ('MDB50','MDB75','MEDB1') THEN BdmDedCode END) AS TraditonalMedical_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('MDH50','MDH75','MDHD1') THEN BdmDedCode END) AS HighDeductableMedical_DedCode

                ,MAX(CASE WHEN BdmDedCode IN ('MDB50','MDB75','MEDB1') THEN BdmBenStartDate END) AS TraditonalMedical_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('MDH50','MDH75','MDHD1') THEN BdmBenStartDate END) AS HighDeductableMedical_BenStartDate
                
                ,MAX(CASE WHEN BdmDedCode IN ('MDB50','MDB75','MEDB1') THEN BdmBenStopDate END) AS TraditonalMedical_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('MDH50','MDH75','MDHD1') THEN BdmBenStopDate END) AS HighDeductableMedical_BenStopDate

                    ,MAX(CASE WHEN BdmDedCode IN ('DEN1','DEN50','DEN75') THEN BdmDedCode END) AS DEN_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('DEN1','DEN50','DEN75') THEN BdmBenStartDate END) AS DEN_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('DEN1','DEN50','DEN75') THEN BdmBenStopDate END) AS DEN_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('VIS') THEN BdmDedCode END) AS VIS_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('VIS') THEN BdmBenStartDate END) AS VIS_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('VIS') THEN BdmBenStopDate END) AS VIS_BenStopDate                    
                    ,MAX(CASE WHEN BdmDedCode IN ('GLIFE') THEN BdmDedCode END) AS     GLIFE_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('LIFEC','LLIFEE','LIFES') THEN BdmDedCode END) AS     LIFEX_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('LTD') THEN BdmDedCode END) AS     LTD_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('FSA','FSAL') THEN BdmDedCode END) AS     FSAX_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('FSADC') THEN BdmDedCode END) AS     FSADC_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('HSAF','HSACF','HSACI','HSAI') THEN BdmDedCode END) AS     HSAX_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('403CF','403GF','403P3','403P5','403PS','403RP') THEN BdmDedCode END) AS     X403_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('ADD') THEN BdmDedCode END) AS     ADD_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('ADDCH','ADDE','ADDSP') THEN BdmDedCode END) AS     ADDX_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('GLIFE') THEN BdmBenStartDate END) AS     GLIFE_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('LIFEC','LLIFEE','LIFES') THEN BdmBenStartDate END) AS     LIFEX_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('LTD') THEN BdmBenStartDate END) AS     LTD_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('FSA','FSAL') THEN BdmBenStartDate END) AS     FSAX_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('FSADC') THEN BdmBenStartDate END) AS     FSADC_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('HSAF','HSACF','HSACI','HSAI') THEN BdmBenStartDate END) AS     HSAX_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('403CF','403GF','403P3','403P5','403PS','403RP') THEN BdmBenStartDate END) AS     X403_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('ADD') THEN BdmBenStartDate END) AS     ADD_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('ADDCH','ADDE','ADDSP') THEN BdmBenStartDate END) AS     ADDX_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('GLIFE') THEN BdmBenStopDate END) AS     GLIFE_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('LIFEC','LLIFEE','LIFES') THEN BdmBenStopDate END) AS     LIFEX_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('LTD') THEN BdmBenStopDate END) AS     LTD_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('FSA','FSAL') THEN BdmBenStopDate END) AS     FSAX_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('FSADC') THEN BdmBenStopDate END) AS     FSADC_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('HSAF','HSACF','HSACI','HSAI') THEN BdmBenStopDate END) AS     HSAX_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('403CF','403GF','403P3','403P5','403PS','403RP') THEN BdmBenStopDate END) AS     X403_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('ADD') THEN BdmBenStopDate END) AS     ADD_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('ADDCH','ADDE','ADDSP') THEN BdmBenStopDate END) AS     ADDX_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('FSA','FSAL') THEN BdmEEGoalAmt END) AS     FSAX_GoalAmt
                    ,MAX(CASE WHEN BdmDedCode IN ('FSADC') THEN BdmEEGoalAmt END) AS     FSADC_GoalAmt
                --FROM EmpDed WITH (NOLOCK)
                FROM dbo.U_dsi_BDM_EHLTJYELGE WITH (NOLOCK)
                --WHERE BdmDedCode IN ('DEN1','DEN50','DEN75','VIS','GLIFE','LIFEC','LLIFEE','LIFES','LTD','FSA','FSAL','FSADC','HSAF','HSACF','HSACI','HSAI','403CF','403GF','403P3','403P5','403PS','403RP','ADD','ADDCH','ADDE','ADDSP')
                WHERE BdmDedCode IN ('MDB50','MDB75','MEDB1','MDH50','MDH75','MDHD1','DEN1','DEN50','DEN75','VIS','GLIFE','LIFEC','LLIFEE','LIFES','LTD','FSA','FSAL','FSADC','HSAF','HSACF','HSACI','HSAI','403CF','403GF','403P3','403P5','403PS','403RP','ADD','ADDCH','ADDE','ADDSP')
                    --AND BdmBenStatus = 'A'
                GROUP BY  BdmEEID, BdmCOID, BdmRecType, BdmDepRecID ) AS Eed
        ON BdmEEID = xEEID 
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
        --AND ConSystemID = EedDepRecID
    WHERE (PgrPayGroup = 'MO'
        AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate)))
--        AND xEEID = 'CZGPFJ000040'
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
ALTER VIEW dbo.dsi_vwEHLTJYELGE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHLTJYELGE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHLTJYELGE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202110011'
       ,expStartPerControl     = '202110011'
       ,expLastEndPerControl   = '202110289'
       ,expEndPerControl       = '202110289'
WHERE expFormatCode = 'EHLTJYELGE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHLTJYELGE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHLTJYELGE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EHLTJYELGE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EHLTJYELGE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EHLTJYELGE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHLTJYELGE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EHLTJYELGE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHLTJYELGE', 'UseFileName', 'V', 'Y'


-- End ripout