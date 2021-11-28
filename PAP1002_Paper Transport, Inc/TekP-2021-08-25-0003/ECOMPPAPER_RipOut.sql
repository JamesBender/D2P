/**********************************************************************************

ECOMPPAPER: Compsych Eligibility Export

FormatCode:     ECOMPPAPER
Project:        Compsych Eligibility Export
Client ID:      PAP1002
Date/time:      2021-11-09 19:21:26.400
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP4DB02
Database:       ULTIPRO_WPPTRAN
Web Filename:   PAP1002_Z36PB_EEHISTORY_ECOMPPAPER_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECOMPPAPER_SavePath') IS NOT NULL DROP TABLE dbo.U_ECOMPPAPER_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECOMPPAPER'


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
WHERE FormatCode = 'ECOMPPAPER'
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
WHERE ExpFormatCode = 'ECOMPPAPER'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECOMPPAPER')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECOMPPAPER'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECOMPPAPER'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECOMPPAPER'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECOMPPAPER'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECOMPPAPER'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECOMPPAPER'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECOMPPAPER'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECOMPPAPER'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECOMPPAPER'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECOMPPAPER_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECOMPPAPER_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECOMPPAPER') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOMPPAPER];
GO
IF OBJECT_ID('U_ECOMPPAPER_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECOMPPAPER_PEarHist];
GO
IF OBJECT_ID('U_ECOMPPAPER_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECOMPPAPER_PDedHist];
GO
IF OBJECT_ID('U_ECOMPPAPER_File') IS NOT NULL DROP TABLE [dbo].[U_ECOMPPAPER_File];
GO
IF OBJECT_ID('U_ECOMPPAPER_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECOMPPAPER_EEList];
GO
IF OBJECT_ID('U_ECOMPPAPER_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECOMPPAPER_drvTbl];
GO
IF OBJECT_ID('U_ECOMPPAPER_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECOMPPAPER_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECOMPPAPER') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECOMPPAPER];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECOMPPAPER','Compsych Eligibility Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','ECOMPPAPERZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECOMPPAPERZ0','50','H','01','1',NULL,'Account Number',NULL,NULL,'"Account Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECOMPPAPERZ0','50','H','01','2',NULL,'Account Name',NULL,NULL,'"Account Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECOMPPAPERZ0','50','H','01','3',NULL,'Employee ID #',NULL,NULL,'"Employee ID #"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECOMPPAPERZ0','50','H','01','4',NULL,'Employee SSN#',NULL,NULL,'"Employee SSN#"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECOMPPAPERZ0','50','H','01','5',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECOMPPAPERZ0','50','H','01','6',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECOMPPAPERZ0','50','H','01','7',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECOMPPAPERZ0','50','H','01','8',NULL,'Home Address Line #1',NULL,NULL,'"Home Address Line #1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECOMPPAPERZ0','50','H','01','9',NULL,'Home Address Line #2',NULL,NULL,'"Home Address Line #2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECOMPPAPERZ0','50','H','01','10',NULL,'Home City',NULL,NULL,'"Home City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECOMPPAPERZ0','50','H','01','11',NULL,'Home State / Province',NULL,NULL,'"Home State / Province"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECOMPPAPERZ0','50','H','01','12',NULL,'Home Zip / Postal Code',NULL,NULL,'"Home Zip / Postal Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECOMPPAPERZ0','50','H','01','13',NULL,'Home Country',NULL,NULL,'"Home Country"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECOMPPAPERZ0','50','H','01','14',NULL,'Home (or Primary) Phone #',NULL,NULL,'"Home (or Primary) Phone #"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECOMPPAPERZ0','50','H','01','15',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECOMPPAPERZ0','50','H','01','16',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECOMPPAPERZ0','50','H','01','17',NULL,'Primary Language',NULL,NULL,'"Primary Language"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECOMPPAPERZ0','50','H','01','18',NULL,'Work Address ID',NULL,NULL,'"Work Address ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECOMPPAPERZ0','50','H','01','19',NULL,'Work Address Line #1',NULL,NULL,'"Work Address Line #1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECOMPPAPERZ0','50','H','01','20',NULL,'Work Address Line #2',NULL,NULL,'"Work Address Line #2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECOMPPAPERZ0','50','H','01','21',NULL,'Work City',NULL,NULL,'"Work City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECOMPPAPERZ0','50','H','01','22',NULL,'Work State / Providence',NULL,NULL,'"Work State / Providence"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECOMPPAPERZ0','50','H','01','23',NULL,'Work Zip',NULL,NULL,'"Work Zip"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECOMPPAPERZ0','50','H','01','24',NULL,'Work Country',NULL,NULL,'"Work Country"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECOMPPAPERZ0','50','H','01','25',NULL,'Work Phone #',NULL,NULL,'"Work Phone #"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECOMPPAPERZ0','50','H','01','26',NULL,'Work Phone Extension',NULL,NULL,'"Work Phone Extension"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECOMPPAPERZ0','50','H','01','27',NULL,'Business Unit',NULL,NULL,'"Business Unit"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECOMPPAPERZ0','50','H','01','28',NULL,'Organization',NULL,NULL,'"Organization"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECOMPPAPERZ0','50','H','01','29',NULL,'Employee Group #1',NULL,NULL,'"Employee Group #1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECOMPPAPERZ0','50','H','01','30',NULL,'Employee Group #2',NULL,NULL,'"Employee Group #2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECOMPPAPERZ0','50','H','01','31',NULL,'Employee Group #3',NULL,NULL,'"Employee Group #3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECOMPPAPERZ0','50','H','01','32',NULL,'Employee Group #4',NULL,NULL,'"Employee Group #4"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECOMPPAPERZ0','50','H','01','33',NULL,'Employee Group #5',NULL,NULL,'"Employee Group #5"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECOMPPAPERZ0','50','H','01','34',NULL,'Employee Group #6',NULL,NULL,'"Employee Group #6"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECOMPPAPERZ0','50','H','01','35',NULL,'Employee Group #7',NULL,NULL,'"Employee Group #7"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECOMPPAPERZ0','50','H','01','36',NULL,'Employee Group #8',NULL,NULL,'"Employee Group #8"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECOMPPAPERZ0','50','H','01','37',NULL,'Full Time / Part Time Status',NULL,NULL,'"Full Time / Part Time Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECOMPPAPERZ0','50','H','01','38',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECOMPPAPERZ0','50','H','01','39',NULL,'Adjusted Employment Date',NULL,NULL,'"Adjusted Employment Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECOMPPAPERZ0','50','H','01','40',NULL,'Anniversary Date',NULL,NULL,'"Anniversary Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECOMPPAPERZ0','50','H','01','41',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECOMPPAPERZ0','50','H','01','42',NULL,'Hours Worked in the Previous 12 Months',NULL,NULL,'"Hours Worked in the Previous 12 Months"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECOMPPAPERZ0','50','H','01','43',NULL,'Key Employee',NULL,NULL,'"Key Employee"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECOMPPAPERZ0','50','H','01','44',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECOMPPAPERZ0','50','H','01','45',NULL,'Work E-mail Address',NULL,NULL,'"Work E-mail Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECOMPPAPERZ0','50','H','01','46',NULL,'Scheduled Hours per Week',NULL,NULL,'"Scheduled Hours per Week"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECOMPPAPERZ0','50','H','01','47',NULL,'Scheduled # of Days per Week',NULL,NULL,'"Scheduled # of Days per Week"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECOMPPAPERZ0','50','H','01','48',NULL,'Additional Letter Recipient E-mail',NULL,NULL,'"Additional Letter Recipient E-mail"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECOMPPAPERZ0','50','H','01','49',NULL,'Spouse Employed',NULL,NULL,'"Spouse Employed"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECOMPPAPERZ0','50','H','01','50',NULL,'Spouse Employee ID',NULL,NULL,'"Spouse Employee ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECOMPPAPERZ0','51','H','01','51',NULL,'Primary Contact ID #',NULL,NULL,'"Primary Contact ID #"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECOMPPAPERZ0','52','H','01','52',NULL,'STD Earnings',NULL,NULL,'"STD Earnings"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECOMPPAPERZ0','53','H','01','53',NULL,'STD Eligibility Date',NULL,NULL,'"STD Eligibility Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECOMPPAPERZ0','54','H','01','54',NULL,'LTD Eligibility Date',NULL,NULL,'"LTD Eligibility Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECOMPPAPERZ0','54','H','01','55',NULL,'Employer Contact 2 IDS',NULL,NULL,'"Employer Contact 2 IDS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECOMPPAPERZ0','54','H','01','56',NULL,'Employer Contact 3 IDS',NULL,NULL,'"Employer Contact 3 IDS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ECOMPPAPERZ0','54','H','01','57',NULL,'Employer Contact 4 IDS',NULL,NULL,'"Employer Contact 4 IDS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ECOMPPAPERZ0','54','H','01','58',NULL,'Employer Contact 5 IDS',NULL,NULL,'"Employer Contact 5 IDS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ECOMPPAPERZ0','54','H','01','59',NULL,'Employer Contact 6 IDS',NULL,NULL,'"Employer Contact 6 IDS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ECOMPPAPERZ0','54','H','01','60',NULL,'Employer Contact 7 IDS',NULL,NULL,'"Employer Contact 7 IDS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ECOMPPAPERZ0','54','H','01','61',NULL,'Employer Contact 8 IDS',NULL,NULL,'"Employer Contact 8 IDS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ECOMPPAPERZ0','54','H','01','62',NULL,'Employer Contact 9 IDS',NULL,NULL,'"Employer Contact 9 IDS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ECOMPPAPERZ0','54','H','01','63',NULL,'Employer Contact 10 IDS',NULL,NULL,'"Employer Contact 10 IDS"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECOMPPAPERZ0','54','D','10','1',NULL,'Account Number',NULL,NULL,'"drvAccNum"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECOMPPAPERZ0','54','D','10','2',NULL,'Account Name',NULL,NULL,'"drvAccName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECOMPPAPERZ0','54','D','10','3',NULL,'Employee ID #',NULL,NULL,'"drvEmpId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECOMPPAPERZ0','54','D','10','4',NULL,'Employee SSN#',NULL,NULL,'"drvEmpSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECOMPPAPERZ0','54','D','10','5',NULL,'First Name',NULL,NULL,'"drvFName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECOMPPAPERZ0','54','D','10','6',NULL,'Middle Initial',NULL,NULL,'"drvMI"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECOMPPAPERZ0','54','D','10','7',NULL,'Last Name',NULL,NULL,'"drvLName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECOMPPAPERZ0','54','D','10','8',NULL,'Home Address Line #1',NULL,NULL,'"drvHomeAdd1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECOMPPAPERZ0','54','D','10','9',NULL,'Home Address Line #2',NULL,NULL,'"drvHomeAdd2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECOMPPAPERZ0','54','D','10','10',NULL,'Home City',NULL,NULL,'"drvHomeCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECOMPPAPERZ0','54','D','10','11',NULL,'Home State / Province',NULL,NULL,'"drvHomeState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECOMPPAPERZ0','54','D','10','12',NULL,'Home Zip / Postal Code',NULL,NULL,'"drvHomeZip"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECOMPPAPERZ0','54','D','10','13',NULL,'Home Country',NULL,NULL,'"drvHomeCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECOMPPAPERZ0','54','D','10','14',NULL,'Home (or Primary) Phone #',NULL,NULL,'"drvHomePh"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECOMPPAPERZ0','54','D','10','15',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECOMPPAPERZ0','54','D','10','16',NULL,'Date of Birth',NULL,NULL,'"drvDOB"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECOMPPAPERZ0','54','D','10','17',NULL,'Primary Language',NULL,NULL,'"drvPrimaryLang"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECOMPPAPERZ0','54','D','10','18',NULL,'Work Address ID',NULL,NULL,'"drvWorkAddId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECOMPPAPERZ0','54','D','10','19',NULL,'Work Address Line #1',NULL,NULL,'"drvWorkAddLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECOMPPAPERZ0','54','D','10','20',NULL,'Work Address Line #2',NULL,NULL,'"drvWorkAddLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECOMPPAPERZ0','54','D','10','21',NULL,'Work City',NULL,NULL,'"drvWorkCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECOMPPAPERZ0','54','D','10','22',NULL,'Work State / Providence',NULL,NULL,'"drvWorkState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECOMPPAPERZ0','54','D','10','23',NULL,'Work Zip',NULL,NULL,'"drvWorkZip"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECOMPPAPERZ0','54','D','10','24',NULL,'Work Country',NULL,NULL,'"drvWorkCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECOMPPAPERZ0','54','D','10','25',NULL,'Work Phone #',NULL,NULL,'"drvWorkPh"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECOMPPAPERZ0','54','D','10','26',NULL,'Work Phone Extension',NULL,NULL,'"drvPhExt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECOMPPAPERZ0','54','D','10','27',NULL,'Business Unit',NULL,NULL,'"drvBusUnit"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECOMPPAPERZ0','54','D','10','28',NULL,'Organization',NULL,NULL,'"drvOrg"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECOMPPAPERZ0','54','D','10','29',NULL,'Employee Group #1',NULL,NULL,'"drvEmpGrp1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECOMPPAPERZ0','54','D','10','30',NULL,'Employee Group #2',NULL,NULL,'"drvEmpGrp2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECOMPPAPERZ0','54','D','10','31',NULL,'Employee Group #3',NULL,NULL,'"drvEmpGrp3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECOMPPAPERZ0','54','D','10','32',NULL,'Employee Group #4',NULL,NULL,'"drvEmpGrp4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECOMPPAPERZ0','54','D','10','33',NULL,'Employee Group #5',NULL,NULL,'"drvEmpGrp5"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECOMPPAPERZ0','54','D','10','34',NULL,'Employee Group #6',NULL,NULL,'"drvEmpGrp6"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECOMPPAPERZ0','54','D','10','35',NULL,'Employee Group #7',NULL,NULL,'"drvEmpGrp7"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECOMPPAPERZ0','54','D','10','36',NULL,'Employee Group #8',NULL,NULL,'"drvEmpGrp8"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECOMPPAPERZ0','54','D','10','37',NULL,'Full Time / Part Time Status',NULL,NULL,'"drvFTPTStat"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECOMPPAPERZ0','54','D','10','38',NULL,'Hire Date',NULL,NULL,'"drvHireDt"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECOMPPAPERZ0','54','D','10','39',NULL,'Adjusted Employment Date',NULL,NULL,'"drvAdjEmplDt"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECOMPPAPERZ0','54','D','10','40',NULL,'Anniversary Date',NULL,NULL,'"drvAnnDt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECOMPPAPERZ0','54','D','10','41',NULL,'Termination Date',NULL,NULL,'"drvTermDt"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECOMPPAPERZ0','54','D','10','42',NULL,'Hours Worked in the Previous 12 Months',NULL,NULL,'"drvHrsWorkedPast12Months"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECOMPPAPERZ0','54','D','10','43',NULL,'Key Employee',NULL,NULL,'"drvKeyEmp"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECOMPPAPERZ0','54','D','10','44',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECOMPPAPERZ0','54','D','10','45',NULL,'Work E-mail Address',NULL,NULL,'"drvWorkEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECOMPPAPERZ0','54','D','10','46',NULL,'Scheduled Hours per Week',NULL,NULL,'"drvSchHrsPerWeek"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECOMPPAPERZ0','54','D','10','47',NULL,'Scheduled # of Days per Week',NULL,NULL,'"drvSchNumDaysPerWeek"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECOMPPAPERZ0','54','D','10','48',NULL,'Additional Letter Recipient E-mail',NULL,NULL,'"drvAddLetterRecEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECOMPPAPERZ0','54','D','10','49',NULL,'Spouse Employed',NULL,NULL,'"drvSpouseEmployed"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECOMPPAPERZ0','54','D','10','50',NULL,'Spouse Employee ID',NULL,NULL,'"drvSpouseEmpId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECOMPPAPERZ0','54','D','10','51',NULL,'Primary Contact ID #',NULL,NULL,'"drvPrimaryContactId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECOMPPAPERZ0','54','D','10','52',NULL,'STD Earnings',NULL,NULL,'"drvSTDEarnings"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECOMPPAPERZ0','54','D','10','53',NULL,'STD Eligibility Date',NULL,NULL,'"drvSTDEligibilityDt"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECOMPPAPERZ0','54','D','10','54',NULL,'LTD Eligibility Date',NULL,NULL,'"drvLTDEligibilityDt"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECOMPPAPERZ0','54','D','10','55',NULL,'Employer Contact 2 IDS',NULL,NULL,'"drvEmployerCont2Ids"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECOMPPAPERZ0','54','D','10','56',NULL,'Employer Contact 3 IDS',NULL,NULL,'"drvEmployerCont3Ids"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ECOMPPAPERZ0','54','D','10','57',NULL,'Employer Contact 4 IDS',NULL,NULL,'"drvEmployerCont4Ids"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ECOMPPAPERZ0','54','D','10','58',NULL,'Employer Contact 5 IDS',NULL,NULL,'"drvEmployerCont5Ids"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ECOMPPAPERZ0','54','D','10','59',NULL,'Employer Contact 6 IDS',NULL,NULL,'"drvEmployerCont6Ids"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ECOMPPAPERZ0','54','D','10','60',NULL,'Employer Contact 7 IDS',NULL,NULL,'"drvEmployerCont7Ids"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ECOMPPAPERZ0','54','D','10','61',NULL,'Employer Contact 8 IDS',NULL,NULL,'"drvEmployerCont8Ids"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ECOMPPAPERZ0','54','D','10','62',NULL,'Employer Contact 9 IDS',NULL,NULL,'"drvEmployerCont9Ids"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ECOMPPAPERZ0','54','D','10','63',NULL,'Employer Contact 10 IDS',NULL,NULL,'"drvEmployerCont10Ids"','(''UA''=''T|)');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECOMPPAPER_20211109.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Compsych Eligibility Export','202110129','EMPEXPORT','ONDEM_XOE',NULL,'ECOMPPAPER',NULL,NULL,NULL,'202110129','Oct 12 2021 11:15PM','Oct 12 2021 11:15PM','202110121',NULL,'','','202110121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Compsych Eligibility Exp-Sched','202110129','EMPEXPORT','SCH_ECOMPP',NULL,'ECOMPPAPER',NULL,NULL,NULL,'202110129','Oct 12 2021 11:15PM','Oct 12 2021 11:15PM','202110121',NULL,'','','202110121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Compsych Eligibility Exp-Test','202111099','EMPEXPORT','TEST_XOE','Nov  9 2021  5:39PM','ECOMPPAPER',NULL,NULL,NULL,'202111099','Nov  9 2021 12:00AM','Dec 30 1899 12:00AM','202110121','1224','','','202110121',dbo.fn_GetTimedKey(),NULL,'us3rVaPAP1002',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOMPPAPER','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOMPPAPER','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOMPPAPER','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOMPPAPER','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOMPPAPER','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOMPPAPER','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOMPPAPER','D10','dbo.U_ECOMPPAPER_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECOMPPAPER
-----------

IF OBJECT_ID('U_dsi_BDM_ECOMPPAPER') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECOMPPAPER] (
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
-- Create table U_ECOMPPAPER_DedList
-----------

IF OBJECT_ID('U_ECOMPPAPER_DedList') IS NULL
CREATE TABLE [dbo].[U_ECOMPPAPER_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECOMPPAPER_drvTbl
-----------

IF OBJECT_ID('U_ECOMPPAPER_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECOMPPAPER_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvAccNum] varchar(6) NOT NULL,
    [drvAccName] varchar(15) NOT NULL,
    [drvEmpId] char(9) NULL,
    [drvEmpSSN] varchar(11) NULL,
    [drvFName] varchar(100) NULL,
    [drvMI] varchar(1) NULL,
    [drvLName] varchar(100) NULL,
    [drvHomeAdd1] varchar(255) NULL,
    [drvHomeAdd2] varchar(255) NULL,
    [drvHomeCity] varchar(255) NULL,
    [drvHomeState] varchar(255) NULL,
    [drvHomeZip] varchar(50) NULL,
    [drvHomeCountry] char(3) NULL,
    [drvHomePh] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDOB] datetime NULL,
    [drvPrimaryLang] varchar(1) NOT NULL,
    [drvWorkAddId] varchar(1) NOT NULL,
    [drvWorkAddLine1] varchar(1) NOT NULL,
    [drvWorkAddLine2] varchar(1) NOT NULL,
    [drvWorkCity] varchar(1) NOT NULL,
    [drvWorkState] varchar(255) NULL,
    [drvWorkZip] varchar(1) NOT NULL,
    [drvWorkCountry] varchar(1) NOT NULL,
    [drvWorkPh] varchar(1) NOT NULL,
    [drvPhExt] varchar(1) NOT NULL,
    [drvBusUnit] varchar(25) NULL,
    [drvOrg] varchar(25) NULL,
    [drvEmpGrp1] varchar(25) NULL,
    [drvEmpGrp2] varchar(201) NULL,
    [drvEmpGrp3] varchar(40) NULL,
    [drvEmpGrp4] varchar(255) NULL,
    [drvEmpGrp5] char(1) NULL,
    [drvEmpGrp6] varchar(45) NULL,
    [drvEmpGrp7] char(25) NULL,
    [drvEmpGrp8] varchar(1) NOT NULL,
    [drvFTPTStat] char(1) NULL,
    [drvHireDt] datetime NULL,
    [drvAdjEmplDt] datetime NULL,
    [drvAnnDt] varchar(1) NOT NULL,
    [drvTermDt] varchar(30) NOT NULL,
    [drvHrsWorkedPast12Months] varchar(30) NULL,
    [drvKeyEmp] varchar(1) NOT NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvSchHrsPerWeek] varchar(2) NOT NULL,
    [drvSchNumDaysPerWeek] varchar(1) NOT NULL,
    [drvAddLetterRecEmail] varchar(1) NOT NULL,
    [drvSpouseEmployed] varchar(1) NOT NULL,
    [drvSpouseEmpId] varchar(1) NOT NULL,
    [drvPrimaryContactId] char(9) NULL,
    [drvSTDEarnings] varchar(1) NOT NULL,
    [drvSTDEligibilityDt] datetime NULL,
    [drvLTDEligibilityDt] datetime NULL,
    [drvEmployerCont2Ids] varchar(1) NOT NULL,
    [drvEmployerCont3Ids] varchar(1) NOT NULL,
    [drvEmployerCont4Ids] varchar(1) NOT NULL,
    [drvEmployerCont5Ids] varchar(1) NOT NULL,
    [drvEmployerCont6Ids] varchar(1) NOT NULL,
    [drvEmployerCont7Ids] varchar(1) NOT NULL,
    [drvEmployerCont8Ids] varchar(1) NOT NULL,
    [drvEmployerCont9Ids] varchar(1) NOT NULL,
    [drvEmployerCont10Ids] varchar(1) NOT NULL
);

-----------
-- Create table U_ECOMPPAPER_EEList
-----------

IF OBJECT_ID('U_ECOMPPAPER_EEList') IS NULL
CREATE TABLE [dbo].[U_ECOMPPAPER_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECOMPPAPER_File
-----------

IF OBJECT_ID('U_ECOMPPAPER_File') IS NULL
CREATE TABLE [dbo].[U_ECOMPPAPER_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_ECOMPPAPER_PDedHist
-----------

IF OBJECT_ID('U_ECOMPPAPER_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECOMPPAPER_PDedHist] (
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
-- Create table U_ECOMPPAPER_PEarHist
-----------

IF OBJECT_ID('U_ECOMPPAPER_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECOMPPAPER_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOMPPAPER]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Paper Transport

Created By: Andy Pineda
Business Analyst: Richard Vars
Create Date: 10/12/2021
Service Request Number: TekP-2021-08-25-0003

Purpose: Compsych Eligibility Export

Revision History
----------------
11/04/2021 by AP:

    - Updated logic for group 6.
    - Updated logic for group 7.
    - Added supervisor id to primary contact.
    - Added 30 days term drop.
    - Updated LTD and STD elig dates.

11/09/2021 by AP:
    - Cleaned up duplicate issue due to the Codes table.
    - Adjusted Hours Worked in the Previous 12 Months logic to not exceed 8760.
    - Updated primary contact to be EC2.EecEmpNo rather than Ec.EecSuperVisorID.
    - Fixed issue with "dupes" showing up in result set due to termination company linking to employee supervisor causing 2 entries 
      1 for each supervisor.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECOMPPAPER';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECOMPPAPER';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECOMPPAPER';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECOMPPAPER';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECOMPPAPER' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOMPPAPER', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOMPPAPER', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOMPPAPER', 'SCH_ECOMPP';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECOMPPAPER';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECOMPPAPER', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@12MonthRolling    varchar(10)

    -- Set FormatCode
    SELECT @FormatCode = 'ECOMPPAPER';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    SELECT @12MonthRolling = REPLACE(CONVERT(CHAR(10), DATEADD(YEAR, -1, @EndDate), 101), '/', '') + substring(@EndPerControl, 9, 1)

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECOMPPAPER_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECOMPPAPER_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    ----==========================================
    ---- Create Deduction List
    ----==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_ECOMPPAPER_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_ECOMPPAPER_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_ECOMPPAPER_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;


    ----==========================================
    ---- BDM Section
    ----==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    ---- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    ---- Non-Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    ---- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    --IF OBJECT_ID('U_ECOMPPAPER_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_ECOMPPAPER_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_ECOMPPAPER_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_ECOMPPAPER_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECOMPPAPER_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECOMPPAPER_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
      --  ,PehEarnCode
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @12MonthRolling THEN PehCurHrs ELSE 0.00 END)
        --,@12MonthRolling as tmr
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ECOMPPAPER_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID--, PehEarnCode
    HAVING SUM(PehCurAmt) <> 0.00;


    ---- CLEAN UP CODES TABLE RESULTS ----

    IF OBJECT_ID('U_dsi_CodesTable','U') IS NOT NULL
    DROP TABLE dbo.U_dsi_CodesTable;

    SELECT EjhEEID AS CodEEID, EjhCOID AS CodCOID, CodDesc, EjhJobEffDate AS CodJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID ORDER BY EjhEEID, EjhJobEffDate DESC) AS RN
    INTO dbo.U_dsi_CodesTable
    FROM dbo.EmpHJob WITH(NOLOCK) JOIN dbo.Codes WITH(NOLOCK)
    ON EjhProject = CodCode
    WHERE CodTable = 'PROJECT'
  --  GROUP BY EjhEEID, EjhCOID, CodDesc

    IF OBJECT_ID('U_dsi_CodesTable_Final','U') IS NOT NULL
    DROP TABLE dbo.U_dsi_CodesTable_Final;

    SELECT DISTINCT CodEEID, CodCOID, CodDesc, CodJobEffDate
    INTO dbo.U_dsi_CodesTable_Final
    FROM dbo.U_dsi_CodesTable WITH(NOLOCK)
    WHERE RN = '1'

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECOMPPAPER_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECOMPPAPER_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECOMPPAPER_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvAccNum = '159472'
        ,drvAccName = 'Paper Transport'
        ,drvEmpId = Ec.EecEmpNo
        ,drvEmpSSN = SUBSTRING(pers.EepSSN, 1, 3)+'-'+
                    SUBSTRING(pers.EepSSN, 4, 2)+'-'+
                    SUBSTRING(pers.EepSSN, 6, 4) 
        ,drvFName = pers.EepNameFirst
        ,drvMI = LEFT(pers.EepNameMiddle, 1)
        ,drvLName = pers.EepNameLast
        ,drvHomeAdd1 = pers.EepAddressline1
        ,drvHomeAdd2 = pers.EepAddressline2
        ,drvHomeCity = pers.EepAddressCity
        ,drvHomeState = pers.EepAddressState
        ,drvHomeZip = pers.EepAddressZipCode
        ,drvHomeCountry = pers.EepAddressCountry
        ,drvHomePh = pers.EepPhoneHomeNumber
        ,drvGender = pers.EepGender
        ,drvDOB = pers.EepDateOfBirth
        ,drvPrimaryLang = ''
        ,drvWorkAddId = ''
        ,drvWorkAddLine1 = ''
        ,drvWorkAddLine2 = ''
        ,drvWorkCity = ''
        ,drvWorkState = LocAddressState
        ,drvWorkZip = ''
        ,drvWorkCountry = ''
        ,drvWorkPh = ''
        ,drvPhExt = ''
        ,drvBusUnit = O2.OrgDesc
        ,drvOrg = O1.OrgDesc
        ,drvEmpGrp1 = O3.OrgDesc
        ,drvEmpGrp2 = pers2.EepNameLast + ' ' + pers2.EepNameFirst
        ,drvEmpGrp3 = CmpCompanyName
        ,drvEmpGrp4 = LocAddressState
        ,drvEmpGrp5 = EjhFLSACategory
        ,drvEmpGrp6 = CodDesc
        ,drvEmpGrp7 = CegEarnGroupDesc
        ,drvEmpGrp8 = ''
        ,drvFTPTStat = Ec.EecFullTimeOrPartTime
        ,drvHireDt = Ec.EecDateOfOriginalHire
        ,drvAdjEmplDt = Ec.EecDateOfLastHire
        ,drvAnnDt = ''
        ,drvTermDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN Ec.EecEmplStatus = 'T' THEN Ec.EecDateOfTermination END), 101), '')
        ,drvHrsWorkedPast12Months = CASE WHEN PehCurHrs > '8760' THEN '8760.00' ELSE CAST(CAST(PehCurHrs AS DECIMAL(10,2)) AS VARCHAR) END
        ,drvKeyEmp = ''
        ,drvJobTitle = JbcDesc
        ,drvWorkEmail = pers.EepAddressEMail
        ,drvSchHrsPerWeek = CASE WHEN Ec.EecFullTimeOrPartTime = 'P' THEN '24' ELSE '40' END
        ,drvSchNumDaysPerWeek = CASE WHEN Ec.EecFullTimeOrPartTime = 'P' THEN '3' ELSE '5' END
        ,drvAddLetterRecEmail = ''
        ,drvSpouseEmployed = ''
        ,drvSpouseEmpId = ''
        ,drvPrimaryContactId = EC2.EecEmpNo
        --Ec.EecSupervisorID
        ,drvSTDEarnings = ''
        ,drvSTDEligibilityDt = std.EedEEEligDate
        ,drvLTDEligibilityDt = ltd.EedEEEligDate
        ,drvEmployerCont2Ids = ''
        ,drvEmployerCont3Ids = ''
        ,drvEmployerCont4Ids = ''
        ,drvEmployerCont5Ids = ''
        ,drvEmployerCont6Ids = ''
        ,drvEmployerCont7Ids = ''
        ,drvEmployerCont8Ids = ''
        ,drvEmployerCont9Ids = ''
        ,drvEmployerCont10Ids = ''
    INTO dbo.U_ECOMPPAPER_drvTbl
    FROM dbo.U_ECOMPPAPER_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp Ec WITH(NOLOCK)
    ON Ec.EecEEID = xEEID
    AND Ec.EecCOID = xCOID
    JOIN dbo.EmpPers pers WITH (NOLOCK)
        ON pers.EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = Ec.EecJobCode
    JOIN dbo.Location WITH(NOLOCK)
        ON LocCode = Ec.EecLocation
    JOIN dbo.Company WITH(NOLOCK)
        ON CmpCOID = xCOID
    JOIN dbo.U_ECOMPPAPER_PEarHist
        ON xEEID = PehEEID
        AND xCOID = PehCOID
    LEFT JOIN dbo.EarnGrp WITH(NOLOCK)
        ON Ec.EecEarnGroupCode = CegEarnGroupCode
      LEFT JOIN (SELECT EedEEID, EedCOID, MAX(EedEEEligDate) AS EedEEEligDate
                    FROM dbo.EmpDedFull WITH(NOLOCK)
                    WHERE EedDedCode IN ('STD', 'STDD')
                    GROUP BY EedEEID, EedCOID) std ON std.EedEEID = xEEID AND std.EedCoID = xCOID
    --LEFT JOIN (SELECT EedEEID, EedCOID, MAX(EedEEEligDate) AS EedEEEligDate 
    --            FROM dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
    --            WHERE EedFormatCode = 'ECOMPPAPER'
    --            AND EedValidForExport = 'Y'
    --            AND EedDedCode IN ('STD', 'STDD')
    --            GROUP BY EedEEID, EedCOID) std ON std.EedEEID = xEEID AND std.EedCOID = xCOID
    LEFT JOIN (SELECT EedEEID, EedCOID, MAX(EedEEEligDate) AS EedEEEligDate
                    FROM dbo.EmpDedFull WITH(NOLOCK)
                    WHERE EedDedCode IN ('LTD', 'LTDD')
                    GROUP BY EedEEID, EedCOID) ltd ON ltd.EedEEID = xEEID AND ltd.EedCoID = xCOID
    --(SELECT EedEEID, EedCOID, MAX(EedEEEligDate) AS EedEEEligDate 
 --               FROM dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
 --               WHERE EedFormatCode = 'ECOMPPAPER'
 --               AND EedValidForExport = 'Y'
 --               AND EedDedCode IN ('LTD', 'LTDD')
 --               GROUP BY EedEEID, EedCOID) ltd ON ltd.EedEEID = xEEID AND ltd.EedCOID = xCOID
    OUTER APPLY (SELECT TOP 1 * FROM dbo.EmpHJob WITH(NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID ORDER BY EjhJobEffDate DESC) E
    LEFT JOIN dbo.OrgLevel O1 WITH(NOLOCK)
        ON O1.OrgCode = Ec.EecOrgLvl1
    LEFT JOIN dbo.OrgLevel O2 WITH(NOLOCK)
        ON O2.OrgCode = Ec.EecOrgLvl2
    LEFT JOIN dbo.OrgLevel O3 WITH(NOLOCK)
        ON O3.OrgCode = Ec.EecOrgLvl3
    LEFT JOIN dbo.EmpComp EC2 WITH (NOLOCK) -- supervisor  
    ON EC2.EecEEID = Ec.EecSupervisorID  
     AND EC2.EecCOID = xCOID
  --  AND Ec2.EecCOID = Ec.EecCOID  
        --AND SUP.EecEmplStatus <> 'T' 
    LEFT JOIN dbo.EmpPers pers2 WITH(NOLOCK)
    ON Ec2.EecEEID = pers2.EepEEID
    LEFT JOIN dbo.U_dsi_CodesTable_Final WITH(NOLOCK)
    ON EjhEEID = CodEEID
    AND EjhCOID = CodCOID
  --  AND CodTable = 'MOTALB'
    --JOIN dbo.U_dsi_BDM_ECOMPPAPER WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    WHERE Ec.EecDateOfTermination IS NULL OR CAST(Ec.EecDateOfTermination AS DATE) >= DATEADD(day, -30, CAST(GETDATE() AS DATE))
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
ALTER VIEW dbo.dsi_vwECOMPPAPER_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECOMPPAPER_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECOMPPAPER%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202110051'
       ,expStartPerControl     = '202110051'
       ,expLastEndPerControl   = '202110129'
       ,expEndPerControl       = '202110129'
WHERE expFormatCode = 'ECOMPPAPER';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECOMPPAPER_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECOMPPAPER_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECOMPPAPER' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECOMPPAPER'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECOMPPAPER'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECOMPPAPER', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECOMPPAPER', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECOMPPAPER', 'UseFileName', 'V', 'Y'


-- End ripout